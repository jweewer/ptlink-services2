/* Session Limiting functions.
 * Based on code by Andrew Kempe (TheShadow)
 *     E-mail: <theshadow@shadowfire.org>
 *
 * Services is copyright (c) 1996-1999 Andrew Church.
 *     E-mail: <achurch@dragonfire.net>
 * Services is copyright (c) 1999-2000 Andrew Kempe.
 *     E-mail: <theshadow@shadowfire.org>
 * This program is free but copyrighted software; see the file COPYING for
 * details.

 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 * http://www.ptlink.net/Coders/ - coders@PTlink.net
 
 * Lamego@PTlink.net -> removed exceptions (are overruled using the botlist)
 * akill is only added on a retry count penalty rule (5 connections attempts)
 */

/*************************************************************************/

#ifndef STREAMLINED

/*************************************************************************/

#include "services.h"
#include "pseudo.h"
#include "hash.h"

/*************************************************************************/

/* SESSION LIMITING
 *
 * The basic idea of session limiting is to prevent one host from having more 
 * than a specified number of sessions (client connections/clones) on the 
 * network at any one time. To do this we have a list of sessions and 
 * exceptions. Each session structure records information about a single host, 
 * including how many clients (sessions) that host has on the network. When a 
 * host reaches it's session limit, no more clients from that host will be 
 * allowed to connect.
 *
 * When a client connects to the network, we check to see if their host has 
 * reached the default session limit per host, and thus whether it is allowed 
 * any more. If it has reached the limit, we kill the connecting client; all 
 * the other clients are left alone. Otherwise we simply increment the counter 
 * within the session structure. When a client disconnects, we decrement the 
 * counter. When the counter reaches 0, we free the session.
 *
 * Exceptions allow one to specify custom session limits for a specific host 
 * or a range thereof. The first exception that the host matches is the one 
 * used.
 *
 * "Session Limiting" is likely to slow down services when there are frequent 
 * client connects and disconnects. The size of the exception list can also 
 * play a large role in this performance decrease. It is therefore recommened 
 * that you keep the number of exceptions to a minimum. A very simple hashing 
 * method is currently used to store the list of sessions. I'm sure there is 
 * room for improvement and optimisation of this, along with the storage of 
 * exceptions. Comments and suggestions are more than welcome!
 *
 * -TheShadow (02 April 1999)
 */

/*************************************************************************/



/* I'm sure there is a better way to hash the list of hosts for which we are
 * storing session information. This should be sufficient for the mean time.
 * -TheShadow */

#define HASH(host)      (((host)[0]&31)<<5 | ((host)[1]&31))

static Session *sessionlist[1024];
static int32 nsessions = 0;


/*************************************************************************/

static Session *findsession(const char *host);

/*************************************************************************/
/****************************** Statistics *******************************/
/*************************************************************************/

void get_session_stats(long *nrec, long *memuse)
{
    Session *session;
    long mem;
    int i;

    mem = sizeof(Session) * nsessions;
    for (i = 0; i < 1024; i++) {
    	for (session = sessionlist[i]; session; session = session->next) {
	    mem += strlen(session->host)+1;
        }
    }

    *nrec = nsessions;
    *memuse = mem;
}


/*************************************************************************/
/************************* Session List Display **************************/
/*************************************************************************/

/* Syntax: SESSION LIST threshold
 *	Lists all sessions with atleast threshold clients.
 *	The threshold value must be greater than 1. This is to prevent 
 * 	accidental listing of the large number of single client sessions.
 *
 * Syntax: SESSION VIEW host
 *	Displays detailed session information about the supplied host.
 */

void do_session(User *u)
{
    Session *session;
    char *cmd = strtok(NULL, " ");
    char *param1 = strtok(NULL, " ");
    User *user;
    int mincount;
    int i;
    if (!cmd)
        cmd = "";

    if (strcasecmp(cmd, "LIST") == 0) {
	if (!param1) {
	    syntax_error(s_OperServ, u, "SESSION", OPER_SESSION_LIST_SYNTAX);

	} else if ((mincount = atoi(param1)) <= 1) {
	    notice_lang(s_OperServ, u, OPER_SESSION_INVALID_THRESHOLD);

	} else {
	    notice_lang(s_OperServ, u, OPER_SESSION_LIST_HEADER, mincount);
	    notice_lang(s_OperServ, u, OPER_SESSION_LIST_COLHEAD);
    	    for (i = 0; i < 1024; i++) {
            	for (session = sessionlist[i]; session; session=session->next) 
		{
            	    if (session->count >= mincount)
                        notice_lang(s_OperServ, u, OPER_SESSION_LIST_FORMAT,
                    	            session->count, session->host);
                }
    	    }
	}
    } else if (strcasecmp(cmd, "VIEW") == 0) {
        if (!param1) {
	    syntax_error(s_OperServ, u, "SESSION", OPER_SESSION_VIEW_SYNTAX);

        } else {
	    session = findsession(param1);
	    if (!session) {
		notice_lang(s_OperServ, u, OPER_SESSION_NOT_FOUND, param1);
	    } else {
	        int limit=check_botlist(param1);
		/* If limit == 0, then there is no limit - reply must include
		 * this information. e.g. "... with no limit.".
		 */

	        notice_lang(s_OperServ, u, OPER_SESSION_VIEW_FORMAT,
				param1, session->count, 
				limit ? limit : DefSessionLimit);
	    }
        }
    } else if (strcasecmp(cmd, "TRACE") == 0) {
        if (!param1) {
	    syntax_error(s_OperServ, u, "SESSION", OPER_SESSION_TRACE_SYNTAX);

        } else {
	    session = findsession(param1);
	    if (!session) {
		notice_lang(s_OperServ, u, OPER_SESSION_NOT_FOUND, param1);
	    } else {
		notice_lang(s_OperServ, u, OPER_SESSION_TRACE_BEGIN,param1);
		for (user =  hash_next_user(1); user; user =  hash_next_user(0)) {
		    if (user->session == session) {
	    		notice_lang(s_OperServ, u, OPER_SESSION_TRACE_FORMAT,user->nick);			
		    }
		}		
		notice_lang(s_OperServ, u, OPER_SESSION_TRACE_END);
	    }
        }


    } else {
	syntax_error(s_OperServ, u, "SESSION", OPER_SESSION_SYNTAX);
    }
}

/*************************************************************************/
/********************* Internal Session Functions ************************/
/*************************************************************************/

static Session* findsession(const char *host)
{
    Session *session;
    int i;

    if (!host)
	return NULL;

    for (i = 0; i < 1024; i++) {
        for (session = sessionlist[i]; session; session = session->next) {
            if (strcasecmp(host, session->host) == 0) {
                return session;
            }
        }
    }

    return NULL;
}

/* Attempt to add a host to the session list. If the addition of the new host
 * causes the the session limit to be exceeded, kill the connecting user.
 * Returns 1 if the host was added or 0 if the user was killed.
 
 *  Lamego
 *  use limit argument or Default if limit is 0
 *  Send language string instead of configured string
 *  to take advantage of multi-language.
 */

Session* add_session(const char *nick, const char *host, int limit)
{
    char buf[512];
    Session *session, **list;
    int sessionlimit = 0;	
    session = findsession(host);

    if (session) 
	  {
	  
		if(session->penalty>10)
		  { /* this session is glined */
			(session->count)++;
			return session;
		  }
		    
		sessionlimit = limit ? limit : DefSessionLimit;	  
		/* Dependent session number will be managed by botlist */
		if (sessionlimit && (session->count >= sessionlimit)) 
		  {
#ifdef JUSTMSG
	  		send_cmd(s_OperServ,"PRIVMSG %s :%s",
		  	  nick,getstring(NULL,OPER_SESSION_EXCEEDED));
#else
	  		send_cmd(s_OperServ,"NOTICE %s :%s",
		  	  nick,getstring(NULL,OPER_SESSION_EXCEEDED));
#endif
		    /* We don't use kill_user() because a user stucture has not yet
		     * been created. Simply kill the user. -TheShadow
			 */

						
	  		if((session->penalty++)>5)
	  		  {
				sprintf(buf, "*@%s",host);
				log2c("%s: Adding gline on %s on session limit exceed with nick %s",s_OperServ,
		  		  buf,nick);
				  
				wallops(s_OperServ,
		  		  "Adding gline on \02%s\02 on session limit exceed with nick \02%s\02",
		  		  buf,nick);
				  
				send_cmd(s_OperServ,"GLINE *@%s %lu %s :Maximum connections for your host exceed",
					host,(long) CLONEGLINETIME, s_OperServ);
				/* signal session as glined */
				session->penalty=11;
				session->count++;
				return session;
			  }
			else 
			  {
				log2c("%s: Killing %s for session limit on %s",s_OperServ, nick, host);			
			  	send_cmd(s_OperServ, "KILL %s :%s (Session limit exceeded)", nick, s_OperServ);				
				return NULL;	
			  }
		  } 
		else 
		  {
	  		session->count++;
	  		return session;
		  }
  	  }
	
    nsessions++;
    session = scalloc(sizeof(Session), 1);
    session->host = sstrdup(host);
    session->penalty = 0;
    list = &sessionlist[HASH(session->host)];
    session->next = *list;
    if (*list)
        (*list)->prev = session;
    *list = session;
    session->count = 1;
    return session;
}

void delete_session(Session* session)
{
    if (debug >= 2)
        log1("debug: del_session() called");

    if (!session) {
	wallops(s_OperServ, 
		"WARNING: Tried to delete non-existant session\2");
	log1("session: Tried to delete non-existant session");
	return;
    }

    if (session->count > 1) {
	session->count--;
	return;
    }

    if (session->prev)
        session->prev->next = session->next;
    else
        sessionlist[HASH(session->host)] = session->next;
    if (session->next)
        session->next->prev = session->prev;

    if (debug >= 2)
        log1("debug: del_session(): free session structure");

    free(session->host);
    free(session);

    nsessions--;

    if (debug >= 2)
        log1("debug: del_session() done");
}



/*************************************************************************/

#endif	/* !STREAMLINED */

/*************************************************************************/
