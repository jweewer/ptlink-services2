******************************************************************
*       http://www.ptlink.net/Coders/ - Coders@PTlink.net        *
******************************************************************
(.6) 27 Mar 2003
  What has been fixed ?
  ---------------------
  mlock/clear modes now supports +B/+K chanmode (^Stinger^)
  language files clean up  (^Stinger^)
  newsserv introduction collision check (^Stinger^)
  akill should send kill with the reason (^Stinger^)
  default language 5 for very old dbs is LANG_EN_US (^Stinger^)
  some newsserv message fixes (^Stinger^)
  user mode +r is now removed on sadmin drops (^Stinger^) 
  channel mode +r is now removed on channel drop (^Stinger^)
  translated de.setemail, de.auth (Semir)
  channel founder can see info even when private is set (dELUXE)

(.5) 16 Feb 2003
  What has been fixed ?
  ---------------------
  missing HIDDEN_HOST code breaking ChanServ UNBAN (reported by semir)
  only report successfull unban if a ban is removed (suggested by delman)
  don't show nickserv info "nick is private" for sopers (suggested by scratcher)

(.4) 04 Feb 2003
  What's new ?
  ---------------------
  NickServ SET NEWSLETTER ON/OFF (will be used for newsletter mailing)

  What has been fixed ?
  ---------------------
  OPNOTICE was not shown on chanserv info (reported by scratcher)
  removed extra %s from en_us.setemail (reported by ozan)
  added akill and bot list check for the spoofed hostname
  Added IRCDNICKMAX to ircdsetup.h (should be 21)
  removed the old web_interface

(.3) 4 Dec 2002
  What has been fixed ?
  ---------------------
  incorrect notice for people using NOMAIL (reported by scoutmirim)
  improved balance stats graphs (nicks.plot)
  AKILL ADD for an existing mask should replace it (reported by semir)
  ircdsetup.h/ZOMBIE msgs cleanup
  avoid GETPASS on forbidden nicks (reported by kayosse)
  added log for nickserv SET functions
  report requested email for opers when NSNeedAuth is on (kil)
  make sure we reset the +a when deopering (reported by network)
  services now compile on HP-UX11.11

(.2) 19 Nov 2002
  What has been fixed ?
  ---------------------
  nick suspensions deny the nick utilization
  the online detection was messing with auto-identify (reported by openglx)
  MySQL lib is now searched at lib/mysql
  added CHAN_LEVEL_MAX/MIN to config.h (suggested by rapaz-_-maluko)
  strupper() and strlower() broken with gcc3 optimization (^Stinger^)
  some nick suspension related bugs (reported by ^Stinger^)
  NSFordbidAsGuest is now hardcoded
  ignore ZLINE/UNZLINE server messages (reported by semir)
  forbidden nicks should not get new memos (reported by ^Stinger^)

(.1) 11 Nov 2002
  What has been fixed ?
  ---------------------
  old nick seen as online after nick change (reported by KayOssE)
  some typos on subscribe related message
  removed SCS stuff (^Stinger^)
  buffer overflows and invalid format strings AUTH related (Thanks to DZEMS)
  import-stdb now sets default options for nicks/chans (Thanks to openglx)

  What's new ?
  ---------------------
  NSRegisterAdvice to enable/disable nick registration advice (Armando Ortiz)

  PTlink.Services2.22.0 (26 Oct 2002)
==================================================================

  What's new ?
  ---------------------
  Nick suspensions (suggested by Arcan Özgür)
  AUTH system for emails (requested by Ozan)
  SendFromName to specify the sender name

  What has been fixed ?
  ---------------------
  added encrypted passwords support on ircservices stdb patch
  NOEXPIRE is now removed on ADMIN DEL (^Stinger^)
  listchans -s fatal bug (reported by Ozan)
