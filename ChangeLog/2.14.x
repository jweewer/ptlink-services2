		       (C) 1999-2000, PTlink Coders Team
		         http://www.ptlink.net/Coders/

18 Nov 2000
(.3)
* version info changed to file version.info (sharing purpose)
* fixed bug on turkish help file causing services to crash
* fixed bug on /MEMOSERV INFO for forbidden channels
* added crontab script (cron/serviceschk)
( reported by Talesin@TTnet )

03 Nov 2000
(.2)
* added extra security requiring user to be oper to have services privileges
( suggested by Seth <seth@berkbilgisayar.com> )
* fixed bug not allowing operserv to join log/admin channel with IRCd 5.6.2
( reported by WaXWeaZLe )
* operserv admin count synchronization fix
* fixed compile error when crypt() is not available

27 Oct 2000
(.1)
* fixed fatal bug allowing password buffer overflow with plain text passwords
* added support for crypt() on password encryption methods

24 Oct 2000
-------------------------------------------------------------------------------
 PTlink.Services 2.14.0                               	  - Lamego@PTlink.net-
-------------------------------------------------------------------------------
* fixed .preinstall script error aborting "make" process
* added import .stdb (services text data base) compatibility 
* configure will now detect sendmail on RH distributions
* updated operserv help
* existing security rule denying oper privileges on +r recognition
  was moved to .conf option OSNoAutoRecon
* added core dump force with kill -SIGUSR2 
* removed untested magick .dbs load code
* removed running group install option
* fixed some erroneous info on example.conf
  (reported by Jason DiCioccio - jasond@epylon.com)
-------------------------------------------------------------------------------
services.h
    fixed chanserv mlock for +d/+q overriding modes
import/
    HOW-TO
    ircservices4.4.8_stdb.patch - .stdb generation from ircservices4.4.8     
    epona-1.2.3_stdb.patch - .stdb generation from epona-1.2.3
botlist.c
    max connections added to LIST output
    adding an existing host will overwrite the existing entry
chanserv.c
    fixed bug not displaying last topic/setter on chanserv info
nickserv.c
    fixed possible pointer corruption on nick drop execution
operserv.c
    added /OperServ GETFOUNDER #chan to get founder access level on channel
