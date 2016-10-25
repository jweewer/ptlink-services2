#
# Services is copyright (c) 1996-1999 Andy Church.
#     E-mail: <achurch@dragonfire.net>
# This program is free but copyrighted software; see the file COPYING for
# details.
# $Id:

# When translating this file to another language, keep in mind that the
# order of parameters for sprintf() is fixed in the source code, so your
# messages need to take the same parameters in the same order as the
# English messages do.  (Obviously, this doesn't hold for the strftime()
# format lines immediately below.)  If you can't get a natural translation
# of a message without changing the order of the parameters, let me know
# (achurch@dragonfire.net) which message is causing a problem and I'll see
# what I can do.
#
# In help messages, "%S" (capital S, not lowercase) refers to the name of
# the service sending the message; for example, in NickServ help messages,
# "%S" is replaced by "NickServ" (or whatever it is renamed to in
# config.h).  The %S's do not count as sprintf() parameters, so they can be
# rearranged, removed, or added as necessary.
#
# Also in help messages, please try to limit line lengths to 60 characters
# of text (not including the leading tab).  This length was chosen because
# it does not cause line wrap under default settings on most current IRC
# clients.  Remember that format characters (control-B, control-_) are not
# included in that 60-character limit (since they don't show on the user's
# screen).  Also remember that format specifiers (%S, etc.) will expand
# when displayed, so remember to take this into account; you can assume
# that the length of a pseudoclient name (%S replacement) will be eight
# characters, so reduce the maximum line length by 6 for every %S on a
# line.
#
# Finally, remember to put a tab at the beginning of every line of text
# (including empty lines).  This has to be a tab, not spaces.

###########################################################################
#
# Name of this language
#
###########################################################################

# For languages other than English, this string should have the following
# format:
#     language-name-in-language (language-name-in-English)
# For example, "Espaol (Spanish)" or "Franais (French)".

LANG_NAME
	English

###########################################################################
#
# General messages
#
###########################################################################

# strftime() format strings.  man 3 strftime for information on the
# meanings of the format specifiers.  Short version:
#	%a = weekday name (short)	%H = hour
#	%b = month name (short)		%M = minute
#	%d = day of month		%S = second
#	%Y = year			%Z = time zone

# This is used as the format string for strftime() for a date and time
# together.
STRFTIME_DATE_TIME_FORMAT
	%b %d %H:%M:%S %Y %Z
# This is used as the format string for strftime() for a date alone in long
# format (English: including weekday).
STRFTIME_LONG_DATE_FORMAT
	%a %b %d %Y
# This is used as the format string for strftime() for a date alone in
# short format (English: without weekday).
STRFTIME_SHORT_DATE_FORMAT
	%b %d %Y

# These tell our strftime() what the names of months and days are.  If you
# don't use %a, %A, %b, or %B in your strftime() strings above, you can
# leave these empty.  However, if you enter names, they MUST stay in order,
# one per line, and the list MUST be complete!

# %a
STRFTIME_DAYS_SHORT
	Sun
	Mon
	Tue
	Wed
	Thu
	Fri
	Sat
# %A
STRFTIME_DAYS_LONG
	Sunday
	Monday
	Tuesday
	Wednesday
	Thursday
	Friday
	Saturday
# %b
STRFTIME_MONTHS_SHORT
	Jan
	Feb
	Mar
	Apr
	May
	Jun
	Jul
	Aug
	Sep
	Oct
	Nov
	Dec
# %B
STRFTIME_MONTHS_LONG
	January
	February
	March
	April
	May
	June
	July
	August
	September
	October
	November
	December


# This is used in ChanServ/NickServ INFO displays.
COMMA_SPACE
	, 


# Various error messages.
USER_RECORD_NOT_FOUND
	Internal error - unable to process request.
UNKNOWN_COMMAND
	Unknown command %s.
UNKNOWN_COMMAND_HELP
	Unknown command %s. /%s HELP for help.
SYNTAX_ERROR
	Syntax: %s
MORE_INFO
	/%s HELP %s for more information.
NO_HELP_AVAILABLE
	No help available for %s.
BAD_USERHOST_MASK
	Mask must be in the form user@host.
SERVICE_OFFLINE
	%s is currently offline.
READ_ONLY_MODE
	Notice: Services is in read-only mode;
	changes will not be saved!
PASSWORD_INCORRECT
	Password incorrect.

# What's the difference between "Access denied" and "Permission denied"?
# Very little; you can safely make them the same message with no real loss
# of meaning.  If you want to make a distinction, "Access denied" is
# usually used more generally; for example, a non-oper trying to access
# OperServ gets "Access denied", while a non-Services admin trying to use
# NickServ SET NOEXPIRE gets "Permission denied".
ACCESS_DENIED
	Access denied.
PERMISSION_DENIED
	Permission denied.
MORE_OBSCURE_PASSWORD
	Please try again with a more obscure password.  
	Passwords should be at least five characters long,
	should not be something easily guessed (e.g. your 
	real name or your nick), and cannot contain the
	space or tab characters.
PASSWORD_TRUNCATED
	Notice:  Your password has been truncated to %d characters.
NICK_NOT_REGISTERED
	Your nick isn't registered.
NICK_NOT_REGISTERED_HELP
	Your nick isn't registered.  Type /%s HELP for 
	information on registering your nickname.
NICK_X_NOT_REGISTERED
	Nick %s isn't registered.
NICK_X_NOT_IN_USE
	Nick %s isn't currently in use.
NICK_X_NOT_ON_CHAN
	Nick %s isn't on channel %s.
NICK_X_FORBIDDEN
	Nick %s may not be registered or used.
CHAN_X_NOT_REGISTERED
	Channel %s isn't registered.
CHAN_X_NOT_IN_USE
	Channel %s doesn't exist.
CHAN_X_FORBIDDEN
	Channel %s may not be registered or used.
NICK_IDENTIFY_REQUIRED
	Password authentication required for that command.
	Retry after typing /%s IDENTIFY password.
CHAN_IDENTIFY_REQUIRED
	Password authentication required for that command.
	Retry after typing /%s IDENTIFY %s password.

###########################################################################
#
# NickServ messages
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	This nick is owned by someone else.  Please choose another.
	(If this is your nick, type /%s IDENTIFY password.)
NICK_IS_SECURE
	This nickname is registered and protected.  If it is your
	nick, type /%s IDENTIFY password.  Otherwise,
	please choose a different nick.
NICK_MAY_NOT_BE_USED
	This nickname may not be used.  Please choose another one.
DISCONNECT_IN_1_MINUTE
	If you do not change within one minute, you will be disconnected.
DISCONNECT_IN_20_SECONDS
	If you do not change within 20 seconds, you will be disconnected.
DISCONNECT_NOW
	This nickname has been registered; you may not use it.  Please
	choose another nickname before reconnecting.

# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER password email
NICK_REGISTRATION_DISABLED
	Sorry, nickname registration is temporarily disabled.
NICK_REGISTRATION_FAILED
	Sorry, registration failed.
NICK_REG_PLEASE_WAIT
	Please wait %d seconds before using the REGISTER command again.
NICK_CANNOT_BE_REGISTERED
	Nickname %s may not be registered.
NICK_ALREADY_REGISTERED
	Nickname %s is already registered!
NICK_REGISTERED
	Nickname %s registered under your account: %s
NICK_PASSWORD_IS
	Your password is %s - remember this for later use.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY password [NOJOIN]
NICK_IDENTIFY_FAILED
	Sorry, identification failed.
NICK_IDENTIFY_SUCCEEDED
	Password accepted - you are now recognized.

# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Sorry, nickname de-registration is temporarily disabled.
NICK_DROPPED
	Your nickname has been dropped.
NICK_X_DROPPED
	Nickname %s has been dropped.

# SET responses
NICK_SET_SYNTAX
	SET option parameters
NICK_SET_SERVADMIN_SYNTAX
	SET [nick] option parameters
NICK_SET_DISABLED
	Sorry, nickname option setting is temporarily disabled.
NICK_SET_UNKNOWN_OPTION
	Unknown SET option %s.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Unknown SET option %s, or nickname not registered.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Sorry, couldn't change password.
NICK_SET_PASSWORD_CHANGED
	Password changed.
NICK_SET_PASSWORD_CHANGED_TO
	Password changed to %s.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE number
NICK_SET_LANGUAGE_UNKNOWN
	Unknown language number %d.  Type /%s HELP SET LANGUAGE for a list of languages.
NICK_SET_LANGUAGE_CHANGED
	Language changed to English.

# SET URL responses
NICK_SET_URL_CHANGED
	URL changed to %s.
NICK_SET_URL_UNSET
	URL unset.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	E-mail address changed to %s.
NICK_SET_EMAIL_UNSET
	E-mail address unset.

# SET ICQNUMBER responses
NICK_SET_ICQ_CHANGED
	ICQ number changed to #%s.
NICK_SET_ICQ_UNSET
	ICQ number unset.

# SET LOCATION responses
NICK_SET_LOCATION_CHANGED
	Location changed to %s.
NICK_SET_LOCATION_UNSET
	Location unset.

# SET KILL responses
NICK_SET_KILL_SYNTAX
	SET KILL {}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	Kill protection is now ON.
NICK_SET_KILL_QUICK
	Kill protection is now ON, with a reduced kill delay.
NICK_SET_KILL_IMMED
	Kill protection is now ON, with no kill delay.
NICK_SET_KILL_IMMED_DISABLED
	The IMMED option is not available on this network.
NICK_SET_KILL_OFF
	Kill protection is now OFF.

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Private option is now ON.
NICK_SET_PRIVATE_OFF
	Private option is now OFF.

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	Your E-mail address will now be hidden from %s INFO displays.
NICK_SET_HIDE_EMAIL_OFF
	Your E-mail address will now be shown in %s INFO displays.
NICK_SET_HIDE_QUIT_ON
	Your last quit message will now be hidden from %s INFO displays.
NICK_SET_HIDE_QUIT_OFF
	Your last quit message will now be shown in %s INFO displays.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [nickname] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	Nick %s will not expire.
NICK_SET_NOEXPIRE_OFF
	Nick %s will expire.

# LINK responses
NICK_LINK_SYNTAX
	LINK nick password
NICK_NICKLINK_SYNTAX
	NICKLINK nick targetnick
NICK_LINK_DISABLED
	The LINK command is not available.
NICK_LINK_FAILED
	Sorry, linking failed.
NICK_NO_LINK_SAME
	You can't link to your current nick!
NICK_LINK_CIRCULAR
	Can't link to nick %s: circular link detected.
NICK_LINKED
	Your nick has been linked to %s.
NICK_NICKLINKED
	The nick %s has been linked to %s.

# UNLINK responses
NICK_UNLINK_SYNTAX
	UNLINK [nick password]
NICK_UNLINK_FAILED
	Sorry, unlinking failed.
NICK_NOT_LINKED
	Your nick isn't linked.
NICK_UNLINKED
	Your nick has been unlinked from %s.
NICK_X_NOT_LINKED
	Nick %s isn't linked.
NICK_X_UNLINKED
	Nick %s has been unlinked from %s.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS nick [ALL]
NICK_LISTLINKS_SYNTAX2
	LISTLINKS
NICK_LISTLINKS_HEADER
	List of nicknames linked to %s:
NICK_LISTLINKS_FOOTER
	%d linked nicknames.

# INFO responses
NICK_INFO_SYNTAX
	INFO nick
NICK_INFO_REALNAME
	%s is %s
NICK_INFO_ADDRESS
	 Last seen address: %s
NICK_INFO_TIME_REGGED
	   Time registered: %s [%s]
NICK_INFO_LAST_IDENTIFY
	Last identify time: %s [%s]
NICK_INFO_LAST_SEEN
	    Last seen time: %s [%s]
NICK_INFO_ONLINE
	 Total online time: %s
NICK_INFO_LAST_QUIT
	 Last quit message: %s
NICK_INFO_URL
	               URL: %s
NICK_INFO_EMAIL
	    E-mail address: %s
NICK_INFO_ICQ
	        ICQ number: #%s
NICK_INFO_LOCATION
	          Location: %s
NICK_INFO_OPTIONS
	           Options: %s
NICK_INFO_NO_EXPIRE
	            Expire: Never
NICK_INFO_SUSPENDED
	   Nick suspension: %s
NICK_INFO_OSUSPENDED
	   Oper suspension: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Kill protection
NICK_INFO_OPT_PRIVATE
	Private
NICK_INFO_OPT_NONE
	None

# LIST responses
NICK_LIST_SYNTAX
	LIST pattern
NICK_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE]
NICK_LIST_HEADER
	List of entries matching %s:
NICK_LIST_RESULTS
	End of list - %d/%d matches shown.

NICK_RELEASED
	Services' hold on your nick has been released.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST nickname [password]
NICK_NO_GHOST_SELF
	You can't ghost yourself!
NICK_GHOST_KILLED
	Ghost with your nick has been killed.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS nickname
NICK_GETPASS_UNAVAILABLE
	GETPASS command unavailable because encryption is in use.
NICK_GETPASS_PASSWORD_IS
	Password for %s is %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID nickname
NICK_FORBID_SUCCEEDED
	Nick %s is now forbidden.
NICK_FORBID_FAILED
	Couldn't forbid nick %s!

###########################################################################
#
# ChanServ messages
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Automatic channel operator status
CHAN_LEVEL_AUTOVOICE
	Automatic mode +v
CHAN_LEVEL_AUTODEOP
	Channel operator status disallowed
CHAN_LEVEL_NOJOIN
	Not allowed to join channel if RESTRICTED
CHAN_LEVEL_INVITE
	Allowed to use INVITE command
CHAN_LEVEL_AKICK
	Allowed to use AKICK command
CHAN_LEVEL_SET
	Allowed to use SET command (not FOUNDER/PASSWORD)
CHAN_LEVEL_CLEAR
	Allowed to use CLEAR command
CHAN_LEVEL_UNBAN
	Allowed to use UNBAN command
CHAN_LEVEL_OPDEOP
	Allowed to use OP/DEOP commands
CHAN_LEVEL_ACCESS_LIST
	Allowed to view the access list
CHAN_LEVEL_ACCESS_CHANGE
	Allowed to modify the access list
CHAN_LEVEL_MEMO_READ
	Allowed to list/read channel memos
CHAN_LEVEL_MEMO_SEND
	Allowed to send channel memos
CHAN_LEVEL_MEMO_DEL
	Allowed to delete channel memos
CHAN_LEVEL_KICK
	Allowed to use KICK command

# Automatic responses
CHAN_IS_REGISTERED
	This channel has been registered with %s.
CHAN_NOT_ALLOWED_OP
	You are not allowed chanop status on channel %s.
CHAN_MAY_NOT_BE_USED
	This channel may not be used.
CHAN_NOT_ALLOWED_TO_JOIN
	You are not permitted to be on this channel.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER channel password description
CHAN_REGISTER_DISABLED
	Sorry, channel registration is temporarily disabled.
CHAN_REGISTER_NOT_LOCAL
	Local channels cannot be registered.
CHAN_MUST_REGISTER_NICK
	You must register your nickname first.  Type /%s HELP for information on registering nicknames.
CHAN_MUST_IDENTIFY_NICK
	Please identify with %s first, using the command:
	/%s IDENTIFY password
CHAN_MAY_NOT_BE_REGISTERED
	Channel %s may not be registered.
CHAN_ALREADY_REGISTERED
	Channel %s is already registered!
CHAN_MUST_BE_CHANOP
	You must be a channel operator to register the channel.
CHAN_REACHED_CHANNEL_LIMIT
	Sorry, you have already reached your limit of %d channels.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Sorry, you have already exceeded your limit of %d channels.
CHAN_REGISTRATION_FAILED
	Sorry, registration failed.
CHAN_REGISTERED
	Channel %s registered under your nickname: %s
CHAN_PASSWORD_IS
	Your channel password is %s - remember it for later use.

# IDENTIFY responses
CHAN_IDENTIFY_SYNTAX
	IDENTIFY channel password
CHAN_IDENTIFY_FAILED
	Sorry, identification failed.
CHAN_IDENTIFY_SUCCEEDED
	Password accepted - you now have founder-level access to %s.

# DROP responses
CHAN_DROP_SYNTAX
	DROP channel
CHAN_DROP_DISABLED
	Sorry, channel de-registration is temporarily disabled.
CHAN_DROPPED
	Channel %s has been dropped.

# SET responses
CHAN_SET_SYNTAX
	SET channel option parameters
CHAN_SET_DISABLED
	Sorry, channel option setting is temporarily disabled.
CHAN_SET_UNKNOWN_OPTION
	Unknown SET option %s.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s has too many channels registered.
CHAN_FOUNDER_CHANGED
	Founder of %s changed to %s.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Successor for %s changed to %s.
CHAN_SUCCESSOR_UNSET
	Successor for %s unset.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Sorry, couldn't set password.
CHAN_PASSWORD_CHANGED
	%s password changed.
CHAN_PASSWORD_CHANGED_TO
	%s password changed to %s.

# SET DESC responses
CHAN_DESC_CHANGED
	Description of %s changed to %s.

# SET URL responses
CHAN_URL_CHANGED
	URL for %s changed to %s.
CHAN_URL_UNSET
	URL for %s unset.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	E-mail address for %s changed to %s.
CHAN_EMAIL_UNSET
	E-mail address for %s unset.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Entry message for %s changed.
CHAN_ENTRY_MSG_UNSET
	Entry message for %s unset.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Sorry, can't set topic.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	Parameter required for MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	Parameter required for MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Parameter for MLOCK +l must be a positive number.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Unknown mode character %c ignored.
CHAN_MLOCK_CHANGED
	Mode lock on channel %s changed to %s.
CHAN_MLOCK_REMOVED
	Mode lock on channel %s removed.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET channel KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Topic retention option is now ON.
CHAN_SET_KEEPTOPIC_OFF
	Topic retention option is now OFF.

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET channel TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Topic lock option is now ON.
CHAN_SET_TOPICLOCK_OFF
	Topic lock option is now OFF.

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET channel PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Private option is now ON.
CHAN_SET_PRIVATE_OFF
	Private option is now OFF.

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET channel SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Secure ops option is now ON.
CHAN_SET_SECUREOPS_OFF
	Secure ops option is now OFF.

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET channel LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Leave ops option is now ON.
CHAN_SET_LEAVEOPS_OFF
	Leave ops option is now OFF.

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET channel RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Restricted access option is now ON.
CHAN_SET_RESTRICTED_OFF
	Restricted access option is now OFF.

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET channel OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Op-notice option is now ON.
CHAN_SET_OPNOTICE_OFF
	Op-notice option is now OFF.

# SET OPNOTICE responses
CHAN_SET_NOLINKS_SYNTAX
	SET channel NOLINKS {ON | OFF}
CHAN_SET_NOLINKS_ON
	NOLINKS option is now ON.
CHAN_SET_NOLINKS_OFF
	NOLINKS option is now OFF.

# SET TOPICENTRY responses
CHAN_SET_TOPICENTRY_SYNTAX
	SET channel TOPICENTRY {ON | OFF}
CHAN_SET_TOPICENTRY_ON
	TOPICENTRY option is now ON.
CHAN_SET_TOPICENTRY_OFF
	TOPICENTRY option is now OFF.
# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET channel NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Channel %s will not expire.
CHAN_SET_NOEXPIRE_OFF
	Channel %s will expire.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS channel {ADD|DEL|LIST} [nick [level] | entry-list]
CHAN_ACCESS_DISABLED
	Sorry, channel access list modification is temporarily disabled.
CHAN_ACCESS_LEVEL_NONZERO
	Access level must be non-zero.
CHAN_ACCESS_LEVEL_RANGE
	Access level must be between %d and %d inclusive.
CHAN_ACCESS_NICKS_ONLY
	Channel access lists may only contain registered nicknames.
CHAN_ACCESS_REACHED_LIMIT
	Sorry, you can only have %d access entries on a channel.
CHAN_ACCESS_LEVEL_UNCHANGED
	Access level for %s on %s unchanged from %d.
CHAN_ACCESS_LEVEL_CHANGED
	Access level for %s on %s changed from %d to %d.
CHAN_ACCESS_ADDED
	%s added to %s access list at level %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	No such entry (#%d) on %s access list.
CHAN_ACCESS_NOT_FOUND
	%s not found on %s access list.
CHAN_ACCESS_NO_MATCH
	No matching entries on %s access list.
CHAN_ACCESS_DELETED
	%s deleted from %s access list.
CHAN_ACCESS_DELETED_ONE
	Deleted 1 entry from %s access list.
CHAN_ACCESS_DELETED_SEVERAL
	Deleted %d entries from %s access list.
CHAN_ACCESS_LIST_EMPTY
	%s access list is empty.
CHAN_ACCESS_LIST_HEADER
	Access list for %s:
	  Num   Lev  Nick
CHAN_ACCESS_LIST_FORMAT
	  %3d  %4d  %s%s%s%s


# AOP/SOP error response
CHAN_NO_AOP_SOP
	To assign channel privileges to users, use the ACCESS
	command; type /%s HELP ACCESS for more
	information.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK channel {ADD | DEL | LIST} [nick-or-usermask]
CHAN_AKICK_DISABLED
	Sorry, channel autokick list modification is temporarily disabled.
CHAN_AKICK_ALREADY_EXISTS
	%s already exists on %s autokick list.
CHAN_AKICK_REACHED_LIMIT
	Sorry, you can only have %d autokick masks on a channel.
CHAN_AKICK_ADDED
	%s added to %s autokick list.
CHAN_AKICK_NO_SUCH_ENTRY
	No such entry (#%d) on %s autokick list.
CHAN_AKICK_NOT_FOUND
	%s not found on %s autokick list.
CHAN_AKICK_NO_MATCH
	No matching entries on %s autokick list.
CHAN_AKICK_DELETED
	%s deleted from %s autokick list.
CHAN_AKICK_DELETED_ONE
	Deleted 1 entry from %s autokick list.
CHAN_AKICK_DELETED_SEVERAL
	Deleted %d entries from %s autokick list.
CHAN_AKICK_LIST_EMPTY
	%s autokick list is empty.
CHAN_AKICK_LIST_HEADER
	Autokick list for %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_LIST_FORMAT2
	  %3d %s by %s : %s

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS channel {SET | DIS[ABLE] | LIST | RESET} [item [level]]
CHAN_LEVELS_RANGE
	Level must be between %d and %d inclusive.
CHAN_LEVELS_CHANGED
	Level for %s on channel %s changed to %d.
CHAN_LEVELS_UNKNOWN
	Setting %s not known.  Type /%s HELP LEVELS DESC for a list of valid settings.
CHAN_LEVELS_DISABLED
	%s disabled on channel %s.
CHAN_LEVELS_LIST_HEADER
	Access level settings for channel %s:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (disabled)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (founder only)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	Access levels for %s reset to defaults.

# INFO responses
CHAN_INFO_SYNTAX
	INFO channel
CHAN_INFO_HEADER
	Information for channel %s:
CHAN_INFO_FOUNDER
	        Founder: %s (%s)
CHAN_INFO_NO_FOUNDER
	        Founder: %s
CHAN_INFO_DESCRIPTION
	    Description: %s
CHAN_INFO_TIME_REGGED
	     Registered: %s [%s]
CHAN_INFO_LAST_USED
	      Last used: %s [%s]
CHAN_INFO_LAST_TOPIC
	     Last topic: %s
CHAN_INFO_TOPIC_SET_BY
	   Topic set by: %s
CHAN_INFO_RECORD
	   Users record: %d user(s) at %s [%s]
CHAN_INFO_USERS
	     Occupation: %d user(s)
CHAN_INFO_URL
	            URL: %s
CHAN_INFO_EMAIL
	 E-mail address: %s
CHAN_INFO_OPTIONS
	        Options: %s
CHAN_INFO_NO_EXPIRE
	         Expire: Never
CHAN_INFO_OPT_PRIVATE
	Private
CHAN_INFO_OPT_KEEPTOPIC
	Topic Retention
CHAN_INFO_OPT_TOPICLOCK
	Topic Lock
CHAN_INFO_OPT_SECUREOPS
	Secure Ops
CHAN_INFO_OPT_LEAVEOPS
	Leave Ops
CHAN_INFO_OPT_RESTRICTED
	Restricted Access
CHAN_INFO_OPT_NOLINKS
	Ignore nick links
CHAN_INFO_OPT_TOPICENTRY
	TopicEntry
CHAN_INFO_OPT_OPNOTICE
	OpNotice
CHAN_INFO_OPT_NONE
	None
CHAN_INFO_MODE_LOCK
	      Mode lock: %s

# LIST responses
CHAN_LIST_SYNTAX
	LIST pattern
CHAN_LIST_HEADER
	List of entries matching %s:
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	End of list - %d/%d matches shown.

# INVITE responses
CHAN_INVITE_SYNTAX
	INVITE channel

# OP responses
CHAN_OP_SYNTAX
	OP channel nick

# DEOP responses
CHAN_DEOP_SYNTAX
	DEOP channel nick

# KICK responses
CHAN_KICK_SYNTAX
	KICK channel nick reason

# UNBAN responses
CHAN_UNBAN_SYNTAX
	UNBAN channel
CHAN_UNBANNED
	You have been unbanned from %s.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR channel what
CHAN_CLEARED_BANS
	All bans on channel %s have been removed.
CHAN_CLEARED_MODES
	All modes on channel %s have been reset.
CHAN_CLEARED_OPS
	Mode +o has been cleared from channel %s.
CHAN_CLEARED_VOICES
	Mode +v has been cleared from channel %s.
CHAN_CLEARED_USERS
	All users have been kicked from channel %s.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS channel
CHAN_GETPASS_UNAVAILABLE
	GETPASS command unavailable because encryption is in use.
CHAN_GETPASS_PASSWORD_IS
	Password for channel %s is %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID channel
CHAN_FORBID_SUCCEEDED
	Channel %s is now forbidden.
CHAN_FORBID_FAILED
	Couldn't forbid channel %s!

###########################################################################
#
# MemoServ messages
#
###########################################################################

# Automatic messages
MEMO_HAVE_NEW_MEMO
	You have 1 new memo.
MEMO_HAVE_NEW_MEMOS
	You have %d new memos.
MEMO_TYPE_READ_LAST
	Type /%s READ LAST to read it.
MEMO_TYPE_READ_NUM
	Type /%s READ %d to read it.
MEMO_TYPE_LIST_NEW
	Type /%s LIST NEW to list them.
MEMO_AT_LIMIT
	Warning: You have reached your maximum number of memos (%d).  You will be unable to receive any new memos until you delete some of your current ones.
MEMO_OVER_LIMIT
	Warning: You are over your maximum number of memos (%d).  You will be unable to receive any new memos until you delete some of your current ones.
MEMO_NEW_MEMO_ARRIVED
	You have a new memo from %s.
	Type /%s READ %d to read it.

# Multi-use responses
MEMO_HAVE_NO_MEMOS
	You have no memos.
MEMO_X_HAS_NO_MEMOS
	%s has no memos.
MEMO_DOES_NOT_EXIST
	Memo %d does not exist!
MEMO_LIST_NOT_FOUND
	No matching memos found.

# SEND responses
MEMO_SEND_SYNTAX
	SEND {nick | channel} memo-text
MEMO_SEND_DISABLED
	Sorry, memo sending is temporarily disabled.
MEMO_SEND_PLEASE_WAIT
	Please wait %d seconds before using the SEND command again.
MEMO_X_GETS_NO_MEMOS
	%s cannot receive memos.
MEMO_X_HAS_TOO_MANY_MEMOS
	%s currently has too many memos and cannot receive more.
MEMO_SENT
	Memo sent to %s.

# LIST responses
MEMO_LIST_SYNTAX
	LIST [channel] [list | NEW]
MEMO_HAVE_NO_NEW_MEMOS
	You have no new memos.
MEMO_X_HAS_NO_NEW_MEMOS
	%s has no new memos.
MEMO_LIST_MEMOS
	Memos for %s.  To read, type: /%s READ num
MEMO_LIST_NEW_MEMOS
	New memos for %s.  To read, type: /%s READ num
MEMO_LIST_CHAN_MEMOS
	Memos for %s.  To read, type: /%s READ %s num
MEMO_LIST_CHAN_NEW_MEMOS
	New memos for %s.  To read, type: /%s READ %s num
MEMO_LIST_HEADER
	 Num  Sender            Date/Time
MEMO_LIST_FORMAT
	%c%3d  %-16s  %s "%s..."

# READ responses
MEMO_READ_SYNTAX
	READ [channel] {list | LAST | NEW}
MEMO_HEADER
	Memo %d from %s (%s).  To delete, type: /%s DEL %d
MEMO_CHAN_HEADER
	Memo %d from %s (%s).  To delete, type: /%s DEL %s %d
MEMO_TEXT
	%s

# DEL responses
MEMO_DEL_SYNTAX
	DEL [channel] {num | list | ALL}
MEMO_DELETED_NONE
	No memos were deleted.
MEMO_DELETED_ONE
	Memo %d has been deleted.
MEMO_DELETED_SEVERAL
	Memos %s have been deleted.
MEMO_DELETED_ALL
	All of your memos have been deleted.

# SET responses
MEMO_SET_SYNTAX
	SET option parameters
MEMO_SET_DISABLED
	Sorry, memo option setting is temporarily disabled.
MEMO_SET_UNKNOWN_OPTION
	Unknown SET option %s.

# SET NOTIFY responses
MEMO_SET_NOTIFY_SYNTAX
	SET NOTIFY {ON | LOGON | NEW | OFF}
MEMO_SET_NOTIFY_ON
	%s will now notify you of memos when you log on and when they are sent to you.
MEMO_SET_NOTIFY_LOGON
	%s will now notify you of memos when you log on or unset /AWAY.
MEMO_SET_NOTIFY_NEW
	%s will now notify you of memos when they are sent to you.
MEMO_SET_NOTIFY_OFF
	%s will not send you any notification of memos.

# SET LIMIT responses
MEMO_SET_LIMIT_SYNTAX
	SET LIMIT [channel] limit
MEMO_SET_LIMIT_SERVADMIN_SYNTAX
	SET LIMIT [user | channel] {limit | NONE} [HARD]
MEMO_SET_YOUR_LIMIT_FORBIDDEN
	You are not permitted to change your memo limit.
MEMO_SET_LIMIT_FORBIDDEN
	The memo limit for %s may not be changed.
MEMO_SET_YOUR_LIMIT_TOO_HIGH
	You cannot set your memo limit higher than %d.
MEMO_SET_LIMIT_TOO_HIGH
	You cannot set the memo limit for %s higher than %d.
MEMO_SET_LIMIT_OVERFLOW
	Memo limit too large; limiting to %d instead.
MEMO_SET_YOUR_LIMIT
	Your memo limit has been set to %d.
MEMO_SET_YOUR_LIMIT_ZERO
	You will no longer be able to receive memos.
MEMO_UNSET_YOUR_LIMIT
	Your memo limit has been disabled.
MEMO_SET_LIMIT
	Memo limit for %s set to %d.
MEMO_SET_LIMIT_ZERO
	Memo limit for %s set to 0.
MEMO_UNSET_LIMIT
	Memo limit disabled for %s.

# INFO responses
MEMO_INFO_SYNTAX
	INFO [channel]
MEMO_INFO_SERVADMIN_SYNTAX
	INFO [nick | channel]
MEMO_INFO_NO_MEMOS
	You currently have no memos.
MEMO_INFO_MEMO
	You currently have 1 memo.
MEMO_INFO_MEMO_UNREAD
	You currently have 1 memo, and it has not yet been read.
MEMO_INFO_MEMOS
	You currently have %d memos.
MEMO_INFO_MEMOS_ONE_UNREAD
	You currently have %d memos, of which 1 is unread.
MEMO_INFO_MEMOS_SOME_UNREAD
	You currently have %d memos, of which %d are unread.
MEMO_INFO_MEMOS_ALL_UNREAD
	You currently have %d memos; all of them are unread.
MEMO_INFO_LIMIT
	Your memo limit is %d.
MEMO_INFO_HARD_LIMIT
	Your memo limit is %d, and may not be changed.
MEMO_INFO_LIMIT_ZERO
	Your memo limit is 0; you will not receive any new memos.
MEMO_INFO_HARD_LIMIT_ZERO
	Your memo limit is 0; you will not receive any new memos.  You cannot change this limit.
MEMO_INFO_NO_LIMIT
	You have no limit on the number of memos you may keep.
MEMO_INFO_X_NO_MEMOS
	%s currently has no memos.
MEMO_INFO_X_MEMO
	%s currently has 1 memo.
MEMO_INFO_X_MEMO_UNREAD
	%s currently has 1 memo, and it has not yet been read.
MEMO_INFO_X_MEMOS
	%s currently has %d memos.
MEMO_INFO_X_MEMOS_ONE_UNREAD
	%s currently has %d memos, of which 1 is unread.
MEMO_INFO_X_MEMOS_SOME_UNREAD
	%s currently has %d memos, of which %d are unread.
MEMO_INFO_X_MEMOS_ALL_UNREAD
	%s currently has %d memos; all of them are unread.
MEMO_INFO_X_LIMIT
	%s's memo limit is %d.
MEMO_INFO_X_HARD_LIMIT
	%s's memo limit is %d.
MEMO_INFO_X_NO_LIMIT
	%s has no memo limit.

###########################################################################
#
# OperServ messages
#
###########################################################################

# General messages
OPER_BOUNCY_MODES
	Services is unable to change modes.  Are your servers configured correctly?
OPER_BOUNCY_MODES_U_LINE
	Services is unable to change modes.  Are your servers' U:lines configured correctly?

# GLOBAL responses
OPER_GLOBAL_SYNTAX
	GLOBAL message

# STATS responses
OPER_STATS_UNKNOWN_OPTION
	Unknown STATS option %s.
OPER_STATS_CURRENT_USERS
	Current users: %d (%d ops, %d helpers, %d bots)
OPER_STATS_MAX_USERS
	Maximum users: %d (%s)
# This is ugly, but at least it's language-portable...
# Note that you can include seconds in any of these--my personal preference
# is to only give resolution to the nearest minute when uptime is one hour
# or more, but just add a %d to get seconds as well.
OPER_STATS_UPTIME_DHMS
	Services up %d days, %02d:%02d
OPER_STATS_UPTIME_1DHMS
	Services up %d day, %02d:%02d
OPER_STATS_UPTIME_HMS
	Services up %d hours, %d minutes
OPER_STATS_UPTIME_HM1S
	Services up %d hours, %d minutes
OPER_STATS_UPTIME_H1MS
	Services up %d hours, %d minute
OPER_STATS_UPTIME_H1M1S
	Services up %d hours, %d minute
OPER_STATS_UPTIME_1HMS
	Services up %d hour, %d minutes
OPER_STATS_UPTIME_1HM1S
	Services up %d hour, %d minutes
OPER_STATS_UPTIME_1H1MS
	Services up %d hour, %d minute
OPER_STATS_UPTIME_1H1M1S
	Services up %d hour, %d minute
OPER_STATS_UPTIME_MS
	Services up %d minutes, %d seconds
OPER_STATS_UPTIME_M1S
	Services up %d minutes, %d second
OPER_STATS_UPTIME_1MS
	Services up %d minute, %d seconds
OPER_STATS_UPTIME_1M1S
	Services up %d minute, %d second
OPER_STATS_USER_MEM
	User    : %6d records, %5d kB
OPER_STATS_CHANNEL_MEM
	Channel : %6d records, %5d kB
OPER_STATS_NICKSERV_MEM
	NickServ: %6d records, %5d kB
OPER_STATS_CHANSERV_MEM
	ChanServ: %6d records, %5d kB
OPER_STATS_OPERSERV_MEM
	OperServ: %6d records, %5d kB
OPER_STATS_AKILL_COUNT
	Current number of AKILLs: %d
OPER_STATS_AKILL_EXPIRE_DAYS
	Default AKILL expiry time: %d days
OPER_STATS_AKILL_EXPIRE_DAY
	Default AKILL expiry time: 1 day
OPER_STATS_AKILL_EXPIRE_HOURS
	Default AKILL expiry time: %d hours
OPER_STATS_AKILL_EXPIRE_HOUR
	Default AKILL expiry time: 1 hour
OPER_STATS_AKILL_EXPIRE_MINS
	Default AKILL expiry time: %d minutes
OPER_STATS_AKILL_EXPIRE_MIN
	Default AKILL expiry time: 1 minute
OPER_STATS_AKILL_EXPIRE_NONE
	Default AKILL expiry time: No expiration

# MODE responses
OPER_MODE_SYNTAX
	MODE channel modes

# CLEARMODES responses
OPER_CLEARMODES_SYNTAX
	CLEARMODES channel [ALL]
OPER_CLEARMODES_DONE
	Binary modes and bans cleared from channel %s.
OPER_CLEARMODES_ALL_DONE
	All modes cleared from channel %s.


# KICK responses
OPER_KICK_SYNTAX
	KICK channel user reason

# ADMIN responses
OPER_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [nick]
OPER_ADMIN_ADD_SYNTAX
	ADMIN ADD nick
OPER_ADMIN_DEL_SYNTAX
	ADMIN DEL nick
OPER_ADMIN_SKELETON
	Services is in skeleton mode; the ADMIN command is unavailable.
OPER_ADMIN_EXISTS
	%s already exists on Services admin list.
OPER_ADMIN_ADDED
	%s added to Services admin list.
OPER_ADMIN_TOO_MANY
	Too many entries (%d) on Services admin list; cannot add more.
OPER_ADMIN_REMOVED
	%s removed from Services admin list.
OPER_ADMIN_NOT_FOUND
	%s not found on Services admin list.
OPER_ADMIN_LIST_HEADER
	Services admin list:

# OPER responses
OPER_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [nick] | SUSPEND nick days
OPER_OPER_ADD_SYNTAX
	OPER ADD nick
OPER_OPER_DEL_SYNTAX
	OPER DEL nick
OPER_OPER_SKELETON
	Services is in skeleton mode; the OPER command is unavailable.
OPER_OPER_EXISTS
	%s already exists on Services operator list.
OPER_OPER_ADDED
	%s added to Services operator list.
OPER_OPER_TOO_MANY
	Too many entries (%d) on Services operator list; cannot add more.
OPER_OPER_REMOVED
	%s removed from Services operator list.
OPER_OPER_NOT_FOUND
	%s not found on Services operator list.
OPER_OPER_LIST_HEADER
	Services operator list:

# AKILL responses
OPER_AKILL_SYNTAX
	AKILL {ADD | DEL | LIST | VIEW} [[+expiry] mask [reason]]
OPER_AKILL_ADD_SYNTAX
	AKILL ADD [+expiry] mask reason
OPER_AKILL_DEL_SYNTAX
	AKILL DEL mask
OPER_TOO_MANY_AKILLS
	AKILL list is full!
OPER_AKILL_NO_NICK
	Reminder: AKILL masks cannot contain nicknames; 
	make sure you have not included a nick portion in your mask.
OPER_AKILL_ADDED
	%s added to AKILL list.
OPER_AKILL_REMOVED
	%s removed from AKILL list.
OPER_AKILL_NOT_FOUND
	%s not found on AKILL list.
OPER_AKILL_LIST_HEADER
	Current AKILL list:
# mask, reason
OPER_AKILL_LIST_FORMAT
	%-32s  %s
# mask, set-by, set-time, expires, reason
OPER_AKILL_VIEW_FORMAT
	%s (by %s on %s; %s)
	    %s
OPER_AKILL_NO_EXPIRE
	does not expire
OPER_AKILL_EXPIRES_SOON
	expires at next database update
OPER_AKILL_EXPIRES_M
	expires in %d minutes
OPER_AKILL_EXPIRES_1M
	expires in %d minute
OPER_AKILL_EXPIRES_HM
	expires in %d hours, %d minutes
OPER_AKILL_EXPIRES_H1M
	expires in %d hours, %d minute
OPER_AKILL_EXPIRES_1HM
	expires in %d hour, %d minutes
OPER_AKILL_EXPIRES_1H1M
	expires in %d hour, %d minute
OPER_AKILL_EXPIRES_D
	expires in %d days
OPER_AKILL_EXPIRES_1D
	expires in %d day

# SET responses
OPER_SET_SYNTAX
	SET option setting
OPER_SET_IGNORE_ON
	Ignore code will be used.
OPER_SET_IGNORE_OFF
	Ignore code will not be used.
OPER_SET_IGNORE_ERROR
	Setting for IGNORE must be ON or OFF.
OPER_SET_READONLY_ON
	Services is now in read-only mode.
OPER_SET_READONLY_OFF
	Services is now in read-write mode.
OPER_SET_READONLY_ERROR
	Setting for READONLY must be ON or OFF.
OPER_SET_DEBUG_ON
	Services is now in debug mode.
OPER_SET_DEBUG_OFF
	Services is now in non-debug mode.
OPER_SET_DEBUG_LEVEL
	Services is now in debug mode (level %d).
OPER_SET_DEBUG_ERROR
	Setting for DEBUG must be ON, OFF, or a positive number.
OPER_SET_UNKNOWN_OPTION
	Unknown option %s.

# JUPE responses
OPER_JUPE_SYNTAX
	JUPE servername [reason]

# RAW responses
OPER_RAW_SYNTAX
	RAW text

# UPDATE responses
OPER_UPDATING
	Updating databases.

# RESTART responses
OPER_CANNOT_RESTART
	SERVICES_BIN not defined; cannot restart.  Rerun the \2configure\2 script and recompile Services to enable the RESTART command.

# LISTIGNORE responses
OPER_IGNORE_LIST
	Services ignore list:
OPER_IGNORE_LIST_EMPTY
	Ignore list is empty.

###########################################################################
#
# News system messages
#
###########################################################################

NEWS_LOGON_TEXT
	[Logon News - %s] %s
NEWS_OPER_TEXT
	[Oper News - %s] %s

NEWS_LOGON_SYNTAX
	Syntax: LOGONNEWS {ADD|DEL|LIST} [text|num]
NEWS_LOGON_LIST_HEADER
	Logon news items:
NEWS_LOGON_LIST_ENTRY
	%5d (%s by %s)
	    %s
NEWS_LOGON_LIST_NONE
	There is no logon news.
NEWS_LOGON_ADD_SYNTAX
	Syntax: LOGONNEWS ADD text
NEWS_LOGON_ADD_FULL
	News list is full!
NEWS_LOGON_ADDED
	Added new logon news item (#%d).
NEWS_LOGON_DEL_SYNTAX
	Syntax: LOGONNEWS DEL {num | ALL}
NEWS_LOGON_DEL_NOT_FOUND
	Logon news item #%d not found!
NEWS_LOGON_DELETED
	Logon news item #%d deleted.
NEWS_LOGON_DEL_NONE
	No logon news items to delete!
NEWS_LOGON_DELETED_ALL
	All logon news items deleted.

NEWS_OPER_SYNTAX
	Syntax: OPERNEWS {ADD|DEL|LIST} [text|num]
NEWS_OPER_LIST_HEADER
	Oper news items:
NEWS_OPER_LIST_ENTRY
	%5d (%s by %s)
	    %s
NEWS_OPER_LIST_NONE
	There is no oper news.
NEWS_OPER_ADD_SYNTAX
	Syntax: OPERNEWS ADD text
NEWS_OPER_ADD_FULL
	News list is full!
NEWS_OPER_ADDED
	Added new oper news item (#%d).
NEWS_OPER_DEL_SYNTAX
	Syntax: OPERNEWS DEL {num | ALL}
NEWS_OPER_DEL_NOT_FOUND
	Oper news item #%d not found!
NEWS_OPER_DELETED
	Oper news item #%d deleted.
NEWS_OPER_DEL_NONE
	No oper news items to delete!
NEWS_OPER_DELETED_ALL
	All oper news items deleted.

NEWS_HELP_LOGON
	Syntax: LOGONNEWS ADD text
	        LOGONNEWS DEL {num | ALL}
	        LOGONNEWS LIST
	
	Edits or displays the list of logon news messages.  When a
	user connects to the network, these messages will be sent
	to them.  (However, no more than three messages will be
	sent in order to avoid flooding the user.  If there are
	more than three news messages, only the three most recent
	will be sent.)
	
	LOGONNEWS LIST may be used by any IRC operator to list the
	current news messages.  ADD and DEL may only be used by
	Services admins.

NEWS_HELP_OPER
	Syntax: OPERNEWS ADD text
	        OPERNEWS DEL {num | ALL}
	        OPERNEWS LIST
	
	Edits or displays the list of oper news messages.  When a
	user opers up (with the /OPER command), these messages will
	be sent to them.  (However, no more than three messages will
	be sent in order to avoid flooding the user.  If there are
	more than three news messages, only the three most recent
	will be sent.)
	
	OPERNEWS LIST may be used by any IRC operator to list the
	current oper news messages.  ADD and DEL may only be used by
	Services admins.

###########################################################################
#
# NickServ help messages
#
###########################################################################

NICK_HELP
	%S allows you to "register" a nickname and
	prevent others from using it.  If the nick is not used for
	%d days, the registration will expire.  The following
	commands allow for registration and maintenance of
	nicknames; to use them, type /%S command.
	For more information on a specific command, type
	/%S HELP command.
	
	    AJOIN      Modify your autojoin channel list
	    REGISTER   Register a nickname
	    IDENTIFY   Identify yourself with your password
	    LINK       Make your nick an alias for another
	    SET        Set options
	    DROP       Cancel the registration of a nickname
	    LISTLINKS  Lists the nicks linked to your nick
	    NOTES      Allows you to store text notes
	    GHOST     Kills a ghost connection for the nick

	Other commands: UNLINK, INFO, LIST, STATUS
	
	NOTICE: This service is intended to provide a way for
	IRC users to ensure their identity is not compromised.
	It is NOT intended to facilitate "stealing" of
	nicknames or other malicious actions.  Abuse of %S
	will result in, at minimum, loss of the abused
	nickname(s).

NICK_HELP_EXPIRE_ZERO
	%S allows you to "register" a nickname and
	prevent others from using it.  The following commands allow
	for registration and maintenance of nicknames; to use them,
	type /%S command. For more information on a
	specific command, type /%S HELP command.
	
	    REGISTER   Register a nickname
	    IDENTIFY   Identify yourself with your password
	    LINK       Make your nick an alias for another
	    SET        Set options, including kill protection
	    DROP       Cancel the registration of a nickname
	
	Other commands: UNLINK, GHOST, INFO, LIST, STATUS
	
	NOTICE: This service is intended to provide a way for
	IRC users to ensure their identity is not compromised.
	It is NOT intended to facilitate "stealing" of
	nicknames or other malicious actions.  Abuse of %S
	will result in, at minimum, loss of the abused
	nickname(s).

NICK_HELP_REGISTER
	Syntax: REGISTER password email
	
	Registers your nickname in the %S database.
	If you dont have an email account use the word NOMAIL.
	as email. Once your nick is registered, you can use 
	the SET command to configure your nick's settings 
	as you like them.  
	Make sure you remember the password you use when
	registering - you'll need it to make changes to your nick
	later.  (Note that case matters!  FIDO, Fido, and fido
	are all different passwords!)
	
	Guidelines on choosing passwords:
	
	Passwords should not be easily guessable.  For example,
	using your real name as a password is a bad idea.  Using
	your nickname as a password is a much worse idea ;) and,
	in fact, %S will not allow it.  Also, short
	passwords are vulnerable to trial-and-error searches, so
	you should choose a password at least 5 characters long.
	Finally, the space character cannot be used in passwords.

NICK_HELP_IDENTIFY
	Syntax: IDENTIFY password [ NOJOIN ]
	
	Tells %S that you are really the owner of this
	nick.  Many commands require you to authenticate yourself
	with this command before you use them.  The password
	should be the same one you sent with the REGISTER
	command.
	If NOJOIN is used, you will not join on the autojoin 
	channels list.

NICK_HELP_DROP
	Syntax: DROP
	
	Drops your nickname from the %S database.  A nick
	that has been dropped is free for anyone to re-register.
	
	In order to use this command, you must first identify
	with your password (/%S HELP IDENTIFY for more
	information).

NICK_HELP_LINK
	Syntax: LINK nick password
	
	Links your nickname to another, effectively making the nick
	you are currently using an alias for the given nick.  When
	you give this command, the ajoin list for the nick you are
	using is deleted and replaced by that of the nick you are
	linking to; all memos for your current nick are added to
	the list of memos for the target nick (this may cause the
	nick to exceed its limit of memos, in which case you will
	need to delete some before you can receive more for either
	nick).
	
	Once the link has been established, your nick will be
	transparently converted into the target nick everywhere in
	Services, except for the %S UNLINK and DROP commands.  For
	example, you can use either nick to read the same set of
	memos (and memos sent to either nick will go into the same
	list).  If you identify for one nick, you will
	automatically be identified for the other as well.  If
	either nick is on a channel's access list, then both nicks
	will get the same access privileges.
	
	In order to use this command, you must identify for your
	current nick (using the IDENTIFY command), and you must
	supply the password for the nick you wish to link to.

NICK_HELP_UNLINK
	Syntax: UNLINK [nick pass]
	
	Removes a link from your nick to another.  When the link is
	removed, the nickname flags and ajoin list of the
	previously linked nick are copied to your current nick and
	can then be independently changed.  Memos are not copied;
	all memos will remain stored with the previously linked
	nick.
	
	By giving a nickname and password as parameters, you can
	unlink a nick besides the one you are currently using.

NICK_HELP_SET
	Syntax: SET option parameters
	
	Sets various nickname options.  option can be one of:
	
	    PASSWORD   Set your nickname password
	    LANGUAGE   Set the language Services will use when
	                   sending messages to you
	    URL        Associate a URL with your nickname
	    EMAIL      Associate an E-mail address with your nickname
	    ICQNUMBER  Associate an ICQ number with your nickname
	    LOCATION   Associate a location with your nickname
	    KILL       Turn kill protection on or off
	    PRIVATE    Prevent your nickname from appearing in a
	                   /%S LIST
	    HIDE       Hide certain pieces of nickname information
	    AUTOJOIN   Turn ajoin on or off
	    NEWSLETTER Enable/disable newsletter reception
	    PRIVMSG    Enable/disable privmsg from services
		
	In order to use this command, you must first identify
	with your password (/%S HELP IDENTIFY for more
	information).
	
	Type /%S HELP SET option for more information
	on a specific option.

NICK_HELP_SET_PASSWORD
	Syntax: SET PASSWORD new-password
	
	Changes the password used to identify you as the nick's
	owner.

NICK_HELP_SET_LANGUAGE
	Syntax: SET LANGUAGE number
	
	Changes the language Services uses when sending messages to
	you (for example, when responding to a command you send).
	number should be chosen from the following list of
	supported languages:
	

NICK_HELP_SET_URL
	Syntax: SET URL url
	
	Associates the given URL with your nickname.  This URL
	will be displayed whenever someone requests information
	on your nick with the INFO command.

NICK_HELP_SET_EMAIL
	Syntax: SET EMAIL address
	
	Associates the given E-mail address with your nickname.
	This address will be displayed whenever someone requests
	information on the channel with the INFO command.

NICK_HELP_SET_ICQ
	Syntax: SET ICQNUMBER  #number
	
	Associates the given ICQ number with your nickname.
	This number will be displayed whenever someone requests
	information about the nick with the INFO command.
NICK_HELP_SET_LOCATION
	Syntax: SET LOCATION  location
	
	Associates the given location with your nickname.
	This location will be displayed whenever someone requests
	information about the nick with the INFO command.
NICK_HELP_SET_KILL
	Syntax: SET KILL {ON | QUICK | IMMED | OFF}
	
	Turns the automatic kill protection option for your nick
	on or off.  With kill protection on, if another user
	tries to take your nick, they will be given one minute to
	change to another nick, after which they will be forcibly
	removed from IRC by %S.
	
	If you select QUICK, the user will be given only 20 seconds
	to change nicks instead of the usual 60.  If you select
	IMMED, the user will be killed immediately without being
	warned first or given a chance to change their nick; please
	do not use this option unless necessary.  Also, your
	network's administrators may have disabled this option.

NICK_HELP_SET_PRIVATE
	Syntax: SET PRIVATE {ON | OFF}
	
	Turns %S's privacy option on or off for your nick.
	With PRIVATE set, your nickname will not appear in
	nickname lists generated with %S's LIST command.
	(However, anyone who knows your nickname can still get
	information on it using the INFO command.)

NICK_HELP_SET_HIDE
	Syntax: SET HIDE {EMAIL | QUIT} {ON | OFF}
	
	Allows you to prevent certain pieces of information from
	being displayed when someone does a %S INFO on your
	nick.  You can hide your E-mail address (EMAIL)
	and last quit message (QUIT).
	The second parameter specifies whether the information should
	be displayed (OFF) or hidden (ON).

NICK_HELP_GHOST
	Syntax: GHOST nickname [password]
	
	Terminates a "ghost" IRC session using your nick.  A
	"ghost" session is one which is not actually connected,
	but which the IRC server believes is still online for one
	reason or another.  Typically, this happens if your
	computer crashes or your Internet or modem connection
	goes down while you're on IRC.
	
	In order to use the GHOST command for a nick, 
	you must supply the correct password for the nickname.

NICK_HELP_INFO
	Syntax: INFO nickname
	
	Displays information about the given nickname, such as
	the nick's owner, last seen address and time, and nick
	options.

NICK_HELP_LIST
	Syntax: LIST pattern
	
	Lists all registered nicknames which match the given
	pattern, in nick!user@host format.  Nicks with the
	PRIVATE option set will not be displayed.
	
	Examples:
	
	    LIST *!joeuser@foo.com
	        Lists all nicks owned by joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Lists all registered nicks with Bot in their
	        names (case insensitive).
	
	    LIST *!*@*.bar.org
	        Lists all nicks owned by users in the bar.org
	        domain.

NICK_HELP_STATUS
	Syntax: STATUS nickname...
	
	Returns whether the user using the given nickname is
	recognized as the owner of the nickname.  The response has
	this format:
	
	    nickname status-code
	
	where nickname is the nickname sent with the command, and
	status-code is one of the following:
	
	    0 - no such user online or nickname not registered
	    1 - user not recognized as nickname's owner
	    2 - user recognized as owner via mode identification
	    3 - user recognized as owner via password identification
	
	Up to sixteen nicknames may be sent with each command; the
	rest will be ignored.  No error message is generated if no
	nickname is given.

NICK_SERVADMIN_HELP
	
	The following commands are available to Services admins:
	
	    GETPASS     Retrieve the password for a nickname
	                   (only if encryption is disabled)
	    FORBID      Prevent a nickname from being used
	    LISTLINKS   Lists all nick links for a given nick

	
	Services admins can also drop any nickname without needing
	to identify for the nick, and may view the ajoin list for
	any nickname (/%S AJOIN LIST nick).

NICK_SERVADMIN_HELP_DROP
	Syntax: DROP [nickname]
	
	Without a parameter, drops your nickname from the
	%S database.
	
	With a parameter, drops the named nick from the database.
	This use limited to Services admins.

NICK_SERVADMIN_HELP_SET
	
	Services admins can also set the option NOEXPIRE, with
	which nicknames can be prevented from expiring.
	Additionally, Services admins can set options for any
	nickname without entering a password, using the format
	SET nickname option parameters.

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET [nickname] NOEXPIRE {ON | OFF}
	
	Sets whether the given nickname will expire.  Setting this
	to ON prevents the nickname from expiring.  If no
	nickname is given, sets the no-expire flag for your nick.
	
	Limited to Services admins.

NICK_SERVADMIN_HELP_UNLINK
	
	Services admins may unlink any nick without entering a
	password.

NICK_HELP_LISTLINKS
	Syntax: LISTLINKS
	
	Lists nicks which are linked to the given nick.  

NICK_SERVADMIN_HELP_LISTLINKS
	Syntax: LISTLINKS nick [ALL]
	
	Lists nicks which are linked to the given nick.  If ALL is
	specified, lists all nicks with the same privileges as the
	given nick; otherwise, lists only those nicks which are
	directly linked to the given nick.

NICK_SERVADMIN_HELP_LIST
	Syntax: LIST pattern [FORBIDDEN] [NOEXPIRE]
	
	Lists all registered nicknames which match the given
	pattern, in nick!user@host format.  Nicks with the PRIVATE
	option set will only be displayed to Services admins.  Nicks
	with the NOEXPIRE option set will have a ! prepended to the
	nickname for Services admins.
	
	If the FORBIDDEN or NOEXPIRE options are given, only nicks
	which, respectively, are FORBIDden or have the NOEXPIRE flag
	set will be displayed.  If both options are given, both
	types of nicks will be displayed.  These options are limited
	to Services admins.
	
	Examples:
	
	    LIST *!joeuser@foo.com
	        Lists all registered nicks owned by joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Lists all registered nicks with Bot in their
	        names (case insensitive).
	
	    LIST * NOEXPIRE
	        Lists all registered nicks which have been set to
	        not expire.

NICK_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS nickname
	
	Returns the password for the given nickname.  Note that
	whenever this command is used, a message including the
	person who issued the command and the nickname it was used
	on will be logged and sent out as a WALLOPS/GLOBOPS.
	
	Limited to Services admins.
	
	This command is unavailable when encryption is enabled.

NICK_SERVADMIN_HELP_FORBID
	Syntax: FORBID nickname
	
	Disallows a nickname from being registered or used by
	anyone.  May be cancelled by dropping the nick.
	
	Limited to Services admins.

###########################################################################
#
# ChanServ help messages
#
###########################################################################

CHAN_HELP
	%S allows you to register and control various
	aspects of channels.  %S can often prevent
	malicious users from "taking over" channels by limiting
	who is allowed channel operator priviliges.  Available
	commands are listed below; to use them, type
	/%S command.  For more information on a
	specific command, type /%S HELP command.
	
	    REGISTER   Register a channel
	    IDENTIFY   Identify yourself with your password
	    SET        Set channel options and information
	    ACCESS     Modify the list of privileged users
	    AOP/SOP    Alias to modify the list of privileged users
	    LEVELS     Redefine the meanings of access levels
	    AKICK      Maintain the AutoKick list
	    DROP       Cancel the registration of a channel
	
	Other commands: INFO, LIST, INVITE, OP, DEOP, UNBAN,
	                KICK, CLEAR, VOICE, DEVOICE

CHAN_HELP_EXPIRES
	
	Note that any channel which is not used for %d days
	(i.e. which no user on the channel's access list enters
	for that period of time) will be automatically dropped.

CHAN_HELP_REGISTER
	Syntax: REGISTER channel password description
	
	Registers a channel in the %S database.  In order
	to use this command, you must first be a channel operator
	on the channel you're trying to register.  The password
	is used with the IDENTIFY command to allow you to
	make changes to the channel settings at a later time.
	The last parameter, which must be included, is a
	general description of the channel's purpose.
	
	When you register a channel, you are recorded as the
	"founder" of the channel.  The channel founder is allowed
	to change all of the channel settings for the channel;
	%S will also automatically give the founder
	channel-operator privileges when s/he enters the channel.
	See the ACCESS command (/%S HELP ACCESS) for
	information on giving a subset of these privileges to
	other channel users.
	
	NOTICE: In order to register a channel, you must have
	first registered your nickname.  If you haven't,
	/%s HELP for information on how to do so.

CHAN_HELP_IDENTIFY
	Syntax: IDENTIFY channel password
	
	Authenticates you to %S as the founder of the given
	channel.  Many commands require you to use this command
	before using them.  The password should be the same one
	you sent with the REGISTER command.

CHAN_HELP_DROP
	Syntax: DROP channel
	
	Unregisters the named channel.  Can only be used by
	channel founder, who must use the IDENTIFY command first.

CHAN_HELP_SET
	Syntax: SET channel option parameters
	
	Allows the channel founder to set various channel options
	and other information.  The founder must use the IDENTIFY
	command before using SET.
	
	Available options:
	
	    FOUNDER     Set the founder of a channel
	    SUCCESSOR   Set the successor for a channel
	    PASSWORD    Set the founder password
	    DESC        Set the channel description
	    URL         Associate a URL with the channel
	    EMAIL       Associate an E-mail address with the channel
	    ENTRYMSG    Set a message to be sent to users when they
	                   enter the channel
	    TOPIC       Change the topic on the channel
	    KEEPTOPIC   Retain topic when channel is not in use
	    TOPICLOCK   Topic can only be changed with SET TOPIC
	    MLOCK       Lock channel modes on or off
	    PRIVATE     Hide channel from LIST command
	    RESTRICTED  Restrict access to the channel
	    SECUREOPS   Stricter control of chanop status
	    LEAVEOPS    Never de-op users except with DEOP command
	    OPNOTICE    Send a notice when OP/DEOP commands are used
	    NOLINKS     Ignore access list recognition on linked nicks.
	    TOPICENTRY  Uses channel topic for entry-msg
	
	Type /%S HELP option for more information on a
	particular option.

CHAN_HELP_SET_FOUNDER
	Syntax: SET channel FOUNDER nick
	
	Changes the founder of a channel.  The new nickname must
	be a registered one.

CHAN_HELP_SET_SUCCESSOR
	Syntax: SET channel SUCCESSOR nick
	
	Changes the successor of a channel.  If the founder's
	nickname expires or is dropped while the channel is still
	registered, the successor will become the new founder of the
	channel.  However, if the successor already has too many
	channels registered (%d), the channel will be dropped
	instead, just as if no successor had been set.  The new
	nickname must be a registered one.

CHAN_HELP_SET_PASSWORD
	Syntax: SET channel PASSWORD password
	
	Sets the password used to identify as the founder of the
	channel.

CHAN_HELP_SET_DESC
	Syntax: SET channel DESC description
	
	Sets the description for the channel, which shows up with
	the LIST and INFO commands.

CHAN_HELP_SET_URL
	Syntax: SET channel URL [url]
	
	Associates the given URL with the channel.  This URL will
	be displayed whenever someone requests information on the
	channel with the INFO command.  If no parameter is given,
	deletes any current URL for the channel.

CHAN_HELP_SET_EMAIL
	Syntax: SET channel EMAIL [address]
	
	Associates the given E-mail address with the channel.
	This address will be displayed whenever someone requests
	information on the channel with the INFO command.  If no
	parameter is given, deletes any current E-mail address for
	the channel.

CHAN_HELP_SET_ENTRYMSG
	Syntax: SET channel ENTRYMSG [message]
	
	Sets the message which will be sent via /notice to users
	when they enter the channel.  If no parameter is given,
	causes no message to be sent upon entering the channel.

CHAN_HELP_SET_TOPIC
	Syntax: SET channel TOPIC topic
	
	Causes %S to set the channel topic to the one
	specified.  This command is most useful in conjunction
	with SET TOPICLOCK.

CHAN_HELP_SET_KEEPTOPIC
	Syntax: SET channel KEEPTOPIC {ON | OFF}
	
	Enables or disables the topic retention option for a
	channel.  When topic retention is set, the topic for the
	channel will be remembered by %S even after the
	last user leaves the channel, and will be restored the
	next time the channel is created.

CHAN_HELP_SET_TOPICLOCK
	Syntax: SET channel TOPICLOCK {ON | OFF}
	
	Enables or disables the topic lock option for a channel.
	When topic lock is set, %S will not allow the
	channel topic to be changed except via the SET TOPIC
	command.

CHAN_HELP_SET_MLOCK
	Syntax: SET channel MLOCK modes
	
	Sets the mode-lock parameter for the channel.  %S
	allows you to define certain channel modes to be always
	on (or off).  The modes that can be locked are i, k, l,
	m, n, p, s, and t; each of these modes can be locked on,
	locked off, or not locked.  The modes parameter is
	constructed exactly the same way as a /MODE command; that
	is, modes followed by a + are locked on, and modes
	followed by a - are locked off.
	
	Warning:  If you set a mode-locked key, as in the second
	example below, you should also set the RESTRICTED option for
	the channel (see HELP SET RESTRICTED), or anyone entering
	the channel when it is empty will be able to see the key!
	
	Examples:
	
	    SET #channel MLOCK +nt-iklps
	        Forces modes n and t on, and modes i, k, l, p, and
	        s off.  Mode m is left free to be either on or off.
	
	    SET #channel MLOCK +knst-ilmp my-key
	        Forces modes k, n, s, and t on, and modes i, l, m,
	        and p off.  Also forces the channel key to be
	        "my-key".
	
	    SET #channel MLOCK +
	        Removes the mode lock; all channel modes are free
	        to be either on or off.

CHAN_HELP_SET_PRIVATE
	Syntax: SET channel PRIVATE {ON | OFF}
	
	Enables or disables the private option for a channel.
	When private is set, a /%S LIST will not
	include the channel in any lists.

CHAN_HELP_SET_RESTRICTED
	Syntax: SET channel RESTRICTED {ON | OFF}
	
	Enables or disables the restricted access option for a
	channel.  When restricted access is set, users who would
	normally be disallowed from having channel operator
	privileges (users with negative access levels and, if
	secure ops is set, users not on the access list) will
	instead be kicked and banned from the channel.

CHAN_HELP_SET_SECUREOPS
	Syntax: SET channel SECUREOPS {ON | OFF}
	
	Enables or disables the secure ops option for a channel.
	When secure ops is set, users who are not on the userlist
	will not be allowed chanop status.

CHAN_HELP_SET_LEAVEOPS
	Syntax: SET channel LEAVEOPS {ON | OFF}
	
	Enables or disables the leave ops option for a channel.
	When leave ops is set, ChanServ will never de-op a user in
	that channel except with the DEOP command.

CHAN_HELP_SET_OPNOTICE
	Syntax: SET channel OPNOTICE {ON | OFF}
	
	Enables or disables the op-notice option for a channel.
	When op-notice is set, ChanServ will send a notice to the
	channel whenever the OP or DEOP commands are used for a user
	in the channel.

CHAN_HELP_SET_NOLINKS
	Syntax: SET channel NOLINKS {ON | OFF}
	
	Enables or disables the NOLINKS option for a channel.
	When op-notice is set, ChanServ will just recoginze
	real nicks as beeing on the access level for that channel.
	This means a nick linked to another found on the access 
	list will not be recognized as so.

CHAN_HELP_SET_TOPICENTRY
	Syntax: SET channel TOPICENTRY {ON | OFF}
	
	Enables or disables the TOPICENTRY option for a channel.
	When TOPICENTRY is set, ChanServ will use the channel topic
	to override the entry-msg setting during an user join.


CHAN_HELP_ACCESS
	Syntax: ACCESS channel ADD nick level
	        ACCESS channel DEL {nick | entry-num | list | ALL }
	        ACCESS channel LIST [mask | list]
	
	Maintains the access list for a channel.  The access
	list specifies which users are allowed chanop status or
	access to %S commands on the channel.  Different
	user levels allow for access to different subsets of
	privileges; /%S HELP ACCESS LEVELS for more
	specific information.  Any nick not on the access list has
	a user level of 0.
	
	The ACCESS ADD command adds the given nickname to the
	access list with the given user level; if the nick is
	already present on the list, its access level is changed to
	the level specified in the command.  The level specified
	must be less than that of the user giving the command, and
	if the nick is already on the access list, the current
	access level of that nick must be less than the access level
	of the user giving the command.
	
	The ACCESS DEL command removes the given nick from the
	access list.  If a list of entry numbers is given, those
	entries are deleted.  (See the example for LIST below.)
	Using ALL will delete all enrtries, is resctricted to
	founder use.
	
	The ACCESS LIST command displays the access list.  If
	a wildcard mask is given, only those entries matching the
	mask are displayed.  If a list of entry numbers is given,
	only those entries are shown; for example:

	   ACCESS #channel LIST 2-5,7-9
	      Lists access entries numbered 2 through 5 and
	      7 through 9.

CHAN_HELP_ACCESS_LEVELS
	User access levels
	
	By default, the following access levels are defined:
	
	   Founder   Full access to %S functions; automatic
	                     opping upon entering channel.  Note
	                     that only one person may have founder
	                     status (it cannot be given using the
	                     ACCESS command).
	        10   Access to AKICK command; automatic opping.
	         5   Automatic opping.
	         3   Automatic voicing.
	         0   No special privileges; can be opped by other
	                     ops (unless secure-ops is set).
	        <0   May not be opped.
	
	These levels may be changed, or new ones added, using the
	LEVELS command; type /%S HELP LEVELS for
	information.

CHAN_HELP_AKICK
	Syntax: AKICK channel ADD mask [reason]
	        AKICK channel DEL [ mask | ALL ]
	        AKICK channel LIST [mask]
	
	Maintains the AutoKick list for a channel.  If a user
	on the AutoKick list attempts to join the channel,
	%S will ban that user from the channel, then kick
	the user.
	
	The AKICK ADD command adds the given nick or usermask
	to the AutoKick list.  If a reason is given with
	the command, that reason will be used when the user is
	kicked; if not, the default reason is "You have been
	banned from the channel".
	
	The AKICK DEL command removes the given nick or mask
	from the AutoKick list.  It does not, however, remove any
	bans placed by an AutoKick; those must be removed
	manually. Using ALL will remove all akick entries, it is
	restricted to founder use.
	
	The AKICK LIST command displays the AutoKick list, or
	optionally only those AutoKick entries which match the
	given mask.

CHAN_HELP_LEVELS
	Syntax: LEVELS channel SET type level
	        LEVELS channel {DIS | DISABLE} type
	        LEVELS channel LIST
	        LEVELS channel RESET
	
	The LEVELS command allows fine control over the meaning of
	the numeric access levels used for channels.  With this
	command, you can define the access level required for most
	of %S's functions.  (The SET FOUNDER and SET PASSWORD
	commands, as well as this command, are always restricted to
	the channel founder.)
	
	LEVELS SET allows the access level for a function or group of
	functions to be changed.  LEVELS DISABLE (or DIS for short)
	disables an automatic feature or disallows access to a
	function by anyone other than the channel founder.
	LEVELS LIST shows the current levels for each function or
	group of functions.  LEVELS RESET resets the levels to the
	default levels of a newly-created channel (see
	HELP ACCESS LEVELS).
	
	For a list of the features and functions whose levels can be
	set, see HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	The following feature/function names are understood.  Note
	that the levels for AUTODEOP and NOJOIN are maximum levels,
	while all others are minimum levels.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Syntax: INFO channel
	
	Lists information about the named registered channel,
	including its founder, time of registration, last time
	used, description, and mode lock, if any.

CHAN_HELP_LIST
	Syntax: LIST pattern
	
	Lists all registered channels matching the given pattern.
	(Channels with the PRIVATE option set are not listed.)

CHAN_HELP_OP
	Syntax: OP #channel nick
	
	Ops a selected nick on a channel.  By default, limited to
	those with level 5 access and above on the channel.

CHAN_HELP_DEOP
	Syntax: DEOP #channel nick
	
	Deops a selected nick on a channel.  By default, limited to
	those with level 5 access and above on the channel.

CHAN_HELP_KICK
	Syntax: KICK #channel nick reason
	
	Kicks a user from a channel with chanserv. By default, limited to 
	those with level 5 access and above on the channel.

CHAN_HELP_INVITE
	Syntax: INVITE channel
	
	Tells %S to invite you into the given channel.  By
	default, only works if your access level on that channel is
	greater than zero.

CHAN_HELP_UNBAN
	Syntax: UNBAN channel
	
	Tells %S to remove all bans preventing you from
	entering the given channel.  By default, only works if your
	access level on that channel is greater than zero.

CHAN_HELP_CLEAR
	Syntax: CLEAR channel what
	
	Tells %S to clear certain settings on a channel.  what
	can be any of the following:
	
	     MODES    Resets all modes on the channel (i.e. clears
	                  modes i,k,l,m,n,p,s,t).
	     BANS     Clears all bans on the channel.
	     OPS      Removes channel-operator status (mode +o) from
	                  all channel operators.
	     VOICES   Removes "voice" status (mode +v) from anyone
	                  with that mode set.
	     USERS    Removes (kicks) all users from the channel.
	
	By default, your access level on the channel must be at
	least 10 to use this command.

CHAN_SERVADMIN_HELP
	
	The following commands are available to Services admins:
	
	    GETPASS    Retrieve the founder password for a channel
	                   (only if encryption is disabled)
	    FORBID     Prevent a channel from being used
	    STATUS     Returns the current access level of a user
	                   on a channel
	
	Services admins can also drop any channel without needing
	to identify via password, and may view the access, AKICK,
	and level setting lists for any channel.

CHAN_SERVADMIN_HELP_DROP
	Syntax: DROP channel
	
	Unregisters the named channel.  Only Services admins
	can drop a channel for which they have not identified.

CHAN_SERVADMIN_HELP_SET
	
	Services admins can also set the option NOEXPIRE, with
	which channels can be prevented from expiring.
	Additionally, Services admins can set options for any
	channel without identifying by password for the channel.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET channel NOEXPIRE {ON | OFF}
	
	Sets whether the given channel will expire.  Setting this
	to ON prevents the channel from expiring.
	
	Limited to Services admins.

CHAN_SERVADMIN_HELP_LIST
	Syntax: LIST pattern
	
	Lists all registered channels matching the given pattern.
	Channels with the PRIVATE option set will only be displayed
	to Services admins.

CHAN_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS channel
	
	Returns the password for the given channel.  Note that
	whenever this command is used, a message including the
	person who issued the command and the channel it was used
	on will be logged and sent out as a WALLOPS/GLOBOPS.
	
	Limited to Services admins.

CHAN_SERVADMIN_HELP_FORBID
	Syntax: FORBID channel
	
	Disallows anyone from registering or using the given
	channel.  May be cancelled by dropping the channel.
	
	Limited to Services admins.

CHAN_SERVADMIN_HELP_STATUS
	Syntax: STATUS channel nickname
	
	Returns the current access level of the given nick on the
	given channel.  The reply is of the form:
	
	    STATUS channel nickname access-level
	
	If an error occurs, the reply will be in the form:
	
	    STATUS ERROR error-message
	
	Limited to Services admins.

###########################################################################
#
# MemoServ help messages
#
###########################################################################

MEMO_HELP
	%S is a utility allowing IRC users to send short
	messages to other IRC users, whether they are online at
	the time or not, or to channels(*).  Both the sender's
	nickname and the target nickname or channel must be
	registered in order to send a memo.
	
	%S's commands include:
	
	    SEND   Send a memo to a nick or channel
	    LIST   List your memos
	    READ   Read a memo or memos
	    DEL    Delete a memo or memos
	    SET    Set options related to memos
	    INFO   Display info related to memos
	
	Type /%S HELP command for help on any of the
	above commands.
	
	(*) By default, any user with at least level 10 access on a
	    channel can read that channel's memos.  This can be
	    changed with the %s LEVELS command.

MEMO_HELP_SEND
	Syntax: SEND {nick | channel} memo-text
	
	Sends the named nick or channel a memo containing
	memo-text.  When sending to a nickname, the recipient will
	receive a notice that he/she has a new memo.  The target
	nickname/channel must be registered.
	
	Prefixing the message with ? will notify you when 
	the memo is read with the memo sent back between -( )-

MEMO_HELP_LIST
	Syntax: LIST [channel] [list | NEW]
	
	Lists any memos you currently have.  With NEW, lists only
	new (unread) memos.  Unread memos are marked with a "*"
	to the left of the memo number.  You can also specify a list
	of numbers, as in the example below:

	   LIST 2-5,7-9
	      Lists memos numbered 2 through 5 and 7 through 9.

MEMO_HELP_READ
	Syntax: READ [channel] {num | list | LAST | NEW}
	
	Sends you the text of the memos specified.  If LAST is
	given, sends you the memo you most recently received.  If
	NEW is given, sends you all of your new memos.  Otherwise,
	sends you memo number num.  You can also give a list of
	numbers, as in this example:
	
	   READ 2-5,7-9
	      Displays memos numbered 2 through 5 and 7 through 9.

MEMO_HELP_DEL
	Syntax: DEL [channel] {num | list | ALL}
	
	Deletes the specified memo or memos.  You can supply
	multiple memo numbers or ranges of numbers instead of a
	single number, as in the second example below.
	
	If ALL is given, deletes all of your memos.
	
	Examples:
	
	   DEL 1
	      Deletes your first memo.
	
	   DEL 2-5,7-9
	      Deletes memos numbered 2 through 5 and 7 through 9.

MEMO_HELP_SET
	Syntax: SET option parameters
	
	Sets various memo options.  option can be one of:
	
	    NOTIFY      Changes when you will be notified about
	                    new memos (only for nicknames)
	    LIMIT       Sets the maximum number of memos you can
	                    receive
	
	Type /%S HELP SET option for more information
	on a specific option.

MEMO_HELP_SET_NOTIFY
	Syntax: SET NOTIFY {ON | LOGON | NEW | OFF}
	
	Changes when you will be notified about new memos:
	
	    ON      You will be notified of memos when you log on,
	               when you unset /AWAY, and when they are sent
	               to you.
	    LOGON   You will only be notified of memos when you log
	               on or when you unset /AWAY.
	    NEW     You will only be notified of memos when they
	               are sent to you.
	    OFF     You will not receive any notification of memos.
	
	ON is essentially LOGON and NEW combined.

MEMO_HELP_SET_LIMIT
	Syntax: SET LIMIT [channel] limit
	
	Sets the maximum number of memos you (or the given channel)
	are allowed to have. If you set this to 0, no one will be
	able to send any memos to you.  However, you cannot set
	this any higher than %d.

MEMO_HELP_INFO
	Syntax: INFO [channel]
	
	Displays information on the number of memos you have, how
	many of them are unread, and how many total memos you can
	receive.  With a parameter, displays the same information
	for the given channel.

MEMO_SERVADMIN_HELP_SET_LIMIT
	Syntax: SET LIMIT [user | channel] {limit | NONE} [HARD]
	
	Sets the maximum number of memos a user or channel is
	allowed to have.  Setting the limit to 0 prevents the user
	from receiving any memos; setting it to NONE allows the
	user to receive and keep as many memos as they want.  If
	you do not give a nickname or channel, your own limit is
	set.
	
	Adding HARD prevents the user from changing the limit.  Not
	adding HARD has the opposite effect, allowing the user to
	change the limit (even if a previous limit was set with
	HARD).
	
	This use of the SET LIMIT command is limited to Services
	admins.  Other users may only enter a limit for themselves
	or a channel on which they have such privileges, may not
	remove their limit, may not set a limit above %d, and may
	not set a hard limit.

MEMO_SERVADMIN_HELP_INFO
	Syntax: INFO [nick | channel]
	
	Without a parameter, displays information on the number of
	memos you have, how many of them are unread, and how many
	total memos you can receive.
	
	With a channel parameter, displays the same information for
	the given channel.
	
	With a nickname parameter, displays the same information
	for the given nickname.  This use limited to Services
	admins.

###########################################################################
#
# OperServ help messages
#
###########################################################################

OPER_HELP
	%S commands:
	    GLOBAL      Send a message to all users
	    STATS       Show status of Services and network
	    OPER LIST   List all Services operators
	    ADMIN LIST  List all Services admins
	
	Commands available to Services operators and admins only:
	    MODE        Change a channel's modes
	    KICK        Kick a user from a channel
	    AKILL       Manipulate the AKILL list
	    VLINE       Manipulate the VLINE list
	    SXLINE      Manipulate the SXLINE list
	    BOT         Manipulate BOT list.
	    SESSION     Session limiting info
	    CLEARMODES  Remove all channel modes
	    
	Commands available to Services admins only:
	    SQLINE      Manipulate the SQLINE list
	    VLINK       Manipulate the VLINK list
	    OPER        Modify the Services operator list
	    LOGONNEWS   Define messages to be shown to users at logon
	    OPERNEWS    Define messages to be shown to users who oper
	    JUPE        "Jupiter" a server
	    SET         Set various global Services options
	    GETFOUNDER  Get channel founder access privileges
	    UPDATE      Force the Services databases to be
	                    updated on disk immediately
	    QUIT        Terminate the Services program
	    SHUTDOWN    Terminate the Services program and save
	                the databases
	    RESTART     Save databases and restart Services
	    REHASH      Reloads services configuration file
	    SENDPASS    Send a nick password via email
	    SECUREMODE  Set the network in SECUREMODE
	
	Commands available to the Services super-user only:
	    RAW         Send a raw string to the IRC server
	    ADMIN       Modify the Services admin list
	
	Notice: All commands sent to %S are logged!

OPER_HELP_GLOBAL
	Syntax: GLOBAL message
	
	Allows IRCops to send messages to all users on the network.
	The message will be sent from the nick %s.

OPER_HELP_STATS
	Syntax: STATS [RECORD | AKILL | ALL]
	
	Without any option, shows the current number of users and
	IRCops online (excluding Services), the highest number of
	users online since Services was started, and the length of
	time Services has been running.
	
	With the AKILL option, displays the current size of the
	AKILL list and the current default expiry time.
	
	The ALL option is available only to Services admins, and
	displays information on Services' memory usage.  Using this
	option can freeze Services for a short period of time on
	large networks, so don't overuse it!
	
	The RECORD option shows records for total users, ops, 
	helpers, and bots count.
	
	UPTIME may be used as a synonym for STATS.

OPER_HELP_OPER
	Syntax: OPER ADD nick
	        OPER DEL nick
	        OPER LIST
	        OPER SUSPEND nick days
	
	Allows Services admins to add or remove nicknames to or from
	the Services operator list.  A user whose nickname is on the
	Services operator list and who has identified to %s
	will be able to access Services operator commands.
	
	Any IRC operator may use the OPER LIST form of the command.
	All other use is limited to Services admins.

OPER_HELP_ADMIN
	Syntax: ADMIN ADD nick
	        ADMIN DEL nick
	        ADMIN LIST
	
	Allows the Services super-user to add or remove nicknames
	to or from the Services admin list.  A user whose nickname
	is on the Services admin list and who has identified to
	%s will be able to access Services admin commands.
	
	Any IRC operator may use the ADMIN LIST form of the command.
	All other use is limited to Services root.

OPER_HELP_MODE
	Syntax: MODE channel modes
	
	Allows Services operators to set channel modes for any
	channel.  Parameters are the same as for the standard /MODE
	command.
	
	Limited to Services operators.

OPER_HELP_CLEARMODES
	Syntax: CLEARMODES channel [ALL]
	
	Clears all binary modes (i,k,l,m,n,p,s,t) and bans from a
	channel.  If ALL is given, also clears all ops and
	voices (+o and +v modes) from the channel.
	
	Limited to Services operators.

OPER_HELP_KICK
	Syntax: KICK channel user reason
	
	Allows IRCops to kick a user from any channel.
	Parameters are the same as for the standard /KICK
	command.  The kick message will have the nickname of the
	IRCop sending the KICK command prepended; for example:
	
	*** SpamMan has been kicked off channel #my_channel by %S (Alcan (Flood))
	
	Limited to Services operators.

OPER_HELP_AKILL
	Syntax: AKILL ADD [+expiry] mask reason
	        AKILL DEL mask
	        AKILL LIST [mask]
	        AKILL VIEW [mask]
	
	Allows Services operators to manipulate the AKILL list.  If
	a user matching an AKILL mask attempts to connect, Services
	will issue a KILL for that user and, on supported server
	types, will instruct all servers to add a ban (K-line) for
	the mask which the user matched.
	
	AKILL ADD adds the given user@host mask to the AKILL
	list for the given reason (which must be given).
	AKILL DEL removes the given mask from the AKILL list if it
	is present.  AKILL LIST shows all current AKILLs; if the
	optional mask is given, the list is limited to those
	AKILLs matching the mask.  AKILL VIEW is a more verbose
	version of AKILL LIST, and will show who added an AKILL,
	the date it was added, and when it expires, as well as the
	user@host mask and reason.
	
	Optionally, an expiry time can be given with the AKILL ADD
	command.  The expiry time precedes the user@host mask, and
	is specified as an integer followed by one of d (days),
	h (hours), or m (minutes).  Combinations (such as 1h30m)
	are not permitted.  If a unit specifier is not included,
	the default is days (so +30 by itself means 30 days).  To
	add an AKILL which does not expire, use +0.  If the
	usermask to be added starts with a +, an expiry time must
	be given, even if it is the same as the default.  The
	current AKILL default expiry time can be found with the
	STATS AKILL command.
	
	The reason is intended for use by IRC operators only, and
	will not be displayed to users in KILL messages.
	
	Limited to Services operators.

OPER_HELP_SET
	Syntax: SET option setting
	
	Sets various global Services options.  Option names
	currently defined are:
	    READONLY   Set read-only or read-write mode
	    DEBUG      Activate or deactivate debug mode
	
	Limited to Services admins.

OPER_HELP_SET_READONLY
	Syntax: SET READONLY {ON | OFF}
	
	Sets read-only mode on or off.  In read-only mode, normal
	users will not be allowed to modify any Services data,
	including channel and nickname access lists, etc.  IRCops
	with sufficient Services privileges will be able to modify
	Services' AKILL list and drop or forbid nicknames and
	channels, but any such changes will not be saved unless
	read-only mode is deactivated before Services is terminated
	or restarted.
	
	This option is equivalent to the command-line option
	-readonly.

OPER_HELP_SET_DEBUG
	Syntax: SET DEBUG {ON | OFF | num}
	
	Sets debug mode on or off.  In debug mode, all data sent to
	and from Services as well as a number of other debugging
	messages are written to the log file.  If num is
	given, debug mode is activated, with the debugging level set
	to num.
	
	This option is equivalent to the command-line option
	-debug.

OPER_HELP_JUPE
	Syntax: JUPE server [reason]
	
	Tells Services to jupiter a server -- that is, to create
	a fake "server" connected to Services which prevents
	the real server of that name from connecting.  The jupe
	may be removed using a standard SQUIT.  If a reason is
	given, it is placed in the server information field;
	otherwise, the server information field will contain the
	text "Jupitered by <nick>", showing the nickname of the
	person who jupitered the server.
	
	Limited to Services admins.

OPER_HELP_RAW
	Syntax: RAW text
	
	Sends a string of text directly to the server to which
	Services is connected.  This command has a very limited
	range of uses, and can wreak havoc on a network if used
	improperly.  DO NOT USE THIS COMMAND unless you are
	absolutely certain you know what you are doing!
	
	Limited to Services admins.

OPER_HELP_UPDATE
	Syntax: UPDATE
	
	Causes Services to update all database files as soon as you
	send the command.
	
	Limited to Services admins.

OPER_HELP_QUIT
	Syntax: QUIT
	
	Causes Services to do an immediate shutdown; databases are
	not saved.  This command should not be used unless
	damage to the in-memory copies of the databases is feared
	and they should not be saved.  For normal shutdowns, use the
	SHUTDOWN command.
	
	Limited to Services admins.

OPER_HELP_SHUTDOWN
	Syntax: SHUTDOWN
	
	Causes Services to save all databases and then shut down.
	
	Limited to Services admins.

OPER_HELP_RESTART
	Syntax: RESTART
	
	Causes Services to save all databases and then restart
	(i.e. exit and immediately re-run the executable).
	
	Limited to Services admins.

OPER_HELP_REHASH
	Syntax: REHASH
	
	Causes Services to reload services.conf
	NOTE: String parameters will not be changed 
	in order to keep services integrity.
	
	Limited to Services admins.

OPER_REHASH_DONE
	Services configuration was rehashed.
OPER_REHASH_ERROR
	An error occured loading services configuration.
CHAN_LEVEL_PROTECT
	Protects a user from beeing deoped or kicked from the channel.
NICK_AUTORECON
	Last access recognition.
NICK_HELP_SET_AUTOJOIN
	Syntax: SET AUTOJOIN {ON | OFF}

	Enables on disables autojoin on channels.
	When enabled, %S will make you join the channels found
	on your AJOIN LIST on identify.
NICK_SET_AUTOJOIN_ON
	AutoJoin is now On
NICK_SET_AUTOJOIN_OFF
	AutoJoin is now Off
NICK_SET_AUTOJOIN_SYNTAX
	Syntax: SET AUTOJOIN {ON | OFF}
NICK_HELP_AJOIN
	Syntax: AJOIN { ADD | DEL | LIST } [#channel]
	
	Modifies or displays the Auto Join list for your nick.
	This is the list of channels you will join on identify
	if AUTOJOIN is on.
	
	Using /%S AJOIN NOW at any time will make you join
	all channels from your ajoin list.
NICK_AJOIN_LIST_X
	Auto Join list for %s is :
NICK_AJOIN_SYNTAX
	Syntax: AJOIN { ADD | DEL | LIST } [#channel]
NICK_AJOIN_REACHED_LIMIT
	Sorry, but the list capacity is %d channels.
NICK_AJOIN_ALREADY_PRESENT
	Channel is already in the list.
NICK_AJOIN_ADDED
	Channel %s added to your list.
NICK_AJOIN_NOT_FOUND
	Channel %s not found on your list.
NICK_AJOIN_DELETED
	Channel %s deleted from your list.
NICK_AJOIN_LIST
	Auto Join list:
NICK_INFO_OPT_AUTOJOIN
	Auto Join
BAD_CHAN_NAME
	Channel must be in format: #Channel
OPER_IDENTIFY_REQUIRED
	Security rules restricts oper to identified
	and OperServ registered nicks.
	Please contact your IRC admin for more info.
NICK_ALREADY_IDENTIFIED
	This nick is already identified.
TODAYSTATS
	Statistics for today (%s):
	
STATS_TOTAL
	Total: %d
STATS_REGISTERED
	Registered: %d
STATS_DROPPED
	Dropped: %d
STATS_EXPIRED
	Expired: %d
STATS_BALANCE
	Balance: %s
OPER_HELP_BOTLIST
	Syntax: 
	     BOT ADD hostname maxcon reason
	     BOT DEL  hostname
	     BOT LIST [mask]
	     BOT VIEW [mask]
	
	Allows Services operators to manipulate the BOT list. If
	a user trigers Clone protection but is hostname matches
	BOT list, the user will not be killed.
OPER_TOO_MANY_BOTLIST
	Sorry, BOT list is full.
OPER_BOTLIST_NO_NICK
	You can only use full hostnames on BOT list.
OPER_BOTLIST_ADDED
	New botlist entry added for %s
OPER_BOTLIST_ADD_SYNTAX
	BOT ADD hostname maxcon reason
OPER_BOTLIST_DEL_SYNTAX
	BOT DEL hostname reason
BOTLIST_REMOVED
	Removed entry %s from botlist
OPER_BOTLIST_NOT_FOUND
	Hostname %s was not found on botlist
OPER_BOTLIST_HEADER
	Current BotList:
# mask, reason	
OPER_BOTLIST_FORMAT
	%-32s %d : %s
#mask, set-by, set-time, reason
OPER_BOTLIST_VIEW_FORMAT
	%s (by %s at %s)
	   %s
OPER_BOTLIST_SYNTAX
	BOT {ADD | DEL | LIST | VIEW} hostname [maxcon reason]
CHAN_INFO_SUCCESSOR
	      Successor: %s (%s)
CHAN_INFO_NO_SUCCESSOR
	      Successor: %s
NICK_SHOULD_REGISTER
	This nick is not registered, if you intend to use it in the future
	please register the nick with /%s REGISTER password email.
	If you dont have an email account use NOMAIL as email.
CHANGE_IN_1_MINUTE
	If you do not change within one minute, your nick will be changed.
NICK_AJOIN_EMPTY
	AutoJoin list is empty
FEATURE_DISABLED
	Feature not available with this server.
CHAN_ACCESS_LIST_FORMAT2
	  %3d  %4d  %s%s%s%s by %s
NICK_AUTORECON_R
	Auto nick recognition on +r mode.
NICK_STATUS_0
	STATUS for %s : 0 - no such user online or nickname not registered
NICK_STATUS_1
	STATUS for %s : 1 - user not recognized as nickname's owner
NICK_STATUS_2
	STATUS for %s : 2 - user recognized as owner via mode identification
NICK_STATUS_3
	STATUS for %s : 3 - user recognized as owner via password identification
OPER_HELP_SQLINE
	Syntax: SQLINE ADD nick reason
	        SQLINE DEL  nick
	        SQLINE LIST [mask]
	        SQLINE VIEW [mask]
	
	Allows Services Administrators to manipulate the SQLINE list.
	A SQLINEd nick cannot be used on the network. 
OPER_TOO_MANY_SQLINE
	Sorry, SQLINE list is full.
OPER_SQLINE_JUST_NICK
	You can only use nick/wildcards on SQLINE list.
OPER_SQLINE_ADDED
	New SQLINE added for %s
OPER_SQLINE_ADD_SYNTAX
	SQLINE ADD nick reason
OPER_SQLINE_DEL_SYNTAX
	SQLINE DEL nick reason
OPER_SQLINE_REMOVED
	Removed SQLINE %s from sqline list.
OPER_SQLINE_NOT_FOUND
	SQLINE for  %s was not found on the list.
OPER_SQLINE_HEADER
	Current SQLINE List:
# mask, reason	
OPER_SQLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_SQLINE_VIEW_FORMAT
	%s (by %s at %s)
	   %s
OPER_SQLINE_SYNTAX
	SQLINE {ADD | DEL | LIST | VIEW} nick [reason]
BAD_EMAIL_ADDRESS
	Bad email address!
	Please use user@mailserver or NOMAIL on mail address.
BAD_ICQNUMBER
	Bad ICQ number!
	Please use #icqnumber 
BAD_LOCATION
	No location!
	Please give a shorter location.
CHAN_DROP_AT
	The channel will drop in %d day(s).
CHAN_DROP_CANCEL
	The drop requested for the channel at %s was canceled.
NICK_DROP_AT
	The nick will drop in %d day(s).
NICK_DROP_CANCEL
	The drop requested for the nick at %s was canceled.
OPER_STATS_USERS_RECORD
	Users record was %d on %s 
	Currently there are %d user(s) (%d%)
	-
OPER_STATS_OPERS_RECORD
	Opers record was %d on %s
	Currently there are %d oper(s) (%d%)
	-
OPER_STATS_HELPERS_RECORD
	Helpers record was %d on %s
	Currently there are %d helper(s) (%d%)
	-
OPER_STATS_BOTS_RECORD
	Bots record was %d on %s
	Currently there are %d bot(s) (%d%)
	-
NEWSS_HELP
	%S allows you to read online news selected by
	subscription.
	You have various commands you can use
	by typing /%S command.
	For more information on a specific command, type
	/%S HELP command.
	
	    LIST         List of available subjects and subscriptions
	    SUBSCRIBE    Subscribe a subject
	    UNSUBSCRIBE  Unsusbcribe a subject
	    SET          Set options
	    RECENT       List most recent delivered news
NEWSS_HELP_OPER
	
	News Operator Commands:
	    SEND         Send a news message
	    VIEW         View recent list with detailed info
	    DEL          Deletes one entry from recent delivered news
	    OPER LIST    List news operators
	    ADMIN LIST   List news admins
NEWSS_HELP_ADMIN
	
	News Administrator Command:
	    SUBJECT      Changes subject list
	    OPER         Add/Delete news operators
NEWSS_HELP_SADMIN
	
	Services Administrator Command:
	    ADMIN        Add/Delete  news admins
NEWSS_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [nick]
NEWSS_OPER_ADD_SYNTAX
	OPER ADD nick
NEWSS_OPER_DEL_SYNTAX
	OPER DEL nick
NEWSS_OPER_SKELETON
	Services is in skeleton mode; the OPER command is unavailable.
NEWSS_OPER_EXISTS
	%s already exists on News operator list.
NEWSS_OPER_ADDED
	%s added to News operator list.
NEWSS_OPER_TOO_MANY
	Too many entries (%d) on News operator list; cannot add more.
NEWSS_OPER_REMOVED
	%s removed from News operator list.
NEWSS_OPER_NOT_FOUND
	%s not found on News operator list.
NEWSS_OPER_LIST_HEADER
	News operator list:
	
NEWSS_OPER_HELP
	Syntax: OPER ADD nick
	        OPER DEL nick
	        OPER LIST
	
	Allows News admins to add or remove nicknames to or from
	the News operator list.  A user whose nickname is on the
	News operator list and who has identified to %s
	will be able to access News operator commands.
	
	Any News operator may use the OPER LIST form of the command.
	All other use is limited to News admins.

# News Server ADMIN responses
NEWSS_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [nick]
NEWSS_ADMIN_ADD_SYNTAX
	ADMIN ADD nick
NEWSS_ADMIN_DEL_SYNTAX
	ADMIN DEL nick
NEWSS_ADMIN_SKELETON
	Services is in skeleton mode; the ADMIN command is unavailable.
NEWSS_ADMIN_EXISTS
	%s already exists on News admin list.
NEWSS_ADMIN_ADDED
	%s added to News admin list.
NEWSS_ADMIN_TOO_MANY
	Too many entries (%d) on News admin list; cannot add more.
NEWSS_ADMIN_REMOVED
	%s removed from News admin list.
NEWSS_ADMIN_NOT_FOUND
	%s not found on News admin list.
NEWSS_ADMIN_LIST_HEADER
	News admin list:
	
NEWSS_SUBJECT_HELP
	Allows to change/create a subject entry 
	on the %S subject list.

	Syntax: SUBJECT number subject
NEWSS_SUBJECT_SYNTAX
	SUBJECT number subject
NEWSS_SUBJECT_ERROR
	Number must be between 1 and %d.
NEWSS_LIST_HELP
	The LIST command gives you the list of 
	available subjects and if they are subscribed 
	or not.
	Those marked with an X are subscribed.
	To subscribe/unsubscribe use commands: 
	    SUBSCRIBE UNSUBSCRIBE

NEWSS_LIST_HEADER
	Nr Subs Subject
	
NEWSS_LIST
	%2d  %c   %s
NEWSS_LIST_END
	End of subject list
NEWSS_SUBJECT_NOTFOUND
	The subject number %d does not exist!
NEWSS_SUBJECT_CHANGED
	Subject changed from %s to %s.
NEWSS_SUBJECT_CREATED
	Subject %s created.
NEWSS_SUBSCRIBE_SYNTAX
	SUBSCRIBE  number [,number] | ALL
NEWSS_SUBSCRIBE_HELP
	This command allows you to subscribe a news subject.
	
	Syntax: SUBSCRIBE  number [,number] | ALL
	
	You can subscribe multiple subjects with one command,
	using numbers separated with comas.
NEWSS_SUBSCRIBE_SUBSCRIBED
	You have subscribed %d subjects.
NEWSS_UNSUBSCRIBE_SYNTAX
	UNSUBSCRIBE  number [,number] | ALL
NEWSS_UNSUBSCRIBE_HELP
	This command allows you to unsubscribe a news subject.
	
	Syntax: UNSUBSCRIBE  number [,number] | ALL
	
	You can unsubscribe multiple subjects with one command,
	using numbers separated with comas.
NEWSS_UNSUBSCRIBE_UNSUBSCRIBED
	You have unsubscribed %d subjects.
NEWSS_SEND_SYNTAX
	SEND number news message
NEWSS_SEND_HELP
	Allows a News Oper/Admin to send a news message.
	
	Syntax: SEND  number news message
NEWSS_SEND_SENT
	News was sent.
NEWSS_SET_SYNTAX
	SET option parameters
NEWSS_SET_HELP
	Syntax: SET option parameters
	
	Sets various %S options.  option can be one of:
	    NOTICE    Selects news reception mode notice/msg.
NEWSS_SET_NOTICE_SYNTAX
	SET NOTICE [ON | OFF]
NEWSS_SET_NOTICE_HELP
	Syntax: SET NOTICE [ON | OFF]
	If notice is on you will receive news via notices,
	if off, news will be sent to you via private msg.  
NEWSS_SET_NOTICE_ON
	NOTICE option is now ON
NEWSS_SET_NOTICE_OFF
	NOTICE option is now OFF
NEWSS_RECENT_HELP
	Syntax: RECENT
	
	List the most recent news.
NEWSS_RECENT_HEADER
	Most recent news list
NEWSS_RECENT_LIST
	%s : %s
NEWSS_RECENT_END
	End of recent news list.
NEWSS_VIEW_HELP
	Syntax: VIEW
	
	List the most recent news with detailed info,
	subject 0 represents deleted items.
NEWSS_VIEW_HEADER
	Nr. : Sub. : Time : news (sender)
NEWSS_VIEW_LIST
	%s%2d : %2d : %s : %s (%s)%s
NEWSS_DEL_SYNTAX
	DEL number
NEWSS_DEL_HELP
	Syntax: DEL number

	This command deletes a entry from recent news list,
	number is the number of the news from the first
	column of /%S VIEW.
	The deleted entry will not be shown on the /%S RECENT
	list but will appear on the /%S VIEW as deleted.
NEWSS_DEL_NOTEXIST
	News number %d does not exist.
NEWSS_DEL_DELETED
	News number %d was deleted.
NICK_INFO_PRIVATE
	Nick information for %s is private.
CHAN_INFO_PRIVATE
	Channel information for %s is private.
CHAN_NEED_REGNICK
	You must use a registered nick to join this channel!
CHAN_MODE_PROTECTED
	This channel uses join protection modes.
NEWS_REC_PLEASE_WAIT
	Please wait %d seconds before using the RECENT command again.
NICK_HELP_NOTES
	Allows a user to store text notes.
	To store a note type /%S NOTES ADD text
	To delete a note type /%S NOTES DEL number
	To list all stored notes type /%S NOTES LIST
NICK_NOTES_SYNTAX
	LIST | ADD text | DEL number
NICK_NOTES_ADDED
	Note was stored with number %d.
NICK_NOTES_NOADD
	You reached the maximum notes number (%d) allowed to your nick,
	please delete some old note before trying to add a new one. 
NICK_NOTES_DELETED
	Note number %d was deleted.
NICK_NOTES_NOTFOUND
	Note number %d was not found.
NICK_NOTES_LIST_HEADER
	No  Note
NICK_NOTES_LIST
	%2d %s
NICK_NOTES_NONOTES
	Notes list is empty.
CHAN_ACCESS_CLEARALL
	Access list is now empty.
CHAN_AKICK_CLEARALL
	AKICK list is now empty.
NICK_STATUS_SYNTAX
	STATUS nick
NICK_X_ISFOUNDER
	Nick %s is founder cannot be set as successor.
NICK_X_ISSUCCESSOR
	Nick %s is channel successor cannot be set as founder.

# SESSION responses
OPER_SESSION_SYNTAX
	SESSION {LIST limit | VIEW hostname | TRACE hostname }
OPER_SESSION_LIST_SYNTAX
	SESSION LIST limit
OPER_SESSION_VIEW_SYNTAX
	SESSION VIEW host
OPER_SESSION_DISABLED
	Session limiting is disabled.
OPER_SESSION_INVALID_THRESHOLD
	Invalid threshold value. It must be a valid integer greater than 1.
OPER_SESSION_NOT_FOUND
	%s not found on session list.
OPER_SESSION_LIST_HEADER
	Hosts with at least %d sessions:
OPER_SESSION_LIST_COLHEAD
	Sessions  Host
# limit, host
OPER_SESSION_LIST_FORMAT
	%6d    %s
# host, sessions, limit
OPER_SESSION_VIEW_FORMAT
	The host %s currently has %d sessions with a limit of %d.
OPER_SESSION_EXCEEDED
	Network security denies any more connetions from your host.
OPER_HELP_SESSION
	Syntax: SESSION LIST threshold
	        SESSION VIEW host
	        SESSION TRACE host
	
	Allows Services operators to view the session list.
	
	SESSION LIST lists hosts with at least threshold sessions.
	The threshold must be a number greater than 1. This is to
	prevent accidental listing of the large number of single
	session hosts.
	
	SESSION VIEW displays detailed information about a specific
	host - including the current session count and session limit.
	The host value may not include wildcards.
	
	SESSION TRACE displays the list of users logged from that host
	The host value may not include wildcards.
OPER_HELP_VLINE
	Syntax: VLINE ADD {file | !word} reason
	        VLINE DEL  {file | !word}
	        VLINE LIST [pattern]
	        VLINE VIEW [pattern]
	
	Allows Services operators to manipulate the VLINE list.
	V-Lined file patterns will block DCC SENDs and set the sender
	+v so it will not be able to DCC SEND again. If a sentence matches a 
	word on the that is on the VLINE list, this sentence will be blocked 
OPER_TOO_MANY_VLINE
	Sorry, VLINE list is full.
OPER_VLINE_JUST_NICK
	You can only use file/wildcards or !words on VLINE list.
OPER_VLINE_ADDED
	New VLINE added for %s
OPER_VLINE_ADD_SYNTAX
	VLINE ADD {file | !word} reason
OPER_VLINE_DEL_SYNTAX
	VLINE DEL {file | !word} reason
OPER_VLINE_REMOVED
	Removed VLINE %s from V-Line list
OPER_VLINE_NOT_FOUND
	VLINE for  %s was not found on the list.
OPER_VLINE_HEADER
	Current VLINE List:
# mask, reason	
OPER_VLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_VLINE_VIEW_FORMAT
	%s (by %s at %s)
	   %s
OPER_VLINE_SYNTAX
	VLINE {ADD | DEL | LIST | VIEW} filename [reason]
OPER_SESSION_TRACE_SYNTAX
	TRACE host
OPER_SESSION_TRACE_BEGIN
	Listing session for %s:
OPER_SESSION_TRACE_FORMAT
	    %s
OPER_SESSION_TRACE_END
	End of session list
AGO_TIME_D
	%d day(s), %d hour(s), %d minute(s) and %d second(s) ago.
AGO_TIME
	%d hour(s), %d minute(s) and %d second(s) ago.
TOTAL_TIME
	%d day(s), %d hour(s), %d minute(s) and %d second(s).
OPER_OPER_SUSPENDED
	Oper %s is now suspended for %d days.
OPER_OPER_UNSUSPEND
	Oper suspension for %s was canceled.
OPER_OPER_SUSPEND_SYNTAX
	OPER SUSPEND nick days
CHAN_HELP_AOP
	Alias for AUTOOP access list entry managment.
	AOP ADD will add the nick to the channel access list with
	AUTOOP level.
	AOP LIST will list all channel access entries with AUTOOP level.
CHAN_AOP_SYNTAX
	AOP channel ADD nick | channel DEL nick | LIST
CHAN_HELP_SOP
	Alias for ACC-CHANGE access list managment.
	SOP ADD will add the nick to the channel access list with
	ACC-CHANGE level.
	SOP LIST will list all channel access entries with ACC-CHANGE level.	
CHAN_SOP_SYNTAX
	SOP channel ADD nick | channel DEL nick | LIST
CHAN_AJOIN_ADD
	You should add the channel to your ajoin list with /%s AJOIN ADD %s

# SENDPASS responses
OPER_SENDPASS_SYNTAX
	SENDPASS nickname
OPER_SENDPASS_NOSENDMAIL
	SENDPASS command unavailable because sendmail was not found!
OPER_SENDPASS_UNAVAILABLE
	SENDPASS command unavailable because encryption is in use.
OPER_SENDPASS_NOMAIL
	Nick %s has no Email-address set!
OPER_SENDPASS_SUBJECT
	Nickname password (%s)
OPER_SENDPASS_HEAD
	Hi,
OPER_SENDPASS_LINE_1
	You have requested to receive the password of nickname %s by e-mail.
OPER_SENDPASS_LINE_2
	The password is '%s'. For security purposes, you should change it as
	soon as you receive this mail.
OPER_SENDPASS_LINE_3
	If you don't know why this mail is sent to you, please ignore it
	silently.
OPER_SENDPASS_LINE_4
	Don't reply to this email!
OPER_SENDPASS_LINE_5
	PTlink Services - http://www.ptlink.net
OPER_SENDPASS_OK
	Password of %s has been sent.
MAIL_LATER
	Cannot send mail now; please retry a little later.
MAIL_DELAYED
	Please wait %d seconds and retry.
OPER_HELP_SENDPASS
	Syntax: SENDPASS nickname
	
	Send the password of the given nickname to the e-mail address
	set in the nickname record. This command is really useful
	to deal with lost passwords.
	
	May be limited to IRC operators on certain networks.
	
	This command is unavailable when encryption is enabled.
CHAN_RESTRICT_REGISTER
	Channel registration on this network is restricted to 
	Services Operators !!!
OPER_GETFOUNDER_SYNTAX
	GETFOUNDER #channel
MEMO_WILL_EXPIRE
	Your memo(s) %s will expire soon.
MEMO_HAVE_EXPIRED
	Your memo(s) %s have expired.
UPDATE_IN_PROGRESS
	Update in progress, requested by %s.
UPDATE_DONE
	Update done in %d second(s).
NICK_INFO_IS_ONLINE
	Nick is online.
NICK_INFO_HEADER
	--------------------------------------
CHAN_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE]
NICK_SERVADMIN_HELP_SUSPEND
	Syntax: SUSPEND nick days
	
	Nick will not be able to identify for the specified number
	of days.
NICK_SUSPEND_SYNTAX
	SUSPEND nick days
NICK_SUSPEND_SUCCEEDED
	Nick %s is now suspended for %s days.
NICK_SUSPEND_CANCEL
	Nick suspension for %s was canceled.
NICK_AUTH_SENT
	A short message has been sent to the email address you requested
	with detailed instructions on how to authenticate your nick
	registration. Until your authenticate the used email address
	you will not be able to send memos and register new channels.
NICK_AUTH_INCORRET
	The authentication code is not valid for this nick and email
	address.
NICK_AUTH_COMPLETED
	The authentication code is correct, your nick registration is now
	complete.
NICK_HELP_AUTH
	Syntax: AUTH code
	
	Authenticate nick email, this command is used to confirm
	you specified a valid email for nick registration/email change.
AUTH_EMAIL_SUBJECT
	Nick registration
SET_EMAIL_SUBJECT
	Nick email change
NICK_SET_EMAIL_WAIT
	Please wait at least one day before trying to change 
	your email address.
NICK_SET_EMAIL_AUTH
	Please check your %s mail for instructions 
	on how to complete the change.
NICK_AUTH_NEEDED
	Please complete your nick registration by using
	the auth code sent to your nick email address.

	If you did not specified a valid email address or
	did not received an authentication code please change
	your email adress with /%s SET EMAIL youremail

NICK_HELP_SET_NEWSLETTER
	Syntax: SET NEWSLETTER { ON | OFF }
	
	Enables/disables newsletter reception.
NICK_SET_NEWSLETTER_ON
	Newsletter reception is now ON.
NICK_SET_NEWSLETTER_OFF
	Newsletter reception is now OFF.
NICK_SET_NEWSLETTER_SYNTAX
	SET NEWSLETTER { ON | OFF }
NICK_INFO_NEWSLETTER
	Will receive newsletter.
OPER_HELP_GETFOUNDER
	Syntax: GETFOUNDER channel
	
	Allows Services admins to gain founder access
	on the given channel.
	
	Limited to: Services admins
CHAN_BAD_MLOCKMODE1
	You can't set this mlock mode +O, this is limited
	to Services operators
CHAN_BAD_MLOCKMODE2
	You can't set this mlock mode +A, this is limited
	to Services admins
NEWSS_ADMIN_HELP
	Syntax: ADMIN ADD nick
	        ADMIN DEL nick
	        ADMIN LIST
	
	Allows News admins to add or remove nicknames to or from
	the News operator list.  A user whose nickname is on the
	News adminstraor list and who has identified to %s
	will be able to access News adminstrator commands.
	
	Any News operator and News administrators may use 
	the ADMIN LIST form of the command.
	All other use is limited to Services admins.
CHAN_VOICE_SYNTAX
	VOICE channel nick
CHAN_DEVOICE_SYNTAX
	DEVOICE channel nick
CHAN_HELP_VOICE
	Syntax: VOICE #channel nick
	
	Voices a selected nick on a channel.  By default, limited to
	those with level 3 access and above on the channel.

CHAN_HELP_DEVOICE
	Syntax: DEVOICE #channel nick
	
	Devoices a selected nick on a channel.  By default, limited to
	those with level 3 access and above on the channel.
CHAN_LEVEL_VOICEDEVOICE
	Allowed to use VOICE/DEVOICE commands
CHAN_BAD_F_MODE
	Channel mode +f cannot be locked
OPER_SECUREMODE_SYNTAX
	SECUREMODE {ON | OFF}
OPER_SECUREMODE_ERROR
	Setting SECUREMODE must be ON of OFF.
OPER_HELP_SECUREMODE
	Syntax: SECUREMODE {ON | OFF}
	
	Set the network in SECUREMODE, with this option ON
	it is not possible for non-registered nicknames, to send text to
	a user/channel or join a channel. When non-registered nicks are in
	a channel when this mode is being set, they will automaticly 
	part the channels they are in.
OPER_HELP_SXLINE
	Syntax:
	     SXLINE ADD name:reason
	     SXLINE DEL name
	     SXLINE LIST
	     SXLINE VIEW
	
	Allows Services operators to manipulate the SXLINE list. If
	a realname is set on this list it will be banned from the network.
OPER_TOO_MANY_SXLINE
	Sorry, SXLINE list is full.
OPER_SXLINE_ADDED
	New SXLINE added for %s
OPER_SXLINE_ADD_SYNTAX
	SXLINE ADD name:reason
OPER_SXLINE_DEL_SYNTAX
	SXLINE DEL name
OPER_SXLINE_REMOVED
	Removed SXLINE %s from SXLine list
OPER_SXLINE_NOT_FOUND
	SXLINE for  %s was not found on the list.
OPER_SXLINE_HEADER
	Current SXLINE List:
# mask, reason
OPER_SXLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_SXLINE_VIEW_FORMAT
	%s (by %s at %s)
	   %s
OPER_SXLINE_SYNTAX
	SXLINE {ADD | DEL | LIST | VIEW} name [serverinfo]
OPER_HELP_VLINK
	Syntax: VLINK ADD virtualhost serverinfo
	        VLINK DEL  virtualhost
	        VLINK LIST [pattern]
	        VLINK VIEW [pattern]
	
	Allows Services admins to manipulate the VLINK list.
	VLINK allows you to set virtual server names (vhost). 
OPER_TOO_MANY_VLINK
	Sorry, VLINK list is full.
OPER_VLINK_ADDED
	New VLINK added for %s
OPER_VLINK_ADD_SYNTAX
	VLINK ADD virtualhost serverinfo
OPER_VLINK_DEL_SYNTAX
	VLINK DEL virtualhost
OPER_VLINK_REMOVED
	Removed VLINK %s from VLink list
OPER_VLINK_NOT_FOUND
	VLINK for  %s was not found on the list.
OPER_VLINK_HEADER
	Current VLINK List:
# mask, reason	
OPER_VLINK_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_VLINK_VIEW_FORMAT
	%s (by %s at %s)
	   %s
OPER_VLINK_SYNTAX
	VLINK {ADD | DEL | LIST | VIEW} virtualhost [serverinfo]
CHAN_HELP_LOGOUT
	Syntax: LOGOUT
	
	Removes all founder privileges from all identified channels
CHAN_LOGOUT_SUCCES
	Succesfully removed founder privileges of all identified channels
NICK_SET_EMAIL_SADMIN_CHANGE
	E-mail address for %s changed to %s.
NICK_HELP_SET_PRIVMSG
	Syntax: SET PRIVMSG {ON | OFF}

	Enables or disables the use of privmsgs instead of notices 
	for services messages.
NICK_SET_PRIVMSG_ON
	PrivMsg is now On
NICK_SET_PRIVMSG_OFF
	PrivMsg is now Off
NICK_SET_PRIVMSG_SYNTAX
	Syntax: SET PRIVMSG {ON | OFF}
NICK_SET_URL_SADMIN_CHANGE
	URL for %s change to %s
NICK_SET_URL_SADMIN_UNSET
	URL for %s unset
NICK_SET_PASSWORD_SADMIN_CHANGED_TO
	Password for %s changed to %s.
NICK_SET_LOCATION_SADMIN_CHANGED
	Location for %s changed to %s
NICK_SET_LOCATION_SADMIN_UNSET
	Location for %s unset
CHAN_LEVEL_AUTOHALFOP
	Automatic mode +h
CHAN_LEVEL_HALFOPDEOP
	Allowed to use HALFOP/DEHALFOP
CHAN_HALFOP_SYNTAX
	Syntax: HALFOP #channel nick
CHAN_DEHALFOP_SYNTAX
	Syntax: DEHALFOP #channel nick
CHAN_CLEARED_HALFOPS
	Mode +h has been cleared from channel %s
CHAN_HELP_HALFOP
	Syntax: HALFOP #channel nick
	
	Halfops a selected nick on a channel.  By default, limited to
	those with level 4 access and above on the channel.
	
CHAN_HELP_DEHALFOP
	Syntax: DEHALFOP #channel nick
	
	Dehalfops a selected nick on a channel.  By default, limited to
	those with level 4 access and above on the channel.
NOMAIL_DISABLED
	The option NOMAIL has been disabled
