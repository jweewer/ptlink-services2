		       (C) 1999-2000, PTlink Coders Team
		         http://www.ptlink.net/Coders/
			 
-------------------------------------------------------------------------------
 PTlink.Services 2.11.x                               	  - Lamego@PTlink.net-
-------------------------------------------------------------------------------
21 Aug 2000
(.1)
    Fixed smal bug generating null entries on history.log
    German and Turkish language files updated
    One more tab fix on english language file
    (Thanks to Cord and Talesin)
    Small improvement on /listnicks ouput (by Cord)

-= 15 Aug 2000 =-
* changelog documentation system changed
    CHANGES file will now be split in version ranges
    Old changes moved to ChangeLog
* removed ircd selection from configure 
    PTlink ircd capabilities now be negotiated between ircd and services.
* added services option to use PRIVMSG instead of NOTICE (ircdsetup.h)
    (suggested by cord@Wunder-Nett.org)
* updated portuguese language file
* small fix on OPERSERV VLINE syntax help
services.conf    
    removed TimeAdjust directive (TimeZone will do the job)
    added StatsOpersOnly to restrict STATS command 
	(suggested by winsome@zurna.net)
chanserv.c
    fixed chanserv description not beeing displayed when successor was set
    (reported by Talesin@TTnet)
nickserv.c
    fixed fatal bug on ./listnicks nick
    (reported by cord@Wunder-Nett.org)
