		       (C) 1999-2000, PTlink Coders Team
		         http://www.ptlink.net/Coders/
(.2) 03 Mar 2001
lang/
    Added italian languague file
    (credits to Night_Haw Antonio Radici, sent by Pietro Femmino)
chanserv.c
     IRC Opers cannot be kicked with ChanServ
     (suggested by coconut69)

(.1) 21 Feb 2001
----------------
Makefile
    new services will just be launched if there are  services 
    running at the install dir (suggested by Bytor at Dynamix.com)
botlist.c
    allow for *,? botlist entries (suggested by Bytor at Dynamix.com)
init.c
    added missing prefix setting mode +o for services clients
nickserv.c
    improved email field validation
users.c
    sadmins will not join LogChan when connecting from bot list

18 Feb 2001
-------------------------------------------------------------------------------
 PTlink.Services 2.17.0                               	  - Lamego@PTlink.net-
-------------------------------------------------------------------------------
* added MD5 encryption support for passwords
* added WebHost for integration with Web Services interface
* added Web interface (adapted from http://www.awesomechristians.com/user/)
channels.c
	fixed bug where +s was not locked
chanserv.c
	added "from nick" to set founder log
nickserv.c
    autojoin is not used for bot entries identifies
users.c
    removed some extra messages for bot clients
------------------------------------------------------------------------------- 