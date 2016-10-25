******************************************************************
*       http://www.ptlink.net/Coders/ - Coders@PTlink.net        *
******************************************************************
 * $Id: 2.23.x,v 1.1 2003/09/03 09:50:30 stinger Exp $
(.6)
  What has been fixed ?
  ---------------------
  Wrong given notice on sadmin doing ChanServ password set
  Wrong given notice on operserv sendpass, that used NickServ
   instead of OperServ
  Again some helpsystem updates
  Forgotten mode clear on OperServ
  +r was set on last access recognition for non authenticaded emails (reported by net)
  
(.5) 30 Jul 2003

  What has been fixed ?
  ---------------------
  Yet another bug on NickServ SET for sadmins
  bug #59: private channel information patch
  Fixed strange bug on operserv stats, with something else then ALL it
   gave stats and unknown option  
  bug #74: hidden should be shown to the nick owner
  When private option is set the nick will get +p on identify
  bug #60: nicks with LIST level should be able to see private info
  bug #44: nicks are now able to delete their own access on the channel
  bug #27: CHANSERV KICK cannot be used on +a users from non +a users
  bug #21: Chanserv requests identify before allowing to set channel password
  some helpsystem updates

(.4) 13 Jul 2003
  What has been fixed ?
  ---------------------
  Fatal bug on NickServ SET without parameters

(.3) 12 Jul 2003

  What has been fixed ?
  ---------------------
  GuestPrefix nick's registration disabled
  check if nick is on channel before kick/op/deop (patch from FerGeCo)
  Helpserv has been removed
  bug #12: operserv can kick his self (patch from FerGeCo)
  bug #69: Set location (patch from FerGeCo)

(.2) 23 Jun 2003

  What's new ?
  ---------------------
  CHANSERV LOGOUT to remove founder privileges from identified channels
  
  What has been fixed ?
  ---------------------
  non identified nicks could get "new memo" notices (from ircservices)
  akick delete comestic fix
  improper input validation for SXLINE commands
  After a forbid the db would stop loading (SUID issue)
  "install" will now correctly check if services are running
  Added total registered chans to chanserv db
  Removed "end of hash chain" byte from nickserv db
  Removed alphabetical order on Nicks/Chans inserts
  Improved nickserv/chanserv hashing
  Removed some gline code on forbidden channels
  Added missing memory free for some fields on delnick()/delchan()
  Fixed get_user_stats endless loop
  mlock on +N gave unknown char, due to missing break    
  
(.1) 01 Jun 2003

  What's new ?
  ---------------------
  GuestPrefix on services.conf (suggested by duck) 
  Added +N to mlock
  OperServ now stores SXLINES
  OperServer now stores VLINKS
  Unique SUIDs (Services User Id) are now generated for each nick   
  
  What has been fixed ?
  ---------------------
  online users/channels hash algorithm changed to the one used on ircd
  NickChange will now append NNN to nick
  NickServ SET KILL should work even with NickChange (duck-patch)
  GETFOUNDER moved to the correct help section on the pt lang (bug #29)
  sadmins can use CHANSERV CLEAR on forbidden channels (bug #52)
  username lost on newmasks starting with @ (bug #51)
  missing rm language.h on distclean make rule (bug #57)
  rename the log( function to log1( 
    (to avoid newer gcc warnings )  
  fixed notice on mlock (bug #61)
  updated operserv help (bug #64 and #62)
  Fixed case sensitivity on clearmodes all of operserv (bug #65)
  Help file typo fix (bug #66)
  Removed the NI_HIDE_MASK from the code (bug #50)
  Removed nickserv commands release and recover, these had no real purpose
  Read domain.def from /etc dir

  PTlink.Services2.23.0 (27 Apr 2003)
==================================================================

  What's new ?
  ---------------------
  Dutch and Brazil Portuguese languages
  configure now uses autoconf
  changed source/install structure
  /ChanServ VOICE/DEVOICE (^Stinger^)
  Securemode add to OperServ, to enable network securemode

  What has been fixed ?
  ---------------------
  typo on m_motd (bug #14)
  operserv clear modes will now remove all modes (bug #13)
  added newsserv admin help (bug #7)
  mlock +O/+A is restricted to sopers/sadmins (bug #1)
  email features not working with AUTH disabled (bug #3)
  removed NSAccessMax setting (bug #11)
  incorrect sqline help (bug #26)
  display +f mlock is not supported message (bug #22)
  typo on import-stdb (bug #31)
  little thing removed from include (bug #34)
  Umode_x removed, was not used (bug #35)
  little portugese helpfilefix (bug #37)
  hopefully fixed akick bug for removing akick (bug #38)
  removed duplicate sentence (bug #43)
  helpfile fixed for operserv vline for adding words (bug #49)
  fixed memory leaks on load_ns_dbase
  fixed memory leaks on load_cs_dbase
  fixed memory leak on match_usermask
