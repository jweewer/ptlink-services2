		       (C) 1999-2000, PTlink Coders Team
		         http://www.ptlink.net/Coders/

17 Sep 2000
(.1)
  Updated german language file
  Fixed turkish language file causing services crash on akick del
  Added CSAutoAjoin to .conf to make on register channel ajoin optional
  Added TODO file

-------------------------------------------------------------------------------
 PTlink.Services 2.12.x                               	  - Lamego@PTlink.net-
-------------------------------------------------------------------------------
16 Sep 2000
* Removed segmentation fault handling to force core dump
* Added sendbug script to send bug reports
* Added setenv function check to configure
  (was giving problems on Solaris)
* Added AutoJoinChan directive on services.conf to force 
  all users join a specific channel on connect
chanserv.c
    on register channel will be added to autojoin list if possible
    OPNOTICE is now sent only to channel ops
    AKICK target restricted to masks
    (i hope this fixes the bug on akick managment)
    Added ChanServ AOP/SOP alias for access list managment.
    (Suggested by Talesin@TTnet)
    Fixed exploitable bug on OP/DEOP from original ircservices
messages.c
    fixed broken server time reply
    (reported by Talesin@TTnet)
