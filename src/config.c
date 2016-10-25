/* Configuration file handling.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2003
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services 
 */

#include "setup.h"
#include "services.h"
#include "path.h"
#include "ircdsetup.h"
#include "options.h"


/*************************************************************************/

/* Configurable variables: */

char *RemoteServer;
int   RemotePort;
char *RemotePassword;
char *LocalHost;
int   LocalPort;

char *ServerName;
char *ServerDesc;
char *ServiceUser;
char *ServiceHost;
static char *temp_userhost;

int	*OperControl;
int	*NickChange;
char 	*GuestPrefix;

char *s_NickServ;
char *s_ChanServ;
char *s_MemoServ;
char *s_OperServ;
char *s_GlobalNoticer;
char *s_NewsServ;
char *desc_NickServ;
char *desc_ChanServ;
char *desc_MemoServ;
char *desc_OperServ;
char *desc_GlobalNoticer;
char *desc_NewsServ;
char *MOTDFilename;
char *HelpChan;
char *OnAuthChan;
char *LogChan;
char *AdminChan;
char *NickDBName;
char *ChanDBName;
char *OperDBName;
char *AutoJoinChan;
char *AutokillDBName;
char *BotListDBName;
char *SQlineDBName;
char *VlineDBName;
char *NewsDBName;
char *NewsServDBName;
char *SXlineDBName;
char *VlinkDBName;

char *DayStatsFN;
char *DomainLangFN;
char *BalanceHistoryFN;
int	EncryptMethod;

int   NoBackupOkay;
int   NoSplitRecovery;
int   StrictPasswords;
int   BadPassLimit;
int   BadPassTimeout;
int   UpdateTimeout;
int   ExpireTimeout;
int   ReadTimeout;
int   WarningTimeout;
int   TimeoutCheck;

static int NSDefNone;
int   NSDefKill;
int   NSDefKillQuick;
int   NSDefPrivate;
int   NSDefHideEmail;
int   NSDefHideQuit;
int   NSDefMemoSignon;
int   NSDefMemoReceive;
int   NSRegDelay;
int   NSNeedEmail;
int   NSNeedAuth;
int   NSDisableNOMAIL;
int   NSExpire;
int   NSRegExpire;
int   NSDropDelay;
int   NSAJoinMax;
int   NSMaxNChange;
char *NSEnforcerUser;
char *NSEnforcerHost;
static char *temp_nsuserhost;
int   NSReleaseTimeout;
int   NSAllowKillImmed;
int   NSDisableLinkCommand;
int   NSListOpersOnly;
int 	StatsOpersOnly;
int   NSListMax;
int 	NSMaxNotes;
int	NSSecureAdmins;
int	NSRegisterAdvice;

/* NewsServ */
int   NWRecentDelay;
int  	ExportRefresh;
char *ExportFN;

/* ChanServ */
int   CSMaxReg;
int   CSExpire;
int	CSRegExpire;
int   CSDropDelay;
int   CSAccessMax;
int   CSAutokickMax;
char *CSAutokickReason;
int   CSInhabit;
int   CSRestrictDelay;
int	CSLostAKick;
int   CSListOpersOnly;
int   CSListMax;
int	CSAutoAjoin;
int 	CSRestrictReg;

/* MemoServ */
int   MSMaxMemos;
int   MSSendDelay;
int   MSNotifyAll;
int	MSExpireTime;
int	MSExpireWarn;

char *ServicesRoot;
int   LogMaxUsers;
int   AutokillExpiry;
int   WallOper;
int   WallBadOS;
int   WallOSMode;
int   WallOSClearmodes;
int   WallOSKick;
int   WallOSAkill;
int   WallAkillExpire;
int   WallGetpass;
int   WallSetpass;
int 	OSNoAutoRecon;
int   CloneMinUsers;
int   CloneMaxDelay;
int   CloneWarningDelay;
char	*WebHost;
/* SendPass */
int	MailDelay;
char 	*SendFrom;
char	*SendFromName;
char 	*MailSignature;

int	DefSessionLimit;
char	*TimeZone;
int 	DefLanguage;


/* MySQL export */
char *MySQLHost;
char *MySQLDB;
char *MySQLUser;
char *MySQLPass;

/*************************************************************************/

/* Deprecated directive (dep_) and value checking (chk_) functions: */

static void dep_ListOpersOnly(void)
{
    NSListOpersOnly = 1;
    CSListOpersOnly = 1;
}

/*************************************************************************/

#define MAXPARAMS	8

/* Configuration directives. */

typedef struct {
    char *name;
    struct {
	int type;	/* PARAM_* below */
	int flags;	/* Same */
	void *ptr;	/* Pointer to where to store the value */
    } params[MAXPARAMS];
} Directive;

#define PARAM_NONE	0
#define PARAM_INT	1
#define PARAM_POSINT	2	/* Positive integer only */
#define PARAM_PORT	3	/* 1..65535 only */
#define PARAM_STRING	4
#define PARAM_TIME	5

#define PARAM_SET	-1	/* Not a real parameter; just set the
				 *    given integer variable to 1 */
#define PARAM_DEPRECATED -2	/* Set for deprecated directives; `ptr'
				 *    is a function pointer to call */

/* Flags: */
#define PARAM_OPTIONAL	0x01
#define PARAM_FULLONLY	0x02	/* Directive only allowed if !STREAMLINED */

Directive directives[] = {
/* ircd specific settings */
    { "OperControl",      { { PARAM_SET, 0, &OperControl } } },    
    { "NickChange",       { { PARAM_SET, 0, &NickChange } } },        
    { "GuestPrefix",	  { { PARAM_STRING, 0, &GuestPrefix } } },
/* */
    { "AdminChan",        { { PARAM_STRING, 0, &AdminChan } } },			            
    { "AutoJoinChan",	  { { PARAM_STRING, 0, &AutoJoinChan } } },
    { "AutokillDB",       { { PARAM_STRING, 0, &AutokillDBName } } },
    { "AutokillExpiry",   { { PARAM_TIME, 0, &AutokillExpiry } } },
    { "BadPassLimit",     { { PARAM_POSINT, 0, &BadPassLimit } } },
    { "BadPassTimeout",   { { PARAM_TIME, 0, &BadPassTimeout } } },
    { "BotListDB",        { { PARAM_STRING, 0, &BotListDBName } } },
    { "ChanServDB",       { { PARAM_STRING, 0, &ChanDBName } } },
    { "ChanServName",     { { PARAM_STRING, 0, &s_ChanServ },
                            { PARAM_STRING, 0, &desc_ChanServ } } },
    { "CSAccessMax",      { { PARAM_POSINT, 0, &CSAccessMax } } },
    { "CSAutoAjoin",	  { { PARAM_SET,    0, &CSAutoAjoin } } },
    { "CSAutokickMax",    { { PARAM_POSINT, 0, &CSAutokickMax } } },
    { "CSAutokickReason", { { PARAM_STRING, 0, &CSAutokickReason } } },
    { "CSExpire",         { { PARAM_TIME, 0, &CSExpire } } },
    { "CSRegExpire",      { { PARAM_TIME, 0, &CSRegExpire } } },    
    { "CSDropDelay",      { { PARAM_TIME, 0, &CSDropDelay } } },    
    { "CSInhabit",        { { PARAM_TIME, 0, &CSInhabit } } },
    { "CSLostAKick",      { { PARAM_TIME, 0, &CSLostAKick } } },
    { "CSListMax",        { { PARAM_POSINT, 0, &CSListMax } } },
    { "CSListOpersOnly",  { { PARAM_SET, 0, &CSListOpersOnly } } },
    { "CSMaxReg",         { { PARAM_POSINT, 0, &CSMaxReg } } },
    { "CSRestrictDelay",  { { PARAM_TIME, 0, &CSRestrictDelay } } },
    { "CSRestrictReg",    { { PARAM_SET, 0, &CSRestrictReg } } },
    { "DayStatsFN",       { { PARAM_STRING, 0, &DayStatsFN } } },
    { "DefSessionLimit",  { { PARAM_INT, 0, &DefSessionLimit } } },
    { "DefLanguage",      { { PARAM_INT,    0, &DefLanguage } } },    
    { "BalanceHistoryFN", { { PARAM_STRING, 0, &BalanceHistoryFN } } },
    { "DomainLangFN",     { { PARAM_STRING, 0, &DomainLangFN } } },			            
    { "EncryptMethod",    { { PARAM_INT, 0, &EncryptMethod } } },     
    { "ExpireTimeout",    { { PARAM_TIME, 0, &ExpireTimeout } } },
    { "ExportRefresh",    { { PARAM_TIME, 0, &ExportRefresh } } },    
    { "ExportFN",    	  { { PARAM_STRING, 0, &ExportFN } } },    
    { "GlobalName",       { { PARAM_STRING, 0, &s_GlobalNoticer },
                            { PARAM_STRING, 0, &desc_GlobalNoticer } } },
    { "HelpChan",         { { PARAM_STRING, 0, &HelpChan } } },
    { "OnAuthChan",       { { PARAM_STRING, 0, &OnAuthChan } } },
    { "ListOpersOnly",    { { PARAM_DEPRECATED, 0, dep_ListOpersOnly } } },
    { "LocalAddress",     { { PARAM_STRING, 0, &LocalHost },
                            { PARAM_PORT, PARAM_OPTIONAL, &LocalPort } } },
    { "LogChan",          { { PARAM_STRING, 0, &LogChan } } },	    		                
    { "LogMaxUsers",      { { PARAM_SET, 0, &LogMaxUsers } } },
    { "MailDelay",    	  { { PARAM_TIME, 0, &MailDelay } } },    
    { "MemoServName",     { { PARAM_STRING, 0, &s_MemoServ },
                            { PARAM_STRING, 0, &desc_MemoServ } } },
    { "MailSignature",	  { { PARAM_STRING, 0, &MailSignature } } },
    { "MOTDFile",         { { PARAM_STRING, 0, &MOTDFilename } } },
    { "MSMaxMemos",       { { PARAM_POSINT, 0, &MSMaxMemos } } },
    { "MSNotifyAll",      { { PARAM_SET, 0, &MSNotifyAll } } },
    { "MSSendDelay",      { { PARAM_TIME, 0, &MSSendDelay } } },
    { "MSExpireWarn",      { { PARAM_TIME, 0, &MSExpireWarn } } },
    { "MSExpireTime",      { { PARAM_TIME, 0, &MSExpireTime } } },
    { "NSRegisterAdvice", { { PARAM_SET, 0, &NSRegisterAdvice } } },
    { "NewsDB",           { { PARAM_STRING, 0, &NewsDBName } } },
    { "NewsServDB",       { { PARAM_STRING, 0, &NewsServDBName } } },
    { "NewsServName",     { { PARAM_STRING, 0, &s_NewsServ },
                            { PARAM_STRING, 0, &desc_NewsServ } } },    
    { "NickservDB",       { { PARAM_STRING, 0, &NickDBName } } },
    { "NickServName",     { { PARAM_STRING, 0, &s_NickServ },
                            { PARAM_STRING, 0, &desc_NickServ } } },
    { "NoBackupOkay",     { { PARAM_SET, 0, &NoBackupOkay } } },
    { "NoSplitRecovery",  { { PARAM_SET, 0, &NoSplitRecovery } } },
    { "NWRecentDelay",    { { PARAM_TIME, 0, &NWRecentDelay } } },
    { "NSAJoinMax",       { { PARAM_POSINT, 0, &NSAJoinMax } } },    
    { "NSMaxNChange",     { { PARAM_POSINT, 0, &NSMaxNChange } } },        
    { "NSAllowKillImmed", { { PARAM_SET, 0, &NSAllowKillImmed } } },
    { "NSDefHideEmail",   { { PARAM_SET, 0, &NSDefHideEmail } } },
    { "NSDefHideQuit",    { { PARAM_SET, 0, &NSDefHideQuit } } },
    { "NSDefKill",        { { PARAM_SET, 0, &NSDefKill } } },
    { "NSDefKillQuick",   { { PARAM_SET, 0, &NSDefKillQuick } } },
    { "NSDefMemoReceive", { { PARAM_SET, 0, &NSDefMemoReceive } } },
    { "NSDefMemoSignon",  { { PARAM_SET, 0, &NSDefMemoSignon } } },    
    { "NSDefNone",        { { PARAM_SET, 0, &NSDefNone } } },
    { "NSDefPrivate",     { { PARAM_SET, 0, &NSDefPrivate } } },
    { "NSDisableLinkCommand",{{PARAM_SET, 0, &NSDisableLinkCommand } } },
    { "NSEnforcerUser",   { { PARAM_STRING, 0, &temp_nsuserhost } } },
    { "NSExpire",         { { PARAM_TIME, 0, &NSExpire } } },
    { "NSRegExpire",      { { PARAM_TIME, 0, &NSRegExpire } } },    
    { "NSDropDelay",      { { PARAM_TIME, 0, &NSDropDelay } } },    
    { "NSListMax",        { { PARAM_POSINT, 0, &NSListMax } } },
    { "NSListOpersOnly",  { { PARAM_SET, 0, &NSListOpersOnly } } },
    { "NSNeedEmail",      { { PARAM_SET, 0, &NSNeedEmail } } },
    { "NSNeedAuth",      { { PARAM_SET, 0, &NSNeedAuth } } },
    { "NSDisableNOMAIL", { { PARAM_SET, 0, &NSDisableNOMAIL } } },    
    { "NSMaxNotes",       { { PARAM_POSINT, 0, &NSMaxNotes } } },    
    { "NSRegDelay",       { { PARAM_TIME, 0, &NSRegDelay } } },
    { "NSReleaseTimeout", { { PARAM_TIME, 0, &NSReleaseTimeout } } },
    { "NSSecureAdmins",   { { PARAM_SET, 0, &NSSecureAdmins } } },
    { "OperServDB",       { { PARAM_STRING, 0, &OperDBName } } },
    { "OperServName",     { { PARAM_STRING, 0, &s_OperServ },
                            { PARAM_STRING, 0, &desc_OperServ } } },
    { "OSNoAutoRecon",    { { PARAM_SET, 0, &OSNoAutoRecon } } },
    { "ReadTimeout",      { { PARAM_TIME, 0, &ReadTimeout } } },
    { "RemoteServer",     { { PARAM_STRING, 0, &RemoteServer },
                            { PARAM_PORT, 0, &RemotePort },
                            { PARAM_STRING, 0, &RemotePassword } } },			    
    { "SendFrom",         { { PARAM_STRING, 0, &SendFrom } } },
    { "SendFromName",     { { PARAM_STRING, 0, &SendFromName } } },    
    { "ServerDesc",       { { PARAM_STRING, 0, &ServerDesc } } },
    { "ServerName",       { { PARAM_STRING, 0, &ServerName } } },
    { "ServicesRoot",     { { PARAM_STRING, 0, &ServicesRoot } } },
    { "ServiceUser",      { { PARAM_STRING, 0, &temp_userhost } } },
    { "SQlineDB",         { { PARAM_STRING, 0, &SQlineDBName } } },
    { "StatsOpersOnly",   { { PARAM_SET, 0, &StatsOpersOnly } } },        
    { "StrictPasswords",  { { PARAM_SET, 0, &StrictPasswords } } },
    { "SXlineDB",	  { { PARAM_STRING, 0, &SXlineDBName } } },
    { "TimeoutCheck",     { { PARAM_TIME, 0, &TimeoutCheck } } },
    { "TimeZone",         { { PARAM_STRING, 0, &TimeZone } } },			            
    { "VlineDB",          { { PARAM_STRING, 0, &VlineDBName } } },
    { "VlinkDB",	  { { PARAM_STRING, 0, &VlinkDBName } } },        
    { "UpdateTimeout",    { { PARAM_TIME, 0, &UpdateTimeout } } },
    { "WallAkillExpire",  { { PARAM_SET, 0, &WallAkillExpire } } },
    { "WallBadOS",        { { PARAM_SET, 0, &WallBadOS } } },
    { "WallGetpass",      { { PARAM_SET, 0, &WallGetpass } } },
    { "WallOper",         { { PARAM_SET, 0, &WallOper } } },
    { "WallOSAkill",      { { PARAM_SET, 0, &WallOSAkill } } },
    { "WallOSClearmodes", { { PARAM_SET, 0, &WallOSClearmodes } } },
    { "WallOSKick",       { { PARAM_SET, 0, &WallOSKick } } },
    { "WallOSMode",       { { PARAM_SET, 0, &WallOSMode } } },
    { "WallSetpass",      { { PARAM_SET, 0, &WallSetpass } } },
    { "WarningTimeout",   { { PARAM_TIME, 0, &WarningTimeout } } },
    { "WebHost",          { { PARAM_STRING, 0, &WebHost } } },
    { "MySQLHost",       { { PARAM_STRING, 0, &MySQLHost } } },        
    { "MySQLDB",       { { PARAM_STRING, 0, &MySQLDB } } },    
    { "MySQLUser",       { { PARAM_STRING, 0, &MySQLUser } } },        
    { "MySQLPass",       { { PARAM_STRING, 0, &MySQLPass } } },            
};

/*************************************************************************/

/* Print an error message to the log (and the console, if open). */
void error(int linenum, char *message, ...);
void error(int linenum, char *message, ...)
{
    char buf[4096];
    va_list args;

    va_start(args, message);
    vsnprintf(buf, sizeof(buf), message, args);
#ifndef NOT_MAIN
    if (linenum)
	log1("%s:%d: %s", ETCPATH "/" SERVICES_CONF, linenum, buf);
    else
	log1("%s: %s", ETCPATH "/" SERVICES_CONF, buf);
    if (!nofork && isatty(2)) {
#endif
	if (linenum)
	    fprintf(stderr, "%s:%d: %s\n", ETCPATH "/" SERVICES_CONF, linenum, buf);
	else
	    fprintf(stderr, "%s: %s\n", ETCPATH "/" SERVICES_CONF, buf);
#ifndef NOT_MAIN
    }
#endif
}

/*************************************************************************/

/* Parse a configuration line.  Return 1 on success; otherwise, print an
 * appropriate error message and return 0.  Destroys the buffer by side
 * effect.
 */
int parse(char *buf, int linenum, int rehash);
int parse(char *buf, int linenum, int rehash)
{
    char *s, *t, *dir;
    int i, n, optind, val;
    int retval = 1;
    int ac = 0;
    char *av[MAXPARAMS];
    dir = strtok(buf, " \t\r\n");
    if(!dir)
    	return 1;
    s = strtok(NULL, "");
    if (s) {
	while (isspace(*s))
	    s++;
	while (*s) {
	    if (ac >= MAXPARAMS) {
		error(linenum, "Warning: too many parameters (%d max)",
			MAXPARAMS);
		break;
	    }
	    t = s;
	    if (*s == '"') {
		t++;
		s++;
		while (*s && *s != '"') {
		    if (*s == '\\' && s[1] != 0)
			s++;
		    s++;
		}
		if (!*s)
		    error(linenum, "Warning: unterminated double-quoted string");
		else
		    *s++ = 0;
	    } else {
		s += strcspn(s, " \t\r\n");
		if (*s)
		    *s++ = 0;
	    }
	    av[ac++] = t;
	    while (isspace(*s))
		s++;
	}
    }

    if (!dir)
	return 1;
    for (n = 0; n < lenof(directives); n++) {
	Directive *d = &directives[n];
	if (strcasecmp(dir, d->name) != 0)
	    continue;
	optind = 0;
	for (i = 0; i < MAXPARAMS && d->params[i].type != PARAM_NONE; i++) {
	    if (d->params[i].type == PARAM_SET) {
		*(int *)d->params[i].ptr = 1;
		continue;
	    }
#ifdef STREAMLINED
	    if (d->params[i].flags & PARAM_FULLONLY) {
		error(linenum, "Directive `%s' not available in STREAMLINED mode",
			d->name);
		break;
	    }
#endif
	    if (d->params[i].type == PARAM_DEPRECATED) {
		void (*func)(void);
		error(linenum, "Deprecated directive `%s' used", d->name);
		func = (void (*)(void))(d->params[i].ptr);
		func();  /* For clarity */
		continue;
	    }
	    if (optind >= ac) {
		if (!(d->params[i].flags & PARAM_OPTIONAL)) {
		    error(linenum, "Not enough parameters for `%s'", d->name);
		    retval = 0;
		}
		break;
	    }
	    switch (d->params[i].type) {
	      case PARAM_INT:
		val = strtol(av[optind++], &s, 0);
		if (*s) {
		    error(linenum, "%s: Expected an integer for parameter %d",
			d->name, optind);
		    retval = 0;
		    break;
		}
		*(int *)d->params[i].ptr = val;
		break;
	      case PARAM_POSINT:
		val = strtol(av[optind++], &s, 0);
		if (*s || val <= 0) {
		    error(linenum,
			"%s: Expected a positive integer for parameter %d",
			d->name, optind);
		    retval = 0;
		    break;
		}
		*(int *)d->params[i].ptr = val;
		break;
	      case PARAM_PORT:
		val = strtol(av[optind++], &s, 0);
		if (*s) {
		    error(linenum,
			"%s: Expected a port number for parameter %d",
			d->name, optind);
		    retval = 0;
		    break;
		}
		if (val < 1 || val > 65535) {
		    error(linenum,
			"Port numbers must be in the range 1..65535");
		    retval = 0;
		    break;
		}
		*(int *)d->params[i].ptr = val;
		break;
	      case PARAM_STRING:
	        if(!rehash) {
		    *(char **)d->params[i].ptr = strdup(av[optind++]);
		    if (!d->params[i].ptr) {
			error(linenum, "%s: Out of memory", d->name);
			return 0;
		    } 
		} else optind++;
		break;
	      case PARAM_TIME:
		val = dotime(av[optind++]);
		if (val < 0) {
		    error(linenum,
			"%s: Expected a time value for parameter %d",
			d->name, optind);
		    retval = 0;
		    break;
		}
		*(int *)d->params[i].ptr = val;
		break;
	      default:
		error(linenum, "%s: Unknown type %d for param %d",
				d->name, d->params[i].type, i+1);
		return 0;  /* don't bother continuing--something's bizarre */
	    }
	}
	break;	/* because we found a match */
    }

    if (n == lenof(directives)) {
	error(linenum, "Unknown directive `%s'", dir);
	return 1;	/* don't cause abort */
    }

    return retval;
}

/*************************************************************************/

#define CHECK(v) do {			\
    if (!v) {				\
	error(0, #v " missing");	\
	retval = 0;			\
    }					\
} while (0)

#define CHEK2(v,n) do {			\
    if (!v) {				\
	error(0, #n " missing");	\
	retval = 0;			\
    }					\
} while (0)

/* Read the entire configuration file.  If an error occurs while reading
 * the file or a required directive is not found, print and log an
 * appropriate error message and return 0; otherwise, return 1.
 */

int read_config(int rehash)
{
    FILE *config;
    int linenum = 1, retval = 1;
    char buf[1024], *s;
#ifndef NOT_MAIN    
    if(rehash)
	log1("Configuration rehash");
#endif	
    config = fopen(ETCPATH "/" SERVICES_CONF, "r");
    if (!config) {
#ifndef NOT_MAIN
	log_perror("Can't open " ETCPATH "/" SERVICES_CONF);
	if (!nofork && isatty(2))
#endif
	    perror("Can't open " ETCPATH "/" SERVICES_CONF);
	return 0;
    }
    while (fgets(buf, sizeof(buf), config)) {
	s = strchr(buf, '#');
	if (s)
	    *s = 0;
	if ((s!=buf) && !parse(buf, linenum, rehash))
	    retval = 0;
	linenum++;
    }
    fclose(config);

    CHECK(RemoteServer);
    CHECK(ServerName);
    CHECK(ServerDesc);
    CHEK2(temp_userhost, ServiceUser);
    CHEK2(s_NickServ, NickServName);
    CHEK2(s_ChanServ, ChanServName);
    CHEK2(s_MemoServ, MemoServName);
    CHEK2(s_OperServ, OperServName);
#ifdef NEWS
    CHEK2(s_NewsServ, NewsServName);
#endif
    CHEK2(s_GlobalNoticer, GlobalName);
    CHEK2(MOTDFilename, MOTDFile);
    CHEK2(NickDBName, NickServDB);
    CHEK2(ChanDBName, ChanServDB);
    CHEK2(OperDBName, OperServDB);
    CHEK2(AutokillDBName, AutokillDB);
    CHEK2(BotListDBName, BotListDB);
    CHEK2(SQlineDBName, SQlineDB);
    CHEK2(NewsDBName, NewsDB);
    CHEK2(VlineDBName, VlineDB);
    CHEK2(SXlineDBName, SXlineDB);
    CHEK2(VlinkDBName, VlinkDB);
#ifdef NEWS
    CHEK2(NewsServDBName, NewsServDB);
#endif    
    CHECK(DayStatsFN);    
    CHECK(UpdateTimeout);
    CHECK(ExpireTimeout);
    CHECK(ReadTimeout);
    CHECK(WarningTimeout);
    CHECK(TimeoutCheck);
    CHECK(NSAJoinMax);    
#ifdef NICKCHANGE
    CHECK(NSMaxNChange);        
#endif
    CHEK2(temp_nsuserhost, NSEnforcerUser);
    CHECK(NSReleaseTimeout);
    CHECK(NSListMax);
    CHECK(NSMaxNotes);
    CHECK(CSAccessMax);
    CHECK(CSAutokickMax);
    CHECK(CSAutokickReason);
    CHECK(CSInhabit);
    CHECK(CSLostAKick);    
    CHECK(CSListMax);
    CHECK(ServicesRoot);
    CHECK(AutokillExpiry);
    CHECK(DefLanguage);
#ifdef SENDMAIL
    CHECK(MailDelay);
    CHECK(SendFrom);	
    CHECK(SendFromName);
    CHECK(MailSignature);
#endif
    if(ExportRefresh)
	CHECK(ExportFN);
    DefLanguage -= 1 ; /* adjust base index */
    if (temp_userhost && !rehash) {
	if (!(s = strchr(temp_userhost, '@'))) {
	    error(0, "Missing `@' for ServiceUser");
	} else {
	    *s++ = 0;
	    ServiceUser = temp_userhost;
	    ServiceHost = s;
	}
    }

    if (temp_nsuserhost) {
	if (!(s = strchr(temp_nsuserhost, '@'))) {
	    NSEnforcerUser = temp_nsuserhost;
	    NSEnforcerHost = ServiceHost;
	} else {
	    *s++ = 0;
	    NSEnforcerUser = temp_userhost;
	    NSEnforcerHost = s;
	}
    }

    if (!NSDefNone &&
		!NSDefKill &&
		!NSDefKillQuick &&
		!NSDefPrivate &&
		!NSDefHideEmail &&
		!NSDefHideQuit &&
		!NSDefMemoSignon &&
		!NSDefMemoReceive
    ) {
	NSDefMemoSignon = 1;
	NSDefMemoReceive = 1;
    }

#ifndef NOT_MAIN	
    if(TimeZone) {
#ifdef HAVE_SETENV   
	setenv("TZ",TimeZone,1);
	tzset();
#else
	log1("TimeZone defined but not supported by this OS!");	
#endif
    }
#endif /* NOT_MAIN */

#ifndef NOT_MAIN    
  if(MySQLDB)
    {
#ifdef HAVE_MYSQL
      CHECK(MySQLHost);
      CHECK(MySQLUser);
      CHECK(MySQLPass);  
#else
      log1("MySQLDB is defined but services were compiled without MySQL support");
#endif
    }

#endif /* NOT_MAIN */    
    return retval;
}


/*************************************************************************/
