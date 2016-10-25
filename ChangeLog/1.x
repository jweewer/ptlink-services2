-------------------------------------------------------------------
 PTlink Services - PTlink Coders Team - Lamego@PTlink.net
 http://www.ptlink.net/Coders/
-------------------------------------------------------------------
Subscribe the PTlink coders Mailing list,
mail to: majordomo@aac.uc.pt body: subscribe ptlink-coders
-------------------------------------------------------------------

16/01/2000
------------ PTlink Services 1.8.1
nickserv.c
	    fixed bug (was not saving logon time)
	    removed extra SVS2MODE +r on /nickserv ghost
	    do autojoin on ghost (this works)
chanserv.c
	    chanserv set password will now display new password
	    ACCESS LIST restricted to Services Admins
users.c
	    set +a (Services Admin flag) when a SADM does /oper
	    
12/01/2000
------------ PTlink Services 1.8.0
* On all files, time references add been adjusted to use TIMEDIF set
channel.c
	    total users and record trace added on joins/parts/quits
chanserv.c 
	    fixe info bug (some mlock modes were not shown)
	    on channel register set maxusers and maxtime
	    DFV_CHANSERV upgrade to 3 (new: channel user record)
	    added CHAN_INFO_RECORD and CHAN_INFO_USERS to chanserv info
	    only services operators will see user@host on access list
config.c
	    added SQlineDBName directive
init.c
	    load SQline database and set sqlines
main.c
	    save SQline database
messages.c
	    ignore SQLINE message from server
nickserv.c
	    on register, last quit time is equal to register time
	    upgraded data file version to 2 (new: last quit time)
	    added last quit time to nickserv info
send.c
	    add rsend to send message without :origin
extern.h
	    function definition was missing
	    add definitions for sqline.c
	    added SQlineDBName definition
services.h
	    added last_time field for user quit timestamp
setup.h
	    added TIMEDIF for time adjusting
lang/
	    changed nickserv info message last seen is now las identify
	    added last quit time message (en_us.l and pt.l)
	    added SQLINE list language strings
	    added CHAN_INFO_RECORD and CHAN_INFO_USERS string
Makefile
	    added sqline.c 
data/example.conf
	    added SQlineDB directive

21/12/1999
------------ PTlink Services 1.7.1
chanserv.c
	    should op deop and kick require identified nicks
	    (reduce recognized nicks permission for chanserv
	    chanserv SECURE set is not beeing used)
nickserv.c
	    inserted nick_restrict_identified(User *u) 
	    now nick_identified will also return true for +r users
	    only operserv will require nick_restrict_identified (password identified)
	    made status more verbose
services.h
	    added UMODE_R 
	    fixed UMODE_X (buggy bit mask)
lang/
	    inserted NICK_AUTORECON_R string
	    fixed e' error for pt.l strings
	    added NICK_STATUS strings
Configure
	    now default for IRC type is option 3 

19/12/1999
------------ PTlink Services 1.7.0
nickserv.c
	    disabled LINK command (buggy)
	    do not collide for RECOGNIZED nicks
operserv.c
	    was doing SVS2MODE on unzombie, should be SVSMODE
		so user cannot notice is being "unzombied"
users.c
	    disabled +r mode changes 	    
	    nick recognition on mode +r

11/12/1999
------------ PTlink Services 1.6.1
chanserv.c
	    fixed drop bug
	    optimized load
nickserv.c
	    clean channel name form invalid chars
	    display empty message on ajoin emply list
lang/
	    removed extra tab on a string
data/example.conf
	    added multi root syntax
	    
07/12/1999
------------ PTlink Services 1.6.0
chanserv.c
	    fixed chanserv kick (was not removing user from internal list)
	    op/deop/kick first check if target nick is being used
	    resorted levels list and inserted KICK level
	    implemented who added/changed for access list
	    database will log a warning on .db conversion
	    set user +a on chanserv register (suggested by Chucky3)
	    only founder nick can drop the channel 
memoserv.c
	    check form MEMOSEND level when sending channel memo
nickserv.c
	    AJOIN ADD/DEL is denied on read only mode
	    fixed memory leak for ajoin list on nick delete
operserv.c
	    added multi root support
services.h
	    inserted level CA_KICK
	    inserted level CA_MEMOSEND, changed CA_MEMO to CA_MEMOREAD
lang/
	    added KICK command/level messages
	    added MEMOREAD/MEMOSEND/MEMODEL messgas

22/11/1999
------------ PTlink Services 1.5.1
chanserv.c
	    fixed stats display bug
	    implemented ChanServ KICK 
nickserv.c
	    fixed stats display bug
	    fixed kill/nick change protection
stats.c
	    fixed bug (seg fault on old day stats file)
lang/
	    added FEATURE_DISABLED
FEATURES
	    upgraded


14/11/1999
------------ PTlink Services 1.5.0
config.c
	    inserted DayStatsFN, DomainLangFN
init.c
	    removed -log (was not working any more)
language.c
	    inserted language domain file support
main.c
	    inserted statistics save on main loop
nickserv.c
	    set language on identify and set_language
	    fixed ajoin (buggy with nick links)
operserv.c
	    fixed bug on clone kill
	    inserted gline support on clone kill
users.c
	    smart language set for user based on hostname
stats.c
	    implemented Save/Load for daily statistics
extern.h
	    inserted DayStatsFN, DomainLangFN
services.h
	    added domain to NickInfo	    
setup.h
	    defined user of GLINES for clone ban
	    inserted CLONEGLINETIME define
lang/
	    fixed some pt and en_us messages
version.sh
	    added PTlink ircd 3.4 version string
Configure
	    added PTlink ircd 3.4 option
data/example.conf
	    inserted DayStatsFN, DomainLangFN
data/domain.def
	    new file with domain language definitions

23/10/1999
------------ PTlink Services 1.4.0
users.c
	    removed dummy debug log
	    Buggy OperControl kill protection replace by Oper bounce
		protection. 
chanserv.c
	    fixed chanserv mlock modes display bug
nickserv.c 	
	    inserted /NickServ JOIN to make user join is ajoin list
operserv.c
	    global messages and is sender now go to log channel
Makefile
	    bug fix (logs dir. was beeing created on the wrong path)
lang/	
	    inserted NICK_HELP_JOIN,NICK_JOIN_SYNTAX,NICK_AJOIN_EMPTY


13/10/1999
------------ PTlink Services 1.3.2
chanserv.c
	    inserted support for chanmode +c e +K
nickserv.c
	    on set password display new password
operserv.c
	    fixed bug on load .dbs (was not reading max. user count)
stats.c	
	    inserted initDaySatts
users.c
	    do not kill oper when servicesadmin list is empty
include/services.h
	    inserted +c and +K mlock support
extern.h
	    inserted definition for initDayStats
services.h
	    inserted total services admins on stats
lang/pt.l
	    fixed some strings

------------ PTlink Services 1.3.1
chanserv.c
	    fixed listchans bug :P (crashing on forbidden chans)
config.c
	    includes setup.h
misc.c
	    inserted make_virthost code from PTlink ircd
services.h
	    inserted UMODE_X flag
	    inserted hiddenhost on user info
users.c
	    match_mask now handles +x masks (AKICK and UNBAN now
		work with +x users)
lang/
	    fixed some en_us strings

	    
 23/09/1999
------------ PTlink Services 1.3.0
configure.c
	    inserted NSDefAutoX
nickserv.c
	    implemented set AUTOX ON/OFF
	    nick with AUTOX set sends umode +x on identify
	    on nick registration check for NSDefAutoX
	    kill/nick change protection is defined in setup.h
operserv.c
	    OperControl feature is defined by setup.h
users.c
	    displays NICK_SHOULD_REGISTER when a unregistered nick connects
extern.h
	    inserted NSDefAutoX
services.h
	    inserted NI_AUTOX
setup.h
	    Allows to customize services :)
lang/
	    fixed some pt strings foun on en_us file
	    inserted NICK_SHOULD_REGISTER string
	    inserted CHANGE_IN_1_MINUTE to support both protection modes
	    pt.l spell checked by BadFile
data/example.conf
	    inserted NSDefAutoX	    
Makefile
	    inserted setup.h
	    

 21/09/1999
------------ PTlink Services 1.2.0
*WARNING* New Datafile format, you will not be able to use this db's with v1.1
akill.c
	    now checks if file was created before trying to write to akill db
	    fixed bug displaying null on default expiry time
botlist.c
	    implemented botlist ADD/DEL/LIST/VIEW and check functions
channels.c 
	    commented stupid code making double check for valid ops (my mistake)
chanserv.c
	    now services opers can always chanserv access list for any channel
	    just identified nicks can do identify for chanserv
	    check_valid_op will now take @ from opers and services admin
	    info will now display successor of channel
	    chanserv stats are only allowed to identified users
	    only ops or protected users will update last time seen on join
	    CLEAR is now also available for Services Admins
config.c
	    inserted BotListDBName
datafiles.c
	    new version scheme on write_file_version and get_file_version
init.c
	    makes OperServ join Admin and Log channels for security sake
	    load botlist
main.c
	    saves botlist when needed
messages.c
	    ignore PROTOCTL message to avoid error log
nickserv.c
	    nickserv stats are only allowed to identified users
operserv.c
	    if clone source is not in botlist, put a akill on the clone hostname
extern.h
	    included botlist.c functions
	    included BotListDBName
Makefile
	    included botlist.c on compilation
lang/en_us.l
	    inserted BOTLIST help strings
	    fixed 1 minute kill message for nick change
	    inserted successor info strings
lang/pt.l
	    fixed 1 minute kill message for nick change
	    inserted successor info strings
data/example.conf
	    inserted BotListDB entry
Config
	    Changed some default options
	     

 09/09/1999
------------ PTlink Services 1.1.1
stats.c
	    fixed ClearDayStats

 07/09/1999
------------ PTlink Services 1.1.0
chanserv.c
	    included statistics functionality for /ChanServ STATS
	    inserted log on giving helper mode (+h)
log.c
	    clears daily statistics on day change
nickserv.c
	    included statistics functionality for /NickServ STATS
services.h
	    inserted strutucure DayStats dor statistics storage
	    fixed bug not killing user exceeding NSMaxNChanges (I hope)
stats.c
	    support routines for statistics.
Makefile
	    inserted stats.c
lang/pt.l
	    fixed stats syntax error
	    

 03/09/1999
------------ PTlink Services 1.0.0
* Removed support for other networks
* Version number set to new independent version: PTlink Services 1.0.0
services.conf
	    LogChan		- channel to dump services log
	    AdminChan		- channel to join in /opers
	    HelpChan		- channel where @ will have +h
	    NSMaxNChange	- maximum forced nick changes
	    
botlist.c
	    some code to be used on botlist (TO DO)
chanserv.c
	    included umode +h for user with op access on #HelpChan
logs.c
	    date format changed
	    implemented function log2 to log to both file and channel
nickserv.c
	    nick kill protecion now changes nick to _nick-
	    cannot register _*- nicks
	    fixed bug on trying to register forbidden nick
operserv.c
	    do not allow oper from recognized nicks anymore,
	    just from identified nicks
config.c
	    included HelpChan, AdminChan, LogChan, NSMaxNChange
users.c	    
	    inserted chanlogs on user errors
	    make opers join AdminChan 
extern.h
	    included HelpChan, AdminChan, LogChan, NSMaxNChange
services.h
	    inserted nick change forced count on NickInfo struct
lang/en_us.l
	    inserted missing messages (were just in PT)
	    	    
%%%%%%%%%%%%%%%%%%%%%%%%%%% BEGINNING VERSION %%%%%%%%%%%%%%%%%%%%%%%%%%%
 09/08/1999
------------ v2.1.1
lang
	    damaged files... restored pt file 
	    inserted NICK_ALREADY_IDENTIFYED
nickserv.c
	    autojoin now works on ghost
	    inserted NICK_ALREADY_IDENTIFYED on repetead identifies
	    
	    
 08/08/1999
------------
nickserv.c
	    nickserv info displays last usermask only to services admins
	    extended chanlogs
chanserv.c
	    extended chanlogs	    

 04/08/1999
------------ v2.1
encrypt.c
	    implemented JP1 encryption
services.h
	    inserterd CMODE_r and CMODE_R
configure
	    replaced MD5 encryption with JP1 encryption option
	    inserted some chan_logs	    	    
memoserv.c
	    fixed do_ghost (now makes +r on ghost identify)
chanserv.c
	    ignore CHAN SECURE SET, 
		just recognized or identified nicks get automodes on join
	    mlock now supports +R mode
	    inserted check_should_deop
	    inserted some chan_logs
channels.c
	    inserted support for CMODE_R and CMODE_r
	    check_modes now puts +r and supports +R mode
extern.h
	    inserted check_should_deop definition
	    inserted chan_log definition
log.c
	    implemented chan_log
	    
 03/08/1999
------------
syscong.h
	    defined ENCRYPTION and ENCRYPT_IRC
chanserv.c
	    inserted channels founder name on ./listchans
 
 01/08/1999
------------ 
nickserv.c
	    fixed bug on load_ns_dbase :P, on listnicks was logging to no file

 29/07/1999
------------ v2.0a
nickserv.c
	    removed SVSJOIN logging
messages.c
	    inserted SVSJOIN ignore filter

 27/07/1999
------------ v2.0
extern.h     inserted NSJoinMax
config.c     inserted NSJoinMax on configuration file
nickserv.c   inserted set autojoin option	   
	     inserted autjoin on identify (when AUTOJOIN is on)
	     database version number set to 8
	     for files version<8, initialize autojoin list (just in load_ns, not for old)
	     save_ns and load_ns now save/load autojoin list
Makefile     install now creates /logs directory inside binary directory
lang/en_us.l added AJOIN help messages
services.h   inserted CHANMAXLEN to limit channel name length on autojoin list
akill.c,operserv.c,news.c,chanserv.c - fixed support for data file version 8

 26/07/1999
------------
memoserv.c - removed (never used) set clean function
services.h - reaplaced (never used) NI_MEMO_CLEAN with NI_AUTO_JOIN
nickserv.c - inserted do_ghost_release (now ghost also makes release when needed)
	     changed nick kill forcing from validate_user to load_ns_database
	     valid_user security improvement (access user are killed with secure on)
	     inserted do_set_autojoin to set AUTOJOIN nick flag
language.h - replace memoserv SET CLEAN messages with nickserv SET AUTOJOIN messages
lang/index - replace memoserv SET CLEAN messages with nickserv SET AUTOJOIN messages
lang/pt.l  - replace memoserv SET CLEAN messages with nickserv SET AUTOJOIN messages

 19/07/1999
------------ v1.6a
nickserv.c - fixed on nick kill enforced message portuguese error
operserv.c - changed is_services_oper  to allow recognized opers

 18/07/1999
------------ 
operserv.c - inserted chatops notice and check for nick existence on zombie and unzombie
		    
 15/07/1999
----------- v1.6
operserv.c - implemented do_zombie and do_unzombie 
lang/index - inserted OPER_HELP_ZOMBIE and OPER_HELP_UNZOMBIE
lang/pt.l  - inserted OPER_HELP_ZOMBIE and OPER_HELP_UNZOMBIE
messages.c - fixed raw numbers support to error 401

 11/07/1999
----------
lang/pt.l  - extra message on channel register showing SUCCESSOR syntax
language.h - inserted OPER_HELP_ZOMBIE and OPER_HELP_UNZOMBIE

 10/07/1999 
---------- v1.5
services.motd - inserted version information

 07/07/1999
----------
nickserv.c - inserted SVSMODE -r nick on do_drop
log.c	   - logs files now go to ./logs directorty
messages.c - extend messages ignore supported (NEWHOST and 403 errors)

 01/07/1999
----------
users.c	   - /oper now requires to be services oper
lang/pt.l  - fixed OPER_IDENTIFY_REQUIRED msg

 28/06/1999
----------
lang.h	   - inserted OPER_IDENTIFY_REQUIRED def
users.c	   - umode +o now have to be done by identified nicks
	             Now logging +o umodes
init.c 	   - services clients now using +S umode protection 

 26/06/1999
----------
lang/pt.l  - fixed spelling 

 19/06/1999
----------
nickserv.c - removed kill protection set option
	   - inserted on kill hard coded message
lang/pt.l  - inserted some helping extra lines

 30/05/1999
----------
misc.c	   - optimized memoserv read bug(001) patch
lang/pt.l  - fixed language errors and changed KILL option information (now forced)
	   - extended memoserv SEND info (for read acknowledge)
send.c	   - inserted private_lang function
language.h - new message ON_KILLPROTECTION
lang/index - new message ON_KILLPROTECTION
extern.h   - inserted new functions definition
nickserv.c - autoidentify and SVSNICK on ghost

 23/05/1999
----------
misc.c	   - fixed memoserv frezzing bug(001) (/memoserv read nnnnnnnnnn)
messages.c - extented non standard messages support (error logging reduced)

 15/05/1999
----------
nickserv.c - forced kill protection
memoserv.c - included SET CLEAN support (functionality not implemented)
laguange.h - include SET CLEAN messages
language.h - new messages for SET CLEAN
lang/index - new messages for SET CLEAN

 14/05/1999
----------
memoserv.c - fixed (LIST NEW on check for memos)
	     inserted ? on front of message to implement read acknowledge
services.h - inserted NI_MEMO_CLEAN

 12/05/1999
----------
language.h - added NICK_AUTORECON language entry
users.c    - on nick change do mode -r or notify nick recognition
nickserv.c - inserted mode +r on identify and on register
memoserv.c - inserted auto LIST NEW on check for memos
log.c      - implemented rotated log filename (Services_%date%.log)

 xx/04/1999
----------
Inserted new ChanServ level PROTECT to use EliteIRCd chanmode +a

