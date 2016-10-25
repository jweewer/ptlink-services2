#
# Services is copyright (c) 1996-1999 Andy Church.
#     E-mail: <achurch@dragonfire.net>
# This program is free but copyrighted software; see the file COPYING for
# details.
# $Id:

# NOTE FOR DUTCH PEOPLE: Het is mogelijk dat er fouten inzitten,als u een 
# fout ontdekt, kan dit gewoon gemeld worden op irc.ptlink.net, kanaal #ptc
# en zoek hier naar de naam ^Stinger^. Dan kan ik dit zo spoedig mogelijk 
# wijzigen, of laat gewoon even een memo achter (: of mail het naar:
# ptlink@chello.nl
# Tnx goes out to mendelsson, ik en me stomme fouten af en toe, en misschien 
# nog steeds (:

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
	Nederlands (Dutch)

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
	Zo
	Ma
	Di
	Wo
	Do
	Vr
	Za
# %A
STRFTIME_DAYS_LONG
	Zondag
	Maandag
	Dinsdag
	Woensdag
	Donderdag
	Vrijdag
	Zaterdag
# %b
STRFTIME_MONTHS_SHORT
	Jan
	Feb
	Mrt
	Apr
	Mei
	Jun
	Jul
	Aug
	Sep
	Okt
	Nov
	Dec
# %B
STRFTIME_MONTHS_LONG
	Januari
	Februari
	Maart
	April
	May
	Juni
	Juli
	Augustus
	September
	October
	November
	December


# This is used in ChanServ/NickServ INFO displays.
COMMA_SPACE
	, 


# Various error messages.
USER_RECORD_NOT_FOUND
	Interne Fout - Opdracht kan niet worden uitgevoerd.
UNKNOWN_COMMAND
	Onbekend commando %s.
UNKNOWN_COMMAND_HELP
	Onbekend commando %s. /%s HELP voor hulp.
SYNTAX_ERROR
	Syntax: %s
MORE_INFO
	Typ /%s HELP %s voor meer information.
NO_HELP_AVAILABLE
	Geen hulp beschikbaar voor %s.
BAD_USERHOST_MASK
	Masker dient gegeven te worden in de vorm gebruiker@host.
SERVICE_OFFLINE
	%s is momenteel niet beschikbaar.
READ_ONLY_MODE
	Notice: Services in alleen-lezen modus;
	veranderingen zullen niet worden opgeslagen!
PASSWORD_INCORRECT
	Wachtwoord onjuist.

# What's the difference between "Access denied" and "Permission denied"?
# Very little; you can safely make them the same message with no real loss
# of meaning.  If you want to make a distinction, "Access denied" is
# usually used more generally; for example, a non-oper trying to access
# OperServ gets "Access denied", while a non-Services admin trying to use
# NickServ SET NOEXPIRE gets "Permission denied".
ACCESS_DENIED
	Geen toegang.
PERMISSION_DENIED
	Geen permissie.
MORE_OBSCURE_PASSWORD
	Probeer het nogmaals met een ingewikkelder wachtwoord.  
	Wachtwoorden dienen minimaal 5 karakters lang te zijn,
	en moeten niet makkelijk te raden zijn (bijv. uw echte naam 
	of bijnaam), en het kan geen spaties of tabs bevatten.
PASSWORD_TRUNCATED
	Opmerking:  Uw wachtwoord is terug gebracht tot %d karakters.
NICK_NOT_REGISTERED
	Uw bijnaam is niet geregistreerd.
NICK_NOT_REGISTERED_HELP
	Uw bijnaam is niet geregistreerd.  Typ /%s HELP voor 
	informatie over het registreren van uw bijnamen.
NICK_X_NOT_REGISTERED
	Bijnaam %s is niet geregistreerd.
NICK_X_NOT_IN_USE
	Bijnaam %s is momenteel niet ingebruik.
NICK_X_NOT_ON_CHAN
	Bijnaam %s is niet in kanaal %s.
NICK_X_FORBIDDEN
	Bijnaam %s mag niet geregistreerd of gebruikt worden.
CHAN_X_NOT_REGISTERED
	Kanaal %s is niet geregistreerd.
CHAN_X_NOT_IN_USE
	Kanaal %s is momenteel niet ingebruik.
CHAN_X_FORBIDDEN
	Kanaal %s mag niet geregistreerd of gebruikt worden.
NICK_IDENTIFY_REQUIRED
	Wachtwoord verificatie vereist voor dit commando.
	Probeer het nogmaals na het typen van: /%s IDENTIFY wachtwoord.
CHAN_IDENTIFY_REQUIRED
	Wachtwoord verificatie vereist voor dit commando.
	Probeer het nogmaals na het typen van: /%s IDENTIFY %s wachtwoord.

###########################################################################
#
# NickServ messages
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	Deze bijnaam is van iemand anders.  Kies een andere.
	(Als dit uw bijnaam is, typ /%s IDENTIFY wachtwoord.)
NICK_IS_SECURE
	Deze bijnaam is geregistreerd en beveiligd.  Als dit uw
	bijnaam is, typ /%s IDENTIFY password, anders dient u 
	een andere bijnaam te kiezen.
NICK_MAY_NOT_BE_USED
	Deze bijnaam mag niet gebruikt worden.  Kies een andere.
DISCONNECT_IN_1_MINUTE
	Als u niet veranderd binnen n minuut, wordt uw verbinding verbroken.
DISCONNECT_IN_20_SECONDS
	Als u niet verandert binnen 20 seconden, wordt uw verbinding verbroken.
DISCONNECT_NOW
	Deze bijnaam is geregistreerd: U kunt deze niet gebruiken.  
	Kies een andere bijnaam voordat u opnieuw verbinding maakt.

# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER wachtwoord E-mail
NICK_REGISTRATION_DISABLED
	Sorry, bijnaam registratie is tijdelijk uitgeschakeld.
NICK_REGISTRATION_FAILED
	Sorry, registratie mislukt.
NICK_REG_PLEASE_WAIT
	Wacht a.u.b. %d voordat u het REGISTER commando
	opnieuw gebruikt.
NICK_CANNOT_BE_REGISTERED
	Bijnaam %s mag niet geregistreerd worden.
NICK_ALREADY_REGISTERED
	Bijnaam %s is al geregistreerd!
NICK_REGISTERED
	Bijnaam %s is al geregistreerd onder uw account: %s
NICK_PASSWORD_IS
	Uw wachtwoord is %s - onthoud dit voor later gebruik.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY wachtwoord [NOJOIN]
NICK_IDENTIFY_FAILED
	Sorry, identificatie niet geslaagd.
NICK_IDENTIFY_SUCCEEDED
	Wachtwoord geaccepteerd - U bent nu herkend.

# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Sorry, bijnaam registratie ongedaan maken is tijdelijk uitgeschakeld.
NICK_DROPPED
	Uw bijnaam registratie is geannuleerd.
NICK_X_DROPPED
	De registratie van bijnaam %s is geannuleerd.

# SET responses
NICK_SET_SYNTAX
	SET optioe parameters
NICK_SET_SERVADMIN_SYNTAX
	SET [bijnaam] optie parameters
NICK_SET_DISABLED
	Sorry, veranderen van bijnaam opties is tijdelijk uitgeschakeld.
NICK_SET_UNKNOWN_OPTION
	Onbekende SET optie %s.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Onbekende SET optie %s, of bijnaam is niet geregistreerd.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Sorry, kon wachtwoord niet veranderen.
NICK_SET_PASSWORD_CHANGED
	Wachtwoord veranderd.
NICK_SET_PASSWORD_CHANGED_TO
	Wachtwoord veranderd naar %s.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE nummer
NICK_SET_LANGUAGE_UNKNOWN
	Onbekend taal nummer %d.  Typ /%s HELP SET LANGUAGE voor een lijst van talen.
NICK_SET_LANGUAGE_CHANGED
	Taal veranderd naar Nederlands.

# SET URL responses
NICK_SET_URL_CHANGED
	URL veranderd naar %s.
NICK_SET_URL_UNSET
	URL verwijderd.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	E-mail adres veranderd naar %s.
NICK_SET_EMAIL_UNSET
	E-mail adres verwijderd.

# SET ICQNUMBER responses
NICK_SET_ICQ_CHANGED
	ICQ nummer veranderd naar #%s.
NICK_SET_ICQ_UNSET
	ICQ nummer verwijderd.

# SET LOCATION responses
NICK_SET_LOCATION_CHANGED
	Location veranderd naar %s.
NICK_SET_LOCATION_UNSET
	Location verwijderd.

# SET KILL responses
NICK_SET_KILL_SYNTAX
	SET KILL {}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	Kill protectie staat nu ON (aan).
NICK_SET_KILL_QUICK
	Kill protectie staat nu ON (aan), met een kleinere 
	kill-vertraging.
NICK_SET_KILL_IMMED
	Kill protection staat nu  ON (aan), zonder kill-vertraging.
NICK_SET_KILL_IMMED_DISABLED
	De IMMED optie is niet beschikbaar op dit netwerk.
NICK_SET_KILL_OFF
	Kill protectie staat nu OFF (uit).

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Prive optie staat nu ON (aan).
NICK_SET_PRIVATE_OFF
	Prive optie staat nu OFF (uit).

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	Uw E-mail adres wordt nu verborgen in %s INFO weergave.
NICK_SET_HIDE_EMAIL_OFF
	Uw E-mail adres wordt nu getoond in %s INFO weergave.
NICK_SET_HIDE_QUIT_ON
	Uw laatste vertrek-boodschap wordt nu verborgen in %s INFO weergave.
NICK_SET_HIDE_QUIT_OFF
	Uw laatste vertrek-boodschap wordt nu getoond in %s INFO weergave.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [bijnaam] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	Bijnaam %s zal niet vervallen.
NICK_SET_NOEXPIRE_OFF
	Bijnaam %s zal vervallen.

# LINK responses
NICK_LINK_SYNTAX
	LINK bijnaam wachtwoord
NICK_NICKLINK_SYNTAX
	NICKLINK bijnaam koppelbijnaam
NICK_LINK_DISABLED
	Het LINK commando is niet beschikbaar.
NICK_LINK_FAILED
	Sorry, koppelen niet geslaagd..
NICK_NO_LINK_SAME
	U kunt niet aan uw huidige bijnaam koppelen!
NICK_LINK_CIRCULAR
	Kan niet koppellen aan bijnaam %s: circulatie koppeling gedetecteerd.
NICK_LINKED
	Uw bijnaam is gekoppeld aan %s.
NICK_NICKLINKED
	Bijnaam %s is gekoppeld aan bijnaam %s.

# UNLINK responses
NICK_UNLINK_SYNTAX
	UNLINK [bijnaam wachwoord]
NICK_UNLINK_FAILED
	Sorry, koppeling ongedaan maken niet geslaagd.
NICK_NOT_LINKED
	Uw bijnaam is niet gelinkt.
NICK_UNLINKED
	De koppeling van uw bijnaam met %s is ongedaan gemaakt.
NICK_X_NOT_LINKED
	Bijnaam %s is niet gekoppeld aan een andere bijnaam.
NICK_X_UNLINKED
	Bijnaam %s is niet meer gekoppeld aan %s.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS bijnaam [ALL]
NICK_LISTLINKS_SYNTAX2
	LISTLINKS
NICK_LISTLINKS_HEADER
	Lijst van bijnamen gekoppeld aan %s:
NICK_LISTLINKS_FOOTER
	%d gekoppelde bijnamen.

# INFO responses
NICK_INFO_SYNTAX
	INFO bijnaam
NICK_INFO_REALNAME
	%s is %s
NICK_INFO_ADDRESS
	     Laatst geziene adres: %s
NICK_INFO_TIME_REGGED
	       Tijd geregistreerd: %s [%s]
NICK_INFO_LAST_IDENTIFY
	       Last identify time: %s [%s]
NICK_INFO_LAST_SEEN
	            Laatst gezien: %s [%s]
NICK_INFO_ONLINE
	       Totale online tijd: %s
NICK_INFO_LAST_QUIT
	Laatste vertrek-boodschap: %s
NICK_INFO_URL
	                      URL: %s
NICK_INFO_EMAIL
	             E-mail adres: %s
NICK_INFO_ICQ
	               ICQ nummer: #%s
NICK_INFO_LOCATION
	                  Locatie: %s
NICK_INFO_OPTIONS
	                   Opties: %s
NICK_INFO_NO_EXPIRE
	                 Verloopt: Nooit
NICK_INFO_SUSPENDED
	    Bijnaam buitenwerking: %s
NICK_INFO_OSUSPENDED
	       Oper buitenwerking: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Kill protectie
NICK_INFO_OPT_PRIVATE
	Prive
NICK_INFO_OPT_NONE
	None

# LIST responses
NICK_LIST_SYNTAX
	LIST patroon
NICK_LIST_SERVADMIN_SYNTAX
	LIST patroon [FORBIDDEN] [NOEXPIRE]
NICK_LIST_HEADER
	Lijst van bijnamen met patroon %s:
NICK_LIST_RESULTS
	Einde van de lijst - %d/%d gevonden bijnamen getoond.

NICK_RELEASED
	Services houd uw bijnaam niet langer vast.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST bijnaam [wachtwoord]
NICK_NO_GHOST_SELF
	U kunt GHOST niet op uw zelf uitvoeren!
NICK_GHOST_KILLED
	Spook met uw bijnaam is verwijderd.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS bijnaam
NICK_GETPASS_UNAVAILABLE
	GETPASS commando is niet beschikbaar omdat encryptie aan staat.
NICK_GETPASS_PASSWORD_IS
	Wachtwoord van %s is %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID bijnaam
NICK_FORBID_SUCCEEDED
	bijnaam %s is nu onbruikbaar.
NICK_FORBID_FAILED
	Kan bijnaam %s niet onbruikbaar maken!

###########################################################################
#
# ChanServ messages
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Automatische kanaal operator status
CHAN_LEVEL_AUTOVOICE
	Automatische voice +v
CHAN_LEVEL_AUTODEOP
	Kanaal operator status niet toegestaan
CHAN_LEVEL_NOJOIN
	Mag niet op het kanaal als deze RESTRICTED is
CHAN_LEVEL_INVITE
	Mag INVITE commando gebruiken
CHAN_LEVEL_AKICK
	Mag AKICK commando gebruiken
CHAN_LEVEL_SET
	Mag SET commando gebruiken (niet FOUNDER/PASSWORD)
CHAN_LEVEL_CLEAR
	Mag CLEAR commando gebruiken
CHAN_LEVEL_UNBAN
	Mag UNBAN commando gebruiken
CHAN_LEVEL_OPDEOP
	Mag OP/DEOP commando gebruiken
CHAN_LEVEL_ACCESS_LIST
	Mag toegangslijst bekijken
CHAN_LEVEL_ACCESS_CHANGE
	Mag toegangslijst aanpassen
CHAN_LEVEL_MEMO_READ
	Mag kanaal memo's bekijken/lezen
CHAN_LEVEL_MEMO_SEND
	Mag memo's naar het kanaal zenden
CHAN_LEVEL_MEMO_DEL
	Mag kanaal memo's verwijderen
CHAN_LEVEL_KICK
	Mag KICK commando gebruiken

# Automatic responses
CHAN_IS_REGISTERED
	Dit kanaal is geregistreerd met %s.
CHAN_NOT_ALLOWED_OP
	U bent niet gemachtigd kanaal operator status te hebben op kanaal %s.
CHAN_MAY_NOT_BE_USED
	Dit kanaal mag niet gebruikt worden.
CHAN_NOT_ALLOWED_TO_JOIN
	U bent niet bevoegd dit kanaal binnen te gaan.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER kanaal wachtwoord beschrijving
CHAN_REGISTER_DISABLED
	Sorry, kanaal registratie is tijdelijk uitgeschakeld.
CHAN_REGISTER_NOT_LOCAL
	Lokale kanalen kunnen niet worden geregistreerd.
CHAN_MUST_REGISTER_NICK
	U dient uw bijnaam eerst te registreren.  Typ /%s HELP voor info over registreren van bijnamen.
CHAN_MUST_IDENTIFY_NICK
	Please identify with %s first, using the command:
	/%s IDENTIFY password
CHAN_MAY_NOT_BE_REGISTERED
	Kanaal %s mag niet geregistreerd worden.
CHAN_ALREADY_REGISTERED
	Kanaal %s is al geregistreerd!
CHAN_MUST_BE_CHANOP
	U dient kanaal operator te zijn om het kanaal te registreren.
CHAN_REACHED_CHANNEL_LIMIT
	Sorry, u heeft uw limiet van %d kanalen bereikt.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Sorry, heeft uw limiet van %d kanalen bereikt.
CHAN_REGISTRATION_FAILED
	Sorry, registratie niet geslaagd.
CHAN_REGISTERED
	Kanaal %s geregistreerd onder bijnaam: %s
CHAN_PASSWORD_IS
	Uw kanaal wachtwoord is %s - Onthou dit voor later gebruik.

# IDENTIFY responses
CHAN_IDENTIFY_SYNTAX
	IDENTIFY kanaal wachtwoord
CHAN_IDENTIFY_FAILED
	Sorry, identificatie niet geslaagd.
CHAN_IDENTIFY_SUCCEEDED
	Wachtwoord geaccepteerd - U heeft nu eigenaar rechten voor kanaal %s.

# DROP responses
CHAN_DROP_SYNTAX
	DROP kanaal
CHAN_DROP_DISABLED
	Sorry, kanaal registratie ongedaan maken is tijdelijk uitgeschakeld.
CHAN_DROPPED
	Registratie van kanaal %s is ongedaan gemaakt.

# SET responses
CHAN_SET_SYNTAX
	SET kanaal opties parameters
CHAN_SET_DISABLED
	Sorry, veranderen van kanaal opties is tijdelijk uitgeschakeld.
CHAN_SET_UNKNOWN_OPTION
	Onbekende SET optie %s.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s heeft te veel kanalen geregistreerd.
CHAN_FOUNDER_CHANGED
	Eigenaar van %s veranderd naar %s.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Opvolger van %s veranderd naar %s.
CHAN_SUCCESSOR_UNSET
	Opvolger van %s is verwijderd.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Sorry, kon wachtwoord niet veranderen.
CHAN_PASSWORD_CHANGED
	%s wachtwoord veranderd.
CHAN_PASSWORD_CHANGED_TO
	%s wachtwoord veranderd naar %s.

# SET DESC responses
CHAN_DESC_CHANGED
	Beschrijving van %s veranderd naar %s.

# SET URL responses
CHAN_URL_CHANGED
	URL van %s veranderd naar %s.
CHAN_URL_UNSET
	URL van %s is verwijderd.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	E-mail adres voor %s veranderd naar %s.
CHAN_EMAIL_UNSET
	E-mail adres voor %s is verwijderd.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	Binnenkomst bericht voor %s is veranderd.
CHAN_ENTRY_MSG_UNSET
	Binnenkomst bericht%s is verwijderd.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Sorry, kan onderwerp niet wijzigen.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	Parameter vereist voor MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	Parameter vereist voor MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Parameter voor MLOCK +l dient een positief getal te zijn.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Onbekende mode karakter %c genegeerd.
CHAN_MLOCK_CHANGED
	Mode slot op kanaal %s veranderd naar %s.
CHAN_MLOCK_REMOVED
	Mode slot voor kanaal %s is verwijderd.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET kanaal KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	Onderwerp behoud optie is nu ON (aan).
CHAN_SET_KEEPTOPIC_OFF
	Onderwerp behoud optie is nu OFF (uit).

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET kanaal TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Onderwerp slot optie is nu ON (aan).
CHAN_SET_TOPICLOCK_OFF
	Onderwerp slot optie is nu OFF (uit).

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET kanaal PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	Prive optie is nu ON (aan).
CHAN_SET_PRIVATE_OFF
	Prive optie is nu OFF (uit).

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET kanaal SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	Operator beveiliging optie is nu ON (aan).
CHAN_SET_SECUREOPS_OFF
	Operator beveiliging optie is nu OFF (uit).

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET kanaal LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	Leave ops optie is nu ON (aan).
CHAN_SET_LEAVEOPS_OFF
	Leave ops optie is nu OFF (uit).

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET kanaal RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	Beperkte toegang optie is nu ON (aan).
CHAN_SET_RESTRICTED_OFF
	Beperkte toegang optie is nu OFF (uit).

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET kanaal OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	Operator opmerking optie is nu ON (aan).
CHAN_SET_OPNOTICE_OFF
	Operator opmerking optie is nu OFF (uit).

# SET NOLINKS responses
CHAN_SET_NOLINKS_SYNTAX
	SET kanaal NOLINKS {ON | OFF}
CHAN_SET_NOLINKS_ON
	Geen gekoppelde bijnamen optie is nu ON (aan).
CHAN_SET_NOLINKS_OFF
	Geen gekoppelde bijnamen optie is nu OFF (uit).

# SET TOPICENTRY responses
CHAN_SET_TOPICENTRY_SYNTAX
	SET kanaal TOPICENTRY {ON | OFF}
CHAN_SET_TOPICENTRY_ON
	TOPICENTRY optie is nu ON (aan)
CHAN_SET_TOPICENTRY_OFF
	TOPICENTRY optie is nu OFF (uit)

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET kanaal NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Kanaal %s zal niet vervallen.
CHAN_SET_NOEXPIRE_OFF
	Kanaal %s zal vervallen.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS kanaal {ADD|DEL|LIST} [bijnaam [level] | invoerlijst]
CHAN_ACCESS_DISABLED
	Sorry, aanpassen van de kanaal toegangslijst is tijdelijk uitgeschakeld.
CHAN_ACCESS_LEVEL_NONZERO
	Toegangs-status mag geen nul zijn.
CHAN_ACCESS_LEVEL_RANGE
	Toegangs-status dient tussen %d en %d te zijn.
CHAN_ACCESS_NICKS_ONLY
	Kanaal toegangslijst mag alleen geregistreerde bijnamen bevatten.
CHAN_ACCESS_REACHED_LIMIT
	Sorry, Het aantal toegangen in de lijst is beperkt tot %d.
CHAN_ACCESS_LEVEL_UNCHANGED
	Toegangs-status van %s in %s onveranderd op %d.
CHAN_ACCESS_LEVEL_CHANGED
	Toegangs-status voor %s in %s veranderd van %d naar %d.
CHAN_ACCESS_ADDED
	%s toegevoegd aan %s toegangslijst met status %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	Invoer (#%d) komt niet voor op de toegangslijst van %s.
CHAN_ACCESS_NOT_FOUND
	%s niet gevonden in de toegangslijst van %s.
CHAN_ACCESS_NO_MATCH
	Invoer niet gevonden in de toegangslijst van %s.
CHAN_ACCESS_DELETED
	%s verwijderd uit de toegangslijst van %s.
CHAN_ACCESS_DELETED_ONE
	1 invoer verwijderd uit de toegangslijst van %s.
CHAN_ACCESS_DELETED_SEVERAL
	%d invoeren verwijderd uit de toegangslijst van %s.
CHAN_ACCESS_LIST_EMPTY
	Toegangslijst van %s is leeg.
CHAN_ACCESS_LIST_HEADER
	Toegangslijst voor %s:
	  Nr   Stat  Naam
CHAN_ACCESS_LIST_FORMAT
	  %3d  %4d  %s%s%s%s


# AOP/SOP error response
CHAN_NO_AOP_SOP
	Om op een kanaal privileges to te kennen aan een bijnaam, 
	gebruik het ACCESS commando; 
	typ /%s HELP ACCESS voor meer informatie.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK kanaal {ADD | DEL | LIST} [bijnaam-of-masker]
CHAN_AKICK_DISABLED
	Sorry, kanaal AKICK lijst bewerking is tijdelijk uitgeschakeld.
CHAN_AKICK_ALREADY_EXISTS
	%s bestaat al in de autokick lijst van %s.
CHAN_AKICK_REACHED_LIMIT
	Sorry, u kunt slechts %d autokick maskers invoeren per kanaal.
CHAN_AKICK_ADDED
	%s toegevoegd aan %s autokick lijst.
CHAN_AKICK_NO_SUCH_ENTRY
	Invoer (#%d) bestaat niet in %s autokick lijst.
CHAN_AKICK_NOT_FOUND
	%s niet gevonden in %s autokick lijst.
CHAN_AKICK_NO_MATCH
	Invoer niet gevonden in %s autokick lijst.
CHAN_AKICK_DELETED
	%s verwijderd uit %s autokick lijst.
CHAN_AKICK_DELETED_ONE
	1 invoer verwijderd uit %s autokick lijst.
CHAN_AKICK_DELETED_SEVERAL
	%d invoeren verwijderd uit %s autokick lijst.
CHAN_AKICK_LIST_EMPTY
	%s autokick lijst is leeg.
CHAN_AKICK_LIST_HEADER
	Autokick lijst van %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_LIST_FORMAT2
	  %3d %s by %s : %s

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS kanaal {SET | DIS[ABLE] | LIST | RESET} [optie [level]]
CHAN_LEVELS_RANGE
	Level moet tussen %d en %d liggen.
CHAN_LEVELS_CHANGED
	Level van %s voor kanaal %s veranderd naar %d.
CHAN_LEVELS_UNKNOWN
	Optie %s onbekend.  Typ /%s HELP LEVELS DESC voor een lijst van geldige opties.
CHAN_LEVELS_DISABLED
	%s uitgeschakeld op kanaal %s.
CHAN_LEVELS_LIST_HEADER
	Toegangslevel van kanaal %s ingesteld op:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (uitgeschakeld)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (alleen eigenaar)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	Toegangslevels van %s teruggezet naar standaardwaarden.

# INFO responses
CHAN_INFO_SYNTAX
	INFO kanaal
CHAN_INFO_HEADER
	Information for channel %s:
CHAN_INFO_FOUNDER
	                Eigenaar: %s (%s)
CHAN_INFO_NO_FOUNDER
	                Eigenaar: %s
CHAN_INFO_DESCRIPTION
	            Beschrijving: %s
CHAN_INFO_TIME_REGGED
	           Geregistreerd: %s [%s]
CHAN_INFO_LAST_USED
	         Laatst gebruikt: %s [%s]
CHAN_INFO_LAST_TOPIC
	       Laatste onderwerp: %s
CHAN_INFO_TOPIC_SET_BY
	Onderwerp ingesteld door: %s
CHAN_INFO_RECORD
	       Gebruikers record: %d gebruiker(s) op %s [%s]
CHAN_INFO_USERS
	               Bezetting: %d gebruiker(s)
CHAN_INFO_URL
	                     URL: %s
CHAN_INFO_EMAIL
	            E-mail adres: %s
CHAN_INFO_OPTIONS
	                  Opties: %s
CHAN_INFO_NO_EXPIRE
	                Verloopt: Nooit
CHAN_INFO_OPT_PRIVATE
	Prive
CHAN_INFO_OPT_KEEPTOPIC
	Onderwerp behoud
CHAN_INFO_OPT_TOPICLOCK
	Onderwerp slot
CHAN_INFO_OPT_SECUREOPS
	Operator beveiliging
CHAN_INFO_OPT_LEAVEOPS
	Operator behoud
CHAN_INFO_OPT_RESTRICTED
	Beperkte toegang
CHAN_INFO_OPT_TOPICENTRY
	Topic bij binnenkomst
CHAN_INFO_OPT_NOLINKS
	Geen gekoppelde bijnamen
CHAN_INFO_OPT_OPNOTICE
	Operator opmerking
CHAN_INFO_OPT_NONE
	Geen
CHAN_INFO_MODE_LOCK
	               Mode slot: %s

# LIST responses
CHAN_LIST_SYNTAX
	LIST patroon
CHAN_LIST_HEADER
	Lijst van invoeren met %s:
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	Einde van de lijst - %d/%d invoeren getoond.

# INVITE responses
CHAN_INVITE_SYNTAX
	INVITE kanaal

# OP responses
CHAN_OP_SYNTAX
	OP kanaal bijnaam

# DEOP responses
CHAN_DEOP_SYNTAX
	DEOP kanaal bijnaam

# KICK responses
CHAN_KICK_SYNTAX
	KICK kanaal bijnaam reden

# UNBAN responses
CHAN_UNBAN_SYNTAX
	UNBAN kanaal
CHAN_UNBANNED
	U bent niet langer verbannen van kanaal %s.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR kanaal wat
CHAN_CLEARED_BANS
	Alle verbannenen van kanaal %s kunnen weer binnengaan.
CHAN_CLEARED_MODES
	Alle modes van kanaal %s zijn teruggezet naar standaardwaarden.
CHAN_CLEARED_OPS
	Mode +o verwijderd van kanaal %s.
CHAN_CLEARED_VOICES
	Mode +v verwijderd van kanaal %s.
CHAN_CLEARED_USERS
	Alle gebruikers zijn verwijderd van kanaal %s.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS kanaal
CHAN_GETPASS_UNAVAILABLE
	GETPASS commando is niet beschikbaar omdat encryptie aanstaat.
CHAN_GETPASS_PASSWORD_IS
	Wachtwoord voor kanaal %s is %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID kanaal
CHAN_FORBID_SUCCEEDED
	Kanaal %s is nu onbruikbaar.
CHAN_FORBID_FAILED
	Kan kanaal %s niet onbruikbaar maken!

###########################################################################
#
# MemoServ messages
#
###########################################################################

# Automatic messages
MEMO_HAVE_NEW_MEMO
	U heeft 1 nieuwe memo.
MEMO_HAVE_NEW_MEMOS
	U heeft %d nieuwe memo's.
MEMO_TYPE_READ_LAST
	Typ /%s READ LAST om deze te lezen.
MEMO_TYPE_READ_NUM
	Typ /%s READ %d om deze te lezen.
MEMO_TYPE_LIST_NEW
	Typ /%s LIST NEW voor een lijst van nieuwe memo's.
MEMO_AT_LIMIT
	Waarschuwing: U heeft het maximum aantal memo's (%d) bereikt.  U kunt geen nieuwe memo's ontvangen totdat u 
	oude verwijdert.
MEMO_OVER_LIMIT
	Waarschwing: U heeft het maximumaantal memo's (%d) overschreden.  U kunt geen nieuwe memo's ontvangen totdat u 
	oude verwijdert.
MEMO_NEW_MEMO_ARRIVED
	U heeft een nieuwe memo van %s.
	Typ /%s READ %d om deze te lezen.

# Multi-use responses
MEMO_HAVE_NO_MEMOS
	U heeft geen memo's.
MEMO_X_HAS_NO_MEMOS
	%s heeft geen memo's.
MEMO_DOES_NOT_EXIST
	Memo %d bestaat niet!
MEMO_LIST_NOT_FOUND
	Geen memo volgens dit patroon.

# SEND responses
MEMO_SEND_SYNTAX
	SEND {bijnaam | kanaal} memo-tekst
MEMO_SEND_DISABLED
	Sorry, het sturen van memo's is tijdelijk uitgeschakeld.
MEMO_SEND_PLEASE_WAIT
	Wacht %d seconden voordat u het SEND commando weer gebruikt.
MEMO_X_GETS_NO_MEMOS
	%s kan geen memo's ontvangen.
MEMO_X_HAS_TOO_MANY_MEMOS
	%s heeft momenteel teveel memo's en kan geen nieuwe ontvangen.
MEMO_SENT
	Memo verstuurd naar %s.

# LIST responses
MEMO_LIST_SYNTAX
	LIST [kanaal] [list | NEW]
MEMO_HAVE_NO_NEW_MEMOS
	U heeft geen nieuwe memo's.
MEMO_X_HAS_NO_NEW_MEMOS
	%s heeft geen nieuwe memo's.
MEMO_LIST_MEMOS
	Memo's van %s. Om ze te lezen, typ: /%s READ num 
MEMO_LIST_NEW_MEMOS
	Niewe memo's van %s.  Om ze te lezen, typ: /%s READ num
MEMO_LIST_CHAN_MEMOS
	Memo's van %s.  Om ze te lezen, typ: /%s READ %s num
MEMO_LIST_CHAN_NEW_MEMOS
	Nieuwe memo's van %s.  Om ze te lezen, typ: /%s READ %s num
MEMO_LIST_HEADER
	 Nr  Afzender          Datum/Tijd
MEMO_LIST_FORMAT
	%c%3d  %-16s  %s "%s..."

# READ responses
MEMO_READ_SYNTAX
	READ [kanaal] {list | LAST | NEW}
MEMO_HEADER
	Memo %d van %s (%s).  Om te verwijderen, typ: /%s DEL %d
MEMO_CHAN_HEADER
	Memo %d van %s (%s).  Om te verwijderen, typ: /%s DEL %s %d
MEMO_TEXT
	%s

# DEL responses
MEMO_DEL_SYNTAX
	DEL [kanaal] {num | list | ALL}
MEMO_DELETED_NONE
	Geen memo's verwijderd.
MEMO_DELETED_ONE
	Memo %d verwijderd.
MEMO_DELETED_SEVERAL
	Memo's %s zijn verwijderd.
MEMO_DELETED_ALL
	Al uw memo's zijn verwijderd.

# SET responses
MEMO_SET_SYNTAX
	SET optie parameters
MEMO_SET_DISABLED
	Sorry, het veranderen van memo-opties is tijdelijk uitgeschakeld.
MEMO_SET_UNKNOWN_OPTION
	Onbekende SET optie %s.

# SET NOTIFY responses
MEMO_SET_NOTIFY_SYNTAX
	SET NOTIFY {ON | LOGON | NEW | OFF}
MEMO_SET_NOTIFY_ON
	%s zal u bericht geven van nieuwe memo's wanneer u inlogt en wanneer ze verstuurd worden.
MEMO_SET_NOTIFY_LOGON
	%s zal u bericht geven van nieuwe memo's wanneer u inlogt of terugkomt van /AWAY.
MEMO_SET_NOTIFY_NEW
	%s zal u bericht geven van nieuwe memo's wanneer ze aan u verstuurd worden.
MEMO_SET_NOTIFY_OFF
	%s zal u geen bericht geven van nieuwe memo's.

# SET LIMIT responses
MEMO_SET_LIMIT_SYNTAX
	SET LIMIT [kanaal] limiet
MEMO_SET_LIMIT_SERVADMIN_SYNTAX
	SET LIMIT [bijnaam | kanaal] {limiet | NONE} [HARD]
MEMO_SET_YOUR_LIMIT_FORBIDDEN
	U kunt uw memo-limiet niet veranderen.
MEMO_SET_LIMIT_FORBIDDEN
	Memo-limiet van %s mag niet veranderd worden.
MEMO_SET_YOUR_LIMIT_TOO_HIGH
	U kunt uw memo-limiet niet hoger dan %d zetten.
MEMO_SET_LIMIT_TOO_HIGH
	U kunt de memo-limiet van %s niet hoger zetten dan %d.
MEMO_SET_LIMIT_OVERFLOW
	Memo-limiet te groot; limiet ingesteld op %d.
MEMO_SET_YOUR_LIMIT
	Uw memo-limiet is ingesteld op %d.
MEMO_SET_YOUR_LIMIT_ZERO
	U kunt niet langer memo's ontvangen.
MEMO_UNSET_YOUR_LIMIT
	Uw memo-limiet is uitgeschakeld.
MEMO_SET_LIMIT
	Memo-limiet voor %s veranderd naar %d.
MEMO_SET_LIMIT_ZERO
	Memo-limiet voor %s veranderd naar 0.
MEMO_UNSET_LIMIT
	Memo-limiet uitgeschakeld voor %s.

# INFO responses
MEMO_INFO_SYNTAX
	INFO [kanaal]
MEMO_INFO_SERVADMIN_SYNTAX
	INFO [bijnaam | kanaal]
MEMO_INFO_NO_MEMOS
	U heeft momenteel geen memo's.
MEMO_INFO_MEMO
	U heeft momenteel 1 memo.
MEMO_INFO_MEMO_UNREAD
	U heeft momenteel 1 memo, en deze is nog niet gelezen.
MEMO_INFO_MEMOS
	U heeft momenteel %d memo's.
MEMO_INFO_MEMOS_ONE_UNREAD
	U heeft momenteel %d memo's, waarvan 1 nog ongelezen is.
MEMO_INFO_MEMOS_SOME_UNREAD
	U heeft momenteel %d memo's, waarvan %d ongelezen zijn.
MEMO_INFO_MEMOS_ALL_UNREAD
	U heeft momenteel %d memos; waarvan er nog geen is gelezen.
MEMO_INFO_LIMIT
	Uw memo-limiet is %d.
MEMO_INFO_HARD_LIMIT
	Uw memo-limiet is %d, en deze mag niet veranderd worden.
MEMO_INFO_LIMIT_ZERO
	Uw memo-limiet is 0; u kunt geen memo's ontvangen.
MEMO_INFO_HARD_LIMIT_ZERO
	Uw memo-limiet is 0; u kunt geen memo's ontvangen.  U kunt dit limiet niet veranderen.
MEMO_INFO_NO_LIMIT
	U heeft geen limiet op het aantal memo's dat u mag hebben.
MEMO_INFO_X_NO_MEMOS
	%s heeft momenteel geen memo's.
MEMO_INFO_X_MEMO
	%s heeft momenteel 1 memo.
MEMO_INFO_X_MEMO_UNREAD
	%s heeft momenteel 1 memo, en deze is nog niet gelezen.
MEMO_INFO_X_MEMOS
	%s heeft momenteel %d memo's.
MEMO_INFO_X_MEMOS_ONE_UNREAD
	%s heeft momenteel %d memo's, waarvan 1 nog ongelezen is.
MEMO_INFO_X_MEMOS_SOME_UNREAD
	%s heeft momenteel %d memo's, waarvan %d ongelezen zijn.
MEMO_INFO_X_MEMOS_ALL_UNREAD
	%s heeft momenteel %d memo's; waarvan er nog geen gelezen.
MEMO_INFO_X_LIMIT
	%s's memo-limiet is %d.
MEMO_INFO_X_HARD_LIMIT
	%s's memo-limiet is %d.
MEMO_INFO_X_NO_LIMIT
	%s heeft geen memo-limiet.

###########################################################################
#
# OperServ messages
#
###########################################################################

# General messages
OPER_BOUNCY_MODES
	Services kan mode niet veranderen.  Zijn uw services juist geconfigureerd?
OPER_BOUNCY_MODES_U_LINE
	Services kan mode niet veranderen.  Zijn de U:lines van uw servers juist geconfigureerd?

# GLOBAL responses
OPER_GLOBAL_SYNTAX
	GLOBAL bericht

# STATS responses
OPER_STATS_UNKNOWN_OPTION
	Onbekende STATS optie %s.
OPER_STATS_CURRENT_USERS
	Huidige aantal gebruikers: %d (%d ops, %d helpers, %d bots)
OPER_STATS_MAX_USERS
	Maximum aantal gebruikers: %d (%s)
# This is ugly, but at least it's language-portable...
# Note that you can include seconds in any of these--my personal preference
# is to only give resolution to the nearest minute when uptime is one hour
# or more, but just add a %d to get seconds as well.
OPER_STATS_UPTIME_DHMS
	Services online %d dagen, %02d:%02d
OPER_STATS_UPTIME_1DHMS
	Services online %d dag, %02d:%02d
OPER_STATS_UPTIME_HMS
	Services online %d uur, %d minuten
OPER_STATS_UPTIME_HM1S
	Services online %d uur, %d minuten
OPER_STATS_UPTIME_H1MS
	Services online %d uur, %d minuut
OPER_STATS_UPTIME_H1M1S
	Services online %d uur, %d minuut
OPER_STATS_UPTIME_1HMS
	Services online %d uur, %d minuten
OPER_STATS_UPTIME_1HM1S
	Services online %d uur, %d minuten
OPER_STATS_UPTIME_1H1MS
	Services online %d uur, %d minuut
OPER_STATS_UPTIME_1H1M1S
	Services online %d uur, %d minuut
OPER_STATS_UPTIME_MS
	Services online %d minuten, %d seconden
OPER_STATS_UPTIME_M1S
	Services online %d minuten, %d seconde
OPER_STATS_UPTIME_1MS
	Services online %d minuut, %d seconden
OPER_STATS_UPTIME_1M1S
	Services online %d minuut, %d seconde
OPER_STATS_USER_MEM
	Gebruiker: %6d record, %5d kB
OPER_STATS_CHANNEL_MEM
	Kanaal   : %6d record, %5d kB
OPER_STATS_NICKSERV_MEM
	NickServ : %6d record, %5d kB
OPER_STATS_CHANSERV_MEM
	ChanServ : %6d record, %5d kB
OPER_STATS_OPERSERV_MEM
	OperServ : %6d record, %5d kB
OPER_STATS_AKILL_COUNT
	Huidige aantal AKILLs: %d
OPER_STATS_AKILL_EXPIRE_DAYS
	Standaard AKILL verlooptijd: %d dagen
OPER_STATS_AKILL_EXPIRE_DAY
	Standaard AKILL verlooptijd: 1 dag
OPER_STATS_AKILL_EXPIRE_HOURS
	Standaard AKILL verlooptijd: %d uren
OPER_STATS_AKILL_EXPIRE_HOUR
	Standaard AKILL verlooptijd: 1 uur
OPER_STATS_AKILL_EXPIRE_MINS
	Standaard AKILL verlooptijd: %d minuten
OPER_STATS_AKILL_EXPIRE_MIN
	Standaard AKILL verlooptijd: 1 minuut
OPER_STATS_AKILL_EXPIRE_NONE
	Standaard AKILL verlooptijd: Verloopt niet

# MODE responses
OPER_MODE_SYNTAX
	MODE kanaal modes

# CLEARMODES responses
OPER_CLEARMODES_SYNTAX
	CLEARMODES kanaal [ALL]
OPER_CLEARMODES_DONE
	Binaire modes en verbanningen verwijderd van kanaal %s.
OPER_CLEARMODES_ALL_DONE
	Alle modes verwijderd van kanaal %s.


# KICK responses
OPER_KICK_SYNTAX
	KICK kanaal bijnaam reden

# ADMIN responses
OPER_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [bijnaam]
OPER_ADMIN_ADD_SYNTAX
	ADMIN ADD bijnaam
OPER_ADMIN_DEL_SYNTAX
	ADMIN DEL bijnaam
OPER_ADMIN_SKELETON
	Services in skelet mode; het ADMIN commando is tijdelijk uitgeschakeld.
OPER_ADMIN_EXISTS
	%s bestaat al in Services admin lijst.
OPER_ADMIN_ADDED
	%s toegevoegd aan Services admin lijst.
OPER_ADMIN_TOO_MANY
	Te veel invoeren (%d) in Services admin lijst; kan niet meer toevoegen.
OPER_ADMIN_REMOVED
	%s verwijderd uit Services admin lijst.
OPER_ADMIN_NOT_FOUND
	%s niet gevonden in Services admin lijst.
OPER_ADMIN_LIST_HEADER
	Services admin lijst:

# OPER responses
OPER_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [bijnaam] | SUSPEND bijnaam days
OPER_OPER_ADD_SYNTAX
	OPER ADD bijnaam
OPER_OPER_DEL_SYNTAX
	OPER DEL bijnaam
OPER_OPER_SKELETON
	Services in skelet mode; het OPER commando is tijdelijk uitgeschakeld.
OPER_OPER_EXISTS
	%s bestaat al in Services operator lijst.
OPER_OPER_ADDED
	%s toegevoegd aan Services operator lijst.
OPER_OPER_TOO_MANY
	Te veel invoeren (%d) in Services operator lijst; kan niet meer toevoegen.
OPER_OPER_REMOVED
	%s verwijderd uit Services operator lijst.
OPER_OPER_NOT_FOUND
	%s verwijderd uit Services operator lijst.
OPER_OPER_LIST_HEADER
	Services operator lijst:

# AKILL responses
OPER_AKILL_SYNTAX
	AKILL {ADD | DEL | LIST | VIEW} [[+verlooptijd] masker [reden]]
OPER_AKILL_ADD_SYNTAX
	AKILL ADD [+verlooptijd] masker reden
OPER_AKILL_DEL_SYNTAX
	AKILL DEL masker
OPER_TOO_MANY_AKILLS
	AKILL lijst is vol!
OPER_AKILL_NO_NICK
	Herrinnering: AKILL maskers mogen geen bijnamen bevatten; 
	Let op of u geen bijnaam in uw masker heeft gezet.
OPER_AKILL_ADDED
	%s toegevoegd aan AKILL lijst.
OPER_AKILL_REMOVED
	%s verwijderd van AKILL lijst.
OPER_AKILL_NOT_FOUND
	%s niet gevonden in AKILL lijst.
OPER_AKILL_LIST_HEADER
	Huidige AKILL lijst:
# mask, reason
OPER_AKILL_LIST_FORMAT
	%-32s  %s
# mask, set-by, set-time, expires, reason
OPER_AKILL_VIEW_FORMAT
	%s (by %s on %s; %s)
	    %s
OPER_AKILL_NO_EXPIRE
	verloopt niet
OPER_AKILL_EXPIRES_SOON
	Verloopt bij de volgende database update
OPER_AKILL_EXPIRES_M
	verloopt over %d minuten
OPER_AKILL_EXPIRES_1M
	verloopt over %d minuut
OPER_AKILL_EXPIRES_HM
	verloopt over %d uur, %d minuten
OPER_AKILL_EXPIRES_H1M
	verloopt over %d uur, %d minuut
OPER_AKILL_EXPIRES_1HM
	verloopt over %d uur, %d minuten
OPER_AKILL_EXPIRES_1H1M
	verloopt over %d uur, %d minuut
OPER_AKILL_EXPIRES_D
	verloopt over %d dagen
OPER_AKILL_EXPIRES_1D
	verloopt %d dag

# SET responses
OPER_SET_SYNTAX
	SET optie instelling
OPER_SET_IGNORE_ON
	Negeer code wordt gebruikt.
OPER_SET_IGNORE_OFF
	Negeer code wordt niet gebruikt.
OPER_SET_IGNORE_ERROR
	Instelling voor IGNORE (negeer) moet ON (aan) of OFF (uit) zijn.
OPER_SET_READONLY_ON
	Services staat nu in alleen-lezen modus.
OPER_SET_READONLY_OFF
	Services staat nu in lees-schrijf modus.
OPER_SET_READONLY_ERROR
	Instelling voor READONLY (alleen-lezen) moet ON (aan) of OFF (uit) zijn.
OPER_SET_DEBUG_ON
	Services staat nu in debug modus.
OPER_SET_DEBUG_OFF
	Services staat nu in non-debug modus.
OPER_SET_DEBUG_LEVEL
	Services staat nu in debug modus (nivo %d).
OPER_SET_DEBUG_ERROR
	Instelling voor DEBUG moet ON (aan), OFF (uit), of een positief nummer zijn.
OPER_SET_UNKNOWN_OPTION
	Onbekende optie %s.

# JUPE responses
OPER_JUPE_SYNTAX
	JUPE servernaam [reden]

# RAW responses
OPER_RAW_SYNTAX
	RAW tekst

# UPDATE responses
OPER_UPDATING
	Databases worden geupdate.

# RESTART responses
OPER_CANNOT_RESTART
	SERVICES_BIN is niet gedefineerd; Kan niet herstarten.  Run het \2configure\2 script en her-compile de Services om 
	het RESTART commando te activeren.

# LISTIGNORE responses
OPER_IGNORE_LIST
	Services negeer lijst:
OPER_IGNORE_LIST_EMPTY
	Ignore lijst is leeg.

###########################################################################
#
# News system messages
#
###########################################################################

NEWS_LOGON_TEXT
	[Inlog Nieuws - %s] %s
NEWS_OPER_TEXT
	[Oper Nieuws - %s] %s

NEWS_LOGON_SYNTAX
	Syntax: LOGONNEWS {ADD|DEL|LIST} [tekst|num]
NEWS_LOGON_LIST_HEADER
	Inlog nieuws punten:
NEWS_LOGON_LIST_ENTRY
	%5d (%s by %s)
	    %s
NEWS_LOGON_LIST_NONE
	Er is geen inlog nieuws.
NEWS_LOGON_ADD_SYNTAX
	Syntax: LOGONNEWS ADD tekst
NEWS_LOGON_ADD_FULL
	Nieuws lijst is vol!
NEWS_LOGON_ADDED
	Nieuw inlog nieuws punt (#%d) toegevoegd.
NEWS_LOGON_DEL_SYNTAX
	Syntax: LOGONNEWS DEL {num | ALL}
NEWS_LOGON_DEL_NOT_FOUND
	Inlog nieuws punt #%d niet gevonden!
NEWS_LOGON_DELETED
	Inlog nieuws punt #%d verwijderd.
NEWS_LOGON_DEL_NONE
	Geen inlog nieuws punten om te verwijderen!
NEWS_LOGON_DELETED_ALL
	Alle inlog nieuws punten zijn verwijderd.

NEWS_OPER_SYNTAX
	Syntax: OPERNEWS {ADD|DEL|LIST} [tekst|num]
NEWS_OPER_LIST_HEADER
	Oper nieuws punten:
NEWS_OPER_LIST_ENTRY
	%5d (%s door %s)
	    %s
NEWS_OPER_LIST_NONE
	Er is geen oper nieuws.
NEWS_OPER_ADD_SYNTAX
	Syntax: OPERNEWS ADD tekst
NEWS_OPER_ADD_FULL
	Nieuws lijst is vol!
NEWS_OPER_ADDED
	Nieuw oper nieuws punt (#%d) toegevoegd.
NEWS_OPER_DEL_SYNTAX
	Syntax: OPERNEWS DEL {num | ALL}
NEWS_OPER_DEL_NOT_FOUND
	Oper nieuws punt #%d niet gevonden!
NEWS_OPER_DELETED
	Oper nieuws punt #%d verwijderd.
NEWS_OPER_DEL_NONE
	Geen oper nieuws punten om te verwijderen!
NEWS_OPER_DELETED_ALL
	Alle oper nieuws punten zijn verwijderd.

NEWS_HELP_LOGON
	Syntax: LOGONNEWS ADD tekst
	        LOGONNEWS DEL {num | ALL}
	        LOGONNEWS LIST
	
	Toont of muteert de lijst van inlog nieuws berichten.
	Wanneer een gebruiker inlogt worden deze aan hem/haar
	getoond. (Let op, niet meer dan 3 berichten worden
	verstuurd om te voorkomen dat de gebruiker overladen wordt.
	Als er meer dan 3 berichten zijn worden alleen de 3 meest
	recente berichten gestuurd.)
	
	LOGONNEWS LIST kan gebruikt worden door elke IRC Operator
	voor een lijst van huidige berichten.  ADD and DEL kunnen
	alleen door Services admins gebruikt worden.


NEWS_HELP_OPER
	Syntax: OPERNEWS ADD tekst
	        OPERNEWS DEL {num | ALL}
	        OPERNEWS LIST
	
	Toont of muteert de lijst van oper nieuws berichten.
	Wanneer een gebruiker opert (/OPER) worden deze berichten
	naar hem/haar gestuurd. (Let op, niet meer dan 3 berichten
	worden verstuurd om te voorkomen dat de gebruiker overladen
	wordt. Als er meer dan 3 berichten zijn worden alleen de 3
	meest recente berichten gestuurd.)

	OPERNEWS LIST kan gebruikt worden door elke IRC Operator
	voor een lijst van huidige berichten.  ADD and DEL kunnen
	alleen door Services admins gebruikt worden.


###########################################################################
#
# NickServ help messages
#
###########################################################################

NICK_HELP
	%S geeft u de mogelijkheid een bijnaam te "registreren"
	zodat anderen deze niet kunnen gebruiken.  %S wordt bediend
	door middel van verschillende commando's die de registratie
	en het bijhouden van bijnamen mogelijk maken.  Voor een lijst van
	commando's, typ /%S HELP commando; om een commando
	te gebruiken, typ /%S commando, en voor meer
	informatie over een bepaald commando, typ
	/%S HELP commando.
	
	    AJOIN      Aanpassen van uw autojoin kanaal lijst
	    REGISTER   Registreer een bijnaam
	    IDENTIFY   Identificeer uzelf met uw wachtwoord
	    LINK       Maak van uw bijnaam een alias voor een andere
	               bijnaam
	    SET        Set opties
	    DROP       Maak de registratie van een bijnaam ongedaan
	    LISTLINKS  Lijst van alle aliassen die bij een bijnaam horen
	    NOTES      Mogelijkheid om tekst notities te bewaren
	    GHOST      Verwijder een "spook" sessie

	Overige commando's: UNLINK, INFO, LIST, STATUS
	
	OPMERKING: Deze service is bedoeld om IRC gebruikers de
	mogelijkheid te geven te zorgen dat hun identiteit niet in
	twijfel wordt gebracht. Het is NIET bedoeld voor het "stelen"
	van bijnamen of andere kwaadaardige doelen. Misbruik van %S
	zorgt, op zijn minst, voor verlies van de misbruikte
	bijna(a)m(en).


NICK_HELP_EXPIRE_ZERO
	%S geeft u de mogelijkheid een bijnaam te "registreren"
	zodat anderen deze niet kunnen gebruiken.  %S wordt bediend
	door middel van verschillende commando's die registratie
	Voor een lijst van commando's,  om een commando te gebruiken,
	typ /%S commando, en voor meer informatie over een
	bepaald commando, typ /%S HELP commando.
	
	    REGISTER   Registreer een bijnaam
	    IDENTIFY   Identificeer uzelf met uw wachtwoord
	    LINK       Maak van uw bijnaam een alias voor een andere
	               bijnaam
	    SET        Set opties, bevat oa. kill protectie
	    DROP       Maak de registratie van een bijnaam ongedaan
	
	Overige commando's: UNLINK, GHOST, INFO, LIST, STATUS
	
	OPMERKING: Deze service is bedoeld om IRC gebruikers de
	mogelijkheid te geven te zorgen dat hun identiteit niet in
	twijfel wordt gebracht. Het is NIET bedoeld voor het "stelen"
	van bijnamen of andere kwaadaardige doelen. Misbruik van %S
	zorgt, op zijn minst, voor verlies van de misbruikte
	bijna(a)m(en).

NICK_HELP_REGISTER
	Syntax: REGISTER wachtwoord E-mail
	
	Registreer uw bijnaam in de %S database.
	Als u geen E-mail adres heeft gebruik dan het woord NOMAIL.
	als E-mail adres. Wanneer uw bijnaam geregistreerd is kan u met 
	het SET commando instellingen van uw bijnaam veranderen 
	Let op dat u het wachtwoord waarmee u geregistreerd heeft
	niet vergeet - u heeft deze nog nodig later.
	(Let op dat type letters uitmaakt!  FIDO, Fido, en
	fido zijn allen verschillende wachtwoorden!)

	Regels voor het kiezen van een wachtwoord:
	
	Wachtwoorden moeten niet makkelijk te raden zijn.
	Uw echte naam als wachtwoord nemen is bijvoorbeeld een
	slecht idee.  Uw bijnaam als wachtwoord is nog slechter ;)
	en %S zal dat ook niet toestaan.  Korte wachtwoorden zijn
	gevaarlijk als iemand zomaar wat probeerd, daarom dient
	uw wachtwoord minimaal 5 tekens te zijn.

NICK_HELP_IDENTIFY
	Syntax: IDENTIFY wachtwoord [ NOJOIN ]
	
	Verteld %S dat u werkelijk de eigenaar bent van uw
	bijnaam.  Veel commando's kunnen pas gebruikt worden
	nadat u zich geindentificeerd heeft.  Het wachtwoord
	is dezelfde die u gebruikt heeft bij het REGISTER
	commando.
	Als NOJOIN wordt gebruikt, dan betreed u niet de kanalen
	die in de autojoin lijst staat.

NICK_HELP_DROP
	Syntax: DROP
	
	Verwijdert uw bijnaam uit de %S database.  Een bijnaam
	die verwijderd is kan door iedereen geregistreerd worden.
	
	Om gebruik te maken van dit commando, dient u zich te 
	identificeren met uw wachtwoord (/%S HELP IDENTIFY voor meer
	informatie).

NICK_HELP_LINK
	Syntax: LINK bijnaam wachtwoord
	
	Koppelt uw bijnaam aan een andere, waardoor de bijnaam die
	u op dat moment gebruikt een alias wordt voor de gegeven
	bijnaam.  Wanneer u dit commando geeft wordt de
	autojoin lijst van uw huidige bijnaam verwijderd en vervangen
	door de bijnaam die u koppelt; alle memo's van uw huidige
	bijnaam worden aan de lijst van de andere naam toegevoegd
	(hierdoor kan de bijnaam teveel memo's hebben, in dat geval
	dient u er een aantal te verwijderen om meer memo's te
	kunnen ontvangen met beide bijnamen).
	
	Wanneer de bijnamen gekoppeld zijn wordt uw bijnaam
	onzichtbaar veranderd naar de andere bijnaam in de Services,
	behalve voor de %S commando's UNLINK en DROP.  U kunt
	bijvoorbeeld beide bijnamen gebruiken om dezelfde memo's te
	lezen (en memo's voor beide bijnamen komen in dezelfde
	lijst). Als U zich identificeerd voor 1 van de bijnamen is de 
	gekoppelde bijnaam ook geidentificeerd. Als een van de bijnamen 
	op een toegangslijst van een kanaal staat krijgen beide bijnamen
	dezelfde rechten.
	
	Om dit commando te kunnen gebruiken dient u zich te
	identificeren voor uw huidige bijnaam (door middel van het
	IDENTIFY commando).Geef vervolgens het wachtwoord op van de bijnaam 
	waar u aan wilt koppelen.

NICK_HELP_UNLINK
	Syntax: UNLINK [bijnaam wachtwoord]
	
	Verwijdert de koppeling tussen 2 bijnamen.  Wanneer de
	koppeling verwijderd is kunnen bijnaam opties en
	toegangslijsten onafhankelijk veranderd worden.  Memo's
	worden niet naar uw huidige bijnaam gekopieerd; deze blijven
	allemaal bij de voorheen gekoppelde bijnaam.
	
	Wanneer een bijnaam en wachtwoord als parameters gegeven
	worden kan een andere bijnaam dan uw huidige ontkoppeld
	worden.

NICK_HELP_SET
	Syntax: SET optie parameters
	
	Verandert verschillende bijnaam opties.  optie kan zijn:
	
	    PASSWORD   Verander uw bijnaam wachtwoord
	    LANGUAGE   Verander de taal waarin Services u berichten
	                   stuurt
	    URL        Associeer een URL met uw bijnaam
	    EMAIL      Associeer een E-mail adres met uw bijnaam
	    ICQNUMBER  Associeer een ICQ nummer met uw bijnaam
	    LOCATION   Associeer een locatie met uw bijnaam
	    KILL       Zet kill protectie aan of uit
	    PRIVATE    Zorg dat uw bijnaam niet voorkomt in een
	                   /%S LIST
	    HIDE       Verberg bepaalde bijnaam informatie
	    AUTOJOIN   Zet Ajoin aan of uit
	    NEWSLETTER Inschakelen/uitschakelen van nieuwsbrief
	                   ontvangen
	    PRIVMSG    	Inschakelen/uitschakelen van prive berichten
			   van de services
	
	Om dit commando te gebruiken dient u zich eerst te
	identificeren met uw wachtwoord (/%S HELP IDENTIFY 
	voor meer informatie)
	
	Typ /%S HELP SET optie voor meer informatie
	over een specifieke optie.

NICK_HELP_SET_PASSWORD
	Syntax: SET PASSWORD nieuw-wachtwoord
	
	Veranderd het wachtwoord waarmee u zich identificeerd als
	eigenaar van de bijnaam.

NICK_HELP_SET_LANGUAGE
	Syntax: SET LANGUAGE nummer
	
	Verandert de taal waarin Services berichten naar u stuurt
	(bijvoorbeeld als antwoord op een commando dat u geeft).
	nummer moet 1 van de volgende punten zijn:

NICK_HELP_SET_URL
	Syntax: SET URL url
	
	Associeerd het gegeven URL met uw bijnaam.  Dit URL
	wordt getoond wanneer iemand informatie opvraagd over uw
	bijnaam met het INFO commando.

NICK_HELP_SET_EMAIL
	Syntax: SET EMAIL adres
	
	Associeerd het gegeven E-mail adres met uw bijnaam.  Dit
	adres wordt getoond wanneer iemand informatie opvraagd over
	uw bijnaam met het INFO commando.

NICK_HELP_SET_ICQ
	Syntax: SET ICQNUMBER  #nummer
	
	Associeerd het gegeven ICQ #nummer met uw bijnaam.  Dit
	ICQ #nummer wordt getoond wanneer iemand informatie opvraagd over
	uw bijnaam met het INFO commando.

NICK_HELP_SET_LOCATION
	Syntax: SET LOCATION  locatie

	Associeerd de gegeven locatie met uw bijnaam.  Deze
	locatie wordt getoond wanneer iemand informatie opvraagd over
	uw bijnaam met het INFO commando.
	

NICK_HELP_SET_KILL

	Syntax: SET KILL {ON | QUICK | IMMED | OFF}
	
	Zet de automatische kill protectie voor uw bijnaam aan of
	uit.
	Wanneer kill protectie aanstaat krijgt iemand die uw bijnaam
	wil gebruiken 60 seconden de tijd om te identificeren.  Doet
	hij/zij dit niet dan wordt de persoon verwijderd van het IRC
	netwerk door %S.
	
	Als u QUICK selecteerd krijgt de gebruiker slechts 20
	seconden de tijd.  Wanneer u IMMED selecteerd wordt de
	gebruiker meteen verwijderd van het netwerk zonder kans
	te krijgen om zijn/haar bijnaam te veranderen; gebruik
	deze optie alleen in geval van nood.  Uw netwerk
	administrators kunnen deze optie uitgeschakeld hebben.

NICK_HELP_SET_PRIVATE

	Syntax: SET PRIVATE {ON | OFF}
	
	Zet de %S prive optie aan of uit voor uw bijnaam. Wanneer
	PRIVATE aan staat zal uw bijnaam niet getoond worden in
	een %S LIST. (Let op, iemand die uw bijnaam weet kan nog
	steeds informatie over u verkrijgen met het INFO commando.)

NICK_HELP_SET_HIDE
	Syntax: SET HIDE {EMAIL | QUIT} {ON | OFF}
	
	Voorkomt dat bepaalde informatie over u getoond wordt
	wanneer iemand %S INFO van uw bijnaam opvraagd. U kunt uw
	E-mail adres (EMAIL), en laatste vertrek boodschap 
	(QUIT) verbergen. De tweede parameter geeft aan of de
	informatie verborgen (ON) of niet (OFF) moet worden.

NICK_HELP_GHOST
	Syntax: GHOST nickname [password]
	
	Verwijdert een "spook" met uw bijnaam.  Een "spook" sessie
	is een gebruiker die niet werkelijk aanwezig is, maar
	waarvan de server denkt dat deze nog online is voor 1 of
	andere reden. Mogelijke oorzaak kan een computercrash
	of modemstoring zijn.
	
	Om het GHOST commando te gebruiken dient u het wachtwoord
	van de bijnaam in te geven.

NICK_HELP_INFO
	Syntax: INFO bijnaam
	
	Geeft informatie over de gegeven bijnaam, zoals eigenaar,
	laatst geziene hostmask en tijd en bijnaam opties. 

NICK_HELP_LIST
	Syntax: LIST patroon
	
	Geeft een lijst van alle bijnamen waarvan ofwel de bijnaam
	zelf, of wel het laatst geziene adres (in de vorm
	gebruiker@host) overeenkomt met het gegeven patroon.
	Bijnamen met de PRIVATE optie aan worden niet getoont.
	
	Voorbeelden:
	
	    LIST *!joeuser@foo.com
	        Geeft alle geregistreerde bijnamen die het laatst gebruikt zijn door joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Geeft alle geregistreerde bijnamen met Bot in de naam (hoofd of kleine letters).

	    LIST *!*@*.bar.org
	        Geeft alle geregistreerde bijnamen die het laatst gebruikt zijn in het bar.org domein.

NICK_HELP_STATUS
	Syntax: STATUS bijnaam...
	
	Verteld of de gebruiker van de bijnaam op dat moment de
	eigenaar van die bijnaam is.  Dit in de volgende vorm:
	
	    bijnaam status-code
	
	Waar bijnaam de gegeven bijnaam is en status-code
	n van de volgende:
	
	    0 - Gebruiker niet online of bijnaam niet geregistreerd
	    1 - Gebruiker niet herkend als eigenaar van de bijnaam
	    2 - Gebruiker alleen herkend via wachtwoord identificatie
	    3 - Gebruiker herkend door wachtwoord identificatie
	
	Maximaal 16 bijnamen mogen gegeven worden met dit commando;
	de rest wordt genegeerd. Er wordt geen error gegeven als
	geen bijnaam gegeven is.

NICK_SERVADMIN_HELP
	
	De volgende commando's zijn beschikbaar voor Services admins:
	
	    GETPASS     Verkrijg het wachtwoord van een bijnaam
	                   (alleen als versleuteling uitstaat)
	    FORBID      Zorg dat een bijnaam niet gebruikt kan worden
	    LISTLINKS   Geef een lijst van bijnamen gekoppeld aan de gegeven
	                    bijnaam
	
	Services admins kunnen een bijnaam registratie ongedaan maken zonder 
	zich te identificeren voor de bijnaam, en kan de ajoin lijst van
	elke bijnaam bekijken met (/%S AJOIN LIST bijnaam).

NICK_SERVADMIN_HELP_DROP
	Syntax: DROP [bijnaam]
	
	Verwijdert de gegeven bijnaam uit de %S database, evenals alle
	gekoppelde bijnamen.
	
	Met een parameter in de vorm van een bijnaam wordt deze bijnaam
	verwijderd uit de database.
	Gebruik beperkt tot Services admins.

NICK_SERVADMIN_HELP_SET
	
	Services admins kunnen ook de optie NOEXPIRE gebruiken,
	waarmee voorkomen kan worden dat bijnamen vervallen.
	Ook kunnen Services Admins opties veranderen voor elke
	bijnaam zonder wachtwoord op de volgende manier:
	SET bijnaam optie parameters.

NICK_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET [bijnaam] NOEXPIRE {ON | OFF}
	
	Stelt in of een bijnaam verloopt of niet. ON zorgt dat de
	bijnaam niet verlooptt.  Als geen bijnaam gegeven is wordt de
	instelling toegepast op uw eigen bijnaam.
	
	Gebruik beperkt tot Services admins.

NICK_SERVADMIN_HELP_UNLINK
	
	Services admins kunnen elke bijnaam koppeling ongedaan maken
	zonder wachtwoord.

NICK_HELP_LISTLINKS
	Syntax: LISTLINKS
	
	Geeft een lijst van bijnamen die aan de gegeven bijnaam
	gekoppeld zijn.

NICK_SERVADMIN_HELP_LISTLINKS
	Syntax: LISTLINKS bijnaam [ALL]
	
	Geeft een lijst van alle gekoppelde bijnaam van de opgegeven bijnaam.  
	Als ALL is gespecificeert wordt er een lijst gegeven van alle bijnamen  
	met de zelfde privileges van de gegeven bijnaam; Anders geeft het een lijst
	van de namen die direct gekoppeld zijn aan de gegeven bijnaam.

NICK_SERVADMIN_HELP_LIST
	Syntax: LIST patroon [FORBIDDEN] [NOEXPIRE]
	
	Geeft een lijst van alle geregistreerde bijnamen in de vorm van:
	gebruiker@host  die overeenkomen met het gegeven patroon.
	Bijnamen met de PRIVATE optie aan worden alleen getoond aan
	Services Admins. Voor Services Admins worden bijnamen die op
	NOEXPIRE staan aangeduidt met een !. 
	
	Als de optie FORBIDDEN, NOEXPIRE gegeven is,
	worden alleen corresponderende bijnamen getoond. De
	opties kunnen gebruikt worden in elke volgorde of combinatie en zijn alleen
	Gebruik beperkt tot  Services admins.
	
	Examples:
	
	    LIST *!joeuser@foo.com
	        Geeft alle geregistreerde bijnamen die gebruikt worden door joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Geeft alle geregistreerde bijnamen met Bot in de naam (hoofd of kleine letters).
	
	    LIST * NOEXPIRE
	        Geeft alle geregistreerde bijnamen die op NOEXPIRE staan.

NICK_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS nickname
	
	Toont het wachtwoord van de gegeven bijnaam.  Let op dat
	elke keer wanneer iemand dit commando uitvoerd dit getoond
	wordt als WALLOPS/GLOBOPS, inclusief de bijnaam van degene
	die het commando uitvoerd.

	Gebruik beperkt tot  Services admins.
	
	Dit commando is niet beschikbaar wanneer er gebruik wordt gemaakt
	van een versleuteling.

NICK_SERVADMIN_HELP_FORBID
	Syntax: FORBID bijnaam
	
	Zorgt dat een bijnaam niet geregistreerd of gebruikt kan
	worden. Kan ongedaan worden gemaakt door het drop commando
	
	Gebruik beperkt tot Services admins.

###########################################################################
#
# ChanServ help messages
#
###########################################################################

CHAN_HELP
	%S Geeft u de mogelijkheid om kanalen te registreren en te
	beheren.  %S kan vaak voorkomen dat kwaadwillende gebruikers
	een kanaal "overnemen" door het aantal operators te limiteren.
	Typ /%S HELP COMMAND voor een lijst van commando's;
	om ze te gebruiken, typ /%S commando.  Voor meer informatie
	over een specifiek commando, typ /%S HELP commando.
	
	    REGISTER   Registreer een kanaal
	    IDENTIFY   Identificeer uzelf met uw wachtwoord
	    SET        Verander informatie en opties van een kanaal
	    ACCESS     Verander de algemene kanaal toegangslijst
	    AOP/SOP    Alias voor het veranderen van de algemene kanaal 
	               toegangslijst voor gebruikers met een privilege
	    LEVELS     Bewerk kanaal toegangsniveaus
	    AKICK      Muteer de AutoKick lijst
	    DROP       Maak de registratie van een kanaal ongedaan
	
	Overige commando's: INFO, LIST, INVITE, OP, DEOP, UNBAN,
	                    KICK, CLEAR, VOICE, DEVOICE

CHAN_HELP_EXPIRES
	
	Let op dat elk kanaal dat niet gebruikt wordt voor %d dagen 
	(niemand van de toegangslijst komt binnen) automatisch verloopt.

CHAN_HELP_REGISTER
	Syntax: REGISTER kanaal wachtwoord beschrijving
	
	Registreert een kanaal in de %S database.  Om dit
	commando te kunnen gebruiken dient u eerst operator status
	te hebben in van het kanaal dat u wilt registreren.
	Het wachtwoord wordt gebruikt met het IDENTIFY commando
	zodat u achteraf instellingen van het kanaal kunt veranderen.
	De laatste parameter, die gegeven moet worden, is een
	beschrijving van het doel van het kanaal.
	
	Wanneer u een kanaal registreerd, wordt u gezien als de
	eigenaar van het kanaal. De kanaal eigenaar kan alle
	instellingen van het kanaal veranderen; %S geeft de eigenaar
	ook autmatisch operator status wanneer hij/zij het kanaal
	binnenkomt.
	Zie het ACCESS commando (/%S HELP ACCESS) voor
	informatie over het geven van delen van deze rechten aan
	andere kanaal gebruikers.
	
	OPMERKING: Om een kanaal te registreren dient uw bijnaam
	geregistreerd te zijn. Wanneer u dit nog niet gedaan heeft
	kunt u via /%s HELP informatie hierover krijgen.

CHAN_HELP_IDENTIFY
	Syntax: IDENTIFY kanaal wachtwoord
	
	Identificeerd uzelf bij %S als de eigenaar van de gegeven
	kanaal.  Veel commando's kunnen pas uitgevoerd worden nadat
	u dit commando heeft gebruikt. Het wachtwoord is hetzelfde
	als dat u met het REGISTER commando gebruikt heeft.

CHAN_HELP_DROP
	Syntax: DROP kanaal
	
	Verwijdert het opgegeven kanaal.  Kan alleen gebruikt worden door de
	kanaal eigenaar, die eerst het IDENTIFY commando gebruikt
	heeft.

CHAN_HELP_SET
	Syntax: SET kanaal opties parameters
	
	Geeft de kanaal eigenaar de mogelijkheid om verschillende
	opties te veranderen. De eigenaar moet het IDENTIFY
	commando gebruiken voor het gebruik van SET.
	
	Beschikbare opties:
	
	    FOUNDER     Verandert de eigenaar van het kanaal
	    SUCCESSOR   Verandert de opvolger van het kanaal 
	    PASSWORD    Verandert het eigenaar wachtwoord
	    DESC        Verandert kanaal omschrijving
	    URL         Associeert een URL met het kanaal
	    EMAIL       Associeert een E-mail adres met het kanaal
	    ENTRYMSG    Stelt een welkomstboodschap in voor wie
	                   het kanaal binnenkomt
	    TOPIC       Verandert het onderwerp van het kanaal
	    KEEPTOPIC   Behoud het onderwerp wanneer het kanaal niet
	                   gebruikt wordt
	    TOPICLOCK   Onderwerp kan alleen veranderd worden met
	                   SET TOPIC
	    MLOCK       Zet een slot op bepaalde kanaal modes
	    PRIVATE     Verbergt kanaal voor het LIST commando
	    RESTRICTED  Beperkt toegang tot het kanaal
	    SECUREOPS   Strengere controle op operator status
	    LEAVEOPS    Operator status wordt niet afgenomen bij
	                   binnenkomst
	    OPNOTICE    Geeft een waarschuwing wanneer OP/DEOP
	                   commando's gebruikt worden
	    NOLINKS     Negeert toegangslijst herkenning voor 
	                   gekoppelde bijnamen.
	    TOPICENTRY  Gebruik kanaal topic voor welkomsboodschap
	
	Typ /%S HELP optie voor meer informatie over een
	bepaalde optie.

CHAN_HELP_SET_FOUNDER
	Syntax: SET kanaal FOUNDER bijnaam
	
	Verandert de eigenaar van een kanaal.  De nieuwe bijnaam moet
	een geregistreerde zijn.

CHAN_HELP_SET_SUCCESSOR
	Syntax: SET kanaal SUCCESSOR bijnaam
	
	Verandert de opvolger van het kanaal. Als de eigenaar
	bijnaam verloopt of verwijderd wordt als het kanaal nog is
	geregistreerd wordt de opvolger de nieuwe eigenaar van het
	kanaal.  Let op, als de opvolger al te vele kanalen op zijn
	naam heeft staan (%d), wordt het kanaal verwijderd, alsof
	er geen opvolger in was gesteld.

CHAN_HELP_SET_PASSWORD
	Syntax: SET kanaal PASSWORD wachtwoord
	
	Verandert het wachtwoord waarmee de eigenaar zich moet
	identificeren.

CHAN_HELP_SET_DESC
	Syntax: SET kanaal DESC beschrijving
	
	Verandert de beschrijving van het kanaal, die getoond wordt
	in de LIST en INFO commando's.

CHAN_HELP_SET_URL
	Syntax: SET kanaal URL [url]
	
	Associeert de gegeven url met het kanaal.  Dit url
	wordt getoond wanneer iemand informatie over het kanaal
	opvraagt met het INFO commando. Als er geen parameter
	wordt meegegeven, zal het huidige url verwijderd worden.

CHAN_HELP_SET_EMAIL
	Syntax: SET kanaal EMAIL [E-mail adres]
	
	Associeert het gegeven E-mail adres met het kanaal.  Dit
	adres wordt getoond wanneer iemand informatie over het
	kanaal opvraagt met het INFO commando. Als er geen 
	parameter wordt meegegeven, zal het huidige url verwijderd
	worden.

CHAN_HELP_SET_ENTRYMSG
	Syntax: SET kanaal ENTRYMSG [bericht]
	
	Verandert het bericht dat gebruikers via /notice krijgen
	als zij het kanaal binnenkomen. Als er geen parameter wordt 
	meegegeven, zal het huidige binnenkomst bericht verwijderd
	worden.

CHAN_HELP_SET_TOPIC
	Syntax: SET kanaal TOPIC onderwerp
	
	Dit laat %S het onderwerp van het kanaal veranderen
	als deze mee gegeven is. Dit commado is erg handig in
	samenwerking met SET TOPICLOCK.

CHAN_HELP_SET_KEEPTOPIC
	Syntax: SET kanaal KEEPTOPIC {ON | OFF}
	
	Schakelt de onderwerp behoud optie van het kanaal aan
	of uit.  Wanneer onderwerp behoud aan staat, onthoudt
	%S het onderwerp, zelfs nadat de laaste gebruiker het
	kanaal verlaat, en deze zal teruggezet worden wanneer er
	weer iemand binnenkomt.

CHAN_HELP_SET_TOPICLOCK
	Syntax: SET kanaal TOPICLOCK {ON | OFF}
	
	Schakelt de onderwerp slot optie van het kanaal aan
	of uit.  Wanneer onderwerp slot aan staat, zal
	%S niet toestaan dat het onderwerp van het kanaal veranderd
	wordt, anders dan met het SET TOPIC commando.

CHAN_HELP_SET_MLOCK
	Syntax: SET kanaal MLOCK modes
	
	Stelt de mode-slot optie van het kanaal in. %S kan ervoor
	zorgen dat bepaalde kanaal modes altijd aan of uit staan.
	Modes  die op slot gezet kunnen worden zijn bijv.
	n, s, t, k, l, enzovoort.
	Elke mode kan op altijd aan, altijd uit of buiten het slot
	worden gezet. De modes parameter werkt het als het
	/MODE commando; wat inhoud dat modes die volgen op een
	commando; wat inhoud dat modes die volgen op een + altijd
	aangezet worden en modes volgend op een - altijd uit.
	
	Waarschuwing: Wanneer u mode k in het slot plaatst,
	zoals in voorbeeld twee hieronder, dient u ook de
	RESTRICTED optie aan te zetten voor het kanaal (zie HELP
	SET RESTRICTED), anders kan een ieder die het kanaal
	binnenkomt als deze leeg is de sleutel zien!

	Voorbeelden:
	
	    SET #kanaal MLOCK +nt-iklps
	        Zet modes n en t aan, en modes i, k, l,p en s uit.
	        Andere modes zijn vrij om te veranderen.
	
	    SET #kanaal MLOCK +knst-ilmp mijn-sleutel
	        Zet modes k, n, s, en t aan, en modes i, l, m,
	        en p uit.  Tevens blijft de kanaalsleutel altijd
		op "mijn-sleutel" staan.

	    SET #kanaal MLOCK +
	        Verwijdert het mode slot; alle kanaalmodes zijn vrij
	        aan of uit te zetten.

CHAN_HELP_SET_PRIVATE
	Syntax: SET kanaal PRIVATE {ON | OFF}
	
	Zet de prive optie van het kanaal aan of uit.
	Wanneer prive aan staat zal het kanaal niet getoond worden
	in een /%S LIST.

CHAN_HELP_SET_RESTRICTED
	Syntax: SET kanaal RESTRICTED {ON | OFF}
	
	Zet de beperkte toegang optie van het kanaal aan of uit.
	Wanneer beperkte toegang aan staat worden gebruikers die
	niet op de toegangslijst staan, een negatieve toegang hebben
	of die normaal geen kanaal operator status mogen hebben
	uit het kanaal verwijderd en verbannen.

CHAN_HELP_SET_SECUREOPS
	Syntax: SET kanaal SECUREOPS {ON | OFF}
	
	Zet de operator beveiliging optie van het kanaal aan of uit.
	Wanneer operator beveiliging aan staat kunnen mensen die
	niet op de auto-op lijst staan geen operator status krijgen.

CHAN_HELP_SET_LEAVEOPS
	Syntax: SET kanaal LEAVEOPS {ON | OFF}
	
	Zet de operator behoud optie van het kanaal aan of uit.
	Wanneer operator behoud aan staat zal ChanServ de operator
	status van iemand die als eerste het kanaal binnen komt niet
	afnemen, behalve wanneer het DEOP commando wordt gebruikt

CHAN_HELP_SET_OPNOTICE
	Syntax: SET kanaal OPNOTICE {ON | OFF}
	
	Zet de operator opmerking optie van kanaal aan of uit.
	Wanneer operator opmerking aan staat, geeft ChanServ een 
	melding aan het kanaal wanneer de OP of DEOP, of 
	soortgelijke commando's gebruikt worden voor iemand in het kanaal.

CHAN_HELP_SET_NOLINKS
	Syntax: SET kanaal NOLINKS {ON | OFF}
	
	Zet de NOLINKS optie van kanaal aan of uit.
	Wanneer NOLINKS aan staat zal ChanServ alleen 
	de echte bijnaam herkennen die in de toegangslijst staat.
	Dit betekent dat een gekoppelde bijnaam er tussen staat
	deze niet herkend zal worden.

CHAN_HELP_SET_TOPICENTRY
	Syntax: SET kanaal TOPICENTRY {ON | OFF}
	
	Zet de TOPICENTRY optie van het kanaal aan of uit.
	Wanneer TOPICENTRY aan staat zal ChanServ de welkomsboodschap
	vervangen met het topic van het kanaal wanneer een gebruiker
	binnenkomt.        

CHAN_HELP_ACCESS
	Syntax: ACCESS kanaal ADD bijnaam level
	        ACCESS kanaal DEL {bijnaam | invoer-num | list | ALL }
	        ACCESS channel LIST [masker | list]
	
	Bewerkt de toegangslijst van het kanaal. De toegangslijst
	houdt bij welke gebruikers toegang hebben tot operator
	status en %S commando's op het kanaal.  Verschillende
	gebruiker levels geven de mogelijkheid toegang te geven tot
	verschillende onderdelen van rechten;  /%S HELP
	ACCESS LEVELS voor meer specifieke informatie.  Elke
	bijnaam die niet op de toegangslijst staat heeft level 0.
	
	Het ACCESS ADD commando voegt de gegeven bijnaam toe aan
	de toegangslijst met het gegeven toegangslevel; wanneer de
	bijnaam al op de lijst staat wordt het toegangslevel
	veranderd naar de gegeven waarde.  Het gegeven level dient
	lager te zijn dan dat van de gebruiker die het commando
	geeft, en als de bijnaam al op de toegangslijst staat
	dient zijn/haar level lager te zijn dan dat van de gebruiker
	die het commando geeft.
	
	Het ACCESS DEL commando verwijdert de gegeven bijnaam uit
	de toegangslijst.  Wanneer een lijst van invoer nummers
	wordt gegeven, worden deze verwijderd.  (Zie de voorbeelden
	van LIST hieronder.) Wanneer ALL wordt gebruikt zullen alle
	ingevoerde bijnamen verwijderd worden, dit is alleen
	beschikbaar voor de eigenaar.
	
	Het ACCESS LIST commando toont de toegangslijst.  Wanneer
	een masker gegeven wordt, worden alleen de invoeren volgens
	het masker getoond.  Wanneer een lijst van invoernummers
	gegeven wordt, worden alleen deze invoeren getoond.;
	bijvoorbeeld:
	
	   ACCESS #kanaal LIST 2-5,7-9
	      Geeft toegangslijst invoeren 2 tot en met 5 en
	      7 tot en met 9.

CHAN_HELP_ACCESS_LEVELS
	Gebruikers toegangslevels
	
	Standaard zijn de volgende toegangslevels gedefineerd:
	
	   Founder   Volledige toegang tot %S functies; automatische
	                     operator status bij binennkomst.  Let op
	                     dat slecht 1 gebruiker als eigenaar 
	                     ingesteld kan worden (het kan niet gegeven
	                     worden met het ACCESS commando).
	        10   Toegang tot AKICK commando; automatische 
	                     operator status.
	         5   Automatische operator status.
	         3   Automatische voice.
	         0   Geen speciale rechten; kan operator status
	                     krijgen van andere operators
	                     (behalve als operator beveiliging 
	                     aanstaat).
	        <0   Mag geen operator status krijgen.
	
	Deze levels kunnen veranderd worden, of worden aangevuld,
	met het LEVELS commando; typ /%S HELP LEVELS voor 
	informatie.

CHAN_HELP_AKICK
	Syntax: AKICK kanaal ADD masker [reden]
	        AKICK kanaal DEL [ masker | ALL ]
	        AKICK kanaal LIST [masker]
	
	Bewerkt de autokick lijst van het kanaal.  Wanneer een
	gebruiker op de autokick het kanaal probeert binnen te gaan
	zal %S de gebruiker van het kanaal verwijderen en verbannen.
	
	Het AKICK ADD commando voegt het gegeven gebruiker of masker
	toe aan de autokick lijst. Wanneer een rede wordt gegeven wordt
	gegeven wordt deze als kick-boodschap gebruikt;  zo niet, 
	de standaard reden is "You have been banned from the channel".
	
	Het AKICK DEL commando verwijdert het gegeven bijnaam of
	of masker de autokick lijst.  Het verwijdert echter geen 
	verbanning die door autokick zijn geplaatst; deze dienen 
	handmatig verwijderd te worden.
	
	Het AKICK LIST commando toont de autokick lijst, of
	of alleen de autokick invoeren met het gegeven masker.

CHAN_HELP_LEVELS
	Syntax: LEVELS kanaal SET type level
	        LEVELS kanaal {DIS | DISABLE} type
	        LEVELS kanaal LIST
	        LEVELS kanaal RESET
	
	Met het LEVELS commando kunnen de kanaal toegangslevels
	gebruikt door het ACCESS commando nauwkeurig bewerkt worden.
	Met dit commando kunt u de het vereisde toegangslevel voor de
	meeste van %S's functies bepalen. (De SET FOUNDER en
	SET PASSWORD commando's, deze commando's kunnen alleen door de
	kanaal eigenaar gebruikt worden.)
	
	LEVELS SET geeft de mogelijkheid om het toegangslevel voor
	een functie of groep van functies te veranderen.
	LEVELS DISABLE (of DIS in het kort) schakelt een
	automatische instelling uit of maakt een bepaalde functie
	alleen toegangkelijk tot de kanaal eigenaar.
	LEVELS LIST toont de huidige levels voor elke functie of
	groep van functies.  LEVELS RESET herstelt de levels naar
	de standaardwaarden voor een nieuw kanaal (zie HELP ACCESS
	LEVELS).
	
	Voor de lijst van functies waarvan levels veranderd kunnen
	worden, zie HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	De volgende functienamen zijn bekend. Let op dat de levels
	voor AUTODEOP en NOJOIN het maximum levels zijn, terwijl 
	andere het minimale level hebben.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Syntax: INFO kanaal
	
	Geeft informatie over het gegeven geregistreerde kanaal,
	inclusief eigenaar, tijd van registratie, laatst gebruikte
	tijd en mode-slot, als deze ingesteld is. 

CHAN_HELP_LIST
	Syntax: LIST patroon
	
	Geeft een lijst van alle geregistreerde kanalen volgens een
	bepaald patroon (kanalen waar de PRIVATE optie aan staat
	worden niet getoond.)

CHAN_HELP_OP
	Syntax: OP #kanaal bijnaam
	
	Geeft de gegeven gebruiker operator status op het kanaal.
	Standaard alleen beschikbaar voor gebruikers met
	toegangslevel 5 of hoger op het kanaal.

CHAN_HELP_DEOP
	Syntax: DEOP #kanaal bijnaam
	
	Verwijdert de operator status van de gegeven gebruiker op
	het kanaal.  Standaard alleen beschikbaar voor gebruikers met
	toegangslevel 5 of hoger op het kanaal.

CHAN_HELP_KICK
	Syntax: KICK #kanaal bijnaam reden
	
	Verwijderd een gebruiker van het kanaal met ChanServ. Standaard
	alleen beschikbaar voor gebruikers met toegangslevel 5 of hoger
	op het kanaal.

CHAN_HELP_INVITE
	Syntax: INVITE kanaal
	
	Zorgt dat %S u uitnodigt voor het gegeven kanaal.  Standaard
	alleen beschikbaar voor gebruikers met toegangslevel 0 of
	hoger op het kanaal.

CHAN_HELP_UNBAN
	Syntax: UNBAN kanaal
	
	Zorgt dat %S alle verbanningen van u verwijdert uit het
	gegeven kanaal. Standaard alleen beschikbaar voor gebruikers
	met toegangslevel 0 of hoger op het kanaal.

CHAN_HELP_CLEAR
	Syntax: CLEAR kanaal wat
	
	Zorgt dat %S een bepaald iets verwijdert van het gegeven  
	kanaal. what kan n van de volgende dingen zijn:
	
	     MODES    Verwijdert alle modes op het kanaal (zoals
	                  de modes i,k,l,m,n,p,s,t).
	     BANS     Verwijdert alle verbanningen op het kanaal.
	     OPS      Verwijdert operator status (mode +o) van
	                  alle gebruikers.
	     VOICES   Verwijdert "voice" status (mode +v) van
	                  alle gebruikers.
	     USERS    Verwijdert (kicks) alle gebruikers van het
	                  kanaal.
	
	Standaard alleen beschikbaar voor gebruikers met toegangslevel
	10 of hoger op het kanaal.

CHAN_SERVADMIN_HELP
	
	De volgende commando's zijn beschikbaar voor Services admins:
	
	    GETPASS    Verkrijg het eigenaar wachtwoord van een kanaal
	                   (alleen wanneer versleuteling uit staat)
	    FORBID     Voorkom dat een kanaal wordt geregistreerd/gebruikt
	    STATUS     Geeft de huidige toegangslevel van een gebruiker 
	                   weer op een kanaal
	
	Services Admins kunnen ook een kanaal verwijderen zonder gebruik
	van een wachtwoord, en zij kunnen de ACCESS, AKICK en LEVEL
	lijsten van elk kanaal bekijken.

CHAN_SERVADMIN_HELP_DROP
	Syntax: DROP kanaal
	
	Verwijdert het gegeven kanaal. Alleen Services admins
	kunnen een kanaal verwijderen waar zij zich niet voor
	geidentificeerd hebben.

CHAN_SERVADMIN_HELP_SET
	
	Services Admins kunnen ook de optie NOEXPIRE gebruiken,
	waarmee voorkomen kan worden kanalen vervallen. Ook
	kunnen Services Admins opties voor elke kanaal veranderen
	zonder wachtwoord identificatie voor het kanaal.

CHAN_SERVADMIN_HELP_SET_NOEXPIRE
	Syntax: SET kanaal NOEXPIRE {ON | OFF}
	
	Stelt in of het gegeven kanaal zal vervallen.  De optie ON
	voorkomt dat het kanaal verloopt.
	
	Gebruik beperkt tot Services admins.

CHAN_SERVADMIN_HELP_LIST
	Syntax: LIST patroon
	
	Geeft een lijst van alle geregistreerde kanalen volgens het
	gegeven patroon. Kanalen die de PRIVATE optie aan hebben
	staan worden alleen aan Services Admins getoond. 

CHAN_SERVADMIN_HELP_GETPASS
	Syntax: GETPASS kanaal

	Geeft het wachtwoord van een gegeven kanaal.  Let op dat
	wanneer dit commando gebruikt wordt er een bericht met onder
	andere de persoon die het commando gebruikt en het kanaal
	waarvoor het gebruikt werd opgeslagen wordt en verstuurd als
	WALLOPS/GLOBOPS.
	
	Wanneer encryptie aanstaat is dit commando mogelijk niet te
	gebruiken, afhankelijk van het gebruikte type encryptie.
	
	Gebruik beperkt tot Services admins.

CHAN_SERVADMIN_HELP_FORBID
	Syntax: FORBID kanaal
	
	Verbied iedereen een gegeven kanaal te gebruiken of
	registreren.  Kan ongedaan worden gemaakt door het kanaal
	te verwijderen.
	
	Gebruik beperkt tot Services admins.

CHAN_SERVADMIN_HELP_STATUS
	Syntax: STATUS kanaal bijnaam
	
	Geeft het huidige toegangslevel van de gegeven bijnaam op het
	gegeven kanaal.  Deze wordt getoond in de vorm::
	
	    STATUS kanaal bijnaam toegangslevel
	
	Wanneer een fout optreedt wordt de volgende melding getoond:
	
	    STATUS ERROR fout-bericht
	
	Gebruik beperkt tot Services admins.

###########################################################################
#
# MemoServ help messages
#
###########################################################################

MEMO_HELP
	%S geeft IRC gebruikers de mogelijkheid korte berichten
	naar andere gebruikers te sturen, of deze online zijn of
	niet, of naar kanalen(*).  Zowel de bijnaam van de verzender
	als die van de ontvangende persoon of kanaal dienen
	geregistreerd te zijn om deze Service te kunnen gebruiken.
	
	%S's commando's zijn:

	    SEND   Stuurt een memo naar een gebruiker of kanaal
	    LIST   Geeft een lijst van uw memo's
	    READ   Leest memo('s)
	    DEL    Verwijdert memo('s)
	    SET    Verandert opties met betrekking tot memo's
	    INFO   Informatie met betrekking tot de memo's
	
	Typ /%S HELP commando voor hulp voor de n van
	bovenstaande commando's.
	
	(*) Standaard kan een gebruiker met minimaal toegangslevel 10
	    op een kanaal de memo's van dat kanaal lezen. Dit kan 
	    veranderd worden door middel van het %s LEVELS commando.

MEMO_HELP_SEND
	Syntax: SEND {bijnaam | kanaal} memo-tekst
	
	Stuurt de gegeven bijnaam of kanaal een memo met daarin
	memo-tekst.  Wanneer u naar een bijnaam stuurt krijgt de
	ontvanger een melding van de nieuwe memo.  De ontvangende
	bijnaam/kanaal dient geregistreerd te zijn.
	
	Als er een ? voor het bericht wordt geplaatst ontvangt u 
	automatisch een memo wanneer uw memo gelezen is, de memo
	die wordt terug gestuurd staat tussen -( )-

MEMO_HELP_LIST
	Syntax: LIST [kanaal] [list | NEW]
	
	Geeft een lijst van memo's die u momenteel heeft.  Met NEW,
	worden alleen nieuwe (ongelezen) memo's getoond.  Ongelezen
	memo's worden aangegeven met een "*" aan de linkerkant van
	het nummer.  U kunt ook een lijst van nummers specificeren
	zoals in het voorbeeld hieronder:
	
	   LIST 2-5,7-9
	     Geeft een lijst van memo's 2 tot en met 5 en 7 tot
	     en met 9. 

MEMO_HELP_READ
	Syntax: READ [kanaal] {num | list | LAST | NEW}
	
	Toont u de tekst van de gegeven memo.  Wanneer LAST gegeven
	is wordt de laatst ontvangen memo getoond.  Wanneer NEW
	gegeven is worden alle ongelezen memo's getoond.  Anders
	wordt memo nummer num getoond.  U kunt ook een lijst van
	nummers geven, zoals bij het LIST commando.
	U kunt ook een lijst van nummers specificeren zoals in
	het voorbeeld hieronder:

	   READ 2-5,7-9
	      Geeft een lijst van memo's 2 tot en met 5 en 7 tot
	      en met 9.

MEMO_HELP_DEL
	Syntax: DEL [kanaal] {num | list | ALL}
	
	Verwijdert de gegeven memo('s).  U kunt meerdere memo
	nummers of reeksen geven in plaatst van een enkel nummer,
	zoals in onderstaand voorbeeld.
	
	Wanneer ALL is gegeven, worden al uw memo's verwijderd.
	
	Voorbeelden:
	
	   DEL 1
	      Verwijdert uw eerste memo.
	
	   DEL 2-5,7-9
	      Verwijdert memo's 2 tot en met 5 en 7 tot en met 9.

MEMO_HELP_SET
	Syntax: SET optie parameters
	
	Verandert verscheidene memo opties. optie kan zijn:
	
	    NOTIFY      Verandert wanneer u bericht krijgt van
	                    nieuwe memo's (alleen voor bijnamen)
	    LIMIT       Stelt het maximum aantal te ontvangen memo's
	                    in
	
	Typ /%S HELP SET optie voor meer informatie
	over een bepaalde optie.

MEMO_HELP_SET_NOTIFY
	Syntax: SET NOTIFY {ON | LOGON | NEW | OFF}
	
	Verandert wanneer u bericht krijgt van nieuwe memo's:
	
	    ON      U krijgt bericht van nieuwe memo's als u inlogged,
	               terugkomt van /AWAY en wanneer een memo naar
	               u verstuurd wordt.
	    LOGON   U krijgt bericht van nieuwe memo's als u inlogged,
	               en wanneer u terugkomt van /AWAY.
	    NEW     U krijgt bericht van nieuwe memo's wanneer deze
	               naar u verstuurd worden.
	    OFF     U krijgt geen bericht van nieuwe memo's.
	
	ON is gelijk aan LOGON en NEW samen.

MEMO_HELP_SET_LIMIT
	Syntax: SET LIMIT [kanaal] limit
	
	Stelt het maximum aantal memo's in dat u (of het gegeven
	kanaal) kunt ontvangen. Wanneer u deze optie op 0 zet kan
	niemand memo's naar u sturen.  Let op, u kunt deze optie
	niet hoger zetten dan %d.

MEMO_HELP_INFO
	Syntax: INFO [kanaal]
	
	Geeft informatie over het aantal memo's dat u heeft, hoeveel
	hiervan ongelezen zijn, hoeveel memo's u mag ontvangen en
	wanneer u bericht krijgt van nieuwe memo's. Met een
	parameter wordt dezelfde informatie getoond voor het gegeven
	kanaal.

MEMO_SERVADMIN_HELP_SET_LIMIT
	Syntax: SET LIMIT [gebruiker | kanaal] {limit | NONE} [HARD]
	
	Stelt het maximum aantal memo's in dat een gebruiker of
	kanaal mag hebben. De limiet op 0 zetten zorgt dat de
	gebruiker geen memo's kan ontvangen; de limiet op NONE
	zetten zorgt dat de gebruiker een onbeperkt aantal memo's mag
	hebben; Wanneer u geen bijnaam of kanaal geeft wordt uw eigen
	limiet veranderd.
	
	Toevoegen van HARD zorgt dat de gebruiker de limiet niet
	kan veranderen.  HARD niet toevoegen heeft het
	tegenovergestelde effect, de gebruiker kan nu zelf zijn
	limiet veranderen (ook al kon dat voorheen niet).
	
	Het gebruik van het SET LIMIT commando is beperkt tot
	Services admins.  Andere gebruikers kunnen alleen de
	limiet van zichzelf of kanaal waar zij de juiste rechten
	hebben veranderen, kunnen hun limiet niet verwijderen,
	kunnen hun limiet niet boven %d zetten en kunnen geen HARD
	limiet instellen.

MEMO_SERVADMIN_HELP_INFO
	Syntax: INFO [bijnaam | kanaal]
	
	Zonder parameter, geeft informatie over het aantal memo's
	dat u heeft, hoeveel er ongelezen zijn, hoeveel u er mag
	ontvangen en hoe u bericht krijgt van nieuwe memo's.
	
	Wanneer u een kanaal als parameter meegeeft, wordt dezelfde
	informatie getoond voor het gegeven kanaal.
	
	Wanneer u een bijnaam als parameter meegeeft, wordt dezelfde
	informatie getoond voor de gegeven bijnaam.	
	Gebruik beperkt tot Services admins.

###########################################################################
#
# OperServ help messages
#
###########################################################################

OPER_HELP
	%S commands:
	    GLOBAL      Stuur een bericht naar alle gebruikers
	    STATS       Toon status van het netwerk en Services
	    OPER LIST   Geef een lijst van alle Services Operators
	    ADMIN LIST  Geef een lijst van alle Services Admins
	
	Commando's beschikbaar voor Services Operators en Admins:
	    MODE        Verander de modes van een kanaal
	    KICK        Verwijder een gebruiker van een kanaal
	    AKILL       Bewerk de AKILL lijst
	    VLINE       Bewerk de VLINE lijst
	    SXLINE      Bewerk de SXLINE lijst
	    BOT         Bewerk de BOT lijst
	    SESSION     Sessie limiet info
	    CLEARMODES  Verwijder alle bestaande kanaalmodes
	    
	Commando's beschikbaar voor Services Admins:
	    SQLINE      Bewerk de SQLINE lijst
	    VLINK       Bewerk de VLINK lijst
	    OPER        Verander de Services Operator lijst
	    LOGONNEWS   Definieer berichten die bij het inloggen aan
	                  gebruikers worden getoond
	    OPERNEWS    Definieer berichten die bij een /OPER aan
	                  gebruikers worden getoond
	    JUPE        "Jupiter" een server
	    SET         Verander verscheidene Services opties
	    GETFOUNDER  Verkrijg kanaal eigenaar privileges
	    UPDATE      Dwing de Services databases direct te
	                  updaten naar harde schijf
	    QUIT        Sluit Services af zonder het opslaan van
	                  databases
	    SHUTDOWN    Sluit Services af met het opslaan van 
	                  databases
	    RESTART     Sla de databases op en herstart Services
	    REHASH      Lees de configuratie bestanden opnieuw in
	    SENDPASS    Stuur een bijnaam zijn wachtwoord via email
	    SECUREMODE  Zet het netwerk op SECUREMODE
	
	Commands available to the Services super-user only:
	    RAW         Stuur een regel naar de IRC Server
	    ADMIN       Bewerk de Services Admin lijst
	
	Let op: Alle commando's gestuurd naar %S worden bijgehouden!

OPER_HELP_GLOBAL
	Syntax: GLOBAL bericht
	
	Geeft IRCops de mogelijkheid berichten te sturen naar alle
	gebruikers op het netwerk.
	Het bericht wordt gestuurd vanuit de bijnaam %s.

OPER_HELP_STATS
	Syntax: STATS [RECORD | AKILL | ALL]
	
	Zonder optie, toont het huidige aantal gebruikers en IRCops
	online (exclusief Services), het hoogste aantal gebruikers
	online sinds Services gestart werd en de tijd die Services
	al draait.
	
	Met de AKILL optie toont het de grote van de AKILL lijst
	en de standaard verloop tijd.
	
	De ALL^B optie is alleen beschikbaar voor Services Admins en
	geeft informatie over Services' geheugen gebruik.  Gebruik
	van dit commando kan Services tijdelijk "bevriezen" op grote
	netwerken, dus gebruik dit commando met mate!
	
	De RECORD optie, toont alle records van het totaal aantal 
	gebruikers, opers, helpers en bots
	
	UPTIME kan gebruikt worden als synoniem voor STATS.

OPER_HELP_OPER
	Syntax: OPER ADD bijnaam
	        OPER DEL bijnaam
	        OPER LIST
	        OPER SUSPEND bijnaam dagen

	Geeft Services Admins de mogelijkheid bijnamen toe te voegen
	en te verwijderen uit de Services Operator lijst.  Een
	gebruiker wiens bijnaam op deze lijst staat en wie zich
	geindentificeerd heeft met %s krijgt toegang tot Services
	operator commando's.
	
	Elke IRC Operator kan het OPER LIST commando gebruiken.
	Alle andere functies zijn beperkt tot Services Admins.

OPER_HELP_ADMIN
	Syntax: ADMIN ADD bijnaam
	        ADMIN DEL bijnaam
	        ADMIN LIST
	
	Geeft de Services Super-Gebruiker de mogelijkheid bijnamen
	toe te voegen en te verwijderen uit de Services Admins lijst.
	Een gebruiker wiens bijnaam op deze lijst staat en wie zich
	geindentificeerd heeft met %s krijgt toegang tot Services
	Admin commando's.
	
	Elke IRC Operator kan het ADMIN LIST commando gebruiken.
	Alle andere functies zijn beperkt tot Services Root.

OPER_HELP_MODE
	Syntax: MODE kanaal modes
	
	Geeft Services Operators de mogelijkheid modes te veranderen
	op elk kanaal.  Parameters zijn hetzelfde als bij het
	normale /MODE commando.
	
	Gebruik beperkt tot Services operators.

OPER_HELP_CLEARMODES
	Syntax: CLEARMODES kanaal [ALL]
	
	Verwijdert alle binaire modes (n,s,t,k,l,enzovoort) en
	verbanningen van het kanaal. Wanneer ALL gegeven is worden
	ook gebruiker modes (zoals +o en +v) verwijderd van het kanaal.
	
	Gebruik beperkt tot Services operators.

OPER_HELP_KICK
	Syntax: KICK kanaal gebruiker reden
	
	Geeft IRCops de mogelijkheid gebruikers van elk
	kanaal te verwijderen. Parameters zijn hetzelfde als bij het
	normale /KICK commando. De kick-boodschap bevat de bijnaam
	van de IRCop die het commando uitvoerd; bijvoorbeeld:
	
	*** SpamMan has been kicked off channel #my_channel by %S (Alcan (Flood))
	
	Gebruik beperkt tot Services operators.

OPER_HELP_AKILL
	Syntax: AKILL ADD [+verlooptijd] masker reden
	        AKILL DEL masker
	        AKILL LIST [masker]
	        AKILL VIEW [masker]
	
	Geeft Services Operators de mogelijkheid de AKILL lijst te
	bewerken.  Wanneer een gebruiker die in deze lijst staat op
	de server probeert in te loggen zal Services deze autmatisch
	verwijderen en, op ondersteunde servers een verbanning
	(K-line) op alle servers toevoegen voor het betreffende
	masker.
	
	AKILL ADD voegt het gegeven user@host masker aan de AKILL
	lijst toe met de gegeven reden (die gegeven moet worden).
	AKILL DEL verwijdert het gegeven masker van de AKILL lijst
	als deze hierop staat.  AKILL LIST toont alle huidige
	AKILLs; wanneer een optioneel masker gegeven is, worden
	alleen de AKILLs volgens het masker getoond. AKILL VIEW is
	een gedetaileerde versie van AKILL LIST, en toont wie een
	AKILL toevoegde, op welke datum, en wanneer deze verloopt,
	tezamen met het user@host masker en de reden.
	
	Optioneel kan er een verlooptijd gegeven worden met het
	AKILL ADD commando.  De verlooptijd gaat vooraf aan het
	user@host masker en wordt geschreven als een nummer gevolgd
	door d (dagen), h (uren), of m (minuten).  Combinaties
	(zoals 1h30m) zijn ook toegestaan.  Wanneer geen eenheid
	gegeven wordt, is de standaardwaarde dagen (dus +30 betekend
	30 dagen).  Om een AKILL in te voeren die niet verloopt gebruikt
	u +0.  Wanneer het masker dat ingevoerd dient te worden start
	met een +, is een verlooptijd verplicht, ook al is deze hetzelfde
	als de standaardwaarde. Deze standaard verlooptijd is te vinden met 
	met STATS AKILL commando.
	
	De reden is alleen bedoelt voor IRC operators, en wordt niet
	getoond in het KILL bericht van de gebruikers.
	
	Gebruik beperkt tot Services operators.

OPER_HELP_SET
	Syntax: SET optie instelling

	Verandert verschillende Services opties.  Opties zijn
	momenteel:
	    READONLY   Zet Services in alleen-lezen of lees-schrijf
	                    modus
	    DEBUG      Activeert of deactiveerd debug modus
	
	Gebruik beperkt tot Services admins.

OPER_HELP_SET_READONLY
	Syntax: SET READONLY {ON | OFF}

	Zet alleen-lezen modus on (aan) of off (uit).  In alleen-
	lezen modus kunnen normale gebruiekrs niks in Services
	veranderen, inclusief kanaal en bijnaam toegangslijsten e.d.
	IRCops met voldoende Services rechten hebben de
	mogelijkheid de AKILL lijst te bewerken en bijnamen te
	verwijderen en te verbieden, maar deze veranderingen worden
	niet opgeslagen als Services niet uit alleen-lezen modus
	gehaald wordt voordat deze uitgezet of geherstart wordt.
	
	Deze optie is gelijk aan de commando-lijn optie -readonly.

OPER_HELP_SET_DEBUG
	Syntax: SET DEBUG {ON | OFF | num}

	Zet debug-modus on (aan) of off (uit).  In debug-modus
	worden alle commando's gestuurd naar Services en enkele
	andere foutcontrole berichten naar het logbestand geschreven.
	Wanneer num is gegeven wordt debug-modus geactiveerd met
	het foutcontrole nummer num.
	
	Deze optie is gelijk aan de commando-lijn optie ^B-debug^B.

OPER_HELP_JUPE
	Syntax: JUPE server [reden]
	
	Zorgt dat Services een server "jupiter" maakt, wat inhoud
	dat een nepserver aan Services gekoppeld wordt, zodat de
	echte server met deze naam niet aan het netwerk kan
	koppelen.  De "jupe" kan verwijderd worden met het SQUIT
	commando.  Wanneer een rede is gegeven wordt deze in de
	server informatie regel geplaatst; zoniet komt in deze regel
	de tekst "Jupitered by <bijnaam>", waarbij <bijnaam> de bijnaam
	is van degene die het jupe commando gaf.
	
	Gebruik beperkt tot Services admins.

OPER_HELP_RAW
	Syntax: RAW tekst
	
	Stuurt een regel tekst direct naar de IRC server waaraan
	Services verbonden is.  Dit commando heeft een beperkt
	aantal functies, en kan een netwerk ernstig verstoren of
	Services laten vastlopen bij foutief gebruik. GEBRUIK
	DIT COMMANDO NIET tenzij u absoluut zeker weet wat u doet!
	
	Gebruik beperkt tot Services admins.

OPER_HELP_UPDATE
	Syntax: UPDATE
	
	Zorgt dat Services alle database bestanden direct update.
	
	Gebruik beperkt tot Services admins.

OPER_HELP_QUIT
	Syntax: QUIT

	Zorgt dat Services onmiddelijk afsluit; databases worden
	niet opgeslagen.  Dit commando dient niet gebruikt worden
	tenzij er mogelijk schade is aan de kopien van de databases
	in het geheugen en deze niet opgeslagen dienen te worden.
	Om normaal af te sluiten dient u het SHUTDOWN commando
	te gebruiken.
	
	Gebruik beperkt tot Services admins.

OPER_HELP_SHUTDOWN
	Syntax: SHUTDOWN
	
	Zorgt dat Services alle databases opslaat en vervolgens
	afsluit.
	
	Gebruik beperkt tot Services admins.

OPER_HELP_RESTART
	Syntax: RESTART

	Zorgt dat Services alle databases opslaat en vervolgens
	opnieuw opstart (afsluit en meteen weer start).
	
	Gebruik beperkt tot Services admins.

OPER_HELP_REHASH
	Syntax: REHASH
	
	Zorgt ervoor dat de services.conf wordt herladen.	
	NOTITIE: String parameters worden niet veranderd 
	Om zo de services optimaal te laten werken.
	
	Gebruik beperkt tot Services admins.

OPER_REHASH_DONE
	Services configuratie is herladen.
OPER_REHASH_ERROR
	Een fout is opgetreden tijdens het herladen van de services 
	configuratie.
CHAN_LEVEL_PROTECT
	Beschermd een gebruiker zodat hij niet verwijderd kan worden van een 
	kanaal of zijnoperator status afgenomen kan worden.
NICK_AUTORECON
	Laatste toegangs herkenning.
NICK_HELP_SET_AUTOJOIN
	Syntax: SET AUTOJOIN {ON | OFF}

	Schakelt autojoin voor kanalen aan/uit.
	Wanneer dit aan staat zal %S er voor zorgen dat u alle kanalen binnen 
	gaat die in uw AJOIN LIST staan bij het identificeren.
NICK_SET_AUTOJOIN_ON
	AutoJoin staat nu On (aan)
NICK_SET_AUTOJOIN_OFF
	AutoJoin staat nu Off (uit)
NICK_SET_AUTOJOIN_SYNTAX
	Syntax: SET AUTOJOIN {ON | OFF}
NICK_HELP_AJOIN
	Syntax: AJOIN { ADD | DEL | LIST } [#kanaal]
	
	Geeft de Auto Join list van uw bijnaam, deze lijst kunt u
	ook bijwerken.
	Dit is de lijst van kanalen die u binnen gaat bij het identificeren
	als AUTOJOIN is ingeschakeld.
	
	Met /%S AJOIN NOW op elk gewenste tijdstip betreed u alle kanalen
	van uw ajoin list.
NICK_AJOIN_LIST_X
	Auto Join lijst van %s is :
NICK_AJOIN_SYNTAX
	Syntax: AJOIN { ADD | DEL | LIST } [#kanaal]
NICK_AJOIN_REACHED_LIMIT
	Sorry, de capaciteit van de lijst is %d kanalen.
NICK_AJOIN_ALREADY_PRESENT
	Kanaal staat al op de lijst.
NICK_AJOIN_ADDED
	Kanaal %s toegevoegd aan uw lijst.
NICK_AJOIN_NOT_FOUND
	Kanaal %s is niet gevonden op uw lijst.
NICK_AJOIN_DELETED
	kanaal %s verwijderd van uw lijst.
NICK_AJOIN_LIST
	Auto Join lijst:
NICK_INFO_OPT_AUTOJOIN
	Auto Join
BAD_CHAN_NAME
	Kanaal moet in formaat van: #Kanaal
OPER_IDENTIFY_REQUIRED
	Beveiliging regels zorgen er voor dat oper alleen
	werkt met geidentificeerde en OperServ geregistreerde
	bijnamen. 
	Voor meer informatie neem contact op met de IRC Admin
NICK_ALREADY_IDENTIFIED
	Deze bijnaam is al geidentificeert
TODAYSTATS
	Statistieken van vandaag (%s):
	
STATS_TOTAL
	Totaal: %d
STATS_REGISTERED
	Geregistreerd: %d
STATS_DROPPED
	Dropped: %d
STATS_EXPIRED
	Expired: %d
STATS_BALANCE
	Balance: %s
OPER_HELP_BOTLIST
	Syntax: 
	     BOT ADD hostnaam maxcon reden
	     BOT DEL  hostnaam
	     BOT LIST [masker]
	     BOT VIEW [masker]
	
	Bied Services operators de mogelijkheid de BOT lijst te
	manipuleren. Als een gebruiker de clone protectie activeert
	maar zijn/haar hostnaam staat in de BOT lijst, wordt deze 
	gebruiker niet gekilled.	
OPER_TOO_MANY_BOTLIST
	Sorry, BOT lijst is vol.
OPER_BOTLIST_NO_NICK
	U kunt alleen volledige hostnamen gebruiken op de BOT lijst.
OPER_BOTLIST_ADDED
	Nieuwe botlijst invoer toegevoegd voor %s
OPER_BOTLIST_ADD_SYNTAX
	BOT ADD hostnaam maxcon reden
OPER_BOTLIST_DEL_SYNTAX
	BOT DEL hostnaam reden
BOTLIST_REMOVED
	%s verwijderd van de botlijst
OPER_BOTLIST_NOT_FOUND
	Hostnaam %s is niet gevonden op de botlijst
OPER_BOTLIST_HEADER
	Huidige BotLijst:
# mask, reason	
OPER_BOTLIST_FORMAT
	%-32s %d : %s
#mask, set-by, set-time, reason
OPER_BOTLIST_VIEW_FORMAT
	%s (by %s at %s)
	   %s
OPER_BOTLIST_SYNTAX
	BOT {ADD | DEL | LIST | VIEW} hostnaam [maxcon reason]
CHAN_INFO_SUCCESSOR
	                Opvolger: %s (%s)
CHAN_INFO_NO_SUCCESSOR
	                Opvolger: %s
NICK_SHOULD_REGISTER
	Deze bijnaam is niet geregistreerd, als u van plan bent deze bijnaam
	in de toekomst te gebruiken registreer de bijnaam  met 
	/%s REGISTER password email.
	Als u geen email account heeft gebruik dan NOMAIL als email adres.
CHANGE_IN_1_MINUTE
	Als u uw bijnaam niet binnen 1 minuut verandert, wordt deze veranderd.
NICK_AJOIN_EMPTY
	AutoJoin lijst is leeg
FEATURE_DISABLED
	Functie is niet beschikbaar op deze server.
CHAN_ACCESS_LIST_FORMAT2
	  %3d  %4d  %s%s%s%s door %s
NICK_AUTORECON_R
	Auto bijnaam herkenning op +r mode.
NICK_STATUS_0
	STATUS voor %s : 0 - Gebruiker niet online of bijnaam niet geregistreerd
NICK_STATUS_1
	STATUS voor %s : 1 - Gebruiker niet herkend als eigenaar van de bijnaam 
NICK_STATUS_2
	STATUS voor %s : 2 - Gebruiker herkend als eigenaar van de bijnaam via identificatie
NICK_STATUS_3
	STATUS voor %s : 3 - Gebruiker herkend als eigenaar van de bijnaam via wachtwoord idenificatie
OPER_HELP_SQLINE
	Syntax: SQLINE ADD bijnaam reden
	        SQLINE DEL  bijnaam
	        SQLINE LIST [masker]
	        SQLINE VIEW [masker]
	
	Bied Services Administrators de mogelijkheid de BOT lijst te
	manipuleren.
	Een bijnaam die SQLINEd is, kan niet op het netwerk worden gebruikt.
OPER_TOO_MANY_SQLINE
	Sorry, SQLINE lijst is vol.
OPER_SQLINE_JUST_NICK
	U kunt gebruik maken van bijnaam/jokers op de SQLINE lijst.
OPER_SQLINE_ADDED
	Nieuwe SQLINE toegevoegd voor %s
OPER_SQLINE_ADD_SYNTAX
	SQLINE ADD bijnaam reden
OPER_SQLINE_DEL_SYNTAX
	SQLINE DEL bijnaam reden
OPER_SQLINE_REMOVED
	%s verwijderd van de sqline lijst.
OPER_SQLINE_NOT_FOUND
	SQLINE voor %s neit gevonden op de sqline lijst.
OPER_SQLINE_HEADER
	Huidige SQLINE Lijst:
# mask, reason	
OPER_SQLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_SQLINE_VIEW_FORMAT
	%s (door %s op %s)
	   %s
OPER_SQLINE_SYNTAX
	SQLINE {ADD | DEL | LIST | VIEW} bijnaam [reden]
BAD_EMAIL_ADDRESS
	Fout E-mail adres!
	Gebruik gebruiker@mailserver of NOMAIL als E-mail adres.
BAD_ICQNUMBER
	Verkeerd ICQ nummer!
	Gebruik #icqnummer 
BAD_LOCATION
	Geen locatie
	Geef een kortere versie van uw locatie op
CHAN_DROP_AT
	Kanaal registratie wordt ongedaan gemaakt in %d dag(en).
CHAN_DROP_CANCEL
	Kanaal registratie ongedaan maken op %s is afgebroken.
NICK_DROP_AT
	Bijnaam registratie wordt ongedaan gemaakt in %d dag(en).
NICK_DROP_CANCEL
	Bijnaam registratie ongedaan maken op %s is afgebroken.
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
	%S bied u de mogelijkheid online nieuws te lezen 
	geselecteerd op inschrijving.
	U kunt verschillende  commando's gebruiken door
	in te typen /%S commando.
	Voor meer informatie over een specifiek commando, typ
	/%S HELP commando.
	
	    LIST         Een lijst van beschikbare onderwerpen and inschrijvingen
	    SUBSCRIBE    Inschrijven voor een onderwerp
	    UNSUBSCRIBE  Uitschrijven voor een onderwerp
	    SET          Verander SET opties
	    RECENT       Lijst van meest recent afgeleverde nieuws 
NEWSS_HELP_OPER
	
	Nieuws Operator Commando's:
	    SEND         Send a news message
	    VIEW         Lijst van recent nieuws met gedetaileerde info
	    DEL          Verwijder een invoer van recent afgeleverde nieuws
	    OPER LIST    Lijst van nieuws operators
	    ADMIN LIST   Lijst van nieuws admins
NEWSS_HELP_ADMIN
	
	Nieuws Administrator Commando's:
	    SUBJECT      Verander Onderwerp lijst
	    OPER         Voegtoe/Verwijder nieuws operators
NEWSS_HELP_SADMIN
	
	Services Administrator Command:
	    ADMIN        Voegtoe/Verwijder nieuws admins
NEWSS_OPER_SYNTAX
	OPER {ADD | DEL | LIST} [bijnaam]
NEWSS_OPER_ADD_SYNTAX
	OPER ADD bijnaam
NEWSS_OPER_DEL_SYNTAX
	OPER DEL bijnaam
NEWSS_OPER_SKELETON
	Services in skelet mode; het OPER commando is tijdelijk uitgeschakeld.	
NEWSS_OPER_EXISTS
	%s bestaat al in Nieuws operator lijst.
NEWSS_OPER_ADDED
	%s toegevoegd aan Nieuws operator lijst.
NEWSS_OPER_TOO_MANY
	Te veel invoeren (%d) in de Nieuws operator lijst; kan niet meer toevoegen.
NEWSS_OPER_REMOVED
	%s verwijderd van Nieuws operator lijst.
NEWSS_OPER_NOT_FOUND
	%s niet gevonden op de Nieuws operator lijst.
NEWSS_OPER_LIST_HEADER
	Nieuws operator lijst:
	
NEWSS_OPER_HELP
	Syntax: OPER ADD bijnaam
	        OPER DEL bijnaam
	        OPER LIST
	
	Bied de Nieuws admin de mogelijkheid bijnamen toe te voegen
	of te verwijderen van de Nieuws operator lijst. Een bijnaam die
	geidentificeert is bij %s en in de Nieuws operator lijst staat is 
	in staat de Nieuws operator commando's te gebruiken.
	
	Elke Nieuws operator mag de OPER LIST vorm van het commando gebruiken.
	Al het andere is voor behouden aan de Nieuws admins.

# News Server ADMIN responses
NEWSS_ADMIN_SYNTAX
	ADMIN {ADD | DEL | LIST} [bijnaam]
NEWSS_ADMIN_ADD_SYNTAX
	ADMIN ADD bijnaam
NEWSS_ADMIN_DEL_SYNTAX
	ADMIN DEL bijnaam
NEWSS_ADMIN_SKELETON
	Services in skelet mode; het ADMIN commando is tijdelijk uitgeschakeld.
NEWSS_ADMIN_EXISTS
	%s bestaat al in Nieuws admin lijst.
NEWSS_ADMIN_ADDED
	%s toegevoegd aan Nieuws admin lijst.
NEWSS_ADMIN_TOO_MANY
	Te veel invoeren (%d) in de Nieuws admin lijst; kan niet meer toevoegen.
NEWSS_ADMIN_REMOVED
	%s verwijderd van Nieuws admin lijst.
NEWSS_ADMIN_NOT_FOUND
	%s niet gevonden op de Nieuws admin lijst.
NEWSS_ADMIN_LIST_HEADER
	Nieuws admin lijst:
	
NEWSS_SUBJECT_HELP
	Toegestaan tot het veranderen/aanmaken van onderwerpen 
	op de %S onderwerpen lijst.

	Syntax: SUBJECT nummer onderwerp
NEWSS_SUBJECT_SYNTAX
	SUBJECT nummer onderwerp
NEWSS_SUBJECT_ERROR
	Nummer moet tussen de 1 en %d liggen.
NEWSS_LIST_HELP
	Het LIST commando geeft een lijst van de 
	beschikbare onderwerpen en of er op ingeschreven is 
	Als de gemarkeert zijn met een X is er op ingeschreven.
	Voor inschrijven/uitschrijven gebruik de commando's: 
	    SUBSCRIBE UNSUBSCRIBE

NEWSS_LIST_HEADER
	Nr Inschr. Onderwerp
	
NEWSS_LIST
	%2d  %c   %s
NEWSS_LIST_END
	Einde dan onderwerp lijst
NEWSS_SUBJECT_NOTFOUND
	Het onderwerp nummer %d bestaat niet!
NEWSS_SUBJECT_CHANGED
	Onderwerp veranderd van %s naar %s.
NEWSS_SUBJECT_CREATED
	Onderwerp %s aangemaakt.
NEWSS_SUBSCRIBE_SYNTAX
	SUBSCRIBE  nummer [,nummer] | ALL
NEWSS_SUBSCRIBE_HELP
	Met dit commando kunt u zich inschrijven op een nieuws onderwerp.
	
	Syntax: SUBSCRIBE  nummer [,nummer] | ALL
	
	Het is mogelijk om op meerdere onderwerpen in te schrijven
	met 1 commando, door een komma tussen de getallen te plaatsen.
NEWSS_SUBSCRIBE_SUBSCRIBED
	U bent ingeschreven op %d onderwerp(en).
NEWSS_UNSUBSCRIBE_SYNTAX
	UNSUBSCRIBE  nummer [,nummer] | ALL
NEWSS_UNSUBSCRIBE_HELP
	Met dit commando kunt u zich uitschrijven op een nieuws onderwerp.
	
	Syntax: UNSUBSCRIBE  nummer [,nummer] | ALL
	
	Het is mogelijk om op meerdere onderwerpen uit te schrijven
	met 1 commado, door een komma tussend e getallen te plaatsen.
NEWSS_UNSUBSCRIBE_UNSUBSCRIBED
	U bent uitgeschreven op %d onderwerp(en).
NEWSS_SEND_SYNTAX
	SEND nummer nieuws bericht
NEWSS_SEND_HELP
	Stelt de Nieuws oper/admin instaat een nieuw bericht te sturen.
	
	Syntax: SEND  nummer nieuws bericht
NEWSS_SEND_SENT
	Nieuws is verstuurd.
NEWSS_SET_SYNTAX
	SET optie parameters
NEWSS_SET_HELP
	Syntax: SET optie parameters
	
	Veranderd verschillende %S opties. optie kan 1 van de
	volgende zijn:
	    NOTICE    Het nieuws ontvangen via notice/msg.
NEWSS_SET_NOTICE_SYNTAX
	SET NOTICE [ON | OFF]
NEWSS_SET_NOTICE_HELP
	Syntax: SET NOTICE [ON | OFF]
	Indien NOTICE aanstaat ontvangt u het nieuws via notices,
	indien het uitstaat, zal het nieuws naar u verzonden worden 
	via een prive bericht.  
NEWSS_SET_NOTICE_ON
	NOTICE optie staat nuw ON (aan)
NEWSS_SET_NOTICE_OFF
	NOTICE option staat nu OFF (uit)
NEWSS_RECENT_HELP
	Syntax: RECENT
	
	Lijst van het meest recente nieuws.
NEWSS_RECENT_HEADER
	Meest recente nieuws lijst
NEWSS_RECENT_LIST
	%s : %s
NEWSS_RECENT_END
	Einde van meest recente nieuws lijst.
NEWSS_VIEW_HELP
	Syntax: VIEW
	
	lijst van het meest recente nieuws met gedetaileerde
	informatie,
	onderwerp 0 vertegenwoordigt verwijderde items.
NEWSS_VIEW_HEADER
	Nr. : Ingeschr. : Tijd : nieuws (sender)
NEWSS_VIEW_LIST
	%s%2d : %2d   : %s : %s (%s)%s
NEWSS_DEL_SYNTAX
	DEL nummer
NEWSS_DEL_HELP
	Syntax: DEL nummer

	Dit commando verwijderd een invoer van de recente nieuws
	lijst, nummer is het nummer van van het nieuws dat
	in de eerste kolom van /%S VIEW staat.
	Een verwijderde invoer wordt niet getoond op de
	/%S RECENT lijst maar wordt wel getoond op de
	/%S VIEW als verwijderd
NEWSS_DEL_NOTEXIST
	 Nieuws nummer %d bestaat niet.
NEWSS_DEL_DELETED
	Nieuws nummer %d is verwijderd.
NICK_INFO_PRIVATE
	 Bijnaam informatie voor %s is prive.
CHAN_INFO_PRIVATE
	 Kanaal informatie voor %s is prive.
CHAN_NEED_REGNICK
	 U heeft een geregistreede bijnaam nodig om dit kanaal te betreden!
CHAN_MODE_PROTECTED
	Dit kanaal gebruikt join protectie modes.
NEWS_REC_PLEASE_WAIT
	Wacht alstublieft %d seconden voor u het RECENTE commando weer gebruikt.
NICK_HELP_NOTES
	Bied u de mogelijkheid tekst notities op te slaan.
	Om een notitie op te slaan typ /%S NOTES ADD tekst
	Om een notitie te verwijderen typ /%S NOTES DEL nummer
	Voor een lijst van alle notities typ /%S NOTES LIST
NICK_NOTES_SYNTAX
	LIST | ADD text | DEL nummer
NICK_NOTES_ADDED
	Notitie is opgeslagen onder nummer %d.
NICK_NOTES_NOADD
	U heeft een maximum aantal notitie nummers (%d) voor uw bijnaam,
	verwijder een aantal oude notities voor u nieuwe toevoegd. 
NICK_NOTES_DELETED
	Notitie nummer %d verwijderd.
NICK_NOTES_NOTFOUND
	Notitie nummer %d niet gevonden.
NICK_NOTES_LIST_HEADER
	Nr  Notitie
NICK_NOTES_LIST
	%2d %s
NICK_NOTES_NONOTES
	Notitie lijst is leeg.
CHAN_ACCESS_CLEARALL
	Toegangslijst is nu empty.
CHAN_AKICK_CLEARALL
	AKICK lijst is nu empty.
NICK_STATUS_SYNTAX
	STATUS bijnaam
NICK_X_ISFOUNDER
	Bijnaam %s is de eigenaar en kan niet gezet worden als opvolger.
NICK_X_ISSUCCESSOR
	Bijnaam %s is de kanaal opvolger en kan niet gezet worden als eigenaar.

# SESSION responses
OPER_SESSION_SYNTAX
	SESSION {LIST limiet | VIEW hostnaam | TRACE hostnaam }
OPER_SESSION_LIST_SYNTAX
	SESSION LIST limiet
OPER_SESSION_VIEW_SYNTAX
	SESSION VIEW host
OPER_SESSION_DISABLED
	Sessie limitering is uitgeschakeld.
OPER_SESSION_INVALID_THRESHOLD
	Niet correcte drempel waarde. Het moet een geldige integer zijn, groter dan 1.
OPER_SESSION_NOT_FOUND
	%s niet gevonden op de sessie lijst.
OPER_SESSION_LIST_HEADER
	Hosts met op ze minst %d sessies:
OPER_SESSION_LIST_COLHEAD
	Sessies  Host
# limit, host
OPER_SESSION_LIST_FORMAT
	%6d    %s
# host, sessions, limit
OPER_SESSION_VIEW_FORMAT
	De host %s heeft momenteel %d sessies met een limiet van %d.
OPER_SESSION_EXCEEDED
	Network beveiliging laat niet geen connecties meer toe vanaf uw host.
OPER_HELP_SESSION
	Syntax: SESSION LIST drempel waarde
	        SESSION VIEW host
	        SESSION TRACE host
	
	Bied Services operators de mogelijkheid de sessie lijst
	te bekijken.
	
	SESSION LIST lijsts van hosts met op ze minst drempel waarde 
	sessies.
	De drempel waarde moet groter zijn dan 1. Dit is om
	per ongeluk verkeerd gebruik te voorkomen dat er geen 
	lange lijsten van enkele sessie hosts worden weer gegeven.
	
	SESSION VIEW geeft gedetaileerde informatie weer over een specifieke
	host - Met het huidige sessie aamtal en sessie limiet.
	De host waarde mag geen jokers bevatten.
	
	SESSION TRACE Geeft een lijst weer met alle gebruikers ingelogd vanaf de opgegeven host 
	De host waarde mag geen jokers bevatten.
OPER_HELP_VLINE
	Syntax: VLINE ADD {bestand | !woord} reden
	        VLINE DEL  {bestand | !woord}
	        VLINE LIST [patroon]
	        VLINE VIEW [patroon]
	
	Bied Services operators de mogelijkheid de VLINE lijst te
	manipuleren.
	V-Lined bestands patronen zullen de DCC SENDs blokkeren en de verstuurder
	op de umode +v zetten zodat hij/zij geen DCC SEND meer kan doen.
	Indien er een woord toegevoegd is aan de VLINE lijst is het niet mogelijk 
	dit in een zin te gebruiken, deze zin zal geblokkeerd worden.
OPER_TOO_MANY_VLINE
	Sorry, VLINE lijst is vol.
OPER_VLINE_JUST_NICK
	U kunt alleen bestand/jokers of !woorden gebruiken op VLINE lijst.
OPER_VLINE_ADDED
	Nieuwe VLINE toegevoegd voor %s
OPER_VLINE_ADD_SYNTAX
	VLINE ADD {bestand | !woord} reden
OPER_VLINE_DEL_SYNTAX
	VLINE DEL {bestand | !woord} reden
OPER_VLINE_REMOVED
	VLINE %s verwijderd van de V-Line lijst
OPER_VLINE_NOT_FOUND
	%s niet gevonden op de VLINE lijst.
OPER_VLINE_HEADER
	Huidige VLINE Lijst:
# mask, reason	
OPER_VLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_VLINE_VIEW_FORMAT
	%s (door %s op %s)
	   %s
OPER_VLINE_SYNTAX
	VLINE {ADD | DEL | LIST | VIEW} {bestandsnaam | !woord} [reden]
OPER_SESSION_TRACE_SYNTAX
	TRACE host
OPER_SESSION_TRACE_BEGIN
	Weergegeven sessie voor %s:
OPER_SESSION_TRACE_FORMAT
	    %s
OPER_SESSION_TRACE_END
	Einde van sessie lijst
AGO_TIME_D
	%d dag(en), %d uur, %d minu(u)t(en) and %d seconde(n) ago.
AGO_TIME
	%d uur, %d minute(s) and %d second(s) ago.
TOTAL_TIME
	%d dag(en), %d uur, %d minu(u)t(en) and %d seconde(n).
OPER_OPER_SUSPENDED
	Oper %s is buiten werking voor %d dag(en).
OPER_OPER_UNSUSPEND
	Oper %s buiten werking is afgebroken.
OPER_OPER_SUSPEND_SYNTAX
	OPER SUSPEND bijnaam dagen
CHAN_HELP_AOP
	Een Alias voor de AUTOOP toegangslijst.
	AOP ADD voegt de bijnaam toe aan de toegangslijst van het kanaal
	met het AUTOOP level.
	AOP LIST geeft een lijst van alle kanaal met toegangslevels gelijk aan AUTOOP.
CHAN_AOP_SYNTAX
	AOP kanaal ADD bijnaam | kanaal DEL bijnaam | LIST
CHAN_HELP_SOP
	Eem Alias voor de  ACC-CHANGE toegangslijst.
	SOP ADD voegt de bijnaam toe aan de toegangslijst van het kanaal
	met het ACC-CHANGE level.
	SOP LIST geeft een lijst van alle kanalen met toegangslevels gelijk aan ACC-CHANGE.	
CHAN_SOP_SYNTAX
	SOP kanaal ADD bijnaam | kanaal DEL bijnaam | LIST
CHAN_AJOIN_ADD
	U kunt het kanaal toevoegenaan uw ajoin lijst door /%s AJOIN ADD %s 

# SENDPASS responses
OPER_SENDPASS_SYNTAX
	SENDPASS bijnaam
OPER_SENDPASS_NOSENDMAIL
	SENDPASS commando is niet beschikbaar omdat sendmail niet is gevonden!
OPER_SENDPASS_UNAVAILABLE
	SENDPASS commando is niet beschikbaar omdat er gebruik wordt gemaakt van versleuteling.
OPER_SENDPASS_NOMAIL
	Bijnaam %s heeft geen E-mail adres ingevoerd!
OPER_SENDPASS_SUBJECT
	Bijnaam wachtwoord (%s)
OPER_SENDPASS_HEAD
	Hallo,
OPER_SENDPASS_LINE_1
	U heeft gevraagt om uw wachtwoord te ontvangen voor bijnaam %s te ontvangen via E-mail.
OPER_SENDPASS_LINE_2
	Het wachtwoord is '%s'. Voor veiligheids overwegingen raden wij u aan dit wachtwoord na het 
	ontvangen van dit zo spoedig mogelijk te wijzigen.
OPER_SENDPASS_LINE_3
	Als u geen idee heeft waarom dit bericht heeft ontvangen, negeer het dan gewoon
OPER_SENDPASS_LINE_4
	Reageer niet op dit bericht!
OPER_SENDPASS_LINE_5
	PTlink Services - http://www.ptlink.net
OPER_SENDPASS_OK
	Wachtwoord van %s is verzonden.
MAIL_LATER
	Kan momenteel geen E-mail verzonden; probeer het later nog eens.
MAIL_DELAYED
	Wacht aub %d seconden en probeer het opnieuw.
OPER_HELP_SENDPASS
	Syntax: SENDPASS bijnaam
	
	Stuurt een E-mail het wachtwoord van de gegeven bijnaam naar het
	E-mail adres van de bijnaam. Dit commando is erg handig ingeval
	van een vergeten/verloren wachtwoord.
	
	 Gebruik beperkt tot IRC operators op bepaalde netwerken.
	
	Dit commando is niet beschikbaar wanneer er gebruik wordt gemaakt
	van een versleuteling.
CHAN_RESTRICT_REGISTER
	Kanaal registratie op dit netwerk is voorbehouden aan 
	Services Operators !!!
OPER_GETFOUNDER_SYNTAX
	GETFOUNDER #channel
MEMO_WILL_EXPIRE
	 Uw memo('s) %s vervallen binnenkort.
MEMO_HAVE_EXPIRED
	Uw memo('s) %s zijn vervallen.
UPDATE_IN_PROGRESS
	Update is bezig, aangevraagt door %s.
UPDATE_DONE
	Update gedaan in %d seconde(n).
NICK_INFO_IS_ONLINE
	Bijnaam is online.
NICK_INFO_HEADER
	--------------------------------------
CHAN_LIST_SERVADMIN_SYNTAX
	LIST patroon [FORBIDDEN] [NOEXPIRE]
NICK_SERVADMIN_HELP_SUSPEND
	Syntax: SUSPEND bijnaam dagen
	
	Het is niet mogelijk de bijnaam te identificeren voor het
	opgegeven aantal dagen.
NICK_SUSPEND_SYNTAX
	SUSPEND bijnaam dagen
NICK_SUSPEND_SUCCEEDED
	Bijnaam %s is nu buitenwerking voor %s dagen.
NICK_SUSPEND_CANCEL
	Buitenwerking van bijnaam %s is nu afgebroken.
NICK_AUTH_SENT
	Er is een kort bericht naar het opgegeven E-mail adres gestuurd
	met een gedetaileerde instructie over hoe u de registratie van 
	uw bijnaam kunt bevestigen door middel van een authenticatie. 
	Tot de authenticatie is het niet mogelijk om memo's te versturen
	of om kanalen te registreren.
NICK_AUTH_INCORRET
	De authenticatie code is niet correct voor deze bijnaam en E-mail adres.
NICK_AUTH_COMPLETED
	De authenticatie code is correct, uw bijnaam registratie is nu
	afgerond.
NICK_HELP_AUTH
	Syntax: AUTH code
	
	Authenticatie bijnaam E-mail, Dit commando wordt gebruikt om na te
	gaan of het door u opgegeven E-mail adres geldig is voor bijnaam
	registratie/E-mail adres verandering.
AUTH_EMAIL_SUBJECT
	Bijnaam registratie
SET_EMAIL_SUBJECT
	Bijnaam E-mail adres wijziging
NICK_SET_EMAIL_WAIT
	Wacht S.V.P. minstens een dag voor u probeert uw E-mail 
	adres te wijzigen.
NICK_SET_EMAIL_AUTH
	Controleer uw %s E-mail adres voor instructies 
	over hoe u de wijziging kunt afronden.
NICK_AUTH_NEEDED
	Rond de bijnaam registratie af door gebruik te maken
	van de auth code die naar uw e-mailadres gestuurd is
	van uw bijnaam.
	
	Als u geen geldig e-mailadres heeft opgegeven of geen
	authenticatie code heeft ontvangen, verander uw 
	e-mailadres dan met /%s SET EMAIL e-mailadres
NICK_HELP_SET_NEWSLETTER
	Syntax: SET NEWSLETTER { ON | OFF }
	
	Schakelt nieuwsbrief inschrijving aan/uit.
NICK_SET_NEWSLETTER_ON
	Newsletter inschrijving staat nu ON (aan).
NICK_SET_NEWSLETTER_OFF
	Nieuwsbrief inschrijving staat nu OFF (uit).
NICK_SET_NEWSLETTER_SYNTAX
	SET NEWSLETTER { ON | OFF }
NICK_INFO_NEWSLETTER
	Zal nieuwsbrief ontvangen.
OPER_HELP_GETFOUNDER
	Syntax: GETFOUNDER kanaal
	
	Bied een Services admins ge mogelijkheis eigenaars
	toegang te krijgen op het gegeven kanaal.
	
	Limited to: Services admins
CHAN_BAD_MLOCKMODE1
	U kan deze mode +O niet in de mlock zetten
	Dit is voorbehouden aan Services operators
CHAN_BAD_MLOCKMODE2
	U kan deze mode +Aniet in de mlock zetten
	Dit is voorbehouden aan Services admins
NEWSS_ADMIN_HELP
	Syntax: OPER ADD bijnaam
	        OPER DEL bijnaam
	        OPER LIST
	
	Bied de Services Administrator de mogelijkheid bijnamen toe te voegen
	of te verwijderen van de Nieuws operator lijst. Een bijnaam die
	geidentificeert is bij %s en in de Nieuws administrator lijst staat is
	in staat de Nieuws administrator commando's te gebruiken.
	
	Elke Nieuws operator en Nieuws administrator mag de ADMIN LIST vorm 
	van het commando gebruiken.
	Al het andere is voor behouden aan de Services administrators.
CHAN_VOICE_SYNTAX
	VOICE kanaal bijnaam
CHAN_DEVOICE_SYNTAX
	DEVOICE kanaal bijnaam
CHAN_HELP_VOICE
	Syntax: VOICE #kanaal bijnaam
	
	Geeft de gegeven gebruiker voice status op het kanaal.
	Standaard alleen beschikbaar voor gebruikers met
	toegangslevel 3 of hoger op het kanaal.

CHAN_HELP_DEVOICE
	Syntax: DEVOICE #kanaal bijnaam
	
	Verwijdert de voice status van de gegeven gebruiker op
	het kanaal.  Standaard alleen beschikbaar voor gebruikers met
	toegangslevel 3 of hoger op het kanaal.
CHAN_LEVEL_VOICEDEVOICE
	Mag VOICE/DEVOICE commando gebruiken
CHAN_BAD_F_MODE
	kanaal mode +f kan niet in de mlock worden gezet
OPER_SECUREMODE_SYNTAX
	SECUREMODE {ON | OFF}
OPER_SECUREMODE_ERROR
	Het zetten van SECUREMODE moet ON(aan) of OFF(uit) zijn.
OPER_HELP_SECUREMODE
	Syntax: SECUREMODE {ON | OFF}
	
	Zet het netwerk in SECUREMODE, Als de optie ON wordt gebruikt
	is het niet mogelijk voor niet geregistreerde bijnamen om tekst naar
	een andere bijnaam of kanaal te sturen, ook is het niet mogelijk om
	en kanaal binnen te gaan. Wanneer niet geregistreerde binnamen in een 
	kanaal zitten wanneer deze mode wordt ingeschakelt, zullen deze bijnamen
	automatisch uit het kanaal verwijderd worden.
OPER_HELP_SXLINE
	Syntax: SXLINE ADD naam:reden
	        SXLINE DEL  naam
	        SXLINE LIST
	        SXLINE VIEW

	Bied Services operators de mogelijkheid de SXLINE lijst te manipuleren.
	Als een naam is ingevoerd is het niet meer mogelijk deze naam op het 
	netwerk te gebruiken, deze naam zal dan zijn verbannen.
OPER_TOO_MANY_SXLINE
	Sorry, SXLINE lijst is vol.
OPER_SXLINE_ADDED
	Nieuwe SXLINE toegevoegd voor %s
OPER_SXLINE_ADD_SYNTAX
	SXLINE ADD naam:reden
OPER_SXLINE_DEL_SYNTAX
	SXLINE DEL naam
OPER_SXLINE_REMOVED
	SXLINE %s verwijderd van de SXLine lijst
OPER_SXLINE_NOT_FOUND
	%s niet gevonden op SXLINE lijst.
OPER_SXLINE_HEADER
	Huidige SXLINE Lijst:
# mask, reason
OPER_SXLINE_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_SXLINE_VIEW_FORMAT
	%s (door %s op %s)
	   %s
OPER_SXLINE_SYNTAX
	SXLINE {ADD | DEL | LIST | VIEW} naam [serverinfo]
OPER_HELP_VLINK
	Syntax: VLINK ADD virtualhost serverinfo
	        VLINK DEL  virtualhost
	        VLINK LIST [patroon]
	        VLINK VIEW [patroon]
	
	Bied Services admins de mogelijkheid de VLINK lijst te manipuleren.
	VLINK bied de mogelijkheid tot het geven van virtuale server namen (vhost). 
OPER_TOO_MANY_VLINK
	Sorry, VLINK lijst is vol.
OPER_VLINK_ADDED
	New VLINK added for %s
OPER_VLINK_ADD_SYNTAX
	VLINK ADD virtualhost serverinfo
OPER_VLINK_DEL_SYNTAX
	VLINK DEL virtualhost
OPER_VLINK_REMOVED
	VLINK %s verwijderd van de VLink lijst
OPER_VLINK_NOT_FOUND
	%s niet gevonden op VLINK lijst.
OPER_VLINK_HEADER
	Huidige VLINK Lijst:
# mask, reason	
OPER_VLINK_FORMAT
	%-32s %s
#mask, set-by, set-time, reason
OPER_VLINK_VIEW_FORMAT
	%s (door %s op %s)
	   %s
OPER_VLINK_SYNTAX
	VLINK {ADD | DEL | LIST | VIEW} virtualhost [serverinfo]
CHAN_HELP_LOGOUT
	Syntax: LOGOUT
	
	Verwijderd alle rechten van de geidentificeerde kanalen
CHAN_LOGOUT_SUCCES
	Alle eigenaars rechten bij de geidentificeerde kanalen zijn verwijderd
NICK_SET_EMAIL_SADMIN_CHANGE
	E-mail adres van %s veranderd naar %sB.
NICK_HELP_SET_PRIVMSG
	Syntax: SET PRIVMSG {ON | OFF} (aan/uit)
	
	Schakelt het gebruik van prive berichten ipv services notices aan
	of uit.
NICK_SET_PRIVMSG_ON
	PrivMsg staat nu On (aan)
NICK_SET_PRIVMSG_OFF
	PrivMsg staat nu Off (uit)
NICK_SET_PRIVMSG_SYNTAX
	Syntax: SET PRIVMSG {ON | OFF} (aan/uit)
NICK_SET_URL_SADMIN_CHANGE
	URL voor %s veranderd naar %s
NICK_SET_URL_SADMIN_UNSET
	URL voor %s verwijderd
NICK_SET_PASSWORD_SADMIN_CHANGED_TO
	Wachtwoord voor %s veranderd naar %s.
NICK_SET_LOCATION_SADMIN_CHANGED
	Locatie voor %s veranderd naar %s
NICK_SET_LOCATION_SADMIN_UNSET
	Location voor %s verwijderd
CHAN_LEVEL_AUTOHALFOP
	Automatisch mode +h
CHAN_LEVEL_HALFOPDEOP
	Toegestaan HALFOP/DEHALFOP te gebruiken
CHAN_HALFOP_SYNTAX
	Syntax: HALFOP #kanaal bijnaam
CHAN_DEHALFOP_SYNTAX
	Syntax: DEHALFOP #kanaal bijnaam
CHAN_CLEARED_HALFOPS
	Mode +h is van kanaal %s verwijderd
CHAN_HELP_HALFOP
	Syntax: HALFOP #kanaal bijnaam
	
	Halfops een geselecteerde bijnaam op het kanaal.  Standaard, 
	iedereen met level 4 toegang en hoger op het kanaal kunnen 
	het gebruiken. 

CHAN_HELP_DEHALFOP
	Syntax: DEHALFOP #kanaal bijnaam
	
	Dehalfops geselecteerde bijnaam op het kanaal. Standaard,
	iedereen met level 4 toegang en hoger op het kanaal kunnen 
	het gebruiken.
NOMAIL_DISABLED
	De optie NOMAIL is uitgeschakeld
