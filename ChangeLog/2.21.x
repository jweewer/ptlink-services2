******************************************************************
*       http://www.ptlink.net/Coders/ - Coders@PTlink.net        *
******************************************************************

(.5) 11 Sep 2002

  What's new ?
  ---------------------
  .stdb export option on listnicks/listchans (-s option)

  What has been fixed ?
  ---------------------
  client umodes changed to "+o", there is a bug causing ircd to
  crash when they just use "+rp".
     (Thanks to semir for the long time testing this problem)
  import-stdb compile error (was broken with mysql support)
  import-stdb now supports MD5 encrypted passwords

(.4) 04 Sep 2002

   What has been fixed ?
   ---------------------
   bug on import-stdb (reported by openglx)
   added HelpServ on introduce_user
   wrong string format on /chanserv list (reported by openglx)
   LocalAddress was not being used (reported by semir)
   Added configure.cygwin (to use with cygwin, patch by openglx)

(.3) 29 Jun 2002

  What has been fixed ?
  ---------------------
  'z' mode parsing (^Stinger^)                           	
  NOEXPIRE was beeing reset and not set on ADMIN ADD (^Stinger^)
  update OPERSERV HELP (reported by micivoda semir)     		
  s_DevNull being used even when undefined (reported by RebuM)
  completely removed unused unused IrcIIHelpName/DevNull
  access list "who" is now updated on access change
  bypass mysql export code when MySQLDB is not defined
  buffer_mode modes buffer override (reported by kil)
  
(.2) 24 Jun 2002

  What's new ?
  ---------------------
  NOJOIN option on /nickserv identify to disable ajoin list entry

  What has been fixed ?
  ---------------------
  removed duplicated send( from notice() (reported by ma5ter_z)
  Moved MySQL connection configuration to services.conf (MySQL*)
  adding a nick to the services admins list will set NOEXPIRE

(.1) 23 Jun 2002

  What's new ?
  ---------------------
  import-stdb for epona-1.4.11

  What has been fixed ?
  ---------------------
  received services nicks will be ignored
  removed oper flag from services (they don't need it)
  fatal bug on import-stdb load_nicks (reported by opengfx)
  stats.today is now saved at end_of_day()
  collapse() is now used on placed akicks (ircd compatibility)
  fixed a fatal bug on send.c
   (found by Aristotles)

  PTlink.Services2.21.0 ( 4 Apr 2002 )
==================================================================

  What's new ?
  ---------------------
  nick info save to a MySQL database
  import-stdb patch for ircservices-4.5.39
  extended nickserv info
  
  What has been fixed ?
  ---------------------
  MD5 is now the default for passwords
    (security first)
  german typos (contributed by Cord Beermann)
  fixed a bug when reading founderless channels  
  fixed possible segfault on check_password() (reported by Georgi)
