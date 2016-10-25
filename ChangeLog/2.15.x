		       (C) 1999-2000, PTlink Coders Team
		         http://www.ptlink.net/Coders/
08 Dec 2000
(.3)
* Fixed bug on SJOIN parsing

05 Dec 2000
(.2)
* Fixed bug on memo expire for unreaded memos
( Reported by Bytor@Dynamix.com )
* Fixed problem with signal handling 
( fix on ircservices ML from Andy Smith <andy@strugglers.net> )

29 Nov 2000
(.1)
* Fixed bug causing seg. fault with glibc2.2 systems (RH7,etc...)
 ( reported by pivot <mercanah@boun.edu.tr> )
* Fixed example.conf typo error
 ( reported by Brandon Florin <bran@tierone.net> )
* Code cleanup to avoid some warnings on newer gcc
* default services.conf is now installed when not found

26 Nov 2000
-------------------------------------------------------------------------------
 PTlink.Services 2.15.0                               	  - Lamego@PTlink.net-
-------------------------------------------------------------------------------
* /OperServ BOTLIST command replaced with /OperServ BOT
* fixed some ircdsetup.h compatibility settings (reported by Madinfo_)
* added scripts/ftpwww.sh script to generate graphs from history.log
  using GNU plot (http://freshmeat.net/projects/gnuplot/download/)
  live samples at http://www.ptlink.net/servicesstats/
* fixed sendbug problems with sh on some systems
-------------------------------------------------------------------------------
botlist.c
    warn and forbid the use of *,? on bot list host names
memoserv.c
    fixed memoserv crash with forbidden channels for all commands
    (reported by WaXWeaZLe <waxweazle@kippesoep.nl.com>)
nickserv.c
    fixed bug using /nickserv listlinks with and unregistered nick
    (reported by Kabouter)
-------------------------------------------------------------------------------    