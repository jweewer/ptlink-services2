		       (C) 1999-2000, PTlink Coders Team
		         http://www.ptlink.net/Coders/

(.2) 06 Jan 20001
-----------------
channels.c
  improved SJOIN parsing (required for future protocol handling)
chanserv.c
  if channel successor is set to founder channel successor will be cleared
  (idea from ircservices)
  added "Expire: Never" info for noexpiring channels
  (suggested by WRaiTH <wraith@illegalcrew.org>)
init.c
  services clients introduction without PTS3 
nickserv.c
  fixed bug allowing anyone to see private nick info
  (reported by WRaiTH <wraith@illegalcrew.org>)
    
			 
(.1) 20 Dec 2000
-----------------
nickserv.c
    fixed NICKSERV SET KILL ability not matching NickChange option
    (reported by Uwe Pfeifer)
    fixed bug not showing last topic info for SAdmins
lang/
    added missing NOLINKS option on help for /ChanServ SET command
sendbug
    fixed to check for services.core
scripts/ftpwww.sh
    was not running as cron process because the gnuplot path was not found
    
11 Dec 2000
-------------------------------------------------------------------------------
 PTlink.Services 2.16.0                               	  - Lamego@PTlink.net-
-------------------------------------------------------------------------------
* added NSForbidAsGuest to force forbidden nickname to be changed to Guest..
* automatic recognition on nick change based on timestamp/usermask
init.c
    fixed missing SIGPIPE handling
    restored correct SIGSEGV handling with core dump
nickserv.c
    nicks starting with guestnnnn cannot be registered
------------------------------------------------------------------------------- 