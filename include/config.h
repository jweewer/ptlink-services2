/* Services configuration.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services 
 */

#ifndef CONFIG_H
#define CONFIG_H

/* Note that most of the options which used to be here have been moved to
 * services.conf. */

/*************************************************************************/

/******* General configuration *******/

/* Name of configuration file (in Services directory) */
#define SERVICES_CONF	"services.conf"

/* Name of services pid file (in etc directory) */
#define PIDFilename     "services.pid"

/* Name of log file (in Services directory) */
#define LOG_FILENAME	"services.log"

/* Maximum amount of data from/to the network to buffer (bytes). */
#define NET_BUFSIZE	65536


/******* OperServ configuration *******/

/* What is the maximum number of Services admins we will allow? */
#define MAX_SERVADMINS	16

/* What is the maximum number of Services operators we will allow? */
#define MAX_SERVOPERS	64

/* How big a hostname list do we keep for clone detection?  On large nets
 * (over 500 simultaneous users or so), you may want to increase this if
 * you want a good chance of catching clones. */
#define CLONE_DETECT_SIZE 16

/* Define this to enable OperServ's debugging commands (Services root
 * only).  These commands are undocumented; "use the source, Luke!" */
/* #define DEBUG_COMMANDS */

/******* ChanServ configuration *******/
/* Defines the range of levels that can be used on the access list 
 * NOTE: Using absolute values >= 10000 will break servicese
 */
#define CHAN_LEVEL_MAX	9999
#define CHAN_LEVEL_MIN -9999

/******************* END OF USER-CONFIGURABLE SECTION ********************/

/* Define so servics will try to set ulimit in order to force core dump */
#define FORCE_CORE

/* Size of input buffer (note: this is different from BUFSIZ)
 * This must be big enough to hold at least one full IRC message, or messy
 * things will happen. */
#define BUFSIZE		1024


/* Extra warning:  If you change these, your data files will be unusable! */

/* Maximum length of a channel name, including the trailing null.  Any
 * channels with a length longer than (CHANMAX-1) including the leading #
 * will not be usable with ChanServ. */
#define CHANMAX		64

/* Maximum length of a nickname, including the trailing null.  This MUST be
 * at least one greater than the maximum allowable nickname length on your
 * network, or people will run into problems using Services!  The default
 * (32) works with all servers I know of. */
#define NICKMAX		32

/* Maximum length of a password */
#define PASSMAX		32

/* Maximum length of a auth code */
#define AUTHMAX		16

/* Maximum length of a memo preview */
#define MEMOPREVMAX	20

/**************************************************************************/

#endif	/* CONFIG_H */
