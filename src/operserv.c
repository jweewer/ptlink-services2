/* OperServ functions.
 *
 * PTlink Services is (C) 1999-2000, PTlink IRC Software
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services
 * $Id:
*/
#include "services.h"
#include "pseudo.h"
#include "ircdsetup.h"
#define DFV_OPERSERV 2
/*************************************************************************/

/* Services admin list */
static NickInfo *services_admins[MAX_SERVADMINS];

/* Services operator list */
static NickInfo *services_opers[MAX_SERVOPERS];


/* Last nick forcing databases update */
char *last_updater = NULL;
time_t last_update_request; /* time */

struct clone {
    char *host;
    long time;
};


/*************************************************************************/
extern void delink(NickInfo *ni);

/*************************************************************************/
static void do_help(User *u);
static void do_global(User *u);
static void do_stats(User *u);
static void do_admin(User *u);
static void do_oper(User *u);
static void do_os_mode(User *u);
static void do_clearmodes(User *u);
static void do_os_kick(User *u);
static void do_sendpass(User *u);
static void do_set(User *u);
static void do_jupe(User *u);
static void do_raw(User *u);
static void do_update(User *u);
static void do_os_quit(User *u);
static void do_shutdown(User *u);
static void do_restart(User *u);
static void do_rehash(User *u);
static void do_listignore(User *u);
static void do_getfounder(User *u);
static void do_reset(User *u);
static void do_securemode(User *u);
/*************************************************************************/

static Command cmds[] = {
    { "HELP",       do_help,       NULL,  -1,                   -1,-1,-1,-1 },
    { "GLOBAL",     do_global,     NULL,  OPER_HELP_GLOBAL,     -1,-1,-1,-1 },
    { "STATS",      do_stats,      NULL,  OPER_HELP_STATS,      -1,-1,-1,-1 },
    { "UPTIME",     do_stats,      NULL,  OPER_HELP_STATS,      -1,-1,-1,-1 },

    /* Anyone can use the LIST option to the ADMIN and OPER commands; those
     * routines check privileges to ensure that only authorized users
     * modify the list. */
    { "ADMIN",      do_admin,      NULL,  OPER_HELP_ADMIN,      -1,-1,-1,-1 },
    { "OPER",       do_oper,       NULL,  OPER_HELP_OPER,       -1,-1,-1,-1 },
    /* Similarly, anyone can use *NEWS LIST, but *NEWS {ADD,DEL} are
     * reserved for Services admins. */
    { "LOGONNEWS",  do_logonnews,  NULL,  NEWS_HELP_LOGON,      -1,-1,-1,-1 },
    { "OPERNEWS",   do_opernews,   NULL,  NEWS_HELP_OPER,       -1,-1,-1,-1 },

    /* Commands for Services opers: */
    { "MODE",       do_os_mode,    is_services_oper,
	OPER_HELP_MODE, -1,-1,-1,-1 },
    { "CLEARMODES", do_clearmodes, is_services_oper,
	OPER_HELP_CLEARMODES, -1,-1,-1,-1 },
    { "KICK",       do_os_kick,    is_services_oper,
	OPER_HELP_KICK, -1,-1,-1,-1 },
    { "AKILL",      do_akill,      is_services_oper,
	OPER_HELP_AKILL, -1,-1,-1,-1 },
    { "BOT",      do_botlist,  is_services_oper,
	OPER_HELP_BOTLIST, -1,-1,-1,-1 },	
    { "SENDPASS",       do_sendpass,  is_services_oper,
	OPER_HELP_SENDPASS, -1,-1,-1,-1 },	
    { "VLINE",       do_vline,  is_services_oper,
	OPER_HELP_VLINE, -1,-1,-1,-1 },	
    { "SXLINE",	     do_sxline, is_services_oper,
	OPER_HELP_SXLINE, -1,-1,-1,-1 },
    { "SESSION",   do_session,   is_services_oper,
        OPER_HELP_SESSION,-1,-1,-1,-1 },        
    /* Commands for Services admins: */
    { "SQLINE",       do_sqline,  is_services_admin,
	OPER_HELP_SQLINE, -1,-1,-1,-1 },    
    { "VLINK",	      do_vlink,	  is_services_admin,
	OPER_HELP_VLINK, -1,-1,-1,-1 },
    { "SET",        do_set,        is_services_admin,
	OPER_HELP_SET, -1,-1,-1,-1 },
    { "SET READONLY",0,0,  OPER_HELP_SET_READONLY, -1,-1,-1,-1 },
    { "SET DEBUG",0,0,     OPER_HELP_SET_DEBUG, -1,-1,-1,-1 },
    { "JUPE",       do_jupe,       is_services_admin,
	OPER_HELP_JUPE, -1,-1,-1,-1 },
    { "RAW",        do_raw,        is_services_root,
	OPER_HELP_RAW, -1,-1,-1,-1 },
    { "UPDATE",     do_update,     is_services_admin,
	OPER_HELP_UPDATE, -1,-1,-1,-1 },
    { "QUIT",       do_os_quit,    is_services_admin,
	OPER_HELP_QUIT, -1,-1,-1,-1 },
    { "SHUTDOWN",   do_shutdown,   is_services_admin,
	OPER_HELP_SHUTDOWN, -1,-1,-1,-1 },
    { "RESTART",    do_restart,    is_services_admin,
	OPER_HELP_RESTART, -1,-1,-1,-1 },
    { "REHASH",    do_rehash,    is_services_admin,	
	OPER_HELP_REHASH, -1,-1,-1,-1 },	
    { "LISTIGNORE", do_listignore, is_services_admin,	-1,-1,-1,-1, -1 },
    { "GETFOUNDER", do_getfounder, is_services_admin,	
	OPER_HELP_GETFOUNDER ,-1,-1,-1, -1 },
    { "RESET", 		do_reset, 		is_services_admin,	-1,-1,-1,-1, -1 },
    { "SECUREMODE",	do_securemode, is_services_admin,	OPER_HELP_SECUREMODE,-1,-1,-1, -1 },
    /* Fencepost: */
    { NULL }
};

/*************************************************************************/
/*************************************************************************/

/* OperServ initialization. */

void os_init(void)
{
    Command *cmd;

    cmd = lookup_cmd(cmds, "GLOBAL");
    if (cmd)
	cmd->help_param1 = s_GlobalNoticer;
    cmd = lookup_cmd(cmds, "ADMIN");
    if (cmd)
	cmd->help_param1 = s_NickServ;
    cmd = lookup_cmd(cmds, "OPER");
    if (cmd)
	cmd->help_param1 = s_NickServ;
}

/*************************************************************************/

/* Main OperServ routine. */

void operserv(const char *source, char *buf)
{
    char *cmd;
    char *s;
    User *u = finduser(source);

    if (!u) {
	log2c("%s: user record for %s not found", s_OperServ, source);
	notice(s_OperServ, source,
		getstring(NULL, USER_RECORD_NOT_FOUND));
	return;
    }

    log1("%s: %s: %s", s_OperServ, source, buf);

    cmd = strtok(buf, " ");
    if (!cmd) {
	return;
    } else if (strcasecmp(cmd, "\1PING") == 0) {
	if (!(s = strtok(NULL, "")))
	    s = "\1";
	notice_s(s_OperServ, source, "\1PING %s", s);
    } else {
	run_cmd(s_OperServ, u, cmds, cmd);
    }
}

/*************************************************************************/
/**************************** Privilege checks ***************************/
/*************************************************************************/

/* Load OperServ data. */

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", OperDBName);	\
	failed = 1;					\
	break;						\
    }							\
} while (0)

void load_os_dbase(void)
{
    dbFILE *f;
    int16  i, n, ver, sver=0;
    char *s;
    int failed = 0;
    if (!(f = open_db(s_OperServ, OperDBName, "r")))
	return;
    switch (ver = get_file_version(f)) {
      case -1:  read_int16(&sver, f);		    
		if(sver<1 || sver>DFV_OPERSERV ) 
		    fatal("Unsupported subversion (%d) on %s", sver, OperDBName);
		if(sver<DFV_OPERSERV) 
		    log1("OperServ DataBase WARNING, reading from subversion %d to %d",
		    sver,DFV_OPERSERV);	       
      case 7:
      case 6:
      case 5:
	SAFE(read_int16(&n, f));
	for (i = 0; i < n && !failed; i++) {
	    SAFE(read_string(&s, f));
	    if (s && i < MAX_SERVADMINS)
		services_admins[i] = findnick(s);
	    if (s) {
		free(s);
		DayStats.os_admins++;
	    }
	}
	if (!failed)
	    SAFE(read_int16(&n, f));
	for (i = 0; i < n && !failed; i++) {
	    SAFE(read_string(&s, f));
	    if (s && i < MAX_SERVOPERS)
		services_opers[i] = findnick(s);
	    if (s)
		free(s);
	}
	if ((ver==7) || sver) {
	    int32 tmp32;
	    SAFE(read_int32(&Count.users_max, f));
	    SAFE(read_int32(&tmp32, f));
	    Count.users_max_time = tmp32;
	}
	if (sver>1) {
	    int32 tmp32;
	    SAFE(read_int32(&Count.opers_max, f));
	    SAFE(read_int32(&tmp32, f));
	    Count.opers_max_time = tmp32;
	    SAFE(read_int32(&Count.helpers_max, f));
	    SAFE(read_int32(&tmp32, f));
	    Count.helpers_max_time = tmp32;	    	    	    
	    SAFE(read_int32(&Count.bots_max, f));
	    SAFE(read_int32(&tmp32, f));
	    Count.bots_max_time = tmp32;	    
	}
	break;

      case 4:
      case 3:
	SAFE(read_int16(&n, f));
	for (i = 0; i < n && !failed; i++) {
	    SAFE(read_string(&s, f));
	    if (s && i < MAX_SERVADMINS)
		services_admins[i] = findnick(s);
	    if (s)
		free(s);
	}
	break;

      default:
	fatal("Unsupported version (%d) on %s", ver, OperDBName);
    } /* switch (version) */
    close_db(f);
}

#undef SAFE

/*************************************************************************/

/* Save OperServ data. */

#define SAFE(x) do {						\
    if ((x) < 0) {						\
	restore_db(f);						\
	log_perror("Write error on %s", OperDBName);		\
	if (time(NULL) - lastwarn > WarningTimeout) {		\
	    wallops(NULL, "Write error on %s: %s", OperDBName,	\
			strerror(errno));			\
	    lastwarn = time(NULL);				\
	}							\
	return;							\
    }								\
} while (0)

void save_os_dbase(void)
{
    dbFILE *f;
    int16 i, count = 0;
    static time_t lastwarn = 0;

    if (!(f = open_db(s_OperServ, OperDBName, "w")))
	return;
    write_int16(DFV_OPERSERV, f);
    for (i = 0; i < MAX_SERVADMINS; i++) {
	if (services_admins[i])
	    count++;
    }
    SAFE(write_int16(count, f));
    for (i = 0; i < MAX_SERVADMINS; i++) {
	if (services_admins[i])
	    SAFE(write_string(services_admins[i]->nick, f));
    }
    count = 0;
    for (i = 0; i < MAX_SERVOPERS; i++) {
	if (services_opers[i])
	    count++;
    }
    SAFE(write_int16(count, f));
    for (i = 0; i < MAX_SERVOPERS; i++) {
	if (services_opers[i])
	    SAFE(write_string(services_opers[i]->nick, f));
    }
    SAFE(write_int32(Count.users_max, f));
    SAFE(write_int32(Count.users_max_time, f));
    SAFE(write_int32(Count.opers_max, f));
    SAFE(write_int32(Count.opers_max_time, f));
    SAFE(write_int32(Count.helpers_max, f));
    SAFE(write_int32(Count.helpers_max_time, f));        
    SAFE(write_int32(Count.bots_max, f));
    SAFE(write_int32(Count.bots_max_time, f));    
    close_db(f);
}

#undef SAFE

/*************************************************************************/
/* Does the given user have Services root privileges? */
int is_services_root_no_oper(User *u)
{
    char* lookroot;
    if (!nick_restrict_identified(u)) 
	return 0;
    else if(skeleton) return 1;
    lookroot = strstr(ServicesRoot,u->nick);
    if (!lookroot)  return 0; 
    if ((lookroot != ServicesRoot) && (*((char*) lookroot-1) != ','))
	return 0; 
    if (*((char*) (lookroot+strlen(u->nick))) != '\0' &&
	*((char*) (lookroot+strlen(u->nick))) != ',')
	return 0; 
    return 1;
}

/*************************************************************************/
/* Does the given user have Services root privileges? */
int is_services_root(User *u)
{
    char* lookroot;
    if (!IsOper(u) || !nick_restrict_identified(u)) 
	return 0;
    else if(skeleton) return 1;
    lookroot = strstr(ServicesRoot,u->nick);
    if (!lookroot)  return 0; 
    if ((lookroot != ServicesRoot) && (*((char*) lookroot-1) != ','))
	return 0; 
    if (*((char*) (lookroot+strlen(u->nick))) != '\0' &&
	*((char*) (lookroot+strlen(u->nick))) != ',')
	return 0; 
    return 1;
}


/*************************************************************************/
/* Does the given user have Services admin privileges? */
int is_services_admin_no_oper(User *u)
{
    int i;
    if (is_services_root_no_oper(u))
	return 1;
    if (skeleton)
	return 1;
    for (i = 0; i < MAX_SERVADMINS; i++) {
	if (services_admins[i] && u->ni == getlink(services_admins[i])) {
	    return OSNoAutoRecon ? 
	    nick_restrict_identified(u) : nick_identified(u);
	}
    }
    return 0;
}

/*************************************************************************/
/* Does the given user have Services admin privileges? */
int is_services_admin(User *u)
{
    int i;
    if(!IsOper(u))
	return 0;
    if (is_services_root(u))
	return 1;
    if (skeleton)
	return 1;
    for (i = 0; i < MAX_SERVADMINS; i++) {
	if (services_admins[i] && u->ni == getlink(services_admins[i])) {
	    return OSNoAutoRecon ? 
	    nick_restrict_identified(u) : nick_identified(u);
	}
    }
    return 0;
}


/*************************************************************************/

/*************************************************************************/

/* Does the given user have Services admin nick? */

int is_services_admin_nick(NickInfo *ni)
{
    int i;
    if (skeleton)
	return 1;
    for (i = 0; i < MAX_SERVADMINS; i++) {
	if (services_admins[i] && ni == getlink(services_admins[i])) {
	    return 1;
	}
    }
    return 0;
}

/*************************************************************************
  Does the given user have Services oper privileges? 
  Will require user to be oper
 *************************************************************************/
int is_services_oper(User *u)
{
    int i;
    if(!IsOper(u))
	return 0;
    if (is_services_admin(u))
	return 1;
    if (skeleton)
	return 1;
    for (i = 0; i < MAX_SERVOPERS; i++) {
	if (services_opers[i] && u->ni == getlink(services_opers[i])) {
	    return OSNoAutoRecon ? 
	    nick_restrict_identified(u) : nick_identified(u) ;
	}
    }
    return 0;
}

/*************************************************************************
  Does the given user have Services oper privileges? 
  Just used on /oper check, user does not need to have oper
 *************************************************************************/
int is_services_oper_no_oper(User *u)
{
    int i;
    if (is_services_admin_no_oper(u))
	return 1;
    if (skeleton)
	return 1;
    for (i = 0; i < MAX_SERVOPERS; i++) {
	if (services_opers[i] && u->ni == getlink(services_opers[i])) {
	    return OSNoAutoRecon ? 
	    nick_restrict_identified(u) : nick_identified(u) ;
	}
    }
    return 0;
}


/*************************************************************************/

/* Expunge a deleted nick from the Services admin/oper lists. */

void os_remove_nick(const NickInfo *ni)
{
    int i;

    for (i = 0; i < MAX_SERVADMINS; i++) {
	if (services_admins[i] == ni)
	    services_admins[i] = NULL;
    }
    for (i = 0; i < MAX_SERVOPERS; i++) {
	if (services_opers[i] == ni)
	    services_opers[i] = NULL;
    }
}


/*************************************************************************/
/*********************** OperServ command functions **********************/
/*************************************************************************/

/* HELP command. */

static void do_help(User *u)
{
    const char *cmd = strtok(NULL, "");

    if (!cmd) {
	notice_help(s_OperServ, u, OPER_HELP);
    } else {
	help_cmd(s_OperServ, u, cmds, cmd);
    }
}

/*************************************************************************/

/* Global notice sending via GlobalNoticer. */

static void do_global(User *u)
{
    char *msg = strtok(NULL, "");

    if (!msg) {
	syntax_error(s_OperServ, u, "GLOBAL", OPER_GLOBAL_SYNTAX);
	return;
    }
    send_global(msg);
    if(strlen(msg)>500) 
	msg[500]='\0'; /* prevent buffer overflow */
    chanlog("Global from %s : %s",u->nick,msg);
}

/*************************************************************************/

/* STATS command. */

static void do_stats(User *u)
{
    time_t uptime = time(NULL) - start_time;
    char *extra = strtok(NULL, "");
    int days = uptime/86400, hours = (uptime/3600)%24,
        mins = (uptime/60)%60, secs = uptime%60;
    struct tm *tm;
    char timebuf[64];

    if (extra && strcasecmp(extra, "ALL") != 0) {
	if (strcasecmp(extra, "AKILL") == 0) {
	    int timeout = AutokillExpiry+59;
	    notice_lang(s_OperServ, u, OPER_STATS_AKILL_COUNT, num_akills());
	    if (timeout >= 172800)
		notice_lang(s_OperServ, u, OPER_STATS_AKILL_EXPIRE_DAYS,
			timeout/86400);
	    else if (timeout >= 86400)
		notice_lang(s_OperServ, u, OPER_STATS_AKILL_EXPIRE_DAY);
	    else if (timeout >= 7200)
		notice_lang(s_OperServ, u, OPER_STATS_AKILL_EXPIRE_HOURS,
			timeout/3600);
	    else if (timeout >= 3600)
		notice_lang(s_OperServ, u, OPER_STATS_AKILL_EXPIRE_HOUR);
	    else if (timeout >= 120)
		notice_lang(s_OperServ, u, OPER_STATS_AKILL_EXPIRE_MINS,
			timeout/60);
	    else if (timeout >= 60)
		notice_lang(s_OperServ, u, OPER_STATS_AKILL_EXPIRE_MIN);
	    else
		notice_lang(s_OperServ, u, OPER_STATS_AKILL_EXPIRE_NONE);
	} else 
	if (strcasecmp(extra, "RECORD") == 0)  {
	    struct tm *tm;
	    char buf[BUFSIZE];

	    tm = localtime(&Count.users_max_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);	
	    notice_lang(s_OperServ, u, OPER_STATS_USERS_RECORD,
		Count.users_max, buf, Count.users,
		100);
	    tm = localtime(&Count.opers_max_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);			
	    notice_lang(s_OperServ, u, OPER_STATS_OPERS_RECORD,
		Count.opers_max, buf, Count.opers,
		(Count.opers*100)/Count.users);
	    tm = localtime(&Count.helpers_max_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);			
	    notice_lang(s_OperServ, u, OPER_STATS_HELPERS_RECORD,
		Count.helpers_max, buf, Count.helpers,
		(Count.helpers*100)/Count.users);
	    tm = localtime(&Count.bots_max_time);
	    strftime(buf, sizeof(buf), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), tm);			
	    notice_lang(s_OperServ, u, OPER_STATS_BOTS_RECORD,
		Count.bots_max, buf, Count.bots,
		(Count.bots*100)/Count.users);
	}
	else {
	    notice_lang(s_OperServ, u, OPER_STATS_UNKNOWN_OPTION,
			strupper(extra));
	}
	return;
    }

    notice_lang(s_OperServ, u, OPER_STATS_CURRENT_USERS, Count.users, Count.opers, 
	  Count.helpers, Count.bots);
    tm = localtime(&Count.users_max_time);
    strftime_lang(timebuf, sizeof(timebuf), u, STRFTIME_DATE_TIME_FORMAT, tm);
    notice_lang(s_OperServ, u, OPER_STATS_MAX_USERS, Count.users_max, timebuf);
    if (days > 1) {
	notice_lang(s_OperServ, u, OPER_STATS_UPTIME_DHMS,
		days, hours, mins, secs);
    } else if (days == 1) {
	notice_lang(s_OperServ, u, OPER_STATS_UPTIME_1DHMS,
		days, hours, mins, secs);
    } else {
	if (hours > 1) {
	    if (mins != 1) {
		if (secs != 1) {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_HMS,
				hours, mins, secs);
		} else {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_HM1S,
				hours, mins, secs);
		}
	    } else {
		if (secs != 1) {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_H1MS,
				hours, mins, secs);
		} else {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_H1M1S,
				hours, mins, secs);
		}
	    }
	} else if (hours == 1) {
	    if (mins != 1) {
		if (secs != 1) {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_1HMS,
				hours, mins, secs);
		} else {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_1HM1S,
				hours, mins, secs);
		}
	    } else {
		if (secs != 1) {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_1H1MS,
				hours, mins, secs);
		} else {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_1H1M1S,
				hours, mins, secs);
		}
	    }
	} else {
	    if (mins != 1) {
		if (secs != 1) {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_MS,
				mins, secs);
		} else {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_M1S,
				mins, secs);
		}
	    } else {
		if (secs != 1) {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_1MS,
				mins, secs);
		} else {
		    notice_lang(s_OperServ, u, OPER_STATS_UPTIME_1M1S,
				mins, secs);
		}
	    }
	}
    }

    if (extra && strcasecmp(extra, "ALL") == 0 && is_services_admin(u)) {
	long count, mem, count2, mem2;

	get_user_stats(&count, &mem);
	notice_lang(s_OperServ, u, OPER_STATS_USER_MEM,
			count, (mem+512) / 1024);
	get_channel_stats(&count, &mem);
	notice_lang(s_OperServ, u, OPER_STATS_CHANNEL_MEM,
			count, (mem+512) / 1024);
	get_nickserv_stats(&count, &mem);
	notice_lang(s_OperServ, u, OPER_STATS_NICKSERV_MEM,
			count, (mem+512) / 1024);
	get_chanserv_stats(&count, &mem);
	notice_lang(s_OperServ, u, OPER_STATS_CHANSERV_MEM,
			count, (mem+512) / 1024);
	count = 0;
	get_akill_stats(&count2, &mem2);
	count += count2;
	mem += mem2;
	get_news_stats(&count2, &mem2);
	count += count2;
	mem += mem2;
	notice_lang(s_OperServ, u, OPER_STATS_OPERSERV_MEM,
			count, (mem+512) / 1024);
    }
}

/*************************************************************************/

/* Channel mode changing (MODE command). */

static void do_os_mode(User *u)
{
    int argc;
    char **argv;
    char *s = strtok(NULL, "");
    char *chan, *modes;
    Channel *c;

    if (!s) {
	syntax_error(s_OperServ, u, "MODE", OPER_MODE_SYNTAX);
	return;
    }
    chan = s;
    s += strcspn(s, " ");
    if (!*s) {
	syntax_error(s_OperServ, u, "MODE", OPER_MODE_SYNTAX);
	return;
    }
    *s = 0;
    modes = (s+1) + strspn(s+1, " ");
    if (!*modes) {
	syntax_error(s_OperServ, u, "MODE", OPER_MODE_SYNTAX);
	return;
    }
    if (!(c = findchan(chan))) {
	notice_lang(s_OperServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (c->bouncy_modes) {
	notice_lang(s_OperServ, u, OPER_BOUNCY_MODES_U_LINE);
	return;
    } else {
	send_cmd(s_OperServ, "MODE %s %s", chan, modes);
	if (WallOSMode)
	    wallops(s_OperServ, "%s used MODE %s on %s", u->nick, modes, chan);
	*s = ' ';
	argc = split_buf(chan, &argv, 1);
	do_cmode(s_OperServ, argc, argv);
    }
}

/*************************************************************************/

/* Clear all modes from a channel. */

static void do_clearmodes(User *u)
{
    char *s;
    int i;
    char *argv[3];
    char *chan = strtok(NULL, " ");
    Channel *c;
    int all = 0;
    int count;		/* For saving ban info */
    char **bans;	/* For saving ban info */
    struct c_userlist *cu, *next;

    if (!chan) {
	syntax_error(s_OperServ, u, "CLEARMODES", OPER_CLEARMODES_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_OperServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (c->bouncy_modes) {
	notice_lang(s_OperServ, u, OPER_BOUNCY_MODES_U_LINE);
	return;
    } else {
	s = strtok(NULL, " ");
	if (s) {
	    if (strcasecmp(s, "ALL") == 0) {
		all = 1;
	    } else {
		syntax_error(s_OperServ,u,"CLEARMODES",OPER_CLEARMODES_SYNTAX);
		return;
	    }
	}
	if (WallOSClearmodes)
	    wallops(s_OperServ, "%s used CLEARMODES%s on %s",
			u->nick, all ? " ALL" : "", chan);
	if (all) {
	    /* Clear mode +o */
	    for (cu = c->chanops; cu; cu = next) {
		next = cu->next;
		argv[0] = sstrdup(chan);
		argv[1] = sstrdup("-o");
		argv[2] = sstrdup(cu->user->nick);
		send_cmd(s_ChanServ, "MODE %s %s :%s",
			argv[0], argv[1], argv[2]);
		do_cmode(s_ChanServ, 3, argv);
		free(argv[2]);
		free(argv[1]);
		free(argv[0]);
	    }
#ifdef HALFOPS
	    for(cu = c->halfops; cu; cu=next) {
		next = cu->next;
		argv[0] = sstrdup(chan);
		argv[1] = sstrdup("-h");
		argv[2] = sstrdup(cu->user->nick);
		send_cmd(s_ChanServ, "MODE %s %s :%s",
			argv[0], argv[1], argv[2]);
		do_cmode(s_ChanServ, 3, argv);
		free(argv[2]);
		free(argv[1]);
		free(argv[0]);
	    }
#endif
	    /* Clear mode +v */
	    for (cu = c->voices; cu; cu = next) {
		next = cu->next;
		argv[0] = sstrdup(chan);
		argv[1] = sstrdup("-v");
		argv[2] = sstrdup(cu->user->nick);
		send_cmd(s_ChanServ, "MODE %s %s :%s",
			argv[0], argv[1], argv[2]);
		do_cmode(s_ChanServ, 3, argv);
		free(argv[2]);
		free(argv[1]);
		free(argv[0]);
	    }
	}

	/* Clear modes */
	send_cmd(s_OperServ, "MODE %s -iklmnpstBcdKfqRSNC", chan);
	argv[0] = sstrdup(chan);
	argv[1] = sstrdup("-iklmnpstBcdKfqRSNC");
	do_cmode(s_OperServ, 2, argv);
	free(argv[0]);
	free(argv[1]);
	c->key = NULL;
	c->limit = 0;

	/* Clear bans */
	count = c->bancount;
	if(count == 0)
	  return;
	  
	bans = smalloc(sizeof(char *) * count);
	for (i = 0; i < count; i++)
	    bans[i] = sstrdup(c->bans[i]);
	for (i = 0; i < count; i++) {
	    argv[0] = sstrdup(chan);
	    argv[1] = sstrdup("-b");
	    argv[2] = bans[i];
	    send_cmd(s_OperServ, "MODE %s %s :%s",
			argv[0], argv[1], argv[2]);
	    do_cmode(s_OperServ, 3, argv);
	    free(argv[2]);
	    free(argv[1]);
	    free(argv[0]);
	}
	free(bans);
    }
}

/*************************************************************************/

/* Kick a user from a channel (KICK command). */

static void do_os_kick(User *u)
{
    char *argv[3];
    char *chan, *nick, *s;
    Channel *c;

    chan = strtok(NULL, " ");
    nick = strtok(NULL, " ");
    s = strtok(NULL, "");
    if (!chan || !nick || !s) {
	syntax_error(s_OperServ, u, "KICK", OPER_KICK_SYNTAX);
	return;
    }
    if (!(c = findchan(chan))) {
	notice_lang(s_OperServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (c->bouncy_modes) {
	notice_lang(s_OperServ, u, OPER_BOUNCY_MODES_U_LINE);
	return;
    } else if (strcasecmp(nick, s_OperServ) == 0 ) {
	notice_lang(s_OperServ, u, PERMISSION_DENIED);
    } else if (!is_on_chan(nick, chan)) {
	notice_lang(s_OperServ, u, NICK_X_NOT_ON_CHAN, nick, chan);
    } else {
    send_cmd(s_OperServ, "KICK %s %s :%s (%s)", chan, nick, u->nick, s);
    if (WallOSKick)
	wallops(s_OperServ, "%s used KICK on %s/%s", u->nick, nick, chan);
    argv[0] = sstrdup(chan);
    argv[1] = sstrdup(nick);
    argv[2] = sstrdup(s);
    do_kick(s_OperServ, 3, argv);
    free(argv[2]);
    free(argv[1]);
    free(argv[0]);
    }
}
/*************************************************************************/

/* Services admin list viewing/modification. */

static void do_admin(User *u)
{
    char *cmd, *nick;
    NickInfo *ni;
    int i;

    if (skeleton) {
	notice_lang(s_OperServ, u, OPER_ADMIN_SKELETON);
	return;
    }
    cmd = strtok(NULL, " ");
    if (!cmd)
	cmd = "";

    if (strcasecmp(cmd, "ADD") == 0) {
	if (!is_services_root(u)) {
	    notice_lang(s_OperServ, u, PERMISSION_DENIED);
	    return;
	}
	nick = strtok(NULL, " ");
	if (nick) {
	    if (!(ni = findnick(nick))) {
		notice_lang(s_OperServ, u, NICK_X_NOT_REGISTERED, nick);
		return;
	    }
	    if(ni->status & NS_VERBOTEN) {
		notice_lang(s_OperServ, u, NICK_X_FORBIDDEN, nick);
		return;
	    }
	    for (i = 0; i < MAX_SERVADMINS; i++) {
		if (!services_admins[i] || services_admins[i] == ni)
		    break;
	    }
	    if (services_admins[i] == ni) {
		notice_lang(s_OperServ, u, OPER_ADMIN_EXISTS, ni->nick);
	    } else if (i < MAX_SERVADMINS) {
		services_admins[i] = ni;
		notice_lang(s_OperServ, u, OPER_ADMIN_ADDED, ni->nick);
		log2c("%s: %s is now a Services Admin (added by %s!%s@%s)", s_OperServ, 
                    ni->nick, u->nick, u->username, u->host);
    		ni->status |= NS_NO_EXPIRE;
		DayStats.os_admins++;
		if (readonly)
		    notice_lang(s_OperServ, u, READ_ONLY_MODE);
	    } else {
		notice_lang(s_OperServ, u, OPER_ADMIN_TOO_MANY, MAX_SERVADMINS);
	    }
	} else {
	    syntax_error(s_OperServ, u, "ADMIN", OPER_ADMIN_ADD_SYNTAX);
	}

    } else if (strcasecmp(cmd, "DEL") == 0) {
	if (!is_services_root(u)) {
	    notice_lang(s_OperServ, u, PERMISSION_DENIED);
	    return;
	}
	nick = strtok(NULL, " ");
	if (nick) {
	    if (!(ni = findnick(nick))) {
		notice_lang(s_OperServ, u, NICK_X_NOT_REGISTERED, nick);
		return;
	    }
	    for (i = 0; i < MAX_SERVADMINS; i++) {
		if (services_admins[i] == ni)
		    break;
	    }
	    if (i < MAX_SERVADMINS) {
		services_admins[i] = NULL;
		notice_lang(s_OperServ, u, OPER_ADMIN_REMOVED, ni->nick);
		log2c("%s: %s is not a Services Admin anymore (deleted by %s!%s@%s)", s_OperServ,
                    ni->nick, u->nick, u->username, u->host);
		ni->status &= ~NS_NO_EXPIRE;
		DayStats.os_admins--;
		if (readonly)
		    notice_lang(s_OperServ, u, READ_ONLY_MODE);
	    } else {
		notice_lang(s_OperServ, u, OPER_ADMIN_NOT_FOUND, ni->nick);
	    }
	} else {
	    syntax_error(s_OperServ, u, "ADMIN", OPER_ADMIN_DEL_SYNTAX);
	}

    } else if (strcasecmp(cmd, "LIST") == 0) {
	notice_lang(s_OperServ, u, OPER_ADMIN_LIST_HEADER);
	for (i = 0; i < MAX_SERVADMINS; i++) {
	    if (services_admins[i])
		notice(s_OperServ, u->nick, "%s", services_admins[i]->nick);
	}

    } else {
	syntax_error(s_OperServ, u, "ADMIN", OPER_ADMIN_SYNTAX);
    }
}

/*************************************************************************/

/* Services oper list viewing/modification. */

static void do_oper(User *u)
{
    char *cmd, *nick, *expiry;
    NickInfo *ni;
    int i,amount=0;

    if (skeleton) {
	notice_lang(s_OperServ, u, OPER_OPER_SKELETON);
	return;
    }
    cmd = strtok(NULL, " ");
    if (!cmd)
	cmd = "";

    if (strcasecmp(cmd, "ADD") == 0) {
	if (!is_services_admin(u)) {
	    notice_lang(s_OperServ, u, PERMISSION_DENIED);
	    return;
	}
	nick = strtok(NULL, " ");
	if (nick) {
	    if (!(ni = findnick(nick))) {
		notice_lang(s_OperServ, u, NICK_X_NOT_REGISTERED, nick);
		return;
	    }
	    if (ni->status & NS_VERBOTEN) {
		notice_lang(s_OperServ, u, NICK_X_FORBIDDEN, nick);
		return;
	    }
	    for (i = 0; i < MAX_SERVOPERS; i++) {
		if (!services_opers[i] || services_opers[i] == ni)
		    break;
	    }
	    if (services_opers[i] == ni) {
		notice_lang(s_OperServ, u, OPER_OPER_EXISTS, ni->nick);
	    } else if (i < MAX_SERVOPERS) {
		services_opers[i] = ni;
		notice_lang(s_OperServ, u, OPER_OPER_ADDED, ni->nick);
		log2c("%s: %s is now a Services Oper (added by %s!%s@%s)", s_OperServ,
		    ni->nick, u->nick, u->username, u->host);
	    } else {
		notice_lang(s_OperServ, u, OPER_OPER_TOO_MANY, MAX_SERVOPERS);
	    }
	    if (readonly)
		notice_lang(s_OperServ, u, READ_ONLY_MODE);
	} else {
	    syntax_error(s_OperServ, u, "OPER", OPER_OPER_ADD_SYNTAX);
	}

    } else if (strcasecmp(cmd, "DEL") == 0) {
	if (!is_services_admin(u)) {
	    notice_lang(s_OperServ, u, PERMISSION_DENIED);
	    return;
	}
	nick = strtok(NULL, " ");
	if (nick) {
	    if (!(ni = findnick(nick))) {
		notice_lang(s_OperServ, u, NICK_X_NOT_REGISTERED, nick);
		return;
	    }
	    for (i = 0; i < MAX_SERVOPERS; i++) {
		if (services_opers[i] == ni)
		    break;
	    }
	    if (i < MAX_SERVOPERS) {
		services_opers[i] = NULL;
		notice_lang(s_OperServ, u, OPER_OPER_REMOVED, ni->nick);
		log2c("%s: %s is not a Services Oper anymore (deleted by %s!%s@%s)", s_OperServ,
		    ni->nick, u->nick, u->username, u->host);
		if (readonly)
		    notice_lang(s_OperServ, u, READ_ONLY_MODE);
	    } else {
		notice_lang(s_OperServ, u, OPER_OPER_NOT_FOUND, ni->nick);
	    }
	} else {
	    syntax_error(s_OperServ, u, "OPER", OPER_OPER_DEL_SYNTAX);
	}
    } else if (strcasecmp(cmd, "LIST") == 0) {
	notice_lang(s_OperServ, u, OPER_OPER_LIST_HEADER);
	for (i = 0; i < MAX_SERVOPERS; i++) {
	    if (services_opers[i])
		notice(s_OperServ, u->nick, "%s", services_opers[i]->nick);
	}

    } else if (strcasecmp(cmd, "SUSPEND") == 0) {
	if (!is_services_admin(u)) {
	    notice_lang(s_OperServ, u, PERMISSION_DENIED);
	    return;
	}
	nick = strtok(NULL, " ");
	expiry =  strtok(NULL, " ");	
	if(expiry)
	    amount = strtol(expiry, (char **)&expiry, 10);	
	if (nick) {
	    if (!(ni = findnick(nick))) {
		notice_lang(s_OperServ, u, NICK_X_NOT_REGISTERED, nick);
		return;
	    }
	    if (is_services_oper(u)) {
		if(amount) {
		    amount*=(24*3600);
		    notice_lang(s_OperServ, u, OPER_OPER_SUSPENDED, nick, amount/(24*3600));
                    log2c("%s: %s had his Oper Privileges SUSPENDED by %s!%s@%s)", s_OperServ,
                        ni->nick, u->nick, u->username, u->host);		
		    ni->flags |= NI_OSUSPENDED;
		    ni->suspension_expire=time(NULL)+amount;
		} else {		
		    notice_lang(s_OperServ, u, OPER_OPER_UNSUSPEND, nick);		
		    log2c("%s: %s had his Oper Privileges granted by %s!%s@%s)", s_OperServ,
		        ni->nick, u->nick, u->username, u->host);
		    ni->flags &= ~NI_OSUSPENDED;
		}
		if (readonly)
		    notice_lang(s_OperServ, u, READ_ONLY_MODE);
	    } else {
		notice_lang(s_OperServ, u, OPER_OPER_NOT_FOUND, ni->nick);
	    }
	} else {
	    syntax_error(s_OperServ, u, "OPER", OPER_OPER_SUSPEND_SYNTAX);
	} 	
    } else {
	syntax_error(s_OperServ, u, "OPER", OPER_OPER_SYNTAX);
    }
}

/*************************************************************************/

/* Set various Services runtime options. */

static void do_set(User *u)
{
    char *option = strtok(NULL, " ");
    char *setting = strtok(NULL, " ");

    if (!option || !setting) {
	syntax_error(s_OperServ, u, "SET", OPER_SET_SYNTAX);

    } else if (strcasecmp(option, "IGNORE") == 0) {
	if (strcasecmp(setting, "on") == 0) {
	    allow_ignore = 1;
	    notice_lang(s_OperServ, u, OPER_SET_IGNORE_ON);
	} else if (strcasecmp(setting, "off") == 0) {
	    allow_ignore = 0;
	    notice_lang(s_OperServ, u, OPER_SET_IGNORE_OFF);
	} else {
	    notice_lang(s_OperServ, u, OPER_SET_IGNORE_ERROR);
	}

    } else if (strcasecmp(option, "READONLY") == 0) {
	if (strcasecmp(setting, "on") == 0) {
	    readonly = 1;
	    log1("Read-only mode activated");
	    close_log();
	    notice_lang(s_OperServ, u, OPER_SET_READONLY_ON);
	} else if (strcasecmp(setting, "off") == 0) {
	    readonly = 0;
	    open_log();
	    log1("Read-only mode deactivated");
	    notice_lang(s_OperServ, u, OPER_SET_READONLY_OFF);
	} else {
	    notice_lang(s_OperServ, u, OPER_SET_READONLY_ERROR);
	}

    } else if (strcasecmp(option, "DEBUG") == 0) {
	if (strcasecmp(setting, "on") == 0) {
	    debug = 1;
	    log1("Debug mode activated");
	    notice_lang(s_OperServ, u, OPER_SET_DEBUG_ON);
	} else if (strcasecmp(setting, "off") == 0 ||
				(*setting == '0' && atoi(setting) == 0)) {
	    log1("Debug mode deactivated");
	    debug = 0;
	    notice_lang(s_OperServ, u, OPER_SET_DEBUG_OFF);
	} else if (isdigit(*setting) && atoi(setting) > 0) {
	    debug = atoi(setting);
	    log1("Debug mode activated (level %d)", debug);
	    notice_lang(s_OperServ, u, OPER_SET_DEBUG_LEVEL, debug);
	} else {
	    notice_lang(s_OperServ, u, OPER_SET_DEBUG_ERROR);
	}

    } else {
	notice_lang(s_OperServ, u, OPER_SET_UNKNOWN_OPTION, option);
    }
}

/*************************************************************************/

static void do_jupe(User *u)
{
    char *jserver = strtok(NULL, " ");
    char *reason = strtok(NULL, "");
    char buf[NICKMAX+16];

    if (!jserver || !valid_hostname(jserver)) {
	syntax_error(s_OperServ, u, "JUPE", OPER_JUPE_SYNTAX);
    } else {
	wallops(s_OperServ, "\2Juping\2 %s by request of \2%s\2.",
		jserver, u->nick);
	if (!reason) {
	    snprintf(buf, sizeof(buf), "Jupitered by %s", u->nick);
	    reason = buf;
	}
	/* Small trivial fix. -- blackfile */
	send_cmd(NULL, "SQUIT %s :Requested by JUPE", jserver);
	send_cmd(NULL, "SERVER %s 2 :%s", jserver, reason);
    }
}

/*************************************************************************/

static void do_raw(User *u)
{
    char *text = strtok(NULL, "");

    if (!text)
	syntax_error(s_OperServ, u, "RAW", OPER_RAW_SYNTAX);
    else
	send_cmd(NULL, "%s", text);
}

/*************************************************************************/

static void do_update(User *u)
{
	if(last_updater)
	  notice_lang(s_NickServ, u, UPDATE_IN_PROGRESS, last_updater);
	else
	  {
	    notice_lang(s_OperServ, u, OPER_UPDATING);
  		save_data = 1;
		last_updater = sstrdup(u->nick);
		last_update_request = time(NULL);
	  }
}

/*************************************************************************/

static void do_os_quit(User *u)
{
    quitmsg = malloc(28 + strlen(u->nick));
    if (!quitmsg)
	quitmsg = "QUIT command received, but out of memory!";
    else
	sprintf(quitmsg, "QUIT command received from %s", u->nick);
    quitting = 1;
}

/*************************************************************************/

static void do_shutdown(User *u)
{
    quitmsg = malloc(32 + strlen(u->nick));
    if (!quitmsg)
	quitmsg = "SHUTDOWN command received, but out of memory!";
    else
	sprintf(quitmsg, "SHUTDOWN command received from %s", u->nick);
    save_data = 1;
    delayed_quit = 1;
}

/*************************************************************************/

static void do_restart(User *u)
{
    quitmsg = malloc(31 + strlen(u->nick));
    if (!quitmsg)
	quitmsg = "RESTART command received, but out of memory!";
    else
	sprintf(quitmsg, "RESTART command received from %s", u->nick);
    raise(SIGHUP);
}

/*************************************************************************
    Reload services.conf
 *************************************************************************/
static void do_rehash(User *u)
{
    if(read_config(1))
	notice_lang(s_OperServ, u, OPER_REHASH_DONE);
    else
	notice_lang(s_OperServ, u, OPER_REHASH_ERROR);
}

/*************************************************************************/

static void do_listignore(User *u)
{
    int sent_header = 0;
    IgnoreData *id;
    int i;

    for (i = 0; i < 256; i++) {
	for (id = ignore[i]; id; id = id->next) {
	    if (!sent_header) {
		notice_lang(s_OperServ, u, OPER_IGNORE_LIST);
		sent_header = 1;
	    }
	    notice(s_OperServ, u->nick, "%ld %s", (long int) id->time, id->who);
	}
    }
    if (!sent_header)
	notice_lang(s_OperServ, u, OPER_IGNORE_LIST_EMPTY);
}

/* gives founder privilegge on channel */
static void do_getfounder(User *u)
{
    char *chan = strtok(NULL,"");
    ChannelInfo *ci;
    struct u_chaninfolist *uc;
    if(!chan) {
	syntax_error(s_OperServ, u, "GETFOUNDER", OPER_GETFOUNDER_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_OperServ, u, CHAN_X_NOT_REGISTERED, chan);	
    } else {
	if (!is_identified(u, ci)) {
	    uc = smalloc(sizeof(*uc));
	    uc->next = u->founder_chans;
	    uc->prev = NULL;
	    if (u->founder_chans)
	        u->founder_chans->prev = uc;
	    u->founder_chans = uc;
	    uc->chan = ci;
	    log2c("%s: %s!%s@%s identified for %s using GETFOUNDER", s_OperServ,
			u->nick, u->username, u->host, ci->name);
    	    sanotice(s_OperServ,"%s!%s@%s identified for %s using GETFOUNDER",
		 u->nick, u->username, u->host, ci->name);
	    notice_lang(s_OperServ, u, CHAN_IDENTIFY_SUCCEEDED, chan);	    	
	    if(ci->flags & CI_DROPPED) {
	        char buf[BUFSIZE];
	        struct tm *tm;
	        ci->flags &= ~CI_DROPPED;
		tm = localtime(&ci->drop_time);
	        strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);		    
		notice_lang(s_OperServ, u, CHAN_DROP_CANCEL, buf);		
		log2c("%s: %s!%s@%s canceled drop for %s on GETFOUNDER", s_OperServ,
			u->nick, u->username, u->host, ci->name);		
	    }
	}
    }
}

/****************************************************************************
    Sends the nick password via email
    * Code adpated from Epona Services *	http://www.pegsoft.net/epona/
 ****************************************************************************/
static void do_sendpass(User *u)
{
#ifndef SENDMAIL    
  notice_lang(s_OperServ, u, OPER_SENDPASS_NOSENDMAIL);  
  return;
#else  
  char *nick = strtok(NULL, " ");
  NickInfo *ni, *link;
  
  if (!nick) 
	  syntax_error(s_OperServ, u, "SENDPASS", OPER_SENDPASS_SYNTAX);
	else if (!(ni = findnick(nick)) || !(link = getlink(ni))) 
	  notice_lang(s_OperServ, u, NICK_X_NOT_REGISTERED, nick); 
	else if (!ni->email) 
	  notice_lang(s_OperServ, u, OPER_SENDPASS_NOMAIL, nick); 
	else if ((time(NULL) - u->lastmail < MailDelay) || (time(NULL) - u->lastmail < MailDelay))
		notice_lang(s_OperServ, u, MAIL_DELAYED, MailDelay);	  
	else if (NSSecureAdmins && is_services_admin_nick(ni)) 
	  {   
  		log2c("%s: %s!%s@%s trying SENDPASS on SADM nick %s",
                        s_OperServ, u->nick, u->username, u->host, ni->nick);
    	    sanotice(s_OperServ,"%s!%s@%s trying SENDPASS on SADM!!! %s",
                    u->nick, u->username, u->host, ni->nick);		
  	  } 
    else 
	  {
    	FILE *p;
    	char sendmail[PATH_MAX];
    	char buf[BUFSIZE];
	char pbuf[BUFSIZE];
	if (ni->crypt_method)
	{	  	
	    rand_string(pbuf,7,12);
	    if (encrypt(pbuf, strlen(pbuf), ni->pass, PASSMAX) < 0) 
	    {
      		memset(pbuf, 0, strlen(pbuf));
		log2c("%s: Failed to encrypt password for %s (set)",			  
		    s_NickServ, ni->nick);
		    notice_lang(s_NickServ, u, NICK_SET_PASSWORD_FAILED);
		    return;
		}
	}
#ifdef SENDMAIL		  
    	snprintf(sendmail, sizeof(sendmail), "%s %s", SENDMAIL, link->email);
#endif
    	if (!(p = popen(sendmail, "w"))) {
    		notice_lang(s_OperServ, u, MAIL_LATER);
    		return;	
    	}

    	fprintf(p, "From: \"%s\" <%s>\n", 
    		SendFromName, SendFrom);
    	fprintf(p, "To: \"%s\" <%s>\n", ni->nick, link->email);
    	
    	snprintf(buf, sizeof(buf), getstringnick(ni, OPER_SENDPASS_SUBJECT), ni->nick);
    	fprintf(p, "Subject: %s\n", buf);
    	
    	fprintf(p, getstringnick(ni, OPER_SENDPASS_HEAD));
    	fprintf(p, "\n");
  		fprintf(p, getstringnick(ni, OPER_SENDPASS_LINE_1), ni->nick);		  
    	fprintf(p, "\n");
		if (ni->crypt_method)
		  fprintf(p, getstringnick(ni, OPER_SENDPASS_LINE_2), pbuf);
		else
		  fprintf(p, getstringnick(ni, OPER_SENDPASS_LINE_2), ni->pass);
    	fprintf(p, "\n");
    	fprintf(p, getstringnick(ni, OPER_SENDPASS_LINE_3));
    	fprintf(p, "\n");
    	fprintf(p, getstringnick(ni, OPER_SENDPASS_LINE_4));
    	fprintf(p, "\n\n");
    	fprintf(p, "%s\n",MailSignature);
    	fprintf(p, "\n.\n");
    	pclose(p);

    	u->lastmail = time(NULL);
    	//link->lastmail = time(NULL);
    	
	log2c("%s: %s!%s@%s used SENDPASS on %s", s_OperServ, u->nick, u->username, u->host, nick);
	notice_lang(s_OperServ, u, OPER_SENDPASS_OK, nick);
    }
#endif    
}


/****************************************************************************
  resets stats info
 ****************************************************************************/
static void do_reset(User *u)
{
  char *rtype = strtok(NULL, " ");
  if(!rtype)    
	return;
	
  if(strcasecmp(rtype,"stats")==0)
	{
	  Count.users_max = 0;
	  Count.opers_max = 0;
	  Count.helpers_max = 0;
	  Count.bots_max = 0;
	}
}
/*****************************************************************************
 Setting the securenetwork option on
 *****************************************************************************/
static void do_securemode(User *u)
{
    char *set = strtok(NULL, " ");

    if(!set) {
	syntax_error(s_OperServ, u, "SECUREMODE", OPER_SECUREMODE_SYNTAX);
    } else if(strcasecmp(set, "on") == 0) {
	send_cmd(s_OperServ, "SVSADMIN ALL SECUREMODE_ON");
	log2c("%s: %s!%s@%s set the SECUREMODE for this network ON", s_OperServ, u->nick, u->username, u->host);
    } else if(strcasecmp(set, "off") == 0) {
	send_cmd(s_OperServ, "SVSADMIN ALL SECUREMODE_OFF");
	log2c("%s: %s!%s@%s set the SECUREMODE for this network OFF", s_OperServ, u->nick, u->username, u->host);
    } else {
	notice_lang(s_OperServ, u, OPER_SECUREMODE_ERROR);
    }
}
