/* Various routines to perform simple actions.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services
 */

#include "services.h"

/*************************************************************************/

/* Remove a user from the IRC network.  `source' is the nick which should
 * generate the kill, or NULL for a server-generated kill.
 */

void kill_user(const char *source, const char *user, const char *reason)
{
    char *av[2];
    char buf[BUFSIZE];

    if (!user || !*user)
	return;
    if (!source || !*source)
	source = ServerName;
    if (!reason)
	reason = "";
    snprintf(buf, sizeof(buf), "%s (%s)", source, reason);
    av[0] = sstrdup(user);
    av[1] = buf;
    send_cmd(source, "KILL %s :%s", user, av[1]);
    do_kill(source, 2, av);
    free(av[0]);
}


/*************************************************************************/

/* Note a bad password attempt for the given user.  If they've used up
 * their limit, toss them off.
 */

void bad_password(User *u)
{
    time_t now = time(NULL);

    if (!BadPassLimit)
	return;

    if (BadPassTimeout > 0 && u->invalid_pw_time > 0
			&& u->invalid_pw_time < now - BadPassTimeout)
	u->invalid_pw_count = 0;
    u->invalid_pw_count++;
    u->invalid_pw_time = now;
    if (u->invalid_pw_count >= BadPassLimit)
	kill_user(NULL, u->nick, "Too many invalid passwords");
}

/*************************************************************************/
