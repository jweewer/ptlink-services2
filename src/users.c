/* Routines to maintain a list of online users.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2002
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services 
 *$Id: users.c,v 1.9 2004/11/21 12:10:23 jpinto Exp $
 */

#include "services.h"
#include "pseudo.h"
#include "ircdsetup.h"
#include "hash.h"
#define HASH(nick)	(((nick)[0]&31)<<5 | ((nick)[1]&31))
static User *userlist[1024];

/*************************************************************************/
/*************************************************************************/

/* Allocate a new User structure, fill in basic values, link it to the
 * overall list, and return it.  Always successful.
 */

static User *new_user(const char *nick)
{
    User *user;

    user = scalloc(sizeof(User), 1);
    if (!nick)
	nick = "";
    strscpy(user->nick, nick, NICKMAX);
/*  old hash code
    list = &userlist[HASH(user->nick)];
    user->next = *list;
    if (*list)
	(*list)->prev = user;
    *list = user;
*/
    add_to_user_hash_table(user->nick, user);
    user->real_ni = findnick(nick);
    if (user->real_ni)
	user->ni = getlink(user->real_ni);
    else
	user->ni = NULL;

    if (++Count.users > Count.users_max) {
	Count.users_max = Count.users;
	Count.users_max_time = time(NULL);
	if (LogMaxUsers)
	    log2c("user: New maximum user count: %d", Count.users_max);
    }
    return user;
}

/*************************************************************************/

/* Change the nickname of a user, and move pointers as necessary. */

static void change_user_nick(User *user, const char *nick)
{

/* old hash code
    if (user->prev)
	user->prev->next = user->next;
    else
	userlist[HASH(user->nick)] = user->next;
    if (user->next)
	user->next->prev = user->prev;
*/
    del_from_user_hash_table(user->nick, user);
    strscpy(user->nick, nick, NICKMAX);
    add_to_user_hash_table(user->nick, user);
/* old hash code    
    list = &userlist[HASH(user->nick)];
    user->next = *list;
    user->prev = NULL;
    
    if (*list)
	(*list)->prev = user;
    *list = user;
*/    
    user->real_ni = findnick(nick);
    if (user->real_ni)
	user->ni = getlink(user->real_ni);
    else
	user->ni = NULL;
	user->local_TS = time(NULL);
}

/*************************************************************************/

/* Remove and free a User structure. */

static void delete_user(User *user)
{
    struct u_chanlist *c, *c2;
    struct u_chaninfolist *ci, *ci2;

    if (debug >= 2)
	log1("debug: delete_user() called");
	
	if(user->session)
	  delete_session(user->session);	
	  
    Count.users--;
    if (IsOper(user))
	  Count.opers--;
    if(IsBot(user))
	  Count.bots--;
    if(IsHelper(user))
	  Count.helpers--;
    cancel_user(user);
    if (debug >= 2)
	log1("debug: delete_user(): free user data");
    free(user->username);
    free(user->host);
    free(user->realname);
    free(user->server);
    free(user->hiddenhost);
	
    if (debug >= 2)
	log1("debug: delete_user(): remove from channels");
    c = user->chans;
    while (c) {
	c2 = c->next;
	chan_deluser(user, c->chan);
	free(c);
	c = c2;
    }
    if (debug >= 2)
	log1("debug: delete_user(): free founder data");
    ci = user->founder_chans;
    while (ci) {
	ci2 = ci->next;
	free(ci);
	ci = ci2;
    }
/* old hash code 
    if (debug >= 2)
	log1("debug: delete_user(): delete from list");
    if (user->prev)
	user->prev->next = user->next;
    else
	userlist[HASH(user->nick)] = user->next;
    if (user->next)
	user->next->prev = user->prev;
*/	
    del_from_user_hash_table(user->nick, user);
    if (debug >= 2)
	log1("debug: delete_user(): free user structure");
    free(user);
    if (debug >= 2)
	log1("debug: delete_user() done");
}

/*************************************************************************/
/*************************************************************************/

/* Return statistics.  Pointers are assumed to be valid. */
void get_user_stats(long *nusers, long *memuse)
{
    long count = 0, mem = 0;
    User *user;
    struct u_chanlist *uc;
    struct u_chaninfolist *uci;

    for (user = hash_next_user(1); user; user=hash_next_user(0)) 
	{
	    count++;
	    mem += sizeof(*user);
	    if (user->username)
		mem += strlen(user->username)+1;
	    if (user->host)
		mem += strlen(user->host)+1;
	    if (user->hiddenhost)
		mem += strlen(user->hiddenhost)+1;
	    if (user->realname)
		mem += strlen(user->realname)+1;
	    if (user->server)
		mem += strlen(user->server)+1;
	    for (uc = user->chans; uc; uc = uc->next)
		mem += sizeof(*uc);
	    for (uci = user->founder_chans; uci; uci = uci->next)
		mem += sizeof(*uci);
    }
    *nusers = count;
    *memuse = mem;
}

/*************************************************************************/

#ifdef DEBUG_COMMANDS

/* Send the current list of users to the named user. */

void send_user_list(User *user)
{
    User *u;
    const char *source = user->nick;

    for (u = hash_next_user(1); u; u = hash_next_user(0)) {
	char buf[BUFSIZE], *s;
	struct u_chanlist *c;
	struct u_chaninfolist *ci;

	notice(s_OperServ, source, "%s!%s@%s +%s %ld %s :%s",
		u->nick, u->username, u->host,
		(u->mode&UMODE_o)?"o":"", u->first_TS, u->server, u->realname);
	buf[0] = 0;
	s = buf;
	for (c = u->chans; c; c = c->next)
	    s += snprintf(s, sizeof(buf)-(s-buf), " %s", c->chan->name);
	notice(s_OperServ, source, "%s%s", u->nick, buf);
	buf[0] = 0;
	s = buf;
	for (ci = u->founder_chans; ci; ci = ci->next)
	    s += snprintf(s, sizeof(buf)-(s-buf), " %s", ci->chan->name);
	notice(s_OperServ, source, "%s%s", u->nick, buf);
    }
}


/* Send information about a single user to the named user.  Nick is taken
 * from strtok(). */

void send_user_info(User *user)
{
    char *nick = strtok(NULL, " ");
    User *u = nick ? finduser(nick) : NULL;
    char buf[BUFSIZE], *s;
    struct u_chanlist *c;
    struct u_chaninfolist *ci;
    const char *source = user->nick;

    if (!u) {
	notice(s_OperServ, source, "User %s not found!",
		nick ? nick : "(null)");
	return;
    }
    notice(s_OperServ, source, "%s!%s@%s +%s %ld %s :%s",
		u->nick, u->username, u->host,
		(u->mode&UMODE_o)?"o":"", u->first_TS, u->server, u->realname);
    buf[0] = 0;
    s = buf;
    for (c = u->chans; c; c = c->next)
	s += snprintf(s, sizeof(buf)-(s-buf), " %s", c->chan->name);
    notice(s_OperServ, source, "%s%s", u->nick, buf);
    buf[0] = 0;
    s = buf;
    for (ci = u->founder_chans; ci; ci = ci->next)
	s += snprintf(s, sizeof(buf)-(s-buf), " %s", ci->chan->name);
    notice(s_OperServ, source, "%s%s", u->nick, buf);
}

#endif	/* DEBUG_COMMANDS */

/*************************************************************************/

/* Find a user by nick.  Return NULL if user could not be found. */

User *finduser(const char *nick)
{
  return hash_find_user(nick);
}

/*************************************************************************/

/* Iterate over all users in the user list.  Return NULL at end of list. */

static User *current;
static int next_index;

User *firstuser(void)
{
    next_index = 0;
    while (next_index < 1024 && current == NULL)
	current = userlist[next_index++];
    if (debug >= 3)
	log1("debug: firstuser() returning %s",
			current ? current->nick : "NULL (end of list)");
    return current;
}


/*************************************************************************/
/*************************************************************************/

/* Handle a server NICK command.
 *	av[0] = nick
 *	If a new user:
 *		av[1] = hop count
 *		av[2] = signon time
 *		av[3] = username
 *		av[4] = hostname
 *		av[5] = user's server
 *		av[6] = user's real name
 *	Else:
 *		av[1] = time of change
 */

void do_nick(const char *source, int ac, char **av)
{
    User *user;
    NickInfo *new_ni=NULL, *new_rni; /* New master nick */
    int ni_changed = 1;	/* Did master nick change? */
    int was_recon=0;	/* Was last nick identified ? */
    int ghostchange=0;	/* nick change from ghost command ? */
	time_t newTS;		/* new nick time stamp */

    /* from PTlink6.13.0 our nicks will "overrule" */
    if( !strcasecmp(av[0], s_NickServ)||
    	!strcasecmp(av[0], s_ChanServ)||
    	!strcasecmp(av[0], s_MemoServ)||
    	!strcasecmp(av[0], s_OperServ)||
    	!strcasecmp(av[0], s_NewsServ)||
    	!strcasecmp(av[0], s_GlobalNoticer))
		return;

    if (!*source) 
	  {
    	
    	  /* from PTlink6.13.0 our nicks will "overrule" 
    	     This needs to be optimized some day  */
    	 if( 	!strcasecmp(av[0], s_NickServ)||
    		!strcasecmp(av[0], s_ChanServ)||
    		!strcasecmp(av[0], s_MemoServ)||
    		!strcasecmp(av[0], s_OperServ)||
    		!strcasecmp(av[0], s_NewsServ)||
    		!strcasecmp(av[0], s_GlobalNoticer))
	     return;	  
	     
		do_snick(source, ac, av);		
  	  } 
	else 
	  {
		/* An old user changing nicks. */
		user = finduser(source);
		
		if(ac>1 && isdigit(av[1][0]))
		  newTS = atol(av[1]);
		else
		  newTS = time(NULL);
		  
		if (!user) 
		  {
	  		log2c("user: NICK from nonexistent nick %s: %s", source,
		  		merge_args(ac, av));
	  		return;
		}
		
		if (debug)
	  	  log1("debug: %s changes nick to %s", source, av[0]);

  		was_recon = nick_identified(user);		
		
  		new_rni = findnick(av[0]);
  		/* Changing nickname case isn't a real change.  Only update
		 * my_signon if the nicks aren't the same, case-insensitively. */	
			 
  		if(new_rni!=user->real_ni) /* check if we have a real nick change */
		  { 
		  
    		if(was_recon)
    		  user->ni->online += (time(NULL) - user->local_TS); 
			  
			
			if (new_rni)
			  {
	  			new_ni = getlink(new_rni);
				/* Check if it is an nick change issued by GHOST command */					
				if(user->on_ghost && new_ni->first_TS && 
					(user->on_ghost==new_ni->first_TS))
				  {
					user->mode &= ~UMODE_r;
  					ghostchange = 1;	    
				  }
				else
				  {
					if (new_ni == user->ni) 
						ni_changed = 0;						
				  }
			  }							
			cancel_user(user);						  
  		  }
		  
		user->on_ghost = 0;	/* force ghost flag reset to avoid hack */
		change_user_nick(user, av[0]);
	
  		/* Let's make ajoin before checking memos */
  		if (ghostchange && !IsBot(user) && (user->ni->flags & NI_AUTO_JOIN) && (user->ni->ajoincount>0))
		    autojoin(user); /* should ajoin on ghost - Lamego */

  		if (!(user->mode & UMODE_r)) 
		  {
			if ((was_recon && !ni_changed) || ghostchange || validate_user(user))
			  {
	  		    user->ni->last_signon = time(NULL);
  			    user->real_ni->last_seen = time(NULL);
			    user->ni->first_TS = user->first_TS;
			    if(!NSNeedAuth || user->ni->email)
  			      send_cmd(s_NickServ, "SVSMODE %s +r", av[0]);  			      				
  			    notice_lang(s_NickServ, user, NICK_AUTORECON);
  			    check_memos(user);
			  }
  		  }
  	  }
}
/* snick - introduce a new user
      parv[0] = nickname
      parv[1] = hopcount
      parv[2] = nick TS (nick introduction time)
      parv[3] = umodes
      parv[4] = username
      parv[5] = hostname
      parv[6] = spoofed hostname
      parv[7] = server
      parv[8] = nick info  	
 */
void do_snick(const char *source, int ac, char **av)
{
    User *user;
    char *domain;
    int isbot=0;	/* Is user coming from a botlist entry ? */
    Session* sess;

    /* This is a new user; create a User structure for it. */
    if (debug)
	  log1("debug: snick new user: %s", av[0]);
	  
    /* First check for AKILLs. */
    if (check_akill(av[0], av[4], av[5])) return;
    if (check_akill(av[0], av[4], av[6])) return;
#ifndef STREAMLINED
        /* Now check for session limits */

    isbot = check_botlist(av[5]);
    if(isbot==0)
      isbot = check_botlist(av[6]);
    sess = add_session(av[0], av[5], isbot);	

	if (!sess) /* this user will be killed for session limit */
        return;	
				  
#endif /* !STREAMLINED */ 	
    /* Allocate User structure and fill it in. */
    user = new_user(av[0]);
    user->session = sess;
    user->first_TS = atol(av[2]);

    user->username = sstrdup(av[4]);
    user->host = sstrdup(av[5]);
    user->server = sstrdup(av[7]);
    user->realname = sstrdup(av[8]);
    user->hiddenhost = strdup(av[6]);
	
	user->local_TS = time(NULL);
	
	user->mode = 0;
	
	if(sess->penalty>10)	/* This user will be glined */
	  {
		log1("user: ignoring %s!%s@%s coming from glined session",
		  user->nick, user->username, user->host);
  		return;
	  }
	  
    domain=(user->host)+strlen(user->host)-3;
    if(domain[0]=='.') 
	domain+=1;	
    user->language=domain_language(domain);
	if (isbot && WebHost && (strcasecmp(user->host,WebHost) == 0))
	  SetWeb(user);
/*
    Going to parse user modes first to avoid sending modes already set
*/	
    av[1] = av[3]; 
    do_umode(av[0],2,av);
	
    if(user->ni) user->ni->status &= ~NS_TEMPORARY;
    if(isbot && !IsBot(user) && !IsWeb(user) && !IsOper(user)) {
	  send_cmd(s_NickServ, "SVSMODE %s +B", av[0]);		  
    }
	if (!isbot) 
  	  {
        if(!nick_recognized(user)) display_news(user, NEWS_LOGON);
		if (NSRegisterAdvice && !(user->ni) && 
		((user->nick[0]!='_') || user->nick[strlen(user->nick)-1]!='-'))
		    notice_lang(s_NickServ, user, NICK_SHOULD_REGISTER,s_NickServ);
  	  }
    if (!(user->mode & UMODE_r)) 
	  {
		if (validate_user(user))
		  {
	  		user->real_ni->last_seen = time(NULL);
	  		send_cmd(s_NickServ, "SVSMODE %s +r", av[0]);
	  		notice_help(s_NickServ, user, NICK_AUTORECON); 
	  		check_memos(user);
		  }
  	  }
	  
    if(AutoJoinChan && !isbot)
    	send_cmd(s_NickServ,"SVSJOIN %s #%s",user->nick,AutoJoinChan);		
}

/*************************************************************************/

/* Handle a JOIN command.
 *	av[0] = channels to join
 */

void do_join(const char *source, int ac, char **av)
{
    User *user;
    struct u_chanlist *c,*c2;    
    char *chan = av[0];
    
    user = finduser(source);
    
    if (!user) 
      {
        log2c("user: JOIN from nonexistent user %s: %s", source,
             merge_args(ac, av));							
        return;
      }
    
    if(*chan=='0') 
      {
        c = user->chans;
        while (c) 
          {
            c2 = c->next;
	    chan_deluser(user, c->chan);
	    free(c);
	    c = c2;
	  }
	user->chans = NULL;
      }
    else
      log2c("error: Got remote :%s JOIN %s ", source, chan);
}

/*************************************************************************/

/* Handle a PART command.
 *	av[0] = channels to leave
 *	av[1] = reason (optional)
 */

void do_part(const char *source, int ac, char **av)
{
    User *user;
    char *s, *t;
    struct u_chanlist *c;

    user = finduser(source);
    if (!user) {
	log2c("user: PART from nonexistent user %s: %s", source,
							merge_args(ac, av));
	return;
    }
    t = av[0];
    while (*(s=t)) {
	t = s + strcspn(s, ",");
	if (*t)
	    *t++ = 0;
	if (debug)
	    log1("debug: %s leaves %s", source, s);
	for (c = user->chans; c && strcasecmp(s, c->chan->name) != 0; c = c->next)
	    ;
	if (c) {
	    if (!c->chan) {
		log2c("user: BUG parting %s: channel entry found but c->chan NULL"
			, s);
		return;
	    }
	    chan_deluser(user, c->chan);
	    if (c->next)
		c->next->prev = c->prev;
	    if (c->prev)
		c->prev->next = c->next;
	    else
		user->chans = c->next;
	    free(c);
	}
    }
}

/*************************************************************************/

/* Handle a KICK command.
 *	av[0] = channel
 *	av[1] = nick(s) being kicked
 *	av[2] = reason
 */

void do_kick(const char *source, int ac, char **av)
{
    User *user;
    char *s, *t;
    struct u_chanlist *c;

    t = av[1];
    while (*(s=t)) {
	t = s + strcspn(s, ",");
	if (*t)
	    *t++ = 0;
	user = finduser(s);
	if (!user) {
	    log2c("user: KICK for nonexistent user %s on %s: %s", s, av[0],
						merge_args(ac-2, av+2));
	    continue;
	}
	if (debug)
	    log1("debug: kicking %s from %s", s, av[0]);
	for (c = user->chans; c && strcasecmp(av[0], c->chan->name) != 0;
								c = c->next)
	    ;
	if (c) {
	    chan_deluser(user, c->chan);
	    if (c->next)
		c->next->prev = c->prev;
	    if (c->prev)
		c->prev->next = c->next;
	    else
		user->chans = c->next;
	    free(c);
	}
    }
}

/*************************************************************************/

/* Handle a MODE command for a user.
 *	av[0] = nick to change mode for
 *	av[1] = modes
 */

void do_umode(const char *source, int ac, char **av)
{
    User *user;
    char *s;
    int add = 1;		/* 1 if adding modes, 0 if deleting */

    if (strcasecmp(source, av[0]) != 0) {
	log1("user: MODE %s %s from different nick %s!", av[0], av[1], source);
	wallops(NULL, "%s attempted to change mode %s for %s",
		source, av[1], av[0]);
	return;
    }
    user = finduser(source);
    if (!user) {
	log2c("user: MODE %s for nonexistent nick %s: %s", av[1], source,
							merge_args(ac, av));
	return;
    }
    if (debug)
	log1("debug: Changing mode for %s to %s", source, av[1]);
    s = av[1];
    while (*s) {
	switch (*s++) {
	    case '+': add = 1; break;
	    case '-': add = 0; break;
	    case 'r': if(add && user->ni) {
			    user->mode |= UMODE_r;
			    user->ni->first_TS = user->first_TS;				
		    } else user->mode &= ~UMODE_r;
		    break;
	    case 'B': add ? SetBot(user) : ClearBot(user);
		    if((Count.bots += add ? +1 : -1)>Count.bots_max) {
			  Count.bots_max = Count.bots;
			  Count.bots_max_time = time(NULL);
		    }
		    break;
	    case 'h': add ? SetHelper(user) : ClearHelper(user);
		    if((Count.helpers += add ? +1 : -1)>Count.helpers_max) {
			  Count.helpers_max = Count.helpers;
			  Count.helpers_max_time = time(NULL);
		    }
		    break;
		    
	    case 'o':
		if (add) {
		if(OperControl) {
	    /* we must allow any /oper when admin list is empty*/
		    if(DayStats.os_admins) { 
			if (!nick_recognized(user)) {
		    	    notice_lang(s_OperServ, user, OPER_IDENTIFY_REQUIRED, s_OperServ);
		    	    send_cmd(s_OperServ,"SVSMODE %s -oa",user->nick);	
		    	    wallops(s_OperServ,"Oper attempt from non identified nick: \2%s\2",user->nick);
					++Count.opers; /* count will be decremented on MODE -o reply */
			    break;
		 	} else if(!is_services_oper_no_oper(user) ) {
		       	    notice_lang(s_OperServ, user, OPER_IDENTIFY_REQUIRED, s_OperServ);
		       	    send_cmd(s_OperServ,"SVSMODE %s -oa",user->nick);	
		       	    wallops(s_OperServ,"Oper attempt from non registered oper: \2%s\2",user->nick);
		       	    log2c("oper: %s!%s@%s failed from server %s (not a registered oper)",
		        	user->nick,user->username,user->host,
		       		user->server);
					++Count.opers; /* count will be decremented on MODE -o reply */
		       	    break;
		    	} else if(user->ni->flags & NI_OSUSPENDED) {
			    if(user->ni->suspension_expire>time(NULL)) {
				notice_lang(s_OperServ, user, OPER_IDENTIFY_REQUIRED, s_OperServ);
		       		send_cmd(s_OperServ,"SVSMODE %s -oa",user->nick);	
		       		wallops(s_OperServ,"Oper attempt from suspended oper: \2%s\2",user->nick);
		       		log2c("oper: %s!%s@%s failed from server %s (suspended oper)",
		        	user->nick,user->username,user->host,
		       		user->server);
					++Count.opers; /* count will be decremented on MODE -o reply */					
				break;
			    } else {
				user->ni->flags &= ~(NI_OSUSPENDED|NI_SUSPENDED);
				log2c("Expired oper suspension for %s",user->nick);
			    }
			} 
		    }
		}
		log2c("oper: %s!%s@%s is now an IRC operator from server %s.",
			    user->nick, user->username, user->host,
			    user->server);
		SetOper(user);			    
		if(is_services_admin(user)) {
	       		send_cmd(s_OperServ,"SVSMODE %s +a",user->nick);
			if(!IsBot(user) && LogChan && user->ni && (user->ni->flags & NI_AUTO_JOIN)) {
		    	    send_cmd(s_OperServ,"INVITE %s #%s",user->nick,
		    		LogChan);
		    	    send_cmd(s_OperServ,"SVSJOIN %s #%s",user->nick,
		    		LogChan);			
			}
		    }
		    if(AdminChan) {
		    	send_cmd(s_OperServ,"INVITE %s #%s",user->nick,
		    	  AdminChan);
		    	send_cmd(s_OperServ,"SVSJOIN %s #%s",user->nick,
		    	  AdminChan);
		    };
		    if (WallOper) {
			wallops(s_OperServ, "\2%s\2 is now an IRC operator.",
				user->nick);			
		    }
		    if(user->mode & UMODE_B) { /* Opers sould never be bots :P */
			  send_cmd(s_NickServ, "SVSMODE %s -B", user->nick);
		    }
		    if(++Count.opers>Count.opers_max) 
			  {
				Count.opers_max = Count.opers;
				Count.opers_max_time = time(NULL);
		    }
		    display_news(user, NEWS_OPER);		    
		} else {
		    ClearOper(user);
		    Count.opers--;
		}
		break; 
	}
    }
}

/*************************************************************************/

/* Handle a QUIT command.
 *	av[0] = reason
 */

void do_quit(const char *source, int ac, char **av)
{
    User *user;
    NickInfo *ni;
    
    user = finduser(source);
    if (!user) {
	log2c("user: QUIT from nonexistent user %s: %s", source,
		merge_args(ac, av));
	return;
    }
    if (debug)
	  log1("debug: %s quits", source);
	  
    if ((ni = user->ni) && nick_recognized(user)) 
	  {
  		if (ni->last_quit)
	  	  free(ni->last_quit);
		  
		ni->last_quit = *av[0] ? sstrdup(av[0]) : NULL;
		ni->last_signon = 0;
		ni = user->real_ni,
		ni->last_seen = time(NULL);
		ni->online+=(time(NULL)-user->local_TS);
		ni->first_TS = 0;
    }
    delete_user(user);
}

/*************************************************************************/

/* Handle a KILL command.
 *	av[0] = nick being killed
 *	av[1] = reason
 */

void do_kill(const char *source, int ac, char **av)
{
    User *user;
    NickInfo *ni;
    user = finduser(av[0]);
    if (!user)
	return;
    if (debug)
	log1("debug: %s killed", av[0]);
    if ((ni = user->ni) && (!(ni->status & NS_VERBOTEN)) &&
			nick_recognized(user)) {
	ni->last_signon = 0;
	
	if (ni->last_quit)
	    free(ni->last_quit);
		
	  ni->last_quit = *av[1] ? sstrdup(av[1]) : NULL;
	  ni = user->real_ni;
	  ni->last_seen = time(NULL);
	  ni->online += (time(NULL)-user->local_TS);
    }
    delete_user(user);
}

/*************************************************************************/

/* Is the given nick an oper? */

int is_oper(const char *nick)
{
    User *user = finduser(nick);
    return user && (user->mode & UMODE_o);
}

/*************************************************************************/

/* Is the given nick on the given channel? */

int is_on_chan(const char *nick, const char *chan)
{
    User *u = finduser(nick);
    struct u_chanlist *c;

    if (!u)
	return 0;
    for (c = u->chans; c; c = c->next) {
	if (strcasecmp(c->chan->name, chan) == 0)
	    return 1;
    }
    return 0;
}

/*************************************************************************/

/* Is the given nick a channel operator on the given channel? */

int is_chanop(const char *nick, const char *chan)
{
    Channel *c = findchan(chan);
    struct c_userlist *u;

    if (!c)
	return 0;
    for (u = c->chanops; u; u = u->next) {
	if (strcasecmp(u->user->nick, nick) == 0)
	    return 1;
    }
    return 0;
}

#ifdef HALFOPS
int is_halfop(const char *nick, const char *chan)
{
	Channel *c = findchan(chan);
	struct c_userlist *u;
	
	if(!c)
	    return 0;
	for(u = c->halfops; u; u = u->next) {
		if(strcasecmp(u->user->nick, nick) == 0)
		return 1;
	}
	return 0;
}
#endif

/*************************************************************************/

/* Is the given nick voiced (channel mode +v) on the given channel? */

int is_voiced(const char *nick, const char *chan)
{
    Channel *c = findchan(chan);
    struct c_userlist *u;

    if (!c)
	return 0;
    for (u = c->voices; u; u = u->next) {
	if (strcasecmp(u->user->nick, nick) == 0)
	    return 1;
    }
    return 0;
}

/*************************************************************************/
/*************************************************************************/

/* Does the user's usermask match the given mask (either nick!user@host or
 * just user@host)?
 */

int match_usermask(const char *mask, User *user)
{
    char *mask2 = sstrdup(mask);
    char *nick, *username, *host, *nick2 , *host2;
    char *host3;
    int result;
    
    if (strchr(mask2, '!')) 
	  {
		nick = strlower(strtok(mask2, "!"));
		username = strtok(NULL, "@");
  	  } 
	else 
	  {
		nick = NULL;
		username = strtok(mask2, "@");
  	  }
	  
    host = strtok(NULL, "");
    if (!username || !host) {
	free(mask2);
	return 0;
    }
    strlower(host);
    host2 = strlower(sstrdup(user->host));
    host3 = strlower(sstrdup(user->hiddenhost));
    if (nick) {
	nick2 = strlower(sstrdup(user->nick));
	result = match_wild(nick, nick2) &&
		 match_wild(username, user->username) &&
		 (match_wild(host, host2) || match_wild(host, host3));
	free(nick2);
    } else {
	result = match_wild(username, user->username) &&
		 (match_wild(host, host2) || match_wild(host, host3));		 
    }
    free(mask2);
    free(host2);
    free(host3);
    return result;
}

/*************************************************************************/

/* Split a usermask up into its constitutent parts.  Returned strings are
 * malloc()'d, and should be free()'d when done with.  Returns "*" for
 * missing parts.
 */

void split_usermask(const char *mask, char **nick, char **user, char **host)
{
    char *mask2 = sstrdup(mask);

    *nick = strtok(mask2, "!");
    *user = strtok(NULL, "@");
    *host = strtok(NULL, "");
    /* Handle special case: mask == user@host */
    if (*nick && !*user && strchr(*nick, '@')) {
	*nick = NULL;
	*user = strtok(mask2, "@");
	*host = strtok(NULL, "");
    }
    if (!*nick)
	*nick = "*";
    if (!*user)
	*user = "*";
    if (!*host)
	*host = "*";
    *nick = sstrdup(*nick);
    *user = sstrdup(*user);
    *host = sstrdup(*host);
    free(mask2);
}

/*************************************************************************/

/* Given a user, return a mask that will most likely match any address the
 * user will have from that location.  For IP addresses, wildcards the
 * appropriate subnet mask (e.g. 35.1.1.1 -> 35.*; 128.2.1.1 -> 128.2.*);
 * for named addresses, wildcards the leftmost part of the name unless the
 * name only contains two parts.  If the username begins with a ~, delete
 * it.  The returned character string is malloc'd and should be free'd
 * when done with.
 */

char *create_mask(User *u)
{
    char *mask, *s, *end;

    /* Get us a buffer the size of the username plus hostname.  The result
     * will never be longer than this (and will often be shorter), thus we
     * can use strcpy() and sprintf() safely.
     */
    end = mask = smalloc(strlen(u->username) + strlen(u->hiddenhost) + 4);
    end += sprintf(end, "*!%s@", u->username);
    if (strspn(u->hiddenhost, "0123456789.") == strlen(u->hiddenhost)
		&& (s = strchr(u->hiddenhost, '.'))
		&& (s = strchr(s+1, '.'))
		&& (s = strchr(s+1, '.'))
		&& (   !strchr(s+1, '.'))) {	/* IP addr */
	s = sstrdup(u->hiddenhost);
	*strrchr(s, '.') = 0;
	if (atoi(u->hiddenhost) < 192)
	    *strrchr(s, '.') = 0;
	if (atoi(u->hiddenhost) < 128)
	    *strrchr(s, '.') = 0;
	sprintf(end, "%s.*", s);
	free(s);
    } else {
	if ((s = strchr(u->hiddenhost, '.')) && strchr(s+1, '.')) {
	    s = sstrdup(strchr(u->hiddenhost, '.')-1);
	    *s = '*';
	} else {
	    s = sstrdup(u->hiddenhost);
	}
	strcpy(end, s);
	free(s);
    }
    return mask;
}

/*************************************************************************/
