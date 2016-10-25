/* Initalization and related routines.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * $Id: newsserv.c,v 1.5 2004/12/06 22:20:34 jpinto Exp $ 
 */
#include "ircdsetup.h"

#include "services.h"
#include "pseudo.h"
#include "newsserv.h"
#define DFV_NEWSSERV 1	/* NewsServ datafiles version */

#ifdef NEWS
/* external functions */
E int is_services_admin(User *u);

/* NewsServ Data Storage */
static NickInfo *news_admins[MAX_NEWSADMINS];
static NickInfo *news_opers[MAX_NEWSOPERS];
static NewsInfo last_news[MAX_LASTNEWS];
static char *subjectlist[MAX_SUBJECTS];
static int  news_cursor=0;
/* functions prototypes */
static int do_help(User *u);
static int do_oper(User *u);
static int is_news_oper(User *u);
static int is_news_admin(User *u);
static int do_subscribe (User *u);
static int do_unsubscribe (User *u);
static int do_set (User *u);
static int do_send (User *u);
static int do_list(User *u);
static int do_recent(User *u);
static int do_view(User *u);
static int do_del(User *u);
static int do_admin(User *u);
static int do_subject(User *u);
void newsserv_export(void);

/*************************************************************************/
static nCommand cmds[] = {
    /* Any user commands */
    { "HELP",		do_help,		-1}, 
    { "SUBSCRIBE",	do_subscribe,	NEWSS_SUBSCRIBE_HELP},
    { "UNSUBSCRIBE",	do_unsubscribe,	NEWSS_UNSUBSCRIBE_HELP},
    { "SET",		do_set,		NEWSS_SET_HELP},
    { "SET NOTICE",	NULL,		NEWSS_SET_NOTICE_HELP},
    { "LIST",		do_list,	NEWSS_LIST_HELP},
    { "RECENT",		do_recent,	NEWSS_RECENT_HELP},
    /* News oper commands */    
    { "",		is_news_oper,		-1},
    { "OPER",		do_oper,	NEWSS_OPER_HELP},        
    { "ADMIN",		do_admin, 	NEWSS_ADMIN_HELP},    
    { "SEND",		do_send,	NEWSS_SEND_HELP},
    { "VIEW",		do_view,	NEWSS_VIEW_HELP},
    { "DEL",		do_del,		NEWSS_DEL_HELP},
    /* News admin commands */    
    { "",		is_news_admin,		-1},
    { "SUBJECT",	do_subject,	NEWSS_SUBJECT_HELP},    
    /* Service admin commands */
    { NULL }
};

/*************************************************************************
  NewsServ initialization
 *************************************************************************/
void nw_init(void)
{
#ifndef NEWS
    return;
#else
/*
    int i;
    for(i=0;i<MAX_SUBJECTS;++i)
	subjectlist[i] = NULL;
    for(i=0;i<MAX_LASTNEWS;++i)
    {
	last_news[i].number = 0; 
    }
*/
#endif
}

/*************************************************************************/
/* Does the given user have News admin privileges? */

static int is_news_admin(User *u)
{
    int i;

    if (is_services_admin(u))
	return 1;
    if (skeleton)
	return 1;
    for (i = 0; i < MAX_NEWSADMINS; i++) {
	if (news_admins[i] && u->ni == getlink(news_admins[i])) {
	    return nick_restrict_identified(u);
	}
    }
    return 0;
}

/*************************************************************************/

/* Does the given user have News oper privileges? */

int is_news_oper(User *u)
{
    int i;
    if (is_news_admin(u))
	return 1;
    if (skeleton)
	return 1;
    for (i = 0; i < MAX_NEWSOPERS; i++) {
	if (news_opers[i] && u->ni == getlink(news_opers[i])) {
	    return nick_restrict_identified(u);
	}
    }
    return 0;
}

/*************************************************************************/

/* Expunge a deleted nick from the news admin/oper lists. */

void nw_remove_nick(const NickInfo *ni)
{
    int i;

    for (i = 0; i < MAX_NEWSADMINS; i++) {
	if (news_admins[i] == ni)
	    news_admins[i] = NULL;
    }
    for (i = 0; i < MAX_NEWSOPERS; i++) {
	if (news_opers[i] == ni)
	    news_opers[i] = NULL;
    }
}

/*************************************************************************
    builds the news bit mask from a sequence of subject numbers
    e.g.:
    1 = return 2
    1,3 = 2 + 8 = return 10
 *************************************************************************/
static int32 buildmask(int *count)
{
    int32 bmask=0;
    int bitmap[MAX_SUBJECTS];
    int num=0,i;
    char *number=strtok(NULL, ", ");
    (*count) = 0;
    if(!number) return 0;
    if(!strcasecmp(number,"ALL"))
    {
    	(*count) = 32;
	return NM_ALL;
    }
    for(i=0;i<MAX_SUBJECTS;++i) bitmap[i]=0;
    while(number) {
	if(isdigit(*number)) {
	    num = atoi(number);
	    if(num<1 || num>MAX_SUBJECTS) 
	    {
		*count = -1;
		return 0;
	    }
	    bitmap[num-1] = 1;
	}
	number=strtok(NULL, ", ");	
    }
    for(i=MAX_SUBJECTS-1;i>=0;--i) {
	if(bitmap[i]) {
	    bmask |= 1;
	    ++(*count);
	}
	bmask= bmask << 1;
    }
    return bmask; 
}


/*************************************************************************/
static int do_help(User *u)
{
    char *cmd = strtok(NULL, "");
    if(!cmd) 
	  {
		notice_help(s_NewsServ, u, NEWSS_HELP);
		
  		if(is_news_oper(u))
	  	  notice_help(s_NewsServ, u, NEWSS_HELP_OPER);
		  
		if(is_news_admin(u))
	  	  notice_help(s_NewsServ, u, NEWSS_HELP_ADMIN);
		  
		if(is_news_admin(u))
	  	  notice_help(s_NewsServ, u, NEWSS_HELP_SADMIN);
    } else 
	  nhelp_cmd(s_NewsServ, u, cmds, cmd);
    return 0;
}

/*************************************************************************
   subscribe subjects
   (set bits on the user news mask matching subjects )
 *************************************************************************/
static int do_subscribe (User *u)
{
    int count;
    int32 smask;

	if (!nick_identified(u)) {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	}
		
    smask=buildmask(&count);
    if(!count) {
        syntax_error(s_NewsServ, u, "SUBSCRIBE", NEWSS_SUBSCRIBE_SYNTAX);
	return 0;
	}
    if (count==-1) {
	notice_lang(s_NewsServ, u, NEWSS_SUBJECT_ERROR,MAX_SUBJECTS);
	return 0;
    }
    notice_lang(s_NewsServ, u, NEWSS_SUBSCRIBE_SUBSCRIBED,count);
    u->ni->news_mask |= smask;
    send_cmd(s_NewsServ,"SVSMODE %s +n %u",u->nick, u->ni->news_mask);
    return 1;
}

/*************************************************************************
   unsubscribe subjects
   (reset bits on the user news mask matching subjects )
 *************************************************************************/
static int do_unsubscribe (User *u)
{
    int count;
    int32 smask;

	if (!nick_identified(u)) 
	  {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	  }
	  
    smask=buildmask(&count);
    if(!count) {
        syntax_error(s_NewsServ, u, "UNSUBSCRIBE", NEWSS_UNSUBSCRIBE_SYNTAX);
	return 0;
	}
    if (count==-1) {
	notice_lang(s_NewsServ, u, NEWSS_SUBJECT_ERROR,MAX_SUBJECTS);
	return 0;
    }
    notice_lang(s_NewsServ, u, NEWSS_UNSUBSCRIBE_UNSUBSCRIBED,count);
    u->ni->news_mask &= (~smask | 1); /* never change bit 0 */
    send_cmd(s_NewsServ,"SVSMODE %s +n %u",u->nick,  u->ni->news_mask);
    return 1;
}

/*************************************************************************
   changes NewsServ options
 *************************************************************************/
static int do_set (User *u)
{
    char* option = strtok(NULL, " ");
    char* value = strtok(NULL, " ");

	if (!nick_identified(u)) 
	  {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	  }
	  
    if(!option || !value) {
	syntax_error(s_NewsServ, u, "SET", NEWSS_SET_SYNTAX);
	return 0;
    }
    if(!strcasecmp(option,"NOTICE")) {
	if(!strcasecmp(value,"ON")) {
	    u->ni->news_mask |= NM_NOTICE;
	    notice_lang(s_NewsServ, u, NEWSS_SET_NOTICE_ON);	    
	} else
	if(!strcasecmp(value,"OFF")) {	
	    u->ni->news_mask &= ~NM_NOTICE;
	    notice_lang(s_NewsServ, u, NEWSS_SET_NOTICE_OFF);
	} else
	{
	    syntax_error(s_NewsServ, u, "SET NOTICE", NEWSS_SET_NOTICE_SYNTAX);
	    return 0;	
	}
	send_cmd(s_NewsServ,"SVSMODE %s +n %u",u->nick,  u->ni->news_mask);	    	
	return 1;
    } 
    syntax_error(s_NewsServ, u, "SET NOTICE", NEWSS_SET_NOTICE_SYNTAX);
    return 0;
}

/*************************************************************************
    Lists all subjects and if they are subscribed or not
 *************************************************************************/
int do_list(User *u)
{
    int i;
    int32 checkmask=2; /* start from bit 1 */

	if (!nick_identified(u)) 
	  {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	  }

    notice_lang(s_NewsServ, u, NEWSS_LIST_HEADER);
    for(i=0;i<MAX_SUBJECTS;++i) {
	if(subjectlist[i])
	    notice_lang(s_NewsServ, u, NEWSS_LIST,i+1,
	     (u->ni->news_mask & checkmask) ? 'X' : ' ',
	     subjectlist[i]);
	//log("news_mask=%d, checkmask=%d",u->ni->news_mask,checkmask);
	checkmask = checkmask << 1;
	}
    notice_lang(s_NewsServ, u, NEWSS_LIST_END);	
    return 1;
}

/*************************************************************************
    Lists most recent sent news
 *************************************************************************/
int do_recent(User *u) {
    int i;
    struct tm *tm=NULL;
    char buf[512];

    /* If you haven't identified your nick, you don't have to see the most recent news
     * so you better identify your nickname (:
     * ^Stinger^
     */
    if(!nick_identified(u)) {
	notice_lang(s_NewsServ, u , NICK_IDENTIFY_REQUIRED, s_NickServ);
	return 0;
    }
     
    if(time(NULL) - u->lastnewsrecent < NWRecentDelay) 
	  {
		u->lastnewsrecent = time(NULL);
		notice_lang(s_NewsServ, u, NEWS_REC_PLEASE_WAIT, NSRegDelay);	
		return 0;
    }
    u->lastnewsrecent = time(NULL); /* lets keep time commad was issued to prevent flooding */
    private_lang(s_NewsServ, u, NEWSS_RECENT_HEADER);	
    for (i=news_cursor; i<MAX_LASTNEWS; ++i) {
	if(last_news[i].number && last_news[i].message) {
	    tm = localtime(&last_news[i].sent_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	    private_lang(s_NewsServ, u, NEWSS_RECENT_LIST,
	    buf,last_news[i].message);
	}
    }
    for (i=0; i<news_cursor; ++i) {
	if(last_news[i].number && last_news[i].message) {
	    tm = localtime(&last_news[i].sent_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	    private_lang(s_NewsServ, u, NEWSS_RECENT_LIST,
	    buf,last_news[i].message);
	}
    }    
    private_lang(s_NewsServ, u, NEWSS_RECENT_END);	
    return 1;
};

/*************************************************************************
    View most recent sent news
 *************************************************************************/
int do_view(User *u) {
    int i;
    struct tm *tm=NULL;
    char buf[512];

	if (!nick_identified(u)) 
	  {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	  }	
	
    private_lang(s_NewsServ, u, NEWSS_VIEW_HEADER);	
    for (i=news_cursor; i<MAX_LASTNEWS; ++i) {
	if(last_news[i].message) {
	    tm = localtime(&last_news[i].sent_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	    private_lang(s_NewsServ, u, NEWSS_VIEW_LIST,
	    last_news[i].number ? "" : "\2",
	    i+1,last_news[i].number, buf,last_news[i].message,
	    last_news[i].sender,
	    last_news[i].number ? "" : "\2"
	    );
	}
    }
    for (i=0; i<news_cursor; ++i) {
	if(last_news[i].message) {
	    tm = localtime(&last_news[i].sent_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	    private_lang(s_NewsServ, u, NEWSS_VIEW_LIST,
	    last_news[i].number ? "" : "\2",
	    i+1,last_news[i].number,buf,last_news[i].message,
	    last_news[i].sender,
	    last_news[i].number ? "" : "\2"
	    );
	  }
    }
    private_lang(s_NewsServ, u, NEWSS_RECENT_END);	
    return 1;
};

/*************************************************************************
    Deletes one entry from recent list
 *************************************************************************/
 
static int do_del (User *u)
{
    char* number = strtok(NULL, " ");
    int num=0;


	if (!nick_identified(u)) 
	  {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	  }
		
    if(!number) {
        syntax_error(s_NewsServ, u, "DEL", NEWSS_DEL_SYNTAX);
	return 0;
    }
    if(isdigit(*number))
	num = atoi(number);	
    if (num<1 || num>MAX_LASTNEWS) {
	notice_lang(s_NewsServ, u, NEWSS_SUBJECT_ERROR,MAX_LASTNEWS);
	return 0;
    }
    num--; 
    if(!last_news[num].message) {
	notice_lang(s_NewsServ, u, NEWSS_DEL_NOTEXIST,num+1);
    } else {
	notice_lang(s_NewsServ, u, NEWSS_DEL_DELETED,num+1);
	last_news[num].number = 0;
	return 1;
    }
    return 0;
}


/*************************************************************************
   send a news
 *************************************************************************/
static int do_send (User *u)
{
    int32 smask = 2 ; /* bit 0 is not used */
    char* number = strtok(NULL, " ");
    char* news = strtok(NULL, "");
    int num=0,i;

	if (!nick_identified(u)) 
	  {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	  }

    if(!number || !news) {
        syntax_error(s_NewsServ, u, "SEND", NEWSS_SEND_SYNTAX);
	return 0;
    }
    if(isdigit(*number))
	num = atoi(number);	
    if (num<1 || num>MAX_SUBJECTS) {
	notice_lang(s_NewsServ, u, NEWSS_SUBJECT_ERROR,MAX_SUBJECTS);
	return 0;
    }
    num--; /* base index 0 */
    if(!subjectlist[num]) {
	notice_lang(s_NewsServ, u, NEWSS_SUBJECT_NOTFOUND,num+1);
	return 0;
    }    
    for(i=0;i<num;i++)
	smask = smask << 1;
    notice_lang(s_NewsServ, u, NEWSS_SEND_SENT);
    send_cmd(s_NewsServ,"NEWS %ld %u :%s",
	    (long int) time(NULL), smask,news);	
    last_news[news_cursor].sent_time = time(NULL);
    strcpy(last_news[news_cursor].sender,u->nick);
    last_news[news_cursor].number = num+1;
    if(last_news[news_cursor].message)
	free(last_news[news_cursor].message);
    last_news[news_cursor].message = sstrdup(news); 
    if(++news_cursor>=MAX_LASTNEWS)
	news_cursor=0;
    return 1;
}

/*************************************************************************
   news oper list viewing/modification. 
 *************************************************************************/
static int do_oper(User *u)
{
    char *cmd, *nick;
    NickInfo *ni;
    int i;

    if (skeleton) {
	notice_lang(s_NewsServ, u, NEWSS_OPER_SKELETON);
	return 0;
    }
	

	if (!nick_identified(u)) 
	  {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	  }

    cmd = strtok(NULL, " ");
    if (!cmd)
	cmd = "";

    if (strcasecmp(cmd, "ADD") == 0) {
	if (!is_news_admin(u)) {
	    notice_lang(s_NewsServ, u, PERMISSION_DENIED);
	    return 0;
	}
	nick = strtok(NULL, " ");
	if (nick) {
	    if (!(ni = findnick(nick))) {
		notice_lang(s_NewsServ, u, NICK_X_NOT_REGISTERED, nick);
		return 0;
	    }
	    for (i = 0; i < MAX_NEWSOPERS; i++) {
		if (!news_opers[i] || news_opers[i] == ni)
		    break;
	    }
	    if (news_opers[i] == ni) {
		notice_lang(s_NewsServ, u, NEWSS_OPER_EXISTS, ni->nick);
	    } else if (i < MAX_NEWSOPERS) {
		news_opers[i] = ni;
		notice_lang(s_NewsServ, u, NEWSS_OPER_ADDED, ni->nick);
	    } else {
		notice_lang(s_NewsServ, u, NEWSS_OPER_TOO_MANY, MAX_NEWSOPERS);
	    }
	    if (readonly)
		notice_lang(s_NewsServ, u, READ_ONLY_MODE);
	} else {
	    syntax_error(s_NewsServ, u, "OPER", NEWSS_OPER_ADD_SYNTAX);
	}

    } else if (strcasecmp(cmd, "DEL") == 0) {
	if (!is_news_admin(u)) {
	    notice_lang(s_NewsServ, u, PERMISSION_DENIED);
	    return 0;
	}
	nick = strtok(NULL, " ");
	if (nick) {
	    if (!(ni = findnick(nick))) {
		notice_lang(s_NewsServ, u, NICK_X_NOT_REGISTERED, nick);
		return 0;
	    }
	    for (i = 0; i < MAX_NEWSOPERS; i++) {
		if (news_opers[i] == ni)
		    break;
	    }
	    if (i < MAX_NEWSOPERS) {
		news_opers[i] = NULL;
		notice_lang(s_NewsServ, u, NEWSS_OPER_REMOVED, ni->nick);
		if (readonly)
		    notice_lang(s_NewsServ, u, READ_ONLY_MODE);
	    } else {
		notice_lang(s_NewsServ, u, NEWSS_OPER_NOT_FOUND, ni->nick);
	    }
	} else {
	    syntax_error(s_NewsServ, u, "OPER", NEWSS_OPER_DEL_SYNTAX);
	}

    } else if (strcasecmp(cmd, "LIST") == 0) {
	notice_lang(s_NewsServ, u, NEWSS_OPER_LIST_HEADER);
	for (i = 0; i < MAX_NEWSOPERS; i++) {
	    if (news_opers[i])
		notice(s_NewsServ, u->nick, "%s", news_opers[i]->nick);
	}

    } else {
	syntax_error(s_NewsServ, u, "OPER", NEWSS_OPER_SYNTAX);
    }
    return 1;
}

/*************************************************************************/

/* Services admin list viewing/modification. */

static int do_admin(User *u)
{
    char *cmd, *nick;
    NickInfo *ni;
    int i;
		
    if (skeleton) 
	  {
		notice_lang(s_NewsServ, u, NEWSS_ADMIN_SKELETON);
		return 0;
  	  }
	  
	if (!nick_identified(u)) 
	  {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	  }
	  
    cmd = strtok(NULL, " ");
    if (!cmd)
	cmd = "";

    if (strcasecmp(cmd, "ADD") == 0) {
	if (!is_services_admin(u)) {
	    notice_lang(s_NewsServ, u, PERMISSION_DENIED);
	    return 0;
	}
	nick = strtok(NULL, " ");
	if (nick) {
	    if (!(ni = findnick(nick))) {
		notice_lang(s_NewsServ, u, NICK_X_NOT_REGISTERED, nick);
		return 0;
	    }
	    for (i = 0; i < MAX_NEWSADMINS; i++) {
		if (!news_admins[i] || news_admins[i] == ni)
		    break;
	    }
	    if (news_admins[i] == ni) {
		notice_lang(s_NewsServ, u, NEWSS_ADMIN_EXISTS, ni->nick);
	    } else if (i < MAX_NEWSADMINS) {
		news_admins[i] = ni;
		notice_lang(s_NewsServ, u, NEWSS_ADMIN_ADDED, ni->nick);
	    } else {
		notice_lang(s_NewsServ, u, NEWSS_ADMIN_TOO_MANY, MAX_NEWSADMINS);
	    }
	    if (readonly)
		notice_lang(s_NewsServ, u, READ_ONLY_MODE);
	} else {
	    syntax_error(s_NewsServ, u, "ADMIN", NEWSS_ADMIN_ADD_SYNTAX);
	}

    } else if (strcasecmp(cmd, "DEL") == 0) {
	if (!is_news_admin(u)) {
	    notice_lang(s_NewsServ, u, PERMISSION_DENIED);
	    return 0;
	}
	nick = strtok(NULL, " ");
	if (nick) {
	    if (!(ni = findnick(nick))) {
		notice_lang(s_NewsServ, u, NICK_X_NOT_REGISTERED, nick);
		return 0;
	    }
	    for (i = 0; i < MAX_NEWSADMINS; i++) {
		if (news_admins[i] == ni)
		    break;
	    }
	    if (i < MAX_NEWSADMINS) {
		news_admins[i] = NULL;
		notice_lang(s_NewsServ, u, NEWSS_ADMIN_REMOVED, ni->nick);
		if (readonly)
		    notice_lang(s_NewsServ, u, READ_ONLY_MODE);
	    } else {
		notice_lang(s_NewsServ, u, NEWSS_ADMIN_NOT_FOUND, ni->nick);
	    }
	} else {
	    syntax_error(s_NewsServ, u, "ADMIN", NEWSS_ADMIN_DEL_SYNTAX);
	}

    } else if (strcasecmp(cmd, "LIST") == 0) {
	notice_lang(s_NewsServ, u, NEWSS_ADMIN_LIST_HEADER);
	for (i = 0; i < MAX_NEWSADMINS; i++) {
	    if (news_admins[i])
		notice(s_NewsServ, u->nick, "%s", news_admins[i]->nick);
	}

    } else {
	syntax_error(s_NewsServ, u, "ADMIN", NEWSS_ADMIN_SYNTAX);
    }
    return 1;
}
/*************************************************************************
   Subject list managing
 *************************************************************************/
int do_subject(User *u)
{
    char* number = strtok(NULL, " ");
    char* subject = strtok(NULL, "");
    int i;
	
	if (!nick_identified(u)) 
	  {
	    notice_lang(s_NewsServ, u, NICK_IDENTIFY_REQUIRED, s_NickServ);
	    return 0;
	  }
	
    if(!number || !subject || !isdigit(*number)) {
	syntax_error(s_NewsServ, u, "SUBJECT", NEWSS_SUBJECT_SYNTAX);
	return 0;
    }
    i = strtol(number, (char **)&number, 10);
    if(i<1 || i>MAX_SUBJECTS) {
	    notice_lang(s_NewsServ, u, NEWSS_SUBJECT_ERROR,MAX_SUBJECTS);
	}
    --i; /* base index 0 */
    if(subjectlist[i]) {
	notice_lang(s_NewsServ, u, NEWSS_SUBJECT_CHANGED,subjectlist[i],subject);
	free(subjectlist[i]);	
    } else notice_lang(s_NewsServ, u, NEWSS_SUBJECT_CREATED,subject);
    subjectlist[i] = sstrdup(subject);
    return 1;
}

#endif /* #ifdef NEWS */

/*************************************************************************
   Main NewsServ routine. 
 *************************************************************************/
void newsserv(const char *source, char *buf) {
#ifdef NEWS
    char *cmd, *s;
#endif
    User *u = finduser(source);

    if (!u) {
	log2c("%s: user record for %s not found", s_NewsServ, source);
	notice(s_NewsServ, source,
		getstring(NULL, USER_RECORD_NOT_FOUND));
	return;
    }
#ifndef NEWS
    notice_lang(s_NickServ, u, FEATURE_DISABLED);
#else
    cmd = strtok(buf, " ");

    if (!cmd) {
	return;
    } else if (strcasecmp(cmd, "\1PING") == 0) {
	if (!(s = strtok(NULL, "")))
	    s = "\1";
	notice_s(s_NewsServ, source, "\1PING %s", s);
    } else if (skeleton) {
	notice_lang(s_NewsServ, u, SERVICE_OFFLINE, s_NickServ);
    } else {
	nrun_cmd(s_NewsServ, u, cmds, cmd);
    }
#endif
}

/* Load NewsServ data. */

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", NewsServDBName);	\
	failed = 1;					\
	break;						\
    }							\
} while (0)

void load_nw_dbase(void)
{
#ifndef NEWS
    return;
#else
    dbFILE *f;
    int16  i,j=0, n, ver, sver=0;
    char *s;
    int failed = 0;
    if (!(f = open_db(s_NewsServ, NewsServDBName, "r")))
	return;
    ver = get_file_version(f);
    read_int16(&sver, f);		    
    if(sver<1 || sver>DFV_NEWSSERV ) 
	fatal("Unsupported subversion (%d) on %s", sver, NewsServDBName);
    if(sver<DFV_NEWSSERV) 
        log1("NewsServ DataBase WARNING, reading from subversion %d to %d",
	    sver,DFV_NEWSSERV);	       
    SAFE(read_int16(&n, f));
    for (i = 0; i < n && !failed; i++) {
	SAFE(read_string(&s, f));
	if (s && i < MAX_NEWSADMINS)
	    news_admins[i] = findnick(s);
	if (s) {
	    free(s);
	}
    }
    if (!failed)
    SAFE(read_int16(&n, f));
    for (i = 0; i < n && !failed; i++) {
	SAFE(read_string(&s, f));
	if (s && i < MAX_NEWSOPERS)
	    news_opers[i] = findnick(s);
	if (s)
	    free(s);
    }
    if (!failed)
    SAFE(read_int16(&n, f));
    for (i = 0; i < n && !failed; i++) {
	SAFE(read_string(&s, f));
	if (s && i < MAX_SUBJECTS)
	    if(s[0]!='\0') subjectlist[i] = sstrdup(s);	    
	if (s) {
	    free(s);
	}	
    }
    SAFE(read_int16(&n, f));
    
    for (i = 0; i < n && !failed; i++) {
	 int tmp32;
	j = (i<MAX_LASTNEWS) ? i : i % MAX_LASTNEWS;
	SAFE(read_int32(&tmp32, f));
	last_news[j].sent_time = tmp32;
	SAFE(read_int16(&last_news[j].number, f));
	SAFE(read_string_buffer(last_news[j].sender, f));
	SAFE(read_string(&last_news[j].message, f));
    }
    news_cursor=j+1;    
    if(news_cursor>=MAX_LASTNEWS) 
	news_cursor=0;
    close_db(f);
#endif
}
#undef SAFE

/*************************************************************************/

/* Save NEWSSERV data. */

#define SAFE(x) do {						  \
    if ((x) < 0) {						  \
	restore_db(f);						  \
	log_perror("Write error on %s", NewsServDBName);	  \
	if (time(NULL) - lastwarn > WarningTimeout) {		  \
	    wallops(NULL, "Write error on %s: %s", NewsServDBName,\
			strerror(errno));			  \
	    lastwarn = time(NULL);				  \
	}							  \
	return;							  \
    }								  \
} while (0)

void save_nw_dbase(void)
{
#ifndef NEWS
    return;
#else
    dbFILE *f;
    int16 i, count = 0;
    static time_t lastwarn = 0;

    if (!(f = open_db(s_NewsServ, NewsServDBName, "w")))
	return;
    write_int16(DFV_NEWSSERV, f);
    for (i = 0; i < MAX_NEWSADMINS; i++) {
	if (news_admins[i])
	    count++;
    }
    SAFE(write_int16(count, f));
    for (i = 0; i < MAX_NEWSADMINS; i++) {
	if (news_admins[i])
	    SAFE(write_string(news_admins[i]->nick, f));
    }
    count = 0;
    for (i = 0; i < MAX_NEWSOPERS; i++) {
	if (news_opers[i])
	    count++;
    }
    SAFE(write_int16(count, f));
    for (i = 0; i < MAX_NEWSOPERS; i++) {
	if (news_opers[i])
	    SAFE(write_string(news_opers[i]->nick, f));
    }
    SAFE(write_int16(MAX_SUBJECTS, f));
    for (i = 0; i < MAX_SUBJECTS; i++) {
	if (subjectlist[i])
	    SAFE(write_string(subjectlist[i], f));
	else
	    SAFE(write_string("\0", f));
    }
    count=0;
    for (i = 0; i < MAX_LASTNEWS; i++) 
	if (last_news[i].message) 
	    ++count;
    SAFE(write_int16(count, f));
    for (i = 0; i < MAX_LASTNEWS; i++) {
	if (last_news[i].message) {
	    SAFE(write_int32(last_news[i].sent_time, f));
	    SAFE(write_int16(last_news[i].number, f));
	    SAFE(write_string(last_news[i].sender, f));
	    SAFE(write_string(last_news[i].message, f));
	}
    }
    close_db(f);
#endif
}

#undef SAFE
#ifdef NEWS
void newsserv_export(void) {
    FILE *exportfile;
    time_t t;
    struct tm *tm;    
    struct tm now;
    char buf[512];   
    int i; 
    if(!(exportfile=fopen(ExportFN,"wt"))) {
	log2c("Error opening newsserv export file!");
	return;
    }
    time(&t);
    now = *localtime(&t);
    strftime(buf, sizeof(buf)-1, "%Y/%m/%d %R", &now);
    fprintf(exportfile,"%s\n",buf);
    for (i=news_cursor-1; i>=0; --i) {
	if(last_news[i].number && last_news[i].message) {
	    tm = localtime(&last_news[i].sent_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	    fprintf(exportfile,"%s %i %s\n",
	    buf,last_news[i].number,last_news[i].message);	
	}
    }        
    for (i=MAX_LASTNEWS-1; i>=news_cursor; --i) {
	if(last_news[i].number && last_news[i].message) {
	    tm = localtime(&last_news[i].sent_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);
	    fprintf(exportfile,"%s %i %s\n",
	    buf,last_news[i].number,last_news[i].message);
	}
    }                
    fclose(exportfile);
}
#endif
