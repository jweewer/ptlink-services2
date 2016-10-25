#
# Services is copyright (c) 1996-1999 Andy Church.
#     E-mail: <achurch@dragonfire.net>
# This program is free but copyrighted software; see the file COPYING for
# details.

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
# For example, "Español (Spanish)" or "Français (French)".

LANG_NAME
	Italiano (Italian)

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
	Dom
	Lun
	Mar
	Mer
	Gio
	Ven
	Sab
# %A
STRFTIME_DAYS_LONG
	Domenica
	Lunedì
	Martedì
	Mercoledì
	Giovedì
	Venerdì
	Sabato
# %b
STRFTIME_MONTHS_SHORT
	Geb
	Feb
	Mar
	Apr
	Mag
	Giu
	Lug
	Ago
	Set
	Ott
	Nov
	Dic
# %B
STRFTIME_MONTHS_LONG
	Gennaio
	Febbraio
	Marzo
	Aprile
	Maggio
	Giugno
	Luglio
	Agosto
	Settembre
	Ottobre
	Novembre
	Dicembre


# This is used in ChanServ/NickServ INFO displays.
COMMA_SPACE
	, 


# Various error messages.
USER_RECORD_NOT_FOUND
	Errore interno - non posso processare la tua richiesta.
UNKNOWN_COMMAND
	Comando Sconosciuto %s.
UNKNOWN_COMMAND_HELP
	Comando Sconosciuto %s. /%s HELP per visualizzare l'help.
SYNTAX_ERROR
	Sintassi: %s
MORE_INFO
	/%s HELP %s per ulteriori informazioni.
NO_HELP_AVAILABLE
	Help non disponibile per %s.
BAD_USERHOST_MASK
	La mask deve essere nella forma user@host.
SERVICE_OFFLINE
	%s adesso e' offline.
READ_ONLY_MODE
	Notice: Il servizio e' in modo read-only;
	I cambiamenti non saranno salvati.
PASSWORD_INCORRECT
	Password errata.

# What's the difference between "Access denied" and "Permission denied"?
# Very little; you can safely make them the same message with no real loss
# of meaning.  If you want to make a distinction, "Access denied" is
# usually used more generally; for example, a non-oper trying to access
# OperServ gets "Access denied", while a non-Services admin trying to use
# NickServ SET NOEXPIRE gets "Permission denied".
ACCESS_DENIED
	Accesso negato.
PERMISSION_DENIED
	Permesso negato.
MORE_OBSCURE_PASSWORD
	Perfavore prova ad inserire una password piu' difficile.  
	La password dovrebbe essere minimo di 5 caratteri,
	e non dovrebbe essere facilmente individuabile (per es. il tuo 
	nome o il tuo nick), and non puo' contenere spazi o 
	caratteri di tabulazione.
PASSWORD_TRUNCATED
	Notice:  La tua password e' stata trocata a %d caratteri.
NICK_NOT_REGISTERED
	Il tuo nick non e' registrato.
NICK_NOT_REGISTERED_HELP
	Il tuo nick non e' registrato.  Scrivi /%s HELP per
	sapere come registrarlo.
NICK_X_NOT_REGISTERED
	Il nick %s non e' registrato.
NICK_X_NOT_IN_USE
	Il nick %s non e' adesso in uso.
NICK_X_NOT_ON_CHAN
	Nick %s isn't on channel %s.
NICK_X_FORBIDDEN
	Il nick %s non puo' essere registrato o usato.
CHAN_X_NOT_REGISTERED
	Il canale %s non e' registrato.
CHAN_X_NOT_IN_USE
	Il canale %s non esiste.
CHAN_X_FORBIDDEN
	Il canale %s non puo' essere registrato o usato.
NICK_IDENTIFY_REQUIRED
	Per questo comando e' necessaria la password.
	Riprova scrivendo /%s IDENTIFY password.
CHAN_IDENTIFY_REQUIRED
	Per questo comando e' richiesta la password.
	Riprova scrivendo /%s IDENTIFY %s password.

###########################################################################
#
# NickServ messages
#
###########################################################################

# Automatic messages
NICK_IS_REGISTERED
	Il nick da te scelto e' gia' registrato. Perfavore scegline un altro.
	(Se e' il tuo nick scrivi /%s IDENTIFY password.)
NICK_IS_SECURE
	Il nick e' registrato e protetto.  Se e' il tuo scrivi 
	 /%s IDENTIFY password.  Oppure
	scegli un nick differente.
NICK_MAY_NOT_BE_USED
	Questo nickname non puo' essere usato,perfavore scegline un altro.
DISCONNECT_IN_1_MINUTE
	Se tu non cambi nick entro un minuto sarai disconnesso.
DISCONNECT_IN_20_SECONDS
	Se tu non cambi nick entro 20 secondi sarai disconnesso.
DISCONNECT_NOW
	Il nick e' stato gia' registrato,non puoi usarlo. Scegline un altro
	prima di riconnetterti. Bye.

# REGISTER responses
NICK_REGISTER_SYNTAX
	REGISTER password email
NICK_REGISTRATION_DISABLED
	Spiacente,la registrazione del nick per adesso non e' attiva.
NICK_REGISTRATION_FAILED
	Spiacente registrazione fallita.
NICK_REG_PLEASE_WAIT
	Perfavore aspetta %d secondi prima di usare il comando REGISTER di nuovo
NICK_CANNOT_BE_REGISTERED
	Il nickname %s non puo' essere registrato.
NICK_ALREADY_REGISTERED
	Il nick %s e' gia' stato registrato!
NICK_REGISTERED
	Il nick %s e' registrato sul tuo account %s
NICK_PASSWORD_IS
	La tua password e' %s - ricordala,dovrai usarla in seguito.

# IDENTIFY responses
NICK_IDENTIFY_SYNTAX
	IDENTIFY password
NICK_IDENTIFY_FAILED
	Spiacente, autenticazione fallita.
NICK_IDENTIFY_SUCCEEDED
	Password accettata. Adesso sei stato autenticato.

# DROP responses
NICK_DROP_SYNTAX
	DROP
NICK_DROP_DISABLED
	Spiacente ma la cancellazione del nick non e' attiva.
NICK_DROPPED
	Il tuo nick e' stato cancellato.
NICK_X_DROPPED
	Il nick %s e' stato cancellato.

# SET responses
NICK_SET_SYNTAX
	SET option parameters
NICK_SET_SERVADMIN_SYNTAX
	SET [nick] option parameters
NICK_SET_DISABLED
	Spiacente,la possibilita' di inserire opzioni ora non e' attiva.
NICK_SET_UNKNOWN_OPTION
	Opzione sconosciuta: %s.
NICK_SET_UNKNOWN_OPTION_OR_BAD_NICK
	Opzione sconosciuta: %s, o nick non registrato.

# SET PASSWORD responses
NICK_SET_PASSWORD_FAILED
	Spiacente,non puoi cambiare la password.
NICK_SET_PASSWORD_CHANGED
	Password cambiata.
NICK_SET_PASSWORD_CHANGED_TO
	La nuova password e' %s.

# SET LANGUAGE responses
NICK_SET_LANGUAGE_SYNTAX
	SET LANGUAGE number
NICK_SET_LANGUAGE_UNKNOWN
	Numero sconosciuto per il linguaggio %d.  Scrivi /%s HELP SET LANGUAGE per una lista di linguaggi
NICK_SET_LANGUAGE_CHANGED
	Language changed to Italian.

# SET URL responses
NICK_SET_URL_CHANGED
	Nuovo URL: %s.
NICK_SET_URL_UNSET
	URL non settato.

# SET EMAIL responses
NICK_SET_EMAIL_CHANGED
	Nuova mail: %s.
NICK_SET_EMAIL_UNSET
	E-mail non settata.

# SET ICQNUMBER responses
NICK_SET_ICQ_CHANGED
	Nuovo numero di icq #%s.
NICK_SET_ICQ_UNSET
	Numero di icq non settato.

# SET LOCATION responses
NICK_SET_LOCATION_CHANGED
	Nuova location %s.
NICK_SET_LOCATION_UNSET
	Location non settata.

# SET KILL responses
NICK_SET_KILL_SYNTAX
	SET KILL {}
NICK_SET_KILL_IMMED_SYNTAX
	SET KILL {ON | QUICK | IMMED | OFF}
NICK_SET_KILL_ON
	Ora la protezione kill e' ON.
NICK_SET_KILL_QUICK
	Ora la protezione kill e' ON, con un ridotto delay di kill.
NICK_SET_KILL_IMMED
	La protezione kill e' ON, senza delay di kill.
NICK_SET_KILL_IMMED_DISABLED
	L'opzione IMMED non e' disponibile per questa rete.
NICK_SET_KILL_OFF
	La protezione kill adesso e' OFF.

# SET PRIVATE responses
NICK_SET_PRIVATE_SYNTAX
	SET PRIVATE {ON | OFF}
NICK_SET_PRIVATE_ON
	Private option e' ON.
NICK_SET_PRIVATE_OFF
	Private option e' OFF.

# SET HIDE responses
NICK_SET_HIDE_SYNTAX
	SET HIDE {EMAIL | QUIT} {ON | OFF}
NICK_SET_HIDE_EMAIL_ON
	La tua mail sara' invisibile nelle %s INFO.
NICK_SET_HIDE_EMAIL_OFF
	La tua mail sara' visibile nelle %s INFO.
NICK_SET_HIDE_QUIT_ON
	Il tuo ultimo messaggio di quit sara' nascosto dalle %s INFO.
NICK_SET_HIDE_QUIT_OFF
	Il tuo ultimo messaggio di quit sara' mostrato nelle %s INFO.

# SET NOEXPIRE responses
NICK_SET_NOEXPIRE_SYNTAX
	SET [nickname] NOEXPIRE {ON | OFF}
NICK_SET_NOEXPIRE_ON
	Il nick %s non scadra'.
NICK_SET_NOEXPIRE_OFF
	Il nick %s scadra'.

# LINK responses
NICK_LINK_SYNTAX
	LINK nick password
NICK_NICKLINK_SYNTAX
	NICKLINK nick targetnick
NICK_LINK_DISABLED
	Il comando LINK non e' disponibile.
NICK_LINK_FAILED
	Spiacente,linking fallito.
NICK_NO_LINK_SAME
	Non posso linkare il tuo nick attuale!
NICK_LINK_CIRCULAR
	Non posso linkare al link %s: ho trovato un link circolare.
NICK_LINKED
	Il tuo nick e' stato linkato a %s.
NICK_NICKLINKED
	Il nick %s e' stato linkato a %s.

# UNLINK responses
NICK_UNLINK_SYNTAX
	UNLINK [nick password]
NICK_UNLINK_FAILED
	Spiacente, unlinking fallito.
NICK_NOT_LINKED
	Il tuo nick non e' linkato.
NICK_UNLINKED
	Il tuo nick e' stato slinkato da %s.
NICK_X_NOT_LINKED
	Il nick %s non e' linkato.
NICK_X_UNLINKED
	Il nick %s e' stato slinkato da %s.

# LISTLINKS responses
NICK_LISTLINKS_SYNTAX
	LISTLINKS nick [ALL]
NICK_LISTLINKS_SYNTAX2
	LISTLINKS
NICK_LISTLINKS_HEADER
	Lista dei nickname attualmente linkati a %s:
NICK_LISTLINKS_FOOTER
	%d nick linkati.

# INFO responses
NICK_INFO_SYNTAX
	INFO nick
NICK_INFO_REALNAME
	%s e' %s
NICK_INFO_ADDRESS
	 Ultimo indirizzo: %s
NICK_INFO_TIME_REGGED
	   Tempo registrato: %s [%s]
NICK_INFO_LAST_IDENTIFY
	Ultima ora di autenticazione: %s [%s]
NICK_INFO_LAST_SEEN
	    Ultima ora in cui era collegato: %s [%s]
NICK_INFO_ONLINE
	 Online per: %s
NICK_INFO_LAST_QUIT
	 Ultimo messaggio di quit %s
NICK_INFO_URL
	               URL: %s
NICK_INFO_EMAIL
	    E-mail: %s
NICK_INFO_ICQ
	        Numero di ICQ: #%s
NICK_INFO_LOCATION
	          Location: %s
NICK_INFO_OPTIONS
	           Options: %s
NICK_INFO_NO_EXPIRE
	            Expire: Mai
NICK_INFO_OSUSPENDED
	   Sospensione degli Oper: %s
# These strings MUST NOT be empty
NICK_INFO_OPT_KILL
	Protezione kill
NICK_INFO_OPT_PRIVATE
	Private
NICK_INFO_OPT_NONE
	Nessuno

# LIST responses
NICK_LIST_SYNTAX
	LIST pattern
NICK_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE]
NICK_LIST_HEADER
	Risultati trovati per %s:
NICK_LIST_RESULTS
	Fine della lista - %d/%d risultati mostrati.

NICK_RELEASED
	I serivizi che trattenevano il tuo nick l'hanno rilasciato.

# GHOST responses
NICK_GHOST_SYNTAX
	GHOST nickname [password]
NICK_NO_GHOST_SELF
	Tu non puoi mandare in 'ghost' te stesso!
NICK_GHOST_KILLED
	Il ghost con il tuo nick e' stato killato.

# GETPASS responses
NICK_GETPASS_SYNTAX
	GETPASS nickname
NICK_GETPASS_UNAVAILABLE
	GETPASS comando non disponibile perche' e' in uso la criptazione.
NICK_GETPASS_PASSWORD_IS
	La password per %s e' %s.

# FORBID responses
NICK_FORBID_SYNTAX
	FORBID nickname
NICK_FORBID_SUCCEEDED
	Il nick %s ora e' vietato.
NICK_FORBID_FAILED
	Non potresti vietare il nick %s!

###########################################################################
#
# ChanServ messages
#
###########################################################################

# Access level descriptions
CHAN_LEVEL_AUTOOP
	Status di channel operator automatico
CHAN_LEVEL_AUTOVOICE
	Modo automatico +v
CHAN_LEVEL_AUTODEOP
	Status di channel operator non permesso
CHAN_LEVEL_NOJOIN
	Non puoi entrare in questo canale se RESTRICTED
CHAN_LEVEL_INVITE
	Sei autorizzato ad usare il comando INVITE 
CHAN_LEVEL_AKICK
	Sei autorizzato ad usare il comando AKICK
CHAN_LEVEL_SET
	Sei autorizzato ad usare il comando SET (non FOUNDER/PASSWORD)
CHAN_LEVEL_CLEAR
	Sei autorizzato ad usare il comando CLEAR
CHAN_LEVEL_UNBAN
	Sei autorizzato ad usare il comando UNBAN
CHAN_LEVEL_OPDEOP
	Sei autorizzato ad usare i comandi OP/DEOP
CHAN_LEVEL_ACCESS_LIST
	Puoi vedere l'access list
CHAN_LEVEL_ACCESS_CHANGE
	Puoi modificare l'access list
CHAN_LEVEL_MEMO_READ
	Puoi vedere i memo del canale
CHAN_LEVEL_MEMO_SEND
	Puoi mandare memo al canale
CHAN_LEVEL_MEMO_DEL
	Puoi cancellare memo del canale
CHAN_LEVEL_KICK
	Puoi usare il comando KICK

# Automatic responses
CHAN_IS_REGISTERED
	Questo canale e' stato registrato con %s.
CHAN_NOT_ALLOWED_OP
	Non puoi essere op su %s.
CHAN_MAY_NOT_BE_USED
	uqesto canale non puo' essere usato.
CHAN_NOT_ALLOWED_TO_JOIN
	Non puoi entrare in questo canale.

# REGISTER responses
CHAN_REGISTER_SYNTAX
	REGISTER channel password description
CHAN_REGISTER_DISABLED
	Spiacente,la registrazioni dei canali attualmente non e' attiva.
CHAN_REGISTER_NOT_LOCAL
	I canali locali non possono essere registrati.
CHAN_MUST_REGISTER_NICK
	Tu devi prima registrare il tuo nick.  Scrivi /%s HELP per sapere come fare.
CHAN_MUST_IDENTIFY_NICK
	Perfavore prima autenticati con %s usando il comando:
	/%s IDENTIFY password
CHAN_MAY_NOT_BE_REGISTERED
	Il canale %s non puo' essere registrato!
CHAN_ALREADY_REGISTERED
	Il canale %s e' gia' registrato!
CHAN_MUST_BE_CHANOP
	Devi essere op per registrare il canale.
CHAN_REACHED_CHANNEL_LIMIT
	Spiacente hai gia' raggiunto il limite di %d canali.
CHAN_EXCEEDED_CHANNEL_LIMIT
	Spiacente hai gia' ecceduto nel limite di %d canali.
CHAN_REGISTRATION_FAILED
	Spiacente, registrazione fallita.
CHAN_REGISTERED
	Il canale %s e' registrato per il nick: %s
CHAN_PASSWORD_IS
	La tua password del canale e' %s - non dimenticarla! dovrai usarla in seguito.

# IDENTIFY responses
CHAN_IDENTIFY_SYNTAX
	IDENTIFY channel password
CHAN_IDENTIFY_FAILED
	Spiacente,autenticazione fallita.
CHAN_IDENTIFY_SUCCEEDED
	Password accetta - adesso hai un accesso piu' a %s.

# DROP responses
CHAN_DROP_SYNTAX
	DROP channel
CHAN_DROP_DISABLED
	Spiacente,la cancellazione dei canali registrati per adesso non e' attiva.
CHAN_DROPPED
	Il canale %s e' stato tolto dalla lista dei canali registrati.

# SET responses
CHAN_SET_SYNTAX
	SET channel option parameters
CHAN_SET_DISABLED
	Spiacente,il servizio attraverso il quale vengono settate le opzioni del canale non e' temporaneamente attivo.
CHAN_SET_UNKNOWN_OPTION
	Sconosciuta opzione di SET %s.

# SET FOUNDER responses
CHAN_SET_FOUNDER_TOO_MANY_CHANS
	%s ha registrato troppi canali.
CHAN_FOUNDER_CHANGED
	Il fondatore di %s adesso e' %s.

# SET SUCCESSOR responses
CHAN_SUCCESSOR_CHANGED
	Il successore per %s adesso e' %s.
CHAN_SUCCESSOR_UNSET
	Il successore per %s non e' stato impostato.

# SET PASSWORD responses
CHAN_SET_PASSWORD_FAILED
	Spiacente,non hai settato una password.
CHAN_PASSWORD_CHANGED
	%s password cambiata.
CHAN_PASSWORD_CHANGED_TO
	%s password cambiata a: %s.

# SET DESC responses
CHAN_DESC_CHANGED
	Descrizione di %s cambiata a %s.

# SET URL responses
CHAN_URL_CHANGED
	URL per %s cambiato a %s.
CHAN_URL_UNSET
	L'URL per %s non e' stato impostato.

# SET EMAIL responses
CHAN_EMAIL_CHANGED
	Indirizzo email per %s cambiato a %s.
CHAN_EMAIL_UNSET
	L'email per %s non e' stato impostata.

# SET ENTRYMSG responses
CHAN_ENTRY_MSG_CHANGED
	E' stato cambiato il messaggio di benvenuto per %s.
CHAN_ENTRY_MSG_UNSET
	Il messaggio di benvenuto per %s non e' stato impostato.

# SET TOPIC responses
CHAN_SET_TOPIC_FAILED
	Spiacente,non posso impostare il topic.

# SET MLOCK responses
CHAN_SET_MLOCK_KEY_REQUIRED
	E' richiesto un parametro per MLOCK +k.
CHAN_SET_MLOCK_LIMIT_REQUIRED
	E' richiesto un parametro per MLOCK +l.
CHAN_SET_MLOCK_LIMIT_POSITIVE
	Il parametro per MLOCK +l deve essere un numero positivo.
CHAN_SET_MLOCK_UNKNOWN_CHAR
	Lo sconosciuto modo %c sara' ignorato.
CHAN_MLOCK_CHANGED
	Il lock dei modes sul canale %s e' stato cambiato a %s.
CHAN_MLOCK_REMOVED
	E' stato tolto il mode lock sul canale %s.

# SET KEEPTOPIC responses
CHAN_SET_KEEPTOPIC_SYNTAX
	SET channel KEEPTOPIC {ON | OFF}
CHAN_SET_KEEPTOPIC_ON
	L'opzione richiesta adesso e' ON.
CHAN_SET_KEEPTOPIC_OFF
	L'opzione richiesta adesso e' OFF.

# SET TOPICLOCK responses
CHAN_SET_TOPICLOCK_SYNTAX
	SET channel TOPICLOCK {ON | OFF}
CHAN_SET_TOPICLOCK_ON
	Adesso il topic lock e' ON.
CHAN_SET_TOPICLOCK_OFF
	Adesso il topic lock e' OFF.

# SET PRIVATE responses
CHAN_SET_PRIVATE_SYNTAX
	SET channel PRIVATE {ON | OFF}
CHAN_SET_PRIVATE_ON
	L'opzione private ora e' ON.
CHAN_SET_PRIVATE_OFF
	L'opzione private ora e' OFF.

# SET SECUREOPS responses
CHAN_SET_SECUREOPS_SYNTAX
	SET channel SECUREOPS {ON | OFF}
CHAN_SET_SECUREOPS_ON
	L'opzione secure ops ora e' ON.
CHAN_SET_SECUREOPS_OFF
	L'opzione secure ops ora e' OFF.

# SET LEAVEOPS responses
CHAN_SET_LEAVEOPS_SYNTAX
	SET channel LEAVEOPS {ON | OFF}
CHAN_SET_LEAVEOPS_ON
	L'opzione leave ops adesso e' ON.
CHAN_SET_LEAVEOPS_OFF
	L'opzione leave ops adesso e' OFF.

# SET RESTRICTED responses
CHAN_SET_RESTRICTED_SYNTAX
	SET channel RESTRICTED {ON | OFF}
CHAN_SET_RESTRICTED_ON
	L'accesso ristretto adesso e' ON.
CHAN_SET_RESTRICTED_OFF
	L'accesso ristretto adesso e' OFF.

# SET OPNOTICE responses
CHAN_SET_OPNOTICE_SYNTAX
	SET channel OPNOTICE {ON | OFF}
CHAN_SET_OPNOTICE_ON
	L'op notice adesso e' ON.
CHAN_SET_OPNOTICE_OFF
	L'op notice adesso e' OFF.

# SET OPNOTICE responses
CHAN_SET_NOLINKS_SYNTAX
	SET channel NOLINKS {ON | OFF}
CHAN_SET_NOLINKS_ON
	L'opzione NOLINKS adesso e' ON.
CHAN_SET_NOLINKS_OFF
	L'opzione NOLINKS adesso e' OFF.

# SET NOEXPIRE responses
CHAN_SET_NOEXPIRE_SYNTAX
	SET channel NOEXPIRE {ON | OFF}
CHAN_SET_NOEXPIRE_ON
	Il canale %s non scadra'.
CHAN_SET_NOEXPIRE_OFF
	Il canale %s scadra'.

# ACCESS messages
CHAN_ACCESS_SYNTAX
	ACCESS channel {ADD|DEL|LIST} [nick [level] | entry-list]
CHAN_ACCESS_DISABLED
	Spiacente, l'access list del canale adesso non e' attiva.
CHAN_ACCESS_LEVEL_NONZERO
	L'access-level non puo' essere zero.
CHAN_ACCESS_LEVEL_RANGE
	L'access level deve essere incluso tra %d e %d (compresi gli estremi).
CHAN_ACCESS_NICKS_ONLY
	L'access list del canale puo' contenere solo nick registrati.
CHAN_ACCESS_REACHED_LIMIT
	Spiacente, puoi inserire solo %d persone nella access-list.
CHAN_ACCESS_LEVEL_UNCHANGED
	L'access level per %s su %s non e' cambiato da %d.
CHAN_ACCESS_LEVEL_CHANGED
	L'access level per %s su %s e' cambiato da %d a %d.
CHAN_ACCESS_ADDED
	%s e' stato addato alla access list di %s con il livello %d.
CHAN_ACCESS_NO_SUCH_ENTRY
	Nessuna corrispondenza per il numero (#%d) sulla access list di %s.
CHAN_ACCESS_NOT_FOUND
	%s non e' stato trovato nella access list di %s.
CHAN_ACCESS_NO_MATCH
	Nessuna entrata corrispondente nella access list di %s.
CHAN_ACCESS_DELETED
	%s e' stato tolto dalla access list di %s.
CHAN_ACCESS_DELETED_ONE
	E' stata cancellata 1 entry dalla access list di %s.
CHAN_ACCESS_DELETED_SEVERAL
	Sono state cancellate %d entries dalla access list di %s.
CHAN_ACCESS_LIST_EMPTY
	L'access list di %s e' vuota.
CHAN_ACCESS_LIST_HEADER
	Access list per %s:
	  Num   Lev  Nick
CHAN_ACCESS_LIST_FORMAT
	  %3d  %4d  %s%s%s%s


# AOP/SOP error response
CHAN_NO_AOP_SOP
	Per assegnare privilegi agli utenti usa il comando ACCESS;
	Scrivi /%s HELP ACCESS per ulteriori informazioni.

# AKICK responses
CHAN_AKICK_SYNTAX
	AKICK channel {ADD | DEL | LIST} [nick-or-usermask]
CHAN_AKICK_DISABLED
	Spiacente, la modificazione della lista degli autokick del canale e'
	temporaneamente disabilitata.
CHAN_AKICK_ALREADY_EXISTS
	%s e' gia' presente sulla lista di autokick di %s.
CHAN_AKICK_REACHED_LIMIT
	Spiacente, puoi inserire solamente %d mask per l'autokick su un canale.
CHAN_AKICK_ADDED
	%s e' stato addato alla autokick list di %s.
CHAN_AKICK_NO_SUCH_ENTRY
	Nessuna entrata (#%d) sulla lista di autokick di %s.
CHAN_AKICK_NOT_FOUND
	%s non e' stata trovata nella lista di autokick di %s.
CHAN_AKICK_NO_MATCH
	Nessuna entries corrispondente nella lista di autokick di %s.
CHAN_AKICK_DELETED
	%s e' stato rimosso dalla lista di autokick di %s.
CHAN_AKICK_DELETED_ONE
	E' stata rimossa 1 entry dalla lista di autokick di %s.
CHAN_AKICK_DELETED_SEVERAL
	Sono state rimosse %d entries dalla lista di autokick di %s.
CHAN_AKICK_LIST_EMPTY
	La lista di autokick di %s e' vuota.
CHAN_AKICK_LIST_HEADER
	Autokick list per %s:
CHAN_AKICK_LIST_FORMAT
	  %3d %s%s
CHAN_AKICK_LIST_FORMAT2
	  %3d %s by %s : %s

# LEVELS responses
CHAN_LEVELS_SYNTAX
	LEVELS channel {SET | DIS[ABLE] | LIST | RESET} [item [level]]
CHAN_LEVELS_RANGE
	Il livello deve essere tra %d e %d (compresi gli estremi).
CHAN_LEVELS_CHANGED
	Il livello per %s sul canale %s e' stato cambiato a %d.
CHAN_LEVELS_UNKNOWN
	Setting %s sconosciuto.  Scrivi /%s HELP LEVELS DESC per vedere una lista di settaggi validi.
CHAN_LEVELS_DISABLED
	%s disabilitato sul canale %s.
CHAN_LEVELS_LIST_HEADER
	Access level settato per il canale %s:
CHAN_LEVELS_LIST_DISABLED
	    %-*s  (disabilitato)
CHAN_LEVELS_LIST_FOUNDER
	    %-*s  (solo per il fondatore)
CHAN_LEVELS_LIST_NORMAL
	    %-*s  %d
CHAN_LEVELS_RESET
	L'access level per %s e' stato riportato al default.

# INFO responses
CHAN_INFO_SYNTAX
	INFO channel
CHAN_INFO_HEADER
	Info sul canale %s:
CHAN_INFO_FOUNDER
	        Fondatore: %s (%s)
CHAN_INFO_NO_FOUNDER
	        Fondatore: %s
CHAN_INFO_DESCRIPTION
	    Descrizione: %s
CHAN_INFO_TIME_REGGED
	     Registrati: %s [%s]
CHAN_INFO_LAST_USED
	      Ultimo chat: %s [%s]
CHAN_INFO_LAST_TOPIC
	     Ultimo topic: %s
CHAN_INFO_TOPIC_SET_BY
	   Topic impostato da: %s
CHAN_INFO_RECORD
	   Users record: %d utente/i a %s [%s]
CHAN_INFO_USERS
	     Utenti: %d
CHAN_INFO_URL
	            URL: %s
CHAN_INFO_EMAIL
	 Indirizzo Email: %s
CHAN_INFO_OPTIONS
	        Opzioni: %s
CHAN_INFO_NO_EXPIRE
	         Scadenza: Mai
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
CHAN_INFO_OPT_NONE
	None
CHAN_INFO_MODE_LOCK
	      Mode lock: %s

# LIST responses
CHAN_LIST_SYNTAX
	LIST pattern
CHAN_LIST_HEADER
	Lista delle entries corrispondenti a %s:
CHAN_LIST_FORMAT
	    %-20s  %s
CHAN_LIST_END
	Fine della lista - %d/%d entries mostrate.

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
	Tu sei stato sbannato da %s.

# CLEAR responses
CHAN_CLEAR_SYNTAX
	CLEAR channel what
CHAN_CLEARED_BANS
	Tutti i ban da %s sono stati rimossi.
CHAN_CLEARED_MODES
	Tutti modes per %s sono stati azzerati.
CHAN_CLEARED_OPS
	E' stato richiesto il modo +o per il canale %s.
CHAN_CLEARED_VOICES
	E' stato richiesto il modo +v per il canale %s.
CHAN_CLEARED_USERS
	Tutti gli utenti sono stati kickati dal canale %s.

# GETPASS responses
CHAN_GETPASS_SYNTAX
	GETPASS channel
CHAN_GETPASS_UNAVAILABLE
	GETPASS comando non disponibile perche' e' in uso la criptazione delle password.
CHAN_GETPASS_PASSWORD_IS
	La password per il canale %s e' %s.

# FORBID responses
CHAN_FORBID_SYNTAX
	FORBID channel
CHAN_FORBID_SUCCEEDED
	Il canale %s adesso e' chiuso.
CHAN_FORBID_FAILED
	Non potresti chiudere il canale %s!

###########################################################################
#
# MemoServ messages
#
###########################################################################

# Automatic messages
MEMO_HAVE_NEW_MEMO
	Hai 1 nuovo memo.
MEMO_HAVE_NEW_MEMOS
	Hai %d nuovi memo.
MEMO_TYPE_READ_LAST
	Scrivi /%s READ LAST per leggerlo.
MEMO_TYPE_READ_NUM
	Scrivi /%s READ %d per leggerlo.
MEMO_TYPE_LIST_NEW
	Scrivi /%s LIST NEW per elencarli.
MEMO_AT_LIMIT
	Attenzione: Tu hai raggiunto il massimo numero di memos (%d). Adesso non puoi piu' riceverne altri finche' non ne cancellerai qualcuno di quelli che possiedi adesso.
MEMO_OVER_LIMIT
	Attenzione: Tu sei oltre il tuo massimo numero di memos (%d). Tu non puoi piu' riceverne altri finche' non cancellerai qualcuno di quelli che possiedi adesso.
MEMO_NEW_MEMO_ARRIVED
	Hai ricevuto un nuovo memo da %s.
	Scrivi /%s READ %d per leggerlo.

# Multi-use responses
MEMO_HAVE_NO_MEMOS
	Tu non hai memos. 
MEMO_X_HAS_NO_MEMOS
	%s non hai memos.
MEMO_DOES_NOT_EXIST
	Il memo %d non esiste!
MEMO_LIST_NOT_FOUND
	Non sono stati trovati memo corrispondenti.

# SEND responses
MEMO_SEND_SYNTAX
	SEND {nick | channel} memo-text
MEMO_SEND_DISABLED
	Spiacente,attualmente il servizio non e' attivo.
MEMO_SEND_PLEASE_WAIT
	Perfavore aspetta %d prima di usare il comando SEND di nuovo.
MEMO_X_GETS_NO_MEMOS
	%s non puo' riceve memo.
MEMO_X_HAS_TOO_MANY_MEMOS
	%s adesso ha troppi memo e non puo' riceverne altri.    
MEMO_SENT
	Memo mandato a %s.

# LIST responses
MEMO_LIST_SYNTAX
	LIST [channel] [list | NEW]
MEMO_HAVE_NO_NEW_MEMOS
	Non e' presente nessun nuovo memo.
MEMO_X_HAS_NO_NEW_MEMOS
	%s non ha nuovi memo.
MEMO_LIST_MEMOS
	Memo per %s.  Per leggerli, scrivi: /%s READ num
MEMO_LIST_NEW_MEMOS
	Nuovi memo per %s.  Per leggerli, scrivi: /%s READ num
MEMO_LIST_CHAN_MEMOS
	Memo per %s.  Per leggerli, scrivi: /%s READ %s num
MEMO_LIST_CHAN_NEW_MEMOS
	Nuovi memo per %s.  Per leggerli, scrivi: /%s READ %s num
MEMO_LIST_HEADER
	 Num  Mittente           Date/Time
MEMO_LIST_FORMAT
	%c%3d  %-16s  %s "%s..."

# READ responses
MEMO_READ_SYNTAX
	READ [channel] {list | LAST | NEW}
MEMO_HEADER
	%d memo da %s (%s).  Per cancellarlo/i scrivi: /%s DEL %d
MEMO_CHAN_HEADER
	%d memo da %s (%s).  Per cancellarlo/i scrivi: /%s DEL %s %d
MEMO_TEXT
	%s

# DEL responses
MEMO_DEL_SYNTAX
	DEL [channel] {num | list | ALL}
MEMO_DELETED_NONE
	Nessun memo e' stato cancellato.
MEMO_DELETED_ONE
	%d memo sono stati cancellati.
MEMO_DELETED_SEVERAL
	I memo %s sono stati cancellati.
MEMO_DELETED_ALL
	Tutti i memo sono stati cancellati.

# SET responses
MEMO_SET_SYNTAX
	SET option parameters
MEMO_SET_DISABLED
	Spiacente, le opzioni per i memo attualmente non sono attive.
MEMO_SET_UNKNOWN_OPTION
	Sconosciuta opzione per SET : %s.

# SET NOTIFY responses
MEMO_SET_NOTIFY_SYNTAX
	SET NOTIFY {ON | LOGON | NEW | OFF}
MEMO_SET_NOTIFY_ON
	%s ti avvertira' se ci saranno nuovi memo quando entrerai in chat e quando te li manderanno.
MEMO_SET_NOTIFY_LOGON
	%s ti avvertira' se ci sono nuovi memo solo quando entrerai in chat o quando
	toglierai l'away
MEMO_SET_NOTIFY_NEW
	%s ti avvertira' se ci sono nuovi memo quando ti saranno spediti.
MEMO_SET_NOTIFY_OFF
	%s non ti avvertira' se arriveranno nuovi memo.

# SET LIMIT responses
MEMO_SET_LIMIT_SYNTAX
	SET LIMIT [channel] limit
MEMO_SET_LIMIT_SERVADMIN_SYNTAX
	SET LIMIT [user | channel] {limit | NONE} [HARD]
MEMO_SET_YOUR_LIMIT_FORBIDDEN
	Non sei aturoizzato a cambiare il limite dei memo.
MEMO_SET_LIMIT_FORBIDDEN
	Il limite dei memo per %s non puo' essere cambiato.
MEMO_SET_YOUR_LIMIT_TOO_HIGH
	Non puoi settare il limite dei memo ad un numero piu' alto di %d.
MEMO_SET_LIMIT_TOO_HIGH
	Non puoi settare il limite dei memo per %s a un numero piu' alto di %d.
MEMO_SET_LIMIT_OVERFLOW
	Il limite dei memo e' stato superato.Limitalo a %d.
MEMO_SET_YOUR_LIMIT
	Il tuo limite per i memo e' stato settato a %d.
MEMO_SET_YOUR_LIMIT_ZERO
	Non potrai piu' ricevere memo.               
MEMO_UNSET_YOUR_LIMIT
	Il tuo limite dei memo e' stato disabilitato.
MEMO_SET_LIMIT
	Limite dei memo per %s settato a %d.
MEMO_SET_LIMIT_ZERO
	Limite dei memo per %s settato a 0.
MEMO_UNSET_LIMIT
	Limite dei memo disabiltiato per %s.

# INFO responses
MEMO_INFO_SYNTAX
	INFO [channel]
MEMO_INFO_SERVADMIN_SYNTAX
	INFO [nick | channel]
MEMO_INFO_NO_MEMOS
	Attualemente non hai memo.  
MEMO_INFO_MEMO
	Attualmente hai 1 memo. 
MEMO_INFO_MEMO_UNREAD
	Attualmente hai 1 memo, e non e' stato ancora letto.
MEMO_INFO_MEMOS
	Attualmente hai %d memo.
MEMO_INFO_MEMOS_ONE_UNREAD
	Attualmente hai %d memo, tra i quali 1 non e' ancora stato letto.
MEMO_INFO_MEMOS_SOME_UNREAD
	Attualmente hai %d memo,tra i quali %d non e' ancora stato letto.
MEMO_INFO_MEMOS_ALL_UNREAD
	Attualmente hai %d memo; e ancora non ne e' stato letto nessuno.
MEMO_INFO_LIMIT
	Il tuo limite di memo e' %d.
MEMO_INFO_HARD_LIMIT
	Il tuo limite di memo e' %d, e non puo' essere cambiato.
MEMO_INFO_LIMIT_ZERO
	Il tuo limite di memo e' 0; non potrai ricevere ulteriori memo.
MEMO_INFO_HARD_LIMIT_ZERO
	Il tuo limite di memo e' 0; non potrai ricevere ulteriori memo.Non potrai cambiare questo limite
MEMO_INFO_NO_LIMIT
	Non c'e' limite per il numero di memo che puoi tenere
MEMO_INFO_X_NO_MEMOS
	%s attualmente non ha memo.
MEMO_INFO_X_MEMO
	%s attualmente ha 1 memo.
MEMO_INFO_X_MEMO_UNREAD
	%s attualmente ha 1 memo,e ancora non e' stato letto.
MEMO_INFO_X_MEMOS
	%s attualmente ha %d memo.
MEMO_INFO_X_MEMOS_ONE_UNREAD
	%s attualmente ha %d memo,tra i quali 1 non e' stato letto.
MEMO_INFO_X_MEMOS_SOME_UNREAD
	%s attualmente ha %d memo, tra i quali %d non sono stati letti.
MEMO_INFO_X_MEMOS_ALL_UNREAD
	%s attualmente ha %d memo;e ancora nessuno e' stato letto.
MEMO_INFO_X_LIMIT
	Il limite di memo di %s e' %d.
MEMO_INFO_X_HARD_LIMIT
	Il limite di memo di %s e' %d.
MEMO_INFO_X_NO_LIMIT
	%s non ha limite di memo.

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
	%S ti permette di registrare un nick in modo da evitare
	che gli altri lo usino.  Se il nick non verra' usato per 
	%d giorni,la registrazione scadra'. I seguenti comandi permettono
	di registrare e trattenere i nick;
	per usarli scrivi  /%S comando.
	Per ogni informazione su ogni comando scrivi 
	/%S HELP comando.
	
	    AJOIN      Modifica la tua lista di autojoin
	    REGISTER   Registra un nick
	    IDENTIFY   Ti autentica con una password
	    LINK       Trasforma il tuo nick in alias per un altro nick
	    SET        Setta le opzioni
	    DROP       Rimuove il nick dai nick registrati
	    LISTLINKS  Mostra i nick linkati a te (come alias)
	    NOTES      Ti permette di conservare dei notes (brevi appunti)

	Altri comandi: UNLINK, GHOST, INFO, LIST, STATUS
	
	NOTICE: Questo server garantisce agli ircuser che la loro
	identita' non sia compromessa.
	Questo NON e' concepito per facilitare il "furto" di
	nick o altre azioni dannose del genere.  L'abuso di %S sara' punito.

NICK_HELP_EXPIRE_ZERO
	%S ti permette di registrare un nick e impedire che
	altri lo usino. 
	I seguenti comandi permettono di registrare e trattenere i nick;
	per usarli scrivi  /%S comando.
	Per ogni informazione su ogni comando scrivi
	/%S HELP comando.
					
	
	    REGISTER   Registera un nick
	    IDENTIFY   Ti autentica con una password
	    LINK       Rende un tuo nick un alias per un altro
	    SET        Setta le opzioni,compresa la kill protection
	    DROP       Cancella la registrazione di un nick
	
	Altri comandi: UNLINK, GHOST, INFO, LIST, STATUS
	
	NOTICE: Questo server garantisce agli ircuser che la loro
	 identita' non sia compromessa.
	 Questo NON e' concepito per facilitare il "furto" di
	 nick o altre azioni dannose del genere.  L'abuso di %S sara' punito.
				
	
NICK_HELP_REGISTER
	Sintassi: REGISTER password email
	
	Registra il tuo nick nel dabase %S.
	Se tu non hai una mail usa NOMAIL. nel campo
	email. Finche' il tuo nick e' registrato puoi usare  
	SET per configurare i settaggi del nick o altre cose
	del genere.
	Non dimenticare la password che usi durante la fase di
	di registrazione. Sara' necessaria per cambiare il tuo nick 
	piu' tardi.  (Nota che la password e' case sentivie!
	  FIDO, Fido,e fido	sono password differenti!)
	
	Consigli per scegliere la tua password:
	
	La password non deve essere facilemente intuibile.  Per esempio,
	usare il tuo nome o il tuo nick come password non e' una buona idea. 
	Del resto %S non te lo permettera'.  Inoltre, password
	brevi sono vulnerabili,quindi tu devi scegliere una password di 5
	caratteri minimo.
	E per finire il carattere spazio non puo' essere usato nella password

NICK_HELP_IDENTIFY
	Sintassi: IDENTIFY password
	
	Prova %S che tu sei il proprietario di quel nick.
	Molti comandi richiedono che tu ti autentichi prima 
	di usarli. La password dovrebbe essere la stessa che 
	hai inserito per il comando ^REGISTER.

NICK_HELP_DROP
	Sintassi: DROP
	
	Cancella il tuo nickname dal database %S.  Un
	nick che e' stato cancellato e' libero per chiunque volesse
	registrarlo.
	
	Per usare questo comando,tu devi prima autenticarti 
	con la tua password (/%S HELP IDENTIFY per sapere
	come fare)
	
NICK_HELP_LINK
	Sintassi: LINK nick password
	
	Linka il tuo nick a un altro rendendo il nick che stai 
	usando adesso un alias per il nick dato.
	Quando tu dai questo comando la lista ajoin per il nick
	che tu stai usando e' cancellata e rimpiazzata da quella del
	nick che hai linkato;tutti i memos del nick attuale sono addati
	alla lista dei memo del target nick (puo' capitare,in questo modo
	di eccedere nel limite dei memos e in questo caso tu dovrai 
	cancellare alcuni prima di ricerverne altri).
	
	Una volta che il link e' stato stabilito il tuo nick sara'
	convertito nel target nick dovunque nei servizi eccetto
	per il comando %S UNLINK e DROP.
	Per esempio tu puoi usare uno o l'altro il nick per leggere lo stesso
	set di note (e i memo mandati all'altro nick saranno messi
	nella stessa lista). Se tu ti autentichi per un nick tu sarai
	automaticamente autenticato per gli altri.
	Se uno dei due nick e' su una access list di un canale allora
	entrambi i nick avranno gli stessi privilegi di accesso.

	Per usare questo comando tu devi identificarti per il nick
	corrente (usando il comando IDENTIFY), e devi metere
	la password per il nick che vuoi linkare.
	
NICK_HELP_UNLINK
	Sintassi: UNLINK [nick pass]
	
	Rimuove il link dal tuo nick verso un altro. Quando un link
	e' rimosso le flag del nickname e la lista ajoin del nick
	linkato precedentemente sono copiate al tuo nick corrente
	e possono essere cambiate indipendentemente. I Memo non sono 
	copiati;tutti i memo resteranno conservati con il vecchio nick
	linkato
	
	Dando il nickn e la password come parametri tu puoi slinkare
	un nick da un'altro che tu stai usando correntemente
	
NICK_HELP_SET
	Sintassi: SET option parameters
	
	Setta varie opzioni per il nick.  option puo' essere:
	
	    PASSWORD   Setta la tua password per il nick
	    LANGUAGE   Setta il linguaggio di questi messaggi                  
	    URL        Associa un URL al tuo nick
	    EMAIL      Associa una E-mail al tuo nick
	    ICQNUMBER  Associa un numero icq al tuo nick
	    LOCATION   Associa una location al tuo nick
	    KILL       Attiva o disattiva la kill protection (on/off)
	    PRIVATE    Evita che il tuo nick appaia in /%S LIST
	    HIDE       Nasconde alcune parti delle info del nick
	
	Per usare questo comando tu devi autenticarti con la tua 
	password. (/%S HELP IDENTIFY per sapere come fare)
	
	Scrivi /%S HELP SET option per ulteriori informazioni
	su una opzione specifica.

NICK_HELP_SET_PASSWORD
	Sintassi: SET PASSWORD new-password
	
	Cambia la password usata per l'autenticazione.

NICK_HELP_SET_LANGUAGE
	Sintassi: SET LANGUAGE number
	
	Cambia il linguaggio dei messaggi di servizio per te
	(per esempio rispondendo a un comando che dai).
	number dovrebbe essere scelto dalla seguente lista di 
	linguaggi supportati.
	
NICK_HELP_SET_URL
	Sintassi: SET URL url
	
	Associa un URL col tuo nick. Questo URL sara' 
	visualizzato da chiunque richiede info sul tuo nick
	col comando INFO.
	
NICK_HELP_SET_EMAIL
	Sintassi: SET EMAIL address
	
	Associa una mail al tuo nick. Questo indirizzo sara' visualizzato
	a chiunque richiede info sul tuo nick col comando
	INFO.

NICK_HELP_SET_ICQ
	Sintassi: SET ICQNUMBER  #number
	
	Associa un numbero di icq (aka UIN) al tuo nick.
	Questo indirizzo sara' visualizzato a chiunque 
	richiede info sul tuo nick col comando INFO.
			
NICK_HELP_SET_LOCATION
	Sintassi: SET LOCATION  location
	
	Associa una location al nickname. 
	Questa location sara' vista sempre da chiunque 
	richiede informazioni sul tuo nick col comando
	INFO

NICK_HELP_SET_KILL
	Sintassi: SET KILL {ON | QUICK | IMMED | OFF}
	
	Switcha la protezione automatica per i kill per il tuo nick
	a on o off.Con kill protection a on, se un'altro utente prova
	a prendere il tuo nick,gli sara' dato un minuto per cambiare 
	nick,dopo il quale sara' killato da irc da %S

	Se tu selezioni QUICK, gli saranno dati solamente 20 secondi
	al posto dei soliti 60 secondi.Se tu selezioni IMMED l'utente
	sara' killato immediatamente senza chance di cambiare nick.
	Non  usare quest'opzione se non e' proprio necessario.
	Puo' anche darsi che l'amministratore del server abbia disabilitato
	quest'opzione
	
NICK_HELP_SET_PRIVATE
	Sintassi: SET PRIVATE {ON | OFF}
	
	Switcha l'opzione privacy ad on o off per il tuo nick.
	Con PRIVATE settato il tuo nick non apparira' nella lista
	dei nick generata col comando LIST di %S.
	(Comunque chiunque puo' conoscere il tuo nick prendendo
	informazioni tramite il comando INFO)

NICK_HELP_SET_HIDE
	Sintassi: SET HIDE {EMAIL | QUIT} {ON | OFF}
	
	Evita che alcune parti di informazioni possano essere
	visualizzate quando qualcuno da il %S INFO sul tuo nick.
	Tu puoi nascondere la tua mail (EMAIL) o il tuo ultimo
	messaggio di quit (QUIT).
	Il secondo aprametro sepcifica se le informazioni dovrebbero essere
	visualizzate (OFF) o nascoste (ON).

NICK_HELP_GHOST
	Sintassi: GHOST nickname [password]
	
	Termina una sessione irc "ghost" usando il tuo nick.
	Una sessione ghost e' quella che anche se non sei attualmente
	connesso il server crede che tu sia ancora online per una 
	ragione o un'altra.Tipicamente questo succede se il tuo
	computer crasha su internet o la linea del modem va giu'
	mentre sei in irc.
	
	Per usare il comando GHOST per un nick tu devi inserire
	la password relativa a quel nick

NICK_HELP_INFO
	Sintassi: INFO nickname
	
	Visualizza le informazioni riguardo un nickname,ad esempio
	il possessore del nick,l'ultimo indirizzo e il tempo e le opzioni
	del nick.

NICK_HELP_LIST
	Sintassi: LIST pattern
	
	Fa una lista di tutti i nick registrati che si riscontrano 
	nel pattern nel formato nick!user@host . I nick con l'opzione
	PRIVATE settata non saranno visualizzati.
	
	Esempi:
	
	    LIST *!joeuser@foo.com
	        Restituisce la lista di tutti i nick registrati da joeuser@foo.com.
	
	    LIST *Bot*!*@*
	        Restituisce la lista col pattern "bot" nel loro nome (case insensitive).
	
	    LIST *!*@*.bar.org
	        lista tutti i nick posseduti dagli utenti del dominio bar.org

NICK_HELP_STATUS
	Sintassi: STATUS nickname...
	
	Ritorna un valore per identificare se sei o meno l'owner del nick.
	La risposta sara' in questo formato.
	
	    nickname status-code
	
	dove nickname e' il nick che hai dato col comando e 
	status-code e' uno dei seguenti:
	
	    0 - nessun user online or nick non registrato
	    1 - l'user non e' riconosciuto come possessore del nick
	    2 - l'user e' stato riconosciuto come owner attraverso la password
	    3 - l'user e' stato riconosciuto come owner attraverso la password
	
	Oltre i 60 nick il resto sara' ignorato. Nessun messaggio di errore
	sara' restituito se non sara' dato nessun nick.

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
	%S ti permette di registrare e controllare vari 
	aspetti dei canali.   %S puo' spesso prevenire 
	i canali dai takeover limitando gli utenti che possono
	avere i privilegi di operatore. I comandi disponibili
	sono listati sotto; per usarli scrivi /%S comando.
	Oer ulteriori informazioni su un comando specifico
	scrivi /%S HELP comando.
	
	    REGISTER   Registra un canale
	    IDENTIFY   Ti autentica con la tua password
	    SET        Setta le info e le opzioni del canale
	    ACCESS     Modifica la lista di utenti privilegiati
	    AOP/SOP    Alias per modificare la lista di utenti privilegiati
	    LEVELS     Ridefinisce il significato dei livelli di accesso
	    AKICK      Mantiene una lista di autokick
	    DROP       Cancella la registrazione di un canale
	
	Altri comandi: INFO, LIST, INVITE, OP, DEOP, UNBAN,
	                KICK, CLEAR

CHAN_HELP_EXPIRES
	
	Nota che qualsiais canale che non e' usato per %d days
	(cioe' nessun utente della access list del canale e' entrato
	durante questo periodo di tempo) sara' automaticamente rimosso dalla
	lista dei canali registrati

CHAN_HELP_REGISTER
	Sintassi: REGISTER channel password description
	
	Registra un canale nel database %S. Per usare questo comando
	tu devi prima essere operatore nel canale che stai provando a 
	registrare. La password e' usata dal comando IDENTIFY per 
	permetterti di fare i cambiamenti nei settaggi del canale anche
	dopo qualche tempo. L'ultimo parametro, che must deve essere
	incluso e' una descrizione generale dei propositi del canale.
	
	Quando tu registri un canale tu sei registrato come "fondatore"
	del canale. Il fondatore del canale puo' cambiare i settaggi
	per il canale; %S puo' automaticamente dare i privilegi 
	dell'operatore-fondatore del canale quando lui/lei entra nel canale.
	Guarda il comando ACCESS (/%S HELP ACCESS) per 
	informazioni su come dare questi privilegi ad altri utenti
	del canale.
	
	NOTA: per registrare un canale tu devi prima registrare il tuo
	nick,se non l'hai fatto leggi /%s HELP per sapere come fare.

CHAN_HELP_IDENTIFY
	Sintassi: IDENTIFY channel password
	
	Ti autentica come fondatore del canale.Molti comandi 
	richiedono che tu usi questo comando prima i eseguirli.La 
	password deve essere la stessa che tu hai usato nel comando
	REGISTER

CHAN_HELP_DROP
	Sintassi: DROP channel
	
	Toglie il canale dalla lista dei chan registrati.Puo' essere usato
	dal fondatore del canale che deve usare prima il comando 
	IDENTIFY.

CHAN_HELP_SET
	Sintassi: SET channel option parameters
	
	Permette al fondatore del canale di variare molte opzioni 
	el canale ed antre infroamzioni.Il fondatore deve prima usare
	il comando IDENTIFY per autenticarsi.
	
	Opzioni disponibili:
	
	    FOUNDER     Setta il fondatore del canale
	    SUCCESSOR   Setta il successore per un canale
	    PASSWORD    Setta la password del fondatore
	    DESC        Setta la descrizione del canale
	    URL         Associa un URL col canale
	    EMAIL       Associa un email con canale
	    ENTRYMSG    Setta un messaggio che sara' mandato agli utenti che entrano nel canale
	    TOPIC       Cambia il topic sul canale
	    KEEPTOPIC   Tiene il topic quando il canale non e' in uso
	    TOPICLOCK   Il topic puo' essere cambiato solo col comando SET TOPIC
	    MLOCK       Modo del canale lock on o off
	    PRIVATE     Nasconde il canale dal comando LIST
	    RESTRICTED  Restringe l'accesso al canale
	    SECUREOPS   Controllo piu' sicuro ei chanop
	    LEAVEOPS    Nessuno puo' essere deoppato se non col comando DEOP
	    OPNOTICE    Manda un notice quando i comandi OP/DEOP sono usati
	    NOLINKS     Ignora l'autenticazione dell'access list sui nick linkati
	
	Scrivi /%S HELP option per informazioni su una particolare 
	opzione.

CHAN_HELP_SET_FOUNDER
	Sintassi: SET channel FOUNDER nick
	
	Cambia il fondatore del canale.Il nuovo nick deve essere
	registrato

CHAN_HELP_SET_SUCCESSOR
	Sintassi: SET channel SUCCESSOR nick
	
	Cambia il successore di un canale.Se il nick del fondatore scade
	o e' cancellat finche' il canale e' registrato il successore 
	diventera' il nuovo fondatore. Comunque se il successore
	ha gia' troppi canalei registrati (%d),il canale sara' cancellato
	subito se nessun successore e' gia' stato settato. Il nuovo
	nick deve essere uno gia' registrato.

CHAN_HELP_SET_PASSWORD
	Sintassi: SET channel PASSWORD password
	
	Setta la password usata per l'autenticazione del fondatore
	del canale.

CHAN_HELP_SET_DESC
	Sintassi: SET channel DESC description
	
	Setta la descrizione per il canale che sara' mostrata nei comandi
	LIST e INFO.

CHAN_HELP_SET_URL
	Sintassi: SET channel URL [url]
	
	Associates the given URL with the channel.  This URL will
	be displayed whenever someone requests information on the
	channel with the INFO command.  If no parameter is given,
	deletes any current URL for the channel.

CHAN_HELP_SET_EMAIL
	Sintassi: SET channel EMAIL [address]
	
	Associa l'indirizzo inserito col canale.
	L'indirizzo sara' visualizzato quando qualcuno richiede
	informazioni sul canale col comando INFO. Se non e' dato
	alcun parametro sara' cancellato l'indirizzo email per il 
	canale.

CHAN_HELP_SET_ENTRYMSG
	Sintassi: SET channel ENTRYMSG [message]
	
	Setta il messaggio che sara' mandato col /notice agli utenti
	quando entreranno nel canale.Se non e' inserito nessun parametro,
	nessun messaggio sara' mandato agli utenti che entrano nel
	canale.

CHAN_HELP_SET_TOPIC
	Sintassi: SET channel TOPIC topic
	
	Fa in  modo che %S setti il topic del canale al topic
	specificato nel campo "topic". questo comando e' molto utile
	se usato con SET TOPICLOCK

CHAN_HELP_SET_KEEPTOPIC
	Sintassi: SET channel KEEPTOPIC {ON | OFF}
	
	Abilita o disabilita' la permanenza del topic per un canale.
	Quando la permanenza del topic e' settat il topic per 
	il canale sar'a ricordato da %S anche quando l'ultimo utente ha
	lasciato il canale e sara' ripristinato la prossima volta
	che il canale verra' creato.

CHAN_HELP_SET_TOPICLOCK
	Sintassi: SET channel TOPICLOCK {ON | OFF}
	
	Abilita o disabilita il topic lock per un canale.
	Quando il topic lock e' attivo %S non permettera' che il topic
	del canale sia cambiato se non con il comando SET TOPIC

CHAN_HELP_SET_MLOCK
	Sintassi: SET channel MLOCK modes
	
	Setta i parametri di mode-lock per il cnaale. %S ti permetti
	di definire che alcuni modes siano sempre on.
	I modes che possono essere bloccati sono i k l m n p s e t;
	ognuno di questi modi puo' essere bloccato,non bloccato o non inserito.
	I parametri dei modi sono inseriti esattamente nella stesso modo del 
	comanmdo MODE; cioe',il modi + sono inseriti,i modi col - sono
	disinseriti.

	Warning: Se tu setti ill mode +k come nel secondo esempio
	sotto,tu dovresti anche settare l'opzione RESTRICTED per 
	il canale (vedi HELP SET RESTRICTED),o qualcuno che entrera'
	nel canale vuoto potra' vedere la password!
	
	Esempi:
	
	    SET #channel MLOCK +nt-iklps
	        Forza i modi n e t on e i modi i, k, l, p e s a off.
			Il modo m e' lasciato libero di essere sia on che off.
	
	    SET #channel MLOCK +knst-ilmp my-key
	        Forza i modi k, n, s, e t on, e i modi i, l, m,
	        and p off. Forza la password del canale a "my-key".
	
	    SET #channel MLOCK +
	        Rimuove il lock dei modes; tutti i modes del canale
			sono libri di essere sia on che off.

CHAN_HELP_SET_PRIVATE
	Sintassi: SET channel PRIVATE {ON | OFF}
	
	Abilita o disabilita l'opzione private per un canale.
	Quando private e' settata, una /%S LIST non visualizzera'
	il canale in nessuna lista.

CHAN_HELP_SET_RESTRICTED
	Sintassi: SET channel RESTRICTED {ON | OFF}
	
	Abilita o disabilita l'opzione restricted access per un canale.
	Quando essa e' settata,gli utenti che dovrebbero essere
	non autorizzati dall'avere i privilegi di operatore del canale
	(utenti con un negativo access leves e, se e' settata secure ops ,
	gli utenti che non sono sulla access list) saranno kickati e bannati
	dal canale
	
CHAN_HELP_SET_SECUREOPS
	Sintassi: SET channel SECUREOPS {ON | OFF}
	
	Abilita o disabilita l'opzione secure ops per un canale.
	Quando l'opzione e' settata,gli utenti che non sono nella userlist
	non potranno avere lo status di op.
	
CHAN_HELP_SET_LEAVEOPS
	Sintassi: SET channel LEAVEOPS {ON | OFF}
	
	Abilita o disabilita l'opzione leave ops per il canale.
	Quando essa e' settata, ChanServ non deopera' mai un itente 
	nel canale ecctto che con il comando DEOP.
	
CHAN_HELP_SET_OPNOTICE
	Sintassi: SET channel OPNOTICE {ON | OFF}
	
	Abilita o disabilita l'opzione op-notice per il canale.
	Quando essa e' attiva,il ChanServ mandera' una notice al canale
	quando sono usati i comandi OP o DEOP per un utente nel canale.
	
CHAN_HELP_SET_NOLINKS
	Sintassi: SET channel NOLINKS {ON | OFF}
	
	Abilita o disabilita l'opzione NOLINKS per un canale.
	Quando op-notice e' settata,ChanServ riconoscera' il nick
	reale come identificato nell'access list del canale.
	Questo singifica che un nick linkato ad un altro nella access
	list non sara' riconosciuto come tale

CHAN_HELP_ACCESS
	Sintassi: ACCESS channel ADD nick level
	        ACCESS channel DEL {nick | entry-num | list | ALL }
	        ACCESS channel LIST [mask | list]
	
	Mantiene l' access list per un canale. L'access list
	specifica quali utenti sono autorizzati ad avere lo status
	di chanop o ad acceere ai comandi %S nel canale. Differenti 
	user-levels permettono di accedere a differenti privilegi
	di settaggio; /%S HELP ACCESS LEVELS visualizzera' informazioni
	piu' specifiche.Se un nick non e' nell'access list avra' user level 0.
	
	Il comando ACCESS ADD un nick fornito come parametro nella
	access list dando l'user-level specificato,questo livello di accesso
	e' cambiato nel livello specificato nel comando. Il level 
	specificato deve essere meno di quello dell'utente che da il
	comando, e se il nick e' gia' nell'access list il livello
	corrente di accesso su questo nick deve essere minore di quello
	di chi da il comando.
	
	Il comando ACCESS DEL rimuove un nick dalla access list.
	Se una lista di entry numbers e' sepcificata, quelle entries 
	saranno cancellate (Vedi l'esempio per LIST sotto).
	Usando ALL cancellera' tutte le entries e restringera' il tutto
	all'utente fondatore.
	
	Il comando ACCESS LIST mostra l'access list. Se e' specificata
	una mask saranno mostrate solo le entrate corrispondenti a questa
	mask.Se e' specificato un numero saranno mostrate solo le entrate
	corrispondenti a quel numero;per esempio:
	      
		ACCESS channel LIST 2-5 7-9 	  
		  Lists access entries numbered 2 through 5 and
	      7 through 9.

CHAN_HELP_ACCESS_LEVELS
	Livelli di accesso per gli utenti
	
	Per default sono definiti i seguenti livelli di accesso
	
	   Fondatore   Pieno accesso alle funzioni di %S, autoop
					   all'entrata nel canale.Nota che solo uan persona
					   puo' avere lo status di fondatore (questo non puo' 
					   essere dato usando il comando ACCESS).
	        10   Accesso al comando AKICK; op automatico.
	         5   Op automatico.
	         3   Voice automatico.
	         0   Nessun privilegio speciale; puo' essere oppato da altri 
	                     ops (se non e' settato secure-ops).
	        <0   Non puo' essere oppato.
	
	Questi livelli possono essere cambiati,o e' possibile aggiungerne altri,
	usando il comando LEVELS; scrivi /%S HELP LEVELS per ulteriori
	informazioni

CHAN_HELP_AKICK
	Sintassi: AKICK channel ADD mask [reason]
	          AKICK channel DEL [ mask | ALL ]
	          AKICK channel LIST [mask]
	
	Mantiene una lista di Auto kick per il canale.
	Se un utente sulla list aprova a entrare nel canale,%S lo bannera'
	e lo kickera'.
	
	Il comando KICK ADD adda il nick dato o la mask nella
	lista di AutoKick.Se e' inserita una reason essa
	sara' usata quando l'utente verra' kickato; altrimenti la default
	reason sara' "You have been banned from the channel".
	
	Il comando AKICK DEL rimuove il nick o la mask inserita
	nella lista di AutoKick.Ma non rimuove i ban piazzati da AutoKick.
	Questi dovrebbero essere inseriti manualmente.Usando ALL rimuoverai
	tutto le entries di akick (l'uso di questa opzione e' ristretta 
	all'utente fondatore).
	
	Il comando AKICK LIST mostra la lista di AutoKick,o
	opzionalmente solo quelle entries di autokick che corrispondono
	con la mask inserita.

CHAN_HELP_LEVELS
	Sintassi: LEVELS channel SET type level
	          LEVELS channel {DIS | DISABLE} type
	          LEVELS channel LIST
	          LEVELS channel RESET
	
	Il comando LEVELS permette un controllo raffinato oltre
	il significato degli access levels per un canale. Con questo comando
	tu puoi definire l'access level richieso per molte funzioni
	di %S. (I comando SET FOUNDER e SET PASSWORD ,come questo
	comando,sono ristretti al fondatore del canale).
	
	Il comando LEVELS SET permette i cambiare l'access level per una
	funzione o un gruppo di funzioni. LEVELS DISABLE (o DIS breve-
	mente) disabilita ogni caratteristica automatica o non permette
	l'accesso a funzioni a nessuno tranne che al fondatore del canale.
	LEVELS LIST mostra i correnti access-levels per ogni
	funzione o gruppo di funzioni. LEVELS RESET riporta i livelli
	a quelli di default o a nuovi creati nel canale (vedi HELP 
	ACCESS LEVELS)
	
	Per una lista delle caratteristiche e delle funzioni di ogni
	livello vedi HELP LEVELS DESC.

CHAN_HELP_LEVELS_DESC
	Nota che i livelli per AUTODEOP e NOJOIN sono al massimo 
	fineche' tutti gli altri sono al minimo.

CHAN_HELP_LEVELS_DESC_FORMAT
	    %-*s  %s

CHAN_HELP_INFO
	Sintassi: INFO channel
	
	Elenca le informazioni riguardo un canale registrato,
	incluso il suo fondatore,il giorno della registrazione,
	l'ultima volta che e' stato usato,la sua descrizione e i
	modi in lock.

CHAN_HELP_LIST
	Sintassi: LIST pattern
	
	Lista tutti i canali registrati che corrispondono al pattern.
	(I canali con l'opzione PRIVATE^N settata non saranno listati.)

CHAN_HELP_OP
	Sintassi: OP #channel nick
	
	Da lo status di operatore a un nick nel canale.Di default e' 
	limitato a quelli che hanno l'access level a 5 in quel canale.

CHAN_HELP_DEOP
	Sintassi: DEOP #channel nick
	
	Toglie l'op al nick nel canale.Di default e' limitato a 
	coloro che hanno l'access level a 5 in quel canale.

CHAN_HELP_KICK
	Sintassi: KICK #channel nick reason
	
	Kicka un utente dal canale col ChanServ. Di default,limita questo
	comando a coloro i quali hanno l'access level a 5 in questo canale.

CHAN_HELP_INVITE
	Sintassi: INVITE channel
	
	Dice a %S di invitarti nel canale dato.Di default funziona
	se il tuo access livel sul canale e' piu' grande di zero.

CHAN_HELP_UNBAN
	Sintassi: UNBAN channel
	
	Dice a %S di rimuovere tutti i ban che impediscono
	il tuo accesso nel canale.Di default puoi usare questo
	comando solo se il tuo access level e' piu' grande di zero.

CHAN_HELP_CLEAR
	Sintassi: CLEAR channel what
	
	Dice a %S di rimuovere alcune condizini nel canale. 
	what puo' essere una delle seguenti.
	
	     MODES    Cancella tutti i modi del canale.
	     BANS     Toglie tutti i ban dal canale
	     OPS      Toglie l'op a tutti gli attuali op
	     VOICES   Rimuove il "voice" a tutti coloro che ce l'hanno.
		 USERS    Kicka tutti gli utenti dal canale.
		 
	Di default il tuo access level nel canale per usare questi comandi
	deve essere come minimo 10.

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
	%S e' un servizio che permette agli utenti IRC di mandare
	piccoli short message agli altri utenti irc sia che questi
	siano online o no,o in un canale(*). Sia il nick del 
	destinatario che quello del mittente devono essere registrati
	per mandare o ricevere un memo.
	
	I comandi del %S includono:
	
	    SEND   Manda un memo a un nick o a un canale
	    LIST   Elelnca i tuoi memo
	    READ   Leggi i memos       
	    DEL    Cancella uno o piu' memos
	    SET    Setta opzioni relative ai memos
	
	Scrivi /%S HELP command per l'help su uno dei comandi
	riassunti qui sopra.
	
	(*) Per default,qualsiasi utente con meno di 10 nella access-level
		su un canale puo' leggere i memos del canale.Questo puo'
		essere cambiato tramite il comando %s LEVELS.

MEMO_HELP_SEND
	Sintassi: SEND {nick | channel} memo-text
	
	Manda un memo al nick o al channel contenten il 
	memo-text. Quando lo mandi al nick il destinatario ricevera'
	un notice che lo informera' della presenza di un nuovo memo.
	Il nick o il canale a cui e' destinato il memo deve essere 
	registrato.

MEMO_HELP_LIST
	Sintassi: LIST [channel] [list | NEW]
	
	Elenca tutti i memo che hai correntemente. Col l'opzione
	NEW elenchera' solo i nuovi memos (aka "non letti").
	I memo non letti saranno segnati con un asterisco alla sinistra
	del numero del memo.Tu puoi anche specificare che li elenchi in base
	a intervalli di numeri,come nell'esempio qui sotto:

	   LIST 2-5,7-9
	      Elenca i memos dal numero 2 al 5 e dal 7 al 9.    

MEMO_HELP_READ
	Sintassi: READ [channel] {num | list | LAST | NEW}
	
	Ti manda il testo del memo che hai specifica. Se hai messo
	l'opzione LAST riceverai l'ultimo memo che ti e' stato spedito.
	Se hai messo l'opzione NEW ti mandera' tutti i piu' recenti memos.
	Ad ogni modo puoi anche ricevere un determinato memo indicandone il 
	numero (aka num). Tu puoi anche inserire una lista di numeri
	come in questo esempio.
	
	   READ 2-5,7-9
	      Visualizza i memo dal 2 al 5 e dal 7 al nove.       

MEMO_HELP_DEL
	Sintassi: DEL [channel] {num | list | ALL}
	
	Cancella il memo o i memos specificati. Tu puoi sostituire
	il numero con molti numeri o con un intervallo di numeri,come 
	nel secondo esempio qui sotto.
	
	Se e' data l'opzione ALL,essa cancellera' tutti i tuoi memos.
	
	Esempi:
	
	   DEL 1
	      Cancella il tuo primo memo.
	
	   DEL 2-5,7-9
	      Cancella i memo dal 2 al 5 e dal 7 al 9.             

MEMO_HELP_SET
	Sintassi: SET option parameters
	
	Setta alcune opzioni per i memo.Il campo option puo' 
	essere uno dei seguenti:
	
	    NOTIFY      Cambia il momento in cui ti sara' notificato
					l'arrivo di nuovi memos (solo per i nick).
	    LIMIT       Setta il numero massimo di memo che puoi
					ricevere
	
	Scrivi /%S HELP SET option per ulteriori informazioni
	su una opzione specifica.

MEMO_HELP_SET_NOTIFY
	Sintassi: SET NOTIFY {ON | LOGON | NEW | OFF}
	
	Cambia il momento in cui ti sara' notificato l'arrivo di nuovi memos:
	
	    ON      Ti sara' notificato quando entrerai in chat,  
	               quando toglierai l' /AWAY e immediatamente quando
				   saranno mandati.
	    LOGON   Ti potranno essere notificati solo quando tu entrerai in				               chat o toglierai l' /AWAY.
	    NEW     Ti saranno ntificati solo quando saranno mandati mentre
	               sei online.        
	    OFF     Non riceverai nessuna notifica dell'arrivo di nuovi memos.
	
	L'opzione ON e' essenzialmente l'unione di LOGON e NEW.

MEMO_HELP_SET_LIMIT
	Sintassi: SET LIMIT [channel] limit
	
	Setta il massimo numero di memo che tuo (o il canale specificato)
	puoi ricevere. Se tu imposterai questo numero a 0 nessuno ti potra'
	mandare memo.Comunque tu non puoi settare un numero piu'
	alto di %d.            

MEMO_HELP_INFO
	Sintassi: INFO [channel]
	
	Visualizza le informazioni sul numero di memo che hai, su quanti
	sono ancora "non letti",e quanti ne hai ricevuto in totale.
	Con un parametro visualizza le stesse informazioni riferite al canale
	inserito.

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
	    BOT         Manipulate BOT list.
	    SESSION     Session limiting info
	    
	Commands available to Services admins only:
	    SQLINE      Manipulate the SQLINE list
	    OPER        Modify the Services operator list
	    LOGONNEWS   Define messages to be shown to users at logon
	    OPERNEWS    Define messages to be shown to users who oper
	    JUPE        "Jupiter" a server
	    SET         Set various global Services options
	    GETFOUNDER  Get channel founder access privileges
	    UPDATE      Force the Services databases to be
	                    updated on disk immediately
	    QUIT        Terminate the Services program
	    RESTART     Save databases and restart Services
	    REHASH      Reloads services configuration file
	    SENDPASS    Send a nick password via email
	
	Commands available to the Services super-user only:
	    ADMIN       Modify the Services admin list
	    RAW         Send a raw string to the IRC server
	
	Notice: All commands sent to %S are logged!

OPER_HELP_GLOBAL
	Syntax: GLOBAL message
	
	Allows IRCops to send messages to all users on the network.
	The message will be sent from the nick %s.

OPER_HELP_STATS
	Syntax: STATS [AKILL | ALL]
	
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
	Evita che gli utenti siano kickati o deoppati dal canale.
NICK_AUTORECON
	Sei stato riconosciuto dall'ultima volta che hai usato ChatNow.
NICK_HELP_SET_AUTOJOIN
	Sintassi: SET AUTOJOIN {ON | OFF}

	Abilita o disabilita l'autojoin nei canali. Quando e' abilitato
	%S ti fara' entrare nei canali trovati nella AJOIN LIST subito
	dopo l'autenticazione
NICK_SET_AUTOJOIN_ON
	L'autoJoin adesso e' On
NICK_SET_AUTOJOIN_OFF
	L'autoJoin adesso e' Off
NICK_SET_AUTOJOIN_SYNTAX
	Sintassi: SET AUTOJOIN {ON | OFF}
NICK_HELP_AJOIN
	Sintassi: AJOIN { ADD | DEL | LIST } [#channel]
	
	Modifica o mostra l'Auto Join list per il tuo nick.
	Questa e' la lista del canale che saranno joinati subito
	dopo l'avvenuta autenticazione del nick.
	
	Usando /%S AJOIN NOW in qualsiasi momento potrai entrare subito
	nei canali elencati nella tua autojoin list.
NICK_AJOIN_LIST_X
	L'auto Join list per %s e' :
NICK_AJOIN_SYNTAX
	Sintassi: AJOIN { ADD | DEL | LIST } [#channel]
NICK_AJOIN_REACHED_LIMIT
	Spiacente, ma il numero massimo di canali e' %d.
NICK_AJOIN_ALREADY_PRESENT
	Il canale e' gia' nella lista.
NICK_AJOIN_ADDED
	Il canale %s e' stato addato alla tua lista.
NICK_AJOIN_NOT_FOUND
	Il canale %s non e' stato trovato nella tua lista.
NICK_AJOIN_DELETED
	Il canale %s e' stato cancellato dalla tua lista.
NICK_AJOIN_LIST
	Auto Join list:
NICK_INFO_OPT_AUTOJOIN
	Auto Join
BAD_CHAN_NAME
	Il canale deve essere nel formato: #Channel
OPER_IDENTIFY_REQUIRED
	Le regole di sicurezza restringono l'operatore
	a identificarsi e l'OperServ a registrare i nick.
	Perfavore contatta l'IRC admin per ulteriori info.
	(Puoi anche joinare #ChatNow,li troverai li').
NICK_ALREADY_IDENTIFIED
	Il nick e' gia' stato identificato.
TODAYSTATS
	Statistiche per oggi (%s):i
	
STATS_TOTAL
	Totale: %d
STATS_REGISTERED
	Registati: %d
STATS_DROPPED
	Cancellati: %d
STATS_EXPIRED
	Scaduti: %d
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
	Questo nick non e' registrato,registralo,ti sara' utile in futuro!
	Per farlo usa il comando /%s REGISTER password email.
	Se non hai un account di mail puoi' inserire il parametro NOMAIL.
	come email.
CHANGE_IN_1_MINUTE
	Se non cambi il nick entro minuto il tuo nick sara' cambiato
NICK_AJOIN_EMPTY
	La lista di autojoin e' vuota
FEATURE_DISABLED
	Questi servizi non sono disponibili su questo server.
CHAN_ACCESS_LIST_FORMAT2
	  %3d  %4d  %s%s%s%s by %s
NICK_AUTORECON_R
	Auto nick recognition on +r mode.
NICK_STATUS_0
	STATUS for %s : 0 - nessun utente online o nick non registrato
NICK_STATUS_1
	STATUS for %s : 1 - l'user non e' stato riconosciuto come proprietario del nick
NICK_STATUS_2
	STATUS for %s : 2 - l'user e' stato riconosciuto attraverso l'identificazione via mode
NICK_STATUS_3
	STATUS for %s : 3 - l'user e' stato riconosciuto attraverso l'autenticazione con password
OPER_HELP_SQLINE
	Syntax: SQLINE ADD nick reason
	        SQLINE DEL  nick
	        SQLINE LIST [mask]
	        SQLINE VIEW [mask]
	
	Allows Services operators to manipulate the SQLINE list.
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
	Indirizzo email non riconosciuto!
	Usa il formato user@mailserver o NOMAIL al posto del mail address.
BAD_ICQNUMBER
	Numero di ICQ errato.
	Usa un #numero_di_icq 
BAD_LOCATION
	Nessuna Location.
	Inserisci una location piu' breve.
CHAN_DROP_AT
	Il canale sara' rimosso in %d giorni.
CHAN_DROP_CANCEL
	La richiesta di cancellazione per il canale %s e' stata annullata.
NICK_DROP_AT
	The nick will drop in %d day(s).
NICK_DROP_CANCEL
	The drop requested for the nick at %s was canceled.
OPER_STATS_USERS_RECORD
	Il picco di utenti e' %d su %s 
	Attualmente ci sono %d utenti (%d%)
	-
OPER_STATS_OPERS_RECORD
	Il picco di op e' stato %d su %s
	Attualmente ci sono %d op (%d%)
	-
OPER_STATS_HELPERS_RECORD
	Helpers record was %d on %s
	Currently there are %d helper(s) (%d%)
	-
OPER_STATS_BOTS_RECORD
	Il picco di bot e' stato %d su %s
	Attualmente ci sono %d bot (%d%)
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
	    SUBCRIBE UNSUBSCRIBE

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
	This command allows you to subcribe a news subject.
	
	Syntax: SUBSCRIBE  number [,number] | ALL
	
	You can subscribe multiple subjects with one command,
	using numbers separated with comas.
NEWSS_SUBSCRIBE_SUBSCRIBED
	You have subscribed %d subjects.
NEWSS_UNSUBSCRIBE_SYNTAX
	UNSUBSCRIBE  number [,number] | ALL
NEWSS_UNSUBSCRIBE_HELP
	This command allows you to unsubcribe a news subject.
	
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
	Le info per %s sono private.
CHAN_INFO_PRIVATE
	Le info per il canale %s sono private.
CHAN_NEED_REGNICK
	Tu devi usare un nick registrato per entrare nel canale!
CHAN_MODE_PROTECTED
	Il canale usa il join protection mode.  
NEWS_REC_PLEASE_WAIT
	Perfavore aspetta %d secondi prima di usare il comando RECENT di nuovo.
NICK_HELP_NOTES
	Permette agli utenti di conseravare note di testo.
	Per conservare una nota scrivi /%S NOTES ADD text
	Per cancellare una nota scrivi /%S NOTES DEL number
	Per vedere l'elenco delle note scrivi /%S NOTES LIST
NICK_NOTES_SYNTAX
	LIST | ADD text | DEL number
NICK_NOTES_ADDED
	La nota e' stata aggiunta col numero %d.
NICK_NOTES_NOADD
	Tu hai aggiunto il massimo numero di note(%d) autorizzato 
	per il tuo nick,devi cancellarne qualcuna prima di inserirne una nuova.
NICK_NOTES_DELETED
	La nota corrispondente al numero %d e' stata cancellata.
NICK_NOTES_NOTFOUND
	La nota corrispondente al numero %d non e' stata trovata.
NICK_NOTES_LIST_HEADER
	Nessuna nota
NICK_NOTES_LIST
	%2d %s
NICK_NOTES_NONOTES
	La note list e' vuota.
CHAN_ACCESS_CLEARALL
	L'access list e' vuota.
CHAN_AKICK_CLEARALL
	L'AKICK list e' vuota.
NICK_STATUS_SYNTAX
	STATUS nick
NICK_X_ISFOUNDER
	%s e' il fondatore,non puo' essere settato come successore.
NICK_X_ISSUCCESSOR
	%s e' il successore e non puo' essere settato come fondatore.

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
	Hosts with atleast %d sessions:
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
	Syntax: VLINE ADD file reason
	        VLINE DEL  file
	        VLINE LIST [pattern]
	        VLINE VIEW [pattern]
	
	Allows Services operators to manipulate the VLINE list.
	V-Lined file patterns will block DCC SENDs and set the sender
	+v so it will not be able to DCC SEND again.
OPER_TOO_MANY_VLINE
	Sorry, VLINE list is full.
OPER_VLINE_JUST_NICK
	You can only use file/wildcards on VLINE list.
OPER_VLINE_ADDED
	New VLINE added for %s
OPER_VLINE_ADD_SYNTAX
	VLINE ADD file reason
OPER_VLINE_DEL_SYNTAX
	VLINE DEL file reason
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
	AOP ADD nick | DEL nick | LIST
CHAN_HELP_SOP
	Alias for ACC-CHANGE access list managment.
	SOP ADD will add the nick to the channel access list with
	ACC-CHANGE level.
	SOP LIST will list all channel access entries with ACC-CHANGE level.	
CHAN_SOP_SYNTAX
	SOP ADD nick | DEL nick | LIST
CHAN_AJOIN_ADD
	You should add the channel to your ajoin list with /%s AJOIN ADD %s

# SENDPASS responses
OPER_SENDPASS_SYNTAX
	SENDPASS nickname
OPER_SENDPASS_NOSENDMAIL
	SENDPASS comando non disponibile perche' non e' stato trovato il sendmail!
OPER_SENDPASS_UNAVAILABLE
	SENDPASS comando non disponibile perche' e' il uso la criptazione delle password.
OPER_SENDPASS_NOMAIL
	Il nick %s non ha settato nessuna mail!
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
	PLEASE DON'T ANSWER TO THIS MAIL!
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
	I tuoi memo %s scadranno presto.
MEMO_HAVE_EXPIRED
	I tuoi memo %s sono scaduti.
CHAN_LIST_SERVADMIN_SYNTAX
	LIST pattern [FORBIDDEN] [NOEXPIRE]
