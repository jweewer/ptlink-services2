******************************************************************
*       http://www.ptlink.net/Coders/ - Coders@PTlink.net        *
******************************************************************
 * $Id: 2.24.x,v 1.1 2004/05/20 22:59:58 jpinto Exp $

(.1) 26 Mar 2004

  What has been fixed ?
  ---------------------
  Broken username/host split on ns_save with mysql support
  Incorrect total/registered counts on chans/nicks (Thanks to Andew Church)
  Breaking ANSI C on mysql.c (Reported by Brito)
  NSMaxNChange was not working with the SVSGUEST code

  PTlink.Services2.24.0 (07 Mar 2004)
==================================================================

  What's new ?
  ---------------------
  Added -dbinit to build mysql DB (back ported from ircsvs3)
  Use new raw SVSGUEST for guest nick generation
  Services Name changed from blabla server to blabla service on 
    configuration

  What has been fixed ?
  ---------------------
  Removed broken crypt() detection
  Broken compile for "make import-stdb"
  We now use the nick table from ircsvs3
  Some extra operchecks on chanserv/nickserv commands
  ChanServ LOGOUT has got some syntaxes
  Channel check on protect now works correct
  Updated pt_br language files (thanks to Rodrigo Teles Calado)


  
