/* ircdsetup.h

 * << ircd features configuration >>
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2004
 * http://www.ptlink.net/Coders/ - Coders@PTlink.net
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 * 
 * $Id: ircdsetup.h,v 1.4 2004/11/21 12:10:19 jpinto Exp $ 
 */

 
#include "sysconf.h"

/* Gline time for session limit exceed (seconds) */
#define CLONEGLINETIME 300

/* your ircd supports NEWS raw for news delivering ? */
#define NEWS

/* define to use PRVIMSG's instead of NOTICES */
#undef JUSTMSG

/* define maximum number of chars allowed for a nick  */
#define IRCDNICKMAX 21

/* Current supported TS protocol */
#define TS_CURRENT 9

/* Minimum supported TS protocol */
#define TS_MIN 7

/* define if you want to use halfops
 * WARNING: this feature is expirimental!!!!
 */
#undef HALFOPS
