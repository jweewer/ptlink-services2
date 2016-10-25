******************************************************************
*       http://www.ptlink.net/Coders - Coders@PTlink.net         *
******************************************************************


(.2) 10 Nov 2001
-----------------    
  What's new ?
  ---------------------
  Host prefix is now received from ircd (CAPAB PREFIX=)
  
  What has been fixed ?
  ---------------------
  Fixed a bug causing list{nicks,chans} -d <dir> to not work. 
  ( merged from ircservices)
  Invalid SJOIN syntax for chanserv after akick (reported by Alexxx)
  Fixed NICK_HELP_AJOIN string (reported by Alpha-]x[)
  Fixed chanserv AOP/SOP list
  removed case sense on access list (for nick match)
  SVSINFO current version set to 6

(.1) 21 Oct 2001
-----------------
  What's new ?
  ---------------------
  /OPERSERV RESET STATS	to resets operserv stats (!no help)
  Update done message on update request (suggested by Ma5ter_Z)
  
  What has been fixed ?
  ---------------------
  helpers/bots stats count
  extended /operserv stats to show helpers/bots count
  Added RECORD option to the English /OPERSERV STATS help
    
  PTlink.Services2.19.0 (23 Sep 2001)
==================================================================

  What's new ?
  ---------------------
  services will check services.pid process before starting
  services will not start if daystats file is not from today
  
  What has been fixed ?
  ---------------------
  replaced services JOINs with SJOINs
  OperServ is now "seen" on #LogChan to mark it as not empty
