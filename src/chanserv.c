/* ChanServ functions.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2004
 * http://software.pt-link.net/
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services 
 * $Id: chanserv.c,v 1.26 2005/03/12 15:17:08 jpinto Exp $ 
 */

/*************************************************************************/

#include "services.h"
#include "pseudo.h"
#include "ircdsetup.h"
#include "irc_string.h"

#define DFV_CHANSERV 10	/* ChanServ datafile version */
/*************************************************************************/

static ChannelInfo *chanlists[C_MAX];

static int def_levels[][2] = {
    { CA_AUTOOP,             5 },
    { CA_AUTOVOICE,          3 },
    { CA_AUTODEOP,          -1 },
    { CA_NOJOIN,            -1 },
    { CA_INVITE,             5 },
    { CA_AKICK,             10 },
    { CA_SET,   ACCESS_INVALID },
    { CA_CLEAR, ACCESS_INVALID },
    { CA_UNBAN,              5 },
    { CA_OPDEOP,             5 },
    { CA_ACCESS_LIST,        0 },
    { CA_ACCESS_CHANGE,      1 },
    { CA_MEMOREAD,           5 },
    { CA_PROTECT, ACCESS_INVALID },
    { CA_KICK,		    10 },            
    { CA_MEMOSEND,	    10 },
    { CA_MEMODEL,	    10 },        
    { CA_VOICEDEVOICE,	     3 },
#ifdef HALFOP
    { CA_AUTOHALFOP,	ACCESS_INVALID },
    { CA_HALFOPDEOP,	ACCESS_INVALID },
#endif
    { -1 }
};

typedef struct {
    int what;
    char *name;
    int desc;
} LevelInfo;
static LevelInfo levelinfo[] = {
    { CA_AUTOOP,        "AUTOOP",       CHAN_LEVEL_AUTOOP },
    { CA_AUTOVOICE,     "AUTOVOICE",    CHAN_LEVEL_AUTOVOICE },
    { CA_AUTODEOP,      "AUTODEOP",     CHAN_LEVEL_AUTODEOP },
    { CA_NOJOIN,        "NOJOIN",       CHAN_LEVEL_NOJOIN },
    { CA_INVITE,        "INVITE",       CHAN_LEVEL_INVITE },
    { CA_AKICK,         "AKICK",        CHAN_LEVEL_AKICK },
    { CA_SET,           "SET",          CHAN_LEVEL_SET },
    { CA_CLEAR,         "CLEAR",        CHAN_LEVEL_CLEAR },
    { CA_UNBAN,         "UNBAN",        CHAN_LEVEL_UNBAN },
    { CA_OPDEOP,        "OPDEOP",       CHAN_LEVEL_OPDEOP },
    { CA_KICK ,         "KICK",         CHAN_LEVEL_KICK },    
    { CA_ACCESS_LIST,   "ACC-LIST",     CHAN_LEVEL_ACCESS_LIST },
    { CA_ACCESS_CHANGE, "ACC-CHANGE",   CHAN_LEVEL_ACCESS_CHANGE },
    { CA_MEMOREAD,      "MEMOREAD",     CHAN_LEVEL_MEMO_READ },
    { CA_MEMOSEND,      "MEMOSEND",     CHAN_LEVEL_MEMO_SEND },    
    { CA_MEMODEL,	"MEMODEL",      CHAN_LEVEL_MEMO_DEL },
    { CA_PROTECT,	"PROTECT",      CHAN_LEVEL_PROTECT },
    { CA_VOICEDEVOICE,	"VOICEDEVOICE", CHAN_LEVEL_VOICEDEVOICE },
#ifdef HALFOPS
    { CA_AUTOHALFOP,	"AUTOHALFOP",	CHAN_LEVEL_AUTOHALFOP },
    { CA_HALFOPDEOP,	"HALFOPDEOP",	CHAN_LEVEL_HALFOPDEOP },
#endif
    { -1 }
};
static int levelinfo_maxwidth = 0;

static u_int32_t last_scid = 0;
/*************************************************************************/

static void insert_chan(ChannelInfo *ci);
static ChannelInfo *makechan(const char *chan);
static int delchan(ChannelInfo *ci);
static void reset_levels(ChannelInfo *ci);
static int is_founder(User *user, ChannelInfo *ci);
int is_identified(User *user, ChannelInfo *ci);
static int get_access(User *user, ChannelInfo *ci);

static void do_help(User *u);
static void do_register(User *u);
static void do_identify(User *u);
static void do_drop(User *u);
static void do_set(User *u);
static void do_set_founder(User *u, ChannelInfo *ci, char *param);
static void do_set_successor(User *u, ChannelInfo *ci, char *param);
static void do_set_password(User *u, ChannelInfo *ci, char *param);
static void do_set_desc(User *u, ChannelInfo *ci, char *param);
static void do_set_url(User *u, ChannelInfo *ci, char *param);
static void do_set_email(User *u, ChannelInfo *ci, char *param);
static void do_set_entrymsg(User *u, ChannelInfo *ci, char *param);
static void do_set_topic(User *u, ChannelInfo *ci, char *param);
static void do_set_mlock(User *u, ChannelInfo *ci, char *param);
static void do_set_keeptopic(User *u, ChannelInfo *ci, char *param);
static void do_set_topiclock(User *u, ChannelInfo *ci, char *param);
static void do_set_private(User *u, ChannelInfo *ci, char *param);
static void do_set_secureops(User *u, ChannelInfo *ci, char *param);
static void do_set_leaveops(User *u, ChannelInfo *ci, char *param);
static void do_set_restricted(User *u, ChannelInfo *ci, char *param);
static void do_set_opnotice(User *u, ChannelInfo *ci, char *param);
static void do_set_nolinks(User *u, ChannelInfo *ci, char *param);
static void do_set_topicentry(User *u, ChannelInfo *ci, char *param);
static void do_set_noexpire(User *u, ChannelInfo *ci, char *param);
static void do_access(User *u);
static void do_aop(User *u);
static void do_sop(User *u);
static void do_akick(User *u);
static void do_info(User *u);
static void do_list(User *u);
static void do_invite(User *u);
static void do_levels(User *u);
static void do_op(User *u);
static void do_deop(User *u);
#ifdef HALFOPS
static void do_halfop(User *u);
static void do_dehalfop(User *u);
#endif
static void do_voice(User *u);
static void do_devoice(User *u);
static void do_ckick(User *u);
static void do_unban(User *u);
static void do_clear(User *u);
static void do_getpass(User *u);
static void do_forbid(User *u);
static void do_status(User *u);
static void do_stats(User *u);
static void do_logout(User *u);
/*************************************************************************/

static Command cmds[] = {
    { "HELP",     do_help,     NULL,  -1,                       -1,-1,-1,-1 },
    { "REGISTER", do_register, NULL,  CHAN_HELP_REGISTER,       -1,-1,-1,-1 },
    { "IDENTIFY", do_identify, NULL,  CHAN_HELP_IDENTIFY,       -1,-1,-1,-1 },
    { "DROP",     do_drop,     NULL,  -1,
		CHAN_HELP_DROP, CHAN_SERVADMIN_HELP_DROP,
		CHAN_SERVADMIN_HELP_DROP, CHAN_SERVADMIN_HELP_DROP },
    { "SET",      do_set,      NULL,  CHAN_HELP_SET,
		-1, CHAN_SERVADMIN_HELP_SET,
		CHAN_SERVADMIN_HELP_SET, CHAN_SERVADMIN_HELP_SET },
    { "SET FOUNDER",    NULL,  NULL,  CHAN_HELP_SET_FOUNDER,    -1,-1,-1,-1 },
    { "SET SUCCESSOR",  NULL,  NULL,  CHAN_HELP_SET_SUCCESSOR,  -1,-1,-1,-1 },
    { "SET PASSWORD",   NULL,  NULL,  CHAN_HELP_SET_PASSWORD,   -1,-1,-1,-1 },
    { "SET DESC",       NULL,  NULL,  CHAN_HELP_SET_DESC,       -1,-1,-1,-1 },
    { "SET URL",        NULL,  NULL,  CHAN_HELP_SET_URL,        -1,-1,-1,-1 },
    { "SET EMAIL",      NULL,  NULL,  CHAN_HELP_SET_EMAIL,      -1,-1,-1,-1 },
    { "SET ENTRYMSG",   NULL,  NULL,  CHAN_HELP_SET_ENTRYMSG,   -1,-1,-1,-1 },
    { "SET TOPIC",      NULL,  NULL,  CHAN_HELP_SET_TOPIC,      -1,-1,-1,-1 },
    { "SET KEEPTOPIC",  NULL,  NULL,  CHAN_HELP_SET_KEEPTOPIC,  -1,-1,-1,-1 },
    { "SET TOPICLOCK",  NULL,  NULL,  CHAN_HELP_SET_TOPICLOCK,  -1,-1,-1,-1 },
    { "SET MLOCK",      NULL,  NULL,  CHAN_HELP_SET_MLOCK,      -1,-1,-1,-1 },
    { "SET RESTRICTED", NULL,  NULL,  CHAN_HELP_SET_RESTRICTED, -1,-1,-1,-1 },
    { "SET SECUREOPS",  NULL,  NULL,  CHAN_HELP_SET_SECUREOPS,  -1,-1,-1,-1 },
    { "SET LEAVEOPS",   NULL,  NULL,  CHAN_HELP_SET_LEAVEOPS,   -1,-1,-1,-1 },
    { "SET OPNOTICE",   NULL,  NULL,  CHAN_HELP_SET_OPNOTICE,   -1,-1,-1,-1 },
    { "SET NOLINKS",    NULL,  NULL,  CHAN_HELP_SET_NOLINKS,    -1,-1,-1,-1 },
    { "SET TOPICENTRY", NULL,  NULL,  CHAN_HELP_SET_TOPICENTRY, -1,-1,-1,-1 },    
    { "SET NOEXPIRE",   NULL,  NULL,  -1, -1,
		CHAN_SERVADMIN_HELP_SET_NOEXPIRE,
		CHAN_SERVADMIN_HELP_SET_NOEXPIRE,
		CHAN_SERVADMIN_HELP_SET_NOEXPIRE },
    { "ACCESS",   do_access,   NULL,  CHAN_HELP_ACCESS,         -1,-1,-1,-1 },
    { "AOP",      do_aop,      NULL,  CHAN_HELP_AOP,  		-1,-1,-1,-1 },
    { "SOP",      do_sop,      NULL,  CHAN_HELP_SOP,		-1,-1,-1,-1 },
    { "ACCESS LEVELS",  NULL,  NULL,  CHAN_HELP_ACCESS_LEVELS,  -1,-1,-1,-1 },
    { "AKICK",    do_akick,    NULL,  CHAN_HELP_AKICK,          -1,-1,-1,-1 },
    { "LEVELS",   do_levels,   NULL,  CHAN_HELP_LEVELS,         -1,-1,-1,-1 },
    { "INFO",     do_info,     NULL,  CHAN_HELP_INFO,           -1,-1,-1,-1 },
    { "LOGOUT",   do_logout,   NULL,  CHAN_HELP_LOGOUT,	        -1,-1,-1,-1 },
    { "LIST",     do_list,     NULL,  -1,
		CHAN_HELP_LIST, CHAN_SERVADMIN_HELP_LIST,
		CHAN_SERVADMIN_HELP_LIST, CHAN_SERVADMIN_HELP_LIST },
    { "OP",       do_op,       NULL,  CHAN_HELP_OP,             -1,-1,-1,-1 },
    { "DEOP",     do_deop,     NULL,  CHAN_HELP_DEOP,           -1,-1,-1,-1 },
    { "VOICE",	  do_voice,    NULL,  CHAN_HELP_VOICE,		-1,-1,-1,-1 },
    { "DEVOICE",  do_devoice,  NULL,  CHAN_HELP_DEVOICE,	-1,-1,-1,-1 },	
#ifdef HALFOPS
    { "HALFOP",	  do_halfop,   NULL,  CHAN_HELP_HALFOP,		-1,-1,-1,-1 },
    { "DEHALFOP", do_dehalfop, NULL,  CHAN_HELP_DEHALFOP,	-1,-1,-1,-1 },
#endif
    { "KICK",	  do_ckick,    NULL,  CHAN_HELP_KICK,           -1,-1,-1,-1 },
    { "INVITE",   do_invite,   NULL,  CHAN_HELP_INVITE,         -1,-1,-1,-1 },
    { "UNBAN",    do_unban,    NULL,  CHAN_HELP_UNBAN,          -1,-1,-1,-1 },
    { "CLEAR",    do_clear,    NULL,  CHAN_HELP_CLEAR,          -1,-1,-1,-1 },
    { "GETPASS",  do_getpass,  is_services_admin,  -1,
		-1, CHAN_SERVADMIN_HELP_GETPASS,
		CHAN_SERVADMIN_HELP_GETPASS, CHAN_SERVADMIN_HELP_GETPASS },
    { "FORBID",   do_forbid,   is_services_admin,  -1,
		-1, CHAN_SERVADMIN_HELP_FORBID,
		CHAN_SERVADMIN_HELP_FORBID, CHAN_SERVADMIN_HELP_FORBID },
    { "STATUS",   do_status,   is_services_admin,  -1,
		-1, CHAN_SERVADMIN_HELP_STATUS,
		CHAN_SERVADMIN_HELP_STATUS, CHAN_SERVADMIN_HELP_STATUS },
    { "STATS",     do_stats, NULL,  -1,           -1,-1,-1,-1 },				
    { NULL }
};


u_int32_t cs_hash_chan_name(const char* name)
{
  unsigned int h = 0;
                                                                                
                                                                                
  while (*name)
    {
      h = (h << 4) - (h + (unsigned char)ToLower(*name++));
    }
                                                                                
                                                                                
  return(h & (C_MAX - 1));
}

/*************************************************************************/
/*************************************************************************/

/* Display total number of registered channels and info about each; or, if
 * a specific channel is given, display information about that channel
 * (like /msg ChanServ INFO <channel>).  If count_only != 0, then only
 * display the number of registered channels (the channel parameter is
 * ignored).
 */

void listchans(int count_only, const char *chan)
{
    int count = 0;
    ChannelInfo *ci;
    u_int32_t i;

    if (count_only) {
	for (i = 0; i < C_MAX; i++) {
	    for (ci = chanlists[i]; ci; ci = ci->next)
		count++;
	}
	printf("%d channels registered.\n", count);
#if HAVE_MYSQL    
    if(count_only)
      save_cs_dbase();
#endif

    } else if (chan) {

	struct tm *tm;
	char *s, buf[BUFSIZE];

	if (!(ci = cs_findchan(chan))) {
	    printf("Channel %s not registered.\n", chan);
	    return;
	}
	if (ci->flags & CI_VERBOTEN) {
	    printf("Channel %s is FORBIDden.\n", ci->name);
	} else {
	    printf("     Channel: %s\n", ci->name);
	    s = ci->founder->last_usermask;
	    printf("     Founder: %s%s%s%s\n",
			ci->founder->nick,
			s ? " (" : "", s ? s : "", s ? ")" : "");
	    printf(" Description: %s\n", ci->desc);
	    tm = localtime(&ci->time_registered);
	    strftime(buf, sizeof(buf), "%b %d %H:%M:%S %Y %Z", tm);
	    printf("  Registered: %s\n", buf);
	    tm = localtime(&ci->last_used);
	    strftime(buf, sizeof(buf), "%b %d %H:%M:%S %Y %Z", tm);
	    printf("   Last used: %s\n", buf);
	    if (ci->last_topic) {
	        printf("  Last topic: %s\n", ci->last_topic);
		printf("Topic set by: %s\n", ci->last_topic_setter);
	    }
	    if (ci->url)
		printf("         URL: %s\n", ci->url);
	    if (ci->email)
		printf(" E-mail address: %s\n", ci->email);
	    printf("     Options: ");
	    if (!ci->flags) {
		printf("None\n");
	    } else {
		int need_comma = 0;
		static const char commastr[] = ", ";
		if (ci->flags & CI_PRIVATE) {
		    printf("Private");
		    need_comma = 1;
		}
		if (ci->flags & CI_KEEPTOPIC) {
		    printf("%sTopic Retention", need_comma ? commastr : "");
		    need_comma = 1;
		}
		if (ci->flags & CI_TOPICLOCK) {
		    printf("%sTopic Lock", need_comma ? commastr : "");
		    need_comma = 1;
		}
		if (ci->flags & CI_SECUREOPS) {
		    printf("%sSecure Ops", need_comma ? commastr : "");
		    need_comma = 1;
		}
		if (ci->flags & CI_LEAVEOPS) {
		    printf("%sLeave Ops", need_comma ? commastr : "");
		    need_comma = 1;
		}
		if (ci->flags & CI_RESTRICTED) {
		    printf("%sRestricted Access", need_comma ? commastr : "");
		    need_comma = 1;
		}
	        printf("\n");
	    }
	    printf("   Mode lock: ");
	    if (ci->mlock_on || ci->mlock_key || ci->mlock_limit) {
		printf("+%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
			(ci->mlock_on & CMODE_I) ? "i" : "",
			(ci->mlock_key         ) ? "k" : "",
			(ci->mlock_limit       ) ? "l" : "",
			(ci->mlock_on & CMODE_M) ? "m" : "",
			(ci->mlock_on & CMODE_n) ? "n" : "",
			(ci->mlock_on & CMODE_P) ? "p" : "",
			(ci->mlock_on & CMODE_s) ? "s" : "",
			(ci->mlock_on & CMODE_T) ? "t" : "",
			(ci->mlock_on & CMODE_c) ? "c" : "",			
			(ci->mlock_on & CMODE_d) ? "d" : "",				
			(ci->mlock_on & CMODE_q) ? "q" : "",								
			(ci->mlock_on & CMODE_S) ? "S" : "",							
			(ci->mlock_on & CMODE_R) ? "R" : "",
			(ci->mlock_on & CMODE_B) ? "B" : "",
			(ci->mlock_on & CMODE_K) ? "K" : "",
			(ci->mlock_on & CMODE_O) ? "O" : "",
			(ci->mlock_on & CMODE_A) ? "A" : "",			
			(ci->mlock_on & CMODE_N) ? "N" : "",
			(ci->mlock_on & CMODE_C) ? "C" : "");
	    }
	    if (ci->mlock_off)
		printf("-%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
			(ci->mlock_off & CMODE_I) ? "i" : "",
			(ci->mlock_off & CMODE_k) ? "k" : "",
			(ci->mlock_off & CMODE_l) ? "l" : "",
			(ci->mlock_off & CMODE_M) ? "m" : "",
			(ci->mlock_off & CMODE_n) ? "n" : "",
			(ci->mlock_off & CMODE_P) ? "p" : "",
			(ci->mlock_off & CMODE_s) ? "s" : "",
			(ci->mlock_off & CMODE_T) ? "t" : "",
			(ci->mlock_off & CMODE_c) ? "c" : "",
			(ci->mlock_off & CMODE_d) ? "d" : "",				
			(ci->mlock_off & CMODE_q) ? "q" : "",								
			(ci->mlock_off & CMODE_S) ? "S" : "",									
			(ci->mlock_off & CMODE_R) ? "R" : "",
			(ci->mlock_off & CMODE_B) ? "B" : "",
			(ci->mlock_off & CMODE_K) ? "K" : "",
			(ci->mlock_off & CMODE_O) ? "O" : "",
			(ci->mlock_off & CMODE_A) ? "A" : "",
			(ci->mlock_off & CMODE_N) ? "N" : "",
			(ci->mlock_off & CMODE_C) ? "C" : "");			
	    if (ci->mlock_key)
		printf(" %s", ci->mlock_key);
	    if (ci->mlock_limit)
		printf(" %d", ci->mlock_limit);
	    printf("\n");
	}

    } else {
	for (i = 0; i < C_MAX; i++) {
	    for (ci = chanlists[i]; ci; ci = ci->next) {
		printf("%-20s  %s (%s)\n", ci->name,	
			ci->flags & CI_VERBOTEN ? "Disallowed (FORBID)"
			                        : ci->desc,
			ci->founder ? ci->founder->nick: "No Founder");
		count++;
	    }
	}
	printf("%d channels registered.\n", count);

    }

}

/*************************************************************************/

/* Return information on memory use.  Assumes pointers are valid. */

void get_chanserv_stats(long *nrec, long *memuse)
{
    long count = 0, mem = 0;
    int i, j;
    ChannelInfo *ci;

    for (i = 0; i < C_MAX; i++) {
	for (ci = chanlists[i]; ci; ci = ci->next) {
	    count++;
	    mem += sizeof(*ci);
	    if (ci->desc)
		mem += strlen(ci->desc)+1;
	    if (ci->url)
		mem += strlen(ci->url)+1;
	    if (ci->email)
		mem += strlen(ci->email)+1;
	    mem += ci->accesscount * sizeof(ChanAccess);
	    mem += ci->akickcount * sizeof(AutoKick);
	    for (j = 0; j < ci->akickcount; j++) {
		if (ci->akick[j].mask)
		    mem += strlen(ci->akick[j].mask)+1;
		if (ci->akick[j].reason)
		    mem += strlen(ci->akick[j].reason)+1;
	    }
	    if (ci->mlock_key)
		mem += strlen(ci->mlock_key)+1;
	    if (ci->last_topic)
		mem += strlen(ci->last_topic)+1;
	    if (ci->entry_message)
		mem += strlen(ci->entry_message)+1;
	    if (ci->levels)
		mem += sizeof(*ci->levels) * CA_SIZE;
	    mem += ci->memos.memocount * sizeof(Memo);
	    for (j = 0; j < ci->memos.memocount; j++) {
		if (ci->memos.memos[j].text)
		    mem += strlen(ci->memos.memos[j].text)+1;
	    }
	}
    }
    *nrec = count;
    *memuse = mem;
}


/*************************************************************************/
/*************************************************************************/

/* ChanServ initialization. */

void cs_init(void)
{
    Command *cmd;

    cmd = lookup_cmd(cmds, "REGISTER");
    if (cmd)
	cmd->help_param1 = s_NickServ;
    cmd = lookup_cmd(cmds, "SET SECURE");
    if (cmd)
	cmd->help_param1 = s_NickServ;
    cmd = lookup_cmd(cmds, "SET SUCCESSOR");
    if (cmd)
	cmd->help_param1 = (char *)(long)CSMaxReg;
}

/*************************************************************************/

/* Main ChanServ routine. */

void chanserv(const char *source, char *buf)
{
    char *cmd, *s;
    User *u = finduser(source);

    if (!u) {
	log2c("%s: user record for %s not found", s_ChanServ, source);
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
	notice_s(s_ChanServ, source, "\1PING %s", s);
    } else if (skeleton) {
	notice_lang(s_ChanServ, u, SERVICE_OFFLINE, s_ChanServ);
    /* 
    } else if (strcasecmp(cmd, "AOP") == 0 || strcasecmp(cmd, "SOP") == 0) {
	notice_lang(s_ChanServ, u, CHAN_NO_AOP_SOP, s_ChanServ);
    */	
    } else {
	run_cmd(s_ChanServ, u, cmds, cmd);
    }
}

/*************************************************************************/

/* Load/save data files. */


#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", ChanDBName);	\
	failed = 1;					\
	break;						\
    }							\
} while (0)

void load_cs_dbase(void)
{
    dbFILE *f;   
    FILE *stdb = NULL;
    char tmppass[20];
    int ver, i, j, c;
    int16 sver=0;
    ChannelInfo *ci;
    u_int32_t total;
    u_int32_t maxhash;
    int failed = 0;
    
    if (!(f = open_db(s_ChanServ, ChanDBName, "r")))
	return;
    
    if(listchans_stdb)
      {	
        stdb=fopen("chan.stdb","w");
        if(stdb==NULL)
          {
           printf("Could not create chan.stdb\n");
           return;
          }
        fprintf(stdb,"# .stdb file - (C) PTlink IRC Software 1999-2003 - http://www.ptlink.net/Coders/\n");
      }
      
    switch (ver = get_file_version(f)) {
      case -1:  read_int16(&sver, f);		    
      	  if(sver>DFV_CHANSERV) fatal("Unsupported subversion (%d) on %s", sver, ChanDBName);
	  if(sver<DFV_CHANSERV) log1("ChanServ DataBase WARNING: converting from subversion %d to %d",
	      sver,DFV_CHANSERV);
        if(sver>8)
          {
            SAFE(read_int32(&total, f));
            maxhash = C_MAX;
          }
        else
          maxhash = 256;
	for (i = 0; i < maxhash && !failed; i++) {
	    int16 tmp16;
	    int32 tmp32;
	    int n_levels;
	    char *tmpf;

	    while ((c = getc_db(f)) != 0) {
		if (c != 1)
		    fatal("Invalid format in %s", ChanDBName);
		ci = smalloc(sizeof(ChannelInfo));
                if(sver>9)
                  {
                    if(read_int32(&ci->scid, f)<0)
                      {
                        log1("Unexpected end of db, expecting %d nicks, got %lu",
                         total, DayStats.ns_total);
                        break;
                      }
                    if(ci->scid > last_scid)
                      last_scid = ci->scid;                      
		  } 
	        else
	          ci->scid = ++last_scid;

		SAFE(read_buffer(ci->name, f));
		insert_chan(ci);
		SAFE(read_string(&tmpf, f));
		if (tmpf)
		  {
		    ci->founder = findnick(tmpf);
		    free(tmpf);
		  }
		else
		    ci->founder = NULL;
		if (ver == 7 || sver) {
		    SAFE(read_string(&tmpf, f));
		    if (tmpf)
		      {
			ci->successor = findnick(tmpf);
			free(tmpf);
		       }
		    else
			ci->successor = NULL;
		} else {
		    ci->successor = NULL;
		}
		if(sver>2)
		{
		    SAFE(read_int16(&tmp16, f));
		    ci->maxusers = tmp16;
		    SAFE(read_int32(&tmp32, f));
		    ci->maxtime = tmp32;
		} else
		{
		    ci->maxusers = 0;
		    ci->maxtime = time(NULL);
		}
		DayStats.cs_total++;
		ci->scid = DayStats.cs_total;
		if (ver == 5 && ci->founder != NULL) {
		    /* Channel count incorrect in version 5 files */
		    ci->founder->channelcount++;
		}
		if (!(ci->founder) && ci->successor) {
		    NickInfo *ni2 = ci->successor;
		    if (ci->successor->channelcount >= ci->successor->channelmax) {
			log2c("%s: Successor (%s) of %s owns too many channels.",
			    s_ChanServ, ci->successor->nick, ci->name);
		    }  else {
			log2c("%s: Transferring foundership of founderless channel %s to successor %s",
			    s_ChanServ, ci->name, ni2->nick);
			ci->founder = ni2;
			ci->successor = NULL;
			if (ni2->channelcount+1 > ni2->channelcount)
			    ni2->channelcount++;
		    }
		}
		SAFE(read_buffer(ci->founderpass, f));
		SAFE(read_string(&ci->desc, f));
		if (!ci->desc)
		    ci->desc = sstrdup("");
		SAFE(read_string(&ci->url, f));
		SAFE(read_string(&ci->email, f));
		SAFE(read_int32(&tmp32, f));
		ci->time_registered = tmp32;
		SAFE(read_int32(&tmp32, f));
		ci->last_used = tmp32;
		SAFE(read_string(&ci->last_topic, f));
		SAFE(read_buffer(ci->last_topic_setter, f));
		SAFE(read_int32(&tmp32, f));
		ci->last_topic_time = tmp32;
		SAFE(read_int32(&ci->flags, f));		
		if(sver>5) {
		    SAFE(read_int16(&tmp16, f));
		    ci->crypt_method = tmp16;		
		} else
		    ci->crypt_method = (ci->flags & CI_ENCRYPTEDPW) ? 1 : 0;
		if(stdb && listchans_stdb)
		  {
                     if(ci->crypt_method==3)
                       strcpy(tmppass, hex_str(ci->founderpass,16));
                     else  
                       strcpy(tmppass, ci->founderpass);                                                                   		
                     fprintf(stdb, "%s %s %s %lu %lu\n",
                       ci->name,
                       (ci->flags & CI_VERBOTEN)  ? "*" : ci->founder->nick,
                       (ci->flags & CI_VERBOTEN)  ? "*" : tmppass,
                        (unsigned long int) ci->time_registered,
                        (unsigned long int) ci->last_used);
                  }		    
		if (!ci->crypt_method && EncryptMethod) {
		    if (debug)
			log1("debug: %s: encrypting password for %s on load",
				s_ChanServ, ci->name);
		    if (encrypt_in_place(ci->founderpass, PASSMAX) < 0)
			fatal("%s: load database: Can't encrypt %s password!",
				s_ChanServ, ci->name);
		    ci->crypt_method = EncryptMethod;		
		}
		if (ci->flags & CI_DROPPED)    {
		    SAFE(read_int32(&tmp32, f));
		    ci->drop_time = tmp32;		
		}
		SAFE(read_int16(&tmp16, f));
		n_levels = tmp16;
		ci->levels = smalloc(2*CA_SIZE);
		reset_levels(ci);
		for (j = 0; j < n_levels; j++) {
		    if (j < CA_SIZE)
			SAFE(read_int16(&ci->levels[j], f));
		    else
			SAFE(read_int16(&tmp16, f));
		}
		
		if(stdb && listchans_stdb)
                  fprintf(stdb,"ACCESS\n");
		SAFE(read_int16(&ci->accesscount, f));
		if (ci->accesscount) {
		    ci->access = scalloc(ci->accesscount, sizeof(ChanAccess));
		    for (j = 0; j < ci->accesscount; j++) {
			SAFE(read_int16(&ci->access[j].in_use, f));
			if (ci->access[j].in_use) {
			    SAFE(read_int16(&ci->access[j].level, f));
			    SAFE(read_string(&tmpf, f));
			    if (tmpf) {
				ci->access[j].ni = findnick(tmpf);
				free(tmpf);
			    }
			    if(sver>1) {
				SAFE(read_string(&tmpf, f));			    
				if (tmpf) {
				    if(tmpf[0]!='*') ci->access[j].who = findnick(tmpf);
					else ci->access[j].who = NULL;
				    free(tmpf);
				} else ci->access[j].who = NULL;
			    } else ci->access[j].who = NULL;		    
			    if(!ci->access[j].ni) 
			      ci->access[j].in_use = 0; /* access list bug killed :P */
                            if(stdb && listchans_stdb && ci->access[j].in_use)
                              fprintf(stdb, "%s %i\n",ci->access[j].ni->nick,ci->access[j].level);
			}			
		    }
		} else {
		    ci->access = NULL;
		}
		if(stdb && listchans_stdb)
		  fprintf(stdb,"-\n");		  
		SAFE(read_int16(&ci->akickcount, f));
		if (ci->akickcount) {
		    ci->akick = scalloc(ci->akickcount, sizeof(AutoKick));
		    for (j = 0; j < ci->akickcount; j++) {
			SAFE(read_int16(&ci->akick[j].in_use, f));
			if (ci->akick[j].in_use) {			   	
			    if(sver < 7) {
			    	int16 is_nick;
			        SAFE(read_int16(&is_nick, f));
			        SAFE(read_string(&tmpf, f));
			        if (is_nick) {
				    ci->akick[j].mask=malloc(strlen(tmpf)+5);
				    sprintf(ci->akick[j].mask,"%s!*@*",tmpf);
				    free(tmpf);
			         } else 
				ci->akick[j].mask = tmpf;
			    } else {
			    	SAFE(read_string(&tmpf, f));
			    	  ci->akick[j].mask = tmpf;
			    }
			    SAFE(read_string(&tmpf, f));
			    if (ci->akick[j].in_use)
				ci->akick[j].reason = tmpf;
			    else if (tmpf)
				free(tmpf);
			    if(sver > 4) {
				SAFE(read_string(&tmpf, f));			    
				if (tmpf) {
				    if(tmpf[0]!='*') ci->akick[j].who = findnick(tmpf);
					else ci->akick[j].who = NULL;
				    free(tmpf);
				} else ci->akick[j].who = NULL;
			    } else ci->akick[j].who = NULL;		    
			    if(sver>5) {
				SAFE(read_int32(&tmp32, f));
				ci->akick[j].last_kick = tmp32;
			    } else ci->akick[j].last_kick = time(NULL);
			}
		    }
		} else {
		    ci->akick = NULL;
		}

		if(sver<8)
		  {
		  	SAFE(read_int16(&tmp16, f));
			ci->mlock_on = tmp16 & 0xFFFF;		  	
		  	SAFE(read_int16(&tmp16, f));
			ci->mlock_off = tmp16 & 0xFFFF;
		  } else {
			SAFE(read_int32(&ci->mlock_on, f));
			SAFE(read_int32(&ci->mlock_off, f));
		  }
		SAFE(read_int32(&ci->mlock_limit, f));
		SAFE(read_string(&ci->mlock_key, f));

		SAFE(read_int16(&ci->memos.memocount, f));
		SAFE(read_int16(&ci->memos.memomax, f));
		if (ci->memos.memocount) {
		    Memo *memos;
		    memos = smalloc(sizeof(Memo) * ci->memos.memocount);
		    ci->memos.memos = memos;
		    for (j = 0; j < ci->memos.memocount; j++, memos++) {
			SAFE(read_int32(&memos->number, f));
			SAFE(read_int16(&memos->flags, f));
			SAFE(read_int32(&tmp32, f));
			memos->time = tmp32;
			SAFE(read_buffer(memos->sender, f));
			SAFE(read_string(&memos->text, f));
		    }
		} else ci->memos.memos = NULL;

		SAFE(read_string(&ci->entry_message, f));

		ci->c = NULL;
		
	    } /* while (getc_db(f) != 0) */
 
	} /* for (i) */

	break; /* case 5 and up */

      default:
	fatal("Unsupported version number (%d) on %s", ver, ChanDBName);

    } /* switch (version) */

    close_db(f);
    
    if(stdb && listchans_stdb)
      fclose(stdb);

    /* Check for non-forbidden channels with no founder */
    for (i = 0; i < C_MAX; i++) {
	ChannelInfo *next;
	for (ci = chanlists[i]; ci; ci = next) {
	    next = ci->next;
	    if (!(ci->flags & CI_VERBOTEN) && !ci->founder) {
		log1("%s: database load: Deleting founderless channel %s",
			s_ChanServ, ci->name);
		delchan(ci);
		DayStats.cs_total--;
	    }
	}
    }
    log2c("ChanServ: Loaded %lu channels", DayStats.cs_total);
}

#undef SAFE

#include "cs_save.c"

/*************************************************************************/

/* Check the current modes on a channel; if they conflict with a mode lock,
 * fix them. */

void check_modes(const char *chan, int sjoin)
{
    Channel *c = findchan(chan);
    ChannelInfo *ci;
    char newmodes[32], *newkey = NULL;
    int32 newlimit = 0;
    char *end = newmodes;
    int modes;
    int set_limit = 0, set_key = 0;

    if (!c || !(ci = c->ci) || c->bouncy_modes)
	return;

    /* Check for mode bouncing */
    if (!sjoin && c->server_modecount >= 3 && c->chanserv_modecount >= 3)
	  {
		  wallops(NULL, "Warning: unable to set modes on channel %s.  "
			"Are your servers' U:lines configured correctly?", chan);
		  log2c("%s: Bouncy modes on channel %s", s_ChanServ, ci->name);
		  c->bouncy_modes = 1;
	  return;
    }

    if (c->chanserv_modetime != time(NULL)) 	{
		c->chanserv_modecount = 0;
	  c->chanserv_modetime = time(NULL);
    }
    c->chanserv_modecount++;

    *end++ = '+';
    modes = ~c->mode & ci->mlock_on;
    if (modes & CMODE_B) {
	*end++ = 'B';
	c->mode |= CMODE_B;
    }
    if (modes & CMODE_R) {
	*end++ = 'R';
	c->mode |= CMODE_R;
    }    
    if (modes & CMODE_I) {
	*end++ = 'i';
	c->mode |= CMODE_I;
    }
    if (modes & CMODE_M) {
	*end++ = 'm';
	c->mode |= CMODE_M;
    }
    if (modes & CMODE_S) {
	*end++ = 'S';
	c->mode |= CMODE_S;
    }    
    if (modes & CMODE_d) {
	*end++ = 'd';
	c->mode |= CMODE_d;
    }  

    if (modes & CMODE_q) {
	*end++ = 'q';
	c->mode |= CMODE_q;
    }        
	  	  
    if (modes & CMODE_n) {
	  *end++ = 'n';	  	
	c->mode |= CMODE_n;
    }
    if (modes & CMODE_P) {
	*end++ = 'p';
	c->mode |= CMODE_P;
    }
    if (modes & CMODE_s) {
	*end++ = 's';
	c->mode |= CMODE_s;
    }
    if (modes & CMODE_T) {
	*end++ = 't';
	c->mode |= CMODE_T;
    }
    if (modes & CMODE_c) {
	*end++ = 'c';
	c->mode |= CMODE_c;
    }

    if (modes & CMODE_K) {
	*end++ = 'K';
	c->mode |= CMODE_K;
    }
	
    if (modes & CMODE_O) {
	*end++ = 'O';
	c->mode |= CMODE_O;
    }    
    if (modes & CMODE_A) {
	*end++ = 'A';
	c->mode |= CMODE_A;
    }
    if(modes & CMODE_N) {
	*end++ = 'N';
	c->mode |= CMODE_N;
    }
    if(modes & CMODE_C) {
	*end++ = 'C';
	c->mode |= CMODE_C;
    }       
    if (ci->mlock_limit && ci->mlock_limit != c->limit) {
	*end++ = 'l';
	newlimit = ci->mlock_limit;
	c->limit = newlimit;
	set_limit = 1;
    }
    if (!c->key && ci->mlock_key) {
	*end++ = 'k';
	newkey = ci->mlock_key;
	c->key = sstrdup(newkey);
	set_key = 1;
    } else if (c->key && ci->mlock_key && strcmp(c->key, ci->mlock_key) != 0) {
	char *av[3];
	send_cmd(s_ChanServ, "MODE %s -k %s", c->name, c->key);
	av[0] = sstrdup(c->name);
	av[1] = sstrdup("-k");
	do_cmode(s_ChanServ, 2, av);
	free(av[0]);
	free(av[1]);
	free(c->key);
	*end++ = 'k';
	newkey = ci->mlock_key;
	c->key = sstrdup(newkey);
	set_key = 1;
    }

    if (end[-1] == '+')
	end--;

    *end++ = '-';
    modes = c->mode & ci->mlock_off;
    if (modes & CMODE_B) {
	*end++ = 'B';
	c->mode &= ~CMODE_B;
    }
    if (modes & CMODE_R) {
	*end++ = 'R';
	c->mode &= ~CMODE_R;
    }
    
    if (modes & CMODE_I) {
	*end++ = 'i';
	c->mode &= ~CMODE_I;
    }
    if (modes & CMODE_M) {
	*end++ = 'm';
	c->mode &= ~CMODE_M;
    }
    if (modes & CMODE_S) {
	*end++ = 'S';
	c->mode &= ~CMODE_S;
    }
    if (modes & CMODE_d) {
	*end++ = 'd';
	c->mode &= ~CMODE_d;
    }

    if (modes & CMODE_q) {
	*end++ = 'q';
	c->mode &= ~CMODE_q;
    }    
	
    if (modes & CMODE_n) {
	*end++ = 'n';
	c->mode &= ~CMODE_n;
    }
    if (modes & CMODE_P) {
	*end++ = 'p';
	c->mode &= ~CMODE_P;
    }
    if (modes & CMODE_s) {
	*end++ = 's';
	c->mode &= ~CMODE_s;
    }
    if (modes & CMODE_T) {
	*end++ = 't';
	c->mode &= ~CMODE_T;
    }
    if (modes & CMODE_c) {
	*end++ = 'c';
	c->mode &= ~CMODE_c;
    }
	
    if (modes & CMODE_K) {
	*end++ = 'K';
	c->mode &= ~CMODE_K;
    }
	
    if (modes & CMODE_O) {
	*end++ = 'O';
	c->mode &= ~CMODE_O;
    }    
    if (modes & CMODE_A) {
	*end++ = 'A';
	c->mode &= ~CMODE_A;
    }        
    if(modes & CMODE_N) {
	*end++ = 'N';
	c->mode &= ~CMODE_N;
    }
    if(modes & CMODE_C) {
	*end++ = 'C';
	c->mode &= ~CMODE_C;
    }
    
    if (c->key && (ci->mlock_off & CMODE_k)) {
	*end++ = 'k';
	newkey = sstrdup(c->key);
	free(c->key);
	c->key = NULL;
	set_key = 1;
    }
    if (c->limit && (ci->mlock_off & CMODE_l)) {
	*end++ = 'l';
	c->limit = 0;
    }

    if (end[-1] == '-')
	end--;

    if (end == newmodes)
	return;
    *end = 0;
    if (set_limit) {
	if (set_key)
	    send_cmd(s_ChanServ, "MODE %s %s %d :%s", c->name,
				newmodes, newlimit, newkey ? newkey : "");
	else
	    send_cmd(s_ChanServ, "MODE %s %s %d", c->name,
				newmodes, newlimit);
    } else if (set_key) {
	send_cmd(s_ChanServ, "MODE %s %s :%s", c->name,
				newmodes, newkey ? newkey : "");
    } else {
	send_cmd(s_ChanServ, "MODE %s %s", c->name, newmodes);
    }

    if (newkey && !c->key)
	free(newkey);
}

/*************************************************************************/

/* Check whether a user is allowed to be opped on a channel; if they
 * aren't, deop them.  If serverop is 1, the +o was done by a server.
 * Return 1 if the user is allowed to be opped, 0 otherwise. */

int check_valid_op(User *user, const char *chan, int serverop)
{
    ChannelInfo *ci = cs_findchan(chan);

    if (!ci || (ci->flags & CI_LEAVEOPS))
	return 1;
	
    if (ci->flags & CI_VERBOTEN) 
	  {
	    /* check_kick() will get them out; we needn't explain. */
	    send_cmd(s_ChanServ, "MODE %s -o %s", chan, user->nick);
	    return 0;
  	  }
  	  
    if (serverop && time(NULL)-start_time >= CSRestrictDelay
				&& !check_access(user, ci, CA_AUTOOP)) {
	notice_lang(s_ChanServ, user, CHAN_IS_REGISTERED, s_ChanServ);
	send_cmd(s_ChanServ, "MODE %s -o %s", chan, user->nick);
	return 0;
    }

    if (check_access(user, ci, CA_AUTODEOP)) {
    	send_cmd(s_ChanServ, "MODE %s -o %s", chan, user->nick);
	return 0;
    }

    return 1;
}

int check_should_deop(User *user, const char *chan)
{
    ChannelInfo *ci = cs_findchan(chan);

    if (!ci || (ci->flags & CI_VERBOTEN) || *chan == '+')
	return 0;

    if ( !nick_identified(user) )
	return 0;

    if (!check_access(user, ci, CA_AUTOOP)) {
	send_cmd(s_ChanServ, "MODE %s -o %s", chan, user->nick);
	return 1;
    } else ci->last_used = time(NULL);

    return 0;
}

#ifdef HALFOPS
int check_valid_halfop(User *user, const char *chan, int serverop)
{
    ChannelInfo *ci = cs_findchan(chan);

    if (!ci || (ci->flags & CI_LEAVEOPS))
        return 1;
    
    if (ci->flags & CI_VERBOTEN)
          {
            send_cmd(s_ChanServ, "MODE %s -h %s", chan, user->nick);
            return 0;
          }

    if (serverop && time(NULL)-start_time >= CSRestrictDelay
                                && !check_access(user, ci, CA_AUTOHALFOP)) {
       notice_lang(s_ChanServ, user, CHAN_IS_REGISTERED, s_ChanServ);
           send_cmd(s_ChanServ, "MODE %s -h %s", chan, user->nick);
       return 0;
    }

    return 1;
} 


int check_should_dehalfop(User *user, const char *chan)
{
    ChannelInfo *ci = cs_findchan(chan);
    
    if (!ci || (ci->flags & CI_VERBOTEN) || *chan == '+')
        return 0;

    if ( !nick_identified(user) )
        return 0;

    if (!check_access(user, ci, CA_AUTOHALFOP)) {
            send_cmd(s_ChanServ, "MODE %s -h %s", chan, user->nick);
        return 1;
    } else ci->last_used = time(NULL);         
  
    return 0;
}  

int check_should_halfop(User *user, const char *chan, int was)
{
    ChannelInfo *ci = cs_findchan(chan);
    if (!ci) return was;
    if ((ci->flags & CI_VERBOTEN) || *chan == '+' || !nick_identified(user))
    {
        if(was) buffer_mode("-h", user->nick);
               return 0;
    }
    if (check_access(user, ci, CA_AUTOHALFOP)) {
        ci->last_used = time(NULL);
        if (!was) /* will not send dummy mode, doh :) */
            buffer_mode("+h", user->nick);
        if(HelpChan && !irccmp(&chan[1],HelpChan) && !IsHelper(user) && !IsBot(user))
          {
               send_cmd(s_NickServ, "SVSMODE %s +h ", user->nick);
               log2c("Helper: %s is now an IRC helper",user->nick);
          }
        return 1;
     } else if(was) buffer_mode("-h", user->nick);
     return 0;
}
#endif

/*************************************************************************/
/* ---- Lamego 1999  							 */
/* Check whether a user should be opped on a channel, and if so, do it.
 * Return 1 if the user was opped, 0 otherwise.  (Updates the channel's
 * last used time if the user was opped.) */

int check_should_op(User *user, const char *chan, int was)
{
    ChannelInfo *ci = cs_findchan(chan);
    if (!ci) return was;
    if ((ci->flags & CI_VERBOTEN) || *chan == '+' || !nick_identified(user))
    {
	if(was) buffer_mode("-o", user->nick);
	return 0;
    }
    if (check_access(user, ci, CA_AUTOOP)) {
	ci->last_used = time(NULL);
	if(!was) /* will not send dummy mode */
	    buffer_mode("+o", user->nick);
	if(HelpChan && !irccmp(&chan[1],HelpChan) && !IsHelper(user) && !IsBot(user)) 
	  {
	       send_cmd(s_NickServ, "SVSMODE %s +h ", user->nick);
	       log2c("Helper: %s is now an IRC helper",user->nick);
	}
	return 1;
    } else if(was) buffer_mode("-o", user->nick);
    return 0;
}

/*************************************************************************/
/* ---- Lamego 1999  							 */                 
/* Check whether a user should be protected on a channel, and if so, do it.
 * Return 1 if the user was protected, 0 otherwise.  (Updates the channel's
 * last used time if the user was opped.) */

int check_should_protect(User *user, const char *chan, int was)
{
    ChannelInfo *ci = cs_findchan(chan);

    if (!ci) return was;
    if ((ci->flags & CI_VERBOTEN) || *chan == '+' || !nick_identified(user))
    {
    /* only services can set +a, so lets trust it (uncomment to avoid mode +a hack)
	if(was) buffer_mode("-a", user->nick);
    */
	return 0;
    }
    if (check_access(user, ci, CA_PROTECT)) {
	ci->last_used = time(NULL);
	if(!was) /* will not send dummy mode */
	    buffer_mode("+a", user->nick);
	return 1;
    }
    /* only services can set +a, so lets trust it (uncomment to avoid mode +a hack)
     else if(was) buffer_mode("-a", user->nick);
    */
    return 0;
}

/*************************************************************************/

/* Check whether a user should be voiced on a channel, and if so, do it.
 * Return 1 if the user was voiced, 0 otherwise. */

int check_should_voice(User *user, const char *chan, int was)
{
    ChannelInfo *ci = cs_findchan(chan);

    if (!ci) return was;
    if ((ci->flags & CI_VERBOTEN) || *chan == '+' || !nick_identified(user))
    {
	if(was) buffer_mode("-v", user->nick);
	return 0;
    }
    if (check_access(user, ci, CA_AUTOVOICE)) {
	ci->last_used = time(NULL);
	if(!was) /* will not send dummy mode */
	    buffer_mode("+v", user->nick);
	return 1;
    } else if(was) buffer_mode("-v", user->nick);
    return 0;
}

/*************************************************************************/

/* Tiny helper routine to get ChanServ out of a channel after it went in. */

static void timeout_leave(Timeout *to)
{
    char *chan = to->data;
    send_cmd(s_ChanServ, "PART %s", chan);
    free(to->data);
}


/* Check whether a user is permitted to be on a channel.  If so, return 0;
 * else, kickban the user with an appropriate message (could be either
 * AKICK or restricted access) and return 1.  Note that this is called
 * _before_ the user is added to internal channel lists (so do_kick() is
 * not called).
 */

/*************************************************************************/

/* `last' is set to the last index this routine was called with */
static int akick_del(AutoKick *akick)
{
    if (!akick->in_use)
	return 0;
    free(akick->mask);
    akick->mask = NULL;
    if (akick->reason) {
	free(akick->reason);
	akick->reason = NULL;
    }
    akick->in_use = 0;
    return 1;
}

int check_kick(User *user, const char *chan, ChannelInfo *ci)
{
    AutoKick *akick;
    int i;
    NickInfo *ni;
    char *av[3], *mask;
    const char *reason;
    Timeout *t;
    int stay;

    if (is_oper(user->nick) || is_services_admin(user))
	  return 0;

    if (ci->flags & CI_VERBOTEN) {
	mask = create_mask(user);
	reason = getstring(user, CHAN_MAY_NOT_BE_USED);
	goto kick;
    }

    if (nick_identified(user))
	ni = user->ni;
    else
	ni = NULL;

    for (akick = ci->akick, i = 0; i < ci->akickcount; akick++, i++) {
	if (!akick->in_use)
	    continue;
	if (match_usermask(akick->mask, user)) {
	    if (debug >= 2) 
		log1("debug: %s matched akick %s", user->nick, akick->mask);	    
	    mask = sstrdup(akick->mask);
	    reason = akick->reason ? akick->reason : CSAutokickReason;
	    akick->last_kick = time(NULL);
	    goto kick;
	} else if(CSLostAKick && (time(NULL) - akick->last_kick > CSLostAKick)) {
	    log2c("%s: Expiring akick for %s on channel %s",s_ChanServ,
		akick->mask,ci->name);
	    akick_del(akick);
	  }
    }
    if (time(NULL)-start_time >= CSRestrictDelay
				&& check_access(user, ci, CA_NOJOIN)) {
	mask = create_mask(user);
	reason = getstring(user, CHAN_NOT_ALLOWED_TO_JOIN);
	goto kick;
    }
    if ((ci->mlock_on & CMODE_R) && !nick_identified(user)) {
	mask = create_mask(user);
	reason = getstring(user, CHAN_NEED_REGNICK);
	goto kick;	
    }
    if ((ci->mlock_on & (CMODE_I | CMODE_k | CMODE_A | CMODE_O)) && (get_access(user,ci)<1)
	&& !findchan(chan)) {
	mask = create_mask(user);
	reason = getstring(user, CHAN_MODE_PROTECTED);
	stay = 1;
	goto kick2;	
    }    
    return 0;

kick:
    if (debug) {
	log1("debug: channel: AutoKicking %s!%s@%s",
		user->nick, user->username, user->host);
    }
    /* Remember that the user has not been added to our channel user list
     * yet, so we check whether the channel does not exist */
    stay = !findchan(chan);
kick2:    
    av[0] = sstrdup(chan);
    if (stay) 
	  {
		send_cmd(ServerName, "SJOIN 1 %s + :%s", chan, s_ChanServ);
		strcpy(av[0], chan);
  	  }
    strcpy(av[0], chan);
    av[1] = sstrdup("+b");
    av[2] = mask;
    send_cmd(s_ChanServ, "MODE %s +b %s  %lu", chan, av[2], (unsigned long int) time(NULL));
    do_cmode(s_ChanServ, 3, av);
    free(av[0]);
    free(av[1]);
    free(av[2]);
    send_cmd(s_ChanServ, "KICK %s %s :%s", chan, user->nick, reason);
    if (stay) {
	t = add_timeout(CSInhabit, timeout_leave, 0);
	t->data = sstrdup(chan);
    }
    return 1;
}

/*************************************************************************/

/* Record the current channel topic in the ChannelInfo structure. */

void record_topic(const char *chan)
{
    Channel *c;
    ChannelInfo *ci;

    if (readonly)
	return;
    c = findchan(chan);
    if (!c || !(ci = c->ci))
	return;
    if (ci->last_topic)
	free(ci->last_topic);
    if (c->topic)
	ci->last_topic = sstrdup(c->topic);
    else
	ci->last_topic = NULL;
    strscpy(ci->last_topic_setter, c->topic_setter, NICKMAX);
    ci->last_topic_time = c->topic_time;
}

/*************************************************************************/

/* Restore the topic in a channel when it's created, if we should. */

void restore_topic(const char *chan)
{
    Channel *c = findchan(chan);
    ChannelInfo *ci;

    if (!c || !(ci = c->ci) || !(ci->flags & CI_KEEPTOPIC))
	return;
    if (c->topic)
	free(c->topic);
    if (ci->last_topic) {
	c->topic = sstrdup(ci->last_topic);
	strscpy(c->topic_setter, ci->last_topic_setter, NICKMAX);
	c->topic_time = ci->last_topic_time;
    } else {
	c->topic = NULL;
	strscpy(c->topic_setter, s_ChanServ, NICKMAX);
    }
    send_cmd(s_ChanServ, "TOPIC %s %s %lu :%s", chan,
		c->topic_setter, (unsigned long int) c->topic_time, c->topic ? c->topic : "");
}

/*************************************************************************/

/* See if the topic is locked on the given channel, and return 1 (and fix
 * the topic) if so. */

int check_topiclock(const char *chan)
{
    Channel *c = findchan(chan);
    ChannelInfo *ci;

    if (!c || !(ci = c->ci) || !(ci->flags & CI_TOPICLOCK))
	return 0;
    if (c->topic)
	free(c->topic);
    if (ci->last_topic)
	c->topic = sstrdup(ci->last_topic);
    else
	c->topic = NULL;
    strscpy(c->topic_setter, ci->last_topic_setter, NICKMAX);
    c->topic_time = ci->last_topic_time;
    send_cmd(s_ChanServ, "TOPIC %s %s %lu :%s", chan,
		c->topic_setter, (unsigned long int) c->topic_time, c->topic ? c->topic : "");
    return 1;
}

/*************************************************************************/

/* Remove all channels which have expired. */

void expire_chans()
{
    ChannelInfo *ci, *next;
    int i;
    time_t now = time(NULL);

    if (!CSExpire)
	return;

    for (i = 0; i < C_MAX; i++) {
	for (ci = chanlists[i]; ci; ci = next) {
	    next = ci->next;
	    if (now - ci->last_used >= CSExpire
			&& !(ci->flags & (CI_VERBOTEN | CI_NO_EXPIRE))) {
		log2c("Expiring channel %s", ci->name);
		DayStats.cs_total--;
		DayStats.cs_expired++;
		delchan(ci);		
	    } else 
	    if (CSRegExpire && (ci->last_used<=ci->time_registered)
		    && (now - ci->last_used >= CSRegExpire)
		    && !(ci->flags & (CI_VERBOTEN | CI_NO_EXPIRE))) {
		log2c("Expiring never used channel %s", ci->name);
		DayStats.cs_total--;
		DayStats.cs_expired++;
		delchan(ci);		
	    } else 	    
	    if ((ci->flags & CI_DROPPED) && !(ci->flags & CI_VERBOTEN) 
		    && (now - ci->drop_time >= CSDropDelay)) {
		log2c("Executing drop on channel %s", ci->name);
		DayStats.cs_total--;
		DayStats.cs_dropped++;
		delchan(ci);		
	    } 
	}
    }
}

/*************************************************************************/

/* Remove a (deleted or expired) nickname from all channel lists. */

void cs_remove_nick(const NickInfo *ni)
{
    int i, j;
    ChannelInfo *ci, *next;
    ChanAccess *ca;
    AutoKick *akick;

    for (i = 0; i < C_MAX; i++) {
	for (ci = chanlists[i]; ci; ci = next) {
	    next = ci->next;
	    if (ci->successor == ni) /* remove from successor */
	      ci->successor = NULL;
	    if (ci->founder == ni) {
		if (ci->successor) {
		    NickInfo *ni2 = ci->successor;
		    if (ni2->channelcount >= ni2->channelmax) {
			log2c("%s: Successor (%s) of %s owns too many channels, "
			    "deleting channel",
			    s_ChanServ, ni2->nick, ci->name);			    
			delchan(ci);
			DayStats.cs_total--;
			DayStats.cs_expired++;
			continue;			
		    } else {
			log2c("%s: Transferring foundership of %s from deleted "
			    "nick %s to successor %s",
			    s_ChanServ, ci->name, ni->nick, ni2->nick);
			ci->founder = ni2;
			ci->successor = NULL;
			if (ni2->channelcount+1 > ni2->channelcount)
			    ni2->channelcount++;
		    }
		} else {
		    log2c("%s: Deleting channel %s owned by deleted nick %s",
				s_ChanServ, ci->name, ni->nick);
		    delchan(ci);
		    DayStats.cs_total--;
		    DayStats.cs_expired++;
		    continue;		    
		}
	    }
	    for (ca = ci->access, j = ci->accesscount; j > 0; ca++, j--) {
		if (ca->in_use && ca->ni == ni) {
		    ca->in_use = 0;
		    ca->ni = NULL;
		}
		if (ca->in_use && ca->who && ca->who == ni) {
		    ca->who = NULL;
		}
		
	    }
	    for (akick = ci->akick, j = ci->akickcount; j > 0; akick++, j--) {
		if (akick->in_use && akick->who && akick->who == ni)
		    akick->who = NULL;						
	    }
	}
    }
}

/*************************************************************************/

/* Return the ChannelInfo structure for the given channel, or NULL if the
 * channel isn't registered. */

ChannelInfo *cs_findchan(const char *chan)
{
    ChannelInfo *ci;
    u_int32_t hashv = cs_hash_chan_name(chan);
    for (ci = chanlists[hashv]; ci; ci = ci->next) {
	if (irccmp(ci->name, chan) == 0)
	    return ci;
    }
    return NULL;
}

/*************************************************************************/

/* Return 1 if the user's access level on the given channel falls into the
 * given category, 0 otherwise.  Note that this may seem slightly confusing
 * in some cases: for example, check_access(..., CA_NOJOIN) returns true if
 * the user does _not_ have access to the channel (i.e. matches the NOJOIN
 * criterion). */

int check_access(User *user, ChannelInfo *ci, int what)
{
    int level = get_access(user, ci);
    int limit = ci->levels[what];

    if (level == ACCESS_FOUNDER)
	return (what==CA_AUTODEOP || what==CA_NOJOIN) ? 0 : 1;
    /* Hacks to make flags work */
    if (what == CA_AUTODEOP && (ci->flags & CI_SECUREOPS) && level == 0
	&& !IsOper(user))
	return 1;
    if (limit == ACCESS_INVALID)
	return 0;
    if (what == CA_AUTODEOP || what == CA_NOJOIN)
	return level <= ci->levels[what];
    else
	return level >= ci->levels[what];
}

/*************************************************************************/
/*********************** ChanServ private routines ***********************/
/*************************************************************************/

/* Insert a channel into memory hash table */

static void insert_chan(ChannelInfo *ci)
{
    ChannelInfo *head;
    char *chan = ci->name;
    u_int32_t hashv = cs_hash_chan_name(chan);
    head = chanlists[hashv];
    if(head)
      head->prev = ci;                          
    ci->next = head;
    ci->prev = NULL;
    chanlists[hashv] = ci;            
}

/*************************************************************************/

/* Add a channel to the database.  Returns a pointer to the new ChannelInfo
 * structure if the channel was successfully registered, NULL otherwise.
 * Assumes channel does not already exist. */

static ChannelInfo *makechan(const char *chan)
{
    ChannelInfo *ci;

    ci = scalloc(sizeof(ChannelInfo), 1);
    strscpy(ci->name, chan, CHANMAX);
    ci->time_registered = time(NULL);
    ci->scid = ++last_scid;
    reset_levels(ci);
    insert_chan(ci);
    return ci;
}

/*************************************************************************/

/* Remove a channel from the ChanServ database.  Return 1 on success, 0
 * otherwise. */

static int delchan(ChannelInfo *ci)
{
    int i;
    NickInfo *ni = ci->founder;
    u_int32_t hashv = cs_hash_chan_name(ci->name);
    
    if (ci->c)
	ci->c->ci = NULL;
    if (ci->next)
	ci->next->prev = ci->prev;
    if (ci->prev)
	ci->prev->next = ci->next;
    else
	chanlists[hashv] = ci->next;
    if (ci->desc)
	free(ci->desc);
    if (ci->mlock_key)
	free(ci->mlock_key);
    if (ci->last_topic)
	free(ci->last_topic);
    if(ci->url)
      free(ci->url);
    if (ci->access)
	free(ci->access);
    for (i = 0; i < ci->akickcount; i++) {
	if (ci->akick[i].mask)
	    free(ci->akick[i].mask);
	if (ci->akick[i].reason)
	    free(ci->akick[i].reason);
    }
    if (ci->akick)
	free(ci->akick);
    if (ci->levels)
	free(ci->levels);
    if (ci->memos.memos) {
	for (i = 0; i < ci->memos.memocount; i++) {
	    if (ci->memos.memos[i].text)
		free(ci->memos.memos[i].text);
	}
	free(ci->memos.memos);
    }
    free(ci);
    while (ni) {
	if (ni->channelcount > 0)
	    ni->channelcount--;
	ni = ni->link;
    }
    return 1;
}

/*************************************************************************/

/* Reset channel access level values to their default state. */

static void reset_levels(ChannelInfo *ci)
{
    int i;

    if (ci->levels)
	free(ci->levels);
    ci->levels = smalloc(CA_SIZE * sizeof(*ci->levels));
    for (i = 0; def_levels[i][0] >= 0; i++)
	ci->levels[def_levels[i][0]] = def_levels[i][1];
}

/*************************************************************************/

/* Does the given user have founder access to the channel? */

static int is_founder(User *user, ChannelInfo *ci)
{
    if (user->ni == getlink(ci->founder)) {
	if (nick_identified(user))
	    return 1;
    }
    
    if (is_identified(user, ci))
	return 1;
    return 0;
}

/*************************************************************************/

/* Has the given user password-identified as founder for the channel? */

int is_identified(User *user, ChannelInfo *ci)
{
    struct u_chaninfolist *c;

    for (c = user->founder_chans; c; c = c->next) {
	if (c->chan == ci)
	    return 1;
    }
    return 0;
}


/*************************************************************************/

/* Return the access level the given user has on the channel.  If the
 * channel doesn't exist, the user isn't on the access list, or the channel
 * is CS_SECURE and the user hasn't IDENTIFY'd with NickServ, return 0. */
static int get_access(User *user, ChannelInfo *ci)
{
    NickInfo *ni = user->ni;
    ChanAccess *access;
    int i;
    if (!ci || !ni)
	return 0;
    if (is_founder(user, ci))
	return ACCESS_FOUNDER;
    if (nick_identified(user))
    {
	for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
	    if (access->in_use && access->ni &&
		((ci->flags & CI_NOLINKS) ? 
		    (access->ni==user->real_ni) : (getlink(access->ni) == ni)))
		return access->level;
	}
    }
    return 0;
}

/*************************************************************************/
/*********************** ChanServ command routines ***********************/
/*************************************************************************/

static void do_help(User *u)
{
    char *cmd = strtok(NULL, "");

    if (!cmd) {
	notice_help(s_ChanServ, u, CHAN_HELP);
	if (CSExpire >= 86400)
	    notice_help(s_ChanServ, u, CHAN_HELP_EXPIRES, CSExpire/86400);
	if (is_services_oper(u))
	    notice_help(s_ChanServ, u, CHAN_SERVADMIN_HELP);
    } else if (strcasecmp(cmd, "LEVELS DESC") == 0) {
	int i;
	notice_help(s_ChanServ, u, CHAN_HELP_LEVELS_DESC);
	if (!levelinfo_maxwidth) {
	    for (i = 0; levelinfo[i].what >= 0; i++) {
		int len = strlen(levelinfo[i].name);
		if (len > levelinfo_maxwidth)
		    levelinfo_maxwidth = len;
	    }
	}
	for (i = 0; levelinfo[i].what >= 0; i++) {
	    notice_help(s_ChanServ, u, CHAN_HELP_LEVELS_DESC_FORMAT,
			levelinfo_maxwidth, levelinfo[i].name,
			getstring(u, levelinfo[i].desc));
	}
    } else {
	help_cmd(s_ChanServ, u, cmds, cmd);
    }
}

/*************************************************************************/

static void do_register(User *u)
{
    char *chan = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    char *desc = strtok(NULL, "");
    NickInfo *ni = u->ni;
    Channel *c;
    ChannelInfo *ci;
    struct u_chaninfolist *uc;
    char **autoj;
    int i;
    char founderpass[PASSMAX+1];
    if (readonly) {
	notice_lang(s_ChanServ, u, CHAN_REGISTER_DISABLED);
	return;
    }
    if (!chan || !pass || !desc) {
	syntax_error(s_ChanServ, u, "REGISTER", CHAN_REGISTER_SYNTAX);
    } else if (*chan == '&') {
	notice_lang(s_ChanServ, u, CHAN_REGISTER_NOT_LOCAL);
    } else if (!ni) {
	notice_lang(s_ChanServ, u, CHAN_MUST_REGISTER_NICK,s_NickServ);
    } else if (!nick_identified(u)) {
	notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
		s_NickServ, s_NickServ);
    } else if (NSNeedAuth && !u->ni->email) {
         notice_lang(s_NickServ, u, NICK_AUTH_NEEDED, s_NickServ);         		
    } else if (!is_chanop(u->nick, chan)) {
	notice_lang(s_ChanServ, u, CHAN_MUST_BE_CHANOP);
    } else if (CSRestrictReg && !is_services_oper(u)) {
	notice_lang(s_ChanServ, u, CHAN_RESTRICT_REGISTER);	
    } else if ((ci = cs_findchan(chan)) != NULL) {
	if (ci->flags & CI_VERBOTEN) {
	    log2c("%s: Attempt to register FORBIDden channel %s by %s!%s@%s",
			s_ChanServ, ci->name, u->nick, u->username, u->host);			
	    notice_lang(s_ChanServ, u, CHAN_MAY_NOT_BE_REGISTERED, chan);
	} else {
	    notice_lang(s_ChanServ, u, CHAN_ALREADY_REGISTERED, chan);
	}
    } else if (ni->channelmax > 0 && ni->channelcount >= ni->channelmax) {
	notice_lang(s_ChanServ, u,
		ni->channelcount > ni->channelmax
					? CHAN_EXCEEDED_CHANNEL_LIMIT
					: CHAN_REACHED_CHANNEL_LIMIT,
		ni->channelmax);

    } else if (!(c = findchan(chan))) {
	log2c("%s: Channel %s not found for REGISTER", s_ChanServ, chan);
	notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);

    } else if (!(ci = makechan(chan))) {
	log2c("%s: makechan() failed for REGISTER %s", s_ChanServ, chan);
	notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);

    } else if (strscpy(founderpass, pass, PASSMAX+1),
               encrypt_in_place(founderpass, PASSMAX) < 0) {
	log1("%s: Couldn't encrypt password for %s (REGISTER)",
		s_ChanServ, chan);
	notice_lang(s_ChanServ, u, CHAN_REGISTRATION_FAILED);
	delchan(ci);
    } else {
	ci->crypt_method = EncryptMethod;
	c->ci = ci;
	ci->c = c;
	ci->flags = CI_KEEPTOPIC;
	ci->mlock_on = CMODE_n | CMODE_T;
	ci->memos.memomax = MSMaxMemos;
	ci->last_used = ci->time_registered;
	ci->founder = u->real_ni;
	if (strlen(pass) > PASSMAX-1)
	    notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
	memcpy(ci->founderpass, founderpass, PASSMAX);
	ci->desc = sstrdup(desc);
	if (c->topic) {
	    ci->last_topic = sstrdup(c->topic);
	    strscpy(ci->last_topic_setter, c->topic_setter, NICKMAX);
	    ci->last_topic_time = c->topic_time;
	}
	c->maxusers = c->n_users;
	c->maxtime = time(NULL);
	ci->maxusers = c->maxusers;
	ci->maxtime = c->maxtime;
	ni = ci->founder;
	while (ni) {
	    if (ni->channelcount+1 > ni->channelcount)  /* Avoid wraparound */
		ni->channelcount++;
	    ni = ni->link;
	}
	log2c("%s: Channel %s registered by %s!%s@%s", s_ChanServ, chan,
		u->nick, u->username, u->host);		
	DayStats.cs_total++;
	DayStats.cs_registered++;	
	notice_lang(s_ChanServ, u, CHAN_REGISTERED, chan, u->nick);
	notice_lang(s_ChanServ, u, CHAN_PASSWORD_IS, pass);
	memset(pass, 0, strlen(pass));
	uc = smalloc(sizeof(*uc));
	uc->next = u->founder_chans;
	uc->prev = NULL;
	if (u->founder_chans)
	    u->founder_chans->prev = uc;
	u->founder_chans = uc;
	uc->chan = ci;
	/* Implement new mode lock */
	check_modes(ci->name, 0);
	/* should protect user on register (suggested by Chucky3) */
	send_cmd(s_ChanServ, "MODE %s +ra %s", chan, u->nick);		
	ni = ci->founder;
	if (ni->ajoincount >= NSAJoinMax) 	
		return;
	if (!CSAutoAjoin) {
		notice_lang(s_ChanServ, u, CHAN_AJOIN_ADD, s_NickServ,chan);
		return;
	}
	for (autoj = ni->autojoin, i = 0; i < ni->ajoincount; autoj++, i++) {
	    if (strcasecmp(*autoj, chan) == 0) {
		return;
	    }
	}
	ni->ajoincount++;
	ni->autojoin = srealloc(ni->autojoin, sizeof(char *) * ni->ajoincount);
	ni->autojoin[ni->ajoincount-1] = sstrdup(chan);
	notice_lang(s_ChanServ, u, NICK_AJOIN_ADDED, chan);
	
    }
}

/*************************************************************************/

static void do_identify(User *u)
{
    char *chan = strtok(NULL, " ");
    char *pass = strtok(NULL, " ");
    ChannelInfo *ci;
    struct u_chaninfolist *uc;

    if (!pass || !chan) {
	syntax_error(s_ChanServ, u, "IDENTIFY", CHAN_IDENTIFY_SYNTAX);
    } else if (!nick_recognized(u)) {
	notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
		s_NickServ, s_NickServ);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else {
	int res;

	if ((res = check_password(pass, ci->founderpass, ci->crypt_method)) == 1) {
	    if (!is_identified(u, ci)) {
		uc = smalloc(sizeof(*uc));
		uc->next = u->founder_chans;
		uc->prev = NULL;
		if (u->founder_chans)
		    u->founder_chans->prev = uc;
		u->founder_chans = uc;
		uc->chan = ci;
		if(ci->crypt_method != EncryptMethod) {
		    strncpy(ci->founderpass,pass,PASSMAX-1);
		    if(encrypt_in_place(ci->founderpass, PASSMAX)<0) {
			log2c("%s: Couldn't encrypt password for %s (IDENTIFY)",
			    s_ChanServ, ci->name);
			return;
		    }
		    ci->crypt_method = EncryptMethod;
		    log2c("%s: %s!%s@%s identified for chan %s with encryption change to %i", s_NickServ,
			u->nick, u->username, u->host, ci->name, EncryptMethod);	    
		} else
		    log2c("%s: %s!%s@%s identified for %s", s_ChanServ,
			u->nick, u->username, u->host, ci->name);
	    }
	    notice_lang(s_ChanServ, u, CHAN_IDENTIFY_SUCCEEDED, chan);	    
	    if(ci->flags & CI_DROPPED) {
	        char buf[BUFSIZE];
	        struct tm *tm;
	        ci->flags &= ~CI_DROPPED;
		tm = localtime(&ci->drop_time);
	        strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);		    
		notice_lang(s_ChanServ, u, CHAN_DROP_CANCEL, buf);		
		log2c("%s: %s!%s@%s canceled drop for %s on identify", s_ChanServ,
			u->nick, u->username, u->host, ci->name);		
	    }
	} else if (res < 0) {
	    log1("%s: check_password failed for %s", s_ChanServ, ci->name);
	    notice_lang(s_ChanServ, u, CHAN_IDENTIFY_FAILED);
	} else {
	    log2c("%s: Failed IDENTIFY for %s by %s!%s@%s",
			s_ChanServ, ci->name, u->nick, u->username, u->host);
	    notice_lang(s_ChanServ, u, PASSWORD_INCORRECT);
	    bad_password(u);
	}

    }
}

/*************************************************************************/

static void do_drop(User *u)
{
    char *chan  = strtok(NULL, " ");
    char *extra = strtok(NULL, " ");
    ChannelInfo *ci;
    NickInfo *ni;
    int is_servadmin = is_services_admin(u);

    if (readonly && !is_servadmin) {
	notice_lang(s_ChanServ, u, CHAN_DROP_DISABLED);
	return;
    }
    if (!chan) {
	syntax_error(s_ChanServ, u, "DROP", CHAN_DROP_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (!is_servadmin & (ci->flags & CI_VERBOTEN)) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!is_servadmin && !is_identified(u, ci)) {
	notice_lang(s_ChanServ, u, CHAN_IDENTIFY_REQUIRED, s_ChanServ, chan);
    } else if (!is_servadmin && get_access(u, ci) < ACCESS_FOUNDER) {
	notice_lang(s_ChanServ, u, CHAN_IDENTIFY_REQUIRED, s_ChanServ, chan);	
    } else {
	if (readonly)  /* in this case we know they're a Services admin */
	    notice_lang(s_ChanServ, u, READ_ONLY_MODE);
	ni = ci->founder;
	if (ni) {   /* This might be NULL (i.e. after FORBID) */
	    if (ni->channelcount > 0)
		ni->channelcount--;
	    ni = getlink(ni);
	    if (ni != ci->founder && ni->channelcount > 0)
		ni->channelcount--;
	}
	if(CSDropDelay && !(is_servadmin && extra && !strcasecmp(extra,"NOW"))) {
	    log2c("%s: Channel %s drop request by %s!%s@%s", s_ChanServ, ci->name,
		u->nick, u->username, u->host);	    
	    ci->flags |= CI_DROPPED;
	    ci->drop_time = time(NULL);
	    notice_lang(s_ChanServ, u, CHAN_DROP_AT,CSDropDelay/86400);
	} else
	{
	    log2c("%s: Channel %s dropped by %s!%s@%s", s_ChanServ, ci->name,
			u->nick, u->username, u->host);
	    DayStats.cs_dropped++;		
	    DayStats.cs_total--;	
	    delchan(ci);
	    send_cmd(s_ChanServ, "MODE %s -r", chan);
	    notice_lang(s_ChanServ, u, CHAN_DROPPED, chan);
	}
    }
}

/*************************************************************************/

/* Main SET routine.  Calls other routines as follows:
 *	do_set_command(User *command_sender, ChannelInfo *ci, char *param);
 * The parameter passed is the first space-delimited parameter after the
 * option name, except in the case of DESC, TOPIC, and ENTRYMSG, in which
 * it is the entire remainder of the line.  Additional parameters beyond
 * the first passed in the function call can be retrieved using
 * strtok(NULL, toks).
 */
static void do_set(User *u)
{
    char *chan = strtok(NULL, " ");
    char *cmd  = strtok(NULL, " ");
    char *param;
    ChannelInfo *ci;
    int is_servadmin = is_services_admin(u);

    if (readonly) {
	notice_lang(s_ChanServ, u, CHAN_SET_DISABLED);
	return;
    }

    if (cmd) {
	if (strcasecmp(cmd, "DESC") == 0 || strcasecmp(cmd, "TOPIC") == 0
	 || strcasecmp(cmd, "ENTRYMSG") == 0)
	    param = strtok(NULL, "");
	else
	    param = strtok(NULL, " ");
    } else {
	param = NULL;
    }

    if (!param && (!cmd || (strcasecmp(cmd, "SUCCESSOR") != 0 &&
                            strcasecmp(cmd, "URL") != 0 &&
                            strcasecmp(cmd, "EMAIL") != 0 &&
                            strcasecmp(cmd, "ENTRYMSG") != 0))) {
	syntax_error(s_ChanServ, u, "SET", CHAN_SET_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!is_servadmin && !check_access(u, ci, CA_SET)) {
	notice_lang(s_ChanServ, u, ACCESS_DENIED);
    } else if (strcasecmp(cmd, "FOUNDER") == 0) {
	if (!is_servadmin && get_access(u, ci) < ACCESS_FOUNDER) {
	    notice_lang(s_ChanServ, u, CHAN_IDENTIFY_REQUIRED, s_ChanServ,chan);
	} else {
	    do_set_founder(u, ci, param);
	}
    } else if (strcasecmp(cmd, "SUCCESSOR") == 0) {
	if (!is_servadmin && get_access(u, ci) < ACCESS_FOUNDER) {
	    notice_lang(s_ChanServ, u, CHAN_IDENTIFY_REQUIRED, s_ChanServ,chan);
	} else { 	
	    do_set_successor(u, ci, param);
	}
    } else if (strcasecmp(cmd, "PASSWORD") == 0) {
	if (!is_servadmin && !is_identified(u, ci)) {
	    notice_lang(s_ChanServ, u, CHAN_IDENTIFY_REQUIRED, s_ChanServ,chan);
	} else {
	    do_set_password(u, ci, param);
	}
    } else if (strcasecmp(cmd, "DESC") == 0) {
	do_set_desc(u, ci, param);
    } else if (strcasecmp(cmd, "URL") == 0) {
	do_set_url(u, ci, param);
    } else if (strcasecmp(cmd, "EMAIL") == 0) {
	do_set_email(u, ci, param);
    } else if (strcasecmp(cmd, "ENTRYMSG") == 0) {
	do_set_entrymsg(u, ci, param);
    } else if (strcasecmp(cmd, "TOPIC") == 0) {
	do_set_topic(u, ci, param);
    } else if (strcasecmp(cmd, "MLOCK") == 0) {
	do_set_mlock(u, ci, param);
    } else if (strcasecmp(cmd, "KEEPTOPIC") == 0) {
	do_set_keeptopic(u, ci, param);
    } else if (strcasecmp(cmd, "TOPICLOCK") == 0) {
	do_set_topiclock(u, ci, param);
    } else if (strcasecmp(cmd, "PRIVATE") == 0) {
	do_set_private(u, ci, param);
    } else if (strcasecmp(cmd, "SECUREOPS") == 0) {
	do_set_secureops(u, ci, param);	
    } else if (strcasecmp(cmd, "LEAVEOPS") == 0) {
	do_set_leaveops(u, ci, param);
    } else if (strcasecmp(cmd, "RESTRICTED") == 0) {
	do_set_restricted(u, ci, param);
    } else if (strcasecmp(cmd, "OPNOTICE") == 0) {
	do_set_opnotice(u, ci, param);
    } else if (strcasecmp(cmd, "NOLINKS") == 0) {
	do_set_nolinks(u, ci, param);
    } else if (strcasecmp(cmd, "TOPICENTRY") == 0) {
	do_set_topicentry(u, ci, param);
    } else if (strcasecmp(cmd, "NOEXPIRE") == 0) {
	do_set_noexpire(u, ci, param);
    } else {
	notice_lang(s_ChanServ, u, CHAN_SET_UNKNOWN_OPTION, strupper(cmd));
	notice_lang(s_ChanServ, u, MORE_INFO, s_ChanServ, "SET");
    }
}

/*************************************************************************/

static void do_set_founder(User *u, ChannelInfo *ci, char *param)
{
    NickInfo *ni = findnick(param), *ni0 = ci->founder;

    if (!ni) 
	  {
		notice_lang(s_ChanServ, u, NICK_X_NOT_REGISTERED, param);
		return;
  	  }
	  
    if (ni->status & NS_VERBOTEN) 
	  {
        notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, param);	
        return;
  	  }
	  
    if (ni->channelcount >= ni->channelmax && !is_services_admin(u)) 
	  {
		notice_lang(s_ChanServ, u, CHAN_SET_FOUNDER_TOO_MANY_CHANS, param);
		return;
  	  }
	  
	if (ni == ci->successor) {
		ci->successor = NULL;	
    } 
	   	    
    if (ni0->channelcount > 0)  /* Let's be paranoid... */
	  ni0->channelcount--;
	  
    ni0 = getlink(ni0);
    if (ni0 != ci->founder && ni0->channelcount > 0)
	ni0->channelcount--;
    ci->founder = ni;
    if (ni->channelcount+1 > ni->channelcount)
	ni->channelcount++;
    ni = getlink(ni);
    if (ni != ci->founder && ni->channelcount+1 > ni->channelcount)
	ni->channelcount++;
    log2c("%s: Changing founder of %s from %s to %s by %s!%s@%s", s_ChanServ,
		ci->name, ni0->nick, param, u->nick, u->username, u->host);
    notice_lang(s_ChanServ, u, CHAN_FOUNDER_CHANGED, ci->name, param);
}

/*************************************************************************/

static void do_set_successor(User *u, ChannelInfo *ci, char *param)
{
    NickInfo *ni;

    if (param) {
	ni = findnick(param);
	if (!ni) {
	    notice_lang(s_ChanServ, u, NICK_X_NOT_REGISTERED, param);
	    return;
	} 
	if (ni->status & NS_VERBOTEN) {
	    notice_lang(s_ChanServ, u, NICK_X_FORBIDDEN, param);	
	    return;
	} 
	if (ni == ci->founder) {
	    notice_lang(s_ChanServ, u, NICK_X_ISFOUNDER, param);	
	    return;
	}
    } else {
	ni = NULL;
    }
    ci->successor = ni;
    if (ni)
	notice_lang(s_ChanServ, u, CHAN_SUCCESSOR_CHANGED, ci->name, param);
    else
	notice_lang(s_ChanServ, u, CHAN_SUCCESSOR_UNSET, ci->name);
}

/*************************************************************************/

static void do_set_password(User *u, ChannelInfo *ci, char *param)
{
    int len = strlen(param);
    if (len > PASSMAX-1) {
	len = PASSMAX-1;
	param[len] = 0;
	notice_lang(s_ChanServ, u, PASSWORD_TRUNCATED, PASSMAX-1);
    }
    if (encrypt(param, len, ci->founderpass, PASSMAX) < 0) {
	memset(param, 0, strlen(param));
	log2c("%s: Failed to encrypt password for %s (set)",
		s_ChanServ, ci->name);
	notice_lang(s_ChanServ, u, CHAN_SET_PASSWORD_FAILED);
	return;
    }
    ci->crypt_method = EncryptMethod;
    notice_lang(s_ChanServ, u, CHAN_PASSWORD_CHANGED_TO,
		ci->name, param);        
    memset(param, 0, strlen(param));
    if (get_access(u, ci) < ACCESS_FOUNDER) {
	log1("%s: %s!%s@%s set password as Services admin for %s",
		s_ChanServ, u->nick, u->username, u->host, ci->name);
	sanotice(s_ChanServ,"%s!%s@%s used SET PASSWORD as Services admin on %s",
		 u->nick, u->username, u->host, ci->name);
	if (WallSetpass)
	    wallops(s_ChanServ, "\2%s\2 set password as Services admin for "
				"channel \2%s\2", u->nick, ci->name);
    } else log2c("%s: %s!%s@%s changed password for %s",s_ChanServ,
		u->nick, u->username, u->host, ci->name);
}

/*************************************************************************/

static void do_set_desc(User *u, ChannelInfo *ci, char *param)
{
    if (ci->desc)
	free(ci->desc);
    ci->desc = sstrdup(param);
    notice_lang(s_ChanServ, u, CHAN_DESC_CHANGED, ci->name, param);
}

/*************************************************************************/

static void do_set_url(User *u, ChannelInfo *ci, char *param)
{
    if (ci->url)
	free(ci->url);
    if (param) {
	ci->url = sstrdup(param);
	notice_lang(s_ChanServ, u, CHAN_URL_CHANGED, ci->name, param);
    } else {
	ci->url = NULL;
	notice_lang(s_ChanServ, u, CHAN_URL_UNSET, ci->name);
    }
}

/*************************************************************************/

static void do_set_email(User *u, ChannelInfo *ci, char *param)
{
    if (ci->email)
	free(ci->email);
    if (param) {
	ci->email = sstrdup(param);
	notice_lang(s_ChanServ, u, CHAN_EMAIL_CHANGED, ci->name, param);
    } else {
	ci->email = NULL;
	notice_lang(s_ChanServ, u, CHAN_EMAIL_UNSET, ci->name);
    }
}

/*************************************************************************/

static void do_set_entrymsg(User *u, ChannelInfo *ci, char *param)
{
    if (ci->entry_message)
	free(ci->entry_message);
    if (param) {
	ci->entry_message = sstrdup(param);
	notice_lang(s_ChanServ, u, CHAN_ENTRY_MSG_CHANGED, ci->name, param);
    } else {
	ci->entry_message = NULL;
	notice_lang(s_ChanServ, u, CHAN_ENTRY_MSG_UNSET, ci->name);
    }
}

/*************************************************************************/

static void do_set_topic(User *u, ChannelInfo *ci, char *param)
{
    Channel *c = ci->c;

    if (!c) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, ci->name);
	return;
    }
    if (ci->last_topic)
	free(ci->last_topic);
    if (*param)
	ci->last_topic = sstrdup(param);
    else
	ci->last_topic = NULL;
    if (c->topic) {
	free(c->topic);
	c->topic_time--;	/* to get around TS8 */
    } else
	c->topic_time = time(NULL);
    if (*param)
	c->topic = sstrdup(param);
    else
	c->topic = NULL;
    strscpy(ci->last_topic_setter, u->nick, NICKMAX);
    strscpy(c->topic_setter, u->nick, NICKMAX);
    ci->last_topic_time = c->topic_time;
    send_cmd(s_ChanServ, "TOPIC %s %s %lu :%s",
		ci->name, u->nick, (unsigned long int) c->topic_time, param);
}

/*************************************************************************/

static void do_set_mlock(User *u, ChannelInfo *ci, char *param)
{
    char *s, modebuf[32], *end, c;
    int add = -1;	/* 1 if adding, 0 if deleting, -1 if neither */
    int newlock_on = 0, newlock_off = 0, newlock_limit = 0;
    char *newlock_key = NULL;

    while (*param) {
	if (*param != '+' && *param != '-' && add < 0) {
	    param++;
	    continue;
	}
	switch (c = *param++) {
	  case '+':
	    add = 1;
	    break;
	  case '-':
	    add = 0;
	    break;
	  case 'B':
	    if(add) {
		newlock_on |= CMODE_B;
		newlock_off &= ~CMODE_B;
	    } else {
		newlock_off |= CMODE_B;
		newlock_on &= ~CMODE_B;
	    }
	    break;    
	  case 'R':
	    if (add) {
		newlock_on |= CMODE_R;
		newlock_off &= ~CMODE_R;
	    } else {
		newlock_off |= CMODE_R;
		newlock_on &= ~CMODE_R;
	    }
	    break;	    
	  case 'i':
	    if (add) {
		newlock_on |= CMODE_I;
		newlock_off &= ~CMODE_I;
	    } else {
		newlock_off |= CMODE_I;
		newlock_on &= ~CMODE_I;
	    }
	    break;
	  case 'k':
	    if (add) {
		if (!(s = strtok(NULL, " "))) {
		    notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_KEY_REQUIRED);
		    return;
		}
		if (newlock_key)
		    free(newlock_key);
		newlock_key = sstrdup(s);
		newlock_off &= ~CMODE_k;
	    } else {
		if (newlock_key) {
		    free(newlock_key);
		    newlock_key = NULL;
		}
		newlock_off |= CMODE_k;
	    }
	    break;
	  case 'l':
	    if (add) {
		if (!(s = strtok(NULL, " "))) {
		    notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_LIMIT_REQUIRED);
		    return;
		}
		if (atol(s) <= 0) {
		    notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_LIMIT_POSITIVE);
		    return;
		}
		newlock_limit = atol(s);
		newlock_off &= ~CMODE_l;
	    } else {
		newlock_limit = 0;
		newlock_off |= CMODE_l;
	    }
	    break;
	  case 'm':
	    if (add) {
		newlock_on |= CMODE_M;
		newlock_off &= ~CMODE_M;
	    } else {
		newlock_off |= CMODE_M;
		newlock_on &= ~CMODE_M;
	    }
	    break;
	  case 'S':
	    if (add) {
		newlock_on |= CMODE_S;
		newlock_off &= ~CMODE_S;
	    } else {
		newlock_off |= CMODE_S;
		newlock_on &= ~CMODE_S;
	    }
	    break;
	  case 'd':
	    if (add) {
		newlock_on |= CMODE_d;
		newlock_off &= ~CMODE_d;
	    } else {
		newlock_off |= CMODE_d;
		newlock_on &= ~CMODE_d;
	    }
	    break;		

	  case 'q':
	    if (add) {
		newlock_on |= CMODE_q;
		newlock_off &= ~CMODE_q;
	    } else {
		newlock_off |= CMODE_q;
		newlock_on &= ~CMODE_q;
	    }
	    break;	    	    

	  case 'n':
	    if (add) {
		newlock_on |= CMODE_n;
		newlock_off &= ~CMODE_n;
	    } else {
		newlock_off |= CMODE_n;
		newlock_on &= ~CMODE_n;
	    }
	    break;
	  case 'p':
	    if (add) {
		newlock_on |= CMODE_P;
		newlock_off &= ~CMODE_P;
	    } else {
		newlock_off |= CMODE_P;
		newlock_on &= ~CMODE_P;
	    }
	    break;
	  case 's':
	    if (add) {
		newlock_on |= CMODE_s;
		newlock_off &= ~CMODE_s;
	    } else {
		newlock_off |= CMODE_s;
		newlock_on &= ~CMODE_s;
	    }
	    break;
	  case 't':
	    if (add) {
		newlock_on |= CMODE_T;
		newlock_off &= ~CMODE_T;
	    } else {
		newlock_off |= CMODE_T;
		newlock_on &= ~CMODE_T;
	    }
	    break;
	  case 'c':
	    if (add) {
		newlock_on |= CMODE_c;
		newlock_off &= ~CMODE_c;
	    } else {
		newlock_off |= CMODE_c;
		newlock_on &= ~CMODE_c;
	    }
	    break;
	  case 'f':
	    if(add) {
		notice_lang(s_ChanServ, u, CHAN_BAD_F_MODE);
		return;
	    }
	    break;
	   case 'K':
	    if (add) {
		newlock_on |= CMODE_K;
		newlock_off &= ~CMODE_K;
	    } else {
		newlock_off |= CMODE_K;
		newlock_on &= ~CMODE_K;
	    }
	    break;
		
	  case 'O':
	    if(is_services_oper(u)) {	
		if (add) {
	    	    newlock_on |= CMODE_O;
		    newlock_off &= ~CMODE_O;
		} else {
		    newlock_off |= CMODE_O;
		    newlock_on &= ~CMODE_O;
		}
	    } else {
		notice_lang(s_ChanServ, u, CHAN_BAD_MLOCKMODE1);
		return;
	    }
	    break;
	  case 'A':
	    if(is_services_admin(u)) {
		if (add) {
	    	    newlock_on |= CMODE_A;
		    newlock_off &= ~CMODE_A;
		} else {
		    newlock_off |= CMODE_A;
		    newlock_on &= ~CMODE_A;
		}
	    } else {
		notice_lang(s_ChanServ, u, CHAN_BAD_MLOCKMODE2);
		return;
	    }
	    break;
	    case 'N':
		if(add) {
	            newlock_on |= CMODE_N;
		    newlock_off &= ~CMODE_N;
	        } else {
	            newlock_off |= CMODE_N;
	            newlock_on &= ~CMODE_N;
	        }		    
		break;
	    case 'C':
		if(add)	{
		    newlock_on |= CMODE_C;
		    newlock_off &= ~CMODE_C;
		} else {
		    newlock_off |= CMODE_C;
		    newlock_on &= ~CMODE_C;
		}
		break;
	  
	  default:
	    notice_lang(s_ChanServ, u, CHAN_SET_MLOCK_UNKNOWN_CHAR, c);
	    break;
	} /* switch */
    } /* while (*param) */

    /* Now that everything's okay, actually set the new mode lock. */
    ci->mlock_on = newlock_on;
    ci->mlock_off = newlock_off;
    ci->mlock_limit = newlock_limit;
    if (ci->mlock_key)
	free(ci->mlock_key);
    ci->mlock_key = newlock_key;

    /* Tell the user about it. */
    end = modebuf;
    *end = 0;
    if (ci->mlock_on)
	end += snprintf(end, sizeof(modebuf)-(end-modebuf), "+%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
				(ci->mlock_on & CMODE_I) ? "i" : "",
				(ci->mlock_key         ) ? "k" : "",
				(ci->mlock_limit       ) ? "l" : "",
				(ci->mlock_on & CMODE_M) ? "m" : "",
				(ci->mlock_on & CMODE_n) ? "n" : "",
				(ci->mlock_on & CMODE_P) ? "p" : "",
				(ci->mlock_on & CMODE_s) ? "s" : "",
				(ci->mlock_on & CMODE_T) ? "t" : "",
				(ci->mlock_on & CMODE_c) ? "c" : "",
				(ci->mlock_on & CMODE_d) ? "d" : "",				
				(ci->mlock_on & CMODE_q) ? "q" : "",								
				(ci->mlock_on & CMODE_S) ? "S" : "",				
				(ci->mlock_on & CMODE_R) ? "R" : "",
				(ci->mlock_on & CMODE_B) ? "B" : "",				
				(ci->mlock_on & CMODE_K) ? "K" : "",
				(ci->mlock_on & CMODE_O) ? "O" : "",
				(ci->mlock_on & CMODE_A) ? "A" : "",
				(ci->mlock_on & CMODE_N) ? "N" : "",
				(ci->mlock_on & CMODE_C) ? "C" : "");
    if (ci->mlock_off)
	end += snprintf(end, sizeof(modebuf)-(end-modebuf), "-%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
				(ci->mlock_off & CMODE_I) ? "i" : "",
				(ci->mlock_off & CMODE_k) ? "k" : "",
				(ci->mlock_off & CMODE_l) ? "l" : "",
				(ci->mlock_off & CMODE_M) ? "m" : "",
				(ci->mlock_off & CMODE_n) ? "n" : "",
				(ci->mlock_off & CMODE_P) ? "p" : "",
				(ci->mlock_off & CMODE_s) ? "s" : "",
				(ci->mlock_off & CMODE_T) ? "t" : "",
				(ci->mlock_off & CMODE_c) ? "c" : "",
				(ci->mlock_off & CMODE_d) ? "d" : "",				
				(ci->mlock_off & CMODE_q) ? "q" : "",								
				(ci->mlock_off & CMODE_S) ? "S" : "",								
				(ci->mlock_off & CMODE_R) ? "R" : "",								
				(ci->mlock_off & CMODE_B) ? "B" : "",
				(ci->mlock_off & CMODE_K) ? "K" : "",
				(ci->mlock_off & CMODE_O) ? "O" : "",
				(ci->mlock_off & CMODE_A) ? "A" : "",
				(ci->mlock_off & CMODE_N) ? "N" : "",
				(ci->mlock_off & CMODE_C) ? "C" : "");
				
    if (*modebuf) {
	notice_lang(s_ChanServ, u, CHAN_MLOCK_CHANGED, ci->name, modebuf);
    } else {
	notice_lang(s_ChanServ, u, CHAN_MLOCK_REMOVED, ci->name);
    }

    /* Implement the new lock. */
    check_modes(ci->name, 0);
}

/*************************************************************************/

static void do_set_keeptopic(User *u, ChannelInfo *ci, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_KEEPTOPIC;
	notice_lang(s_ChanServ, u, CHAN_SET_KEEPTOPIC_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_KEEPTOPIC;
	notice_lang(s_ChanServ, u, CHAN_SET_KEEPTOPIC_OFF);
    } else {
	syntax_error(s_ChanServ, u, "SET KEEPTOPIC", CHAN_SET_KEEPTOPIC_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_topiclock(User *u, ChannelInfo *ci, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_TOPICLOCK;
	notice_lang(s_ChanServ, u, CHAN_SET_TOPICLOCK_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_TOPICLOCK;
	notice_lang(s_ChanServ, u, CHAN_SET_TOPICLOCK_OFF);
    } else {
	syntax_error(s_ChanServ, u, "SET TOPICLOCK", CHAN_SET_TOPICLOCK_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_private(User *u, ChannelInfo *ci, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_PRIVATE;
	notice_lang(s_ChanServ, u, CHAN_SET_PRIVATE_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_PRIVATE;
	notice_lang(s_ChanServ, u, CHAN_SET_PRIVATE_OFF);
    } else {
	syntax_error(s_ChanServ, u, "SET PRIVATE", CHAN_SET_PRIVATE_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_secureops(User *u, ChannelInfo *ci, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_SECUREOPS;
	notice_lang(s_ChanServ, u, CHAN_SET_SECUREOPS_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_SECUREOPS;
	notice_lang(s_ChanServ, u, CHAN_SET_SECUREOPS_OFF);
    } else {
	syntax_error(s_ChanServ, u, "SET SECUREOPS", CHAN_SET_SECUREOPS_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_leaveops(User *u, ChannelInfo *ci, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_LEAVEOPS;
	notice_lang(s_ChanServ, u, CHAN_SET_LEAVEOPS_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_LEAVEOPS;
	notice_lang(s_ChanServ, u, CHAN_SET_LEAVEOPS_OFF);
    } else {
	syntax_error(s_ChanServ, u, "SET LEAVEOPS", CHAN_SET_LEAVEOPS_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_restricted(User *u, ChannelInfo *ci, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_RESTRICTED;
	if (ci->levels[CA_NOJOIN] < 0)
	    ci->levels[CA_NOJOIN] = 0;
	notice_lang(s_ChanServ, u, CHAN_SET_RESTRICTED_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_RESTRICTED;
	if (ci->levels[CA_NOJOIN] >= 0)
	    ci->levels[CA_NOJOIN] = -1;
	notice_lang(s_ChanServ, u, CHAN_SET_RESTRICTED_OFF);
    } else {
	syntax_error(s_ChanServ,u,"SET RESTRICTED",CHAN_SET_RESTRICTED_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_opnotice(User *u, ChannelInfo *ci, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_OPNOTICE;
	notice_lang(s_ChanServ, u, CHAN_SET_OPNOTICE_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_OPNOTICE;
	notice_lang(s_ChanServ, u, CHAN_SET_OPNOTICE_OFF);
    } else {
	syntax_error(s_ChanServ, u, "SET OPNOTICE", CHAN_SET_OPNOTICE_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_nolinks(User *u, ChannelInfo *ci, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_NOLINKS;
	notice_lang(s_ChanServ, u, CHAN_SET_NOLINKS_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_NOLINKS;
	notice_lang(s_ChanServ, u, CHAN_SET_NOLINKS_OFF);
    } else {
	syntax_error(s_ChanServ, u, "SET NOLINKS", CHAN_SET_NOLINKS_SYNTAX);
    }
}

static void do_set_topicentry(User *u, ChannelInfo *ci, char *param)
{
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_TOPICENTRY;
	notice_lang(s_ChanServ, u, CHAN_SET_TOPICENTRY_ON);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_TOPICENTRY;
	notice_lang(s_ChanServ, u, CHAN_SET_TOPICENTRY_OFF);
    } else {
	syntax_error(s_ChanServ, u, "SET TOPICENTRY", CHAN_SET_TOPICENTRY_SYNTAX);
    }
}

/*************************************************************************/

static void do_set_noexpire(User *u, ChannelInfo *ci, char *param)
{
    if (!is_services_admin(u)) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	return;
    }
    if (strcasecmp(param, "ON") == 0) {
	ci->flags |= CI_NO_EXPIRE;
	notice_lang(s_ChanServ, u, CHAN_SET_NOEXPIRE_ON, ci->name);
    } else if (strcasecmp(param, "OFF") == 0) {
	ci->flags &= ~CI_NO_EXPIRE;
	notice_lang(s_ChanServ, u, CHAN_SET_NOEXPIRE_OFF, ci->name);
    } else {
	syntax_error(s_ChanServ, u, "SET NOEXPIRE", CHAN_SET_NOEXPIRE_SYNTAX);
    }
}

/*************************************************************************/

/* `last' is set to the last index this routine was called with
 * `perm' is incremented whenever a permission-denied error occurs
 */
static int access_del(User *u, ChanAccess *access, int *perm, int uacc)
{
    if (!access->in_use)
	return 0;
    if (uacc <= access->level) {
	(*perm)++;
	return 0;
    }
    access->ni = NULL;
    access->in_use = 0;
    access->who = u->ni;
    return 1;
}

static int access_del_callback(User *u, int num, va_list args)
{
    ChannelInfo *ci = va_arg(args, ChannelInfo *);
    int *last = va_arg(args, int *);
    int *perm = va_arg(args, int *);
    int uacc = va_arg(args, int);
    if (num < 1 || num > ci->accesscount)
	return 0;
    *last = num;
    return access_del(u, &ci->access[num-1], perm, uacc);
}


static int access_list(User *u, int index, ChannelInfo *ci, int *sent_header)
{
    ChanAccess *access = &ci->access[index];
    NickInfo *ni;
    char *s;

    if (!access->in_use)
	return 0;
    if (!*sent_header) {
	notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_HEADER, ci->name);
	*sent_header = 1;
    }
    if ((ni = findnick(access->ni->nick))
			&& is_services_oper(u))
	s = ni->last_usermask;
    else
	s = NULL;
    if(access->who)
	notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_FORMAT2,
		index+1, access->level, access->ni->nick,
		s ? " (" : "", s ? s : "", s ? ")" : "",
		access->who->nick);
    else
        notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_FORMAT,
		index+1, access->level, access->ni->nick,
		s ? " (" : "", s ? s : "", s ? ")" : "");		
    return 1;
}

static int access_list_callback(User *u, int num, va_list args)
{
    ChannelInfo *ci = va_arg(args, ChannelInfo *);
    int *sent_header = va_arg(args, int *);
    if (num < 1 || num > ci->accesscount)
	return 0;
    return access_list(u, num-1, ci, sent_header);
}


static void do_access(User *u)
{
    char *chan = strtok(NULL, " ");
    char *cmd  = strtok(NULL, " ");
    char *nick = strtok(NULL, " ");
    char *s    = strtok(NULL, " ");
    ChannelInfo *ci;
    NickInfo *ni;
    short level = 0, ulev;
    int i;
    int is_list = (cmd && strcasecmp(cmd, "LIST") == 0);
    ChanAccess *access;

    /* If LIST, we don't *require* any parameters, but we can take any.
     * If DEL, we require a nick and no level.
     * Else (ADD), we require a level (which implies a nick). */
    if (!cmd || (is_list ? 0 :
			(strcasecmp(cmd,"DEL")==0) ? (!nick || s) : !s)) {
	syntax_error(s_ChanServ, u, "ACCESS", CHAN_ACCESS_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (((is_list && !check_access(u, ci, CA_ACCESS_LIST))
                || (!is_list && !check_access(u, ci, CA_ACCESS_CHANGE)))
               && !is_services_admin(u))
    {
	notice_lang(s_ChanServ, u, ACCESS_DENIED);

    } else if (strcasecmp(cmd, "ADD") == 0) {

	if (readonly) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_DISABLED);
	    return;
	}

	level = atoi(s);
	ulev = get_access(u, ci);
	if (level >= ulev) {
	    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    return;
	}
	if (level == 0) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_NONZERO);
	    return;
	} else if (level < CHAN_LEVEL_MIN || level > CHAN_LEVEL_MAX) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_RANGE,
			ACCESS_INVALID+1, ACCESS_FOUNDER-1);
	    return;
	}
	ni = findnick(nick);
	if (!ni) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_NICKS_ONLY);
	    return;
	}
	for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
	    if (access->ni == ni) {
		/* Don't allow lowering from a level >= ulev */
		if (access->level >= ulev) {
		    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
		    return;
		}
		if (access->level == level) {
		    notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_UNCHANGED,
			access->ni->nick, chan, level);
		    return;
		}        
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_CHANGED,
			access->ni->nick, chan, access->level, level);
		access->level = level;			
        	access->who = u->real_ni;
		return;
	    }
	}
	for (i = 0; i < ci->accesscount; i++) {
	    if (!ci->access[i].in_use)
		break;
	}
	if (i == ci->accesscount) {
	    if (i < CSAccessMax) {
		ci->accesscount++;
		ci->access =
		    srealloc(ci->access, sizeof(ChanAccess) * ci->accesscount);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_REACHED_LIMIT,
			CSAccessMax);
		return;
	    }
	}
	access = &ci->access[i];
	access->ni = ni;
	access->in_use = 1;
	access->level = level;
	access->who = u->real_ni;
	notice_lang(s_ChanServ, u, CHAN_ACCESS_ADDED,
		access->ni->nick, chan, level);

    } else if (strcasecmp(cmd, "DEL") == 0) {

	if (readonly) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_DISABLED);
	    return;
	}
	if (!strcasecmp(nick,"ALL")) {
	    if (!is_services_admin(u) && get_access(u, ci) < ACCESS_FOUNDER) 
		notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    else {
		for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
		    access->in_use = 0;		
		    access->ni = NULL;
		    access->who = u->ni;
		}
		notice_lang(s_ChanServ, u, CHAN_ACCESS_CLEARALL);
	    }
	    return;
	}
	/* Special case: is it a number/list?  Only do search if it isn't. */
	if (isdigit(*nick) && strspn(nick, "1234567890,-") == strlen(nick)) {
	    int count, deleted, last = -1, perm = 0;
	    deleted = process_numlist(nick, &count, access_del_callback, u,
					ci, &last, &perm, get_access(u, ci));
	    if (!deleted) {
		if (perm) {
		    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
		} else if (count == 1) {
		    notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_SUCH_ENTRY,
				last, ci->name);
		} else {
		    notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_MATCH, ci->name);
		}
	    } else if (deleted == 1) {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DELETED_ONE, ci->name);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DELETED_SEVERAL,
				deleted, ci->name);
	    }
	} else {
	    ni = findnick(nick);
	    if (!ni) {
		notice_lang(s_ChanServ, u, NICK_X_NOT_REGISTERED, nick);
		return;
	    }
	    for (i = 0; i < ci->accesscount; i++) {
		if (ci->access[i].ni == ni)
		    break;
	    }
	    if (i == ci->accesscount) {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_NOT_FOUND, nick, chan);
		return;
	    }
	    access = &ci->access[i];
	    if ((get_access(u, ci) <= access->level) 
	      && (u->real_ni != access->ni)) {
		notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DELETED,
				access->ni->nick, ci->name);
		access->ni = NULL;
		access->in_use = 0;
		access->who = u->ni;
	    }
	}

    } else if (strcasecmp(cmd, "LIST") == 0) {
	int sent_header = 0;

	if (ci->accesscount == 0) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_EMPTY, chan);
	    return;
	}
	if (nick && strspn(nick, "1234567890,-") == strlen(nick)) {
	    process_numlist(nick, NULL, access_list_callback, u, ci,
								&sent_header);
	} else {
	    for (i = 0; i < ci->accesscount; i++) {
		if (nick && ci->access[i].ni
			 && !match_wild_nocase(nick, ci->access[i].ni->nick))
		    continue;
		access_list(u, i, ci, &sent_header);
	    }
	}
	if (!sent_header)
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_MATCH, chan);

    } else {
	syntax_error(s_ChanServ, u, "ACCESS", CHAN_ACCESS_SYNTAX);
    }
}


static void do_aop(User *u)
{
    char *chan = strtok(NULL, " ");
    char *cmd  = strtok(NULL, " ");
    char *nick = strtok(NULL, " ");
    ChannelInfo *ci;
    NickInfo *ni;
    short level = 0, ulev;
    int i;
    int is_list = (cmd && strcasecmp(cmd, "LIST") == 0);
    ChanAccess *access;

    /* If LIST, we don't *require* any parameters, but we can take any.
     * If DEL, we require a nick and no level.
     * Else (ADD), we require a level (which implies a nick). */
    if (!cmd || (is_list ? 0 : !nick)) {
	syntax_error(s_ChanServ, u, "ACCESS", CHAN_AOP_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (((is_list && !check_access(u, ci, CA_ACCESS_LIST))
                || (!is_list && !check_access(u, ci, CA_ACCESS_CHANGE)))
               && !is_services_admin(u))
    {
	notice_lang(s_ChanServ, u, ACCESS_DENIED);

    } else if (strcasecmp(cmd, "ADD") == 0) {
	
	if (readonly) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_DISABLED);
	    return;
	}

	level = ci->levels[CA_AUTOOP];
    
	ulev = get_access(u, ci);
	if (level >= ulev) {
	    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    return;
	}
	if (level == 0) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_NONZERO);
	    return;
	} else if (level <= ACCESS_INVALID || level >= ACCESS_FOUNDER) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_RANGE,
			ACCESS_INVALID+1, ACCESS_FOUNDER-1);
	    return;
	}
	ni = findnick(nick);
	if (!ni) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_NICKS_ONLY);
	    return;
	}
	for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
	    if (access->ni == ni) {
		/* Don't allow lowering from a level >= ulev */
		if (access->level >= ulev) {
		    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
		    return;
		}
		if (access->level == level) {
		    notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_UNCHANGED,
			access->ni->nick, chan, level);
		    return;
		}
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_CHANGED,
			access->ni->nick, chan, access->level, level);
        access->level = level;
		return;
	    }
	}
	for (i = 0; i < ci->accesscount; i++) {
	    if (!ci->access[i].in_use)
		break;
	}
	if (i == ci->accesscount) {
	    if (i < CSAccessMax) {
		ci->accesscount++;
		ci->access =
		    srealloc(ci->access, sizeof(ChanAccess) * ci->accesscount);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_REACHED_LIMIT,
			CSAccessMax);
		return;
	    }
	}
	access = &ci->access[i];
	access->ni = ni;
	access->in_use = 1;
	access->level = level;
	access->who = u->real_ni;
	notice_lang(s_ChanServ, u, CHAN_ACCESS_ADDED,
		access->ni->nick, chan, level);

    } else if (strcasecmp(cmd, "DEL") == 0) {

	if (readonly) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_DISABLED);
	    return;
	}
	if (!strcasecmp(nick,"ALL")) {
	    if (!is_services_admin(u) && get_access(u, ci) < ACCESS_FOUNDER) 
		notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    else {
		for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
		    access->in_use = 0;		
		    access->ni = NULL;
		    access->who = u->ni;
		}
		notice_lang(s_ChanServ, u, CHAN_ACCESS_CLEARALL);
	    }
	    return;
	}
	/* Special case: is it a number/list?  Only do search if it isn't. */
	if (isdigit(*nick) && strspn(nick, "1234567890,-") == strlen(nick)) {
	    int count, deleted, last = -1, perm = 0;
	    deleted = process_numlist(nick, &count, access_del_callback, u,
					ci, &last, &perm, get_access(u, ci));
	    if (!deleted) {
		if (perm) {
		    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
		} else if (count == 1) {
		    notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_SUCH_ENTRY,
				last, ci->name);
		} else {
		    notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_MATCH, ci->name);
		}
	    } else if (deleted == 1) {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DELETED_ONE, ci->name);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DELETED_SEVERAL,
				deleted, ci->name);
	    }
	} else {
	    ni = findnick(nick);
	    if (!ni) {
		notice_lang(s_ChanServ, u, NICK_X_NOT_REGISTERED, nick);
		return;
	    }
	    for (i = 0; i < ci->accesscount; i++) {
		if (ci->access[i].ni == ni)
		    break;
	    }
	    if (i == ci->accesscount) {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_NOT_FOUND, nick, chan);
		return;
	    }
	    access = &ci->access[i];
	    if (get_access(u, ci) <= access->level) {
		notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DELETED,
				access->ni->nick, ci->name);
		access->ni = NULL;
		access->in_use = 0;
		access->who = u->ni;
	    }
	}

    } else if (strcasecmp(cmd, "LIST") == 0) {
	int sent_header = 0;
    
	ulev = get_access(u, ci);
	level = ci->levels[CA_ACCESS_LIST];
	if (level >= ulev) 
      {
	    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    return;
	  }

	if (ci->accesscount == 0) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_EMPTY, chan);
	    return;
	}
    
	if (nick && strspn(nick, "1234567890,-") == strlen(nick)) {
	    process_numlist(nick, NULL, access_list_callback, u, ci,
								&sent_header);
	} else {
		int oplevel=ci->levels[CA_AUTOOP];
	    for (i = 0; i < ci->accesscount; i++) {
		if ((nick && ci->access[i].ni && !match_wild_nocase(nick, ci->access[i].ni->nick))
			 || ci->access[i].level<oplevel)
		    continue;
		access_list(u, i, ci, &sent_header);
	    }
	}
	if (!sent_header)
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_MATCH, chan);

    } else {
	syntax_error(s_ChanServ, u, "AOP", CHAN_AOP_SYNTAX);
    }
}

static void do_sop(User *u)
{
    char *chan = strtok(NULL, " ");
    char *cmd  = strtok(NULL, " ");
    char *nick = strtok(NULL, " ");
    ChannelInfo *ci;
    NickInfo *ni;
    short level = 0, ulev, soplevel;
    int i;
    int is_list = (cmd && strcasecmp(cmd, "LIST") == 0);
    ChanAccess *access;

    /* If LIST, we don't *require* any parameters, but we can take any.
     * If DEL, we require a nick and no level.
     * Else (ADD), we require a level (which implies a nick). */
    if (!cmd || (is_list ? 0 : !nick)) {
	syntax_error(s_ChanServ, u, "ACCESS", CHAN_SOP_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (((is_list && !check_access(u, ci, CA_ACCESS_LIST))
                || (!is_list && !is_founder(u, ci)))
               && !is_services_admin(u))
    {
	notice_lang(s_ChanServ, u, ACCESS_DENIED);

    } else if (strcasecmp(cmd, "ADD") == 0) {
	
	if (readonly) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_DISABLED);
	    return;
	}
	ulev = get_access(u, ci);
	level = ci->levels[CA_ACCESS_CHANGE];
	if (level >= ulev) {
	    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    return;
	}
	if (level == 0) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_NONZERO);
	    return;
	} else if (level <= ACCESS_INVALID || level >= ACCESS_FOUNDER) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_RANGE,
			ACCESS_INVALID+1, ACCESS_FOUNDER-1);
	    return;
	}
	ni = findnick(nick);
	if (!ni) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_NICKS_ONLY);
	    return;
	}
	for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
	    if (access->ni == ni) {
		/* Don't allow lowering from a level >= ulev */
		if (access->level >= ulev) {
		    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
		    return;
		}
		if (access->level == level) {
		    notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_UNCHANGED,
			access->ni->nick, chan, level);
		    return;
		}
		notice_lang(s_ChanServ, u, CHAN_ACCESS_LEVEL_CHANGED,
			access->ni->nick, chan, access->level, level);
		access->level = level;            
		return;
	    }
	}
	for (i = 0; i < ci->accesscount; i++) {
	    if (!ci->access[i].in_use)
		break;
	}
	if (i == ci->accesscount) {
	    if (i < CSAccessMax) {
		ci->accesscount++;
		ci->access =
		    srealloc(ci->access, sizeof(ChanAccess) * ci->accesscount);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_REACHED_LIMIT,
			CSAccessMax);
		return;
	    }
	}
	access = &ci->access[i];
	access->ni = ni;
	access->in_use = 1;
	access->level = level;
	access->who = u->real_ni;
	notice_lang(s_ChanServ, u, CHAN_ACCESS_ADDED,
		access->ni->nick, chan, level);

    } else if (strcasecmp(cmd, "DEL") == 0) {

	if (readonly) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_DISABLED);
	    return;
	}
        
	if (!strcasecmp(nick,"ALL")) {
	    if (!is_services_admin(u) && get_access(u, ci) < ACCESS_FOUNDER) 
		notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    else {
		for (access = ci->access, i = 0; i < ci->accesscount; access++, i++) {
		    access->in_use = 0;		
		    access->ni = NULL;
		    access->who = u->ni;
		}
		notice_lang(s_ChanServ, u, CHAN_ACCESS_CLEARALL);
	    }
	    return;
	}
	/* Special case: is it a number/list?  Only do search if it isn't. */
	if (isdigit(*nick) && strspn(nick, "1234567890,-") == strlen(nick)) {
	    int count, deleted, last = -1, perm = 0;
	    deleted = process_numlist(nick, &count, access_del_callback, u,
					ci, &last, &perm, get_access(u, ci));
	    if (!deleted) {
		if (perm) {
		    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
		} else if (count == 1) {
		    notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_SUCH_ENTRY,
				last, ci->name);
		} else {
		    notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_MATCH, ci->name);
		}
	    } else if (deleted == 1) {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DELETED_ONE, ci->name);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DELETED_SEVERAL,
				deleted, ci->name);
	    }
	} else {
	    ni = findnick(nick);
	    if (!ni) {
		notice_lang(s_ChanServ, u, NICK_X_NOT_REGISTERED, nick);
		return;
	    }
	    for (i = 0; i < ci->accesscount; i++) {
		if (ci->access[i].ni == ni)
		    break;
	    }
	    if (i == ci->accesscount) {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_NOT_FOUND, nick, chan);
		return;
	    }
	    access = &ci->access[i];
	    if (get_access(u, ci) <= access->level) {
		notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_ACCESS_DELETED,
				access->ni->nick, ci->name);
		access->ni = NULL;
		access->in_use = 0;
		access->who = u->ni;
	    }
	}

    } else if (strcasecmp(cmd, "LIST") == 0) {
	int sent_header = 0;

	ulev = get_access(u, ci);
	level = ci->levels[CA_ACCESS_LIST];
    
	if (level >= ulev) 
      {
	    notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    return;
	  }

	if (ci->accesscount == 0) {
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_LIST_EMPTY, chan);
	    return;
	}
	if (nick && strspn(nick, "1234567890,-") == strlen(nick)) {
	    process_numlist(nick, NULL, access_list_callback, u, ci,
								&sent_header);
	} else {
        soplevel = ci->levels[CA_ACCESS_CHANGE];
	    for (i = 0; i < ci->accesscount; i++) {
		if ((nick && ci->access[i].ni && !match_wild_nocase(nick, ci->access[i].ni->nick))
			 || ci->access[i].level<soplevel)
		    continue;
		access_list(u, i, ci, &sent_header);
	    }
	}
	if (!sent_header)
	    notice_lang(s_ChanServ, u, CHAN_ACCESS_NO_MATCH, chan);

    } else {
	  syntax_error(s_ChanServ, u, "SOP", CHAN_SOP_SYNTAX);
    }
}


static int akick_del_callback(User *u, int num, va_list args)
{
    ChannelInfo *ci = va_arg(args, ChannelInfo *);
    int *last = va_arg(args, int *);
    *last = num;
    if (num < 1 || num > ci->akickcount)
	return 0;
    return akick_del(&ci->akick[num-1]);
}


static int akick_list(User *u, int index, ChannelInfo *ci, int *sent_header)
{
    AutoKick *akick = &ci->akick[index];
    char buf[BUFSIZE], buf2[BUFSIZE];

    if (!akick->in_use)
	return 0;
    if (!*sent_header) {
	notice_lang(s_ChanServ, u, CHAN_AKICK_LIST_HEADER, ci->name);
	*sent_header = 1;
    }
    strscpy(buf, akick->mask, sizeof(buf));
    if (akick->reason)
	snprintf(buf2, sizeof(buf2), "%s", akick->reason);
    else
	*buf2 = 0;
    if(!akick->who)
	notice_lang(s_ChanServ, u, CHAN_AKICK_LIST_FORMAT, index+1, buf, buf2);
    else
	notice_lang(s_ChanServ, u, CHAN_AKICK_LIST_FORMAT2, index+1, buf, akick->who->nick,
	    buf2);
    return 1;
}

static int akick_list_callback(User *u, int num, va_list args)
{
    ChannelInfo *ci = va_arg(args, ChannelInfo *);
    int *sent_header = va_arg(args, int *);
    if (num < 1 || num > ci->akickcount)
	return 0;
    return akick_list(u, num-1, ci, sent_header);
}


static void do_akick(User *u)
{
    char *chan   = strtok(NULL, " ");
    char *cmd    = strtok(NULL, " ");
    char *mask   = strtok(NULL, " ");
    char *reason = strtok(NULL, "");
    ChannelInfo *ci;
    int i;
    AutoKick *akick;
    char *mask2=NULL;
    if (!cmd || (strcasecmp(cmd, "LIST") != 0 && !mask)) {
	syntax_error(s_ChanServ, u, "AKICK", CHAN_AKICK_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!check_access(u, ci, CA_AKICK) && !is_services_admin(u)) {
	if (ci->founder && getlink(ci->founder) == u->ni)
	    notice_lang(s_ChanServ, u, CHAN_IDENTIFY_REQUIRED, s_ChanServ,chan);
	else
	    notice_lang(s_ChanServ, u, ACCESS_DENIED);

    } else if (strcasecmp(cmd, "ADD") == 0) {

	char *nick, *user, *host;
	(void)collapse(mask);
	if (readonly) {
	    notice_lang(s_ChanServ, u, CHAN_AKICK_DISABLED);
	    return;
	}
	if(!strchr(mask,'@')) {
		mask2=smalloc(strlen(mask)+5);
		sprintf(mask2,"%s!*@*",mask);
		mask=mask2;
		mask2=NULL;
	} else {
	split_usermask(mask, &nick, &user, &host);
	mask = smalloc(strlen(nick)+strlen(user)+strlen(host)+3);
	sprintf(mask, "%s!%s@%s", nick, user, host);
	    free(nick);
	    free(user);
	    free(host);
	}
	for (akick = ci->akick, i = 0; i < ci->akickcount; akick++, i++) {
	    if (!akick->in_use)
		continue;
	    if (strcasecmp(akick->mask,mask) == 0) {
		notice_lang(s_ChanServ, u, CHAN_AKICK_ALREADY_EXISTS,
			akick->mask, chan);
		return;
	    }
	}

	for (i = 0; i < ci->akickcount; i++) {
	    if (!ci->akick[i].in_use)
		break;
	}
	if (i == ci->akickcount) {
	    if (ci->akickcount >= CSAutokickMax) {
		notice_lang(s_ChanServ, u, CHAN_AKICK_REACHED_LIMIT,
			CSAutokickMax);
		return;
	    }
	    ci->akickcount++;
	    ci->akick = srealloc(ci->akick, sizeof(AutoKick) * ci->akickcount);
	}
	akick = &ci->akick[i];
	akick->in_use = 1;
	akick->mask = mask;
	if (reason)
	    akick->reason = sstrdup(reason);
	else
	    akick->reason = NULL;
	notice_lang(s_ChanServ, u, CHAN_AKICK_ADDED, mask, chan);
	akick->who = u->real_ni;
	akick->last_kick = time(NULL);
    } else if (strcasecmp(cmd, "DEL") == 0) {
	if (readonly) {
	    notice_lang(s_ChanServ, u, CHAN_AKICK_DISABLED);
	    return;
	}

	if (!strcasecmp(mask,"ALL")) {
	    if (!is_services_admin(u) && get_access(u, ci) < ACCESS_FOUNDER) 
		notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	    else {
	    	for (i = 0; i < ci->akickcount; i++) 
		    akick_del(&ci->akick[i]);
		notice_lang(s_ChanServ, u, CHAN_AKICK_CLEARALL);
		/* ci->akickcount=0; */
	    }
	    return;
	}

	/* Special case: is it a number/list?  Only do search if it isn't. */
	if (isdigit(*mask) && strspn(mask, "1234567890,-") == strlen(mask)) {
	    int count, deleted, last = -1;
	    deleted = process_numlist(mask, &count, akick_del_callback, u,
					ci, &last);
	    if (!deleted) {
		if (count == 1) {
		    notice_lang(s_ChanServ, u, CHAN_AKICK_NO_SUCH_ENTRY,
				last, ci->name);
		} else {
		    notice_lang(s_ChanServ, u, CHAN_AKICK_NO_MATCH, ci->name);
		}
	    } else if (deleted == 1) {
		notice_lang(s_ChanServ, u, CHAN_AKICK_DELETED_ONE, ci->name);
	    } else {
		notice_lang(s_ChanServ, u, CHAN_AKICK_DELETED_SEVERAL,
				deleted, ci->name);
	    }
	} else {
	    if(!strchr(mask,'@')) {
		mask2=smalloc(strlen(mask)+5);
		sprintf(mask2,"%s!*@*",mask);
		mask=mask2;
	    }			
	    for (akick = ci->akick, i = 0; i < ci->akickcount; akick++, i++) {
		if (!akick->in_use)
		    continue;
		if ((strcasecmp(akick->mask, mask) == 0))
		    break;
	    }
	    if (i == ci->akickcount) {
		notice_lang(s_ChanServ, u, CHAN_AKICK_NOT_FOUND, mask, chan);
		if(mask2)
		   free(mask2);
		return;
	    }
	    notice_lang(s_ChanServ, u, CHAN_AKICK_DELETED, mask, chan);
	    akick_del(akick);
	    if(mask2) free(mask2);
	}
    } else if (strcasecmp(cmd, "LIST") == 0) {
	int sent_header = 0;

	if (ci->akickcount == 0) {
	    notice_lang(s_ChanServ, u, CHAN_AKICK_LIST_EMPTY, chan);
	    return;
	}
	if (mask && isdigit(*mask) &&
			strspn(mask, "1234567890,-") == strlen(mask)) {
	    process_numlist(mask, NULL, akick_list_callback, u, ci,
								&sent_header);
	} else {
	    for (akick = ci->akick, i = 0; i < ci->akickcount; akick++, i++) {
		if (akick->in_use && mask && !match_wild_nocase(mask, akick->mask))
			continue;
		akick_list(u, i, ci, &sent_header);
	    }
	}
	if (!sent_header)
	    notice_lang(s_ChanServ, u, CHAN_AKICK_NO_MATCH, chan);

    } else {
	syntax_error(s_ChanServ, u, "AKICK", CHAN_AKICK_SYNTAX);
    }
}

/*************************************************************************/

static void do_levels(User *u)
{
    char *chan = strtok(NULL, " ");
    char *cmd  = strtok(NULL, " ");
    char *what = strtok(NULL, " ");
    char *s    = strtok(NULL, " ");
    ChannelInfo *ci;
    short level;
    int i;

    /* If SET, we want two extra parameters; if DIS[ABLE], we want only
     * one; else, we want none.
     */
    if (!cmd || ((strcasecmp(cmd,"SET")==0) ? !s :
			(strncasecmp(cmd,"DIS",3)==0) ? (!what || s) : !!what)) {
	syntax_error(s_ChanServ, u, "LEVELS", CHAN_LEVELS_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!is_founder(u, ci) && !is_services_admin(u)) {
	notice_lang(s_ChanServ, u, ACCESS_DENIED);

    } else if (strcasecmp(cmd, "SET") == 0) {
	level = atoi(s);
	if (level <= ACCESS_INVALID || level >= ACCESS_FOUNDER) {
	    notice_lang(s_ChanServ, u, CHAN_LEVELS_RANGE,
			ACCESS_INVALID+1, ACCESS_FOUNDER-1);
	    return;
	}
	for (i = 0; levelinfo[i].what >= 0; i++) {
	    if (strcasecmp(levelinfo[i].name, what) == 0) {
		ci->levels[levelinfo[i].what] = level;
		notice_lang(s_ChanServ, u, CHAN_LEVELS_CHANGED,
			levelinfo[i].name, chan, level);
		return;
	    }
	}
	notice_lang(s_ChanServ, u, CHAN_LEVELS_UNKNOWN, what, s_ChanServ);

    } else if (strcasecmp(cmd, "DIS") == 0 || strcasecmp(cmd, "DISABLE") == 0) {
	for (i = 0; levelinfo[i].what >= 0; i++) {
	    if (strcasecmp(levelinfo[i].name, what) == 0) {
		ci->levels[levelinfo[i].what] = ACCESS_INVALID;
		notice_lang(s_ChanServ, u, CHAN_LEVELS_DISABLED,
			levelinfo[i].name, chan);
		return;
	    }
	}
	notice_lang(s_ChanServ, u, CHAN_LEVELS_UNKNOWN, what, s_ChanServ);

    } else if (strcasecmp(cmd, "LIST") == 0) {
	int i;
	notice_lang(s_ChanServ, u, CHAN_LEVELS_LIST_HEADER, chan);
	if (!levelinfo_maxwidth) {
	    for (i = 0; levelinfo[i].what >= 0; i++) {
		int len = strlen(levelinfo[i].name);
		if (len > levelinfo_maxwidth)
		    levelinfo_maxwidth = len;
	    }
	}
	for (i = 0; levelinfo[i].what >= 0; i++) {
	    int j = ci->levels[levelinfo[i].what];
	    if (j == ACCESS_INVALID) {
		j = levelinfo[i].what;
		if (j == CA_AUTOOP || j == CA_AUTODEOP
				|| j == CA_AUTOVOICE || j == CA_NOJOIN)
		{
		    notice_lang(s_ChanServ, u, CHAN_LEVELS_LIST_DISABLED,
				levelinfo_maxwidth, levelinfo[i].name);
		} else {
		    notice_lang(s_ChanServ, u, CHAN_LEVELS_LIST_DISABLED,
				levelinfo_maxwidth, levelinfo[i].name);
		}
	    } else {
		notice_lang(s_ChanServ, u, CHAN_LEVELS_LIST_NORMAL,
				levelinfo_maxwidth, levelinfo[i].name, j);
	    }
	}

    } else if (strcasecmp(cmd, "RESET") == 0) {
	reset_levels(ci);
	notice_lang(s_ChanServ, u, CHAN_LEVELS_RESET, chan);

    } else {
	syntax_error(s_ChanServ, u, "LEVELS", CHAN_LEVELS_SYNTAX);
    }
}

/*************************************************************************/

static void do_info(User *u)
{
    char *chan = strtok(NULL, " ");
    ChannelInfo *ci;
    NickInfo *ni;
    char buf[BUFSIZE],buf2[BUFSIZE], *end;
    struct tm *tm;
    time_t now=time(NULL);
    int need_comma = 0;
    const char *commastr = getstring(u, COMMA_SPACE);
    int is_servadmin = is_services_admin(u);

    if (!chan) {
	syntax_error(s_ChanServ, u, "INFO", CHAN_INFO_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!ci->founder) {
	/* Paranoia... this shouldn't be able to happen */
	delchan(ci);
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else 
	    {
		if (ci->flags & CI_PRIVATE) 
		{
		    notice_lang(s_ChanServ, u, CHAN_INFO_PRIVATE, chan);		    		
	  	    if(!is_services_oper(u) && !is_founder(u,ci) && !check_access(u, ci, CA_ACCESS_LIST))
			return;
		}
		notice_lang(s_ChanServ, u, CHAN_INFO_HEADER, chan);
		ni = ci->founder;
  		if (ni->last_usermask && is_servadmin)
		  {
	  		notice_lang(s_ChanServ, u, CHAN_INFO_FOUNDER, ni->nick,
				ni->last_usermask);
		  } else {
	  		notice_lang(s_ChanServ, u, CHAN_INFO_NO_FOUNDER, ni->nick);
		  }
		ni = ci->successor;
		if(ni) 
		  {
	  		if (ni->last_usermask && is_servadmin)
	  		  {
				notice_lang(s_ChanServ, u, CHAN_INFO_SUCCESSOR, ni->nick,
					ni->last_usermask);
	  		  } else notice_lang(s_ChanServ, u, CHAN_INFO_NO_SUCCESSOR, ni->nick);	
		  }   
		notice_lang(s_ChanServ, u, CHAN_INFO_DESCRIPTION, ci->desc);
	
		/* when registered */
		tm = localtime(&ci->time_registered);
		strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
		ago_time(buf2,now-ci->time_registered,u);
		notice_lang(s_ChanServ, u, CHAN_INFO_TIME_REGGED, buf,buf2);
	
		/* last used */
		tm = localtime(&ci->last_used);
		strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
		ago_time(buf2,now-ci->last_used,u);
  		notice_lang(s_ChanServ, u, CHAN_INFO_LAST_USED, buf,buf2);	
		
		if (ci->last_topic && (!(ci->mlock_on & CMODE_s) || is_servadmin)) 
		  {
	  		notice_lang(s_ChanServ, u, CHAN_INFO_LAST_TOPIC, ci->last_topic);
		    notice_lang(s_ChanServ, u, CHAN_INFO_TOPIC_SET_BY,
			ci->last_topic_setter);
		  }
	
		/* record time */
		tm = localtime(&ci->maxtime);
		strftime_lang(buf, sizeof(buf), u, STRFTIME_DATE_TIME_FORMAT, tm);
		ago_time(buf2,now-ci->maxtime,u);
		notice_lang(s_ChanServ, u, CHAN_INFO_RECORD, ci->maxusers, buf, buf2);
		if (ci->c)
	  	  notice_lang(s_ChanServ, u, CHAN_INFO_USERS, ci->c->n_users);
		if (ci->url) 
		    notice_lang(s_ChanServ, u, CHAN_INFO_URL, ci->url);
		if (ci->email)
	  	  notice_lang(s_ChanServ, u, CHAN_INFO_EMAIL, ci->email);
		end = buf;
		*end = 0;
	if (ci->flags & CI_PRIVATE) 
	{
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s",
			getstring(u, CHAN_INFO_OPT_PRIVATE));
	    need_comma = 1;
	}
	if (ci->flags & CI_KEEPTOPIC) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, CHAN_INFO_OPT_KEEPTOPIC));
	    need_comma = 1;
	}
	if (ci->flags & CI_TOPICLOCK) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, CHAN_INFO_OPT_TOPICLOCK));
	    need_comma = 1;
	}
	if (ci->flags & CI_SECUREOPS) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, CHAN_INFO_OPT_SECUREOPS));
	    need_comma = 1;
	}
	if (ci->flags & CI_LEAVEOPS) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, CHAN_INFO_OPT_LEAVEOPS));
	    need_comma = 1;
	}
	if (ci->flags & CI_RESTRICTED) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, CHAN_INFO_OPT_RESTRICTED));
	    need_comma = 1;
	}
	if (ci->flags & CI_NOLINKS) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, CHAN_INFO_OPT_NOLINKS));
	    need_comma = 1;
	}
	if (ci->flags & CI_TOPICENTRY) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, CHAN_INFO_OPT_TOPICENTRY));
	    need_comma = 1;
	}	
	if (ci->flags & CI_OPNOTICE) {
	    end += snprintf(end, sizeof(buf)-(end-buf), "%s%s",
			need_comma ? commastr : "",
			getstring(u, CHAN_INFO_OPT_OPNOTICE));
	    need_comma = 1;
	}		
	notice_lang(s_ChanServ, u, CHAN_INFO_OPTIONS,
		*buf ? buf : getstring(u, CHAN_INFO_OPT_NONE));
	end = buf;
	*end = 0;
	if (ci->mlock_on || ci->mlock_key || ci->mlock_limit)
	    end += snprintf(end, sizeof(buf)-(end-buf), "+%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
				(ci->mlock_on & CMODE_I) ? "i" : "",
				(ci->mlock_key         ) ? "k" : "",
				(ci->mlock_limit       ) ? "l" : "",
				(ci->mlock_on & CMODE_M) ? "m" : "",
				(ci->mlock_on & CMODE_n) ? "n" : "",
				(ci->mlock_on & CMODE_P) ? "p" : "",
				(ci->mlock_on & CMODE_s) ? "s" : "",
				(ci->mlock_on & CMODE_T) ? "t" : "",
				(ci->mlock_on & CMODE_c) ? "c" : "",
				(ci->mlock_on & CMODE_d) ? "d" : "",				
				(ci->mlock_on & CMODE_q) ? "q" : "",								
				(ci->mlock_on & CMODE_S) ? "S" : "",				
				(ci->mlock_on & CMODE_R) ? "R" : "",
				(ci->mlock_on & CMODE_B) ? "B" : "",								
				(ci->mlock_on & CMODE_K) ? "K" : "",
				(ci->mlock_on & CMODE_O) ? "O" : "",								
				(ci->mlock_on & CMODE_A) ? "A" : "",
				(ci->mlock_on & CMODE_N) ? "N" : "",
				(ci->mlock_on & CMODE_C) ? "C" : "");				
				
	if (ci->mlock_off)
	    end += snprintf(end, sizeof(buf)-(end-buf), "-%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
				(ci->mlock_off & CMODE_I) ? "i" : "",
				(ci->mlock_off & CMODE_k) ? "k" : "",
				(ci->mlock_off & CMODE_l) ? "l" : "",
				(ci->mlock_off & CMODE_M) ? "m" : "",
				(ci->mlock_off & CMODE_n) ? "n" : "",
				(ci->mlock_off & CMODE_P) ? "p" : "",
				(ci->mlock_off & CMODE_s) ? "s" : "",
				(ci->mlock_off & CMODE_T) ? "t" : "",
				(ci->mlock_off & CMODE_c) ? "c" : "",
				(ci->mlock_off & CMODE_d) ? "d" : "",				
				(ci->mlock_off & CMODE_q) ? "q" : "",								
				(ci->mlock_off & CMODE_S) ? "S" : "",								
				(ci->mlock_off & CMODE_R) ? "R" : "",								
				(ci->mlock_off & CMODE_B) ? "B" : "",
				(ci->mlock_off & CMODE_K) ? "K" : "",
				(ci->mlock_off & CMODE_O) ? "O" : "",								
				(ci->mlock_off & CMODE_A) ? "A" : "",
				(ci->mlock_off & CMODE_N) ? "N" : "",
				(ci->mlock_off & CMODE_C) ? "C" : "");				
				
	if (*buf)
	    notice_lang(s_ChanServ, u, CHAN_INFO_MODE_LOCK, buf);

	if(ci->flags & CI_DROPPED)
	    notice_lang(s_ChanServ, u, CHAN_DROP_AT,
	    (ci->drop_time+CSDropDelay-time(NULL))/86400);    

	if ((ci->flags & CI_NO_EXPIRE) && is_servadmin)
	  notice_lang(s_ChanServ, u, CHAN_INFO_NO_EXPIRE);							
	  
  }	
	  
}

/*************************************************************************/

static void do_list(User *u)
{
    char *pattern = strtok(NULL, " ");
    char *keyword;
    ChannelInfo *ci;
    int nchans, i;
    char buf[BUFSIZE];
    int is_servadmin = is_services_admin(u);
    int16 matchflags = 0; // CI_ flags must match one to quallify 
    
    if (CSListOpersOnly && (!u || !(u->mode & UMODE_o))) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	return;
    }

    if (!pattern) {
	syntax_error(s_ChanServ, u, "LIST", 
	    is_servadmin ? CHAN_LIST_SERVADMIN_SYNTAX : CHAN_LIST_SYNTAX);
    } else {
	nchans = 0;
	/* /chanserv list * FORBIDDEN/NOEXPIRE give the the output of 
	    forbidden or noexpire channels - ^Stinger^ */
	while(is_servadmin && (keyword = strtok(NULL, " "))) {
	    if(strcasecmp(keyword, "FORBIDDEN") == 0)
		matchflags |= CI_VERBOTEN;
	    if(strcasecmp(keyword, "NOEXPIRE") == 0)
		matchflags |= CI_NO_EXPIRE;
	}

	notice_lang(s_ChanServ, u, CHAN_LIST_HEADER, pattern);
	for (i = 0; i < C_MAX; i++) {
	    for (ci = chanlists[i]; ci; ci = ci->next) {
		if (!is_servadmin & (ci->flags & CI_VERBOTEN))
		    continue;
		if((matchflags != 0) && !(ci->flags & matchflags))
		    continue;
		snprintf(buf, sizeof(buf), "%-20s %s", ci->name,
						ci->desc ? ci->desc : "");
		if (strcasecmp(pattern, ci->name) == 0 ||
					match_wild_nocase(pattern, buf)) {
		    if (++nchans <= CSListMax) {
			char noexpire_char = ' ';
			if (is_servadmin && (ci->flags & CI_NO_EXPIRE))
			    noexpire_char = '!';
			if(ci->flags & CI_VERBOTEN) {
			    snprintf(buf, sizeof(buf), "%-20s [Forbidden]",
				ci->name);
			} else {
			    snprintf(buf, sizeof(buf), "%-20s %s",
				ci->name, ci->desc);
			}
			if(u->is_msg)
			  privmsg(s_ChanServ, u->nick, "  %c%s",
			  			noexpire_char, buf);
			else			
			
			  notice(s_ChanServ, u->nick, "  %c%s",
						noexpire_char, buf);
		    }
		}
	    }
	}
	notice_lang(s_ChanServ, u, CHAN_LIST_END,
			nchans>CSListMax ? CSListMax : nchans, nchans);
    }

}

/*************************************************************************/

static void do_invite(User *u)
{
    char *chan = strtok(NULL, " ");
    Channel *c;
    ChannelInfo *ci;

    if (!chan) {
	syntax_error(s_ChanServ, u, "INVITE", CHAN_INVITE_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(ci = c->ci)) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!u || !check_access(u, ci, CA_INVITE)) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else {
	send_cmd(s_ChanServ, "INVITE %s %s", u->nick, chan);
	send_cmd(s_ChanServ, "SVSJOIN %s %s",u->nick, chan);
    }
}

/*************************************************************************/

static void do_op(User *u)
{
    char *chan = strtok(NULL, " ");
    char *op_params = strtok(NULL, " ");  
    Channel *c;
    ChannelInfo *ci;
    User *user;
    if (!chan || !op_params) {
	syntax_error(s_ChanServ, u, "OP", CHAN_OP_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(user=finduser(op_params))) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_IN_USE, op_params);		
    } else if (!(ci = c->ci)) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!is_on_chan(op_params, chan)) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN, op_params, chan);
    } else if (!u || !check_access(u, ci, CA_OPDEOP)) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else {
	char *av[3];
        struct u_chanlist *c;
        for (c = user->chans; c; c = c->next) {
            if (!irccmp(chan, c->chan->name))
                break;
        }
        if (!c)
            return;
	send_cmd(s_ChanServ, "MODE %s +o %s", chan, op_params);
	av[0] = chan;		
	av[1] = sstrdup("+o");
	av[2] = op_params;
	do_cmode(s_ChanServ, 3, av);
	free(av[1]);
	if (ci->flags & CI_OPNOTICE) {
	    char buf[NICKMAX*2+32];
	    char chan2[CHANMAX+2];
	    snprintf(buf, sizeof(buf), "OP command used for %s by %s",
			op_params, u->nick);
	    snprintf(chan2,sizeof(chan2),"@%s",chan);
	    notice(s_ChanServ, chan2, buf);
	}
    }
}

/*************************************************************************/

static void do_deop(User *u)
{
    char *chan = strtok(NULL, " ");
    char *deop_params = strtok(NULL, " ");
    Channel *c;
    ChannelInfo *ci;
    User *user;
    if (!chan || !deop_params) {
	syntax_error(s_ChanServ, u, "DEOP", CHAN_DEOP_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(user=finduser(deop_params))) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_IN_USE, deop_params);			
    } else if (!(ci = c->ci)) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!is_on_chan(deop_params, chan)) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN, deop_params, chan);
    } else if (!u || !check_access(u, ci, CA_OPDEOP)) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else {
	char *av[3];
        struct u_chanlist *c;
        for (c = user->chans; c; c = c->next) {
            if (!irccmp(chan, c->chan->name))
                break;
        }
        if (!c)
            return;
	send_cmd(s_ChanServ, "MODE %s -o %s", chan, deop_params);

	av[0] = chan;
	av[1] = sstrdup("-o");
	av[2] = deop_params;
	do_cmode(s_ChanServ, 3, av);
	free(av[1]);
	if (ci->flags & CI_OPNOTICE) {
	    char buf[NICKMAX*2+32];
	    char chan2[CHANMAX+2];
	    snprintf(buf, sizeof(buf), "DEOP command used for %s by %s",
	    		deop_params, u->nick);
	    snprintf(chan2,sizeof(chan2),"@%s",chan);
	    notice(s_ChanServ, chan2, buf);		    	   
	}
    }
}
/*************************************************************************/
static void do_voice(User *u)
{
    char *chan = strtok(NULL, " ");
    char *voice_params = strtok(NULL, " ");  
    Channel *c;
    ChannelInfo *ci;
    User *user;
    if (!chan || !voice_params) {
	syntax_error(s_ChanServ, u, "VOICE", CHAN_VOICE_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(user=finduser(voice_params))) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_IN_USE, voice_params);		
    } else if (!(ci = c->ci)) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!is_on_chan(voice_params, chan)) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN, voice_params, chan);
    } else if (!u || !check_access(u, ci, CA_VOICEDEVOICE)) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else {
	char *av[3];
        struct u_chanlist *c;
        for (c = user->chans; c; c = c->next) {
            if (!irccmp(chan, c->chan->name))
                break;
        }
        if (!c)
            return;
	send_cmd(s_ChanServ, "MODE %s +v %s", chan, voice_params);
	av[0] = chan;		
	av[1] = sstrdup("+v");
	av[2] = voice_params;
	do_cmode(s_ChanServ, 3, av);
	free(av[1]);
	if (ci->flags & CI_OPNOTICE) {
	    char buf[NICKMAX*2+32];
	    char chan2[CHANMAX+2];
	    snprintf(buf, sizeof(buf), "VOICE command used for %s by %s",
			voice_params, u->nick);
	    snprintf(chan2,sizeof(chan2),"@%s",chan);
	    notice(s_ChanServ, chan2, buf);
	}
    }
}    
/*************************************************************************/
static void do_devoice(User *u)
{
    char *chan = strtok(NULL, " ");
    char *devoice_params = strtok(NULL, " ");  
    Channel *c;
    ChannelInfo *ci;
    User *user;
    if (!chan || !devoice_params) {
	syntax_error(s_ChanServ, u, "DEVOICE", CHAN_DEVOICE_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(user=finduser(devoice_params))) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_IN_USE, devoice_params);		
    } else if (!(ci = c->ci)) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!is_on_chan(devoice_params, chan)) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN, devoice_params, chan);
    } else if (!u || !check_access(u, ci, CA_VOICEDEVOICE)) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else {
	char *av[3];
        struct u_chanlist *c;
        for (c = user->chans; c; c = c->next) {
            if (!irccmp(chan, c->chan->name))
                break;
        }
        if (!c)
            return;
	send_cmd(s_ChanServ, "MODE %s -v %s", chan, devoice_params);
	av[0] = chan;		
	av[1] = sstrdup("-v");
	av[2] = devoice_params;
	do_cmode(s_ChanServ, 3, av);
	free(av[1]);
	if (ci->flags & CI_OPNOTICE) {
	    char buf[NICKMAX*2+32];
	    char chan2[CHANMAX+2];
	    snprintf(buf, sizeof(buf), "DEVOICE command used for %s by %s",
			devoice_params, u->nick);
	    snprintf(chan2,sizeof(chan2),"@%s",chan);
	    notice(s_ChanServ, chan2, buf);
	}
    }
}    
#ifdef HALFOPS
static void do_halfop(User *u)
{
    char *chan = strtok(NULL, " ");
    char *halfop_params = strtok(NULL, " ");
    Channel *c;
    ChannelInfo *ci;
    User *user;
    if (!chan || !halfop_params) {
        syntax_error(s_ChanServ, u, "HALFOP", CHAN_HALFOP_SYNTAX);
    } else if (!(c = findchan(chan))) {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(user=finduser(halfop_params))) {
        notice_lang(s_ChanServ, u, NICK_X_NOT_IN_USE, halfop_params);
    } else if (!(ci = c->ci)) {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
        notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!is_on_chan(halfop_params, chan)) {
       notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN, halfop_params, chan);

    } else if (!u || !check_access(u, ci, CA_HALFOPDEOP)) {
        notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else {
        char *av[3];
        struct u_chanlist *c;
        for (c = user->chans; c; c = c->next) {
            if (!irccmp(chan, c->chan->name))
                break;
        }
        if (!c)
            return;
        send_cmd(s_ChanServ, "MODE %s +h %s", chan, halfop_params);
        av[0] = chan;
        av[1] = sstrdup("+h");
        av[2] = halfop_params;
        do_cmode(s_ChanServ, 3, av);
        free(av[1]);
        if (ci->flags & CI_OPNOTICE) {
            char buf[NICKMAX*2+32];
            char chan2[CHANMAX+2];
            snprintf(buf, sizeof(buf), "HALFOP command used for %s by %s",
                        halfop_params, u->nick);
            snprintf(chan2,sizeof(chan2),"@%s",chan);
            notice(s_ChanServ, chan2, buf);
        }
    }
}
static void do_dehalfop(User *u)
{
    char *chan = strtok(NULL, " ");
    char *dehalfop_params = strtok(NULL, " ");
    Channel *c;
    ChannelInfo *ci;
    User *user;
    if (!chan || !dehalfop_params) {
        syntax_error(s_ChanServ, u, "DEHALFOP", CHAN_DEHALFOP_SYNTAX);
    } else if (!(c = findchan(chan))) {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(user=finduser(dehalfop_params))) {
        notice_lang(s_ChanServ, u, NICK_X_NOT_IN_USE, dehalfop_params);
    } else if (!(ci = c->ci)) {
        notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
        notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!is_on_chan(dehalfop_params, chan)) {
       notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN, dehalfop_params, chan);

    } else if (!u || !check_access(u, ci, CA_HALFOPDEOP)) {
        notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else {
        char *av[3];
        struct u_chanlist *c;
        for (c = user->chans; c; c = c->next) {
            if (!irccmp(chan, c->chan->name))
               break;
        }
        if (!c)
           return;
        send_cmd(s_ChanServ, "MODE %s -h %s", chan, dehalfop_params);

        av[0] = chan;
        av[1] = sstrdup("-h");
        av[2] = dehalfop_params;
            do_cmode(s_ChanServ, 3, av);
        free(av[1]);
        if (ci->flags & CI_OPNOTICE) {
            char buf[NICKMAX*2+32];
            char chan2[CHANMAX+2];
            snprintf(buf, sizeof(buf), "DEHALFOP command used for %s by %s",
                        dehalfop_params, u->nick);
            snprintf(chan2,sizeof(chan2),"@%s",chan);
            notice(s_ChanServ, chan2, buf);
        }
   }
}                                                           
#endif
/*************************************************************************/

static void do_ckick(User *u)
{
    char *chan = strtok(NULL, " ");
    char *nick = strtok(NULL, " ");
    char *reason = strtok(NULL, "");
    char *kickpar [2];
    User *user;
    Channel *c;
    ChannelInfo *ci;

    if (!chan || !nick || !reason) {
	syntax_error(s_ChanServ, u, "KICK", CHAN_KICK_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(user=finduser(nick))) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_IN_USE, nick);	
    } else if (!(ci = c->ci)) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!u || IsOper(user) || !check_access(u, ci, CA_KICK) ||
    	(!check_access(u, ci, CA_PROTECT) && check_access(user, ci, CA_PROTECT))) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else if (!is_on_chan(nick, chan)) {
	notice_lang(s_ChanServ, u, NICK_X_NOT_ON_CHAN, nick, chan);
    } else {
	send_cmd(s_ChanServ, "KICK %s %s :%s", chan, nick,reason);
	kickpar[0]=sstrdup(chan);
	kickpar[1]=sstrdup(nick);	    
	do_kick(NULL,2,kickpar);
	free(kickpar[0]);
	free(kickpar[1]);	    
	if (ci->flags & CI_OPNOTICE) {
	    char buf[NICKMAX*2+32];
	    char chan2[CHANMAX+2];
	    snprintf(buf, sizeof(buf), "KICK command used for %s by %s",
		nick, u->nick);
	    snprintf(chan2,sizeof(chan2),"@%s",chan);
	    notice(s_ChanServ, chan2, buf);
	}	    
    }
}

/*************************************************************************/

static void do_unban(User *u)
{
    char *chan = strtok(NULL, " ");
    Channel *c;
    ChannelInfo *ci;
    int i;
    int nobans = -1;
    char *av[3];

    if (!chan) {
	syntax_error(s_ChanServ, u, "UNBAN", CHAN_UNBAN_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(ci = c->ci)) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!u || !check_access(u, ci, CA_UNBAN)) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else {
	/* Save original ban info */
	int count = c->bancount;
	char **bans = smalloc(sizeof(char *) * count);
	memcpy(bans, c->bans, sizeof(char *) * count);

	av[0] = chan;
	av[1] = sstrdup("-b");
	for (i = 0; i < count; i++) {
	    if (match_usermask(bans[i], u)) {
	    	nobans = 0; /* we had a ban */
		send_cmd(s_ChanServ, "MODE %s -b %s",
			chan, bans[i]);
		av[2] = sstrdup(bans[i]);
		do_cmode(s_ChanServ, 3, av);
		free(av[2]);
	    }
	}
	free(av[1]);
	free(bans);
	if(nobans==0)
	  notice_lang(s_ChanServ, u, CHAN_UNBANNED, chan);	
    }
}

/*************************************************************************/

static void do_clear(User *u)
{
    char *chan = strtok(NULL, " ");
    char *what = strtok(NULL, " ");
    Channel *c;
    ChannelInfo *ci;

    if (!what) {
	syntax_error(s_ChanServ, u, "CLEAR", CHAN_CLEAR_SYNTAX);
    } else if (!(c = findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_IN_USE, chan);
    } else if (!(ci = c->ci)) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN && (!is_services_admin(u))) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (!u || (!is_services_admin(u) && !check_access(u, ci, CA_CLEAR))) {
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
    } else if (strcasecmp(what, "bans") == 0) {
	char *av[3];
	int i;

	/* Save original ban info */
	int count = c->bancount;
	char **bans = smalloc(sizeof(char *) * count);
	buffer_mode(NULL,chan);	
	for (i = 0; i < count; i++) {
	    bans[i] = sstrdup(c->bans[i]);
	    buffer_mode("-b",c->bans[i]);
        }
	buffer_mode(NULL,NULL);	
	for (i = 0; i < count; i++) {
	    av[0] = sstrdup(chan);
	    av[1] = sstrdup("-b");
	    av[2] = bans[i];
	    do_cmode(s_ChanServ, 3, av);
	    free(av[2]);
	    free(av[1]);
	    free(av[0]);
	}
	notice_lang(s_ChanServ, u, CHAN_CLEARED_BANS, chan);
	free(bans);
    } else if (strcasecmp(what, "modes") == 0) {
	char *av[3];

	av[0] = chan;
	av[1] = sstrdup("-mintpslkSKcfdBqRNC");
	if (c->key)
	    av[2] = sstrdup(c->key);
	else
	    av[2] = sstrdup("");
	send_cmd(s_ChanServ, "MODE %s %s :%s",
			av[0], av[1], av[2]);
	do_cmode(s_ChanServ, 3, av);
	free(av[2]);
	free(av[1]);
	check_modes(chan, 0);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_MODES, chan);
    } else if (strcasecmp(what, "ops") == 0) {
	char *av[3];
	struct c_userlist *cu, *next;
	buffer_mode(NULL,chan);
	for (cu = c->chanops; cu; cu = next) {
	    next = cu->next;
	    av[0] = sstrdup(chan);
	    av[1] = sstrdup("-o");
	    av[2] = sstrdup(cu->user->nick);
	    buffer_mode("-o",cu->user->nick);
	    do_cmode(s_ChanServ, 3, av);
	    free(av[2]);
	    free(av[1]);
	    free(av[0]);
	}
	buffer_mode(NULL,NULL);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_OPS, chan);
#ifdef HALFOPS
    } else  if(strcasecmp(what, "halfops") == 0) {
	char *av[3];
	struct c_userlist *cu, *next;
	buffer_mode(NULL, chan);
	for (cu = c->halfops; cu; cu = next) {
	    next =  cu->next;
	    av[0] = sstrdup(chan);
	    av[1] = sstrdup("-h");
	    av[2] = sstrdup(cu->user->nick);
	    buffer_mode("-h", cu->user->nick);
	    do_cmode(s_ChanServ, 3, av);
	    free(av[2]);
	    free(av[1]);
	    free(av[0]);
	}
	buffer_mode(NULL, NULL);
	notice_lang(s_ChanServ, u, CHAN_CLEARED_HALFOPS, chan);
#endif
    } else if (strcasecmp(what, "voices") == 0) {
	char *av[3];
	struct c_userlist *cu, *next;
	buffer_mode(NULL,chan);
	for (cu = c->voices; cu; cu = next) {
	    next = cu->next;
	    av[0] = sstrdup(chan);
	    av[1] = sstrdup("-v");
	    av[2] = sstrdup(cu->user->nick);
	    buffer_mode("-v",cu->user->nick);			
	    do_cmode(s_ChanServ, 3, av);
	    free(av[2]);
	    free(av[1]);
	    free(av[0]);
	}
	buffer_mode(NULL,NULL);	
	notice_lang(s_ChanServ, u, CHAN_CLEARED_VOICES, chan);
    } else if (strcasecmp(what, "users") == 0) {
	char *av[3];
	struct c_userlist *cu, *next;
	char buf[256];

	snprintf(buf, sizeof(buf), "CLEAR USERS command from %s", u->nick);

	for (cu = c->users; cu; cu = next) {
	    next = cu->next;
	    av[0] = sstrdup(chan);
	    av[1] = sstrdup(cu->user->nick);
	    av[2] = sstrdup(buf);
	    send_cmd(s_ChanServ, "KICK %s %s :%s",
			av[0], av[1], av[2]);
	    do_kick(s_ChanServ, 3, av);
	    free(av[2]);
	    free(av[1]);
	    free(av[0]);
	}
	notice_lang(s_ChanServ, u, CHAN_CLEARED_USERS, chan);
    } else {
	syntax_error(s_ChanServ, u, "CLEAR", CHAN_CLEAR_SYNTAX);
    }
}

/*************************************************************************/

static void do_getpass(User *u)
{

    char *chan = strtok(NULL, " ");
    ChannelInfo *ci;
    
    /* Assumes that permission checking has already been done. */
    if(!IsOper(u)) {

    } else if (!chan) {
	syntax_error(s_ChanServ, u, "GETPASS", CHAN_GETPASS_SYNTAX);
    } else if (!(ci = cs_findchan(chan))) {
	notice_lang(s_ChanServ, u, CHAN_X_NOT_REGISTERED, chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice_lang(s_ChanServ, u, CHAN_X_FORBIDDEN, chan);
    } else if (ci->crypt_method) {	
	notice_lang(s_ChanServ, u, CHAN_GETPASS_UNAVAILABLE);	
    } else {
	log1("%s: %s!%s@%s used GETPASS on %s",
		s_ChanServ, u->nick, u->username, u->host, ci->name);
	if (WallGetpass) {
	    wallops(s_ChanServ, "\2%s\2 used GETPASS on channel \2%s\2",
		u->nick, chan);
	}
	notice_lang(s_ChanServ, u, CHAN_GETPASS_PASSWORD_IS,
		chan, ci->founderpass);
    }
}

/*************************************************************************/

static void do_forbid(User *u)
{
    ChannelInfo *ci;
    char *chan = strtok(NULL, " ");

    /* Assumes that permission checking has already been done. */
    if(!IsOper(u)) {
    
    } else if (!chan || chan[0]!='#') {
	syntax_error(s_ChanServ, u, "FORBID", CHAN_FORBID_SYNTAX);
	return;
    }
    if (readonly)
	notice_lang(s_ChanServ, u, READ_ONLY_MODE);
    if ((ci = cs_findchan(chan)) != NULL)
	delchan(ci);
    else
     {
       DayStats.cs_registered++;
       DayStats.cs_total++;
     }
    ci = makechan(chan);
    if (ci) {
	log1("%s: %s set FORBID for channel %s", s_ChanServ, u->nick,
		ci->name);
	ci->flags |= CI_VERBOTEN;
	notice_lang(s_ChanServ, u, CHAN_FORBID_SUCCEEDED, chan);
    } else {
	log1("%s: Valid FORBID for %s by %s failed", s_ChanServ, ci->name,
		u->nick);
	notice_lang(s_ChanServ, u, CHAN_FORBID_FAILED, chan);
    }
}

/*************************************************************************/

static void do_status(User *u)
{
    ChannelInfo *ci;
    User *u2;
    char *nick, *chan;

    chan = strtok(NULL, " ");
    nick = strtok(NULL, " ");
    if (!nick || strtok(NULL, " ")) {
        if(u->is_msg)
          privmsg(s_ChanServ, u->nick, "STATUS ERROR Syntax error");
        else
	  notice(s_ChanServ, u->nick, "STATUS ERROR Syntax error");
	return;
    }
    if (!(ci = cs_findchan(chan))) {
	char *temp = chan;
	chan = nick;
	nick = temp;
	ci = cs_findchan(chan);
    }
    if (!ci) {
	notice(s_ChanServ, u->nick, "STATUS ERROR Channel %s not registered",
		chan);
    } else if (ci->flags & CI_VERBOTEN) {
	notice(s_ChanServ, u->nick, "STATUS ERROR Channel %s forbidden", chan);
	return;
    } else if ((u2 = finduser(nick)) != NULL) {
	notice(s_ChanServ, u->nick, "STATUS %s %s %d",
		chan, nick, get_access(u2, ci));
    } else { /* !u2 */
	notice(s_ChanServ, u->nick, "STATUS ERROR Nick %s not online", nick);
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
	notice_lang(s_ChanServ, u, PERMISSION_DENIED);
	return;
    }
    balance = DayStats.cs_registered - (DayStats.cs_dropped+ DayStats.cs_expired);
    time(&t);
    tm = *localtime(&t);
    strftime(tmp, sizeof(tmp), getstring(NULL,STRFTIME_DATE_TIME_FORMAT), &tm);
    notice_lang(s_ChanServ, u, TODAYSTATS,tmp);    
    notice_lang(s_ChanServ, u, STATS_TOTAL,DayStats.cs_total);
    notice_lang(s_ChanServ, u, STATS_REGISTERED,DayStats.cs_registered);
    notice_lang(s_ChanServ, u, STATS_DROPPED,DayStats.cs_dropped);
    notice_lang(s_ChanServ, u, STATS_EXPIRED,DayStats.cs_expired);    
    if(balance>0) prefix='+';
	else prefix=' ';
    sprintf(tmp,"%c%ld", prefix, balance);
    notice_lang(s_ChanServ, u, STATS_BALANCE,tmp);        
}


/* remove recognized founder privilege for identified channels */
void do_logout(User *u)
{
  struct u_chaninfolist *ci, *ci2;
  if (!nick_recognized(u)) {
    notice_lang(s_ChanServ, u, CHAN_MUST_IDENTIFY_NICK,
     s_NickServ, s_NickServ);
   } 
                             
   ci = u->founder_chans;
   while (ci) {
        ci2 = ci->next;
        free(ci);
        ci = ci2;
   }
  
  u->founder_chans = NULL;
  notice_lang(s_ChanServ, u, CHAN_LOGOUT_SUCCES);
}
