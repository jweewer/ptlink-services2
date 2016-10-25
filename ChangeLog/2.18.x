	      		(C) 1999-2001, PTlink Coders Team
	        	  http://www.ptlink.net/Coders/

(.8) 29 Jul 2001
What has been fixed ?
---------------------
JP2 encryption password size match
operserv SENDPASS generates a random new password when
  using encryption
disabled new memos notice when services are read-only

(.7) 13 Jun 2001

What has been fixed ?
---------------------
bug on +l/+k parameters parsing
removed TS check on SVSMODE (was causing mode integrity problems)
added services data synchronization (SVSINFO)
reenabled sqline/svline propagation
				  
(.6) 04 Jun 2001
--------------------
What has been fixed ?
---------------------
fixed bug not checking for nick registration on newsserv commands
 (reported by OldHawk)
completed memoserv send help

(.5) 19 May 2001
---------------------
What has been fixed ?
---------------------
.conf parameters type not allowing password encryption disable
  (reported by carlos23)

(.4) 08 May 2001

What has been fixed ?
---------------------
Added missing newmask raw support
Fixed user match masking (broking unban/akick)
Added timestamp based recognition
Added TS certification for services mode changes
Added remote parameter count check on nick introduction
Reenabled +q channel mode detection
Fixed forbidden nicks being used after any identify
  (reported by DoctorX at PTlink.net)
Removed autojoin on ghost command from bot entry

(.3) 13 Apr 2001
----------------
Ban mask generation using masked hostname
  (was using real host, not working on PTlink6)
Fixed nick kill enforcer introduction 
  (was using old protocol)

(.2) 30 Mar 2001
----------------
Fixed ban mask generation (needing *!)
cleaned channel mode parsing code for sjoin
fixed fatal bug on /NickServ NOTES DEL (reported by winsome)

(.1) 20 Mar 2001
-----------------
Fixed fatal bug on sjoin parsing for nonexistent nicks
made services akills being enforced with GLINEs

  17 Mar 2001
-------------------------------------------------------------------------------
 PTlink.Services 2.18.x                               	  - Lamego@PTlink.net-
-------------------------------------------------------------------------------
  implemented PTS4 protocol for compatibility with PTlink6
  added Italian language to services.conf descriptions
	(reported by ^Stinger^)
  fixed /ChanServ SOP (was using ACC-LIST level)
------------------------------------------------------------------------------- 
NOTE: This version uses only PTS4 protocol, PTlink6 is required to link
