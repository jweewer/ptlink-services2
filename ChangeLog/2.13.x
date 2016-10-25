		       (C) 1999-2000, PTlink Coders Team
		         http://www.ptlink.net/Coders/


03 Oct 2000
(.2)
"make install" will now kill running version and start the new version
Stripped "Quit:" empty messages from nickserv info (suggested by nexus@TTnet)
Optimized chanserv/nickserv do_register code
Added missing mlock support for modes +S/+d/+q
Added .conf CSRestrictReg, restricts /ChanServ REGISTER to services Opers
(suggested by Cord Beermann)


28 Sep 2000
(.1)
Fixed JUSTMSG option (patch from Cord Beermann)
German language file and update and english fix (Cord Beermann) 
Fixed small bug on SENDPASS
Added (forgoten) MailSignature directive to example.conf

27 Sep 2000
-------------------------------------------------------------------------------
 PTlink.Services 2.13.x                               	  - Lamego@PTlink.net-
-------------------------------------------------------------------------------
* Added NSSecureAdmins to protect SADM nicks (suggested by Nadi OZTURK)
* Added php3 script to to output newsserv news to web (by dragon@PTlink.net)
chanserv.c
    Added should add to ajoin msg, on channel registration
init.c
    Replaced hard coded protocol negotiation
memoserv.c
    Added memo preview on /MemoServ LIST
operserv.c
    Added /OperServ SENDPASS nick, code from Epona services
users.c
    Extended SJOIN protocol to support '.' as chan admin symbol
-------------------------------------------------------------------------------