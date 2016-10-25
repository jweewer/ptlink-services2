/* Channel-handling routines.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2004
 * http://software.pt-link.net
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services 
 * $Id: channels.c,v 1.8 2004/11/21 12:10:21 jpinto Exp $ 
 */

#include "services.h"
#include "ircdsetup.h"
#include "hash.h"

#define HASH(chan)	((chan)[1] ? ((chan)[1]&31)<<5 | ((chan)[2]&31) : 0)
static Channel *chanlist[1024];

/*************************************************************************/

/* Return statistics.  Pointers are assumed to be valid. */

void get_channel_stats(long *nrec, long *memuse)
{
    long count = 0, mem = 0;
    Channel *chan;
    struct c_userlist *cu;
    int j;
    
    for (chan = hash_next_channel(1); chan; chan=hash_next_channel(0)) 
    {
	    count++;
	    mem += sizeof(*chan);
	    if (chan->topic)
		mem += strlen(chan->topic)+1;
	    if (chan->key)
		mem += strlen(chan->key)+1;
	    mem += sizeof(char *) * chan->bansize;
	    for (j = 0; j < chan->bancount; j++) {
		if (chan->bans[j])
		    mem += strlen(chan->bans[j])+1;
	    }
	    for (cu = chan->users; cu; cu = cu->next)
		mem += sizeof(*cu);
	    for (cu = chan->chanops; cu; cu = cu->next)
		mem += sizeof(*cu);
#ifdef HALFOPS
	    for (cu = chan->halfops; cu; cu = cu->next)
		mem += sizeof(*cu);
#endif
	    for (cu = chan->voices; cu; cu = cu->next)
		mem += sizeof(*cu);
    }
    *nrec = count;
    *memuse = mem;
}

/*************************************************************************/

/* Return the Channel structure corresponding to the named channel, or NULL
 * if the channel was not found.  chan is assumed to be non-NULL and valid
 * (i.e. pointing to a channel name of 2 or more characters). */

Channel *findchan(const char *chan)
{
   return hash_find_channel(chan);
}

/*************************************************************************/

/* Iterate over all channels in the channel list.  Return NULL at end of
 * list.
 */

static Channel *current;
static int next_index;

Channel *firstchan(void)
{
    next_index = 0;
    while (next_index < 1024 && current == NULL)
	current = chanlist[next_index++];
    if (debug >= 3)
	log1("debug: firstchan() returning %s",
			current ? current->name : "NULL (end of list)");
    return current;
}

/*************************************************************************/
/*************************************************************************/

/* Add/remove a user to/from a channel, creating or deleting the channel as
 * necessary.  If creating the channel, restore mode lock and topic as
 * necessary.  Also check for auto-opping and auto-voicing. */

Channel* chan_adduser(User *user, const char *chan, int wasmodes )
{
    Channel *c = findchan(chan);
    int wasoped = 0; /* flag to indicate user doesnt need voice */
    int newchan = !c;
    struct c_userlist *u;

    if (newchan) {
	if (debug)
	    log1("debug: Creating channel %s", chan);
	/* Allocate pre-cleared memory */
	c = scalloc(sizeof(Channel), 1);
	c->n_users = 0;
	strscpy(c->name, chan, sizeof(c->name));
/*	old hash code	
	list = &chanlist[HASH(c->name)];
	c->next = *list;
	if (*list)
	    (*list)->prev = c;
	*list = c;
*/	
        add_to_channel_hash_table(c->name, c); /* new hash code */
	c->creation_time = time(NULL);
	/* Store ChannelInfo pointer in channel record */
	c->ci = cs_findchan(chan);
	/* Store return pointer in ChannelInfo record */
	if (c->ci)
	{
	    c->ci->c = c;
	    c->maxusers = c->ci->maxusers;
	    c->maxtime = c->ci->maxtime;
	    buffer_mode("+r","");
	} else
	{
	    c->maxusers = 1;
	    c->maxtime = time(NULL);
	}
	/* Restore locked modes and saved topic */
	  check_modes(chan, 1);
	  restore_topic(chan);
    }
    if (c->maxusers<++(c->n_users)) 
    { /* new channel user record*/
	c->maxusers = c->n_users;
	c->maxtime  = time(NULL);
	if(c->ci) { /* update chanserv register */
	    c->ci->maxusers = c->maxusers;
	    c->ci->maxtime = c->maxtime;
	}
    }
    if (check_should_op(user, chan, wasmodes & IS_OP)) {
	u = smalloc(sizeof(struct c_userlist));
	u->next = c->chanops;
	u->prev = NULL;
	if (c->chanops)
	    c->chanops->prev = u;
	c->chanops = u;
	u->user = user;
	wasoped = 1;
    } 
    if(!wasoped)
    {
#ifdef HALFOPS
	if (check_should_halfop(user, chan, wasmodes & IS_HALFOP)) {
	    u = smalloc(sizeof(struct c_userlist));
	    u->next = c->halfops;
	    u->prev = NULL;
	    if (c->halfops)
		c->halfops->prev = u;
	    c->halfops = u;
	    u->user = user;
	}
	else if (check_should_voice(user, chan, wasmodes & IS_VOICE)) {
#else
        if (check_should_voice(user, chan, wasmodes & IS_VOICE)) {
#endif
	   u = smalloc(sizeof(struct c_userlist));
	   u->next = c->voices;
	   u->prev = NULL;
	   if (c->voices)
	       c->voices->prev = u;
	   c->voices = u;
 	   u->user = user;
 	}
    }
    check_should_protect(user, chan, wasmodes & IS_ADMIN) ;
    u = smalloc(sizeof(struct c_userlist));
    u->next = c->users;
    u->prev = NULL;
    if (c->users)
	c->users->prev = u;
    c->users = u;
    u->user = user;
    return c;
}


void chan_deluser(User *user, Channel *c)
{
    struct c_userlist *u;
    int i;
    for (u = c->users; u && u->user != user; u = u->next)
	;
    if (!u)
	return;
    (c->n_users)--;
    if (u->next)
	u->next->prev = u->prev;
    if (u->prev)
	u->prev->next = u->next;
    else
	c->users = u->next;
    free(u);
    for (u = c->chanops; u && u->user != user; u = u->next)
	;
    if (u) {
	if (u->next)
	    u->next->prev = u->prev;
	if (u->prev)
	    u->prev->next = u->next;
	else
	    c->chanops = u->next;
	free(u);
    }
#ifdef HALFOPS
    for (u = c->halfops; u && u->user != user; u = u->next)
	;
    if(u) {
	if (u->next)
	    u->next->prev = u->prev;
	if (u->prev)
	    u->prev->next = u->next;
	else
	    c->halfops = u->next;
	free(u);
    }
#endif
    for (u = c->voices; u && u->user != user; u = u->next)
	;
    if (u) {
	if (u->next)
	    u->next->prev = u->prev;
	if (u->prev)
	    u->prev->next = u->next;
	else
	    c->voices = u->next;
	free(u);
    }
    if (!c->users) {
	if (debug)
	    log1("debug: Deleting channel %s", c->name);
	if (c->ci)
	    c->ci->c = NULL;
	if (c->topic)
	    free(c->topic);
	if (c->key)
	    free(c->key);
	for (i = 0; i < c->bancount; ++i) {
	    if (c->bans[i])
		free(c->bans[i]);
	    else
		log1("channel: BUG freeing %s: bans[%d] is NULL!", c->name, i);
	}
	if (c->bansize)
	    free(c->bans);
	if (c->chanops || c->voices)
	    log1("channel: Memory leak freeing %s: %s%s%s %s non-NULL!",
			c->name,
			c->chanops ? "c->chanops" : "",
			c->chanops && c->voices ? " and " : "",
			c->voices ? "c->voices" : "",
			c->chanops && c->voices ? "are" : "is");
#ifdef HALFOPS
	if(c->halfops)
	    log1("channel: Memory leak freeing %s: %s is non-NULL!",
		c->name, c->halfops ? "c->halfops" : "");
#endif

/* old hash code			
	if (c->next)
	    c->next->prev = c->prev;
	if (c->prev)
	    c->prev->next = c->next;
	else
	    chanlist[HASH(c->name)] = c->next;
*/
	del_from_channel_hash_table(c->name, c); /* new hash code */
	free(c);
    }
}

/*************************************************************************
 * puts a mode for a channel on buffer, will flush modes out if buffer is 
 * full
 * if mode==NULL flush buffer and initialize modes for chan = target
 */
#define MODESMAX 4 /* Please check your ircd documentation */
void buffer_mode(const char* mode,char* target) {
    static int modesonbuffer = 0;
    static char moremodes[MODESMAX+1];
    static char lessmodes[MODESMAX+1];
    static char *targets[MODESMAX];
    static char channame[CHANMAX];
    char modebuf[512]; /* buffer for mode line */
    if(mode) { /* buffering mode */
	if(mode[0]=='+') strcat(moremodes,&mode[1]);
	    else strcat(lessmodes,&mode[1]);
	targets[modesonbuffer++] = target;
    } else if(target) 
	{
	    strcpy(channame,target); // no modes to send out
	    moremodes[0]='\0';
	    lessmodes[0]='\0';
	    modesonbuffer = 0;
	    return;
	}	    
    if(!modesonbuffer) return; /* no*/
    if(!mode || (modesonbuffer == MODESMAX)) { // modes will be sent out
	int i=0,i2=0;
	if(moremodes[0]) {
	    modebuf[i++]='+';
	    while((modebuf[i++]=moremodes[i2++]));
	    --i;
	}
	if(lessmodes[0]) {
	    modebuf[i++]='-';i2=0;
	    while((modebuf[i++]=lessmodes[i2++]));
	    --i;
	}
	modebuf[i]=' ';modebuf[i+1]='\0';
	for(i=0;i<modesonbuffer;++i) {
	    strcat(modebuf," ");
	    strcat(modebuf,targets[i]);
	}
	send_cmd(s_ChanServ,"MODE %s %s",channame,modebuf);
	moremodes[0]='\0';
	lessmodes[0]='\0';
	modesonbuffer = 0;
    }    
}

/*************************************************************************/

/* Handle a channel MODE command. */

void do_cmode(const char *source, int ac, char **av)
{
    Channel *chan;
    struct c_userlist *u;
    User *user;
    char *s, *nick;
    int add = 1;		/* 1 if adding modes, 0 if deleting */
    char *modestr = av[1];

    chan = findchan(av[0]);
    if (!chan) {
      if(strcmp(source,s_ChanServ))
	  log2c("channel: MODE %s for nonexistent channel %s",
					merge_args(ac-1, av+1), av[0]);
	  return;
    }

    /* This shouldn't trigger on +o, etc. */
    if (strchr(source, '.') && !modestr[strcspn(modestr, "bova")]) {
	if (time(NULL) != chan->server_modetime) {
	    chan->server_modecount = 0;
	    chan->server_modetime = time(NULL);
	}
	chan->server_modecount++;
    }

    s = modestr;
    ac -= 2;
    av += 2;

    while (*s) {

	switch (*s++) {

	case '+':
	    add = 1; break;

	case '-':
	    add = 0; break;

	case 'i':
	    if (add)
		chan->mode |= CMODE_I;
	    else
		chan->mode &= ~CMODE_I;
	    break;

	case 'm':
	    if (add)
		chan->mode |= CMODE_M;
	    else
		chan->mode &= ~CMODE_M;
	    break;
	case 'S':
	    if (add)
		chan->mode |= CMODE_S;
	    else
		chan->mode &= ~CMODE_S;
	    break;
	case 'd':
	    if (add)
		chan->mode |= CMODE_d;
	    else
		chan->mode &= ~CMODE_d;
	    break;
	case 'q':
	    if (add)
		chan->mode |= CMODE_q;
	    else
		chan->mode &= ~CMODE_q;
	    break;
	    
	case 'n':
	    if (add)
		chan->mode |= CMODE_n;
	    else
		chan->mode &= ~CMODE_n;
	    break;
	
	case 'R':
	    if (add)
		chan->mode |= CMODE_R;
	    else
		chan->mode &= ~CMODE_R;
	    break;
/*	    
	case 'r':
	    if (add)
		chan->mode |= CMODE_r;
	    else
		chan->mode &= ~CMODE_r;
	    break;
*/
	case 'p':
	    if (add)
		chan->mode |= CMODE_P;
	    else
		chan->mode &= ~CMODE_P;
	    break;

	case 's':
	    if (add)
		chan->mode |= CMODE_s;
	    else
		chan->mode &= ~CMODE_s;
	    break;
	case 'c':
	    if (add)
		chan->mode |= CMODE_c;
	    else
		chan->mode &= ~CMODE_c;
	    break;
	case 'B':
	    if(add)
		chan->mode |= CMODE_B;
	    else
		chan->mode &= ~CMODE_B;
	    break;
	case 'K':
	    if (add)
		chan->mode |= CMODE_K;
	    else
		chan->mode &= ~CMODE_K;
	    break;	    
	case 't':
	    if (add)
		chan->mode |= CMODE_T;
	    else
		chan->mode &= ~CMODE_T;
	    break;
	case 'N':
	    if(add)
		chan->mode |= CMODE_N;
	    else
		chan->mode &= ~CMODE_N;
	    break;
	case 'C':
	    if(add)
		chan->mode |= CMODE_C;
	    else
		chan->mode &= ~CMODE_C;
	    break;
	    
	case 'k':
	    if (add && --ac < 0) {
		log2c("channel: MODE %s %s: missing parameter for %ck",
					chan->name, modestr, add ? '+' : '-');
		break;
	    }
	    if (chan->key) {
		  free(chan->key);
		  chan->key = NULL;
	    }
	    if (add)
		  chan->key = sstrdup(*av++);
	    break;

	case 'l':
	    if (add) {
		if (--ac < 0) {
		    log2c("channel: MODE %s %s: missing parameter for +l",
							chan->name, modestr);
		    break;
		}
		chan->limit = atoi(*av++);
	    } else {
		chan->limit = 0;
	    }
	    break;

	case 'b':
	    if (--ac < 0) {
		log2c("channel: MODE %s %s: missing parameter for %cb",
					chan->name, modestr, add ? '+' : '-');
		break;
	    }
	    if (add) {
		if (chan->bancount >= chan->bansize) {
		    chan->bansize += 8;
		    chan->bans = srealloc(chan->bans,
					sizeof(char *) * chan->bansize);
		}
		chan->bans[chan->bancount++] = sstrdup(*av++);
	    } else {
		char **s = chan->bans;
		int i = 0;
		while (i < chan->bancount && strcmp(*s, *av) != 0) {
		    i++;
		    s++;
		}		
		if (i < chan->bancount) {
		    free(chan->bans[i]);
		    chan->bancount--;
		    if (i < chan->bancount)
			memmove(s, s+1, sizeof(char *) * (chan->bancount-i));
		}
		av++;
	    }
	    break;

	case 'o':
	    if (--ac < 0) {
		log2c("channel: MODE %s %s: missing parameter for %co",
					chan->name, modestr, add ? '+' : '-');
		break;
	    }
	    nick = *av++;
	    if (add) {
		for (u = chan->chanops; u && stricmp(u->user->nick, nick) != 0;
								u = u->next)
		    ;
		if (u)
		    break;
		user = finduser(nick);
		if (!user) {
		    log2c("channel: MODE %s +o for nonexistent user %s",
							chan->name, nick);
		    break;
		}
		if (debug)
		    log2c("debug: Setting +o on %s for %s", chan->name, nick);
		if (!check_valid_op(user, chan->name, !!strchr(source, '.')))
		    break;
		u = smalloc(sizeof(*u));
		u->next = chan->chanops;
		u->prev = NULL;
		if (chan->chanops)
		    chan->chanops->prev = u;
		chan->chanops = u;
		u->user = user;
	    } else {
		for (u = chan->chanops; u && stricmp(u->user->nick, nick);
								u = u->next)
		    ;
		if (!u)
		    break;
		if (u->next)
		    u->next->prev = u->prev;
		if (u->prev)
		    u->prev->next = u->next;
		else
		    chan->chanops = u->next;
		free(u);
	    }
	    break;
#ifdef HALFOPS
	case 'h':
	    if(--ac < 0) {
		log2c("channel: MODE %s %s: missing paramater for %ch",
		    chan->name, modestr, add ? '+' : '-');
		break;
	    }
	    nick = *av++;
	    if(add) {
		for (u = chan->halfops; u && stricmp(u->user->nick, nick) != 0;
								u = u->next)
		    ;
		if(u)
		    break;
		user = finduser(nick);
		if(!user) {
		    log2c("channel: MODE %s +h for nonexistent user %s",
							chan->name, nick);
		    break;
		}
		if (debug)
		    log2c("debug: Setting +h on %s for %s", chan->name, nick);
		u = smalloc(sizeof(*u));
		u->next = chan->halfops;
		u->prev = NULL;
		if(chan->halfops)
		    chan->halfops->prev = u;
		chan->halfops = u;
		u->user = user;
	    } else {
		for(u = chan->halfops; u && stricmp(u->user->nick, nick);
							    u = u->next)
		    ;
		if(!u)
		    break;
		if(u->next)
		    u->next->prev = u->prev;
		if(u->prev)
		    u->prev->next = u->next;
		else
		    chan->halfops = u->next;
		free(u);
	    }
	    break;
#endif    
	case 'v':
	    if (--ac < 0) {
		log2c("channel: MODE %s %s: missing parameter for %cv",
					chan->name, modestr, add ? '+' : '-');
		break;
	    }
	    nick = *av++;
	    if (add) {
		for (u = chan->voices; u && stricmp(u->user->nick, nick);
								u = u->next)
		    ;
		if (u)
		    break;
		user = finduser(nick);
		if (!user) {
		    log2c("channel: MODE %s +v for nonexistent user %s",
							chan->name, nick);
		    break;
		}
		if (debug)
		    log2c("debug: Setting +v on %s for %s", chan->name, nick);
		u = smalloc(sizeof(*u));
		u->next = chan->voices;
		u->prev = NULL;
		if (chan->voices)
		    chan->voices->prev = u;
		chan->voices = u;
		u->user = user;
	    } else {
		for (u = chan->voices; u && stricmp(u->user->nick, nick);
								u = u->next)
		    ;
		if (!u)
		    break;
		if (u->next)
		    u->next->prev = u->prev;
		if (u->prev)
		    u->prev->next = u->next;
		else
		    chan->voices = u->next;
		free(u);
	    }
	    break;

	} /* switch */

    } /* while (*s) */

    /* Check modes against ChanServ mode lock */
    check_modes(chan->name, 0);
}

/*************************************************************************/

/* Handle a SJOIN MODE command. */

void do_cmode_sjoin(Channel *chan, int ac, char **av)
{
    char *s;
    int add = 1;		/* 1 if adding modes, 0 if deleting */
    char *modestr = av[1];

    if (!chan) 
	  {
		log2c("channel: MODE %s for nonexistent channel %s",
				merge_args(ac-1, av+1), av[0]);
		return;
    }

    s = modestr;
    ac -= 2;
    av += 2;

    while (*s) {

	switch (*s++) {

	case '+':
	    add = 1; break;

	case '-':
	    add = 0; break;

	case 'i':
	    if (add)
		chan->mode |= CMODE_I;
	    else
		chan->mode &= ~CMODE_I;
	    break;

	case 'm':
	    if (add)
		chan->mode |= CMODE_M;
	    else
		chan->mode &= ~CMODE_M;
	    break;
	case 'S':
	    if (add)
		chan->mode |= CMODE_S;
	    else
		chan->mode &= ~CMODE_S;
	    break;
	case 'd':
	    if (add)
		chan->mode |= CMODE_d;
	    else
		chan->mode &= ~CMODE_d;
	    break;
	case 'q':
	    if (add)
		chan->mode |= CMODE_q;
	    else
		chan->mode &= ~CMODE_q;
	    break;
	    
	case 'n':
	    if (add)
		chan->mode |= CMODE_n;
	    else
		chan->mode &= ~CMODE_n;
	    break;
	case 'R':
	    if (add)
		chan->mode |= CMODE_R;
	    else
		chan->mode &= ~CMODE_R;
	    break;
/*	    
	case 'r':
	    if (add)
		chan->mode |= CMODE_r;
	    else
		chan->mode &= ~CMODE_r;
	    break;
*/
	case 'p':
	    if (add)
		chan->mode |= CMODE_P;
	    else
		chan->mode &= ~CMODE_P;
	    break;

	case 's':
	    if (add)
		chan->mode |= CMODE_s;
	    else
		chan->mode &= ~CMODE_s;
	    break;
	case 'c':
	    if (add)
		chan->mode |= CMODE_c;
	    else
		chan->mode &= ~CMODE_c;
	    break;
	case 'B':
	    if(add)
		chan->mode |= CMODE_B;
	    else
		chan->mode &= ~CMODE_B;
	    break;    
	case 'K':
	    if (add)
		chan->mode |= CMODE_K;
	    else
		chan->mode &= ~CMODE_K;
	    break;	    
	case 't':
	    if (add)
		chan->mode |= CMODE_T;
	    else
		chan->mode &= ~CMODE_T;
	    break;
	case 'N':
	    if(add)
		chan->mode |= CMODE_N;
	    else
		chan->mode &= ~CMODE_N;
	    break;
	case 'C':
	    if(add)
		chan->mode |= CMODE_C;
	    else
		chan->mode &= ~CMODE_C;
	    break;
	    
	case 'k':
	    if (--ac < 0) {
		log2c("channel: MODE %s %s: missing parameter for %ck",
					chan->name, modestr, add ? '+' : '-');
		break;
	    }
	    if (chan->key) {
		free(chan->key);
		chan->key = NULL;
	    }
	    if (add)
		chan->key = sstrdup(*av++);
	    break;

	case 'l':
	    if (add) {
		if (--ac < 0) {
		    log2c("channel: MODE %s %s: missing parameter for +l",
							chan->name, modestr);
		    break;
		}
		chan->limit = atoi(*av++);
	    } else {
		chan->limit = 0;
	    }
	    break;

	} /* switch */

    } /* while (*s) */

    /* Check modes against ChanServ mode lock */
    check_modes(chan->name, 1);
}


/*************************************************************************/

/* Handle a TOPIC command. */

void do_topic(const char *source, int ac, char **av)
{
    Channel *c = findchan(av[0]);

    if (!c) {
	log2c("channel: TOPIC %s for nonexistent channel %s",
						merge_args(ac-1, av+1), av[0]);
	return;
    }
    if (check_topiclock(av[0]))
	return;
    strscpy(c->topic_setter, av[1], sizeof(c->topic_setter));
    c->topic_time = atol(av[2]);
    if (c->topic) {
	free(c->topic);
	c->topic = NULL;
    }
    if (ac > 3 && *av[3])
	c->topic = sstrdup(av[3]);
    record_topic(av[0]);
}


/*************************************************************************
 * Handle a SJOIN command.
 *	av[0] = TS (channel creation TimeStamp)
 *	av[1] = channel being introduced
 *	av[2] = modes set for that channel
 *	av[3,4] = mode parameters
 *	av[3+extrapars] = list of modes/users (e.g.: ^@+Lamego )
 */
void do_sjoin(const char *source, int ac, char **av)
{
    User *user;
    char *nick, *nick_, *chan;
    struct u_chanlist *c;
    ChannelInfo *ci;    
    int modeparc;
    int uchanmode; /* to build user chan modes */
    time_t chants;
    int ignore_modes = 0; 
    Channel *ch, *lastch=NULL;
    chants = atol(av[0]);
    if(ac==2) 
	  { /* normal user join */
		av[0]=av[1];
		do_join(source, 1, av);
		return;
  	  }
    else if((ac-4) && (ac-5) && (ac-6)) /* ac==4 || ac==5 || ac=6 */
	  {
		log2c("Parse error on sjoin, expecting 4,5 or 6 got %i",ac);
		log2c("sjoin: %s", merge_args(ac,av));
		return;
  	  }
	  
    chan = av[1];
	
    if((ch=findchan(chan))) 
	  {
		if(chants>ch->TS3_stamp) 
		  {
	  		ignore_modes=1;  
		  }
		else
	  	  ch->TS3_stamp=chants;
  	  }  
        
    nick=av[ac-1]; 
    
    ci = cs_findchan(chan);
	
    buffer_mode(NULL,chan); /* init mode buffer */
    while(*nick)
  	  {
		uchanmode = 0;
#ifdef HALFOPS
		while(*nick=='@' || *nick=='+' || *nick=='.' || *nick=='%')
#else
		while(*nick=='@' || *nick=='+' || *nick=='.')
#endif
      	  {
	  		switch(*nick++)
	  		  {
				case '@': uchanmode |= IS_OP;break;
				case '+': uchanmode |= IS_VOICE;break;		
				case '.': uchanmode |= IS_ADMIN;break;
#ifdef HALFOPS
				case '%': uchanmode |= IS_HALFOP;break;
#endif
				default: 
		  		  log2c("modes: SJOIN %s invalid char mode: %s", chan, nick);
		  		break;
	  		}
		  }
	
		nick_=nick;
		while((*nick) && *nick!=' ') ++nick;
	
		if ((*nick))
		  *(nick++)='\0';
	  
  		user = finduser(nick_);
	
		if (!user) 
		  {
	  		log2c("user: SJOIN %s from nonexistent user %s", av[1],nick);
	  		/* If we have a not found user on sjoin something is very bad :( */
	  		continue; /* but lets try the other users for now -Lamego */
		  }

		if (ci && check_kick(user, chan, ci)) /* first check if user should not join*/
		  	continue;
    
                if (ci && (ci->flags & CI_TOPICENTRY))
                  {
                    if(ci->last_topic)
                      notice(s_ChanServ, user->nick, "%s: %s", ci->name, ci->last_topic);
                  }
                else
                  {                  
		    if (ci && ci->entry_message)
	  	      notice(s_ChanServ, user->nick, "%s: %s", ci->name, ci->entry_message); 
	  	  }
	  	if(ci && ci->url)
                  send_cmd(ServerName, "328 %s %s :%s", 
                    user->nick, ci->name, ci->url);
		chan_adduser(user, chan, ignore_modes ? 0 : uchanmode);
			
		c = smalloc(sizeof(*c));
		c->next = user->chans;
		c->prev = NULL;
	
		if (user->chans)
	  	  user->chans->prev = c;		
		user->chans = c;
	
		if(!lastch) 
		  {
	  		c->chan = findchan(chan);	
	  		lastch = c->chan;
	  	  }
		else
	  	  c->chan = lastch;
  	  } /* end of joining nicks loop */
	  
	if(!lastch) /* all users were kicked from channel */
	  return;
	
    buffer_mode(NULL,NULL); /* flush mode buffer */
	
    if(strlen(av[2])>1) 
	  { /* there are channel modes to set*/
	        modeparc = ac-2;
		do_cmode_sjoin(lastch, modeparc, &av[1]);
		
  	  }
	  
    if(!ch && lastch) 
	  lastch->TS3_stamp=chants;
}

/*************************************************************************/

/*************************************************************************
    Clean invalid chars from channel name (from ircd)
 *************************************************************************/
void    clean_channelname(char* cn)
{
        u_char  *ch = (u_char *)cn;
        for (; *ch; ch++)
                /* Don't allow any control chars, the space, the comma,
                 * or the "non-breaking space" in channel names.
                 * Might later be changed to a system where the list of
                 * allowed/non-allowed chars for channels was a define
                 * or some such.
                 *   --Wizzu
                 */
                if (*ch < 33 || *ch == ',' || *ch == 160)
                    {
                        *ch = '\0';
                        return;
                    }
}
