		       (C) 1999-2000, PTlink Coders Team
		         http://www.ptlink.net/Coders/

-------------------------------------------------------------------------------
 PTlink.Services 2.10.x                               	  - Lamego@PTlink.net-
-------------------------------------------------------------------------------
5 Aug 2000
(.2)
    Fixed fatal bug when /nickserv notes was used by a non identified nick
    (bug repported by Talesin@TTnet)
    Fixed bug causing wrong update of last identify time instead of last seen
    time on kills, online time is now also updated on user kill.
    
4 Aug 2000    
(.1)
    german language file updated (thanks again to Cord Beermann)
    nick total online time is now updated on nick change
    mlock will now handle correctly +c,+K chanmodes
    (reported by winsome@zurna.net)
    - Fix for bugs repported by Talesin@TTnet  -
    hardcoded OperServ join on init replaced  by operserv nick
    services will now handle SAMODE
    

03 Aug 2000
* Added german language file, thanks to Cord Beermann <cord@Wunder-Nett.org> 
* Added "ago time" to chanserv/nickserv info date fields
config.c
    added TimeZone setting to override running Time Zone for services
init.c
    operserv will now join admin channel
log.c
    changed log message on log rotation
messages.
    added support for short mode message "UMODE"
newsserv.c
    added news export feature (new NewsServ .conf settings)    
operserv.c
    added oper suspensions (/OPERSERV OPER SUSPEND)
nickserv.c
    removed Nick KILL protection info when using NickChange
    check for ';' or ',' on email field
    Nickserv Info extensions
    - Total online time
    - ICQ number
    - Location
users.c
    fixed bug creating session ghosts on services kill
    removed "+r recognition" message
sqvline.c
    Adding q/v line with an existing mask will overwrite old line.    

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 PTlink.Services 2.9.x                               	 
...............................................................................
23 Jul 2000
(.3)
    Fixed fatal bug registering nick with NSNeedEmail unset.
    Optimized m_sjoin perfomance:
	removed repeated channel lookups
	ignore received modes conforming with TS3 protocol
	
16 Jul 2000    
(.2)
    Fixed clone protection syncronization problmens
    
02 Jul 2000
(.1)
    fixed bug on SET PASSWORD causing passwords to be merged
    (reported by yahya@kanunsuz.net and Talesin@TTnet)
    SAdmins will only autojoin #services.log if they use AUTOJOIN on
    fixed no such user error on Clone KILL activation    
    optimized clone protection logging
    
29 Jun 2000
* Default language is now defined via DefLanguage (services.conf)
* Fixed broken VLineDB directive on example.conf
+ Added TimeAdjust functionality to services.conf
+ Added expiring nick mailing system script and install documentation.
 (mailing script using perl from Shadow@PTlink.net)

ChanServ
--------
    Rearranged AKICK LIST output
    (suggested by KoRSaN@TTnet)

OperServ
--------
    Added NICKLINK so sadmins can create nick links
    (suggested by Talesin@TTnet)
    OperServ now joins #services.log to enforce security 

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

 PTlink.Services 2.8.x
...............................................................................
 
17 Jun 2000
* Removed parse check for '@' on hostuser during /OPERSERV REHASH
* Fixed handling for merged +l/+k chan modes
+ Passwords encryption method change via services.conf
+ Auto join on Log channel for Service Administrators
+ Mail list for near expiring nicks (./listnicks -e days)
- Removed AutoSetSAdmin (should always be used)


ChanServ
--------
    Akicks will expire when inactive (CSLostAKick on services.conf).
    fixed bug causing access list to get corrupted on foundership transfer
    Removed topic info from +s mlocked channels

NickServ
--------
    Added logging to link/unlink commands.
    
OperServ
--------
    Added /OPERSERV SESSION TRACE host to list all users from a given host
    
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    
 PTlink.Services 2.7.x
...............................................................................
7 Jun 2000
(.1)
    nick changes only on case or linked nicks auto recognition
    implemented new auto identify on ghost mechanism

1 Jun 2000
* Fixed Helper attribution (bots are no longer helpers)
* Fixed bug on access list lost entries causing segment fault
  (reported by winsome@zurna.net)
* unknown messages will now be sent to log channel
+ HTML services manual
  (thanks to kript0n@antionline.org)
+ Support for PTlink5.x (using PTS3 protocol)
+ Added turkish language file
  (thanks to chaos@chaos.gen.tr from TTnet)
+ Server version display on server connects
+ sqvline dependency check on Makefile
+ OPERSERV VLINE list for PTlink5.x
- Check Clones (Session limit does the job)
- removed Bahamut support
- removed Unreal ircd support

NickServ
--------
    max notes expand (if applicable) during nickserv load
    error on total nicks mismatch replaced with warning log

OperServ
--------
    added V-Lines to sqline.c and file was rename to sqvline.c
    
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

 PTlink.Services 2.6.x
...............................................................

17 May 2000
(.1)
* Fixed buffer overflow on nick collisions 
    (reported by wins@zurna)
* Fixed linked nick possibe hacking
    (reported by talesin@TTnet)
* fixed need for . on email checking

04 May 2000
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
* Fixed Smart Language Selection 
    (what the hell happened with it??,
    must use the new domain.def file)
* chanserv/nickserv private info is now allowd to services opers
    (suggested by Talesin@TTnet)
* optimized m_join (why was used more than one channel find ???)
* removed options.h (settings moved to services.conf)
* added session limiting 
    (code ported from ircservices -Andrew Kempe)
* added log on password changes
* fixed problem on cofigure where test include hanged on some OSs

NewsServ
--------
    Changed RECENT/VIEW command to private messages
	(suggested by skunk@PTlink)
NickServ
--------
    added syntax display for STATUS when no nick was specified
    (suggested by Bytor@Dynamix)    
    enforced email validation (now must include ".")
    even non registered nicks can set services language now
    
ChanServ
--------
    added ALL option to ChanServ AKICK/ACCESS DEL (founder only)
	(sugested by Dark_Elf@TTnet)
    display channel URL on join using numeric 328
    sucessor and founder cannot be set the same

Lang
--------
    Added CHAN_ACCESS_CLEARALL/CHAN_AKICK_CLEARALL strings
    Added ALL option to ACCESS/AKICK help    
    Added NICK_STATUS_SYNTAX

 PTlink.Services 2.5.x
...............................................................
13 Apr 2000
(.1)
    fixed fatal bug on nickserv.db load (reported by Talesin@TTnet)
    fixed modes display on mlock for +O/+A modes
    fixed operserv help errors (reported by Talesin@TTnet)

NickServ
--------
    any user can use LISTLINKS for their own nick 
	(suggested by SIGMA@PTlink)
    Added NOTES storage 
	/NickServ NOTES ADD text | DEL number | LIST
    added .db load integrity check with number of nicks field
    
OperServ
--------
    Added /OperServ REHASH to reload services.conf
	(suggested by Bytor@Dynamix)
	    
Lang
--------
    Added NOTES strings
    Added LISTLINKS and NOTES to NickServ HELP    
    Added BOTLIST and REHASH to OperServ HELP (suggested by Bytor@Dynamix)
    Added REHASH strings
    
BUG FIXES:	
    akick who added nick was not removed when nick expired
    identify flag not cleared on linked nick change 
	(reported by Talesin@TTnet)
    listnicks/listchans fatal bug causing Seg Fault    
    
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


 PTlink.Services 2.4.x
...............................................................

08 Apr 2000
-----------
* Magick-1.4 databases import (experimental)
  ( use command line argument -Magick-1.4 )
* added UNREAL 3.0 compatibility
* added NWRecentDelay configuration directive to prevent
  NewsServ flooding
  
Chanserv
--------
    added who added nick on AKICK LIST
    added mlock support for channel modes +A/+O
    fixed +r bug (was set on unregistered channels)
    +r is now set on channel registration

Lang
--------
    added NEWS_REC_PLEASE_WAIT string

 PTlink.Services 2.3.x
...............................................................

(.2)
    fixed subscribe/unsubcribe bug
    removed some extra tabs on lang files
(.1)
    fixed mode buffering overflow on CLEAR BANS (reported by Taslesmin)
    fixed extra modes sent on nick join (reported by Talesin)
    added mode +r on channel creation
    fixed enforced mlock +R/+k/+i bug 

31 Mar 2000
-----------
* Fixed bug on NEWS support
* Added -Magick-1.4 command line option to load Magick-1.4 database
 (still experimental, only nickserv conversion is implemented)

ChanServ 
--------
    Added SET NOLINKS to disable linked nicks access list recognition
    mlock +R/+k/+i works now for empty channels using kick/ban
    
OperServ
--------
    Added virtual host display to Clone Warning (suggested by Dark_Elf)

NewsServ
--------
    Implemented ALL option for SUBSCRIBE/UNSUBSCRIBE

Lang
--------
    Added CHAN_SET_NOLINKS* strings and 
	CHAN_HELP_SET_NOLINKS,CHAN_INFO_OPT_NOLINKS
    Added LISTLINKS to SAdmins NickServ Help
    Added ALL option to subscribe/unsubscribe help strings
    Added CHAN_NEED_REGNICK and CHAN_MODE_PROTECTED kick reasons
    
    
 PTlink.Services 2.2.x
...............................................................

                *** ALWAYS check options.h ***
25 Mar 2000
-----------
NewsServ integration with PTlink ircd 3.6.x
Removed ircii helpserv files
Need of email on nick registration is now define on services.conf

ChanServ
--------
    PRIVATE will hide all channel info
    Only sadmins can see last usermask of founder/sucessor
    Added DROP nick NOW for service admins
    
NickServ
--------
    PRIVATE will hide all nick info
    Added DROP nick NOW for service admins
    
Lang
--------
added NICK_INFO_PRIVATE,CHAN_INFO_PRIVATE 


 PTlink.Services 2.1.x
...............................................................
23 Mar 2000
-----------
Compatibility with Dalnet Bahamut ircd 1.2.2-release 
    (lots of services features not available)
WARNING: Not compatible with PTlink ircd version below 4.x
Nick links are working again 100% (I hope :P)
Implemented drop delay
    nicks/chans will just drop some (configured) time after
    the DROP command as been issued, identify for the
    nick/chan during that time will cancel the "DROP".
Implemented CSRegExpire and NSRegExpire
    nicks/chans registered and never used can have a shorter
    expire time.
Opers/Helpers/Bots statistics, check /OPERSERV STATS RECORD
Reduced multi language support to english and portuguese.
ChanServ/NickServ stats history saving.
Important messages sent via SANOTICE

NewsServ
--------
New service for online news broadcasts.
    
ChanServ
--------
chan modes buffering (+-ovav)
    modes will be stacked in the same line 
    according to the ircd capability
IRC Operators will not be deoped on SECUREOPS channels
    - suggested by Datcrack
forbidden nicks cannot be used on set successor/founder
removed SET SECURE option (no use without nick access list)


NickServ
--------
removed access list recognition support
New REGISTER syntax is : /NickServ REGISTER password email
    - suggested by HakOmaN
email field validation (must have @)    
removed /NICKSERV SET AUTOX
replaced /NICKSERV JOIN with /NICKSERV AJOIN NOW

OperServ
--------
fixed GLOBAL bug, (buffer overflow with a message>256)
implemented /OPERSERV STATS RECORD

