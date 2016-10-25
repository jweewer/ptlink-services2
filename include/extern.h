/* Prototypes and external variable declarations.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 */

#ifndef EXTERN_H
#define EXTERN_H


#define E extern


/**** actions.c ****/

E void kill_user(const char *source, const char *user, const char *reason);
E void bad_password(User *u);

/**** akill.c ****/
E void get_akill_stats(long *nrec, long *memuse);
E int num_akills(void);
E void load_akill(void);
E void save_akill(void);
E int check_akill(const char *nick, const char *username, const char *host);
E void expire_akills(void);
E void do_akill(User *u);
E void add_akill(const char *mask, const char *reason, const char *who,
		      const char *expiry);

/**** botlist.c ****/  /* Lamego 1999 */
E int check_botlist(const char *host);
E void do_botlist(User *u);
E void load_botlist(void);
E void save_botlist(void);



/**** channels.c ****/

#ifdef DEBUG_COMMANDS
E void send_channel_list(User *user);
E void send_channel_users(User *user);
#endif
E void buffer_mode(const char* mode,char* target);
E void get_channel_stats(long *nrec, long *memuse);
E Channel *findchan(const char *chan);
E Channel *firstchan(void);
E Channel *nextchan(void);

E Channel* chan_adduser(User *user, const char *chan, int wasmodes);
E void chan_deluser(User *user, Channel *c);

E void do_cmode(const char *source, int ac, char **av);
E void do_topic(const char *source, int ac, char **av);
E void do_sjoin(const char *source, int ac, char **av);
E void do_cmode_sjoin(Channel *chan, int ac, char **av);

E int only_one_user(const char *chan);
E void clean_channelname(char* cn);


/**** chanserv.c ****/

E void listchans(int count_only, const char *chan);
E void get_chanserv_stats(long *nrec, long *memuse);

E void cs_init(void);
E void chanserv(const char *source, char *buf);
E void load_cs_dbase(void);
E void save_cs_dbase(void);
E void check_modes(const char *chan, int sjoin);
E int check_valid_op(User *user, const char *chan, int newchan);
E int check_should_op(User *user, const char *chan, int wasmode);
E int check_should_deop(User *user, const char *chan);
E int check_should_voice(User *user, const char *chan, int wasmode);
E int check_should_protect(User *user, const char *chan, int wasmode);
E int check_kick(User *user, const char *chan, ChannelInfo *ci);
E void record_topic(const char *chan);
E void restore_topic(const char *chan);
E int check_topiclock(const char *chan);
E void expire_chans(void);
E void cs_remove_nick(const NickInfo *ni);

E ChannelInfo *cs_findchan(const char *chan);
E int check_access(User *user, ChannelInfo *ci, int what);
E int is_identified(User *user, ChannelInfo *ci);
#ifdef HALFOPS
E int check_valid_halfops(User *user, const char *chan, int newchan);
E int check_should_halfop(User *user, const char *chan, int wasmode);
E int check_should_dehalfop(User *user, const char *chan);
#endif

/**** sessions.c ****/  /* Lamego 2000 */
E void do_session(User *u);
E Session* add_session(const char *nick, const char *host, int limit);
E void delete_session(Session* session);

/**** sqline.c ****/  /* Lamego 2000 */
E void do_sqline(User *u);
E void load_sq_dbase(void);
E void save_sq_dbase(void);
E void set_sqlines(void);
E void do_vline(User *u);
E void load_vl_dbase(void);
E void save_vl_dbase(void);
E void set_vlines(void);
E void load_sxl_dbase(void);
E void save_sxl_dbase(void);
E void set_sxlines(void);
E void do_sxline(User *u);
E void load_vlink_dbase(void);
E void save_vlink_dbase(void);
E void set_vlinks(void);
E void do_vlink(User *u);

/**** config.c ****/

E char *RemoteServer;
E int   RemotePort;
E char *RemotePassword;
E char *LocalHost;
E int   LocalPort;

E char *ServerName;
E char *ServerDesc;
E char *ServiceUser;
E char *ServiceHost;

E int	*OperControl;
E int	*NickChange;
E char  *GuestPrefix;

E int	*AutoSetSAdmin;
E char *AutoJoinChan;

E char *s_NickServ;
E char *s_ChanServ;
E char *s_MemoServ;
E char *s_OperServ;
E char *s_GlobalNoticer;

E char *s_NewsServ;
E char *desc_NickServ;
E char *desc_ChanServ;
E char *desc_MemoServ;
E char *desc_OperServ;
E char *desc_GlobalNoticer;
E char *desc_NewsServ;

E char *MOTDFilename;
E char *NickDBName;
E char *ChanDBName;
E char *OperDBName;
E char *AutokillDBName;
E char *BotListDBName;
E char *SQlineDBName;
E char *VlineDBName;
E char *NewsDBName;
E char *NewsServDBName;
E char *SXlineDBName;
E char *VlinkDBName;
E char *DayStatsFN;
E char *DomainLangFN;
E char *BalanceHistoryFN;
E int	EncryptMethod;

E char *LogChan;
E char *HelpChan;
E char *OnAuthChan;
E char *AdminChan;

E int   NoBackupOkay;
E int   NoSplitRecovery;
E int   StrictPasswords;
E int   BadPassLimit;
E int   BadPassTimeout;
E int   UpdateTimeout;
E int   ExpireTimeout;
E int   ReadTimeout;
E int   WarningTimeout;
E int   TimeoutCheck;

E int   NSDefKill;
E int   NSDefKillQuick;
E int   NSDefPrivate;
E int   NSDefHideEmail;
E int   NSDefHideQuit;
E int   NSDefMemoSignon;
E int   NSDefMemoReceive;
E int   NSRegDelay;
E int	NSNeedEmail;
E int   NSNeedAuth;
E int   NSDisableNOMAIL;
E int   NSExpire;
E int   NSRegExpire;
E int   NSDropDelay;
E int	NSAJoinMax;
E int 	NSMaxNChange;
E char *NSEnforcerUser;
E char *NSEnforcerHost;
E int   NSReleaseTimeout;
E int   NSAllowKillImmed;
E int   NSDisableLinkCommand;
E int   NSListOpersOnly;
E int   NSListMax;
E int	NSMaxNotes;
E int 	NSSecureAdmins;
E int	NSForbidAsGuest;
E int	NSRegisterAdvice;

E int	NWRecentDelay;
E int   CSMaxReg;
E int   CSExpire;
E int   CSRegExpire;
E int   CSDropDelay;
E int   CSAccessMax;
E int   CSAutokickMax;
E char *CSAutokickReason;
E int   CSInhabit;
E int 	CSLostAKick;
E int   CSRestrictDelay;
E int   CSListOpersOnly;
E int   CSListMax;
E int	CSAutoAjoin;
E int 	CSRestrictReg;
E int   CSKeepIn;

E int   MSMaxMemos;
E int   MSSendDelay;
E int   MSNotifyAll;
E int 	MSExpireWarn;
E int 	MSExpireTime;

E int	MailDelay;
E char *SendFrom;
E char *SendFromName;
E char *MailSignature;

E char *ServicesRoot;
E int   LogMaxUsers;
E int   AutokillExpiry;
E int 	OSNoAutoRecon;
E int   WallOper;
E int   WallBadOS;
E int   WallOSMode;
E int   WallOSClearmodes;
E int   WallOSKick;
E int   WallOSAkill;
E int   WallAkillExpire;
E int   WallGetpass;
E int   WallSetpass;
E int   CloneMinUsers;
E int   CloneMaxDelay;
E int   CloneWarningDelay;
E int 	DefSessionLimit;
E int 	DefBotListMax;
E int 	DefLanguage;
E int  	ExportRefresh;
E char *ExportFN;
E int 	StatsOpersOnly;
E char *WebHost;

/* MySQL export */
E char *MySQLHost;
E char *MySQLDB;
E char *MySQLUser;
E char *MySQLPass;

E int read_config(int rehash);


/**** helpserv.c ****/

E void helpserv(const char *whoami, const char *source, char *buf);


/**** init.c ****/

E void introduce_user(const char *user);
E int init(int ac, char **av);


/**** language.c ****/

E char **langtexts[NUM_LANGS];
E char *langnames[NUM_LANGS];
E int langlist[NUM_LANGS];

E void lang_init(void);

E char *getstring(User *u, int index); 
E char* getstringnick(NickInfo *ni,int index);
E char* igetstring(int i,int index);
E int strftime_lang(char *buf, int size, User *u, int format, struct tm *tm);
E void syntax_error(const char *service, User *u, const char *command,
		int msgnum);
E int domain_language(char *domain);
E void send_auth_email(NickInfo *ni, char *pass);
E void send_setemail(NickInfo *ni);

/**** list.c ****/
E int listnicks_stdb;
E int listchans_stdb;
E void do_listnicks(int ac, char **av);
E void do_listchans(int ac, char **av);


/**** log.c ****/

E int open_log(void);
E void close_log(void);
E void log1(const char *fmt, ...)		FORMAT(printf,1,2);
E void log2c(const char *fmt, ...)		FORMAT(printf,1,2);
E void chanlog(const char *fmt, ...)		FORMAT(printf,1,2);
E void log_perror(const char *fmt, ...)		FORMAT(printf,1,2);
E void fatal(const char *fmt, ...)		FORMAT(printf,1,2);
E void fatal_perror(const char *fmt, ...)	FORMAT(printf,1,2);


/**** main.c ****/

E const char version_number[];
E const char version_build[];
E const char version_protocol[];

E char *services_dir;
E char *log_filename;
E int   debug;
E int   readonly;
E int   skeleton;
E int   nofork;
E int   forceload;
E int 	generate;
E int 	expiremail;
E int   ccompleted;

E int   quitting;
E int   delayed_quit;
E char *quitmsg;
E char  inbuf[BUFSIZE];
E int   servsock;
E int   save_data;
E int   got_alarm;
E time_t start_time;


/**** memory.c ****/

E void *smalloc(long size);
E void *scalloc(long elsize, long els);
E void *srealloc(void *oldptr, long newsize);
E char *sstrdup(const char *s);


/**** memoserv.c ****/

E void ms_init(void);
E void memoserv(const char *source, char *buf);
E void load_old_ms_dbase(void);
E void check_memos(User *u);


/**** misc.c ****/

E char *strscpy(char *d, const char *s, size_t len);
E char *stristr(char *s1, char *s2);
E char *strupper(char *s);
E char *strlower(char *s);
E char *strnrepl(char *s, int32 size, const char *old, const char *new);

E char *merge_args(int argc, char **argv);

E int match_wild(const char *pattern, const char *str);
E int match_wild_nocase(const char *pattern, const char *str);

typedef int (*range_callback_t)(User *u, int num, va_list args);
E int process_numlist(const char *numstr, int *count_ret,
		range_callback_t callback, User *u, ...);
E int dotime(const char *s);
E void make_virthost(char *curr, char *new);
E void ago_time(char *buf, time_t t, User *u);
E void total_time(char *buf, time_t t, User *u);
E void dumpcore();
E void rand_string(char *target, int minlen, int maxlen);
E char* e_str(const char* src);
E char* t_str(time_t src);
E void set_sql_string(char* dest, char* src);
E char* hex_str(unsigned char *str, int len);
E char* collapse(char *pattern);
E void strip_rn(char *txt);
E int get_pass(char *dest, size_t maxlen);

E int valid_hostname(const char* hostname);

E int valid_hostname(const char* hostname);

/**** news.c ****/

E void get_news_stats(long *nrec, long *memuse);
E void load_news(void);
E void save_news(void);
E void display_news(User *u, int16 type);
E void do_logonnews(User *u);
E void do_opernews(User *u);

/**** newsserv.c ****/
E void newsserv(const char *source, char *buf);
E void nw_init(void);
E void load_nw_dbase(void);
E void save_nw_dbase(void);
E void newsserv_export(void);

/**** nickserv.c ****/
E void listnicks(int count_only, const char *nick);
E void get_nickserv_stats(long *nrec, long *memuse);

E void ns_init(void);
E void nickserv(const char *source, char *buf);
E void load_ns_dbase(void);
E void save_ns_dbase(void);
E int validate_user(User *u);
E void cancel_user(User *u);
E int nick_identified(User *u);
E int nick_restrict_identified(User *u);
#define nick_recognized(x) ((x)->real_ni && (((x)->real_ni->status\
 & (NS_IDENTIFIED | NS_RECOGNIZED)) || ((x)->mode & UMODE_r)))
E void expire_nicks(void);

E NickInfo *findnick(const char *nick);
E NickInfo *getlink(NickInfo *ni);
E void autojoin(User *u);
E uint32 lastnid;

/**** operserv.c ****/

E void operserv(const char *source, char *buf);

E void os_init(void);
E void load_os_dbase(void);
E void save_os_dbase(void);
E int is_services_root(User *u);
E int is_services_admin(User *u);
E int is_services_oper_no_oper(User *u);
E int is_services_admin_nick(NickInfo *ni);
E int is_services_oper(User *u);
E void os_remove_nick(const NickInfo *ni);


/**** process.c ****/

E int allow_ignore;
E IgnoreData *ignore[];

E void add_ignore(const char *nick, time_t delta);
E IgnoreData *get_ignore(const char *nick);

E int split_buf(char *buf, char ***argv, int colon_special);
E void process(void);


/**** send.c ****/

E void send_cmd(const char *source, const char *fmt, ...)
	FORMAT(printf,2,3);
E void vsend_cmd(const char *source, const char *fmt, va_list args)
	FORMAT(printf,2,0);
E void send_rcmd(const char *source, const char *fmt, ...)
	FORMAT(printf,2,3);
E void vsend_rcmd(const char *source, const char *fmt, va_list args)
	FORMAT(printf,2,0);	
E void wallops(const char *source, const char *fmt, ...)
	FORMAT(printf,2,3);
E void sanotice(const char *source, const char *fmt, ...)
	FORMAT(printf,2,3);
E void notice(const char *source, const char *dest, const char *fmt, ...)
	FORMAT(printf,3,4);
E void notice_s(const char *source, const char *dest, const char *fmt, ...)
	FORMAT(printf,3,4);	
E void notice_list(const char *source, const char *dest, const char **text);
E void notice_lang(const char *source, User *dest, int message, ...);
E void private_lang(const char *source, User *dest, int message, ...);
E void notice_help(const char *source, User *dest, int message, ...);
E void privmsg(const char *source, const char *dest, const char *fmt, ...)
	FORMAT(printf,3,4);
E void add_send_domain(char* string);
E void send_global(char* msg);

/**** sockutil.c ****/

E int32 total_read, total_written;
E int32 read_buffer_len(void);
E int32 write_buffer_len(void);

E int sgetc(int s);
E char *sgets(char *buf, int len, int s);
E char *sgets2(char *buf, int len, int s);
E int sread(int s, char *buf, int len);
E int sputs(char *str, int s);
E int sockprintf(int s, char *fmt,...);
E int conn(const char *host, int port, const char *lhost, int lport);
E void disconn(int s);


/**** users.c ****/

E int32 usercnt, opcnt, maxusercnt;
E time_t maxusertime;

#ifdef DEBUG_COMMANDS
E void send_user_list(User *user);
E void send_user_info(User *user);
#endif

E void get_user_stats(long *nusers, long *memuse);
E User *finduser(const char *nick);
E User *firstuser(void);
E User *nextuser(void);

E void do_snick(const char *source, int ac, char **av);
E void do_nick(const char *source, int ac, char **av);
E void do_join(const char *source, int ac, char **av);
E void do_part(const char *source, int ac, char **av);
E void do_kick(const char *source, int ac, char **av);
E void do_umode(const char *source, int ac, char **av);
E void do_quit(const char *source, int ac, char **av);
E void do_kill(const char *source, int ac, char **av);

E int is_oper(const char *nick);
E int is_on_chan(const char *nick, const char *chan);
E int is_chanop(const char *nick, const char *chan);
E int is_voiced(const char *nick, const char *chan);
#ifdef HALFOPS
E int if_halfop(const char *nick, const char *chan);
#endif

E int match_usermask(const char *mask, User *user);
E void split_usermask(const char *mask, char **nick, char **user, char **host);
E char *create_mask(User *u);

/**** stats.c ****/
E void saveDayStats(void);
E void loadDayStats(void);
E void end_of_day_stats(void);

/* strcache.c */
E int init_scs_cache(void);

/* match.c */
void irc_lower(char *str);
void irc_lower_nick(char *str);
#endif	/* EXTERN_H */
