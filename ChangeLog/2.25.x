******************************************************************
*                  http://software.pt-link.net                   *
******************************************************************
 * $Id: 2.25.x,v 1.1 2004/10/23 11:50:42 jpinto Exp $

(.1) 16 Oct 2004

  What's new ?
  ---------------------
  Issue 000134 : ChanServ SET TOPICENTRY

  What has been fixed ?
  ---------------------
  Issue 0000137 : Broken compile on OpenBSD
  Issue 0000126 : channel will be displayed on chanserv entrymessage
  Issue 0000132 : Incorrect TS Protocol support

  PTlink.Services2.25.0 (03 Oct 2004)
==================================================================

  What's new ?
  ---------------------
  Added NICKSERV SET PRIVMSG (idea from rooknix)
  Added support for SSNICK/SSJOIN (will be needed later)
  Services now logs who added/deleted a Services Admin or Oper
  Add experimental Halfops support (defined ircdsetup.h)

  What has been fixed ?
  ---------------------  
  bug #123 : nickserv's ajoin does not check users authentification 
  bug #121 : do_clearmodes() crash
  bug #097 : GNUplot example obsolete for services stats (commented)
  bug #118 : Channel record not reset on channel drop
  bug #116 : compile broken when DEBUG_COMMANDS is defined 
  chan table format changed to the svs3 format
  bug #98 : hostname akick is useless after services restart (expire them)
  bug #111 : broken check_pidfile() 
  bug #107 : memory leak on ban removal
  change command lines options(ircd alike), added --help
  improved mysql header files/library detection
  load_vlink_dbase() debugging now set correct
  bug #103 : getlink() doesn't check for NULL structure
  Notices on nickserv set email fixed for sadmins
  bug #101 : Potential buffer overflows on dbinit.c
  bug #100 : Missing SQUIT server before JUPE
  bug #102 : A ")" is missing when DEBUG_COMMANDS is defined.
  bug #105 : chanmode +C is missing on mlock and clear modes
  bug #108 : SAdmins should be able to override SET EMAIL delay
  bug #106 : NickServ SET for Services Administrators displays invalid change messages
