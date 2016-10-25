/* NickServ functions.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2003
 * http://www.ptlink.net/Coders/ - coders@PTlink.net
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services
 * $Id: nickserv.c,v 1.27 2005/03/12 15:17:08 jpinto Exp $
*/

/*
 * Note that with the addition of nick links, most functions in Services
 * access the "effective nick" (u->ni) to determine privileges and such.
 * The only functions which access the "real nick" (u->real_ni) are:
 *	various functions which set/check validation flags
 *	    (validate_user, cancel_user, nick_{identified,recognized},
 *	     do_identify)
 *	validate_user (adding a collide timeout on the real nick)
 *	cancel_user (deleting a timeout on the real nick)
 *	do_register (checking whether the real nick is registered)
 *	do_drop (dropping the real nick)
 *	do_link (linking the real nick to another)
 *	do_unlink (unlinking the real nick)
 *	chanserv.c/do_register (setting the founder to the real nick)
 * plus a few functions in users.c relating to nick creation/changing.
 */
#include "stdinc.h"
#include "services.h"
#include "pseudo.h"
#include "ircdsetup.h"
#include "newsserv.h"
#include "hash.h"

#define DFV_NICKSERV 11	/* NickServ datafile version */

/*************************************************************************/


static NickInfo *nicklists[N_MAX];	/* One for each initial character */

/* For local timeout use: */
#define TO_COLLIDE	0	/* Collide the user with this nick */
#define TO_RELEASE	1	/* Release a collided nick */

/*************************************************************************/

static void insert_nick(NickInfo *ni);
static NickInfo *makenick(const char *nick);
static int delnick(NickInfo *ni);
static void remove_links(NickInfo *ni);
void delink(NickInfo *ni);
static int delnote(NoteInfo *ni, int num);
static int addnote(NoteInfo *ni, char* note);
void autojoin(User *u);

static void collide(NickInfo *ni, int from_timeout);
static void release(NickInfo *ni, int from_timeout);
static void add_ns_timeout(NickInfo *ni, int type, time_t delay);
static void del_ns_timeout(NickInfo *ni, int type);

static void do_help(User *u);
static void do_register(User *u);
static void do_identify(User *u);
static void do_drop(User *u);
static void do_set(User *u);
static void do_set_password(User *u, NickInfo *ni, char *param);
static void do_set_language(User *u, NickInfo *ni, char *param);
static void do_set_url(User *u, NickInfo *ni, char *param);
static void do_set_email(User *u, NickInfo *ni, char *param);
static void do_set_icqnumber(User *u, NickInfo *ni, char *param);
static void do_set_location(User *u, NickInfo *ni, char *param);
static void do_set_kill(User *u, NickInfo *ni, char *param);
static void do_set_private(User *u, NickInfo *ni, char *param);
static void do_set_newsletter(User *u, NickInfo *ni, char *param);
static void do_set_autojoin(User *u, NickInfo *ni, char *param);
static void do_set_privmsg(User *u, NickInfo *ni, char *param);
static void do_set_hide(User *u, NickInfo *ni, char *param);
static void do_set_noexpire(User *u, NickInfo *ni, char *param);
static void do_ajoin(User *u);
static void do_link(User *u);
static void do_unlink(User *u);
static void do_listlinks(User *u);
static void do_info(User *u);
static void do_notes(User *u);
static void do_list(User *u);
static void do_ghost(User *u);
static void do_status(User *u);
static void do_getpass(User *u);
static void do_forbid(User *u);
static void do_stats(User *u);
static void do_suspend(User *u);
static void do_auth(User *u);

/*************************************************************************/

static Command cmds[] = {
    { "HELP",     do_help,     NULL,  -1,                     -1,-1,-1,-1 },
    { "REGISTER", do_register, NULL,  NICK_HELP_REGISTER,     -1,-1,-1,-1 },
    { "IDENTIFY", do_identify, NULL,  NICK_HELP_IDENTIFY,     -1,-1,-1,-1 },
    { "AUTH",         do_auth, NULL,  NICK_HELP_AUTH,         -1,-1,-1,-1 },
    { "DROP",     do_drop,     NULL,  -1,
		NICK_HELP_DROP, NICK_SERVADMIN_HELP_DROP,
		NICK_SERVADMIN_HELP_DROP, NICK_SERVADMIN_HELP_DROP },
    { "AJOIN",   do_ajoin,     NULL,  NICK_HELP_AJOIN,        -1,-1,-1,-1 },    
    { "LINK",     do_link,     NULL,  NICK_HELP_LINK,         -1,-1,-1,-1 },
    { "UNLINK",   do_unlink,   NULL,  NICK_HELP_UNLINK,       -1,-1,-1,-1 },
    { "SET",      do_set,      NULL,  NICK_HELP_SET,
		-1, NICK_SERVADMIN_HELP_SET,
		NICK_SERVADMIN_HELP_SET, NICK_SERVADMIN_HELP_SET },
    { "SET PASSWORD", NULL,    NULL,  NICK_HELP_SET_PASSWORD, -1,-1,-1,-1 },
    { "SET URL",      NULL,    NULL,  NICK_HELP_SET_URL,      -1,-1,-1,-1 },
    { "SET EMAIL",    NULL,    NULL,  NICK_HELP_SET_EMAIL,    -1,-1,-1,-1 },
    { "SET ICQNUMBER",NULL,    NULL,  NICK_HELP_SET_ICQ,      -1,-1,-1,-1 },    
    { "SET LOCATION", NULL,    NULL,  NICK_HELP_SET_LOCATION, -1,-1,-1,-1 },    
    { "SET KILL",     NULL,    NULL,  NICK_HELP_SET_KILL,     -1,-1,-1,-1 },
    { "SET PRIVATE",  NULL,    NULL,  NICK_HELP_SET_PRIVATE,  -1,-1,-1,-1 },
    { "SET NEWSLETTER",NULL,   NULL,  NICK_HELP_SET_NEWSLETTER,-1,-1,-1,-1 },    
    { "SET AUTOJOIN", NULL,    NULL,  NICK_HELP_SET_AUTOJOIN, -1,-1,-1,-1 },    
    { "SET PRIVMSG", NULL,    NULL,  NICK_HELP_SET_PRIVMSG, -1,-1,-1,-1 },        
    { "SET HIDE",     NULL,    NULL,  NICK_HELP_SET_HIDE,     -1,-1,-1,-1 },
    { "SET NOEXPIRE", NULL,    NULL,  -1, -1,
		NICK_SERVADMIN_HELP_SET_NOEXPIRE,
		NICK_SERVADMIN_HELP_SET_NOEXPIRE,
		NICK_SERVADMIN_HELP_SET_NOEXPIRE },
    { "GHOST",    do_ghost,    NULL,  NICK_HELP_GHOST,        -1,-1,-1,-1 },
    { "INFO",     do_info,     NULL,  NICK_HELP_INFO,         -1,-1,-1,-1 },
    { "NOTES",	  do_notes,    NULL,  NICK_HELP_NOTES,	      -1,-1,-1,-1 },
    { "STATS",    do_stats, NULL,  -1,           -1,-1,-1,-1 },		    
    { "LIST",     do_list,     NULL,  -1,
		NICK_HELP_LIST, NICK_SERVADMIN_HELP_LIST,
		NICK_SERVADMIN_HELP_LIST, NICK_SERVADMIN_HELP_LIST },
    { "STATUS",   do_status,   NULL,  NICK_HELP_STATUS,       -1,-1,-1,-1 },
    { "LISTLINKS",do_listlinks, NULL, -1,
		NICK_HELP_LISTLINKS, NICK_HELP_LISTLINKS,
		NICK_SERVADMIN_HELP_LISTLINKS, NICK_SERVADMIN_HELP_LISTLINKS },
    { "GETPASS",  do_getpass,  is_services_admin,  -1,
		-1, NICK_SERVADMIN_HELP_GETPASS,
		NICK_SERVADMIN_HELP_GETPASS, NICK_SERVADMIN_HELP_GETPASS },
    { "FORBID",   do_forbid,   is_services_admin,  -1,
		-1, NICK_SERVADMIN_HELP_FORBID,
		NICK_SERVADMIN_HELP_FORBID, NICK_SERVADMIN_HELP_FORBID },
    { "SUSPEND",  do_suspend,   is_services_admin,  -1,
		-1, NICK_SERVADMIN_HELP_SUSPEND,
		NICK_SERVADMIN_HELP_SUSPEND, NICK_SERVADMIN_HELP_SUSPEND },		

    { NULL }
};

u_int32_t last_snid = 0;

u_int32_t ns_hash_nick_name(const char* name)
{
  unsigned int h = 0;
                                                                                              

  while (*name)
    {
      h = (h << 4) - (h + (unsigned char)ToLower(*name++));
    }
                                                                                                          

  return(h & (U_MAX - 1));
}
/*************************************************************************/
/*************************************************************************/

/* Display total number of registered nicks and info about each; or, if
 * a specific nick is given, display information about that nick (like
 * /msg NickServ INFO <nick>).  If count_only != 0, then only display the
 * number of registered nicks (the nick parameter is ignored).
 */

void listnicks(int count_only, const char *nick)
{
    int count = 0;
    NickInfo *ni;
    int i;
    if (count_only) {

	for (i = 0; i < N_MAX; i++) {
	    for (ni = nicklists[i]; ni; ni = ni->next)
		count++; 
	}
	printf("%d nicknames registered.\n", count);

    } else if (nick) {

	struct tm *tm;
	char buf[512];

	if (!(ni = findnick(nick))) {
	    printf("Nick %s not registered.\n", nick);
	    return;
	} else if (ni->status & NS_VERBOTEN) {
	    printf("Nick %s is FORBIDden.\n", nick);
	    return;
	}
	printf("              Nick: %s\n", nick);
	printf("          Username: %s\n", ni->last_realname);
	printf(" Last seen address: %s\n", ni->last_usermask);
	tm = localtime(&ni->time_registered);
	strftime(buf, sizeof(buf), "%b %d %H:%M:%S %Y %Z", tm);
	printf("   Time registered: %s\n", buf);
	tm = localtime(&ni->last_identify);
	strftime(buf, sizeof(buf), "%b %d %H:%M:%S %Y %Z", tm);
	printf("Last identify time: %s\n", buf);
	tm = localtime(&ni->last_seen);
	strftime(buf, sizeof(buf), "%b %d %H:%M:%S %Y %Z", tm);
	printf("    Last seen time: %s\n", buf);	
	if (ni->url)
	    printf("               URL: %s\n", ni->url);
	if (ni->email)
	    printf("    E-mail address: %s\n", ni->email);
	if (ni->icq_number)
	    printf("        ICQ number: #%s\n", ni->icq_number);	    
	if (ni->location)
	    printf("         Location : %s\n", ni->location);
    } else {

	for (i = 0; i < N_MAX; i++) {
	    for (ni = nicklists[i]; ni; ni = ni->next) {
	        if(expiremail) {
		    if(ni->email && !(ni->status & NS_VERBOTEN)
			&& (time(NULL)-ni->last_seen>NSExpire-expiremail)
			&& (time(NULL)-ni->last_seen<NSExpire-expiremail+(24*3600))
			)
			printf("%s %s\n", ni->email, ni->nick);
		} else
		    printf("    %-20s  %s\n", ni->nick, ni->last_usermask);
		count++;
	    }
	}
	if(!expiremail) printf("%d nicknames registered.\n", count);

    }
#if HAVE_MYSQL    
    if(count_only)
      save_ns_dbase();
#endif
}

/*************************************************************************
 Returns 0 if email is invalid
 *************************************************************************/
int is_email(char *email) 
{
    char *i=NULL, *j=NULL;
    if (strlen(email)>51)
    	return 0;
    	
    i = strchr(email ,'@');
    
    if(i)
    	j = strchr(i ,'.');    

    if(!i || !j || (j-i<3))
    	return 0;
    	

    	
    if (strchr(email,';') || strchr(email,':') || strchr(email,'|')
    	|| strchr(email,'/') || strchr(email,',') || strchr(email,'&'))
    		return 0;
    		
    while( (i=strchr(j ,'.')) )
    {
    	j = i;
    	++j;	
    }

    if(strlen(email)- ((int)(j-email)) <2)
    	return 0;    
    
   return 1;	
}    
/*************************************************************************/

/* Return information on memory use.  Assumes pointers are valid. */

void get_nickserv_stats(long *nrec, long *memuse)
{
    long count = 0, mem = 0;
    int i, j;
    NickInfo *ni;
    char **accptr;

    for (i = 0; i < N_MAX; i++) {
	for (ni = nicklists[i]; ni; ni = ni->next) {
	    count++;
	    mem += sizeof(*ni);
	    if (ni->url)
		mem += strlen(ni->url)+1;
	    if (ni->email)
		mem += strlen(ni->email)+1;
	    if (ni->email_request)
		mem += strlen(ni->email_request)+1;		
	    if (ni->icq_number)
		mem += strlen(ni->icq_number)+1;		
	    if (ni->location)
		mem += strlen(ni->location)+1;				
	    if (ni->last_usermask)
		mem += strlen(ni->last_usermask)+1;
	    if (ni->last_realname)
		mem += strlen(ni->last_realname)+1;
	    if (ni->last_quit)
		mem += strlen(ni->last_quit)+1;
	    if (ni->link) 
	      continue;
	    mem += sizeof(char *) * ni->ajoincount;
	    for (accptr=ni->autojoin, j=0; j < ni->ajoincount; accptr++, j++) {
		if (*accptr)
		    mem += strlen(*accptr)+1;
	    }	    
	    mem += ni->memos.memocount * sizeof(Memo);
	    for (j = 0; j < ni->memos.memocount; j++) {
		if (ni->memos.memos[j].text)
		    mem += strlen(ni->memos.memos[j].text)+1;
	    }
	    mem += ni->notes.count * sizeof(char*);
	    for (j = 0; j < ni->notes.count; j++) {
		if (ni->notes.note[j])
		    mem += strlen(ni->notes.note[j])+1;
	    }
	}
    }
    *nrec = count;
    *memuse = mem;
}

/*************************************************************************/
/*************************************************************************/

/* NickServ initialization. */

void ns_init(void)
{
}

/*************************************************************************/

/* Main NickServ routine. */

void nickserv(const char *source, char *buf)
{
    char *cmd, *s;
    User *u = finduser(source);

    if (!u) {
	log2c("%s: user record for %s not found", s_NickServ, source);
        notice(s_NickServ, source,
	  getstring(NULL, USER_RECORD_NOT_FOUND));
	return;
    }

    cmd = strtok(buf, " ");

    if (!cmd) {
	return;
    } else if (strcasecmp(cmd, "\1PING") == 0) {
	if (!(s = strtok(NULL, "")))
	    s = "\1";
	  notice_s(s_NickServ, source, "\1PING %s", s);
    } else if (skeleton) {
	notice_lang(s_NickServ, u, SERVICE_OFFLINE, s_NickServ);
    } else {
	run_cmd(s_NickServ, u, cmds, cmd);
    }

}

/*************************************************************************/

/* Load/save data files. */


#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	  {						\
	    log1("Read error on %s", NickDBName);	\
	    abort();					\
	  }						\
	failed = 1;					\
	break;						\
    }							\
} while (0)

void load_ns_dbase(void)
{
    dbFILE *f;
    FILE *stdb = NULL;
    char tmppass[33];
    int ver, i, j, c;
    int16 sver = 0;
    int16 tmp16;
    u_int32_t total;
    u_int32_t to_read;
    NickInfo *ni;
    char *tmplink;
    int del;
    int failed = 0;
    if (!(f = open_db(s_NickServ, NickDBName, "r")))
	return;
	
    if(listnicks_stdb)
      {
        stdb=fopen("nick.stdb","w");
        if(stdb==NULL)
          {
            printf("Could not create nick.stdb\n");
            return;
          }
        fprintf(stdb,"# .stdb file - (C) PTlink IRC Software 2000-2003 - http://www.ptlink.net/Coders/\n");
      }
    switch (ver = get_file_version(f)) {
      case -1: SAFE(read_int16(&sver, f));
	    if(sver<1 || sver>DFV_NICKSERV) 
		fatal("Unsupported subversion (%d) on %s", sver, NickDBName);      
	    if(sver<DFV_NICKSERV) 
		log1("NickServ DataBase WARNING: converting from subversion %d to %d",
		    sver, DFV_NICKSERV);	       
	if(sver>3) {
	    SAFE(read_int32(&total, f));
	} else 
	{
	  fatal("Subversion < 4 is not supported any more");
	}
	to_read = total;
	while (to_read>0) {
	    if (sver<10)
	      c = getc_db(f);
	    else 
	      c = 1 ; 
   	    if (c==1) 
   	      {
	        u_int32_t tmp32;   	      
   	      	--to_read;

	        ni = scalloc(sizeof(NickInfo), 1);
	        ni->forcednicks = 0;
	        ni->last_signon = 0;
		if(sver>8)
		  {		  
		    if(read_int32(&ni->snid, f)<0)
		    {
		       log1("Unexpected end of db, expecting %d nicks, got %lu",
		       	total, DayStats.ns_total);
		       break;
		    } 		    
		  }
		if(sver>10) /* we have a valid snid */
		  {
                    if(ni->snid > last_snid)
                      last_snid = ni->snid;
                  }
                else
                  {
                    ni->snid = ++last_snid;
                  }
		DayStats.ns_total++;   	      			  
		SAFE(read_buffer(ni->nick, f));
		if(findnick(ni->nick)) /* its a duplicate */
		  {
		    log1("Ignoring duplicate nick %s", ni->nick);
		    del = 1;
		  }
                else
                  del = 0;
		insert_nick(ni);
		SAFE(read_buffer(ni->pass, f));
		if(sver>6)
		  SAFE(read_buffer(ni->auth, f));
		else
		 ni->auth[0]='\0';		 
		SAFE(read_string(&ni->url, f));
		SAFE(read_string(&ni->email_request, f));
		if(sver>6)
		  SAFE(read_string(&ni->email, f));
		else
		  ni->email = NULL;
		if(!NSNeedAuth && ni->email_request && !ni->email)
		  ni->email=strdup(ni->email_request);
		if(sver>5) {
		    SAFE(read_string(&ni->icq_number, f));
		    SAFE(read_string(&ni->location, f));
		}
		else {
		    ni->icq_number=NULL;
		    ni->location=NULL;
		}
		SAFE(read_string(&ni->last_usermask, f));
		if (!ni->last_usermask)
		    ni->last_usermask = sstrdup("@");
		SAFE(read_string(&ni->last_realname, f));
		if (!ni->last_realname)
		    ni->last_realname = sstrdup("");
		SAFE(read_string(&ni->last_quit, f));
		SAFE(read_int32(&tmp32, f));
		ni->time_registered = tmp32;
		SAFE(read_int32(&tmp32, f));
		ni->last_identify = tmp32;
		if(sver>1) {
		    SAFE(read_int32(&tmp32, f));
		    ni->last_seen = tmp32;
		} else ni->last_seen = ni->last_identify;
		if(sver>6)
		  {
		    SAFE(read_int32(&tmp32, f));
		    ni->last_email_request = tmp32;
		  }
		if(sver>5) {
		    SAFE(read_int32(&tmp32, f));
		    ni->birth_date = tmp32;
		} else ni->birth_date = 0;
		SAFE(read_int16(&ni->status, f));
		ni->status &= ~NS_TEMPORARY;		
		if(sver>4) {
		    SAFE(read_int16(&tmp16, f));
		    ni->crypt_method = tmp16;
		} else
		    ni->crypt_method = (ni->status & NS_ENCRYPTEDPW) ? 1 : 0;
		if(stdb && listnicks_stdb)
		  {
                    if(ni->crypt_method==3)
                      strcpy(tmppass, hex_str(ni->pass,16));
                    else 
                      strcpy(tmppass, ni->pass);		  
                    fprintf(stdb,"%s %s %lu %lu %s\n",
                      ni->nick,
                      (ni->status & NS_VERBOTEN) ? "*" : tmppass,
                      (unsigned long int) ni->time_registered,
                      (unsigned long int)ni->last_seen,
                      ni->email ? ni->email :"");
                  }                  
		if(sver<3) {
		    ni->news_mask = NM_ALL;
		    ni->news_status = NW_WELCOME;
		} else {
		    SAFE(read_int32(&tmp32, f));
		    ni->news_mask = tmp32;
		    SAFE(read_int16(&ni->news_status, f));
		}		
		if (!ni->crypt_method && EncryptMethod) {
		    if (debug)
			log1("debug: %s: encrypting password for `%s' on load",
				s_NickServ, ni->nick);
		    if (encrypt_in_place(ni->pass, PASSMAX) < 0)
			fatal("%s: Can't encrypt `%s' nickname password!",
				s_NickServ, ni->nick);
		    ni->crypt_method = EncryptMethod;		
		}

		/* Store the _name_ of the link target in ni->link for now;
		 * we'll resolve it after we've loaded all the nicks */
		SAFE(read_string((char **)&ni->link, f));
		SAFE(read_int16(&ni->linkcount, f));
		if (ni->link) 
		  {
		    SAFE(read_int16(&ni->channelcount, f));
		    /* No other information saved for linked nicks, since
		     * they get it all from their link target */
		    ni->flags = 0;
		    ni->ajoincount = 0;
		    ni->autojoin = NULL;		    
		    ni->memos.memocount = 0;
		    ni->memos.memomax = MSMaxMemos;
		    ni->memos.memos = NULL;
		    ni->notes.count = 0;
		    ni->notes.max = 0;
		    ni->notes.note = NULL;
		    ni->channelmax = CSMaxReg;
		    ni->language = DefLanguage;
		    ni->last_signon = 0;
		} else {
		    SAFE(read_int32(&ni->flags, f));
		    if(sver<3) {
			ni->flags &= ~NI_DROPPED;
		    }
		    if(sver<8) {
		    	ni->flags |= NI_NEWSLETTER;
		    }		    
		    if(sver>2) {
			SAFE(read_int32(&tmp32, f));
			if(sver>5)
			    ni->online = tmp32;		    
			else
			    ni->online = 0;
		    } else ni->online = 0;
		    if(sver>5 && (ni->flags & (NI_SUSPENDED | NI_OSUSPENDED))) {
			SAFE(read_int32(&tmp32, f));
			ni->suspension_expire = tmp32;
		    }		    
		    if (!NSAllowKillImmed)
			ni->flags &= ~NI_KILL_IMMED;
		/* We don't use access list anymore, just discard it */
		    if(sver<3) {
			int16 count=0;
			SAFE(read_int16(&count, f));
			if (count) {
			    char *tmp;
			    for (j = 0; j < count; j++) {
				SAFE(read_string(&tmp, f));
				free(tmp);
			    }
			}
		    }
		    if(!sver) {
			    ni->flags |= NI_AUTO_JOIN;
			    ni->ajoincount = 0;
			    ni->autojoin = NULL;
		    } else {
			SAFE(read_int16(&ni->ajoincount, f));
			if (ni->ajoincount) {
			    char **autojoin;
			    autojoin = smalloc(sizeof(char *) * ni->ajoincount);
			    ni->autojoin = autojoin;
			    for (j = 0; j < ni->ajoincount; j++, autojoin++) 
				SAFE(read_string(autojoin, f));
			}
		    }
		    SAFE(read_int16(&ni->memos.memocount, f));
		    SAFE(read_int16(&ni->memos.memomax, f));
		    if (ni->memos.memocount) {
			Memo *memos;
			memos = smalloc(sizeof(Memo) * ni->memos.memocount);
			ni->memos.memos = memos;
			for (j = 0; j < ni->memos.memocount; j++, memos++) {
			    SAFE(read_int32(&memos->number, f));
			    SAFE(read_int16(&memos->flags, f));
			    SAFE(read_int32(&tmp32, f));
			    memos->time = tmp32;
			    SAFE(read_buffer(memos->sender, f));
			    SAFE(read_string(&memos->text, f));
			}
		    }
		    ni->notes.count = 0;
		    ni->notes.max = NSMaxNotes;		    
		    
		    SAFE(read_int16(&ni->notes.count, f));
		    SAFE(read_int16(&ni->notes.max, f));			
		    
		    if(NSMaxNotes>ni->notes.max)
		        ni->notes.max = NSMaxNotes;
		    if(ni->notes.max)
			  ni->notes.note=smalloc(sizeof(char*) * ni->notes.max);
			else 
		    	  ni->notes.note = NULL;
		    for (j = 0; j < ni->notes.count; j++) {
			SAFE(read_string(&ni->notes.note[j], f));
		    }
		    SAFE(read_int16(&ni->channelcount, f));
		    SAFE(read_int16(&ni->channelmax, f));		    
		    if (ver == 5) {
			/* Fields not initialized properly for new nicks */
			/* These will be updated by load_cs_dbase() */
			ni->channelcount = 0;
			ni->channelmax = CSMaxReg;
		    }
		    SAFE(read_int16(&ni->language, f));
		    /* this code is only needed for compatibility */
		    if(sver<4 && ni->language==5)		  
		  	ni->language=LANG_EN_US;

		    if(ni->language>=NUM_LANGS)
		      ni->language = DefLanguage;
		      
		    if(del)
		      {
                        delnick(ni);
                        DayStats.ns_total--;
                      }
		}
	    }  /* if (c == 1) */
	} /* while(to_read>0) */

	/* Now resolve links */
	for (i = 0; i < N_MAX; i++) {
	    for (ni = nicklists[i]; ni; ni = ni->next) {
		if (ni->link)
		  {
		    tmplink = (char *)ni->link;
		    ni->link = findnick(tmplink);
		    free(tmplink);
		  }
	    }
	}

	break;
      default:
	fatal("Unsupported version number (%d) on %s", ver, NickDBName);

    } /* switch (version) */

/* We don't need this anymore because we now always read
   until we reach the nicks count - Lamego
   
    if (sver>3 && total!=(u_int32_u) DayStats.ns_total)
		    log1("Invalid format in %s, loaded %ld nicks", 
		    NickDBName, DayStats.ns_total);
*/		    
    close_db(f);
    
    if(stdb && listnicks_stdb)
      fclose(stdb);
    log2c("NickServ: Loaded %lu nicks", DayStats.ns_total);
}

#undef SAFE

#include "ns_save.c"

/*************************************************************************
  Delete a note by number.  Return 1 if the note was found, else 0. 
 *************************************************************************/
static int delnote(NoteInfo *ni, int num)
{
    int i;
    if (num>-1 && num < ni->count) 
	  {
		if(ni->note[num]) /* paranoid checking */
	  	  free(ni->note[num]);
		for(i=num;i+1 < ni->count;++i) ni->note[i]=ni->note[i+1];
		ni->count--;
		return 1;
    } else 
	return 0;
}

/*************************************************************************
  Add a note.  Return notes count if there is space for note, else 0.         
 *************************************************************************/
static int addnote(NoteInfo *ni, char* note)
{
    if(ni->count < ni->max) {
	ni->note[ni->count++]=sstrdup(note);
	return ni->count;
    } else 
	return 0;
}


/*************************************************************************/

/*************************************************************************
  Check whether a user is on the access list of the nick they're using, or
  if they're the same user who last identified for the nick.  If not, send
  warnings as appropriate.  If so, update last seen info.  
  Return 1 if the user is valid and recognized, 0 otherwise (note
  This means an nick will return 0 from here unless the
  user's timestamp matches the last identify timestamp).  If the user's
  nick is not registered, 0 is returned.
 *************************************************************************/

int validate_user(User *u)
{
    NickInfo *ni;
    char checkmask[HOSTLEN+15];	/* 10 should is enough for username */

    if (!(ni = u->real_ni)) 
	  return 0;

    if (ni->flags & NI_SUSPENDED)
      {
	 if(ni->suspension_expire<time(NULL))
	 {
	   log2c("%s: Expired nick suspension for %s", 
	 	s_NickServ, u->nick);
	   ni->flags &= ~NI_SUSPENDED;
	 }
      }
      
    if ((ni->status & NS_VERBOTEN) || (ni->flags & NI_SUSPENDED)) 
      {
	notice_lang(s_NickServ, u, NICK_MAY_NOT_BE_USED);

        if(++(ni->forcednicks)>=NSMaxNChange)
          {
            ni->forcednicks=0;
	    kill_user(s_NickServ, ni->nick, "Please use another nick");
	    chanlog("Nick %s exceeded non identify limit.",ni->nick);
	  }
	else
	  send_cmd(s_NickServ,"SVSGUEST %s %s %d",
	    ni->nick, GuestPrefix ? GuestPrefix : "Guest", 999);
	    	                          
        return 0;
    }

    if (u->first_TS && u->ni->first_TS &&  (u->first_TS==u->ni->first_TS))
	  { /* same signon time, check if is the same user */
		snprintf(checkmask,sizeof(checkmask), "%s@%s", u->username, u->host);
		if( !strcmp(checkmask,ni->last_usermask) )
	  	  return 1;
  	  }

    if (!IsWeb(u))
	  notice_lang(s_NickServ, u, NICK_IS_SECURE,s_NickServ);

/* <duck-patch> */
    if(!NickChange || (NickChange && (u->ni->flags & NI_KILLPROTECT))) {
	if (u->ni->flags & NI_KILLPROTECT) {
	    if ((u->ni->flags & NI_KILL_IMMED)) 
	    { 
		if(!IsWeb(u))
		  notice_lang(s_NickServ, u, DISCONNECT_NOW);
		collide(ni, 0);
	    } else if (u->ni->flags & NI_KILL_QUICK) {
		if(!IsWeb(u))
		  notice_lang(s_NickServ, u, DISCONNECT_IN_20_SECONDS);
		add_ns_timeout(ni, TO_COLLIDE, 20);
	    } else {
		  if(!IsWeb(u))
    		notice_lang(s_NickServ, u, DISCONNECT_IN_1_MINUTE);
		add_ns_timeout(ni, TO_COLLIDE, 60);
	    }
	}
    } else {
	  	if(!IsWeb(u))
		  notice_lang(s_NickServ, u, CHANGE_IN_1_MINUTE);
        add_ns_timeout(ni, TO_COLLIDE, 60);
    }
    return 0;
}

/*************************************************************************/

/* Cancel validation flags for a nick (i.e. when the user with that nick
 * signs off or changes nicks).  Also cancels any impending collide. */

void cancel_user(User *u)
{
    NickInfo *ni = u->real_ni;
    if (ni) {
	ni->status &= ~NS_TEMPORARY;
	u->mode &= ~UMODE_r;
	del_ns_timeout(ni, TO_COLLIDE);
    }
}

/*************************************************************************/

/* Return whether a user has identified for their nickname. */

int nick_restrict_identified(User *u)
{
    return u->real_ni && (u->real_ni->status & NS_IDENTIFIED);
}
/*************************************************************************/

/* Return whether a user has identified for their nickname. 
    +r will count as identified --Lamego */

int nick_identified(User *u)
{
    return (u->real_ni && ((u->real_ni->status & NS_IDENTIFIED) 
    || (u->mode & UMODE_r)));    
}

/*************************************************************************/

/* Return whether a user is recognized for their nickname. */
/* REPLACED with a macro
int nick_recognized(User *u)
{
    return (u->real_ni && ((u->real_ni->status & (NS_IDENTIFIED | NS_RECOGNIZED))
    || (u->mode & UMODE_r)));
}
*/
/*************************************************************************/

/* Return was recognized via umode +r. */
int nick_recon(User *u)
{
    return (u->mode & UMODE_r);
}
/*************************************************************************/

/* Remove all nicks which have expired.  Also update last-seen time for all
 * nicks.
 */

void expire_nicks()
{
    User *u;
    NickInfo *ni, *next;
    int i;
    time_t now = time(NULL);

    /* Assumption: this routine takes less than NSExpire seconds to run.
     * If it doesn't, some users may end up with invalid user->ni pointers. */
    for (u = hash_next_user(1); u; u = hash_next_user(0)) {
	if (u->real_ni) {
	    if (debug >= 2)
		log1("debug: NickServ: updating last seen time for %s", u->nick);
	    u->real_ni->last_seen = time(NULL);
	}
    }
    if (!NSExpire)
	  return;
    for (i = 0; i < N_MAX; i++) {
	for (ni = nicklists[i]; ni; ni = next) {
	    next = ni->next;
	    if ((now - ni->last_seen >= NSExpire)
		    && !(ni->status & (NS_VERBOTEN | NS_NO_EXPIRE))) {
		log2c("Expiring nickname %s", ni->nick);
		DayStats.ns_total--;
		DayStats.ns_expired++;		
		delnick(ni);
	    } else 
	    if (NSRegExpire && (ni->last_identify==ni->time_registered)
		    && (now - ni->time_registered >= NSRegExpire)
		    && !(ni->status & (NS_VERBOTEN | NS_NO_EXPIRE))) {
		log2c("Expiring never identified nick %s", ni->nick);
		DayStats.ns_total--;
		DayStats.ns_expired++;
		delnick(ni);		
	    } else 	    	    
	    if ((ni->flags & NI_DROPPED) && (now - ni->last_identify >= NSDropDelay)) {
		User *u2=finduser(ni->nick);
		log2c("Executing drop on nick %s", ni->nick);
		DayStats.ns_total--;
		DayStats.ns_dropped++;
		delnick(ni);
		if(u2)
		    u2->ni=u2->real_ni=NULL;
	    }	    
	}
    }
}

/*************************************************************************/
/*************************************************************************/

/* Return the NickInfo structure for the given nick, or NULL if the nick
 * isn't registered. */

NickInfo *findnick(const char *nick)
{
    NickInfo *ni;
    u_int32_t hashv = ns_hash_nick_name(nick);
    for (ni = nicklists[hashv]; ni; ni = ni->next) {
	if (irccmp(ni->nick, nick) == 0)
	    return ni;
    }
    return NULL;
}

/*************************************************************************/

/* Return the "master" nick for the given nick; i.e., trace the linked list
 * through the `link' field until we find a nickname with a NULL `link'
 * field.  Assumes `ni' is not NULL.
 *
 * Note that we impose an arbitrary limit of 512 nested links.  This is to
 * prevent infinite loops in case someone manages to create a circular
 * link.  If we pass this limit, we arbitrarily cut off the link at the
 * initial nick.
 */

NickInfo *getlink(NickInfo *ni)
{
    NickInfo *orig = ni;
    int i = 0;

    while (ni->link && ++i < 512)
	ni = ni->link;
    if (i >= 512) {
	log1("%s: Infinite loop(?) found at nick %s for nick %s, cutting link",
		s_NickServ, ni->nick, orig->nick);
	orig->link = NULL;
	ni = orig;
	/* FIXME: we should sanitize the data fields */
    }
    return ni;
}

/*************************************************************************/
/*********************** NickServ private routines ***********************/
/*************************************************************************/

/*************************************************************************/

/* Insert a nick into nickserv hash table */

static void insert_nick(NickInfo *ni)
{
    NickInfo *head;
    char *nick = ni->nick;
    u_int32_t	hashv = ns_hash_nick_name(nick);    
    head = nicklists[hashv];
    if(head)
      head->prev = ni;
          
    ni->next = head;
    ni->prev = NULL;
    nicklists[hashv] = ni;
}


/*************************************************************************/

/* Add a nick to the database.  Returns a pointer to the new NickInfo
 * structure if the nick was successfully registered, NULL otherwise.
 * Assumes nick does not already exist.
 */

static NickInfo *makenick(const char *nick)
{
    NickInfo *ni;
    ni = scalloc(sizeof(NickInfo), 1);
    strscpy(ni->nick, nick, NICKMAX);
    ni->notes.max = NSMaxNotes;
    ni->notes.note = scalloc(NSMaxNotes, sizeof(char*));
    ni->snid = ++last_snid;
    insert_nick(ni);
    return ni;
}

/*************************************************************************/

/* Remove a nick from the NickServ database.  Return 1 on success, 0
 * otherwise.  Also deletes the nick from any ChanServ/OperServ lists it is
 * on.
 */

static int delnick(NickInfo *ni)
{
    int i;
    u_int32_t hashv = ns_hash_nick_name(ni->nick);
    
    cs_remove_nick(ni);
    os_remove_nick(ni);
    if (ni->linkcount)
	remove_links(ni);
    if (ni->link)
	ni->link->linkcount--;
    if (ni->next)
	ni->next->prev = ni->prev;
    if (ni->prev)
	ni->prev->next = ni->next;
    else
	nicklists[hashv] = ni->next;
    if (ni->last_usermask)
	free(ni->last_usermask);
    if (ni->last_realname)
	free(ni->last_realname);
    if(ni->url)
      free(ni->url);
    if(ni->email);
      free(ni->email);      
    if(ni->email_request);
     free(ni->email_request); 
    if(ni->icq_number)
      free(ni->icq_number);
    if(ni->location)
      free(ni->location);
    if(ni->last_quit)
      free(ni->last_quit);
    if (ni->autojoin) {
	for (i = 0; i < ni->ajoincount; i++) {
	    if (ni->autojoin[i])
		free(ni->autojoin[i]);
	}
	free(ni->autojoin);
    }    
    if (ni->memos.memos) {
	for (i = 0; i < ni->memos.memocount; i++) {
	    if (ni->memos.memos[i].text)
		free(ni->memos.memos[i].text);
	}
	free(ni->memos.memos);
    }
    if (ni->notes.count) {
	for (i = 0; i < ni->notes.count; i++) 
	    if(ni->notes.note[i])
		free(ni->notes.note[i]);
    }
    free(ni->notes.note);
    del_ns_timeout(ni, TO_COLLIDE);
    del_ns_timeout(ni, TO_RELEASE);    
    free(ni);
    return 1;
}

/*************************************************************************/

/* Remove any links to the given nick (i.e. prior to deleting the nick).
 * Note this is currently linear in the number of nicks in the database--
 * that's the tradeoff for the nice clean method of keeping a single parent
 * link in the data structure.
 */

static void remove_links(NickInfo *ni)
{
    u_int32_t i;
    NickInfo *ptr;

    for (i = 0; i < N_MAX; i++) {
	for (ptr = nicklists[i]; ptr; ptr = ptr->next) {
	    if (ptr->link == ni) {
		if (ni->link) {
		    ptr->link = ni->link;
		    ni->link->linkcount++;
		} else
		    delink(ptr);
	    }
	}
    }
}

/*************************************************************************/

/* Break a link from the given nick to its parent. */

void delink(NickInfo *ni)
{
    NickInfo *link;

    link = ni->link;
    ni->link = NULL;
    do {
	link->channelcount -= ni->channelcount;
	if (link->link)
	    link = link->link;
    } while (link->link);
    ni->status = link->status;
    link->status &= ~NS_TEMPORARY;
    ni->flags = link->flags;
    ni->channelmax = link->channelmax;
    ni->memos.memomax = link->memos.memomax;
    ni->language = link->language;
    if (link->ajoincount > 0) {
	char **ajoin;
	int i;
	
	ni->ajoincount = link->ajoincount;
	ajoin = smalloc(sizeof(char *) * ni->ajoincount);
	ni->autojoin = ajoin;
	for (i = 0; i < ni->ajoincount; i++, ajoin++)
	    *ajoin = sstrdup(link->autojoin[i]);
    }
    
    link->linkcount--;
}

/*************************************************************************/
void autojoin(User *u)
{
    char** autojoin;
    char chans [512]; /* Should be large enougth to NSAJoinMax * MAXCHANLEN +"SVSJOIN nick" */
    int i;
    chans[0]='\0';    
    for (autojoin = u->ni->autojoin, i = 0; i < u->ni->ajoincount; autojoin++, i++) {
	strcat(chans, *autojoin);
	strcat(chans,",");
    }
    send_cmd(s_NickServ, "SVSJOIN %s %s", u->nick,chans);
}

/*************************************************************************/

/* Collide a nick. */

static void collide(NickInfo *ni, int from_timeout)
{
    static int nickdig = 1;
    char buf[IRCDNICKMAX+8];
    char buf2[IRCDNICKMAX+8]; 
    User *u;
    if (!from_timeout)
	del_ns_timeout(ni, TO_COLLIDE);
    if(NickChange && !(ni->flags & NI_KILLPROTECT)) {
    	if(GuestPrefix)
    	  {
	    if(++(ni->forcednicks)>=NSMaxNChange) {
		ni->forcednicks=0;
	    	kill_user(s_NickServ, ni->nick, "Please identify yourself");
		chanlog("Nick %s exceeded non identify limit.",ni->nick);
	    }
	    else
    	      send_cmd(s_NickServ,"SVSGUEST %s %s %d",
    	        ni->nick, GuestPrefix, 999);
    	    return ;
    	  }
	sprintf(buf2,"_%s-", ni->nick); 
	sprintf(buf,"%s%.3i",buf2, ++nickdig);
	while((u = finduser(buf)) && nickdig<1000 && (strlen(buf)<IRCDNICKMAX)) {
	    sprintf(buf,"%s%.3i", buf2, nickdig++);
	}
	if ((strlen(buf)>=IRCDNICKMAX) || (nickdig>999)) {
	    kill_user(s_NickServ, ni->nick, "Nick kill enforced");
	    if(nickdig>999)
	      nickdig = 0;	    
	    else
	    {
    	      send_cmd(NULL, "NICK %s 1 %lu %s %s %s %s %s :NickServ Enforcer",
		ni->nick, time(NULL), "+i", NSEnforcerUser, NSEnforcerHost,
		NSEnforcerHost, ServerName);
	      ni->status |= NS_KILL_HELD;
    	      add_ns_timeout(ni, TO_RELEASE, NSReleaseTimeout);		
    	    }
	} else {
	    if(++(ni->forcednicks)>=NSMaxNChange) {
		ni->forcednicks=0;
	    	kill_user(s_NickServ, ni->nick, "Please identify yourself");
		chanlog("Nick %s exceeded non identify limit.",ni->nick);
	    }
	    else
	    {
		send_cmd(s_NickServ,"SVSNICK %s %s :0",
		  ni->nick,buf);
	    }
	}
    } else {
	kill_user(s_NickServ, ni->nick, "Nick kill enforced");
    	send_cmd(NULL, "NICK %s 1 %lu %s %s %s %s %s :NickServ Enforcer",
	    ni->nick, (unsigned long int) time(NULL), "+i", NSEnforcerUser, NSEnforcerHost,
	    NSEnforcerHost, ServerName);
	ni->status |= NS_KILL_HELD;
	add_ns_timeout(ni, TO_RELEASE, NSReleaseTimeout);		
    }
}

/*************************************************************************/

/* Release hold on a nick. */

static void release(NickInfo *ni, int from_timeout)
{
    if (!from_timeout)
	del_ns_timeout(ni, TO_RELEASE);
    send_cmd(ni->nick, "QUIT");
    ni->status &= ~NS_KILL_HELD;
}

/*************************************************************************/
/*************************************************************************/

static struct my_timeout {
    struct my_timeout *next, *prev;
    NickInfo *ni;
    Timeout *to;
    int type;
} *my_timeouts;

/*************************************************************************/

/* Remove a collide/release timeout from our private list. */

static void rem_ns_timeout(NickInfo *ni, int type)
{
    struct my_timeout *t, *t2;

    t = my_timeouts;
    while (t) {
	if (t->ni == ni && t->type == type) {
	    t2 = t->next;
	    if (t->next)
		t->next->prev = t->prev;
	    if (t->prev)
		t->prev->next = t->next;
	    else
		my_timeouts = t->next;
	    free(t);
	    t = t2;
	} else {
	    t = t->next;
	}
    }
}

/*************************************************************************/

/* Collide a nick on timeout. */

static void timeout_collide(Timeout *t)
{
    NickInfo *ni = t->data;
    User *u;

    rem_ns_timeout(ni, TO_COLLIDE);
    /* If they identified or don't exist anymore, don't kill them. */
    if ((ni->status & NS_IDENTIFIED) 
		|| !(u = finduser(ni->nick))		
		|| u->local_TS > t->settime
		|| (u->mode & UMODE_r)
		)
	return;
    /* The RELEASE timeout will always add to the beginning of the
     * list, so we won't see it.  Which is fine because it can't be
     * triggered yet anyway. */
    collide(ni, 1);
}

/*************************************************************************/

/* Release a nick on timeout. */

static void timeout_release(Timeout *t)
{
    NickInfo *ni = t->data;

    rem_ns_timeout(ni, TO_RELEASE);
    release(ni, 1);
}

/*************************************************************************/

/* Add a collide/release timeout. */

static void add_ns_timeout(NickInfo *ni, int type, time_t delay)
{
    Timeout *to;
    struct my_timeout *t;
    void (*timeout_routine)(Timeout *);

    if (type == TO_COLLIDE)
	timeout_routine = timeout_collide;
    else if (type == TO_RELEASE)
	timeout_routine = timeout_release;
    else {
	log1("NickServ: unknown timeout type %d!  ni=%p (%s), delay=%ld",
		type, ni, ni->nick, (long int) delay);
	return;
    }
    to = add_timeout(delay, timeout_routine, 0);
    to->data = ni;
    t = smalloc(sizeof(*t));
    t->next = my_timeouts;
    my_timeouts = t;
    t->prev = NULL;
    t->ni = ni;
    t->to = to;
    t->type = type;
}

/*************************************************************************/

/* Delete a collide/release timeout. */

static void del_ns_timeout(NickInfo *ni, int type)
{
    struct my_timeout *t, *t2;

    t = my_timeouts;
    while (t) {
	if (t->ni == ni && t->type == type) {
	    t2 = t->next;
	    if (t->next)
		t->next->prev = t->prev;
	    if (t->prev)
		t->prev->next = t->next;
	    else
		my_timeouts = t->next;
	    del_timeout(t->to);
	    free(t);
	    t = t2;
	} else {
	    t = t->next;
	}
    }
}

/*************************************************************************/
/*********************** NickServ command routines ***********************/
/*************************************************************************/

/* Return a help message. */

static void do_help(User *u)
{
    char *cmd = strtok(NULL, "");

    if (!cmd) {
	if (NSExpire >= 86400)
	    notice_help(s_NickServ, u, NICK_HELP, NSExpire/86400);
	else
	    notice_help(s_NickServ, u, NICK_HELP_EXPIRE_ZERO);
	if (is_services_oper(u))
	    notice_help(s_NickServ, u, NICK_SERVADMIN_HELP);
    } else if (strcasecmp(cmd, "SET LANGUAGE") == 0) {
	int i;
	notice_help(s_NickServ, u, NICK_HELP_SET_LANGUAGE);
	for (i = 0; i < NUM_LANGS && langlist[i] >= 0; i++) {
	    if(u->is_msg)
	      privmsg(s_NickServ, u->nick, "    %2d) %s",
	                i+1, langnames[langlist[i]]);
	    else
	      notice(s_NickServ, u->nick, "    %2d) %s",
			i+1, langnames[langlist[i]]);
	}
    } else {
	help_cmd(s_NickServ, u, cmds, cmd);
    }
}

/*************************************************************************/

/* Register a nick. */

static void do_register(User *u)
{
    NickInfo *ni;
    char *pass = strtok(NULL, " ");
    char *email = strtok(NULL, " ");
    if (readonly) 
	  {
		notice_lang(s_NickServ, u, NICK_REGISTRATION_DISABLED);
		return;
  	  }
    if (!pass || (NSNeedEmail && !email) || (strcasecmp(pass, u->nick) == 0 && strtok(NULL, " "))) {
	syntax_error(s_NickServ, u, "REGISTER", NICK_REGISTER_SYNTAX);
    } else if (time(NULL) - u->lastnickreg < NSRegDelay) {
	notice_lang(s_NickServ, u, NICK_REG_PLEASE_WAIT, NSRegDelay);
    } else if ((strlen(u->nick)>1) && (u->nick[0]=='_') 
	    && (u->nick[strlen(u->nick)-1]=='-')) {
	notice_lang(s_NickServ, u, NICK_CANNOT_BE_REGISTERED, u->nick);
    } else if(GuestPrefix && 
    	!strncasecmp(u->nick, GuestPrefix, strlen(GuestPrefix))) {
	    notice_lang(s_NickServ, u, NICK_CANNOT_BE_REGISTERED, u->nick);
    } else if ((strcasecmp(u->nick, pass) == 0)
		|| (StrictPasswords && strlen(pass) < 5)) {
	notice_lang(s_NickServ, u, MORE_OBSCURE_PASSWORD);
    } else if (email && (NSDisableNOMAIL || strcasecmp(email,"NOMAIL")) && !is_email(email)) {
	notice_lang(s_NickServ, u, BAD_EMAIL_ADDRESS);
	if(NSDisableNOMAIL && email &&  (strcasecmp(email, "NOMAIL")==0))
	    notice_lang(s_NickServ, u, NOMAIL_DISABLED);
    } else if (u->real_ni) {
	if (u->real_ni->status & NS_VERBOTEN) {
	    log2c("%s: %s@%s tried to register FORBIDden nick %s", s_NickServ,
			u->username, u->host, u->nick);
	    notice_lang(s_NickServ, u, NICK_CANNOT_BE_REGISTERED, u->nick);				    			
	    } 
    	    else notice_lang(s_NickServ, u, NICK_ALREADY_REGISTERED, u->nick);	
    } else {
	ni = makenick(u->nick);
	if (ni) {
	    int len = strlen(pass);
	    if (len > PASSMAX-1) {
		len = PASSMAX-1;
		pass[len] = 0;
		notice_lang(s_NickServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
	    }
	    if (encrypt(pass, len, ni->pass, PASSMAX) < 0) {
		memset(pass, 0, strlen(pass));
		log1("%s: Failed to encrypt password for %s (register)",
			s_NickServ, u->nick);
		notice_lang(s_NickServ, u, NICK_REGISTRATION_FAILED);
	        free(ni);
		return;
	    }	    
	    ni->status = NS_IDENTIFIED | NS_RECOGNIZED;
	    ni->crypt_method=EncryptMethod;
	    if(email && strcasecmp(email,"NOMAIL")) ni->email_request = sstrdup(email);
		else ni->email = ni->email_request = NULL;
	    ni->flags = NI_NEWSLETTER;
	    ni->news_mask = NM_ALL;
	    if (NSDefKill)
		ni->flags |= NI_KILLPROTECT;
	    if (NSDefKillQuick)
		ni->flags |= NI_KILL_QUICK;
	    if (NSDefPrivate)
		ni->flags |= NI_PRIVATE;
	    if (NSDefHideEmail)
		ni->flags |= NI_HIDE_EMAIL;
	    if (NSDefHideQuit)
		ni->flags |= NI_HIDE_QUIT;
	    if (NSDefMemoSignon)
		ni->flags |= NI_MEMO_SIGNON;
	    if (NSDefMemoReceive)
		ni->flags |= NI_MEMO_RECEIVE;
	    ni->memos.memomax = MSMaxMemos;
	    ni->channelcount = 0;
	    ni->channelmax = CSMaxReg;
	    ni->flags |= NI_AUTO_JOIN;
	    ni->last_usermask = smalloc(strlen(u->username)+strlen(u->host)+2);
	    sprintf(ni->last_usermask, "%s@%s", u->username, u->host);
	    ni->last_realname = sstrdup(u->realname);
	    ni->time_registered = ni->last_identify = ni->last_seen = time(NULL);
	    ni->ajoincount = 0;
	    ni->autojoin = NULL;	    
	    ni->language = u->language;
	    ni->link = NULL;
	    u->ni = u->real_ni = ni;
	    ni->forcednicks = 0;
	    if(!NSNeedAuth)
	    send_cmd(s_NickServ, "SVSMODE %s +rn %u", u->nick,
	  	  ni->news_mask);
	    ni->last_signon = time(NULL);
	    ni->first_TS = u->first_TS;
	    log2c("%s: `%s' registered by %s@%s [%s]", s_NickServ,
			u->nick, u->username, u->host,email ? email : "NOMAIL");			
		/* +r on nick register - Lamego 1999 */
	    notice_lang(s_NickServ, u, NICK_REGISTERED, u->nick, ni->last_usermask);
	    DayStats.ns_registered++;
	    DayStats.ns_total++;
	    notice_lang(s_NickServ, u, NICK_PASSWORD_IS, pass);
	    rand_string(ni->auth, AUTHMAX-1, AUTHMAX-1);
	    if(NSNeedAuth && email && strcasecmp(email,"NOMAIL"))
	      {    
	        send_auth_email(ni, pass);	    
	    	notice_lang(s_NickServ, u, NICK_AUTH_SENT);
	      }
	    memset(pass, 0, strlen(pass));
	    u->lastnickreg = time(NULL);
	} else {
	    log2c("%s: makenick(%s) failed", s_NickServ, u->nick);
	    notice_lang(s_NickServ, u, NICK_REGISTRATION_FAILED);
	}

    }
 
}

/*************************************************************************/

static void do_identify(User *u)
{
    char *pass = strtok(NULL, " ");
	char *fromhost = NULL;
    NickInfo *rni,*ni;
    int res;
    int nojoin = 0;
    time_t drop_time;
	
	if (pass)
	  fromhost = strtok(NULL, " ");
	  
    if (!pass) 
		syntax_error(s_NickServ, u, "IDENTIFY", NICK_IDENTIFY_SYNTAX);
	else if (!(rni = u->real_ni)) 
		notice(s_NickServ, u->nick, "Your nick isn't registered.");
	else if (rni->status & NS_VERBOTEN)
	  {
		log2c("%s: %s@%s tried to identify FORBIDden nick %s", s_NickServ,
			u->username, u->host, u->nick);
	  	  notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, u->nick);
	  }
    else if (rni->status & NS_IDENTIFIED) 
		notice_lang(s_NickServ, u, NICK_ALREADY_IDENTIFIED);
	else if (!(res = check_password(pass, rni->pass,rni->crypt_method))) 
	  {
		log2c("%s: Failed IDENTIFY for %s!%s@%s",
			s_NickServ, u->nick, u->username, u->host);
		notice_lang(s_NickServ, u, PASSWORD_INCORRECT);
		bad_password(u);

  	  } 
	else if (res == -1) 
	  notice_lang(s_NickServ, u, NICK_IDENTIFY_FAILED);	  	
    else 
	  {
		ni = u->ni;
		rni->forcednicks = 0; /* reset forced nicks */
		rni->status |= NS_IDENTIFIED;
		u->language = ni->language;
		u->is_msg = (ni->flags & NI_PRIVMSG);
		drop_time = rni->last_identify;	
		
		if (!(rni->status & NS_RECOGNIZED)) 
		  {
	  		rni->last_seen = rni->last_identify = time(NULL);
	  		if (rni->last_usermask)
			free(rni->last_usermask);
		    rni->last_usermask = smalloc(strlen(u->username)+strlen(u->host)+2);
		    sprintf(rni->last_usermask, "%s@%s", u->username, u->host);
		    if (rni->last_realname)
			free(rni->last_realname);
		    rni->last_realname = sstrdup(u->realname);
		  }
		  
		if(rni->crypt_method != EncryptMethod) 
		  {
	  		strncpy(rni->pass,pass,PASSMAX-1);
		    if(encrypt_in_place(rni->pass, PASSMAX)<0) 
			  {
				log2c("%s: Couldn't encrypt password for %s (IDENTIFY)",
					s_NickServ, rni->nick);
	  			return;
	  		  }
			  
	  	    rni->crypt_method = EncryptMethod;
		    log2c("%s: %s!%s@%s identified for nick %s with encryption change to %i", s_NickServ,
					u->nick, u->username, u->host, u->nick, EncryptMethod);
	  	  } 
		else {
		if(IsWeb(u) && fromhost)
		  log2c("%s: %s!WebServices@%s identified for nick %s from web", s_NickServ,
			u->nick, fromhost, u->nick);
		else
	  	  log2c("%s: %s!%s@%s identified for nick %s", s_NickServ,
			u->nick, u->username, u->host, u->nick);
		}	
	if(NSNeedAuth && !ni->email)
	  notice_lang(s_NickServ, u, NICK_AUTH_NEEDED, s_NickServ);
	else
	  {
	    if(ni->flags & NI_PRIVATE)
	      send_cmd(s_NickServ, "SVSMODE %s +prn %u", u->nick,
	        ni->news_mask);
	    else	    
	      send_cmd(s_NickServ, "SVSMODE %s +rn %u", u->nick,
	        ni->news_mask);	      
	  }

	ni->last_signon = time(NULL);
	ni->first_TS = u->first_TS;
		
	if(!IsWeb(u))
	  notice_lang(s_NickServ, u, NICK_IDENTIFY_SUCCEEDED);
			
        if(rni->flags & NI_DROPPED) 
		  {
	  		char buf[BUFSIZE];
	        struct tm *tm;
	        rni->flags &= ~NI_DROPPED;
  			tm = localtime(&drop_time);
	        strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
			notice_lang(s_NickServ, u, NICK_DROP_CANCEL, buf);
			log2c("%s: %s!%s@%s canceled drop on identify", s_NickServ,
				u->nick, u->username, u->host);
	  	  }
		if(fromhost && (strcasecmp(fromhost,"NOJOIN")==0))
			nojoin = -1;
		if ((nojoin==0) && !IsBot(u) && (ni->flags & NI_AUTO_JOIN) && (ni->ajoincount>0)) 
			autojoin(u);
        check_memos(u);
    }
}

/*************************************************************************/

static void do_drop(User *u)
{
    char *nick  = strtok(NULL, " ");
    char *extra = strtok(NULL, " ");
    NickInfo *ni;
    User *u2;
    int is_sadmin = is_services_admin(u);
    if (readonly && !is_sadmin) {
	notice_lang(s_NickServ, u, NICK_DROP_DISABLED);
	return;
    }

    if (!is_sadmin && nick) {
	syntax_error(s_NickServ, u, "DROP", NICK_DROP_SYNTAX);

    } else if (!(ni = (nick ? findnick(nick) : u->real_ni))) {
	if (nick)
	    notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
	else
	    notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);

    } else if (!nick && !nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
    } else if (NSSecureAdmins && is_services_admin_nick(ni)) {   
        log1("%s: %s!%s@%s trying DROP on SADM nick %s",
                        s_NickServ, u->nick, u->username, u->host, ni->nick);
            sanotice(s_NickServ,"%s!%s@%s trying DROP on SADM!!! %s",
                    u->nick, u->username, u->host, ni->nick);
    } else {
	if (readonly)
	    notice_lang(s_NickServ, u, READ_ONLY_MODE);
	if(NSDropDelay && !(is_sadmin && extra && !strcasecmp(extra,"NOW"))) {
	    log2c("%s: %s!%s@%s drop request for nickname %s", s_NickServ,
		u->nick, u->username, u->host, nick ? nick : u->nick);
	    ni->flags |= NI_DROPPED;
	    ni->last_identify = time(NULL);
	    notice_lang(s_NickServ, u, NICK_DROP_AT,NSDropDelay/86400);
	}
	else {
	    delnick(ni);
	    log2c("%s: %s!%s@%s dropped nickname %s", s_NickServ,
		u->nick, u->username, u->host, nick ? nick : u->nick);
	    DayStats.ns_dropped++;
	    DayStats.ns_total--;	
	    if (nick) {
		notice_lang(s_NickServ, u, NICK_X_DROPPED, nick);
		send_cmd(s_NickServ, "SVSMODE %s -r", nick);
	    } else {
		notice_lang(s_NickServ, u, NICK_DROPPED);
		send_cmd(s_NickServ, "SVSMODE %s -r", u->nick);
	    }
	    if (nick && (u2 = finduser(nick)))
		u2->ni = u2->real_ni = NULL;
	    else if (!nick)
		u->ni = u->real_ni = NULL;
	}
    }
}

/*************************************************************************/

static void do_set(User *u)
{
    char *cmd = NULL;
    char *param = NULL;
    NickInfo *ni;
    int is_servadmin = is_services_admin(u);
    int set_nick = 0;
    cmd = strtok(NULL, " ");
    if(cmd)
      {
        if (strcasecmp(cmd,"LOCATION")!=0) {
          param = strtok(NULL, " ");
        } else {
	  param = strtok(NULL, "");
        };
      } 
      
    if (readonly) {
	notice_lang(s_NickServ, u, NICK_SET_DISABLED);
	return;
    }

    if (is_servadmin && cmd && (ni = findnick(cmd))) {
	cmd = param;
	param = strtok(NULL, " ");
	set_nick = 1;
    } else {
	ni = u->ni;
    }
    
    if (!param && (!cmd || (strcasecmp(cmd,"URL")!=0 && strcasecmp(cmd,"EMAIL")!=0
    && (strcasecmp(cmd,"ICQNUMBER")!=0) && (strcasecmp(cmd,"LOCATION")!=0) ))){
	if (is_servadmin) {
	    syntax_error(s_NickServ, u, "SET", NICK_SET_SERVADMIN_SYNTAX);
	} else {
	    syntax_error(s_NickServ, u, "SET", NICK_SET_SYNTAX);
	}
	notice_lang(s_NickServ, u, MORE_INFO, s_NickServ, "SET");
    } else if (strcasecmp(cmd, "LANGUAGE") == 0) {
	do_set_language(u, ni, param);
    } else if (!ni) {
	notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);
    } else if (!is_servadmin && !nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
    } else if (strcasecmp(cmd, "PASSWORD") == 0) {
	do_set_password(u, set_nick ? ni : u->real_ni, param);
    } else if (strcasecmp(cmd, "URL") == 0) {
	do_set_url(u, set_nick ? ni : u->real_ni, param);
    } else if (strcasecmp(cmd, "EMAIL") == 0) {
	do_set_email(u, set_nick ? ni : u->real_ni, param);
    } else if (strcasecmp(cmd, "ICQNUMBER") == 0) {
	do_set_icqnumber(u, set_nick ? ni : u->real_ni, param);	
    } else if (strcasecmp(cmd, "LOCATION") == 0) {
	do_set_location(u, set_nick ? ni : u->real_ni, param);		
    } else if (strcasecmp(cmd, "KILL") == 0) {
	do_set_kill(u, ni, param);
    } else if (strcasecmp(cmd, "PRIVATE") == 0) {
	do_set_private(u, ni, param);
    } else if (strcasecmp(cmd, "NEWSLETTER") == 0) {
	do_set_newsletter(u, ni, param);	
    } else if (strcasecmp(cmd, "AUTOJOIN") == 0) {
	do_set_autojoin(u, ni, param);
    } else if (strcasecmp(cmd, "PRIVMSG") == 0) {
	do_set_privmsg(u, ni, param);
    } else if (strcasecmp(cmd, "HIDE") == 0) {
	do_set_hide(u, ni, param);
    } else if (strcasecmp(cmd, "NOEXPIRE") == 0) {
	do_set_noexpire(u, ni, param);
    } else {
	if (is_servadmin)
	    notice_lang(s_NickServ, u, NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK,
			strupper(cmd));
	else
	    notice_lang(s_NickServ, u, NICK_SET_UNKNOWN_OPTION, strupper(cmd));
    }
}

/*************************************************************************/

static void do_set_password(User *u, NickInfo *ni, char *param)
{
    int len = strlen(param);
    if (strcasecmp(ni->nick, param) == 0 || (StrictPasswords && len < 5)) {
	notice_lang(s_NickServ, u, MORE_OBSCURE_PASSWORD);
	return;
    }
    if (len > PASSMAX-1 ) {
        len = PASSMAX-1;
        param[len] = 0;
        notice_lang(s_NickServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
    }
    if (encrypt(param, len, ni->pass, PASSMAX) < 0) {
        memset(param, 0, strlen(param));
	log2c("%s: Failed to encrypt password for %s (set)",
		s_NickServ, ni->nick);
        notice_lang(s_NickServ, u, NICK_SET_PASSWORD_FAILED);
        return;
    }
    ni->crypt_method = EncryptMethod;
    if(u->real_ni != ni)
	notice_lang(s_NickServ, u, NICK_SET_PASSWORD_SADMIN_CHANGED_TO, ni->nick, param);
    else
	notice_lang(s_NickServ, u, NICK_SET_PASSWORD_CHANGED_TO,param);    
    memset(param, 0, strlen(param));
    if (u->real_ni != ni) {
    if (NSSecureAdmins && is_services_admin_nick(ni)) {
        log1("%s: %s!%s@%s trying SET PASSWORD on SADM nick %s",
                        s_NickServ, u->nick, u->username, u->host, ni->nick);
	    sanotice(s_NickServ,"%s!%s@%s trying SET PASSWORD on SADM!!! %s",
	            u->nick, u->username, u->host, ni->nick);             
	return;
    }
	log2c("%s: %s!%s@%s used SET PASSWORD as Services admin on %s",
		s_NickServ, u->nick, u->username, u->host, ni->nick);
	sanotice(s_NickServ,"%s!%s@%s used SET PASSWORD as Services admin on %s",
		 u->nick, u->username, u->host, ni->nick);
	if (WallSetpass) {
	    wallops(s_NickServ, "\2%s\2 used SET PASSWORD as Services admin "
			"on \2%s\2", u->nick, ni->nick);
	}
    } else
	    log2c("%s: %s!%s@%s changed password",s_NickServ, u->nick, u->username, u->host);
}

/*************************************************************************/

static void do_set_language(User *u, NickInfo *ni, char *param)
{
    int langnum;

    if (param[strspn(param, "0123456789")] != 0) {  /* i.e. not a number */
	syntax_error(s_NickServ, u, "SET LANGUAGE", NICK_SET_LANGUAGE_SYNTAX);
	return;
    }
    langnum = atoi(param)-1;
    if (langnum < 0 || langnum >= NUM_LANGS || langlist[langnum] < 0) {
	notice_lang(s_NickServ, u, NICK_SET_LANGUAGE_UNKNOWN,
		langnum+1, s_NickServ);
	return;
    }
    
    log2c("%s: %s SET LANGUAGE %i", s_NickServ, u->nick, langnum+1);
    
    if(ni) 
      ni->language = langlist[langnum];
    
    u->language = langlist[langnum];
	notice_lang(s_NickServ, u, NICK_SET_LANGUAGE_CHANGED);
}

/*************************************************************************/

static void do_set_url(User *u, NickInfo *ni, char *param)
{
    if (ni->url)
	free(ni->url);
    if (param) {
	if(u->real_ni != ni)
	    log2c("%s: %s used SET URL on %s and set to: %s", s_NickServ, u->nick, ni->nick, param);
	else
    	    log2c("%s: %s SET URL %s", s_NickServ, u->nick, param);    
	ni->url = sstrdup(param);
	if(u->real_ni != ni)
	    notice_lang(s_NickServ, u, NICK_SET_URL_SADMIN_CHANGE, ni->nick, param);
	else
	    notice_lang(s_NickServ, u, NICK_SET_URL_CHANGED, param);
    } else {
	ni->url = NULL;
	if(u->real_ni != ni)
	    notice_lang(s_NickServ, u, NICK_SET_URL_SADMIN_UNSET, ni->nick);
	else
	    notice_lang(s_NickServ, u, NICK_SET_URL_UNSET);
    }
}

/*************************************************************************/

static void do_set_email(User *u, NickInfo *ni, char *param)
{
    if (param && (NSDisableNOMAIL || strcasecmp(param,"NOMAIL"))) {
	if(NSDisableNOMAIL && param && (strcasecmp(param, "NOMAIL")==0))
	    notice_lang(s_NickServ, u, NOMAIL_DISABLED);
	else if (is_email(param)) {
          if((!is_services_admin(u)) && (time(NULL)-ni->last_email_request<24*60*60))
            {
              notice_lang(s_NickServ, u, NICK_SET_EMAIL_WAIT);
              return;
            }
            if(u->real_ni != ni)
	        log2c("%s: %s used SET EMAIL on %s and set to: %s", s_NickServ, u->nick, ni->nick, param);
	    else
	        log2c("%s: %s SET EMAIL %s", s_NickServ, u->nick, param);
	    if(ni->email_request) 
	      free(ni->email_request);
	    ni->email_request = sstrdup(param);
	    if(!NSNeedAuth)
	      ni->email = sstrdup(param);
	    ni->last_email_request = time(NULL);
	    rand_string(ni->auth, AUTHMAX-1, AUTHMAX-1);
	    if(NSNeedAuth)
	      {    
	        send_setemail(ni);	    	    
	        notice_lang(s_NickServ, u, NICK_SET_EMAIL_AUTH, param);
	      }
	    else
	      if(u->real_ni != ni)
		notice_lang(s_NickServ, u, NICK_SET_EMAIL_SADMIN_CHANGE, ni->nick, param);
	      else	
	        notice_lang(s_NickServ, u, NICK_SET_EMAIL_CHANGED, param);
	} else       
	    notice_lang(s_NickServ, u, BAD_EMAIL_ADDRESS);
    }	    	
    else
    { 
    	if(NSNeedAuth) 
    	  return;
	if(ni->email) 
	  free(ni->email);
	if(ni->email_request) 
	  free(ni->email_request);	  
	ni->email = NULL;
	ni->email_request = NULL;
	notice_lang(s_NickServ, u, NICK_SET_EMAIL_UNSET);
    }
}

static void do_set_icqnumber(User *u, NickInfo *ni, char *param)
{
    if (param) {
        if (param[0]!='#' || (strlen(param)>20) || (strlen(param)<2)) {
	    notice_lang(s_NickServ, u, BAD_ICQNUMBER);
	} else {
	    if(ni->icq_number) free(ni->icq_number);
	    ni->icq_number = sstrdup(&param[1]);
	    notice_lang(s_NickServ, u, NICK_SET_ICQ_CHANGED, ni->icq_number); 
	}
    } else { 
	if(ni->icq_number) free(ni->icq_number);
	ni->icq_number = NULL;
	notice_lang(s_NickServ, u, NICK_SET_ICQ_UNSET);
    }
}

static void do_set_location(User *u, NickInfo *ni, char *param)
{
    if (param) {
        if (strlen(param)>30) {
	    notice_lang(s_NickServ, u, BAD_LOCATION);
	} else {
	    log2c("%s: %s SET LOCATION %s", s_NickServ, u->nick, param);
	    if(ni->location) free(ni->location);
	    ni->location = sstrdup(param);
	    if(u->real_ni != ni)
	    	notice_lang(s_NickServ, u, NICK_SET_LOCATION_SADMIN_CHANGED, ni->nick, ni->location);
	    else
		notice_lang(s_NickServ, u, NICK_SET_LOCATION_CHANGED, ni->location); 
	}
    } else { 
	if(ni->location) 
	    free(ni->location);
	ni->location = NULL;
	if(u->real_ni != ni)
	    notice_lang(s_NickServ, u, NICK_SET_LOCATION_SADMIN_UNSET, ni->nick);
	else
	    notice_lang(s_NickServ, u, NICK_SET_LOCATION_UNSET);
    }
}

/*************************************************************************/
static void do_set_kill(User *u, NickInfo *ni, char *param)
{
/*
    if (NickChange) {
	notice_lang(s_NickServ,u,FEATURE_DISABLED);
	return;
    }
*/
    if (strcasecmp(param, "ON") == 0) {
	ni->flags |= NI_KILLPROTECT; 
	ni->flags &= ~(NI_KILL_QUICK | NI_KILL_IMMED);
	notice_lang(s_NickServ, u, NICK_SET_KILL_ON);
    } else if (strcasecmp(param, "QUICK") == 0) {
	ni->flags |= NI_KILLPROTECT | NI_KILL_QUICK; 
	ni->flags &= ~NI_KILL_IMMED;
	notice_lang(s_NickServ, u, NICK_SET_KILL_QUICK);
    } else if (strcasecmp(param, "IMMED") == 0) {
        notice_lang(s_NickServ, u, NICK_SET_KILL_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ni->flags &= ~(NI_KILLPROTECT | NI_KILL_QUICK | NI_KILL_IMMED);
	notice_lang(s_NickServ, u, NICK_SET_KILL_OFF);
    } else {
        notice_lang(s_NickServ, u, NICK_SET_KILL_ON);
    }
}

/*************************************************************************/

static void do_set_private(User *u, NickInfo *ni, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ni->flags |= NI_PRIVATE;
	notice_lang(s_NickServ, u, NICK_SET_PRIVATE_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ni->flags &= ~NI_PRIVATE;
	notice_lang(s_NickServ, u, NICK_SET_PRIVATE_OFF);
    } else {
	syntax_error(s_NickServ, u, "SET PRIVATE", NICK_SET_PRIVATE_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_newsletter(User *u, NickInfo *ni, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ni->flags |= NI_NEWSLETTER;
	notice_lang(s_NickServ, u, NICK_SET_NEWSLETTER_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ni->flags &= ~NI_NEWSLETTER;
	notice_lang(s_NickServ, u, NICK_SET_NEWSLETTER_OFF);
    } else {
	syntax_error(s_NickServ, u, "SET NEWSLETTER", NICK_SET_NEWSLETTER_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_hide(User *u, NickInfo *ni, char *param)
{
    int flag, onmsg, offmsg;

    if (strcasecmp(param, "EMAIL") == 0) {
	flag = NI_HIDE_EMAIL;
	onmsg = NICK_SET_HIDE_EMAIL_ON;
	offmsg = NICK_SET_HIDE_EMAIL_OFF;
    } else if (strcasecmp(param, "QUIT") == 0) {
	flag = NI_HIDE_QUIT;
	onmsg = NICK_SET_HIDE_QUIT_ON;
	offmsg = NICK_SET_HIDE_QUIT_OFF;
    } else {
	syntax_error(s_NickServ, u, "SET HIDE", NICK_SET_HIDE_SYNTAX);
	return;
    }
    param = strtok(NULL, " ");
    if (!param) {
	syntax_error(s_NickServ, u, "SET HIDE", NICK_SET_HIDE_SYNTAX);
    } else if (strcasecmp(param, "ON") == 0) {
	ni->flags |= flag;
	notice_lang(s_NickServ, u, onmsg, s_NickServ);
    } else if (strcasecmp(param, "OFF") == 0) {
	ni->flags &= ~flag;
	notice_lang(s_NickServ, u, offmsg, s_NickServ);
    } else {
	syntax_error(s_NickServ, u, "SET HIDE", NICK_SET_HIDE_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_noexpire(User *u, NickInfo *ni, char *param)
{
    if (!is_services_admin(u)) {
	notice_lang(s_NickServ, u, PERMISSION_DENIED);
	return;
    }
    if (!param) {
	syntax_error(s_NickServ, u, "SET NOEXPIRE", NICK_SET_NOEXPIRE_SYNTAX);
	return;
    }
    if (strcasecmp(param, "ON") == 0) {
	ni->status |= NS_NO_EXPIRE;
	notice_lang(s_NickServ, u, NICK_SET_NOEXPIRE_ON, ni->nick);
    } else if (strcasecmp(param, "OFF") == 0) {
	ni->status &= ~NS_NO_EXPIRE;
	notice_lang(s_NickServ, u, NICK_SET_NOEXPIRE_OFF, ni->nick);
    } else {
	syntax_error(s_NickServ, u, "SET NOEXPIRE", NICK_SET_NOEXPIRE_SYNTAX);
    }
}

/*************************************************************************
    Lamego 1999
    Sets autojoin list active on/off
 *************************************************************************/
static void do_set_autojoin(User *u, NickInfo *ni, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ni->flags |= NI_AUTO_JOIN;
	notice_lang(s_NickServ, u, NICK_SET_AUTOJOIN_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ni->flags &= ~NI_AUTO_JOIN;
	notice_lang(s_NickServ, u, NICK_SET_AUTOJOIN_OFF);
    } else {
	syntax_error(s_NickServ, u, "SET AUTOJOIN", NICK_SET_AUTOJOIN_SYNTAX);
    }
}

static void do_set_privmsg(User *u, NickInfo *ni, char *param)
{
    User *tu;
  
    if (strcasecmp(param, "ON") == 0) {
	ni->flags |= NI_PRIVMSG;
	notice_lang(s_NickServ, u, NICK_SET_PRIVMSG_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ni->flags &= ~NI_PRIVMSG;
	notice_lang(s_NickServ, u, NICK_SET_PRIVMSG_OFF);
    } else {
	syntax_error(s_NickServ, u, "SET PRIVMSG", NICK_SET_PRIVMSG_SYNTAX);
    }
    tu = finduser(ni->nick); /* check if the user is online */
    if(tu)
      tu->is_msg = (ni->flags & NI_PRIVMSG);
}


static void do_ajoin(User *u) {
    char *cmd = strtok(NULL, " ");
    char *chan = strtok(NULL, " ");
    char **autoj;
    NickInfo *ni;
    int i;
    if (chan) 
      clean_channelname(chan);    
    if (!nick_identified(u)) 
      {
        notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
        return;
      }
    if (cmd && strcasecmp(cmd, "LIST") == 0 && chan && is_services_admin(u)
			&& (ni = findnick(chan))) {
	ni = getlink(ni);			
	notice_lang(s_NickServ, u, NICK_AJOIN_LIST_X, chan);	
	if (ni->ajoincount) {
	    for (autoj = ni->autojoin, i = 0; i < ni->ajoincount; autoj++, i++) {
	      {
	        if(u->is_msg)
	          privmsg(s_NickServ, u->nick, "    %s", *autoj);
	        else
		  notice(s_NickServ, u->nick, "    %s", *autoj);
	      }
	    }
	}
	else  notice_lang(s_NickServ,u, NICK_AJOIN_EMPTY);
    } else if (!cmd || ((strcasecmp(cmd,"LIST")==0 || strcasecmp(cmd,"NOW")==0) 
		? !!chan : !chan)) {
	syntax_error(s_NickServ, u, "AJOIN", NICK_AJOIN_SYNTAX);
    } else if (!(ni = u->ni)) {
	notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);
    } else if (cmd && !strcasecmp(cmd, "NOW")) {
	if (ni->ajoincount) 
	    autojoin(u); 
	else
	    notice_lang(s_NickServ,u, NICK_AJOIN_EMPTY);
    } else if (chan && !strchr(chan, '#')) {
	notice_lang(s_NickServ, u, BAD_CHAN_NAME);
	notice_lang(s_NickServ, u, MORE_INFO, s_NickServ, "AJOIN");
    } else if (!nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
    } else if (strcasecmp(cmd, "ADD") == 0) {
    	if (readonly) {
	    notice_lang(s_NickServ, u, READ_ONLY_MODE);
	    return;
	}
	if (ni->ajoincount >= NSAJoinMax) {
	    notice_lang(s_NickServ, u, NICK_AJOIN_REACHED_LIMIT, NSAJoinMax);
	    return;
	}
	if (strlen(chan)>MAXCHANLEN) {
	    notice_lang(s_NickServ, u, BAD_CHAN_NAME);
	    notice_lang(s_NickServ, u, MORE_INFO, s_NickServ, "AJOIN");
	    return;
	}
	for (autoj = ni->autojoin, i = 0; i < ni->ajoincount; autoj++, i++) {
	    if (strcasecmp(*autoj, chan) == 0) {
		notice_lang(s_NickServ, u,
			NICK_AJOIN_ALREADY_PRESENT, *autoj);
		return;
	    }
	}
	ni->ajoincount++;
	ni->autojoin = srealloc(ni->autojoin, sizeof(char *) * ni->ajoincount);
	ni->autojoin[ni->ajoincount-1] = sstrdup(chan);
	notice_lang(s_NickServ, u, NICK_AJOIN_ADDED, chan);
    } else if (strcasecmp(cmd, "DEL") == 0) {
    	if (readonly) {
	    notice_lang(s_NickServ, u, READ_ONLY_MODE);
	    return;
	}
	for (autoj = ni->autojoin, i = 0; i < ni->ajoincount; autoj++, i++) {
	    if (strcasecmp(*autoj, chan) == 0)
		break;
	}
	if (i == ni->ajoincount) {
	    notice_lang(s_NickServ, u, NICK_AJOIN_NOT_FOUND, chan);
	    return;
	}
	notice_lang(s_NickServ, u, NICK_AJOIN_DELETED, *autoj);
	free(*autoj);
	ni->ajoincount--;
	if (i < ni->ajoincount)	/* if it wasn't the last entry... */
	    memmove(autoj, autoj+1, (ni->ajoincount-i) * sizeof(char *));
	if (ni->ajoincount)		/* if there are any entries left... */
	    ni->autojoin = srealloc(ni->autojoin, ni->ajoincount * sizeof(char *));
	else {
	    free(ni->autojoin);
	    ni->autojoin = NULL;
	}
    } else if (strcasecmp(cmd, "LIST") == 0) {
        if(ni->ajoincount==0) {
	    notice_lang(s_NickServ,u, NICK_AJOIN_EMPTY);
	    return;
	}
	notice_lang(s_NickServ, u, NICK_AJOIN_LIST);
	for (autoj = ni->autojoin, i = 0; i < ni->ajoincount; autoj++, i++) {
	    if(u->is_msg)
	      privmsg(s_NickServ, u->nick, "    %s", *autoj);
	    else
	      notice(s_NickServ, u->nick, "    %s", *autoj);
	}
    } else {
	syntax_error(s_NickServ, u, "AJOIN", NICK_AJOIN_SYNTAX);

    }
}


static void do_link(User *u)
{
    char *nick = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    NickInfo *ni = u->real_ni, *target;
    int res;
    
    if (NSDisableLinkCommand) {
	notice_lang(s_NickServ, u, NICK_LINK_DISABLED);
	return;
    }

    if (!pass) {
	syntax_error(s_NickServ, u, "LINK", NICK_LINK_SYNTAX);

    } else if (!ni) {
	notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);

    } else if (!nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);

    } else if (!(target = findnick(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);

    } else if (target == ni) {
	notice_lang(s_NickServ, u, NICK_NO_LINK_SAME, nick);

    } else if (target->status & NS_VERBOTEN) {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, nick);

    } else if (!(res = check_password(pass, target->pass,target->crypt_method))) {
	log2c("%s: LINK: bad password for %s by %s!%s@%s",
		s_NickServ, nick, u->nick, u->username, u->host);
	notice_lang(s_NickServ, u, PASSWORD_INCORRECT);
	bad_password(u);

    } else if (res == -1) {
	notice_lang(s_NickServ, u, NICK_LINK_FAILED);

    } else {
	NickInfo *tmp;

	/* Make sure they're not trying to make a circular link */
	for (tmp = target; tmp; tmp = tmp->link) {
	    if (tmp == ni) {
		notice_lang(s_NickServ, u, NICK_LINK_CIRCULAR, nick);
		return;
	    }
	}

	/* If this nick already has a link, break it */
	if (ni->link)
	    delink(ni);

	ni->link = target;
	target->linkcount++;
	do {
	    target->channelcount += ni->channelcount;
	    if (target->link)
		target = target->link;
	} while (target->link);
	if (ni->autojoin) {
	    int i;
	    for (i = 0; i < ni->ajoincount; i++) {
		if (ni->autojoin[i])
		    free(ni->autojoin[i]);
	    }
	    free(ni->autojoin);
	    ni->autojoin = NULL;
	    ni->ajoincount = 0;
	}	
	if (ni->memos.memos) {
	    int i, num;
	    Memo *memo;
	    if (target->memos.memos) {
		num = 0;
		for (i = 0; i < target->memos.memocount; i++) {
		    if (target->memos.memos[i].number > num)
			num = target->memos.memos[i].number;
		}
		num++;
		target->memos.memos = srealloc(target->memos.memos,
			sizeof(Memo) * (ni->memos.memocount +
			                target->memos.memocount));
	    } else {
		num = 1;
		target->memos.memos = smalloc(sizeof(Memo)*ni->memos.memocount);
		target->memos.memocount = 0;
	    }
	    memo = target->memos.memos + target->memos.memocount;
	    for (i = 0; i < ni->memos.memocount; i++, memo++) {
		*memo = ni->memos.memos[i];
		memo->number = num++;
	    }
	    target->memos.memocount += ni->memos.memocount;
	    ni->memos.memocount = 0;
	    free(ni->memos.memos);
	    ni->memos.memos = NULL;
	    ni->memos.memocount = 0;
	}
	u->ni = target;
	notice_lang(s_NickServ, u, NICK_LINKED, nick);
	/* They gave the password, so they might as well have IDENTIFY'd */
	target->status |= NS_IDENTIFIED;
	log2c("%s: %s!%s@%s linked to nick %s", s_NickServ,
		u->nick, u->username, u->host, nick);
	
    }
}

/*************************************************************************/

static void do_unlink(User *u)
{
    NickInfo *ni;
    char *linkname;
    char *nick = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    int res = 0;

    if (nick) {
	int is_servadmin = is_services_admin(u);
	ni = findnick(nick);
	if (!ni) {
	    notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
	} else if (!ni->link) {
	    notice_lang(s_NickServ, u, NICK_X_NOT_LINKED, nick);
	} else if (!is_servadmin && !pass) {
	    syntax_error(s_NickServ, u, "UNLINK", NICK_UNLINK_SYNTAX);
	} else if (!is_servadmin &&
				!(res = check_password(pass, ni->pass,ni->crypt_method))) {
	    log2c("%s: LINK: bad password for %s by %s!%s@%s",
		s_NickServ, nick, u->nick, u->username, u->host);
	    notice_lang(s_NickServ, u, PASSWORD_INCORRECT);
	    bad_password(u);
	} else if (res == -1) {
	    notice_lang(s_NickServ, u, NICK_UNLINK_FAILED);
	} else {
	    linkname = ni->link->nick;
	    delink(ni);
	    notice_lang(s_NickServ, u, NICK_X_UNLINKED, ni->nick, linkname);
	    /* Adjust user record if user is online */
	    /* FIXME: probably other cases we need to consider here */
	    for (u = hash_next_user(1); u; u = hash_next_user(0)) {
		if (u->real_ni == ni) {
		    u->ni = ni;
		    break;
		}
	    }
	}
    } else {
	ni = u->real_ni;
	if (!ni)
	    notice_lang(s_NickServ, u, NICK_NOT_REGISTERED);
	else if (!nick_identified(u))
	    notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	else if (!ni->link)
	    notice_lang(s_NickServ, u, NICK_NOT_LINKED);
	else {
	    linkname = ni->link->nick;
	    u->ni = ni;  /* Effective nick now the same as real nick */
	    delink(ni);
	    notice_lang(s_NickServ, u, NICK_UNLINKED, linkname);
	    log2c("%s: %s!%s@%s unlinked from nick %s", s_NickServ,
		u->nick, u->username, u->host, nick);	    
	}
    }
}

/*************************************************************************/

static void do_listlinks(User *u)
{
    char *nick = strtok(NULL, " ");
    char *param = strtok(NULL, " ");
    NickInfo *ni, *ni2;
    int count = 0, i;
    int is_sadmin = is_services_admin(u);
    if (!nick_identified(u)) {
	    notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
    } else if (is_sadmin && (!nick || (param && strcasecmp(param, "ALL") != 0))) {
	syntax_error(s_NickServ, u, "LISTLINKS", NICK_LISTLINKS_SYNTAX);
    } else if (nick && !is_sadmin) {
	syntax_error(s_NickServ, u, "LISTLINKS", NICK_LISTLINKS_SYNTAX2);
    } else if (!(ni = (nick ? findnick(nick) : u->real_ni))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
    } else if (ni->status & NS_VERBOTEN) {
	notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, ni->nick);
    } else {
	notice_lang(s_NickServ, u, NICK_LISTLINKS_HEADER, ni->nick);
	if (param)
	    ni = getlink(ni);
	for (i = 0; i < N_MAX; i++) {
	    for (ni2 = nicklists[i]; ni2; ni2 = ni2->next) {
		if (ni2 == ni)
		    continue;
		if (param ? getlink(ni2) == ni : ni2->link == ni) {
		    if(u->is_msg)
		      privmsg(s_NickServ, u->nick, "    %s", ni2->nick);
		    else
		      notice(s_NickServ, u->nick, "    %s", ni2->nick);
		    count++;
		}
	    }
	}
	notice_lang(s_NickServ, u, NICK_LISTLINKS_FOOTER, count);
    }
}



/*************************************************************************/

static void do_info(User *u)
{
    NickInfo *ni, *real;
    char *nick = strtok(NULL, " ");
    char *email;
    User *u2;
    int is_servoper;
    int is_servadmin = is_services_admin(u);
    is_servoper = is_servadmin ? 1 : is_services_oper(u);
    if (!nick) {
	syntax_error(s_NickServ, u, "INFO", NICK_INFO_SYNTAX);

    } else if (!(ni = findnick(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);

    } else if (ni->status & NS_VERBOTEN) {
	  notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, nick);

    } else {
	struct tm *tm;
	char buf[BUFSIZE], *end;
	char buf2[BUFSIZE];
	const char *commastr = getstring(u, COMMA_SPACE);
	time_t now=time(NULL);
	int need_comma = 0;

	real = getlink(ni);
	if ( (real->flags & NI_PRIVATE) ) 
	  {		
		if (!is_servoper && 
		  (!nick_identified(u) || (u->ni != real))) 
		    {
		    	notice_lang(s_NickServ, u, NICK_INFO_PRIVATE,nick);
			return;
		    }
	  }

    	notice_lang(s_NickServ, u, NICK_INFO_HEADER);
        if(is_servadmin)
          notice(s_NickServ, u->nick, "SNID: \02%d\02", ni->snid);                    
          
	notice_lang(s_NickServ, u, NICK_INFO_REALNAME,
		nick, ni->last_realname);
	/* last mask is just useful for sopers */
	if (is_servoper)
	    notice_lang(s_NickServ, u, NICK_INFO_ADDRESS, ni->last_usermask);		
		
	/* registered */
	tm = localtime(&ni->time_registered);
	strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
	ago_time(buf2,now-ni->time_registered,u);
	notice_lang(s_NickServ, u, NICK_INFO_TIME_REGGED, buf, buf2);
	
	/* last identify */
	tm = localtime(&ni->last_identify);
	strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
	ago_time(buf2,now-ni->last_identify,u);
	notice_lang(s_NickServ, u, NICK_INFO_LAST_IDENTIFY, buf,buf2);
	
	/* last seen */
	tm = localtime(&ni->last_seen);
	strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
	ago_time(buf2,now-ni->last_seen,u);
	notice_lang(s_NickServ, u, NICK_INFO_LAST_SEEN, buf, buf2);	
	total_time(buf,real->online,u);
	notice_lang(s_NickServ, u, NICK_INFO_ONLINE, buf);	
	if (ni->last_quit && strlen(ni->last_quit)>5 && 
	(is_servoper || !(real->flags & NI_HIDE_QUIT) || (u->ni == real)))
	    notice_lang(s_NickServ, u, NICK_INFO_LAST_QUIT, ni->last_quit);
	if (ni->url)
	    notice_lang(s_NickServ, u, NICK_INFO_URL, ni->url);
	    
	if(!NSNeedAuth && !ni->email)
	  email = ni->email_request;
	else
	  email = ni->email;
	  
	if (email && (is_servoper || !(real->flags & NI_HIDE_EMAIL) || (u->ni == real)))
	    notice_lang(s_NickServ, u, NICK_INFO_EMAIL, email);
	if(NSNeedAuth && ni->email_request && is_servoper)
	  notice_lang(s_NickServ, u, NICK_INFO_EMAIL, ni->email_request);
	if (ni->icq_number)
	    notice_lang(s_NickServ, u, NICK_INFO_ICQ, ni->icq_number);	    
	if (ni->location)
	    notice_lang(s_NickServ, u, NICK_INFO_LOCATION, ni->location);	    	    
	*buf = 0;
	end = buf;
	if (!NickChange && real->flags & NI_KILLPROTECT) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s",
			getstring(u, NICK_INFO_OPT_KILL));
	    need_comma = 1;
	}
	if (real->flags & NI_PRIVATE) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, NICK_INFO_OPT_PRIVATE));
	    need_comma = 1;
	}
	if (real->flags & NI_AUTO_JOIN) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, NICK_INFO_OPT_AUTOJOIN));
	    need_comma = 1;
	}

	notice_lang(s_NickServ, u, NICK_INFO_OPTIONS,
		*buf ? buf : getstring(u, NICK_INFO_OPT_NONE));
	if ((ni->status & NS_NO_EXPIRE) && ((real == u->ni && nick_identified(u))  || is_servadmin))
	    notice_lang(s_NickServ, u, NICK_INFO_NO_EXPIRE);
	    
	if(ni->flags & NI_DROPPED)
	    notice_lang(s_NickServ, u, NICK_DROP_AT,
	    (ni->last_identify+NSDropDelay-time(NULL))/86400);    

	if((ni->flags & NI_SUSPENDED) && is_servoper) {
	    if(ni->suspension_expire-now>0) {
		total_time(buf,ni->suspension_expire-now,u);
		notice_lang(s_NickServ, u,NICK_INFO_SUSPENDED,buf);
	    }		
	}	   	 
	if((ni->flags & NI_OSUSPENDED) && is_servoper) {
	    if(ni->suspension_expire-now>0) {
		total_time(buf,ni->suspension_expire-now,u);
		notice_lang(s_NickServ, u,NICK_INFO_OSUSPENDED,buf);
	    }		
	}
    
	if((u2=finduser(nick)) && nick_recognized(u2))
	  {
            notice_lang(s_NickServ, u,NICK_INFO_IS_ONLINE);
	  }
	if ( ni->flags & NI_NEWSLETTER ) 
	  {
	    notice_lang(s_NickServ, u, NICK_INFO_NEWSLETTER);
	  }
    notice_lang(s_NickServ, u, NICK_INFO_HEADER);      
    
    }
}

/*************************************************************************/
static void do_notes(User *u)
{
    int num,i;
    char *cmd = strtok(NULL, " ");
    char *param = strtok(NULL, "");
    if(!cmd || (cmd && !param && strcasecmp(cmd,"LIST"))) {
    	syntax_error(s_NickServ, u, "NOTES", NICK_NOTES_SYNTAX);
    } else if (!nick_identified(u)) {
	notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);	
    } else if (!strcasecmp(cmd,"ADD")) {
	if((i = addnote(&u->ni->notes,param))) 
	    notice_lang(s_NickServ, u, NICK_NOTES_ADDED,i);
	else
	    notice_lang(s_NickServ, u, NICK_NOTES_NOADD,u->ni->notes.max);
    } else if (!strcasecmp(cmd,"DEL")) {
	if(isdigit(*param)) {
	    num = atoi(param)-1;
	    if(delnote(&u->ni->notes,num))
		  notice_lang(s_NickServ, u, NICK_NOTES_DELETED,num+1);
	    else
		  notice_lang(s_NickServ, u, NICK_NOTES_NOTFOUND,num+1);
	} else syntax_error(s_NickServ, u, "NOTES", NICK_NOTES_SYNTAX);
    } else if (!strcasecmp(cmd,"LIST")) {
	if(u->ni->notes.count) {
	    notice_lang(s_NickServ, u, NICK_NOTES_LIST_HEADER);
	    for(num=0;num<u->ni->notes.count;++num)
		notice_lang(s_NickServ, u, NICK_NOTES_LIST,num+1,u->ni->notes.note[num]);
	} else notice_lang(s_NickServ, u, NICK_NOTES_NONOTES);
    } else syntax_error(s_NickServ, u, "NOTES", NICK_NOTES_SYNTAX);
}

/*************************************************************************/

/* SADMINS can search for nicks based on their NS_VERBOTEN and NS_NO_EXPIRE
 * status. The keywords FORBIDDEN and NOEXPIRE represent these two states
 * respectively. These keywords should be included after the search pattern.
 * Multiple keywords are accepted and should be separated by spaces. Only one
 * of the keywords needs to match a nick's state for the nick to be displayed.
 * Forbidden nicks can be identified by "[Forbidden]" appearing in the last
 * seen address field. Nicks with NOEXPIRE set are preceeded by a "!". Only
 * SADMINS will be shown forbidden nicks and the "!" indicator.
 * Syntax for sadmins: LIST pattern [FORBIDDEN] [NOEXPIRE]
 * -TheShadow
 */

static void do_list(User *u)
{
    char *pattern = strtok(NULL, " ");
    char *keyword;
    NickInfo *ni;
    int nnicks, i;
    char buf[BUFSIZE];
    int is_servadmin = is_services_admin(u);
    int16 matchflags = 0; /* NS_ flags a nick must match one of to qualify */

    if (NSListOpersOnly && !(u->mode & UMODE_o)) {
	notice_lang(s_NickServ, u, PERMISSION_DENIED);
	return;
    }

    if (!pattern) {
	syntax_error(s_NickServ, u, "LIST",
		is_servadmin ? NICK_LIST_SERVADMIN_SYNTAX : NICK_LIST_SYNTAX);
    } else {
	nnicks = 0;

	while (is_servadmin && (keyword = strtok(NULL, " "))) {
	    if (strcasecmp(keyword, "FORBIDDEN") == 0)
		matchflags |= NS_VERBOTEN;
	    if (strcasecmp(keyword, "NOEXPIRE") == 0)
		matchflags |= NS_NO_EXPIRE;
	}

	notice_lang(s_NickServ, u, NICK_LIST_HEADER, pattern);
	for (i = 0; i < N_MAX; i++) {
	    for (ni = nicklists[i]; ni; ni = ni->next) {
		if (!is_servadmin && ((ni->flags & NI_PRIVATE)
						|| (ni->status & NS_VERBOTEN)))
		    continue;
		if ((matchflags != 0) && !(ni->status & matchflags))
		    continue;

		/* We no longer compare the pattern against the output buffer.
		 * Instead we build a nice nick!user@host buffer to compare.
		 * The output is then generated separately. -TheShadow */
		snprintf(buf, sizeof(buf), "%s!%s", ni->nick,
				ni->last_usermask ? ni->last_usermask : "*@*");
		if (strcasecmp(pattern, ni->nick) == 0 ||
					match_wild_nocase(pattern, buf)) {
		    if (++nnicks <= NSListMax) {
			char noexpire_char = ' ';
			if (is_servadmin && (ni->status & NS_NO_EXPIRE))
			    noexpire_char = '!';
			if (!is_servadmin) {
			    snprintf(buf, sizeof(buf), "%-20s  [Hidden]",
						ni->nick);
			} else if (ni->status & NS_VERBOTEN) {
			    snprintf(buf, sizeof(buf), "%-20s  [Forbidden]",
						ni->nick);
			} else {
			    snprintf(buf, sizeof(buf), "%-20s  %s",
						ni->nick, ni->last_usermask);
			}
			if(u->is_msg)
			  privmsg(s_NickServ, u->nick, "   %c%s",
						noexpire_char, buf);
			else
			  notice(s_NickServ, u->nick, "   %c%s",
						noexpire_char, buf);
		    }
		}
	    }
	}
	notice_lang(s_NickServ, u, NICK_LIST_RESULTS,
			nnicks>NSListMax ? NSListMax : nnicks, nnicks);
    }
}

/*************************************************************************/
static void do_ghost_release(User *u, NickInfo *ni,char* nick, char* pass) {
    int res;
    time_t now;
    if (!pass) {
    	syntax_error(s_NickServ, u, "GHOST", NICK_GHOST_SYNTAX);
	return;
    }
    res = check_password(pass, ni->pass,ni->crypt_method);
    if (res == 1) {
	    release(ni, 0);
	    notice_lang(s_NickServ, u, NICK_RELEASED);
	    ni->status |= (NS_IDENTIFIED | NS_RECOGNIZED);
	    ni->last_identify = time(NULL);
	    if (ni->last_usermask)
	      free(ni->last_usermask);
	    ni->last_usermask = smalloc(strlen(u->username)+strlen(u->host)+2);
	    sprintf(ni->last_usermask, "%s@%s", u->username, u->host);
	    if (ni->last_realname)
		free(ni->last_realname);
	    ni->last_realname = sstrdup(u->realname);
	    log2c("%s: %s!%s@%s identified on release for nick %s", s_NickServ,
			u->nick, u->username, u->host, nick);
	    now = time(NULL);
	    send_cmd(s_NickServ, "SVSNICK %s %s :0", 
	    	u->nick,nick);
		u->on_ghost = u->first_TS;
	    ni->first_TS = u->first_TS;
	}
    else { log2c("%s: GHOST RELEASE: invalid password for %s by %s!%s@%s",
		s_NickServ, nick, u->nick, u->username, u->host);
		bad_password(u);		
	}
}

/*************************************************************************/

static void do_ghost(User *u)
{
    char *nick = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    NickInfo *ni;
    User *u2;
    time_t now;
    if (!nick)
	  syntax_error(s_NickServ, u, "GHOST", NICK_GHOST_SYNTAX);
    else if (!(u2 = finduser(nick))) 
	  {
		if ((ni = findnick(nick)) && (ni->status & NS_KILL_HELD))  do_ghost_release(u, ni, nick, pass);
	  	  else notice_lang(s_NickServ, u, NICK_X_NOT_IN_USE, nick);
  	  } 
	else if (!(ni = u2->real_ni)) 
	  notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);	
	else if (ni->status & NS_VERBOTEN)
	  {
		log2c("%s: %s@%s tried to ghost FORBIDden nick %s", s_NickServ,
			u->username, u->host, u->nick);
	  	  notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, nick);
	  }
	else if (irccmp(nick, u->nick) == 0) 
	  notice_lang(s_NickServ, u, NICK_NO_GHOST_SELF);
	else if (pass) 
	  {
		int res = check_password(pass, ni->pass,ni->crypt_method);
		
		if (res == 1) 
		  {
	  	    char buf[IRCDNICKMAX+32];
		    snprintf(buf, sizeof(buf), "GHOST command used by %s", u->nick);
		    kill_user(s_NickServ, nick, buf);
		    notice_lang(s_NickServ, u, NICK_GHOST_KILLED, nick);
		    ni->status |= (NS_IDENTIFIED | NS_RECOGNIZED);	   
		    ni->last_identify = time(NULL);
			
		    if (ni->last_usermask)
	    	  free(ni->last_usermask);

		    ni->last_usermask = smalloc(strlen(u->username)+strlen(u->host)+2);
		    sprintf(ni->last_usermask, "%s@%s", u->username, u->host);
			
		    if (ni->last_realname)
				free(ni->last_realname);
		    ni->last_realname = sstrdup(u->realname);
			
		    log2c("%s: %s!%s@%s identified on ghost for nick %s", s_NickServ,
				u->nick, u->username, u->host, nick);
				
		    now=time(NULL);			
			
		    send_cmd(s_NickServ, "SVSNICK %s %s :0", 
		    	u->nick,nick);
				
			u->on_ghost = u->first_TS;
	  		ni->first_TS = u->first_TS;
			
		  } 
		else 
		  {
		    notice_lang(s_NickServ, u, ACCESS_DENIED);
		    if (res == 0) 
			  {
				log2c("%s: GHOST: invalid password for %s by %s!%s@%s",
					s_NickServ, nick, u->nick, u->username, u->host);
				bad_password(u);
	  		  }
  		  }
  	  } 
	else 
	  notice_lang(s_NickServ, u, ACCESS_DENIED);
}

/*************************************************************************/

static void do_status(User *u)
{
    char *nick = strtok(NULL, " ");
    User *u2;
    if(!nick) 
    	syntax_error(s_NickServ, u, "STATUS", NICK_STATUS_SYNTAX);
    else if (!(u2 = finduser(nick)))
        notice_lang(s_NickServ, u, NICK_STATUS_0, nick);
    else if (nick_identified(u2))
        notice_lang(s_NickServ, u, NICK_STATUS_3, nick);	
    else if (nick_recognized(u2))
        notice_lang(s_NickServ, u, NICK_STATUS_2, nick);	
    else
        notice_lang(s_NickServ, u, NICK_STATUS_1, nick);		
}

/*************************************************************************/

static void do_getpass(User *u)
{
    char *nick = strtok(NULL, " ");
    NickInfo *ni;
    /* Assumes that permission checking has already been done. */
    if (!IsOper(u)) {
    
    } else if (!nick) {
	syntax_error(s_NickServ, u, "GETPASS", NICK_GETPASS_SYNTAX);
    } else if (!(ni = findnick(nick))) {
	notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
    } else if (ni->status & NS_VERBOTEN) {
        notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, nick);
    } else if (ni->crypt_method) {
	notice_lang(s_NickServ, u, NICK_GETPASS_UNAVAILABLE);
    } else if (NSSecureAdmins && is_services_admin_nick(ni)) {
    	log1("%s: %s!%s@%s trying GETPASS on SADM nick %s",
    	                s_NickServ, u->nick, u->username, u->host, nick);
	sanotice(s_NickServ,"%s!%s@%s used GETPASS on SADM!!! %s",
		u->nick, u->username, u->host, nick);    	                	
    }
    else {
	log1("%s: %s!%s@%s used GETPASS on %s",
		s_NickServ, u->nick, u->username, u->host, nick);
	sanotice(s_NickServ,"%s!%s@%s used GETPASS on %s",
		u->nick, u->username, u->host, nick);
	if (WallGetpass)
	    wallops(s_NickServ, "\2%s\2 used GETPASS on \2%s\2", u->nick, nick);
	notice_lang(s_NickServ, u, NICK_GETPASS_PASSWORD_IS, nick, ni->pass);
    }
}

/*************************************************************************/

static void do_forbid(User *u)
{
    NickInfo *ni;
    char *nick = strtok(NULL, " ");

    /* Assumes that permission checking has already been done. */
    if(!IsOper(u)) {
    
    } else if (!nick) {
	syntax_error(s_NickServ, u, "FORBID", NICK_FORBID_SYNTAX);
	return;
    }
    if (readonly)
	notice_lang(s_NickServ, u, READ_ONLY_MODE);
    if ((ni = findnick(nick)) != NULL)
	delnick(ni);
    else
      {
	DayStats.ns_registered++;
	DayStats.ns_total++;
      }
    ni = makenick(nick);
    if (ni) {
	ni->status |= NS_VERBOTEN;
	log2c("%s: %s set FORBID for nick %s", s_NickServ, u->nick, nick);
	sanotice(s_NickServ,"%s set FORBID for nick %s", u->nick, nick);
	notice_lang(s_NickServ, u, NICK_FORBID_SUCCEEDED, nick);
    } else {
	log2c("%s: Valid FORBID for %s by %s failed", s_NickServ,
		nick, u->nick);		
	notice_lang(s_NickServ, u, NICK_FORBID_FAILED, nick);
    }
}

/*************************************************************************/

/****************************************************************************
    Shows stats of the day
 ****************************************************************************/
static void do_stats(User *u)
{
    time_t t;
    struct tm tm;    
    char tmp[63];
    char prefix;
    long int balance;
    if (StatsOpersOnly && !is_services_oper(u)) {
	notice_lang(s_NickServ, u, PERMISSION_DENIED);
	return;
    }
    balance = DayStats.ns_registered - (DayStats.ns_dropped+ DayStats.ns_expired);
    time(&t);
    tm = *localtime(&t);
    strftime(tmp, sizeof(tmp), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), &tm);
    notice_lang(s_NickServ, u, TODAYSTATS,tmp);
    notice_lang(s_NickServ, u, STATS_TOTAL,DayStats.ns_total);
    notice_lang(s_NickServ, u, STATS_REGISTERED,DayStats.ns_registered);
    notice_lang(s_NickServ, u, STATS_DROPPED,DayStats.ns_dropped);
    notice_lang(s_NickServ, u, STATS_EXPIRED,DayStats.ns_expired);   
    if(balance>0) prefix='+';
	else prefix=' ';	
    sprintf(tmp,"%c%ld", prefix, balance);
    notice_lang(s_NickServ, u, STATS_BALANCE,tmp);    
}

/*************************************************************************/

static void do_suspend(User *u)
{
    NickInfo *ni;
    char *nick = strtok(NULL, " ");
    char *stime = strtok(NULL, " ");
    long amount;
    
    /* Assumes that permission checking has already been done. */
    if(!IsOper(u)) {
    
    } else if (!nick || !stime) {
	syntax_error(s_NickServ, u, "SUSPEND", NICK_SUSPEND_SYNTAX);
	return;
    }

    if (readonly)
	notice_lang(s_NickServ, u, READ_ONLY_MODE);
    
    if (!(ni = findnick(nick))) 
      {
        notice_lang(s_NickServ, u, NICK_X_NOT_REGISTERED, nick);
        return;                                         
      }                                                       

    if (ni->status & NS_VERBOTEN) 
      {
        notice_lang(s_NickServ, u, NICK_X_FORBIDDEN, nick);
        return;
      }
                  
    amount = atoi(stime)*24*3600;      
    
    if(amount>0)
      {
    	ni->flags |= NI_SUSPENDED;
    	ni->flags &= ~NI_OSUSPENDED; /* nick suspension overrides */
    	ni->suspension_expire=time(NULL)+amount;
    
    	log2c("%s: %s SUSPENDed nick %s for %s days", 
    	  s_NickServ, u->nick, nick, stime);
    	sanotice(s_NickServ,"%s SUSPENDed nick %s", u->nick, nick);
    	notice_lang(s_NickServ, u, NICK_SUSPEND_SUCCEEDED, nick, stime);
      }
    else
      {
    	ni->flags &= ~NI_SUSPENDED;
	log2c("%s: %s canceled nick suspension for %s",
	  s_NickServ, u->nick, nick);
	sanotice(s_NickServ,"%s canceled nick suspension for %s",
	  u->nick, nick);
    	notice_lang(s_NickServ, u, NICK_SUSPEND_CANCEL, nick);
      }
      
}

/*************************************************************************/

static void do_auth(User *u)
{
  char *auth = strtok(NULL, " ");
  
  if (!u->ni || !nick_identified(u))
    {
      notice_lang(s_NickServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
      return;
    }
    
  if(!auth || (strcmp(auth, u->ni->auth)!=0))
    {
      notice_lang(s_NickServ, u , NICK_AUTH_INCORRET);
      return;
    }
        
  notice_lang(s_NickServ, u , NICK_AUTH_COMPLETED);    
  if(!u->ni->email_request)
    return;
    
  if(u->ni->email)
    free(u->ni->email);
  else /* this is the firs email set */
    {
      send_cmd(s_NickServ, "SVSMODE %s +rn %u", u->nick, u->ni->news_mask);  	
      if(OnAuthChan)
        send_cmd(s_NickServ, "SVSJOIN %s #%s", u->nick, OnAuthChan);
    }
  u->ni->email = u->ni->email_request;
  u->ni->email_request = NULL;
  log2c("%s: %s!%s@%s AUTHenticated email %s",
    s_NickServ, u->nick, u->username, u->host,u->ni->email);
           
}
