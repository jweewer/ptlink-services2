******************************************************************
*       http://www.ptlink.net/Coders - Coders@PTlink.net         *
******************************************************************

(.1)

  What's new ?
  ---------------------
  memos export to MySQL

  What has been fixed ?
  ---------------------
  MD5 encryption
  removed sql INSERT log line
  make sure nick is escaped (some chars could break the SQL string)

  PTlink.Services2.20.0 (27 Dec 2001)
==================================================================

  What's new ?
  ---------------------
  nick info save to a MySQL database
  
  What has been fixed ?
  ---------------------
  removed HostPrefix code (masked hosts are propagated with PTS4)
  removed "MODE +b for nonexistent channel" for chanserv modes
  PING is now sent at end of connect burst (protocol)
  optimized do_sjoin
  cleaned up do_join
  