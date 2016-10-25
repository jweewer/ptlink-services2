/* Main header for Services.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2001
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services
 *$Id: services.h,v 1.13 2005/01/23 22:37:33 jpinto Exp $
 */

#ifndef SERVICES_H
#define SERVICES_H

/*************************************************************************/

#include "sysconf.h"
#include "config.h"
#include "stats.h"
#include "ircdsetup.h"

/* Some Linux boxes (or maybe glibc includes) require this for the
 * prototype of strsignal(). */
#define _GNU_SOURCE

/* Some AIX boxes define int16 and int32 on their own.  Blarph. */
#if INTTYPE_WORKAROUND
# define int16 builtin_int16
# define int32 builtin_int32
#endif

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
#include <errno.h>
#include <grp.h>
#include <limits.h>
#include <netdb.h>
#include <netinet/in.h>
#include <setjmp.h>
#include <sys/socket.h>
#include <sys/stat.h>	/* for umask() on some systems */
#include <sys/types.h>
#include <sys/time.h>
#include <sys/resource.h>	/* for setrlimit */

#if HAVE_MYSQL
/* will be done later */
# include <mysql.h>
#endif

#if HAVE_STRINGS_H
# include <strings.h>
#endif

#if HAVE_SYS_SELECT_H
# include <sys/select.h>
#endif

#ifdef _AIX
/* Some AIX boxes seem to have bogus includes that don't have these
 * prototypes. */
extern int strcasecmp(const char *, const char *);
extern int strncasecmp(const char *, const char *, size_t);
# if 0	/* These break on some AIX boxes (4.3.1 reported). */
extern int gettimeofday(struct timeval *, struct timezone *);
extern int socket(int, int, int);
extern int bind(int, struct sockaddr *, int);
extern int connect(int, struct sockaddr *, int);
extern int shutdown(int, int);
# endif
# undef FD_ZERO
# define FD_ZERO(p) memset((p), 0, sizeof(*(p)))
#endif /* _AIX */

/* Alias stricmp/strnicmp to strcasecmp/strncasecmp if we have the latter
 * but not the former. */
#if !HAVE_STRICMP && HAVE_STRCASECMP
# define stricmp strcasecmp
# define strnicmp strncasecmp
#endif

/* We have our own versions of toupper()/tolower(). */
#include <ctype.h>
#undef tolower
#undef toupper
#define tolower tolower_
#define toupper toupper_
extern int toupper(char), tolower(char);

/* We also have our own encrypt(). */
#define encrypt encrypt_


#if INTTYPE_WORKAROUND
# undef int16
# undef int32
#endif


/* Miscellaneous definitions. */
#include "defs.h"

/*************************************************************************/

/* Configuration sanity-checking: */

#if CHANNEL_MAXREG > 32767
# undef CHANNEL_MAXREG
# define CHANNEL_MAXREG	0
#endif
#if DEF_MAX_MEMOS > 32767
# undef DEF_MAX_MEMOS
# define DEF_MAX_MEMOS	0
#endif
#if MAX_SERVOPERS > 32767
# undef MAX_SERVOPERS
# define MAX_SERVOPERS 32767
#endif
#if MAX_SERVADMINS > 32767
# undef MAX_SERVADMINS
# define MAX_SERVADMINS 32767
#endif

/*************************************************************************/
/*************************************************************************/

/* Obsolete, new indivdual file version implemented
    just left here for compatibilty sake */
#define FILE_VERSION	8  

/*************************************************************************/

/* Memo info structures.  Since both nicknames and channels can have memos,
 * we encapsulate memo data in a MemoList to make it easier to handle. */

typedef struct memo_ Memo;
struct memo_ {
    uint32 number;	/* Index number -- not necessarily array position! */
    int16 flags;
    time_t time;	/* When it was sent */
    char sender[NICKMAX];
    char *text;
};

#define MF_UNREAD	0x0001	/* Memo has not yet been read */

typedef struct {
    int16 memocount, memomax;
    Memo *memos;

} MemoInfo;

typedef struct {
    int16 count, max;
    char **note;
} NoteInfo;

/*************************************************************************/

/* Nickname info structure.  Each nick structure is stored in one of 256
 * lists; the list is determined by the first character of the nick.  Nicks
 * are stored in alphabetical order within lists. */


typedef struct nickinfo_ NickInfo;

struct nickinfo_ {
    NickInfo *next, *prev;
    u_int32_t snid;        	/* services user id */
    NickInfo *hnextsnid;	/* next on snid hash */
    char nick[NICKMAX];
    int	crypt_method;
    char pass[PASSMAX];
    char auth[AUTHMAX];
    char *url;
    char *email;		/* validated email */
    char *email_request;	/* register/change email */
    char *icq_number;
    char *location;
    char *last_usermask;
    char *last_realname;
    char *last_quit;
    time_t time_registered;
    time_t last_identify;
    time_t last_seen;
    time_t last_signon;
    time_t first_TS;	/* for svs* TS */
    time_t birth_date;
    time_t suspension_expire;
    time_t last_email_request;
    int32 online;	/* total online time */
    int16 status;	/* See NS_* below */
    int32 news_mask;	/* news subscription bit mask, see NM_ below (on NewsServ) */
    int16 news_status;	/* news status bit mask, see NW_ below below (on NewsServ)*/
    NickInfo *link;	/* If non-NULL, nick to which this one is linked */
    int16 linkcount;	/* Number of links to this nick */

    /* All information from this point down is governed by links.  Note,
     * however, that channelcount is always saved, even for linked nicks
     * (thus removing the need to recount channels when unlinking a nick). */

    int32 flags;	/* See NI_* below */
    
    int16 ajoincount;  /* # of entries */
    char **autojoin;	/* Array of strings */
    MemoInfo memos;
    NoteInfo notes;
    uint16 channelcount;/* Number of channels currently registered */
    uint16 channelmax;	/* Maximum number of channels allowed */

    uint16 language;	/* Language selected by nickname owner (LANG_*) */

    int forcednicks;    /* forced nicks change since last identify/NickServ kill */
};


#define NUM_DOMS  16	/* The maximum size for the smart selection domain list */
typedef struct langinfo_ LangInfo;
struct langinfo_ {
    char domain[4];
    int language ;
};

/* Nickname status flags: */
#define NS_ENCRYPTEDPW	0x0001      /* Nickname password is encrypted */
#define NS_VERBOTEN	0x0002      /* Nick may not be registered or used */
#define NS_NO_EXPIRE	0x0004      /* Nick never expires */
#define NS_AUTH		0x0008	    /* Nick registration with valid AUTH code */

#define NS_IDENTIFIED	0x8000      /* User has IDENTIFY'd */
#define NS_RECOGNIZED	0x4000      /* ON_ACCESS true && SECURE flag not set */
#define NS_ON_ACCESS	0x2000      /* User comes from a known address */
#define NS_KILL_HELD	0x1000      /* Nick is being held after a kill */
#define NS_TEMPORARY	0xF000      /* All temporary status flags */


/* Nickname setting flags: */
#define NI_KILLPROTECT	0x00000001  /* Kill others who take this nick */
#define NI_SUSPENDED	0x00000002  /* old SAFE bit (STILL SET ON OLD DBs) */
#define NI_MEMO_HARDMAX	0x00000008  /* Don't allow user to change memo limit */
#define NI_MEMO_SIGNON	0x00000010  /* Notify of memos at signon and un-away */
#define NI_MEMO_RECEIVE	0x00000020  /* Notify of new memos when sent */
#define NI_PRIVATE	0x00000040  /* Don't show in LIST to non-servadmins */
#define NI_HIDE_EMAIL	0x00000080  /* Don't show E-mail in INFO */
/* free 0x00000100 */  /* Don't show last seen address in INFO */
#define NI_HIDE_QUIT	0x00000200  /* Don't show last quit message in INFO */
#define NI_KILL_QUICK	0x00000400  /* Kill in 20 seconds instead of 60 */
#define NI_KILL_IMMED	0x00000800  /* Kill immediately instead of in 60 sec */
#define NI_AUTO_JOIN   	0x00001000  /* Make users autojoin on identify */
#define NI_DROPPED	0x00002000  /* This nick is drop pending */
#define NI_OSUSPENDED	0x00004000  /* Oper suspension */ 
#define NI_NEWSLETTER	0x00008000  /* want to receive newsletter ? */
#define NI_PRIVMSG	0x00010000  /* wants to receive privmsgs */

/* Languages.  Never insert anything in the middle of this list, or
 * everybody will start getting the wrong language!  If you want to change
 * the order the languages are displayed in for NickServ HELP SET LANGUAGE,
 * do it in language.c.
 */
#define LANG_EN_US	0	/* United States English */
#define LANG_PT		1	/* Portugese */
#define LANG_TR		2	/* Turkish */
#define LANG_DE		3	/* German */
#define LANG_IT		4	/* Italian */
#define LANG_NL		5	/* Netherlands */
#define LANG_PT_BR	6	/* Brazil Portuguese */

#define NUM_LANGS	7	/* Number of languages */

/* Sanity-check on default language value */
#if DEF_LANGUAGE < 0 || DEF_LANGUAGE >= NUM_LANGS
# error Invalid value for DEF_LANGUAGE: must be >= 0 and < NUM_LANGS
#endif

/*************************************************************************/

/* Channel info structures.  Stored similarly to the nicks, except that
 * the second character of the channel name, not the first, is used to
 * determine the list.  (Hashing based on the first character of the name
 * wouldn't get very far. ;) ) */

/* Access levels for users. */
typedef struct {
    int16 in_use;	/* 1 if this entry is in use, else 0 */
    int16 level;
    NickInfo *ni;	/* Guaranteed to be non-NULL if in use, NULL if not */
    NickInfo *who;	/* who last added/changed this access entry */
} ChanAccess;

/* Note that these two levels also serve as exclusive boundaries for valid
 * access levels.  ACCESS_FOUNDER may be assumed to be strictly greater
 * than any valid access level, and ACCESS_INVALID may be assumed to be
 * strictly less than any valid access level.
 */
#define ACCESS_FOUNDER	10000	/* Numeric level indicating founder access */
#define ACCESS_INVALID	-10000	/* Used in levels[] for disabled settings */

/* AutoKick data. */
typedef struct {
    int16 in_use;
    int16 is_nick;	/* 1 if a regged nickname, 0 if a nick!user@host mask */
			/* Always 0 if not in use */
    char *mask;	/* Guaranteed to be non-NULL if in use, NULL if not */
    char *reason;
    NickInfo *who;	/* who added the akick */
    time_t last_kick;	/* last time this akick was triggered */
} AutoKick;

typedef struct chaninfo_ ChannelInfo;
struct chaninfo_ {
    ChannelInfo *next, *prev;
    u_int32_t scid;		/* services channel id */
    char name[CHANMAX];    
    NickInfo *founder;
    NickInfo *successor;		/* Who gets the channel if the founder
					 * nick is dropped or expires */
    char founderpass[PASSMAX];
    char *desc;
    char *url;
    char *email;

    time_t time_registered;
    time_t last_used;
    char *last_topic;			/* Last topic on the channel */
    char last_topic_setter[NICKMAX];	/* Who set the last topic */
    time_t last_topic_time;		/* When the last topic was set */

    int32 flags;			/* See below */
    int16  crypt_method;		/* encryption method */    
    time_t drop_time;			/* Time when drop command was issued
					   (only applicable if CI_DROPPED */
    int16 *levels;			/* Access levels for commands */

    int16 accesscount;
    ChanAccess *access;			/* List of authorized users */
    int16 akickcount;
    AutoKick *akick;			/* List of users to kickban */

    int32 mlock_on, mlock_off;		/* See channel modes below */
    int32 mlock_limit;			/* 0 if no limit */
    char *mlock_key;			/* NULL if no key */

    char *entry_message;		/* Notice sent on entering channel */

    MemoInfo memos;

    struct channel_ *c;			/* Pointer to channel record (if   *
					 *    channel is currently in use) */
    time_t maxtime;
    int16 maxusers;					 
};

#define CI_KEEPTOPIC	0x00000001 /* Retain topic even after last person leaves channel */
#define CI_SECUREOPS	0x00000002 /* Don't allow non-authorized users to be opped */
#define CI_PRIVATE	0x00000004 /* Hide channel from ChanServ LIST command */
#define CI_TOPICLOCK	0x00000008 /* Topic can only be changed by SET TOPIC */
#define CI_RESTRICTED	0x00000010 /* Those not allowed ops are kickbanned */
#define CI_LEAVEOPS	0x00000020 /* Don't auto-deop anyone */
#define CI_VERBOTEN	0x00000080 /* Don't allow the channel to be registered or used */
#define CI_ENCRYPTEDPW	0x00000100 /* obsolete by crypt_method */
#define CI_NO_EXPIRE	0x00000200 /* Channel does not expire */
#define CI_MEMO_HARDMAX	0x00000400 /* Channel memo limit may not be changed */
#define CI_OPNOTICE	0x00000800 /* Send notice to channel on use of OP/DEOP */
#define CI_DROPPED	0x00001000 /* Channel was dropped */
#define CI_NOLINKS	0x00002000 /* Restrict access level recognition to real nick (ignoring links) */
#define CI_TOPICENTRY	0x00004000 /* Show topic on entry-msg */

/* Indices for cmd_access[]: */
#define CA_INVITE	0
#define CA_AKICK	1
#define CA_SET		2	/* but not FOUNDER or PASSWORD */
#define CA_UNBAN	3
#define CA_AUTOOP	4
#define CA_AUTODEOP	5	/* Maximum, not minimum */
#define CA_AUTOVOICE	6
#define CA_OPDEOP	7	/* ChanServ commands OP and DEOP */
#define CA_ACCESS_LIST	8
#define CA_CLEAR	9
#define CA_NOJOIN	10	/* Maximum */
#define CA_ACCESS_CHANGE 11
#define CA_MEMOREAD	12
#define CA_PROTECT	13
#define CA_KICK		14
#define CA_MEMOSEND	15
#define CA_MEMODEL	16
#define CA_VOICEDEVOICE 17 /* ChanServ commands VOICE and DEVOICE */
#ifdef HALFOPS
#define CA_AUTOHALFOP	18
#define CA_HALFOPDEOP	19
#define CA_SIZE		20
#else
#define CA_SIZE		18
#endif

/*************************************************************************/

/* Online user and channel data. */

typedef struct user_ User;
typedef struct user_ IRC_User;
typedef struct channel_ Channel;
typedef struct channel_ IRC_Chan;
typedef struct session_ Session;

struct user_ {
    IRC_User *hnext;     
    char nick[NICKMAX];
    NickInfo *ni;			/* Effective NickInfo (not a link) */
    NickInfo *real_ni;			/* Real NickInfo (ni.nick==user.nick) */
    char *username;
    char *host;				/* User's hostname */
    char *hiddenhost;
    char *realname;
    char *server;			/* Name of server user is on */
    time_t local_TS;			/* local TS for nick (last nick change) */
    time_t first_TS;			/* TS from nick introduction */
    int32 mode;				/* See below */
    struct u_chanlist {
	struct u_chanlist *next, *prev;
	Channel *chan;
    } *chans;				/* Channels user has joined */
    struct u_chaninfolist {
	struct u_chaninfolist *next, *prev;
	ChannelInfo *chan;
    } *founder_chans;			/* Channels user has identified for */
    short invalid_pw_count;		/* # of invalid password attempts */
    time_t invalid_pw_time;		/* Time of last invalid password */
    time_t lastmemosend;		/* Last time MS SEND command used */
    time_t lastnickreg;			/* Last time NS REGISTER cmd used */
    time_t lastnewsrecent;		/* Last time NW RECENT cmd was used */
    time_t on_ghost;			/* time when GHOST command was issued */        
    time_t lastmail;			/* time when SENDPASS command was used */
    int language;			/* language setinf from smart selection system */
    time_t maxtime;
    Session *session;
    int is_msg;				/* user wants to receive privmsg from services */
};

#define UMODE_o 0x00000001
/* 0x00000002 is free */
/* 0x00000004 is free */
/* 0x00000008 is free */
/* 0x00000010 is free */
#define UMODE_h 0x00000020
#define UMODE_r 0x00000040
/* 0x00000080 is free */
#define UMODE_B 0x00000100
/* 0x00000200 is free */
#define UMODE_W 0x00000400 /* not a real umode, just a web user mark */

struct channel_ {
    IRC_Chan *hnextch;   
    char name[CHANMAX];
    ChannelInfo *ci;			/* Corresponding ChannelInfo */
    time_t creation_time;		/* When channel was created */

    char *topic;
    char topic_setter[NICKMAX];		/* Who set the topic */
    time_t topic_time;			/* When topic was set */

    int32 mode;				/* Binary modes only */
    int32 limit;			/* 0 if none */
    char *key;				/* NULL if none */

    int32 bancount, bansize;
    char **bans;

    struct c_userlist {
	struct c_userlist *next, *prev;
	User *user;
#ifdef HALFOPS
    } *users, *chanops, *voices, *halfops;
#else
    } *users, *chanops, *voices;
#endif

    time_t server_modetime;		/* Time of last server MODE */
    time_t chanserv_modetime;		/* Time of last check_modes() */
    time_t TS3_stamp;			/* TimeStamp for TS3 protocol */
    int16 server_modecount;		/* Number of server MODEs this second */
    int16 chanserv_modecount;		/* Number of check_mode()'s this sec */
    int16 bouncy_modes;			/* Did we fail to set modes here? */
    int16 maxusers;
    time_t maxtime;
    int16 n_users;    
};

#define CMODE_I  0x00000001
#define CMODE_M  0x00000002
#define CMODE_n  0x00000004
#define CMODE_P  0x00000008
#define CMODE_s  0x00000010
#define CMODE_T  0x00000020
#define CMODE_k  0x00000040		/* These two used only by ChanServ */
#define CMODE_l  0x00000080
#define CMODE_q	 0x00000100
#define CMODE_R  0x00000200
#define CMODE_c  0x00000400
#define CMODE_K  0x00000800
#define CMODE_O	 0x00001000
#define CMODE_A	 0x00002000
#define CMODE_S	 0x00004000
#define CMODE_d	 0x00008000
#define CMODE_B  0x00010000
#define CMODE_N	 0x00020000
#define CMODE_C  0x00040000

/* Flags for user chan modes on SJOIN */
#define IS_OP	 0x00000001
#define IS_VOICE 0x00000002
#define IS_ADMIN 0x00000004
#ifdef HALFOPS
#define IS_HALFOP 0x00000008
#endif
/*************************************************************************/

/* Constants for news types. */

#define NEWS_LOGON	0
#define NEWS_OPER	1

/*************************************************************************/

 

/* Ignorance list data. */

typedef struct ignore_data {
    struct ignore_data *next;
    char who[NICKMAX];
    time_t time;	/* When do we stop ignoring them? */
} IgnoreData;

/*************************************************************************/
#define MAXCHANLEN 31 /* Maximum length allowed for a channel name */

struct DayStats_ {
    long ns_total;
    long ns_registered;
    long ns_dropped;
    long ns_expired;
    long cs_total;
    long cs_registered;
    long cs_dropped;
    long cs_expired;    
    long os_admins;
} DayStats;

struct Count_ {
    int32  users;	/* total users count */
    int32  users_max;	/* users count max */
    time_t users_max_time;    
    int32  bots;	
    int32  bots_max;	
    time_t bots_max_time;    
    int32  opers;	
    int32  opers_max;	
    time_t opers_max_time;        
    int32  helpers;	
    int32  helpers_max;	
    time_t helpers_max_time;            
} Count;

typedef struct senddomain_ SendDomain;
struct senddomain_ {
    char* domain;
    SendDomain *next;
};


struct session_ {
    Session *prev, *next;
    char *host;
    int count;			/* Number of clients with this host */
    int penalty;		/* For repeated connection attempts */
};


#define HOSTLEN         63      /* Length of hostname */


/* in-memory nick/chan info hash size */
#define N_MAX   0xFFFF
#define C_MAX	0xffff

/* Some nice macros */
#define IsOper(x) 	((x)->mode & UMODE_o)
#define SetOper(x)	((x)->mode |= UMODE_o)
#define ClearOper(x)	((x)->mode &= ~UMODE_o)
#define IsHelper(x) 	((x)->mode & UMODE_h)
#define SetHelper(x)	((x)->mode |= UMODE_h)
#define ClearHelper(x)	((x)->mode &= ~UMODE_h)
#define IsBot(x) 	((x)->mode & UMODE_B)
#define SetBot(x)	((x)->mode |= UMODE_B)
#define ClearBot(x)	((x)->mode &= ~UMODE_B)
#define IsWeb(x) 	((x)->mode & UMODE_W)
#define SetWeb(x)	((x)->mode |= UMODE_W)
#define ClearWeb(x)	((x)->mode &= ~UMODE_W)

#include "extern.h"

/* ircsvs3 compatibily macros */
#define NFL_PRIVATE   	0x00000001      /* nick info is private */
#define NFL_FORBIDDEN   0x00000002      /* nick is forbidden */
#define NFL_NOEXPIRE    0x00000004      /* nick will not expire */
#define NFL_NEWSLETTER  0x00000008      /* nick should received  newsletter */

#define CFL_PRIVATE     0x00000001      /* chan info is private */
#define CFL_FORBIDDEN   0x00000002      /* chan is forbidden */
#define CFL_NOEXPIRE    0x00000004      /* chan will not expire */
#define CFL_OPNOTICE    0x00000008      /* send opnotice messages */

#define IsRegistered(x)         ((x)->flags & FL_REGISTERED)
#define SetRegistered(x)        ((x)->flags |= FL_REGISTERED)
                                                                                
#define IsIdentified(x)         ((x)->status & FL_REGISTERED)
#define SetIdentified(x)        ((x)->status |= FL_REGISTERED)
                                                                                
#define IsForbidden(x)          ((x)->status & FL_FORBIDDEN)
#define SetForbidden(x)         ((x)->status |= FL_FORBIDDEN)

/*************************************************************************/

#endif	/* SERVICES_H */
