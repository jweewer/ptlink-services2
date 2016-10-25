#

# Services is copyright (c) 1996-1999 Andy Church.
#     Email: <achurch@dragonfire.net>
# This program is free but copyrighted software; see the file
# COPYING for details.

# This file is translated by Cord Beermann <cord@Wunder-Nett.org>
# If you find a better formulation, send it to
# pt-service-deutsch@cord.de

# diese Datei ist übersetzt worden von Cord Beermann
# <cord@Wunder-Nett.org>. Wenn Dir eine bessere Übersetzung für
# etwas einfällt, schicke Sie bitte an pt-service-deutsch@cord.de

#################################################################
#
# Name of this language
#
#################################################################

# For languages other than English, this string should have the
# following format:
#     language-name-in-language (language-name-in-English)
# For example, "Español (Spanish)" or "Français (French)".

LANG_NAME
	Deutsch (German)

#################################################################
#
# General messages
#
#################################################################

# strftime() format strings.  man 3 strftime for information on
# the meanings of the format specifiers.  Short version:
#	%a = weekday name (short)	%H = hour
#	%b = month name (short)		%M = minute
#	%d = day of month		%S = second
#	%Y = year			%Z = time zone

# This is used as the format string for strftime() for a date
# and time together.
STRFTIME_DATE_TIME_FORMAT
	%d %b %Y %H:%M:%S %Z
# This is used as the format string for strftime() for a date
# alone in long format (English: including weekday).
STRFTIME_LONG_DATE_FORMAT
	%a %d %b %Y
# This is used as the format string for strftime() for a date
# alone in short format (English: without weekday).
STRFTIME_SHORT_DATE_FORMAT
	%d %b %Y
# These tell our strftime() what the names of months and days
# are.  If you don't use %a, %A, %b, or %B in your strftime()
# strings above, you can leave these empty.  However, if you
# enter names, they MUST stay in order, one per line, and the
# list MUST be complete!

# %a
STRFTIME_DAYS_SHORT
	Son
	Mon
	Die
	Mit
	Don
	Fre
	Sam
# %A
STRFTIME_DAYS_LONG
	Sonntag
	Montag
	Dienstag
	Mittwoch
	Donnerstag
	Freitag
	Samstag
# %b
STRFTIME_MONTHS_SHORT
	Jan
	Feb
	Mär
	Apr
	Mai
	Jun
	Jul
	Aug
	Sep
	Okt
	Nov
	Dez
# %B
STRFTIME_MONTHS_LONG
	Januar
	Februar
	März
	April
	Mai
	Juni
	Juli
	August
	September
	Oktober
	November
	Dezember

# This is used in ChanServ/NickServ INFO displays.
COMMA_SPACE
	,

# Various error messages.
USER_RECORD_NOT_FOUND
	Interner Fehler - kann Befehl nicht ausführen.
UNKNOWN_COMMAND
	Unbekannter Befehl %s.
UNKNOWN_COMMAND_HELP
	Unbekannter Befehl %s.
	Tippe /msg %s HELP für Hilfe.
SYNTAX_ERROR
	Syntax: %s
MORE_INFO
	/msg %s HELP %s für weitere Hilfe.
NO_HELP_AVAILABLE
	Keine Hilfe verfügbar für %s.
BAD_USERHOST_MASK
	Maske muß in der Form user@host sein.
SERVICE_OFFLINE
	%s ist derzeit offline.
READ_ONLY_MODE
	Achtung: Services sind im read-only Modus;
	Änderungen können nicht gespeichert werden!
PASSWORD_INCORRECT
	Passwort falsch.

# What's the difference between "Access denied" and "Permission
# denied"? Very little; you can safely make them the same
# message with no real loss of meaning.  If you want to make a
# distinction, "Access denied" is usually used more generally;
# for example, a non-oper trying to access OperServ gets "Access
# denied", while a non-Services admin trying to use NickServ
# SET NOEXPIRE gets "Permission denied".
ACCESS_DENIED
	Zugang verweigert.
PERMISSION_DENIED
	Erlaubnis verweigert.
MORE_OBSCURE_PASSWORD
	Bitte versuche es noch einmal mit einem komplizierteren
	Passwort. Passwörter sollen mindestens fünf Zeichen
	lang sein, sie sollen nicht einfach zu erraten sein (z.B.
	Dein richtiger Name oder Dein Nick), und können keine
	Leerzeichen oder Tabulatoren enthalten.
PASSWORD_TRUNCATED
	Achtung:  Dein Passwort wurde auf %d Zeichen gekürzt.
NICK_NOT_REGISTERED
	Dein Nick ist nicht registriert.
NICK_NOT_REGISTERED_HELP
	Dein Nick ist nicht registriert.
	Tippe /msg %s HELP für weitere Informationen,
	wie man den Nick registriert.
NICK_X_NOT_REGISTERED
	Nick %s nicht registriert.
NICK_X_NOT_IN_USE
	Nick %s wird derzeit nicht benutzt.
NICK_X_NOT_ON_CHAN
	Nick %s isn't on channel %s.
NICK_X_FORBIDDEN
	Nick %s darf nicht registriert oder
	benutzt werden.
CHAN_X_NOT_REGISTERED
	Kanal %s ist nicht registriert.
CHAN_X_NOT_IN_USE
	Kanal %s existiert nicht.
CHAN_X_FORBIDDEN
	Kanal %s darf nicht registriert oder
	benutzt werden.
NICK_IDENTIFY_REQUIRED
	Für diesem Befehl ist eine Autorisierung erforderlich.
	Versuche es noch einmal nach der Eingabe
	/msg %s IDENTIFY password.
CHAN_IDENTIFY_REQUIRED
	Für diesen Befehl ist Autorisierung erforderlich.
	Versuche es noch einmal nach der Eingabe
	/msg %s IDENTIFY password.

#################################################################
#
# NickServ messages
#
#################################################################

# Automatic messages
NICK_IS_REGISTERED
	Dieser Nick gehört jemand anderem.  Bitte wähle einen
	anderen Nick.  (Wenn es Dein Nick ist, tippe
	/msg %s IDENTIFY password.)
NICK_IS_SECURE
	Dieser Nick ist registriert und geschützt.  Wenn es Dein
	Nick sein sollte, tippe
	/msg %s IDENTIFY password.
	Ansonsten wähle bitte einen anderen Nick.
NICK_MAY_NOT_BE_USED
	Dieser Nick darf nicht benutzt werden.
	Bitte wähle einen anderen.
DISCONNECT_IN_1_MINUTE
	Wenn Du nicht innerhalb einer Minute wechselst, wirst Du
	vom Chat getrennt.
DISCONNECT_IN_20_SECONDS
	Wenn Du nicht innerhalb zwanzig Sekunden wechselst, wirst
	Du vom Chat getrennt.
DISCONNECT_NOW
	Dieser Nick ist registriert; Du darfst ihn
	nicht benutzen. Wähle einen anderen Nick bevor
	Du wiederkommst.

# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER password email
NICK_REGISTRATION_DISABLED
	Sorry, Nick Registrierung ist derzeit abgeschaltet.
NICK_REGISTRATION_FAILED
	Sorry, Registrierung mißlungen.
NICK_REG_PLEASE_WAIT
	Bitte warte %d Sekunden, bevor Du den REGISTER Befehl
	erneut benutzt.
NICK_CANNOT_BE_REGISTERED
	Nick %s darf nicht registriert werden.
NICK_ALREADY_REGISTERED
	Nick %s ist bereits registriert!
NICK_REGISTERED
	Nick %s registriert unter Deinem
	Zugang: %s
NICK_PASSWORD_IS
	Dein Passwort ist %s - Bitte merk Dir
	dieses Passwort.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY password
NICK_IDENTIFY_FAILED
	Sorry, Identifizierung gescheitert.
NICK_IDENTIFY_SUCCEEDED
	Passwort akzeptiert - Du bist nun angemeldet.

# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Sorry, Nick löschen ist derzeit abgeschaltet.
NICK_DROPPED
	Dein Nick ist gelöscht worden.
NICK_X_DROPPED
	Nick %s ist gelöscht worden.

# SET responses
NICK_SET_SYNTAX
	SET option parameters
NICK_SET_SERVADMIN_SYNTAX
	SET [nick] option parameters
NICK_SET_DISABLED
	Sorry, Nick Einstellungen ändern ist
	derzeit abgeschaltet.
NICK_SET_UNKNOWN_OPTION
	Unbekannte SET Einstellung %s.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Unbekannte SET Einstellung %s,
	oder Nick nicht registriert.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Sorry, ich kann das Passwort nicht ändern.
NICK_SET_PASSWORD_CHANGED
	Passwort geändert.
NICK_SET_PASSWORD_CHANGED_TO
	Passwort geändert auf %s.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE number
NICK_SET_LANGUAGE_UNKNOWN
	Unbekannte Sprache Nummer %d.  Tippe
	/msg %s HELP SET LANGUAGE für eine Liste
	der verfügbaren	Sprachen.
NICK_SET_LANGUAGE_CHANGED
	Sprache geändert auf Deutsch.

# SET URL responses
NICK_SET_URL_CHANGED
	URL auf %s geändert.
NICK_SET_URL_UNSET
	URL gelöscht.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	Email Adresse auf %s geändert.
NICK_SET_EMAIL_UNSET
	Email Adresse gelöscht.

# SET ICQNUMBER responses
NICK_SET_ICQ_CHANGED
	ICQ Nummer auf #%s geändert.
NICK_SET_ICQ_UNSET
	ICQ Nummer gelöscht.

# SET LOCATION responses
NICK_SET_LOCATION_CHANGED
	Standort auf %s geändert.
NICK_SET_LOCATION_UNSET
	Standort gelöscht.

# SET KILL responses
NICK_SET_KILL_SYNTAX
	SET KILL {}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	Kill Schutz ist nun ON.
NICK_SET_KILL_QUICK
	Kill Schutz ist nun ON, mit
	reduzierter kill Verzögerung.
NICK_SET_KILL_IMMED
	Kill Schutz ist nun ON, ohne eine Kill Verzögerung.
NICK_SET_KILL_IMMED_DISABLED
	Die IMMED Einstellung ist in
	diesem Netz nicht möglich.
NICK_SET_KILL_OFF
	Kill Schutz ist nun OFF.

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Privat Einstellung ist nun ON.
NICK_SET_PRIVATE_OFF
	Privat Einstellung ist nun OFF.

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	Deine Email Adresse wird nun auf
	%s INFO Anzeigen nicht angezeigt.
NICK_SET_HIDE_EMAIL_OFF
	Deine Email Adresse wird nun auf
	%s INFO Anzeigen angezeigt.
NICK_SET_HIDE_QUIT_ON
	Deine letzte quit Nachricht wird nun auf
	%s INFO Anzeigen nicht angezeigt.
NICK_SET_HIDE_QUIT_OFF
	Deine letzte quit Nachricht wird nun auf
	%s INFO Anzeigen angezeigt.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [nickname] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	Nick %s wird nicht ablaufen.
NICK_SET_NOEXPIRE_OFF
	Nick %s wird ablaufen.

# LINK responses
NICK_LINK_SYNTAX
	LINK nick password
NICK_NICKLINK_SYNTAX
	NICKLINK nick targetnick
NICK_LINK_DISABLED
	Der LINK Befehl ist nicht verfügbar.
NICK_LINK_FAILED
	Sorry, linking gescheitert.
NICK_NO_LINK_SAME
	Du kannst nicht an Deinen aktuellen Nick linken!
NICK_LINK_CIRCULAR
	Kann Nick nicht linken %s:
	circular link entdeckt.
NICK_LINKED
	Dein Nick ist nun gelinkt zu %s.
NICK_NICKLINKED
	Der Nick %s ist nun gelinkt zu %s.

# UNLINK responses
NICK_UNLINK_SYNTAX
	UNLINK [nick password]
NICK_UNLINK_FAILED
	Sorry, Linkaufhebung gescheitert.
NICK_NOT_LINKED
	Dein Nick ist nicht gelinkt.
NICK_UNLINKED
	Dein Nick ist nun entlinkt von %s.
NICK_X_NOT_LINKED
	Nick %s nicht gelinkt.
NICK_X_UNLINKED
	Nick %s ist nun entlinkt von %s.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS nick [ALL]
NICK_LISTLINKS_SYNTAX2
	LISTLINKS
NICK_LISTLINKS_HEADER
	Liste der Nicks die zu %s gelinkt sind:
NICK_LISTLINKS_FOOTER
	%d gelinkte Nick.

# INFO responses
NICK_INFO_SYNTAX
	INFO nick
NICK_INFO_REALNAME
	%s ist %s
NICK_INFO_ADDRESS
	   Letzte gesehene Adresse: %s
NICK_INFO_TIME_REGGED
	          Zeit registriert: %s [%s]
NICK_INFO_LAST_IDENTIFY
	Letzte Identifikationszeit: %s [%s]
NICK_INFO_LAST_SEEN
	      Letzte Zeit anwesend: %s [%s]
NICK_INFO_ONLINE
	  Gesamte Anwesenheitszeit: %s
NICK_INFO_LAST_QUIT
	     Letzte quit Nachricht: %s
NICK_INFO_URL
	                       URL: %s
NICK_INFO_EMAIL
	             Email Adresse: %s
NICK_INFO_ICQ
	                ICQ Nummer: #%s
NICK_INFO_LOCATION
	                  Standort: %s
NICK_INFO_OPTIONS
	             Einstellungen: %s
NICK_INFO_NO_EXPIRE
	Dieser Nick wird nicht ablaufen.
NICK_INFO_OSUSPENDED
	             Oper Sperrung: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Kill Schutz
NICK_INFO_OPT_PRIVATE
	Privat
NICK_INFO_OPT_NONE
	Keine

# LIST responses
NICK_LIST_SYNTAX
	LIST pattern
NICK_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE]
NICK_LIST_HEADER
	Liste der Einträge die auf %s passen:
NICK_LIST_RESULTS
	Ende der Liste - %d/%d Treffer angezeigt.

NICK_RELEASED
	der Service, der Deinen Nick hält wurde freigegeben.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST nickname [password]
NICK_NO_GHOST_SELF
	Du kannst Dich nicht selbst ghosten.
NICK_GHOST_KILLED
	Ghost mit Deinem Nick ist gekillt.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS nickname
NICK_GETPASS_UNAVAILABLE
	GETPASS Befehl nicht verfügbar, weil Verschlüsselung
	aktiviert ist.
NICK_GETPASS_PASSWORD_IS
	Passwort für %s ist %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID nickname
NICK_FORBID_SUCCEEDED
	Nick %s ist nun verboten.
NICK_FORBID_FAILED
	Ich kann den Nick %s nicht verbieten!

#################################################################
#
# ChanServ messages
#
#################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Automatischer Kanal Op Status
CHAN_LEVEL_AUTOVOICE
	Automatischer Mode +v
CHAN_LEVEL_AUTODEOP
	Kanal Op Status verboten
CHAN_LEVEL_NOJOIN
	Es ist verboten den Kanal zu betreten, wenn RESTRICTED
	gesetzt ist.
CHAN_LEVEL_INVITE
	Der INVITE Befehl ist erlaubt
CHAN_LEVEL_AKICK
	Der AKICK Befehl ist erlaubt
CHAN_LEVEL_SET
	Der SET Befehl ist erlaubt (nicht FOUNDER/PASSWORD)
CHAN_LEVEL_CLEAR
	Der CLEAR Befehl ist erlaubt
CHAN_LEVEL_UNBAN
	Der UNBAN Befehl ist erlaubt
CHAN_LEVEL_OPDEOP
	Die OP/DEOP Befehle sind erlaubt
CHAN_LEVEL_ACCESS_LIST
	Das Anschauen der Zugangs-Liste ist erlaubt
CHAN_LEVEL_ACCESS_CHANGE
	Das ändern der Zugangs-Liste ist erlaubt
CHAN_LEVEL_MEMO_READ
	Listen/Lesen der Kanal-Memos ist erlaubt
CHAN_LEVEL_MEMO_SEND
	Senden von Kanal-Memos ist erlaubt
CHAN_LEVEL_MEMO_DEL
	Löschen von Kanal-Memos ist erlaubt
CHAN_LEVEL_KICK
	Der KICK Befehl ist erlaubt

# Automatic responses
CHAN_IS_REGISTERED
	Dieser Kanal wurde mit %s registriert.
CHAN_NOT_ALLOWED_OP
	Du darfst keinen Op Status auf Kanal %s haben.
CHAN_MAY_NOT_BE_USED
	Dieser Kanal darf nicht benutzt werden.
CHAN_NOT_ALLOWED_TO_JOIN
	Du hast nicht Recht auf diesem Kanal zu sein.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER channel password description
CHAN_REGISTER_DISABLED
	Sorry, Kanal Registrierung ist derzeit abgeschaltet.
CHAN_REGISTER_NOT_LOCAL
	Lokale Kanäle können nicht registriert werden.
CHAN_MUST_REGISTER_NICK
	Du mußt erst Deinen Nick registrieren. Tippe
	/msg %s HELP für Informationen zum
	Nick registrieren.
CHAN_MUST_IDENTIFY_NICK
	Identifiziere Dich zuerst mit dem Befehl
	/msg %s IDENTIFY password
CHAN_MAY_NOT_BE_REGISTERED
	Kanal %s darf nicht registriert werden.
CHAN_ALREADY_REGISTERED
	Kanal %s ist bereits registriert!
CHAN_MUST_BE_CHANOP
	Du mußt Kanal Op sein, um den Kanal zu registrieren.
CHAN_REACHED_CHANNEL_LIMIT
	Sorry, Du hast bereits die Obergrenze von
	%d Kanälen erreicht.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Sorry, Du hast bereits die Obergrenze von
	%d Kanälen überschritten.
CHAN_REGISTRATION_FAILED
	Sorry, Registrierung gescheitert.
CHAN_REGISTERED
	Kanal %s unter Deinem Nick
	registriert: %s
CHAN_PASSWORD_IS
	Dein Kanal Passwort ist %s -
	Bitte merk Dir dieses Passwort.

# IDENTIFY responses
CHAN_IDENTIFY_SYNTAX
	IDENTIFY channel password
CHAN_IDENTIFY_FAILED
	Sorry, Identifizierung gescheitert.
CHAN_IDENTIFY_SUCCEEDED
	Passwort akzeptiert - Du hast nun Founder Zugang zu
	%s.,

# DROP responses
CHAN_DROP_SYNTAX
	DROP channel
CHAN_DROP_DISABLED
	Sorry, Kanal löschen ist derzeit abgeschaltet.
CHAN_DROPPED
	Kanal %s ist nun gelöscht.

# SET responses
CHAN_SET_SYNTAX
	SET channel option parameters
CHAN_SET_DISABLED
	Sorry, Kanal Einstellung ändern ist derzeit abgeschaltet.
CHAN_SET_UNKNOWN_OPTION
	Unbekannte SET Einstellung %s.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s hat zu viele Kanäle registriert.
CHAN_FOUNDER_CHANGED
	Founder von %s ist nun %s.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Nachfolger für %s ist nun %s.
CHAN_SUCCESSOR_UNSET
	Nachfolger für %s gelöscht.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Sorry, kann Passwort nicht setzen.
CHAN_PASSWORD_CHANGED
	%s Passwort geändert.
CHAN_PASSWORD_CHANGED_TO
	%s Passwort geändert auf %s.

# SET DESC responses
CHAN_DESC_CHANGED
	Beschreibung von %s geändert auf %s.

# SET URL responses
CHAN_URL_CHANGED
	URL für %s geändert auf %s.
CHAN_URL_UNSET
	URL für %s gelöscht.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	Email Adresse für %s ist nun %s.
CHAN_EMAIL_UNSET
	Email Adresse für %s gelöscht.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Eingangs Nachricht für %s geändert.
CHAN_ENTRY_MSG_UNSET
	Eingangs Nachricht für %s gelöscht.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Sorry, kann Topic nicht setzen.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	Parameter benötigt für MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	Parameter benötigt für MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Parameter für MLOCK +l muß eine positive Nummer sein.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Unbekanntes Mode Zeichen %c ignoriert.
CHAN_MLOCK_CHANGED
	Mode Sperre auf Kanal %s auf
	%s geändert.
CHAN_MLOCK_REMOVED
	Mode Sperre auf Kanal %s gelöscht.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET channel KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Topic Beibehaltung Einstellung ist nun ON.
CHAN_SET_KEEPTOPIC_OFF
	Topic Beibehaltung Einstellung ist nun OFF.

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET channel TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Topic Sperre Einstellung ist nun ON.
CHAN_SET_TOPICLOCK_OFF
	Topic Sperre Einstellung ist nun OFF.

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET channel PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Privat Einstellung ist nun ON.
CHAN_SET_PRIVATE_OFF
	Privat Einstellung ist nun OFF.

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET channel SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Sichere Ops Einstellung ist nun ON.
CHAN_SET_SECUREOPS_OFF
	Sichere Ops Einstellung ist nun OFF.

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET channel LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Belasse Ops Einstellung ist nun ON.
CHAN_SET_LEAVEOPS_OFF
	Belasse Ops Einstellung ist nun OFF.

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET channel RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Eingeschränkter Zugang Einstellung ist nun ON.
CHAN_SET_RESTRICTED_OFF
	Eingeschränkter Zugang Einstellung ist nun OFF.

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET channel OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Op-Notiz Einstellung ist nun ON.
CHAN_SET_OPNOTICE_OFF
	Op-Notiz Einstellung ist nun OFF.

# SET OPNOTICE responses
CHAN_SET_NOLINKS_SYNTAX
	SET channel NOLINKS {ON | OFF}
CHAN_SET_NOLINKS_ON
	NOLINKS Einstellung ist nun ON.
CHAN_SET_NOLINKS_OFF
	NOLINKS Einstellung ist nun OFF.

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET channel NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Kanal %s wird nicht auslaufen.
CHAN_SET_NOEXPIRE_OFF
	Kanal %s wird auslaufen.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS channel {ADD|DEL|LIST} [nick [level] | entry-list]
CHAN_ACCESS_DISABLED
	Sorry, Änderung der Kanal-Zugangs-Liste ist
	derzeit abgeschaltet.
CHAN_ACCESS_LEVEL_NONZERO
	Zugangs-Stufe muß nicht-Null sein.
CHAN_ACCESS_LEVEL_RANGE
	Zugangs-Stufe muß zwischen %d und %d
	inklusive sein.
CHAN_ACCESS_NICKS_ONLY
	Kanal-Zugangs-Liste darf nur registrierte
	Nicks enthalten.
CHAN_ACCESS_REACHED_LIMIT
	Sorry, Du kannst höchstens %d Zugangs-Einträge für
	einen Kanal haben.
CHAN_ACCESS_LEVEL_UNCHANGED
	Zugangs-Stufe für %s auf %s nicht
	geändert von %d.
CHAN_ACCESS_LEVEL_CHANGED
	Zugangs-Stufe für %s auf %s wurde von %d
	auf %d geändert.
CHAN_ACCESS_ADDED
	%s hinzugefügt zur %s Zugangs-Liste
	auf Stufe %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	Keine Eintrag (#%d) auf %s Zugangs-Liste.
CHAN_ACCESS_NOT_FOUND
	%s wurde nicht auf der %s
	Zugangs-Liste gefunden.
CHAN_ACCESS_NO_MATCH
	Keine passenden Einträge auf der %s Zugangs-Liste.
CHAN_ACCESS_DELETED
	%s von der %s Zugangs-Liste gelöscht.
CHAN_ACCESS_DELETED_ONE
	Ein Eintrag von der %s Zugangs-Liste gelöscht.
CHAN_ACCESS_DELETED_SEVERAL
	%d Einträge von der %s Zugangs-Liste gelöscht.
CHAN_ACCESS_LIST_EMPTY
	%s Zugangs-Liste ist leer.
CHAN_ACCESS_LIST_HEADER
	Zugangs-Liste für %s:
	  Num  Stuf  Nick
CHAN_ACCESS_LIST_FORMAT
	  %3d  %4d  %s%s%s%s

# AOP/SOP error response
CHAN_NO_AOP_SOP
	Benutze den ACCESS Befehl um Kanal-Privilegien
	zuzuweisen; Tippe /msg %s HELP ACCESS für
	weitere Informationen.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK channel {ADD | DEL | LIST} [nick-or-usermask]
CHAN_AKICK_DISABLED
	Sorry, Änderungen der Kanal-Auto-KICK-Liste sind
	derzeit abgeschaltet.
CHAN_AKICK_ALREADY_EXISTS
	%s ist bereits auf der
	%s Auto-Kick-Liste.
CHAN_AKICK_REACHED_LIMIT
	Sorry, Du kannst höchstens %d Auto-Kick Masken auf
	einem Kanal haben.
CHAN_AKICK_ADDED
	%s wurde der Auto-Kick-Liste hinzugefügt.
CHAN_AKICK_NO_SUCH_ENTRY
	Kein solcher Eintrag (#%d) auf der
	%s Auto-Kick-Liste.
CHAN_AKICK_NOT_FOUND
	%s wurde auf der %s Auto-Kick-Liste
	nicht gefunden.
CHAN_AKICK_NO_MATCH
	Keine passenden Einträge auf der
	%s Auto-Kick-Liste.
CHAN_AKICK_DELETED
	%s wurde von der %s
	Auto-Kick-Liste gelöscht.
CHAN_AKICK_DELETED_ONE
	Ein Eintrag von der %s Auto-Kick-Liste gelöscht.
CHAN_AKICK_DELETED_SEVERAL
	%d Einträge von der %s
	Auto-Kick-Liste gelöscht.
CHAN_AKICK_LIST_EMPTY
	%s Auto-Kick-Liste ist leer.
CHAN_AKICK_LIST_HEADER
	Auto-Kick-Liste für %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_LIST_FORMAT2
	  %3d %s von %s : %s

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS channel {SET | DIS[ABLE] | LIST | RESET} [item [level]]
CHAN_LEVELS_RANGE
	Stufe muß zwischen %d und %d inklusive sein.
CHAN_LEVELS_CHANGED
	Stufe für %s auf Kanal %s geändert
	auf %d.
CHAN_LEVELS_UNKNOWN
	Einstellung %s unbekannt.  Tippe
	/msg %s HELP LEVELS DESC für eine Liste von
	korrekten Einstellungen.
CHAN_LEVELS_DISABLED
	%s abgeschaltet auf Kanal %s.
CHAN_LEVELS_LIST_HEADER
	Zugang-Stufen-Einstellung für Kanal %s:
CHAN_LEVELS_LIST_DISABLED
	 %-*s  (abgeschaltet)
CHAN_LEVELS_LIST_FOUNDER
	 %-*s  (nur founder)
CHAN_LEVELS_LIST_NORMAL
	 %-*s  %d
CHAN_LEVELS_RESET
	Zugangs-Stufen für %s auf die
	Voreinstellung zurückgesetzt.

# INFO responses
CHAN_INFO_SYNTAX
	INFO channel
CHAN_INFO_HEADER
	Information für Kanal %s:
CHAN_INFO_FOUNDER
	          Founder: %s (%s)
CHAN_INFO_NO_FOUNDER
	          Founder: %s
CHAN_INFO_DESCRIPTION
	     Beschreibung: %s
CHAN_INFO_TIME_REGGED
	      Registriert: %s [%s]
CHAN_INFO_LAST_USED
	   Letzte Nutzung: %s [%s]
CHAN_INFO_LAST_TOPIC
	    Letztes Topic: %s
CHAN_INFO_TOPIC_SET_BY
	Topic gesetzt von: %s
CHAN_INFO_RECORD
	  Benutzer Rekord: %d user(s) am %s [%s]
CHAN_INFO_USERS
	         Besitzer: %d user(s)
CHAN_INFO_URL
	              URL: %s
CHAN_INFO_EMAIL
	    Email Adresse: %s
CHAN_INFO_OPTIONS
	    Einstellungen: %s
CHAN_INFO_NO_EXPIRE
	    Ablaufen: Nie
CHAN_INFO_OPT_PRIVATE
	Privat
CHAN_INFO_OPT_KEEPTOPIC
	Topic Beibehaltung
CHAN_INFO_OPT_TOPICLOCK
	Topic Sperre
CHAN_INFO_OPT_SECUREOPS
	Sichere Ops
CHAN_INFO_OPT_LEAVEOPS
	Belasse Ops
CHAN_INFO_OPT_RESTRICTED
	Eingeschränkter Zugang
CHAN_INFO_OPT_NOLINKS
	Ignoriere Nick Links
CHAN_INFO_OPT_NONE
	Keine
CHAN_INFO_MODE_LOCK
	     Modus Sperre: %s

# LIST responses
CHAN_LIST_SYNTAX
	LIST pattern
CHAN_LIST_HEADER
	Liste der Einträge die auf %s passen:
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	Ende der Liste - %d/%d Treffer angezeigt.

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
	Du bist nicht mehr von %s gebannt.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR channel what
CHAN_CLEARED_BANS
	Alle Bans auf Kanal %s sind gelöscht.
CHAN_CLEARED_MODES
	Alle Modi auf Kanal %s sind zurückgesetzt.
CHAN_CLEARED_OPS
	Modus +o wurde auf Kanal %s gelöscht.
CHAN_CLEARED_VOICES
	Modus +v wurde auf Kanal %s gelöscht.
CHAN_CLEARED_USERS
	Alle Benutzer sind aus dem Kanal %s
	gekickt worden.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS channel
CHAN_GETPASS_UNAVAILABLE
	GETPASS Befehl ist nicht verfügbar, weil Verschlüsselung
	aktiviert ist.
CHAN_GETPASS_PASSWORD_IS
	Passwort für Kanal %s ist %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID channel
CHAN_FORBID_SUCCEEDED
	Kanal %s ist nun verboten.
CHAN_FORBID_FAILED
	Kann Kanal %s nicht verbieten!

#################################################################
#
# MemoServ messages
#
#################################################################

# Automatic messages
MEMO_HAVE_NEW_MEMO
	Du hast ein neues Memo.
MEMO_HAVE_NEW_MEMOS
	Du hast %d neue Memos.
MEMO_TYPE_READ_LAST
	Tippe /msg %s READ LAST um sie zu lesen.
MEMO_TYPE_READ_NUM
	Tippe /msg %s READ %d um sie zu lesen.
MEMO_TYPE_LIST_NEW
	Tippe /msg %s LIST NEW für eine Liste.
MEMO_AT_LIMIT
	Warnung: Du hast die maximale Anzahl von Memos
	bekommen (%d). Du kannst keine neuen Memos erhalten,
	bis Du einige Alte gelöscht hast.
MEMO_OVER_LIMIT
	Warnung: Du hast mehr als die maximale Anzahl von
	Memos bekommen (%d). Du kannst keine neuen Memos
	erhalten, bis Du einige Alte gelöscht hast.
MEMO_NEW_MEMO_ARRIVED
	Du hast ein neues Memo von %s.
	Tippe /msg %s READ %d um sie zu lesen.

# Multi-use responses
MEMO_HAVE_NO_MEMOS
	Du hast keine Memos.
MEMO_X_HAS_NO_MEMOS
	%s hat keine Memos.
MEMO_DOES_NOT_EXIST
	Memo %d existiert nicht.
MEMO_LIST_NOT_FOUND
	Keine passenden Memos gefunden.

# SEND responses
MEMO_SEND_SYNTAX
	SEND {nick | channel} memo-text
MEMO_SEND_DISABLED
	Sorry, Memo verschicken ist derzeit abgeschaltet.
MEMO_SEND_PLEASE_WAIT
	Bitte warte %d Sekunden bevor Du den SEND Befehl
	nochmals benutzt.
MEMO_X_GETS_NO_MEMOS
	%s kann keine Memos empfangen.
MEMO_X_HAS_TOO_MANY_MEMOS
	%s hat derzeit zu viele Memos und kann keine
	weiteren empfangen.
MEMO_SENT
	Memo an %s geschickt.

# LIST responses
MEMO_LIST_SYNTAX
	LIST [channel] [list | NEW]
MEMO_HAVE_NO_NEW_MEMOS
	Du hast keine neuen Memos.
MEMO_X_HAS_NO_NEW_MEMOS
	%s hat keine neuen Memos.
MEMO_LIST_MEMOS
	Memos für %s.  Um zu lesen tippe:
	/msg %s READ num
MEMO_LIST_NEW_MEMOS
	Neue Memos für %s.  Um zu lesen tippe:
	/msg %s READ num
MEMO_LIST_CHAN_MEMOS
	Memos für %s.  Um zu lesen tippe:
	/msg %s READ %s num
MEMO_LIST_CHAN_NEW_MEMOS
	Neue Memos für %s.  Um zu lesen tippe:
	/msg %s READ num
MEMO_LIST_HEADER
	 Num  Sender            Datum/Zeit
MEMO_LIST_FORMAT
	%c%3d  %-16s  %s "%s..."

# READ responses
MEMO_READ_SYNTAX
	READ [channel] {list | LAST | NEW}
MEMO_HEADER
	Memo %d von %s (%s).  Um zu löschen
	tippe: /msg %s DEL %d
MEMO_CHAN_HEADER
	Memo %d von %s (%s).  Um zu löschen
	tippe: /msg %s DEL %d
MEMO_TEXT
	%s

# DEL responses
MEMO_DEL_SYNTAX
	DEL [channel] {num | list | ALL}
MEMO_DELETED_NONE
	Es wurden keine Memos gelöscht.
MEMO_DELETED_ONE
	Memo %d wurde gelöscht.
MEMO_DELETED_SEVERAL
	Memos %s wurde gelöscht.
MEMO_DELETED_ALL
	Es wurden alle Deine Memos gelöscht.

# SET responses
MEMO_SET_SYNTAX
	SET option parameters
MEMO_SET_DISABLED
	Sorry, Memo Einstellung ist derzeit abgeschaltet.
MEMO_SET_UNKNOWN_OPTION
	Unbekannte SET Einstellung %s.

# SET NOTIFY responses
MEMO_SET_NOTIFY_SYNTAX
	SET NOTIFY {ON | LOGON | NEW | OFF}
MEMO_SET_NOTIFY_ON
	%s wird Dich nun über Memos benachrichtigen,
	wenn Du Dich anmeldest, und wenn Du Neue erhältst.
MEMO_SET_NOTIFY_LOGON
	%s wird Dich nun über Memos benachrichtigen,
	wenn Du Dich anmeldest, und /AWAY abschaltest.
MEMO_SET_NOTIFY_NEW
	%s wird Dich nun über Memos benachrichtigen,
	wenn Du  Neue erhältst.
MEMO_SET_NOTIFY_OFF
	%s wird Dich nicht wegen Memos benachrichtigen.

# SET LIMIT responses
MEMO_SET_LIMIT_SYNTAX
	SET LIMIT [channel] limit
MEMO_SET_LIMIT_SERVADMIN_SYNTAX
	SET LIMIT [user | channel] {limit | NONE} [HARD]
MEMO_SET_YOUR_LIMIT_FORBIDDEN
	Du hast nicht das Recht Deine Memo-Obergrenze zu ändern.
MEMO_SET_LIMIT_FORBIDDEN
	Die Memo-Obergrenze für %s darf nicht
	geändert werden.
MEMO_SET_YOUR_LIMIT_TOO_HIGH
	Du kannst Deine Memo-Obergrenze nicht höher
	als %d setzen.
MEMO_SET_LIMIT_TOO_HIGH
	Du kannst die Memo-Obergrenze für %s nicht höher
	als %d setzen.
MEMO_SET_LIMIT_OVERFLOW
	Memo-Obergrenze zu groß; zurückgesetzt auf %d.
MEMO_SET_YOUR_LIMIT
	Deine Memo-Obergrenze wurde auf %d gesetzt.
MEMO_SET_YOUR_LIMIT_ZERO
	Du kannst keine Memos mehr empfangen.
MEMO_UNSET_YOUR_LIMIT
	Deine Memo-Obergrenze wurde abgeschaltet.
MEMO_SET_LIMIT
	Memo-Obergrenze für %s auf %d gesetzt.
MEMO_SET_LIMIT_ZERO
	Memo-Obergrenze für %s auf 0 gesetzt.
MEMO_UNSET_LIMIT
	Memo-Obergrenze für %s abgeschaltet.

# INFO responses
MEMO_INFO_SYNTAX
	INFO [channel]
MEMO_INFO_SERVADMIN_SYNTAX
	INFO [nick | channel]
MEMO_INFO_NO_MEMOS
	Du hast derzeit keine Memos.
MEMO_INFO_MEMO
	Du hast derzeit 1 Memo.
MEMO_INFO_MEMO_UNREAD
	Du hast derzeit 1 ungelesenes Memo.
MEMO_INFO_MEMOS
	Du hast derzeit %d Memos.
MEMO_INFO_MEMOS_ONE_UNREAD
	Du hast derzeit %d Memos, davon 1 Ungelesenes.
MEMO_INFO_MEMOS_SOME_UNREAD
	Du hast derzeit %d Memos, davon
	%d Ungelesene.
MEMO_INFO_MEMOS_ALL_UNREAD
	Du hast derzeit %d ungelesene Memos.
MEMO_INFO_LIMIT
	Deine Memo-Obergrenze ist %d.
MEMO_INFO_HARD_LIMIT
	Deine Memo-Obergrenze ist %d und kann nicht
	geändert werden.
MEMO_INFO_LIMIT_ZERO
	Deine Memo-Obergrenze ist 0; Du kannst keine neuen
	Memos empfangen.
MEMO_INFO_HARD_LIMIT_ZERO
	Deine Memo-Obergrenze ist 0; Du kannst keine neuen
	Memos empfangen. Du kannst diese Grenze nicht ändern.
MEMO_INFO_NO_LIMIT
	Du hast keine Memo-Obergrenze.
MEMO_INFO_X_NO_MEMOS
	%s hat derzeit keine Memos.
MEMO_INFO_X_MEMO
	%s hat derzeit 1 Memo.
MEMO_INFO_X_MEMO_UNREAD
	%s hat derzeit 1 ungelesenes Memo.
MEMO_INFO_X_MEMOS
	%s hat derzeit %d Memos.
MEMO_INFO_X_MEMOS_ONE_UNREAD
	%s hat derzeit %d Memos, davon
	1 Ungelesenes.
MEMO_INFO_X_MEMOS_SOME_UNREAD
	%s hat derzeit %d Memos, davon
	%d Ungelesene.
MEMO_INFO_X_MEMOS_ALL_UNREAD
	%s hat derzeit %d ungelesene Memos.
MEMO_INFO_X_LIMIT
	%s Memo-Obergrenze ist %d.
MEMO_INFO_X_HARD_LIMIT
	%s Memo-Obergrenze ist %d.
MEMO_INFO_X_NO_LIMIT
	%s hat keine Memo-Obergrenze.

#################################################################
#
# OperServ messages
#
#################################################################

# General messages
OPER_BOUNCY_MODES
	Services können keine Modes ändern. Sind Deine Server
	richtig konfiguriert?
OPER_BOUNCY_MODES_U_LINE
	Services können keine Modes ändern.  Ist die U:line
	Deines Servers richtig konfiguriert?

# GLOBAL responses
OPER_GLOBAL_SYNTAX
	GLOBAL message

# STATS responses
OPER_STATS_UNKNOWN_OPTION
	Unbekannte STATS Einstellung%s.
OPER_STATS_CURRENT_USERS
	Aktuelle Benutzer: %d (%d Ops, %d Helfer, %d bots)
OPER_STATS_MAX_USERS
	Maximale Benutzer: %d (%s)
# This is ugly, but at least it's language-portable...
# Note that you can include seconds in any of these--my personal
# preference is to only give resolution to the nearest minute
# when uptime is one hour or more, but just add a %d to get
# seconds as well.
OPER_STATS_UPTIME_DHMS
	Services seit %d Tagen, %02d:%02d aktiv
OPER_STATS_UPTIME_1DHMS
	Services seit %d Tag, %02d:%02d aktiv
OPER_STATS_UPTIME_HMS
	Services seit %d Stunden, %d Minuten aktiv
OPER_STATS_UPTIME_HM1S
	Services seit %d Stunden, %d Minuten aktiv
OPER_STATS_UPTIME_H1MS
	Services seit %d Stunden, %d Minute aktiv
OPER_STATS_UPTIME_H1M1S
	Services seit %d Stunden, %d Minute aktiv
OPER_STATS_UPTIME_1HMS
	Services seit %d Stunde, %d Minuten aktiv
OPER_STATS_UPTIME_1HM1S
	Services seit %d Stunde, %d Minuten aktiv
OPER_STATS_UPTIME_1H1MS
	Services seit %d Stunde, %d Minute aktiv
OPER_STATS_UPTIME_1H1M1S
	Services seit %d Stunde, %d Minute aktiv
OPER_STATS_UPTIME_MS
	Services seit %d Minuten, %d Sekunden aktiv
OPER_STATS_UPTIME_M1S
	Services seit %d Minuten, %d Sekunde aktiv
OPER_STATS_UPTIME_1MS
	Services seit %d Minute, %d Sekunden aktiv
OPER_STATS_UPTIME_1M1S
	Services seit %d Minute, %d Sekunde aktiv
OPER_STATS_USER_MEM
	Benutzer: %6d Rekord, %5d kB
OPER_STATS_CHANNEL_MEM
	Kanal   : %6d Rekord, %5d kB
OPER_STATS_NICKSERV_MEM
	NickServ: %6d Rekord, %5d kB
OPER_STATS_CHANSERV_MEM
	ChanServ: %6d Rekord, %5d kB
OPER_STATS_OPERSERV_MEM
	OperServ: %6d Rekord, %5d kB
OPER_STATS_AKILL_COUNT
	 Aktuelle Zahl der AKILLs: %d
OPER_STATS_AKILL_EXPIRE_DAYS
	Normale AKILL Ablauf Zeit: %d Tage
OPER_STATS_AKILL_EXPIRE_DAY
	Normale AKILL Ablauf Zeit: 1 Tag
OPER_STATS_AKILL_EXPIRE_HOURS
	Normale AKILL Ablauf Zeit: %d Stunden
OPER_STATS_AKILL_EXPIRE_HOUR
	Normale AKILL Ablauf Zeit: 1 Stunde
OPER_STATS_AKILL_EXPIRE_MINS
	Normale AKILL Ablauf Zeit: %d Minuten
OPER_STATS_AKILL_EXPIRE_MIN
	Normale AKILL Ablauf Zeit: 1 Minute
OPER_STATS_AKILL_EXPIRE_NONE
	Normale AKILL Ablauf Zeit: kein Ablauf

# MODE responses
OPER_MODE_SYNTAX
	MODE channel modes

# CLEARMODES responses
OPER_CLEARMODES_SYNTAX
	CLEARMODES channel [ALL]
OPER_CLEARMODES_DONE
	Binär Modes und Bans vom Kanal %s gelöscht.
OPER_CLEARMODES_ALL_DONE
	Alle Modi vom Kanal %s gelöscht.

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
	Services sind im Skeleton Modus; der ADMIN Befehl ist
	nicht verfügbar.
OPER_ADMIN_EXISTS
	%s existiert bereits auf der
	Service Admin Liste.
OPER_ADMIN_ADDED
	%s wurde der Services Admin Liste hinzugefügt.
OPER_ADMIN_TOO_MANY
	Zu viele Einträge (%d) auf der Service Admin Liste;
	kann keine weiteren hinzufügen.
OPER_ADMIN_REMOVED
	%s von der Service Admin Liste gelöscht.
OPER_ADMIN_NOT_FOUND
	%s nicht auf der Service Admin Liste gefunden.
OPER_ADMIN_LIST_HEADER
	Service Admin Liste:

# OPER responses
OPER_OPER_SYNTAX
	OPER { {ADD | DEL | LIST} [nick] | SUSPEND nick Tage }
OPER_OPER_ADD_SYNTAX
	OPER ADD nick
OPER_OPER_DEL_SYNTAX
	OPER DEL nick
OPER_OPER_SKELETON
	Services sind im Skeleton Modus; der OPER Befehl ist
	nicht verfügbar.
OPER_OPER_EXISTS
	%s existiert bereits auf der
	Service Oper Liste.
OPER_OPER_ADDED
	%s wurde der Services Oper Liste hinzugefügt.
OPER_OPER_TOO_MANY
	Zu viele Einträge (%d) auf der Service Oper Liste;
	kann keine weiteren hinzufügen.
OPER_OPER_REMOVED
	%s von der Service Oper Liste gelöscht.
OPER_OPER_NOT_FOUND
	%s nicht auf der Service Oper Liste gefunden.
OPER_OPER_LIST_HEADER
	Service Oper Liste:

# AKILL responses
OPER_AKILL_SYNTAX
	AKILL {ADD | DEL | LIST | VIEW} [[+expiry] mask [reason]]
OPER_AKILL_ADD_SYNTAX
	AKILL ADD [+expiry] mask reason
OPER_AKILL_DEL_SYNTAX
	AKILL DEL mask
OPER_TOO_MANY_AKILLS
	AKILL Liste ist voll!
OPER_AKILL_NO_NICK
	Erinnerung: AKILL Masken können keine Nicks
	enthalten; Stelle sicher, das Du nicht Teile eines
	Nicks in einer Maske verwendest.
OPER_AKILL_ADDED
	%s wurde der AKILL Liste hinzugefügt.
OPER_AKILL_REMOVED
	%s von der AKILL Liste gelöscht.
OPER_AKILL_NOT_FOUND
	%s nicht auf der AKILL Liste gefunden.
OPER_AKILL_LIST_HEADER
	Aktuelle AKILL Liste:
# mask, reason
OPER_AKILL_LIST_FORMAT
	%-32s  %s
# mask, set-by, set-time, expires, reason
OPER_AKILL_VIEW_FORMAT
	%s (von %s auf %s; %s)
	    %s
OPER_AKILL_NO_EXPIRE
	läuft nicht ab.
OPER_AKILL_EXPIRES_SOON
	läuft bei der nächsten Datenbank-Aktualisierung ab
OPER_AKILL_EXPIRES_M
	läuft in %d Minuten ab
OPER_AKILL_EXPIRES_1M
	läuft in %d Minute ab
OPER_AKILL_EXPIRES_HM
	läuft in %d Stunden, %d Minuten ab
OPER_AKILL_EXPIRES_H1M
	läuft in %d Stunden, %d Minute ab
OPER_AKILL_EXPIRES_1HM
	läuft in %d Stunde, %d Minuten ab
OPER_AKILL_EXPIRES_1H1M
	läuft in %d Stunde, %d Minute ab
OPER_AKILL_EXPIRES_D
	läuft in %d Stunden ab
OPER_AKILL_EXPIRES_1D
	läuft in %d Stunde ab

# SET responses
OPER_SET_SYNTAX
	SET option setting
OPER_SET_IGNORE_ON
	Ignore Code wird benutzt.
OPER_SET_IGNORE_OFF
	Ignore Code wird nicht benutzt.
OPER_SET_IGNORE_ERROR
	Einstellung von IGNORE muß ON oder OFF sein.
OPER_SET_READONLY_ON
	Services sind nun im read-only Modus.
OPER_SET_READONLY_OFF
	Services sind nun im read-write Modus.
OPER_SET_READONLY_ERROR
	Einstellung von READ-ONLY muß ON oder OFF sein.
OPER_SET_DEBUG_ON
	Services sind nun im debug Modus.
OPER_SET_DEBUG_OFF
	Services sind nun im non-debug Modus.
OPER_SET_DEBUG_LEVEL
	Services sind nun im debug Modus (Stufe %d).
OPER_SET_DEBUG_ERROR
	Einstellung von DEBUG muss ON, OFF oder eine
	positive Zahl sein.
OPER_SET_UNKNOWN_OPTION
	Unbekannte Einstellung %s.

# JUPE responses
OPER_JUPE_SYNTAX
	JUPE servername [reason]

# RAW responses
OPER_RAW_SYNTAX
	RAW text

# UPDATE responses
OPER_UPDATING
	Aktualisiere Datenbanken.

# RESTART responses
OPER_CANNOT_RESTART
	SERVICES_BIN nicht definiert; kein Neustart möglich.
	Starte das 'configure' Skript nochmals und compiliere
	die Services erneut um den RESTART Befehl zu aktivieren.

# LISTIGNORE responses
OPER_IGNORE_LIST
	Services Ignore Liste:
OPER_IGNORE_LIST_EMPTY
	Ignore liste ist leer.

#################################################################
#
# News System messages
#
#################################################################

NEWS_LOGON_TEXT
	[Logon News - %s] %s
NEWS_OPER_TEXT
	[Oper News - %s] %s
NEWS_LOGON_SYNTAX
	Syntax: LOGONNEWS {ADD|DEL|LIST} [text|num]
NEWS_LOGON_LIST_HEADER
	Logon News Artikel:
NEWS_LOGON_LIST_ENTRY
	%5d (%s von %s)
	    %s
NEWS_LOGON_LIST_NONE
	Es gibt keine Logon News.
NEWS_LOGON_ADD_SYNTAX
	Syntax: LOGONNEWS ADD text
NEWS_LOGON_ADD_FULL
	News Liste ist voll!
NEWS_LOGON_ADDED
	Neuer Logon News Artikel hinzugefügt (#%d).
NEWS_LOGON_DEL_SYNTAX
	Syntax: LOGONNEWS DEL {num | ALL}
NEWS_LOGON_DEL_NOT_FOUND
	Logon News Artikel #%d nicht gefunden!
NEWS_LOGON_DELETED
	Logon News Artikel #%d gelöscht.
NEWS_LOGON_DEL_NONE
	Keine Logon News Artikel zum Löschen!
NEWS_LOGON_DELETED_ALL
	Alles Logon News Artikel gelöscht.
NEWS_OPER_SYNTAX
	Syntax: OPERNEWS {ADD|DEL|LIST} [text|num]
NEWS_OPER_LIST_HEADER
	Oper News Artikel:
NEWS_OPER_LIST_ENTRY
	%5d (%s von %s)
	    %s
NEWS_OPER_LIST_NONE
	Keine Oper News.
NEWS_OPER_ADD_SYNTAX
	Syntax: OPERNEWS ADD text
NEWS_OPER_ADD_FULL
	News Liste ist voll!
NEWS_OPER_ADDED
	Neuer Oper News Artikel hinzugefügt (#%d).
NEWS_OPER_DEL_SYNTAX
	Syntax: OPERNEWS DEL {num | ALL}
NEWS_OPER_DEL_NOT_FOUND
	Oper News Artikel #%d nicht gefunden!
NEWS_OPER_DELETED
	Oper News Artikel #%d gelöscht.
NEWS_OPER_DEL_NONE
	Keine Oper News Artikel zum Löschen!
NEWS_OPER_DELETED_ALL
	Alle Oper News Artikel gelöscht.
NEWS_HELP_LOGON
	Syntax: LOGONNEWS ADD text
	        LOGONNEWS DEL {num | ALL}
	        LOGONNEWS LIST
	
	Bearbeitet oder zeigt die Liste der Logon News
	Nachrichten. Wenn sich ein Benutzer anmeldet, werden ihm
	diese Nachrichten geschickt.  (Wie auch immer, es werden
	nicht mehr als drei Nachrichten verschickt um den
	Benutzer nicht zu flooden. Wenn mehr als drei Nachrichten
	vorliegen, werden nur die drei Neuesten geschickt.)
	
	LOGONNEWS LIST kann von einem IRC Operator benutzt
	werden, um die derzeitigen Nachrichten anzuzeigen.  ADD
	und DEL können nur von Service Admins benutzt werden.

NEWS_HELP_OPER
	Syntax: OPERNEWS ADD text
	        OPERNEWS DEL {num | ALL}
	        OPERNEWS LIST
	
	Bearbeitet oder zeigt die Liste der Oper News
	Nachrichten. Wenn sich ein Oper anmeldet (mit dem /oper
	Befehl), werden ihm diese Nachrichten geschickt.  (Wie
	auch immer, es werden nicht mehr als drei Nachrichten
	verschickt um den Benutzer nicht zu flooden. Wenn mehr
	als drei Nachrichten vorliegen, werden nur die drei
	Neuesten geschickt.)
	
	OPERNEWS LIST kann von jedem IRC Operator benutzt werden,
	um die derzeitigen Oper Nachrichten anzuzeigen.  ADD und
	DEL können nur von Service Admins benutzt werden.

#################################################################
#
# NickServ help messages
#
#################################################################

NICK_HELP
	%S erlaubt es, einen Nick zu registrieren, und
	andere davon abzuhalten Diesen zu benutzen.  Wenn ein
	Nick %d Tage nicht benutzt wird, läuft die
	Registrierung ab.  Die folgenden Befehle ermöglichen die
	Registrierung und Pflege von Nicks; um Sie zu benutzen
	tippe /msg %S command. Weitere Hilfe für
	einen bestimmten Befehl erhältst Du mit
	/msg %S HELP command.
	
	 AJOIN      Ändere Deine Auto-Join Kanal-Liste
	 REGISTER   Registriere einen Nick
	 IDENTIFY   Identifiziere Dich selbst mit Deinem Passwort
	 LINK       Linke Deinen Nick zu einen Anderen
	 SET        Setze Einstellungen
	 DROP       Lösche die Registrierung eines Nicks
	 LISTLINKS  Liste die Nicks, die mit Deinem Nick
	            gelinkt sind.
	 NOTES      Erlaubt Dir Text Nachrichten zu speichern.
	 GHOST	    Killt eine ghost Verbindung fuer den Nick

	Andere Befehle: UNLINK, INFO, LIST, STATUS
	
	Achtung: Dieser Service bietet einen Möglichkeit
	sicherzustellen, daß die Identität eines Benutzers nicht
	kompromittiert ist.  Er ist NICHT dafür gedacht, das
	"Stehlen" von Nicks und andere heimtückische Aktionen zu
	fördern.  Der Mißbrauch des %S wird mindestens
	mit dem Verlust der mißbrauchten Nick(s) geahndet.

NICK_HELP_EXPIRE_ZERO
	%S erlaubt es, einen Nick zu registrieren, und
	andere davon abzuhalten Diesen zu benutzen.  Die
	folgenden Befehle ermöglichen die Registrierung und
	Pflege von Nicks; um Sie zu benutzen tippe
	/msg %S command.  Weitere Hilfe für einen
	bestimmten Befehl erhältst Du mit
	/msg %S HELP command.
	
	 REGISTER  Registriere einen Nick
	 IDENTIFY  Identifiziere Dich selbst mit Deinem Passwort
	 LINK      Linke Deinen Nick zu einen Anderen
	 SET       Setze Einstellungen, einschließlich Kill
	           Schutz
	 DROP      Lösche die Registrierung eines Nicks
	
	Andere Befehle: UNLINK, GHOST, INFO, LIST, STATUS
	
	Achtung: Dieser Service bietet einen Möglichkeit
	sicherzustellen, daß die Identität eines Benutzers nicht
	kompromittiert ist.  Er ist NICHT dafür gedacht, das
	"Stehlen" von Nicks und andere heimtückische Aktionen zu
	fördern.  Der Mißbrauch des %S wird mindestens
	mit dem Verlust der mißbrauchten Nick(s) geahndet.

NICK_HELP_REGISTER
	Syntax: REGISTER password email
	
	Registriert Deinen Nick in der %S Datenbank.  Wenn
	Du keine Email-Adresse hast, trage NOMAIL ein.  Wenn
	Dein Nick registriert ist, kannst Du die Einstellungen
	mit dem SET Befehl ändern.
	
	Stelle sicher das Du Dir das Passwort merkst - Du
	brauchst es um später weitere Änderungen an Deiner
	Registrierung zu machen. (Achtung. Im Passwort ist
	Groß/Klein-Schreibung relevant FIDO, Fido,
	und fido sind alle verschiedene Passwörter!)
	
	Richtlinien um ein Passwort auszuwählen:
	
	Passwörter sollen nicht einfach zu erraten sein.  Es ist
	zum Beispiel eine schlechte Idee, Deinen richtigen Namen
	als Passwort zu benutzen. Dein Nick als Passwort zu
	benutzen ist übrigens eine noch schlechtere Idee ;-) und
	%S erlaubt dieses auch nicht.  Außerdem sind
	kurze Passwörter verwundbar für
	Versuch-und-Fehler-Suchen. Du solltest also ein Passwort
	wählen, welches mindestens fünf Zeichen lang ist. Das
	Leerzeichen kann in Passwörtern nicht verwendet werden.
	
NICK_HELP_IDENTIFY
	Syntax: IDENTIFY password
	
	Beweist %S, das Du wirklich der Besitzer dieses
	Nicks bist. Viele Befehle erfordern, daß Du Dich vor der
	Nutzung autorisierst.  Daß Passwort muß dasselbe sein,
	wie das was Du mit dem REGISTER-Befehl geschickt hast.

NICK_HELP_DROP
	Syntax: DROP
	
	Löscht Deinen Nick aus der %S Datenbank.  Ein
	gelöschter Nick kann von jedem anderen Benutzer wieder
	registriert werden.
	
	Um diesen Befehl zu benutzen, mußt Du Dich erst mit
	Deinem Passwort identifizieren
	(/msg %S HELP IDENTIFY für
	weitere Informationen).

NICK_HELP_LINK
	Syntax: LINK nick password
	
	Linkt Deinen Nick zu einem Anderen, registriert deinen
	aktuellen Nick als Alias für den angegebenen Nick.  Wenn
	Du diesen Befehl eingibst, wird die Auto-Join Liste für
	Deinen aktuellen Nick gelöscht und durch die Liste des
	angegebenen Nicks ersetzt; alle Memos des aktuellen Nick
	werden den Memos des angegebenen Nick hinzugefügt
	(Dadurch kann die Obergrenze der Memos überschritten
	werden; Du mußt dann einige Memos löschen, damit Du
	wieder neue Memos empfangen kannst).
	
	Wenn der Link eingerichtet ist, wird Dein Nick in allen
	Services in den Ziel-Nick umgewandelt, außer in den
	%S UNLINK und DROP Befehlen.  Du kannst
	zum Beispiel beide Nicks benutzen um Deine Memos zu lesen
	(und Memos an beide Nicks werden der gleichen Liste
	hinzugefügt). Wenn Du Dich für einen Nick identifizierst,
	wirst Du auch für den anderen Nick erkannt.  Wenn einer
	der Nicks auf der Zugangs-Liste eines Kanals ist,
	erhalten beide dieselben Zugangs-rechte.
	
	Um diesen Befehl zu benutzen, mußt Du Dich erst mit
	Deinem Passwort identifizieren
	(/msg %S HELP IDENTIFY für
	weitere Informationen).

NICK_HELP_UNLINK
	Syntax: UNLINK [nick pass]
	
	Entfernt einen Link von einen Nick zu einem Anderen.
	Wenn der Link gelöscht wird, werden die Einstellungen und
	die Auto-Join Liste des entlinkten Nicks zu dem Aktuellen
	kopiert und können dann unabhängig voneinander geändert
	werden.  Memos werden nicht kopiert; alle Memos bleiben
	bei dem vorher gelinkten Nick gespeichert.
	
	Indem Du Nick und Passwort als Parameter angibst, kannst
	Du einen Nick entlinken, außer dem den Du zu dem
	Zeitpunkt benutzt.
	
NICK_HELP_SET
	Syntax: SET option parameters
	
	Setze verschiedene Nick Einstellung.
	option kann sein:
	
	 PASSWORD   Setze Dein Nick Passwort
	 LANGUAGE   Setze die Sprache, die Services benutzen um
	            Dir Nachrichten zu schicken
	 URL        Setze eine URL
	 EMAIL      Setze eine Email Adresse
	 ICQNUMBER  Setze eine ICQ Nummer
	 LOCATION   Setze einen Standort
	 KILL       Schalte Kill Schutz an oder aus
	 PRIVATE    Verhindere das Anzeigen Deines Nicks in
	            /msg %S LIST
	 HIDE       Unterdrücke bestimmte Teile Deiner Nick
	            Information
	
	Um diesen Befehl zu benutzen, mußt Du Dich erst mit
	Deinem Passwort identifizieren
	(/msg %S HELP IDENTIFY für
	weitere Informationen).
	
	Tippe /msg %S HELP SET option für weitere
	Information zu einer bestimmten Einstellung.

NICK_HELP_SET_PASSWORD
	Syntax: SET PASSWORD new-password
	
	ändert das Passwort, welches Dich als Besitzer des
	Nicks identifiziert.

NICK_HELP_SET_LANGUAGE
	Syntax: SET LANGUAGE number
	
	Ändert die Sprache, die die Services benutzen um Dir
	Nachrichten zu schicken (zum Beispiel als Antwort auf
	einen Befehl von Dir). number kann von der folgenden
	Liste der unterstützten Sprachen gewählt werden:

NICK_HELP_SET_URL
	Syntax: SET URL url
	
	Fügt Deinem Nick die angegebene URL hinzu.  Die URL wird
	angezeigt wenn jemand mit dem INFO Befehl
	Informationen über Deinen Nick abruft.

NICK_HELP_SET_EMAIL
	Syntax: SET EMAIL address
	
	Fügt Deinem Nick die angegebene Email Adresse hinzu.  Die
	Adresse wird angezeigt wenn jemand mit dem INFO
	Befehl Informationen über Deinen Nick abruft.

NICK_HELP_SET_ICQ
	Syntax: SET ICQNUMBER #number
	
	Fügt Deinem Nick die angegebene ICQ Nummer hinzu. Die
	Nummer wird angezeigt wenn jemand mit dem INFO Befehl
	Informationen über Deinen Nick abruft.
NICK_HELP_SET_LOCATION
	Syntax: SET LOCATION  location
	
	Fügt Deinem Nick den angegebenen Standort hinzu. Der
	Standort wird angezeigt wenn jemand mit dem INFO
	Befehl Informationen über Deinen Nick abruft.
NICK_HELP_SET_KILL
	Syntax: SET KILL {ON | QUICK | IMMED | OFF}
	
	Schaltet den automatischen Kill-Schutz ein oder aus.  Mit
	eingeschaltetem Kill-Schutz wird einem anderen
	Benutzern, der Deinen Nick benutzt, eine Minute Zeit
	gegeben den Nick zu wechseln, bevor er von %S aus
	dem IRC entfernt wird.
	
	Wenn Du QUICK einstellst, werden dem Benutzer nur 20
	statt 60 Sekunden gegeben, um den Nick zu wechseln. Wenn
	Du IMMED einstellst, wird der Benutzer sofort
	ohne Warnung und ohne eine Chance den Nick zu
	wechseln aus dem IRC entfernt; Bitte benutze diese
	Einstellung nur im Notfall.  Diese Einstellung ist
	eventuell vom Administrator abgeschaltet.

NICK_HELP_SET_PRIVATE
	Syntax: SET PRIVATE {ON | OFF}
	
	Schaltet %S's Privat Einstellung für Deinen
	Nick an oder aus.  Wenn PRIVATE eingeschaltet ist,
	wird Dein Nick nicht beim %S's LIST Befehl
	angezeigt.  (Wenn jemand Deinen Nick kennt, kann er
	mit dem INFO Befehl immer noch Informationen über
	Dich abrufen.)

NICK_HELP_SET_HIDE
	Syntax: SET HIDE {EMAIL | QUIT} {ON | OFF}
	
	Ermöglicht Dir die Unterdrückung bestimmter Teile Deiner
	Nick Information, wenn jemand Deinen Nick mit dem
	INFO Befehl abruft.  Du kannst Deine Email Adresse
	(EMAIL) und Deine letzte quit Nachricht (QUIT).
	Der zweite Parameter gibt an ob die Information angezeigt
	wird (OFF) oder nicht (ON).

NICK_HELP_GHOST
	Syntax: GHOST nickname [password]
	
	Terminiert eine "Ghost" IRC Session mit Deinem Nick.
	Eine "Ghost" Session ist eine Session die nicht mehr
	verbunden ist, bei der der Server aber immer noch
	annimmt, das sie aktiv sei.  So etwas passiert, wenn Dein
	Rechner abstürzt oder Deine Internet-Verbindung
	unterbrochen wurde, während Du im IRC warst.
	
	Um den GHOST Befehl für einen Nick zu benutzen, mußt
	Du das richtige Passwort für den Nick angeben.

NICK_HELP_INFO
	Syntax: INFO nickname
	
	Zeigt Informationen über den angegebenen Nick an, z.B.
	den Eigentümer, die zuletzt gesehene Adresse und Zeit und
	die Nick Einstellungen.

NICK_HELP_LIST
	Syntax: LIST pattern
	
	Zeige alle registrierten Nicks, welche auf den
	angegebenen Filter, in nick!user@host Format, passen.
	Nicks, die die PRIVATE Einstellung gesetzt haben,
	werden nicht angezeigt.
	
	Beispiele:
	
	 LIST *!joeuser@foo.com
	  Zeige alle registrierten Nicks die joeuser@foo.com
	  gehören.
	
	 LIST *Bot*!*@*
	  Zeige alle registrierten Nicks, die Bot in Ihrem
	  Namen haben (Groß/Kleinschreibung ignoriert)
	
	 LIST *!*@*.bar.org
	  Zeige alle registrierten Nicks, die Benutzern der
	  bar.org Domain gehören.

NICK_HELP_STATUS
	Syntax: STATUS nickname...
	
	Gibt aus, ob der Benutzer der den angegebenen Nick
	benutzt, der Besitzer des Namens ist. Die Antwort hat
	dieses Format:
	
	 nickname status-code
	
	nickname ist der Nick der der abgefragt wurde und
	status-code ist eins der folgenden:
	
	 0 - Benutzer nicht online oder Nick nicht
	     registriert.
	 1 - Benutzer wird nicht als der Eigentümer erkannt.
	 2 - Benutzer wurde als Eigentümer per Passwort
	     Identifizierung erkannt.
	 3 - Benutzer wurde als Eigentümer per Passwort
	     Identifizierung erkannt.
	
	Bis zu sechzehn Nicks können pro Befehl abgefragt werden;
	Der Rest wird ignoriert.  Es wird keine Fehlermeldung
	generiert wenn keine Nicks angegeben werden.

NICK_SERVADMIN_HELP
	
	Die folgenden Befehle sind für Service Admins verfügbar:
	
	 GETPASS    Gib das Passwort für einen Nick aus
	                (nur wenn Kodierung abgeschaltet ist)
	 FORBID     Verhindert die Nutzung eines Nick
	 LISTLINKS  Zeige alle Links für einen Nick
	
	Service Admins können jeden Nick löschen, ohne sich dafür
	identifizieren zu müssen, und können die Auto-Join Liste
	für jeden Nick ansehen
	(/msg %S AJOIN LIST nick).
	
NICK_SERVADMIN_HELP_DROP
	Syntax: DROP [nickname]
	
	Ohne Parameter: Löscht Deinen Nick aus der
	%S Datenbank.
	
	Mit einem Parameter: Löscht den gegebenen Nick aus der
	Datenbank. Dieses ist auf Services Admins begrenzt.

NICK_SERVADMIN_HELP_SET
	
	Service Admins können die Einstellung NOEXPIRE
	setzen, welches verhindert das Nicks ablaufen.  Außerdem
	können Service Admins Einstellungen für jeden Nick
	setzen, ohne ein Passwort eingeben zu müssen. Format:
	SET nickname option parameters.

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET [nickname] NOEXPIRE {ON | OFF}
	
	Gibt an, ob der Nick abläuft.  Wenn auf ON gesetzt,
	läuft der Nick nicht ab. Wenn kein Nick angegeben wird,
	wird Dein eigener Nick gesetzt.
	
	Nur für Services Admins.

NICK_SERVADMIN_HELP_UNLINK
	
	Service Admins können jeden Nick, ohne ein Passwort
	eingeben zu müssen, entlinken.

NICK_HELP_LISTLINKS
	Syntax: LISTLINKS
	
	Zeige Nicks an, welche zu einem gegebenen Nick
	gelinkt sind.

NICK_SERVADMIN_HELP_LISTLINKS
	Syntax: LISTLINKS nick [ALL]
	
	Zeige Nicks an, welche zu einem gegebenen Nick gelinkt
	sind.  Wenn ALL angegeben wird, werden alle Nicks
	ausgegeben, die dieselben Privilegien wie der gegebene
	Nick haben; sonst werden nur Nicks ausgegeben die direkt
	gelinkt sind.

NICK_SERVADMIN_HELP_LIST
	Syntax: LIST pattern [FORBIDDEN] [NOEXPIRE]
	
	Zeige alle registrierten Nicks, welche auf den
	angegebenen Filter, in nick!user@host Format, passen.
	Nicks, die die PRIVATE Einstellung gesetzt haben,
	werden nur Services Admins angezeigt.  Nicks mit der
	NOEXPIRE Einstellung werden durch ein vorangestelltes
	! gekennzeichnet.
	
	Wenn die FORBIDDEN oder NOEXPIRE Einstellung angegeben
	wird, werden nur Nicks welche die FORBIDDEN oder NOEXPIRE
	gesetzt haben, angezeigt. Wenn beide Einstellungen
	angegeben werden, werden beide Typen ausgegeben. Diese
	Einstellungen sind nur für Services Admins verfügbar.
	
	Beispiele:
	
	 LIST *!joeuser@foo.com
	  Zeige alle registrierten Nicks die joeuser@foo.com
	  gehören.
	
	 LIST *Bot*!*@*
	  Zeige alle registrierten Nicks, die Bot in Ihrem
	  Namen haben (Groß/Kleinschreibung ignoriert)
	
	 LIST * NOEXPIRE
	  Zeige alle registrierten Nicks die nicht  ablaufen.

NICK_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS nickname
	
	Zeigt das Passwort des Nicks.  Achtung Wenn dieser
	Befehl benutzt wird, wird eine Nachricht mit demjenigen
	der den Befehl eingeben hat und dem Nick der abgefragt
	wurde geloggt und als WALLOPS/GLOBOPS verschickt.
	
	Nur für Services Admins.
	
	Dieser Befehl ist nicht verfügbar, wenn Kodierung
	aktiviert wurde.
	
NICK_SERVADMIN_HELP_FORBID
	Syntax: FORBID nickname
	
	Verbietet die Registrierung oder Nutzung des Nicks für
	alle.  Kann gelöscht werden mit dem DROP-Befehl.
	
	Nur für Services Admins.

#################################################################
#
# ChanServ help messages
#
#################################################################

CHAN_HELP
	
	%S erlaubt es, einen Kanal zu registrieren,
	und verschiedene Einstellungen des Kanals zu
	kontrollieren.  %S kann meist verhindern, daß
	boshafte Benutzer einen Kanal übernehmen, indem nur
	bestimmte Nicks erlaubt wird Operator Status zu erlangen.
	Verfügbare Befehle sind unten aufgeführt; Um sie zu
	benutzen tippe /msg %S command. Weitere
	Hilfe für einen bestimmten Befehl erhältst Du mit
	/msg %S HELP command.
	
	 REGISTER  Registriere einen Kanal
	 IDENTIFY  Identifiziere Dich selbst mit Deinem Passwort
	 SET       Setze Kanal Einstellungen und Information
	 ACCESS    Bearbeite die Liste der privilegierten
	           Benutzer
	 AOP/SOP   Alias um die Liste der privilegierten Benutzer 
	           zu bearbeiten
	 LEVELS    Redefiniere die Bedeutung der Zugangs-Stufen
	 AKICK     Pflege die Auto-Kick Liste
	 DROP      Lösche die Registrierung eines Kanals
	
	Andere Befehle: INFO, LIST, INVITE, OP, DEOP, UNBAN,
	                KICK, CLEAR

CHAN_HELP_EXPIRES
	Beachte das jeder Kanal, der %d Tage nicht benutzt
	wird (also kein Benutzer der Zugangs-Liste in dem
	Zeitraum den Kanal betritt) automatisch gelöscht wird.

CHAN_HELP_REGISTER
	Syntax: REGISTER channel password description
	
	Registriert einen Kanal in der %S Datenbank.  Um
	diesen Befehl zu benutzen mußt Du erst Operator in dem
	Kanal, den Du registrieren willst, sein.  Das Passwort
	wird im IDENTIFY Befehl benutzt, um Dir Änderungen
	der Kanal Einstellungen zu einem späteren Zeitpunkt zu
	erlauben.  Der letzte Parameter, welcher benutzt werden
	muß, soll eine allgemeine Beschreibung des
	Kanal-Zwecks enthalten..
	
	Wenn Du einen Kanal registrierst, wirst Du als "Founder"
	des Kanals registriert. Der Kanal Founder darf alle
	Einstellungen des Kanals ändern; %S wird dem
	Founder außerdem automatisch Kanal-Operator-Rechte
	geben, wenn er den Kanal betritt.
	
	Benutze den ACCESS Befehl
	(/msg %S HELP ACCESS) um Privilegien an andere
	Kanal Benutzer weiterzugeben.
	
	HINWEIS: Um einen Kanal zu registrieren, mußt Du zuerst
	Deinen Nick registrieren. Wenn Du das noch nicht getan
	hast, Tippe /msg %s HELP für weitere Informationen,
	wie man das macht.

CHAN_HELP_IDENTIFY
	Syntax: IDENTIFY channel password
	
	Autentifiziert Dich für %S als den Founder des
	angegebenen Kanals.  Viele Befehle lassen sich erst
	benutzen, nachdem Du diesen Befehl benutzt hast.  Daß
	Passwort muß dasselbe sein, wie das was Du mit dem
	REGISTER-Befehl geschickt hast.

CHAN_HELP_DROP
	Syntax: DROP channel
	
	Löscht den angegebenen Kanal.  Dieser Befehl kann nur von
	dem Kanal Founder benutzt werden, nachdem er den
	IDENTIFY Befehl benutzt hat.

CHAN_HELP_SET
	Syntax: SET channel option parameters
	
	Ermöglicht dem Kanal Founder, verschiedene Kanal
	Einstellungen und andere Informationen zu setzen.  Der
	Founder muß erst den IDENTIFY Befehl benutzen, bevor
	er SET benutzen kann.
	
	Verfügbare Einstellungen:
	
	 FOUNDER     Setzt den Founder eines Kanals
	 SUCCESSOR   Setzt den Nachfolger eines Kanals
	 PASSWORD    Setzt das Founder Passwort
	 DESC        Setzt die Kanal Beschreibung
	 URL         Setzt eine URL
	 EMAIL       Setzt eine Email Adresse
	 ENTRYMSG    Setzt eine Nachricht, die Benutzern
	             geschickt wird, wenn sie den Kanal betreten
	 TOPIC       ändert das Topic auf dem Kanal
	 KEEPTOPIC   Bewahrt das Topic, wenn ein Kanal nicht
	             benutzt wird
	 TOPICLOCK   Topic kann nur mit SET TOPIC geändert werden
	 MLOCK       Sperrung der Kanal Modi on oder off
	 PRIVATE     Unterdrücke die Anzeige des Kanals im LIST
	             Befehl
	 RESTRICTED  Beschränke den Zugang zum Kanal
	 SECUREOPS   Stärkere Kontrolle des Kanal Operator Status
	 LEAVEOPS    Nimmt niemals einen Op weg, außer mit dem
	             DEOP Befehl
	 OPNOTICE    Schicke eine Notiz, wenn der OP/DEOP Befehl
	             benutzt wird
	 NOLINKS     Ignoriert die Access-Listen Erkennung von 
		     gelinkten Nicks. 
	  
	Tippe /msg %S HELP SET option für weitere
	Information zu einer bestimmten Option.

CHAN_HELP_SET_FOUNDER
	Syntax: SET channel FOUNDER nick
	
	ändert den Founder des Kanals. Der neue Nick muß
	registriert sein.

CHAN_HELP_SET_SUCCESSOR
	Syntax: SET channel SUCCESSOR nick
	
	ändert den Nachfolger für einen Kanal.  Wenn der Nick des
	Founder abläuft, oder gelöscht wird, während der Kanal
	immer noch registriert ist, wird der Nachfolger der neue
	Founder des Kanals.  Wenn der Nachfolger allerdings
	bereits zu viele Kanäle registriert hat (%d), wird der
	Kanal stattdessen gelöscht, als ob kein Nachfolger
	eingetragen wurde.  Der neue Nick muß registriert sein.

CHAN_HELP_SET_PASSWORD
	Syntax: SET channel PASSWORD password
	
	ändert das Passwort, welches Dich als Founder des
	Kanals identifiziert.

CHAN_HELP_SET_DESC
	Syntax: SET channel DESC description
	
	Setzt die Beschreibung für den Kanal, wird angezeigt mit
	dem LIST und dem INFO Befehl.

CHAN_HELP_SET_URL
	Syntax: SET channel URL [url]
	
	Ordnet dem Kanal die URL zu. Die URL wird angezeigt, wenn
	jemand mit dem INFO Befehl Informationen über den
	Kanal abruft.  Ohne Parameter wird die aktuelle URL des
	Kanals gelöscht.

CHAN_HELP_SET_EMAIL
	Syntax: SET channel EMAIL [address]
	
	Ordnet dem Kanal die Email Adresse zu. Diese Adresse wird
	angezeigt, wenn jemand mit dem INFO Befehl
	Informationen über den Kanal abruft. Ohne Parameter wird
	die aktuelle Email Adresse des Kanals gelöscht.

CHAN_HELP_SET_ENTRYMSG
	Syntax: SET channel ENTRYMSG [message]
	
	Setzt eine Nachricht, die Benutzern, wenn sie den Kanal
	betreten per /notice geschickt wird.  Ohne Parameter,
	wird keine Nachricht beim Betreten des Kanals verschickt.

CHAN_HELP_SET_TOPIC
	Syntax: SET channel TOPIC topic
	
	Veranlaßt %S das Topic des Kanals zu setzen.
	Dieser Befehl ist am Sinn-vollsten in Verbindung mit
	SET TOPICLOCK.

CHAN_HELP_SET_KEEPTOPIC
	Syntax: SET channel KEEPTOPIC {ON | OFF}
	
	Aktiviert und deaktiviert die Topic Beibehaltung
	Einstellung für einen Kanal.  Wenn Topic Beibehaltung
	aktiviert ist, wird das Topic durch %S
	gespeichert, auch wenn der letzte Benutzer den Kanal
	verlassen hat, und wird wieder hergestellt, wenn der
	Kanal wieder geöffnet wird.

CHAN_HELP_SET_TOPICLOCK
	Syntax: SET channel TOPICLOCK {ON | OFF}
	
	Aktiviert und deaktiviert die Topic Sperre
	Einstellung für einen Kanal.  Wenn Topic Sperre
	aktiviert ist, verhindert %S die Änderung des
	Topic, außer durch den SET TOPIC Befehl.

CHAN_HELP_SET_MLOCK
	Syntax: SET channel MLOCK modes
	
	Setzt die Mode-Sperre Parameter für den Kanal.  Du kannst
	mit %S bestimmte Kanal Modi definieren, welche
	immer an (oder aus) sind.  Die Modi die so gesperrt
	werden können sind i, k, l, m, n,
	p, s, und t; jedes dieser Modi kann gesperrt,
	entsperrt, oder nicht gesperrt werden.  Die modes
	Parameter funktionieren genauso wie der /MODE Befehl;
	das bedeutet, Modi gefolgt von einem + sind gesperrt, und
	Modi gefolgt von einem - sind entsperrt.
	
	Warnung: Wenn Du einen Kanal-Schlüssel sperrst, wie
	in dem zweiten Beispiel unten, solltest Du außerdem die
	RESTRICTED Einstellung für den Kanal (siehe HELP
	SET RESTRICTED) setzen, oder jeder der den Kanal
	betritt, wenn er leer ist, kann den Schlüssel sehen!
	
	Beispiele:
	
	 SET #channel MLOCK +nt-iklps
	  Schaltet die Modi n und t ein, und die Modi i, k, l, p
	  und s aus.  Mode m ist weiterhin frei.
	
	 SET #channel MLOCK +knst-ilmp my-key
	  Schaltet die Modi k, n, s und t ein, und die Modi i, l,
	  m und p aus.  Setzt außerdem den Kanal-Schlüssel auf
	  "my-key".
	
	 SET #channel MLOCK +
	  Schaltet die Mode-sperre aus; alle Kanal Modi sind
	  freigegeben.

CHAN_HELP_SET_PRIVATE
	Syntax: SET channel PRIVATE {ON | OFF}
	
	Schaltet die PRIVATE Einstellung für einen Kanal ein
	oder aus.  Wenn PRIVATE gesetzt ist, wird der Kanal
	bei einem /msg %S LIST nicht angezeigt.

CHAN_HELP_SET_RESTRICTED
	Syntax: SET channel RESTRICTED {ON | OFF}
	
	Aktiviert oder Deaktiviert den eingeschränkten Zugang
	für einen Kanal.  Wenn eingeschränkter Zugang
	aktiviert ist, werden Benutzer die keinen Kanal Operator
	Status haben dürfen (Benutzer mit Negativer Zugangs-Stufe
	und, wenn sichere Ops gesetzt ist, Benutzer die
	nicht auf der Zugangs-Liste sind) aus dem Kanal gekickt
	und gebannt.

CHAN_HELP_SET_SECUREOPS
	Syntax: SET channel SECUREOPS {ON | OFF}
	
	Aktiviert oder Deaktiviert die sichere Ops
	Einstellung für einen Kanal. Wenn sichere Ops gesetzt
	ist, können Benutzer, die nicht auf der Zugangs-Liste
	sind, keine Kanal Op Status erlangen.

CHAN_HELP_SET_LEAVEOPS
	Syntax: SET channel LEAVEOPS {ON | OFF}
	
	Aktiviert oder Deaktiviert die Belasse Ops
	Einstellung für den Kanal.  Wenn Belasse Ops
	aktiviert ist, wird %S nie jemanden den Op Status
	entziehen, außer mit dem DEOP Befehl.

CHAN_HELP_SET_OPNOTICE
	Syntax: SET channel OPNOTICE {ON | OFF}
	
	Aktiviert oder Deaktiviert die Op-Notiz Einstellung
	für einen Kanal.  Wenn Op-Notiz aktiviert ist,
	schickt %S eine Notiz an den Kanal, wenn der
	OP oder DEOP Befehl für einen Benutzer auf dem
	Kanal benutzt wird.

CHAN_HELP_SET_NOLINKS
	Syntax: SET channel NOLINKS {ON | OFF}
	
	Aktiviert oder Deaktiviert die NOLINKS Einstellung
	für einen Kanal. Wenn NOLINKS aktiviert ist, erkennt
	%S nur die Nicks die auf der Zugangs Liste
	eingetragen sind, gelinkte Nicks werden nicht erkannt.

CHAN_HELP_ACCESS
	Syntax: ACCESS channel ADD nick level
	        ACCESS channel DEL {nick | entry-num | list | ALL }
	        ACCESS channel LIST [mask | list]
	
	Pflegt die Zugangs-Liste für einen Kanal.  Die
	Zugangs-Liste gibt an, welche Benutzer einen Kanal Op
	Status haben dürfen, und Zugang zu den %S Befehlen
	für den Kanal haben.  Verschiedene Benutzer-Stufen
	erlauben den Zugang zu verschiedenen Subsets der
	Privilegien; Tippe /msg %S HELP ACCESS LEVELS
	für weitere Informationen.  Jeder Nick der nicht auf der
	Liste ist, hat eine Benutzer-Stufe von 0.
	
	Der ACCESS ADD Befehl fügt der Zugangs-Liste den
	angegebenen Nick mit der angegebenen Zugangs-Stufe hinzu;
	wenn der Nick bereits auf der Liste existiert, wird die
	Zugangs-Stufe entsprechend geändert.  Der angegebene
	level muß geringer sein, als der level des
	Benutzers der den Befehl eingibt, und wenn der nick
	bereits auf der Zugangs-Liste ist, muß die aktuelle
	Zugangs-Stufe des Nicks geringer sein, als die
	Zugangs-Stufe des Benutzers der den Befehl eingibt.
	
	Der ACCESS DEL Befehl löscht den angegebenen Nick aus
	der Zugangs-Liste.  Wenn eine Liste der laufenden Nummern
	angegeben wird, werden die entsprechenden Einträge
	gelöscht.  (Siehe das Beispiel unten.) Mit ALL werden
	alle Einträge gelöscht, dieser Befehl ist nur für den
	Founder möglich.
	
	Der ACCESS LIST Befehl zeigt die Zugangs-Liste.  Wenn
	eine Maske angegeben wird, werden nur dir passenden
	Einträge ausgegeben.  Wenn eine Liste von laufenden
	Nummern angegeben wird, werden nur die entsprechenden
	Einträge ausgegeben; zum Beispiel:
	
	 ACCESS #channel LIST 2-5,7-9
	  Zeigt die Einträge 2 bis 5 und 7 bis 9 der
	  Zugangs-Liste.

CHAN_HELP_ACCESS_LEVELS
	Benutzer-Zugangs-Stufen
	
	Als Voreinstellung sind die folgenden
	Zugangs-Stufen definiert:
	
	 Founder  Voller Zugang zu den Funktionen des
	              %S; Automatisches Op geben beim
	              Betreten des Kanals.  Es kann nur eine
	              Person den Founder Status haben (Es kann
	              nicht mit dem ACCESS Befehl vergeben
	              werden).
	      10  Zugang zum AKICK Befehl; Automatisches Op
	              geben.
	       5  Automatisches Op geben.
	       3  Automatisches Rede-recht.
	       0  Keine speziellen Privilegien; Kann von
	              anderen Ops geopped werden (außer bei
	              gesetzten secure-ops).
	      <0  Darf nicht geoppt werden.
	
	Diese Stufen können mit dem LEVELS Befehl geändert
	werden, es können auch Neue hinzugefügt werden; Tippe
	/msg %S HELP LEVELS für weitere Informationen.

CHAN_HELP_AKICK
	Syntax: AKICK channel ADD mask [reason]
	        AKICK channel DEL [ mask | ALL ]
	        AKICK channel LIST [mask]
	
	Bearbeite die AutoKick Liste für einen Kanal.  Wenn
	ein Benutzer, der auf der AutoKick Liste ist, versucht
	den Kanal zu betreten, wird %S den Benutzer bannen
	und kicken.
	
	Der AKICK ADD Befehl fügt den gegebenen Nick oder die
	Benutzermaske zur AutoKickListe hinzu.  Wenn eine
	reason mit dem Befehl gesetzt wird, wird diese
	angegeben wenn ein Benutzer gekickt wird;
	wenn nicht ist der voreingestellte Grund "You have been
	banned from the channel".
	
	Der AKICK DEL Befehl löscht den gegebenen Nick oder
	die Benutzermaske aus der AutoKickListe.  Es löscht nicht
	die Bans die von einem AutoKick gesetzt wurden; diese
	müssen manuell entfernt werden.  Mit ALL werden alle
	AutoKick-Einträge gelöscht, dieser Befehl ist nur für den
	Founder möglich.
	
	Der AKICK LIST Befehl zeigt die AutoKick Liste, oder
	nur die Einträge die auf die gegebene Maske passen.

CHAN_HELP_LEVELS
	Syntax: LEVELS channel SET type level
	        LEVELS channel {DIS | DISABLE} type
	        LEVELS channel LIST
	        LEVELS channel RESET
	
	Der LEVELS Befehl ermöglicht die Kontrolle über die
	Bedeutung der numerischen Zugangsstufen der Kanäle.  Mit
	diesem Befehl kannst Du die Zugangsstufen definieren,
	die für die meissten %S Funktionen benötigt
	werden. (Die SET FOUNDER und SET PASSWORD
	Befehle und dieser Befehl sind immer nur für den Kanal
	Founder verfügbar.)
	
	LEVELS SET ermöglicht es die Zugangsstufe für eine
	Funktion oder eine Gruppe von Funktionen zu ändern.
	LEVELS DISABLE (oder kurz DIS) schaltet eine
	automatische Funktion ab oder unterbindet den Zugang
	zu einer Funktion für alle ausser den Kanal Founder.
	LEVELS LIST zeigt die aktuellen Stufen für jede
	Funktion und Gruppe von Funktionen. LEVELS RESET
	setzt die Zugangsstufen wieder auf die
	Voreinstellungen für einen neuen Kanal zurück
	(siehe HELP ACCESS LEVELS).
	
	Für eine Liste der Funktionen, für die Zugangsstufen
	gesetzt werden können, tippe HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	Die folgenden Funktionsnamen sind understood.  Beachte
	dass die Stufen für AUTODEOP und NOJOIN maximum Stufen
	sind, alle anderen sind Minimum Stufen.

CHAN_HELP_LEVELS_DESC_FORMAT
	 %-*s  %s

CHAN_HELP_INFO
	Syntax: INFO channel
	
	Gibt Informationen über den genannten registrierten
	Kanal, inklusive dem Founder, dem Zeitpunkt der
	Registrierung, der letzten Nutzung, Beschreibung und
	Modesperre, wenn vorhanden aus.

CHAN_HELP_LIST
	Syntax: LIST pattern
	
	Gibt alle registrierten Kanäle die auf die gegebene Maske
	passen, aus (Kanaäle mit der PRIVATE Einstellung
	werden nicht angezeigt)

CHAN_HELP_OP
	Syntax: OP #channel nick
	
	Oppt einen ausgewählten Nick auf einem Kanal.  Als
	Voreinstellung ist dieser Befehl auf Benutzer mit Stufe 5
	Zugang oder höher beschränkt.

CHAN_HELP_DEOP
	Syntax: DEOP #channel nick
	
	Deoppt einen ausgewählten Nick auf einem Kanal. Als
	Voreinstellung ist dieser Befehl auf Benutzer mit Stufe 5
	Zugang oder höher beschränkt.

CHAN_HELP_KICK
	Syntax: KICK #channel nick reason
	
	Kickt einen Benutzer mit %S aus einem Kanal.  Als
	Voreinstellung ist dieser Befehl auf Benutzer mit Stufe 5
	Zugang oder höher beschränkt.

CHAN_HELP_INVITE
	Syntax: INVITE channel
	
	Veranlasst %S Dich auf den angegebenen Kanal
	einzuladen.  Als Voreinstellung ist dieser Befehl auf
	Benutzer mit Stufe 1 Zugang oder höher beschränkt.

CHAN_HELP_UNBAN
	Syntax: UNBAN channel
	
	Veranlasst %S alle Bans zu löschen die verhindern,
	das Du auf den Kanal kannst.  Als Voreinstellung ist
	dieser Befehl auf Benutzer mit Stufe 1 Zugang oder
	höher beschränkt.

CHAN_HELP_CLEAR
	Syntax: CLEAR channel what
	
	Veranlasst %S die angegebene Einstellung auf einem
	Kanal zu löschen.  what kann eins der folgenden sein:
	
	 MODES   Setzt alle Modes auf einem Kanal zurück (das
	         heisst alle i,k,l,m,n,p,s,t-Modes werden
	         gelöscht).
	 BANS    Löscht alle Bans auf dem Kanal.
	 OPS     Deoppt alle Kanal Ops (mode +o)
	 VOICES  Löscht alle "voice" Modes (mode +v)
	 USERS   Kickt alle Benutzer aus dem Kanal.
	
	Als Voreinstellung ist dieser Befehl auf Benutzer mit
	Stufe 10 Zugang oder höher beschränkt.

CHAN_SERVADMIN_HELP
	
	Die folgenden Befehle sind für Service Admins verfügbar:
	
	 GETPASS  Gibt das Passwort des Founders aus (nur bei
	          abgeschalteter Kodierung)
	 FORBID   Verbietet die Nutzung des Kanals
	 STATUS   Gibt die aktuellen Zugangsstufe für einen
	          Benutzer des Kanals aus
	
	Service Admins können ausserdem jeden Kanal ohne Passwort
	Identifizierung löschen, oder sich die Zugangs-,
	AutoKick- und Einstellungslisten ansehen.

CHAN_SERVADMIN_HELP_DROP
	Syntax: DROP channel
	
	Löscht den genannten Kanal.  Nur Services admins
	können einen Kanal löschen, für den sie nicht
	angemeldet sind.

CHAN_SERVADMIN_HELP_SET
	
	Service Admins können die Einstellung NOEXPIRE
	setzen, welches verhindert das Kanäle ablaufen.
	Ausserdem können Service Admins Einstellungen für jeden
	Kanal setzen, ohne ein Passwort eingeben zu müssen.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET channel NOEXPIRE {ON | OFF}
	
	Gibt an, ob der Kanal abläuft.  Wenn auf ON gesetzt,
	läuft der Kanal nicht ab.
	
	Nur für Services admins.

CHAN_SERVADMIN_HELP_LIST
	Syntax: LIST pattern
	
	Zeigt alle registrierten Kanäle, welche auf den
	angegebenen Filter passen.  Kanäle, die die
	PRIVATE Einstellung gesetzt haben, werden nur
	Service Admins angezeigt.

CHAN_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS channel
	
	Zeigt das Passwort des Kanals.  Achtung Wenn dieser
	Befehl benutzt wird, wird eine Nachricht mit demjenigen
	der den Befehl eingeben hat und dem Kanal der abgefragt
	wurde geloggt und als WALLOPS/GLOBOPS verschickt.
	
	Nur für Service admins.

CHAN_SERVADMIN_HELP_FORBID
	Syntax: FORBID channel
	
	Verbietet die Registrierung und Nutzung des Kanals.  Kann
	mit dem DROP-Befehl gelöscht werden.
	
	Nur für Service admins.

CHAN_SERVADMIN_HELP_STATUS
	Syntax: STATUS channel nickname
	
	Gibt die aktuelle Zugangsstufe für den angegebenen Nick
	für den angegebenen Kanal aus.  Die Antwort erfolgt in
	der Form:
	
	 STATUS channel nickname access-level
	
	Wenn ein Fehler auftritt, erfolgt die Antwort in diesem
	Format:
	
	 STATUS ERROR error-message
	
	Nur für Service admins.

#################################################################
#
# MemoServ help messages
#
#################################################################

MEMO_HELP
	%S ermöglicht es IRC Benutzern kurze
	Nachrichten an andere IRC Benutzer oder Kanäle(*) zu
	schicken, egal ob diese gerade online sind, oder nicht.
	Sowohl der Nick des Absenders als auch der Nick des
	Empfängers oder der Kanalname müssen registriert sein um
	ein Memo zu versenden.
	
	%S's Befehle enthalten:
	
	 SEND  Schicke ein Memo an einen Nick oder Kanal
	 LIST  Zeige Deine Memos an
	 READ  Lies ein Memo oder mehrere Memos
	 DEL   Löscht ein Memo oder mehrere Memos
	 SET   Setzt Einstellungen zu den Memos
	
	Tippe /msg %S HELP command für Hilfe zu
	den obigen Befehlen.
	
	(*) Als Voreinstellung kann jeder Benutzer mit mindestens
	Zugangsstufe 10 eines Kanals die Kanal Memos lesen.
	Dieses kann mit dem %s LEVELS Befehl
	geändert werden.

MEMO_HELP_SEND
	Syntax: SEND {nick | channel} memo-text
	
	Schickt dem genannten nick oder Kanal ein Memo
	mit dem memo-text.  Wenn an einen Nick geschickt
	wird, erhält der Empfänger eine Notice das er ein neues
	Memo erhalten hat.  Der Ziel Nick muss registriert sein.

	Mit einem vorgestellten ? wirst Du benachrichtigt, wenn 
	das Memo gelesen wurde.

MEMO_HELP_LIST
	Syntax: LIST [channel] [list | NEW]
	
	Zeigt alle Memos die Du derzeit hast.  Mit NEW werden
	nur neue (ungelesene) Memos angezeigt.  Ungelesene Memos
	werden mit einem "*" gekennzeichnet.  Du kannst auch eine
	Liste von Nummern angeben, wie in dem Beispiel unten:
	
	 LIST 2-5,7-9
	  Zeige Memos Nr. 2 bis 5 und 7 bis 9.

MEMO_HELP_READ
	Syntax: READ [channel] {num | list | LAST | NEW}
	
	Schickt Dir den Text des angegebenen Memos.  Wenn LAST
	angegeben wird, wird das neueste Memo ausgegeben.  Wenn
	NEW angegeben wird, werden alle neuen Memos ausgegeben.
	Sonst gibt es das Memo Nummer num aus. Du kannst auch
	eine Liste von Nummern angeben, wie in diesem Beispiel:
	
	 READ 2-5,7-9
	  Zeigt Memo Nr. 2 bis 5 und 7 bis 9 an.

MEMO_HELP_DEL
	Syntax: DEL [channel] {num | list | ALL}
	
	Löscht das angegebenen Memo oder Memos.  Du kannst statt
	einer Nummer mehrere Memo Nummern angeben, oder Bereiche
	von Nummern, wie im zweiten beispiel unten.
	
	Mit ALL kannst Du alle Memos löschen.
	
	Beispiele:
	
	 DEL 1
	  Löscht das erste Memo.
	
	 DEL 2-5,7-9
	  Löscht Memo Nr. 2 bis 5 und 7 bis 9.

MEMO_HELP_SET
	Syntax: SET option parameters
	
	Setze verschiedene Einstellungen.
	option ist eins von:
	
	 NOTIFY  Ändert wann Du nach Empfang eines neuen Memos
	         benachrichtigst wirst. (nur für Nicks)
	 LIMIT   Setze die Memo-Obergrenze die Du empfangen
	         kannst.
	
	Tippe /msg %S HELP SET option für weitere
	Informationen über eine bestimmte Einstellung.

MEMO_HELP_SET_NOTIFY
	Syntax: SET NOTIFY {ON | LOGON | NEW | OFF}
	
	Ändert wann Du nach Empfang eines neuen Memos
	benachrichtigt wirst:
	
	 ON     Du wirst über Memos benachrichtigt, wenn Du Dich
	        anmeldest, wenn Du /away abschaltest und wenn
	        Dir Memos zugeschickt werden.
	 LOGON  Du wirst über Memos benachrichtigt, wenn Du Dich
	        anmeldest und wenn Du /away abschaltest.
	 NEW    Du wirst nur über Memos benachrichtigt, wenn Dir
	        Memos zugeschickt werden.
	 OFF    Du wirst nicht über Memos benachrichtigt.
	
	ON ist praktisch eine Kombination von LOGON und
	NEW

MEMO_HELP_SET_LIMIT
	Syntax: SET LIMIT [channel] limit
	
	Setzt die Memo-Obergrenze die Du (oder der angegebene
	Kanal) haben darf.  Wenn Du dieses auf 0 setzt, kann Dir
	niemand Memos schicken.  Du kannst diesen Wert nicht
	höher als %d setzen.

MEMO_HELP_INFO
	Syntax: INFO [channel]
	
	Zeigt Informationen über die Anzahl Deiner Memos, wieviel
	davon ungelesen sind, und wieviele Memos Du maximal
	empfangen kannst, an.  Mit einem Parameter werden diese
	Informationen für den angegebenen Kanal angezeigt.

MEMO_SERVADMIN_HELP_SET_LIMIT
	Syntax: SET LIMIT [user | channel] {limit | NONE} [HARD]
	
	Setzt die Memo-Obergrenze die eine Benutzer oder Kanal
	haben darf.  Wenn die Grenze auf 0 gesetzt wird, kann der
	Benutzer keine Memos mehr empfangen: wenn auf NONE
	gesetzt, kann der Benutzer unbegrenzt viele Memos haben.
	Ohne Angabe eines Nick oder Kanal, wird Deine eigene
	Grenze gesetzt.
	
	Mit der zusätzlichen Einstellung HARD wird verhindert
	das der Benutzer seine Grenze ändern kann.  Ohne HARD
	wird dem benutzer erlaubt die Grenze zu ändern. (auch
	wenn eine frühere Obergrenze mit HARD gesetzt wurde).
	
	Die Benutzung des SET LIMIT Befehls ist auf
	Service admins beschränkt.  Andere Benutzer
	können nur eine Obergrenze für sich selbst oder einen
	Kanal, für den sie dei entsprechenden Rechte haben
	müssen, ändern. Sie können Ihre Obergrenze nicht nicht
	löschen, sie können keine Obergrenze über %d setzen,
	und können kein wenn HARD gesetzt wurde, Ihre Grenze
	nicht ändern.

MEMO_SERVADMIN_HELP_INFO
	Syntax: INFO [nick | channel]
	
	Ohne einen Parameter werden Informationen über die Anzahl
	der Memos, wieviel davon ungelesen sind, und die maximale
	Anzahl der Memos angezeigt.
	
	Mit einem Kanal-Parameter, wird diese Information für den
	gegebenen Kanal angezeigt.
	
	Mit einem Nick, wird diese Information für den gegebenen
	Nick angezeigt.
	
	Dieser Befehl ist nur für Services admins.

#################################################################
#
# OperServ help messages
#
#################################################################

OPER_HELP
	%S Befehle:
	 GLOBAL      Schickt eine Nachricht an alle Benutzer
	 STATS       Zeigt den Status der Services und des
	             Netzwerks
	 OPER LIST   Zeigt alle Service Operators
	 ADMIN LIST  Zeigt alle Service Admins
	
	Commands available to Services operators and admins only:
	 MODE        Ändert einen Kanal Mode
	 KICK        Kickt einen Benutzer aus einem Kanal
	 AKILL       Manipuliert die AKILL Liste
	 VLINE       Manipuliert die VLINE Liste
	 BOT         Manipulatiert die BOT Liste.
	 SESSION     Sitzung Begrenzungs info
	
	Befehle die nur für Service Admins verfügbar sind:
	 SQLINE      Manipuliert die SQLINE Liste
	 OPER        Ändert die Service Operator Liste
	 LOGONNEWS   Definiert Nachrichten die Benutzern beim
	             Anmelden angezeigt werden
	 OPERNEWS    Definiert Nachrichten die Benutzern die
	             Oper werden angezeigt werden
	 JUPE        "Jupiter" einen Server
	 SET         Setzt verschiedene globale Service
	             Einstellungen
	 GETFOUNDER  Hole Kanal-Founder Zugangs-Privilegien.
	 UPDATE      Erzwingt eine Sofortaktualisierung der
	             Service Datenbank auf der Festplatte
	 QUIT        Beendet das Service Programm
	 RESTART     Speichert die Datenbank und startet die
	             Services neu
	 REHASH      Lädt die Konfigurationsdatei neu
	 SENDPASS    Schicke ein Nick Passwort per Email.
	
	Befehle die nur für den Service super-user
	verfügbar sind:
	 ADMIN       Ändert die Service Admin Liste
	 RAW         Schickt eine raw Zeichenkette an den
	             Server
	
	Achtung: alle Befehle die an den %S geschickt
	             werden, werden geloggt!

OPER_HELP_GLOBAL
	Syntax: GLOBAL message
	
	Ermöglicht es IRCops Nachrichten an alle Benutzer des
	Netzwerks zu schicken.  Die Nachricht wird von dem Nick
	%s gesendet.

OPER_HELP_STATS
	Syntax: STATS [RECORD | AKILL | ALL]
	
	Ohne Einstellung werden alle derzeitigen Benutzer
	und IRCops (ausser den Services), die höchste Zahl
	Benutzer seit die Services gestartet wurden, und
	die Zeit seitdem angezeigt.
	
	Mit der AKILL Einstellung, wird die derzeitige
	Grösse der AKILL list und die voreingestellte
	Ablaufzeit gezeigt.
	
	Die ALL Einstellung ist nur für Service Admins
	verfügbar, und zeigt den Speicherbedarf der Services an.
	Die Nutzung dieses Befehls kann die Services für einen
	kurzen Moment einfrieren, deshalb benutze diesen Befehl
	nicht so oft.

	Die BRECORD Einstellung zeigt Daten über Benutzer 
	insgesamt, Ops, Helfer, und Bot Zahlen.
	
	UPTIME kann als Synonym für STATS benutzt werden.

OPER_HELP_OPER
	Syntax: OPER ADD nick
	        OPER DEL nick
	        OPER LIST
	        OPER SUSPEND nick Tage
	
	Ermöglicht Service Admins der Service Operator Liste
	Nicks hinzuzufügen, zu sperren oder zu löschen.  Ein
	Benutzer dessen Nick auf der Service Operator Liste ist,
	und der sich dem %s identifiziert hat, kann die
	Service Operator Befehle benutzen.
	
	Jeder IRC Operator kann den OPER LIST Befehl
	benutzen. Alle anderen Formen des Befehls sind nur für
	Service Admins verfügbar.

OPER_HELP_ADMIN
	Syntax: ADMIN ADD nick
	        ADMIN DEL nick
	        ADMIN LIST
	
	Ermöglicht dem Service super-user der Service Admin Liste
	Nicks hinzuzufügen, oder zu löschen.  Ein Benutzer dessen
	Nick auf der Service Admin Liste ist, und der sich dem
	%s identifiziert hat, kann die Service Admin
	Befehle benutzen.
	
	Jeder IRC Operator kann den ADMIN LIST Befehl
	benutzen. Alle anderen Formen des Befehls sind nur für
	den Service root verfügbar.

OPER_HELP_MODE
	Syntax: MODE channel modes
	
	Ermöglicht es Service Operators Kanal Modes für jeden
	Kanal zu setzen.  Die Parameter sind dieselben wie für
	den standard /MODE Befehl.
	
	Nur für BService Operator.

OPER_HELP_CLEARMODES
	Syntax: CLEARMODES channel [ALL]
	
	Löscht alle Modes (i,k,l,m,n,p,s,t) und Bans eines
	Kanals.  Wenn ALL angegeben wird, werden auch alle
	Ops und Voices (+o und +v modes) zurückgesetzt.
	
	Nur für BService Operator.

OPER_HELP_KICK
	Syntax: KICK channel user reason
	
	Ermöglicht es IRCops einen Benutzer aus einem Kanal zu
	kicken.  Die Parameter sind dieselben wie für den
	standard /KICK Befehl.  Die kick-Nachricht wird den Nick
	des ausführenden IRCOps enthalten; zum Beispiel:
	
	*** SpamMan has been kicked off channel #my_channel by
	    %S (Alcan (Flood))
	
	Nur für BService Operator.

OPER_HELP_AKILL
	Syntax: AKILL ADD [+expiry] mask reason
	        AKILL DEL mask
	        AKILL LIST [mask]
	        AKILL VIEW [mask]
	
	Ermöglicht Service Operatorn die AKILL Liste zu
	bearbeiten.  Wenn ein Benutzer der auf eine AKILL Maske
	passt sich anmeldet, wird er von den Services gekillt
	und, auf unterstützten Servern Typen, wird ein Bann
	(K-Line) eingerichtet.
	
	AKILL ADD fügt die angegebene user@host Maske mit dem
	angegebenen Grund (welcher angegeben werrden muss) zu
	der AKILL Liste hinzu. AKILL DEL löscht die
	angegebene Maske aus der AKILL Liste, wenn sie dort
	vorhanden ist.  AKILL LIST zeigt alle aktuellen
	AKILLs; wenn die optionale Maske angegeben wird, werden
	nur die passenden AKILLs ausgegeben. AKILL VIEW ist
	eine ausführlichere Version von AKILL LIST, und zeigt
	an, wer den AKILL hinzugefügt hat, den Zeitpunkt als er
	eingerichtet wurde, wann er abläuft, und die user@host
	Maske und den Grund.
	
	Ausserdem kann eine Ablaufzeit mit dem AKILL ADD
	Befehl angegeben werden.  Die Ablaufzeit geht der
	user@host Maske voraus, und wird als ganze Zahl mit
	einem folgenden d (Tage), h (Stunden), oder
	m (Minuten) angegeben. Kombinationen (wie
	1h30m) sind nicht möglich.  Wenn eine Einheit
	nicht angegeben wird, wird von Tagen ausgegangen
	(also wird mit +30 die Ablaufzeit auf 30 Tage
	gesetzt). Um einen AKILL einzutragen der nicht
	abläuft, benutze +0. Wenn die angegebene
	Benutzermaske mit einem + beginnt muss eine
	Ablaufzeit angegeben werden, auch wenn es dieselbe
	ist wie die Voreinstellung.  Die aktuelle AKILL
	Ablaufzeit kann mit dem STATS AKILL Befehl
	abgerufen werden.
	
	Das reason Feld ist nur für IRC Operator
	gedacht, und wird dem Benutzer in der KILL
	Nachricht nicht angezeigt.
	
	Nur für Service Operator.

OPER_HELP_SET
	Syntax: SET option setting
	
	Setzt verschiedene globale Service Einstellungen.  Die
	Namen, die derzeit definiert sind, sind:
	 READONLY  Setzt den read-only oder read-write Modus
	 DEBUG      Aktiviert oder Deaktiviert den debug
	                Modus
	
	Nur für Service Admins.

OPER_HELP_SET_READONLY
	Syntax: SET READONLY {ON | OFF}
	
	Schaltet den read-only Modus an oder aus.  Im read-only
	Modus können normale Benutzer keine Service Daten (z.B.
	Kanal und Nick Zugangslisten usw) ändern.  IRCops mit
	ausreichenden Service Privilegien können die AKILL Liste
	ändern und Nicks und Kanäle löschen oder verbieten, aber
	alle Änderungen werden nicht gesichert bis der read-only
	Modus deaktiviert wird, bevor der Service beendet oder
	neu gestartet wird.
	
	Diese Einstellung ist equivalent der Kommandozeilenoption
	-readonly.

OPER_HELP_SET_DEBUG
	Syntax: SET DEBUG {ON | OFF | num}
	
	Schaltet den Debug Modus ein oder aus.  Im debug Modus
	werden alle Daten die an den Service oder von dem Service
	geschickt werden mit weiteren debugging Nachrichten in
	die Logdatei geschrieben.  Wen num angegeben wird,
	wird der Debug Modus mit der Stufe num aktiviert.
	
	Diese Einstellung ist equivalent der Kommandozeilenoption
	-debug.

OPER_HELP_JUPE
	Syntax: JUPE server [reason]
	
	Veranlasst die Services einen server zu "jupitern" -- das
	bedeutet, einen gefälschten Server zu simulieren, welcher
	den richtigen Server mit dem angegebenen Namen davon
	abhält sich zu verbinden.  Der jupe kann mit einem
	standard SQUIT gelöscht werden.  Wenn ein Grund
	angegeben wird, wird dieser im Server Informationsfeld
	eingetragen; sonst enthält dieses Feld den text
	"Jupitered by <nick>", mit dem Nick des Benutzers der den
	Befehl eingegeben hat.
	
	Nur für Service Admins

OPER_HELP_RAW
	Syntax: RAW text
	
	Schickt eine Zeichenkette direkt zu dem Server an den die
	Services konnektiert sind.  Der Befehl hat einen sehr
	eingeschränkten Nutzen, und kann große Probleme in einem
	Netzwerk auslösen, wenn er unsachgemäß eingesetzt wird.
	BENUTZE DIESEN BEFEHL NICHT solange Du nicht weißt
	was Du tust!
	
	Nur für Service Admins.

OPER_HELP_UPDATE
	Syntax: UPDATE
	
	Läßt die Services alle Datenbank-Dateien aktualisieren.
	
	Nur für Service Admins.

OPER_HELP_QUIT
	Syntax: QUIT
	
	Beendet sofort die Services; Datenbanken werden
	nicht gesichert.  Dieser Befehl sollte nicht
	benutzt werden, außer wenn Beschädigungen an den
	Datenbanken im Speicher befürchtet werden, und
	diese nicht abgespeichert werden sollen.
	Für normales Beenden, benutze den SHUTDOWN Befehl.
	
	Nur für Service Admins.

OPER_HELP_SHUTDOWN
	Syntax: SHUTDOWN
	
	Speichert die Datenbanken und beendet die Services.
	
	Nur für Service Admins.

OPER_HELP_RESTART
	Syntax: RESTART
	
	Speichert die Datenbanken und startet die Services neu.
	(das heißt beenden und sofortiges neu starten der
	ausführbaren Datei).
	
	Nur für Service Admins.

OPER_HELP_REHASH
	Syntax: REHASH
	
	Lädt die services.conf neu.  ACHTUNG:
	Text-Parameter werden nicht geändert um die
	Integrität des Services zu erhalten.
	
	Nur für Service Admins.

OPER_REHASH_DONE
	Service Konfiguration ist neu gelesen.

OPER_REHASH_ERROR
	Ein Fehler trat beim Laden der Konfiguration auf.

CHAN_LEVEL_PROTECT
	Schätzt einen Benutzer vor De-Op oder Kick aus
	einem Kanal.

NICK_AUTORECON
	Zugangs-Listen-Erkennung.

NICK_HELP_SET_AUTOJOIN
	Syntax: SET AUTOJOIN {ON | OFF}
	
	Aktiviert oder Deaktiviert Auto-Join auf Kanälen.  Wenn
	aktiviert, Läßt Dich %S die Kanäle betreten die
	auf Deiner AJOIN LIST gefunden werden.

NICK_SET_AUTOJOIN_ON
	Auto-Join ist nun On

NICK_SET_AUTOJOIN_OFF
	Auto-Join ist nun Off

NICK_SET_AUTOJOIN_SYNTAX
	Syntax: SET AUTOJOIN {ON | OFF}

NICK_HELP_AJOIN
	Syntax: AJOIN { ADD | DEL | LIST } [#channel]
	
	ändert oder zeigt die Auto Join Liste für Deinen
	Nick. Dies ist die Liste der Kanäle die Du nach
	der Identifizierung betrittst, wenn AUTOJOIN
	eingeschaltet ist.
	
	Benutze /msg %S AJOIN NOW wenn Du alle Kanäle
	Deiner Auto Join Liste betreten willst.

NICK_AJOIN_LIST_X
	Auto Join Liste für %s:

NICK_AJOIN_SYNTAX
	Syntax: AJOIN { ADD | DEL | LIST } [#channel]

NICK_AJOIN_REACHED_LIMIT
	Sorry, aber Du kannst maximal %d Kanäle eintragen.

NICK_AJOIN_ALREADY_PRESENT
	Kanal ist bereits auf der Liste.

NICK_AJOIN_ADDED
	Kanal %s wurde der Liste hinzugefügt.

NICK_AJOIN_NOT_FOUND
	Kanal %s wurde auf Deiner Liste
	nicht gefunden.

NICK_AJOIN_DELETED
	Kanal %s wurde von Deiner Liste gelöscht.

NICK_AJOIN_LIST
	Auto Join Liste:

NICK_INFO_OPT_AUTOJOIN
	Auto Join

BAD_CHAN_NAME
	Kanal muß in der Form #Kanal sein.

OPER_IDENTIFY_REQUIRED
	
	Die Sicherheit-Regeln beschränken Oper auf identifizierte
	und bei OperServ registrierte Nicks.  Bitte kontaktiere
	Deinen IRC Admin für weitere Informationen.

NICK_ALREADY_IDENTIFIED
	Dieser Nick ist bereits identifiziert.
TODAYSTATS
	Statistik für heute (%s):
STATS_TOTAL
	     Gesamt: %d
STATS_REGISTERED
	Registriert: %d
STATS_DROPPED
	   Gelöscht: %d
STATS_EXPIRED
	 Abgelaufen: %d
STATS_BALANCE
	    Balance: %s
OPER_HELP_BOTLIST
	Syntax:
	     BOT ADD hostname maxcon reason
	     BOT DEL  hostname
	     BOT LIST [mask]
	     BOT VIEW [mask]
	
	Ermöglicht es Service Operatoren die BOT Liste zu
	ändern. Wenn ein Benutzer den Clone-Schutz auslöst, aber
	der Host-Name in der BOT ist, wird er nicht gekillt.
OPER_TOO_MANY_BOTLIST
	Sorry, BOT Liste ist voll.
OPER_BOTLIST_NO_NICK
	Du kannst keine Nicks auf der BOT Liste benutzen.
OPER_BOTLIST_ADDED
	Neuer BOT Listen Eintrag für %s hinzugefügt.
OPER_BOTLIST_ADD_SYNTAX
	BOT ADD hostname maxcon reason
OPER_BOTLIST_DEL_SYNTAX
	BOT DEL hostname reason
BOTLIST_REMOVED
	Eintrag %s aus der BOT Liste gelöscht.
OPER_BOTLIST_NOT_FOUND
	Host-Name %s wurde nicht auf der
	BOT Liste gefunden.
OPER_BOTLIST_HEADER
	Aktuelle Bot-Liste:
# mask, reason	
OPER_BOTLIST_FORMAT
	%-32s %d : %s
#mask, set-by, set-time, reason
OPER_BOTLIST_VIEW_FORMAT
	%s (von %s am %s)
	   %s
OPER_BOTLIST_SYNTAX
	BOT {ADD | DEL | LIST | VIEW} hostname [maxcon reason]
CHAN_INFO_SUCCESSOR
	        Nachfolger: %s (%s)
CHAN_INFO_NO_SUCCESSOR
	        Nachfolger: %s
NICK_SHOULD_REGISTER
	Dieser Nick ist nicht registriert, wenn Du ihn in der
	Zukunft benutzen willst, solltest Du ihn mit
	/msg %s REGISTER password email registrieren.
	Wenn Du keine Mail-Adresse hast, trage NOMAIL ein.
CHANGE_IN_1_MINUTE
	Wenn Du den Nick nicht innerhalb einer Minute änderst,
	wird er automatisch geändert.
NICK_AJOIN_EMPTY
	Auto-Join Liste ist leer
FEATURE_DISABLED
	Funktion auf diesem Server nicht verfügbar
CHAN_ACCESS_LIST_FORMAT2
	  %3d  %4d  %s%s%s%s von %s
NICK_AUTORECON_R
	Automatische Nick-Erkennung in +r Modus.
NICK_STATUS_0
	STATUS für %s : 0 - Benutzer nicht da, oder Nick
	nicht registriert
NICK_STATUS_1
	STATUS für %s : 1 - Benutzer nicht als
	Nick-Eigentümer erkannt
NICK_STATUS_2
	STATUS für %s : 2 - Benutzer als Nick-Eigentümer
	durch die Zugangs-Liste erkannt
NICK_STATUS_3
	STATUS für %s : 3 - Benutzer als Nick-Eigentümer
	durch Passwort Identifikation erkannt
OPER_HELP_SQLINE
	Syntax: SQLINE ADD nick reason
	        SQLINE DEL  nick
	        SQLINE LIST [mask]
	        SQLINE VIEW [mask]
	
	Ermöglicht es Service Operators die SQLINE Liste zu
	ändern.  Ein geSQLINEter Nick kann nicht benutzt werden.
OPER_TOO_MANY_SQLINE
	Sorry, SQLINE Liste ist voll.
OPER_SQLINE_JUST_NICK
	Du kannst nur Nicks/Masken in der SQLINE Liste benutzen.
OPER_SQLINE_ADDED
	Neue SQLINE für %s hinzugefügt.
OPER_SQLINE_ADD_SYNTAX
	SQLINE ADD nick reason
OPER_SQLINE_DEL_SYNTAX
	SQLINE DEL nick reason
OPER_SQLINE_REMOVED
	SQLINE %s gelöscht aus der sqline Liste gelöscht.
OPER_SQLINE_NOT_FOUND
	SQLINE für %s wurde nicht gefunden.
OPER_SQLINE_HEADER
	Aktuelle SQLINE Liste:
# mask, reason	
OPER_SQLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_SQLINE_VIEW_FORMAT
	%s (von %s am %s)
	   %s
OPER_SQLINE_SYNTAX
	SQLINE {ADD | DEL | LIST | VIEW} nick [reason]
BAD_EMAIL_ADDRESS
	Falsche Email Adresse!
	Bitte Benutzer user@mailserver oder NOMAIL.
BAD_ICQNUMBER
	Falsche ICQ Nummer!
	Bitte gib #icqnummer ein.
BAD_LOCATION
	Kein Standort!
	Bitte gib einen kürzeren Standort ein.
CHAN_DROP_AT
	Der Kanal wird in %d Tagen gelöscht.
CHAN_DROP_CANCEL
	Die Löschung für Kanal %s wurde zurückgezogen.
NICK_DROP_AT
	Der Nick wird in %d Tagen gelöscht.
NICK_DROP_CANCEL
	Die Löschung des Nicks %s wurde zurückgezogen.
OPER_STATS_USERS_RECORD
	Benutzer Rekord war %d am %s
	Derzeit sind es %d Benutzer (%d%)
	-
OPER_STATS_OPERS_RECORD
	Oper Rekord war %d am %s
	Derzeit sind es %d Oper (%d%)
	-
OPER_STATS_HELPERS_RECORD
	Helfer Rekord war %d am %s
	Derzeit sind es %d Helfer (%d%)
	-
OPER_STATS_BOTS_RECORD
	Bot Rekord war %d am %s
	Derzeit sind es %d Bots (%d%)
	-
NEWSS_HELP
	%S bietet die die Möglichkeit Online News nach
	Bestellung zu lesen.
	
	Es gibt verschiedene Befehle die Du mit
	/msg %S command benutzen kannst.  Für
	weitere Informationen zu einem speziellen Befehl, tippe
	/msg %S HELP command.
	
	 LIST         Liste der verfügbaren Subjekts und
	              Abonnierungen
	 SUBSCRIBE    Abonniere ein Subjekt
	 UNSUBSCRIBE  Bestelle ein Subjekt ab
	 SET          Setze Einstellungen.
	 RECENT       Zeige die neuesten News
NEWSS_HELP_OPER
	
	News Operator Befehle:
	 SEND        Schickt eine News Nachricht
	 VIEW        Zeigt aktuelle Liste mit detaillierten
	             Informationen
	 DEL         Löscht einen Eintrag der aktuell
	             gelieferten News
	 OPER LIST   Zeigt News Operators
	 ADMIN LIST  Zeigt News Admins
NEWSS_HELP_ADMIN
	
	News Administrator Befehle:
	 SUBJECT  ändert Subjekt Liste
	 OPER     Fügt News Operators hinzu oder löscht Sie
NEWSS_HELP_SADMIN
	Service Administrator Befehl:
	 ADMIN  Fügt News Admins hinzu oder löscht sie
NEWSS_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [nick]
NEWSS_OPER_ADD_SYNTAX
	OPER ADD nick
NEWSS_OPER_DEL_SYNTAX
	OPER DEL nick
NEWSS_OPER_SKELETON
	Services sind im Skeleton Modus; der OPER Befehl ist
	nicht verfügbar.
NEWSS_OPER_EXISTS
	%s ist bereits auf der News Operator Liste.
NEWSS_OPER_ADDED
	%s wurde der News Operator Liste hinzugefügt.
NEWSS_OPER_TOO_MANY
	Zu viele Einträge (%d) auf der News Operator Liste;
	kann keine Neuen hinzufügen.
NEWSS_OPER_REMOVED
	%s wurde aus der News Operator Liste gelöscht.
NEWSS_OPER_NOT_FOUND
	%s wurde auf der News Operator Liste
	nicht gefunden.
NEWSS_OPER_LIST_HEADER
	News Operator Liste:
	
NEWSS_OPER_HELP
	Syntax: OPER ADD nick
	        OPER DEL nick
	        OPER LIST
	
	Ermöglicht es News Admins Nicks der News Operator
	Liste hinzuzufügen oder zu löschen.  Ein Benutzer
	dessen Nick auf der News Operator Liste ist und der
	sich %s identifiziert hat, hat Zugriff auf die
	News Operator Befehle.
	
	Jeder News Operator kann den OPER LIST Befehl
	benutzen, alle anderen Formen des Befehls sind nur für
	News Admins verfügbar.

# News Server ADMIN responses
NEWSS_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [nick]
NEWSS_ADMIN_ADD_SYNTAX
	ADMIN ADD nick
NEWSS_ADMIN_DEL_SYNTAX
	ADMIN DEL nick
NEWSS_ADMIN_SKELETON
	Services sind im Skeleton Modus; der ADMIN Befehl ist
	nicht verfügbar.
NEWSS_ADMIN_EXISTS
	%s ist bereits auf der News Admin Liste.
NEWSS_ADMIN_ADDED
	%s wurde der News Admin Liste hinzugefügt.
NEWSS_ADMIN_TOO_MANY
	Zu viele Einträge (%d) auf der News Admin Liste; kann
	keine Neuen hinzufügen.
NEWSS_ADMIN_REMOVED
	%s wurde aus der News Admin Liste gelöscht.
NEWSS_ADMIN_NOT_FOUND
	%s wurde auf der News Admin Liste
	nicht gefunden.
NEWSS_ADMIN_LIST_HEADER
	News Admin Liste:
	
NEWSS_SUBJECT_HELP
	Syntax: SUBJECT number subject
	
	Ermöglicht die Änderung/Anlegung einen Subjekt Eintrag
	auf der %S Subjekt Liste.
	
NEWSS_SUBJECT_SYNTAX
	SUBJECT number subject
NEWSS_SUBJECT_ERROR
	Nummer muß zwischen 1 und %d liegen.
NEWSS_LIST_HELP
	Der LIST Befehl gibt eine Liste der verfügbaren
	Subjekts aus und ob sie eines bestellt haben oder nicht.
	Die mit X markierten Subjekt sind bestellt. Um zu
	bestellen/abzubestellen benutze die SUBCRIBE
	UNSUBSCRIBE Befehle.

NEWSS_LIST_HEADER
	Nr Subs Subjekt
	
NEWSS_LIST
	%2d  %c   %s
NEWSS_LIST_END
	Ende der Subjekt Liste
NEWSS_SUBJECT_NOTFOUND
	Das Subjekt Nummer %d existiert nicht!
NEWSS_SUBJECT_CHANGED
	Subjekt geändert von %s zu %s.
NEWSS_SUBJECT_CREATED
	Subjekt %s erstellt.
NEWSS_SUBSCRIBE_SYNTAX
	SUBSCRIBE  number [,number] | ALL
NEWSS_SUBSCRIBE_HELP
	Syntax: SUBSCRIBE  number [,number] | ALL
	
	Dieser Befehl ermöglicht es Dir ein Subjekt zu bestellen.
	Du kannst mehrere Subjekts mit einem Befehl bestellen,
	indem Du die Nummern mit Kommata trennst.
NEWSS_SUBSCRIBE_SUBSCRIBED
	Du hast %d Subjekts bestellt.
NEWSS_UNSUBSCRIBE_SYNTAX
	UNSUBSCRIBE  number [,number] | ALL
NEWSS_UNSUBSCRIBE_HELP
	Syntax: UNSUBSCRIBE number [,number] | ALL
	
	Dieser Befehl ermöglicht es Dir ein Subjekt
	abzubestellen.  Du kannst mehrere Subjekts mit
	einem Befehl abbestellen, indem Du die Nummern
	mit Kommata trennst.
NEWSS_UNSUBSCRIBE_UNSUBSCRIBED
	Du hast %d Subjekts abbestellt.
NEWSS_SEND_SYNTAX
	SEND number news message
NEWSS_SEND_HELP
	Syntax: SEND  number news message
	
	Ermöglicht es News Opers/Admins News Nachrichten
	zu verschicken.
NEWSS_SEND_SENT
	News ist verschickt.
NEWSS_SET_SYNTAX
	SET option parameters
NEWSS_SET_HELP
	Syntax: SET option parameters
	
	Setzt verschiedene %S Einstellungen. option
	kann eins von:
	 NOTICE  Setzt News Empfang Modus Notice/Message.
NEWSS_SET_NOTICE_SYNTAX
	SET NOTICE [ON | OFF]
NEWSS_SET_NOTICE_HELP
	Syntax: SET NOTICE [ON | OFF]
	
	Wenn notice aktiviert ist, wirst Du News über notices
	empfangen, wenn es aus ist über Private Messages.
NEWSS_SET_NOTICE_ON
	NOTICE Einstellung ist nun ON
NEWSS_SET_NOTICE_OFF
	NOTICE Einstellung ist nun OFF
NEWSS_RECENT_HELP
	Syntax: RECENT
	
	Zeige die neuesten News.
NEWSS_RECENT_HEADER
	Neueste News Liste
NEWSS_RECENT_LIST
	%s : %s
NEWSS_RECENT_END
	Ende der Neueste News Liste.
NEWSS_VIEW_HELP
	Syntax: VIEW
	
	Zeige die neuesten News mit detailliertem Informationen,
	Subjekt 0 steht für gelöschte Beitrage.
NEWSS_VIEW_HEADER
	Nr. : Sub. : Zeit : News (Sender)
NEWSS_VIEW_LIST
	%s%2d : %2d : %s : %s (%s)%s
NEWSS_DEL_SYNTAX
	DEL number
NEWSS_DEL_HELP
	Syntax: DEL number
	
	Dieser Befehl löscht einen Eintrag von der aktuellen News
	Liste. number ist die Nummer der News von der ersten
	Spalte von /msg %S VIEW. Der gelöschte Eintrag
	wird nicht auf der /msg %S RECENT Liste
	angezeigt, aber wird auf der /msg %S VIEW
	Liste als gelöscht angezeigt.
NEWSS_DEL_NOTEXIST
	News Nummer %d existiert nicht.
NEWSS_DEL_DELETED
	News Nummer %d wurde gelöscht.
NICK_INFO_PRIVATE
	Nick Information für %s ist privat.
CHAN_INFO_PRIVATE
	Kanal Information für %s ist privat.
CHAN_NEED_REGNICK
	Du mußt einen registrierten Nick haben, um diesen Kanal
	zu betreten!
CHAN_MODE_PROTECTED
	Dieser Kanal benutzt den Join Schutz Modus.
NEWS_REC_PLEASE_WAIT
	Bitte warte %d Sekunden bevor Du den RECENT Befehl
	erneut benutzt.
NICK_HELP_NOTES
	Ermöglicht es einem Benutzer Text Notizen zu speichern.
	Benutze /msg %S NOTES ADD text um eine
	Notiz zu speichern,
	/msg %S NOTES DEL number um eine Notiz zu
	löschen und /msg %S NOTES LIST um alle
	gespeicherten Notizen zu zeigen.
NICK_NOTES_SYNTAX
	LIST | ADD text | DEL number
NICK_NOTES_ADDED
	Notiz wurde munter der Nummer %d gespeichert.
NICK_NOTES_NOADD
	Du hast die maximale Anzahl (%d) von Notizen
	empfangen, die Deinem Nick gestattet sind, bitte
	lösche einige alte Notizen bevor Du versuchst eine
	Neue hinzuzufügen.
NICK_NOTES_DELETED
	Notiz Nummer %d wurde gelöscht.
NICK_NOTES_NOTFOUND
	Notiz Nummer %d wurde nicht gefunden.
NICK_NOTES_LIST_HEADER
	Keine Notiz
NICK_NOTES_LIST
	%2d %s
NICK_NOTES_NONOTES
	Notiz Liste ist leer.
CHAN_ACCESS_CLEARALL
	Zugangs-Liste ist nun leer.
CHAN_AKICK_CLEARALL
	AKICK Liste ist nun leer.
NICK_STATUS_SYNTAX
	STATUS nick
NICK_X_ISFOUNDER
	Nick %s ist der Founder und kann nicht
	gleichzeitig der Nachfolger sein.
NICK_X_ISSUCCESSOR
	Nick %s ist Kanal Nachfolger und kann nicht
	gleichzeitig der Founder sein.

# SESSION responses
OPER_SESSION_SYNTAX
	SESSION {LIST limit | VIEW hostname | TRACE hostname }
OPER_SESSION_LIST_SYNTAX
	SESSION LIST limit
OPER_SESSION_VIEW_SYNTAX
	SESSION VIEW host
OPER_SESSION_DISABLED
	Sitzung-Beschränkung ist abgeschaltet.
OPER_SESSION_INVALID_THRESHOLD
	Ungültiger threshold Wert. Es muß eine gültige ganze
	Zahl größerer als 1 sein.
OPER_SESSION_NOT_FOUND
	%s nicht in der Sitzung-Liste gefunden.
OPER_SESSION_LIST_HEADER
	Hosts mit mindestens %d Sitzungen:
OPER_SESSION_LIST_COLHEAD
	Sitzung   Host
# limit, host
OPER_SESSION_LIST_FORMAT
	%6d    %s
# host, sessions, limit
OPER_SESSION_VIEW_FORMAT
	Der Host %s hat derzeit %d Sitzungen
	mit einer Obergrenze von %d.
OPER_SESSION_EXCEEDED
	Netzwerk Sicherheit lehnt weitere Verbindungen von Deinem
	Host ab.
OPER_HELP_SESSION
	Syntax: SESSION LIST threshold
	        SESSION VIEW host
	        SESSION TRACE host
	
	Ermöglicht Service Operators Du Sitzung-Liste anzusehen.
	
	SESSION LIST zeigt Hosts mit mindestens threshold
	Sitzungen.  Der threshold muß eine Zahl größerer 1 sein.
	Dieses verhindert das versehentlich eine große Anzahl von
	Hosts mit einer Sitzung angezeigt wird.
	
	SESSION VIEW zeigt detaillierte Informationen über
	einen bestimmten Host - inklusive der Anzahl der
	aktuellen Sitzungen und die Sitzung-Obergrenze. Die
	host Einstellung darf keine Masken enthalten.
	
	SESSION TRACE zeigt die Liste der Benutzer die über
	den Host konnektiert sind. Die host Einstellung darf
	keine Masken enthalten.
OPER_HELP_VLINE
	Syntax: VLINE ADD file reason
	        VLINE DEL  file
	        VLINE LIST [pattern]
	        VLINE VIEW [pattern]
	
	Ermöglicht Service Operators die Änderung der VLINE
	Liste. V-Lined Datei Masken verhindern DCC SENDs und
	setzen den Absender auf +v sodaß sie keine weiteren
	SENDs schicken können.
OPER_TOO_MANY_VLINE
	Sorry, VLINE Liste ist voll.
OPER_VLINE_JUST_NICK
	Du kannst nur Dateien/Masken auf der
	VLIST Liste benutzen.
OPER_VLINE_ADDED
	Neue VLINE hinzugefügt für %s
OPER_VLINE_ADD_SYNTAX
	VLINE ADD file reason
OPER_VLINE_DEL_SYNTAX
	VLINE DEL file reason
OPER_VLINE_REMOVED
	VLINE %s von der V-Line Liste gelöscht
OPER_VLINE_NOT_FOUND
	VLINE %s nicht auf der Liste gefunden.
OPER_VLINE_HEADER
	Aktuelle VLINE Liste:
# mask, reason	
OPER_VLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_VLINE_VIEW_FORMAT
	%s (von %s am %s)
	   %s
OPER_VLINE_SYNTAX
	VLINE {ADD | DEL | LIST | VIEW} nick [reason]
OPER_SESSION_TRACE_SYNTAX
	TRACE host
OPER_SESSION_TRACE_BEGIN
	Liste die Sitzungen für %s:
OPER_SESSION_TRACE_FORMAT
	    %s
OPER_SESSION_TRACE_END
	Ende der Sitzung-Liste
AGO_TIME_D
	vor %d Tag(en), %d Stunde(n), %d Minute(n) und %d Sekunde(n).
AGO_TIME
	vor %d Tag(en), %d Minute(n) und %d Sekunde(n).
TOTAL_TIME
	%d Tag(e), %d Stunde(n), %d Minute(n) und %d Sekunde(n).
OPER_OPER_SUSPENDED
	Oper %s ist nun für %d Tage gesperrt.
OPER_OPER_UNSUSPEND
	Oper Sperrung für %s wurde gelöscht.
OPER_OPER_SUSPEND_SYNTAX
	OPER SUSPEND nick Tage
CHAN_HELP_AOP
	Alias für die AUTOOP Zugangsliste.
	AOP ADD fügt den Nick mit AUTOOP level zu der Kanal
	Zugangsliste hinzu.
	AOP LIST zeigt alle Kanal Zugangseinträge mit
	AUTOOP level an.
CHAN_AOP_SYNTAX
	AOP ADD nick | DEL nick | LIST
CHAN_HELP_SOP
	Alias für das ACC-CHANGE Zugangslistenmanagement.
	SOP ADD fügt den Nick mit ACC-CHANGE level zu der Kanal
	Zugangsliste hinzu.
	SOP LIST zeigt alle Kanal Zugangseinträge mit
	ACC-CHANGE level an.
CHAN_SOP_SYNTAX
	SOP ADD nick | DEL nick | LIST
CHAN_AJOIN_ADD
	Du solltest Deiner ajoin Liste den Kanal mit
	/msg %s AJOIN ADD %s hinzufügen.

# SENDPASS responses
OPER_SENDPASS_SYNTAX
	SENDPASS ^_nickname^_
OPER_SENDPASS_NOSENDMAIL
	SENDPASS Befehl ist nicht verfügbar, weil sendmail nicht
	gefunden wurde.
OPER_SENDPASS_UNAVAILABLE
	SENDPASS Befehl ist nicht verfügbar, weil Kodierung
	aktiviert ist.
OPER_SENDPASS_NOMAIL
	Nick %s hat keine Email-Adresse angegeben.
OPER_SENDPASS_SUBJECT
	Nickname passwort (%s)
OPER_SENDPASS_HEAD
	Hallo,
OPER_SENDPASS_LINE_1
	Du hast das Passwort von Nick %s per Email angefordert.
OPER_SENDPASS_LINE_2
	Das Passwort ist '%s'. Aus Sicherheitsgruenden solltest
	Du es so bald wie möglich ändern.
OPER_SENDPASS_LINE_3
	Wenn Du nicht weisst warum Du diese Mail bekommen hast,
	dann ignoriere sie bitte.
OPER_SENDPASS_LINE_4
	Bitte antworte nicht auf diese eMail!
OPER_SENDPASS_LINE_5
	PTlink Services - http://www.ptlink.net
OPER_SENDPASS_OK
	Passwort von %s wurde verschickt.
MAIL_LATER
	Kann derzeit keine Mail verschicken; Bitte probier es
	später noch einmal.
MAIL_DELAYED
	Bitte warte %d Sekunden und versuche es dann 
	noch einmal.
OPER_HELP_SENDPASS
	Syntax: SENDPASS nickname
	
	Schicke das Passwort des angegebenen Nicks an die
	Email-Adresse die dem Nick zugeordnet ist. Dieser
	Befehl ist nützlich um Benutzern das vergessene
	Passwort mitzuteilen.
	
	Kann in bestimmten Netzen auf IRC Operaters
	begrenzt sein.
	
	Dieser Befehl ist nicht verfügbar, wenn Kodierung
	aktiviert ist.
CHAN_RESTRICT_REGISTER
	Kanalregistrierung ist in diesem Netz nur für Services
	Operators möglich!
OPER_GETFOUNDER_SYNTAX
	GETFOUNDER #channel
MEMO_WILL_EXPIRE
	Dein Memo %s werden bald ablaufen.
MEMO_HAVE_EXPIRED
	Dein Memo %s ist abgelaufen.
UPDATE_IN_PROGRESS
	Aktualisierung, gestartet von %s, laeuft.
UPDATE_DONE
	Aktualisierung in %d Sekunde(n) durchgefuehrt.
CHAN_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE]
