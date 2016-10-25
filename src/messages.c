/* Definitions of IRC message functions and list of messages.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2002
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * This services are based on Andy Church Services 
 */

#include "services.h"
#include "messages.h"
#include "language.h"
#include "ircdsetup.h"
#include "options.h"
#include "patchlevel.h"

/* List of messages is at the bottom of the file. */

/*************************************************************************/
/*************************************************************************/

static void m_nickcoll(char *source, int ac, char **av)
{
    if (ac < 1)
	return;
    if (!skeleton && !readonly)
	introduce_user(av[0]);
}

/*************************************************************************/

static void m_ping(char *source, int ac, char **av)
{
    if (ac < 1)
	return;
    send_cmd(ServerName, "PONG %s ", ac>1 ? av[1] : ServerName);
    ccompleted = 1;
}

/*************************************************************************/

static void m_away(char *source, int ac, char **av)
{
    User *u = finduser(source);

    if (u && (ac == 0 || *av[0] == 0))	/* un-away */
	check_memos(u);
}

/*************************************************************************/

static void m_join(char *source, int ac, char **av)
{
    if (ac != 1)
	return;
    do_join(source, ac, av);
}

/*************************************************************************/

static void m_sjoin(char *source, int ac, char **av)
{
    do_sjoin(source, ac, av);
}

static void m_njoin(char *source, int ac, char **av)
{
    do_sjoin(source, ac, av);
}

static void m_snick(char *source, int ac, char **av)
{
    if (ac!=9 && ac!=10) {
	    log2c("debug: NICK message: expecting 9 or 10 parameters after "
	        "parsing; got %s",merge_args(ac, av));
	return;
    }
    do_snick(source, ac, av);
}

static void m_nnick(char *source, int ac, char **av)
{
    if (ac!=9 && ac!=10) {
	    log2c("debug: NICK message: expecting 9 or 10 parameters after "
	        "parsing; got %s",merge_args(ac, av));
	return;
    }
    do_snick(source, ac, av);
}

/*************************************************************************/

static void m_kick(char *source, int ac, char **av)
{
    if (ac != 3)
	return;
    do_kick(source, ac, av);
}

/*************************************************************************/

static void m_kill(char *source, int ac, char **av)
{
    if (ac != 2)
	return;
    /* Recover if someone kills us. */
    if (strcasecmp(av[0], s_OperServ) == 0 ||
        strcasecmp(av[0], s_NickServ) == 0 ||
        strcasecmp(av[0], s_ChanServ) == 0 ||
        strcasecmp(av[0], s_MemoServ) == 0 ||
        strcasecmp(av[0], s_NewsServ) == 0 ||
        strcasecmp(av[0], s_GlobalNoticer) == 0
    ) {
	if (!readonly && !skeleton)
	    introduce_user(av[0]);
    } else do_kill(source, ac, av);
}

/*************************************************************************/

static void m_mode(char *source, int ac, char **av)
{
    if (*av[0] == '#' || *av[0] == '&') {
	if (ac < 2)
	    return;
	do_cmode(source, ac, av);
    } else {
	if (ac != 2)
	    return;
	do_umode(source, ac, av);
    }
}

/*************************************************************************/

static void m_motd(char *source, int ac, char **av)
{
    FILE *f;
    char buf[BUFSIZE];

    f = fopen(MOTDFilename, "r");
    send_cmd(ServerName, "375 %s :- %s Message of the Day",
		source, ServerName);
   if (f) {
	while (fgets(buf, sizeof(buf), f)) {
	    buf[strlen(buf)-1] = 0;
	    send_cmd(ServerName, "372 %s :- %s", source, buf);
	}
	fclose(f);
    } else {
	  send_cmd(ServerName, "372 %s :- MOTD file not found!  Please "
			"contact your IRC administrator.", source);
    }

    /* Look, people.  I'm not asking for payment, praise, or anything like
     * that for using Services... is it too much to ask that I at least get
     * some recognition for my work?  Please don't remove the copyright
     * message below.
     */

    send_cmd(ServerName, "372 %s :-", source);
    send_cmd(ServerName, "372 %s :- PTlink Services is copyright (c) "
		"1999-2003 PTlink IRC Software ", source);
    send_cmd(ServerName, "372 %s :- Based on Services 4.2.4 "
		"1996-1999 Andy Church Services", source);
    send_cmd(ServerName, "376 %s :End of /MOTD command.", source);
}

/*************************************************************************/
static void m_nick(char *source, int ac, char **av)
{
    if ((!*source && ac != 9) || (*source && ac != 2)) 
	  {		
	    log2c("debug: NICK message: expecting 2 or 9 parameters after "
	        "parsing; got %d, source=`%s'", ac, source);
		if(!*source) 
		  {
			log2c("Killing invalid user %s", av[0]);		
			send_cmd(s_NickServ, "KILL %s :Invalid user", av[0]);
		  }
  		  return;
		
    }
    do_nick(source, ac, av);
}


/*************************************************************************/

static void m_part(char *source, int ac, char **av)
{
    if (ac < 1 || ac > 2)
	return;
    do_part(source, ac, av);
}

/*************************************************************************/

static void m_privmsg(char *source, int ac, char **av)
{
    time_t starttime, stoptime;	/* When processing started and finished */
    char *s;

    if (ac != 2)
	return;

    /* Check if we should ignore.  Operators always get through. */
    if (allow_ignore && !is_oper(source)) {
	IgnoreData *ign = get_ignore(source);
	if (ign && ign->time > time(NULL)) {
	    log1("Ignored message from %s: \"%s\"", source, inbuf);
	    return;
	}
    }

    /* If a server is specified (nick@server format), make sure it matches
     * us, and strip it off. */
    s = strchr(av[0], '@');
    if (s) {
	*s++ = 0;
	if (strcasecmp(s, ServerName) != 0) {
	    log2c("Got invalid direction message for @%s",s);
	    return;
	}
    }
    starttime = time(NULL);

    if (strcasecmp(av[0], s_OperServ) == 0) {
	if (is_oper(source)) {
	    operserv(source, av[1]);
	} else {
	    User *u = finduser(source);
	    if (u)
		notice_lang(s_OperServ, u, ACCESS_DENIED);
	    else
		notice(s_OperServ, source, "Access denied.");
	    if (WallBadOS)
		wallops(s_OperServ, "Denied access to %s from %s (non-oper)",
			s_OperServ, source);
	}
    } else if (strcasecmp(av[0], s_NickServ) == 0) {
	nickserv(source, av[1]);
    } else if (strcasecmp(av[0], s_ChanServ) == 0) {
	chanserv(source, av[1]);
    } else if (strcasecmp(av[0], s_MemoServ) == 0) {
	memoserv(source, av[1]);
    } else if (strcasecmp(av[0], s_NewsServ) == 0) {
	newsserv(source, av[1]);	
    }

    /* Add to ignore list if the command took a significant amount of time. */
    if (allow_ignore) {
	stoptime = time(NULL);
	if (stoptime > starttime && *source && !strchr(source, '.'))
	    add_ignore(source, stoptime-starttime);
    }
}

/*************************************************************************/

static void m_quit(char *source, int ac, char **av)
{
    if (ac != 1)
	return;
    do_quit(source, ac, av);
}

/*************************************************************************/

static void m_stats(char *source, int ac, char **av)
{
    if (ac < 1)
	return;
    switch (*av[0]) {
      case 'u': {
	int uptime = time(NULL) - start_time;
	send_cmd(NULL, "242 %s :Services up %d day%s, %02d:%02d:%02d",
		source, uptime/86400, (uptime/86400 == 1) ? "" : "s",
		(uptime/3600) % 24, (uptime/60) % 60, uptime % 60);
	send_cmd(NULL, "250 %s :Current users: %d (%d ops); maximum %d",
		source, Count.users, Count.opers, Count.users_max);
	send_cmd(NULL, "219 %s u :End of /STATS report.", source);
	break;
      } /* case 'u' */

      case 'l':
	send_cmd(NULL, "211 %s Server SendBuf SentBytes SentMsgs RecvBuf "
		"RecvBytes RecvMsgs ConnTime", source);
	send_cmd(NULL, "211 %s %s %d %d %d %d %d %d %ld", source, RemoteServer,
		read_buffer_len(), total_read, -1,
		write_buffer_len(), total_written, -1,
		(long int) start_time);
	send_cmd(NULL, "219 %s l :End of /STATS report.", source);
	break;

      case 'c':
      case 'h':
      case 'i':
      case 'k':
      case 'm':
      case 'o':
      case 'y':
	send_cmd(NULL, "219 %s %c :/STATS %c not applicable or not supported.",
		source, *av[0], *av[0]);
	break;
    }
}

/*************************************************************************/

static void m_time(char *source, int ac, char **av)
{
    time_t t;
    struct tm *tm;
    char buf[64];

    time(&t);
    tm = localtime(&t);
    strftime(buf, sizeof(buf), "%a %b %d %H:%M:%S %Y %Z", tm);
    send_cmd(NULL, "391 %s :%s", source,buf);
}

/*************************************************************************/

static void m_topic(char *source, int ac, char **av)
{
    if (ac != 4)
	return;
    do_topic(source, ac, av);
}


/*************************************************************************/

void m_version(char *source, int ac, char **av)
{
    if (source)
	send_cmd(ServerName, "351 %s %s %s :--",
			source, PATCHLEVEL, ServerName);
}

/*************************************************************************/

void m_whois(char *source, int ac, char **av)
{
    const char *clientdesc;

    if (source && ac >= 1) {
	if (strcasecmp(av[0], s_NickServ) == 0)
	    clientdesc = desc_NickServ;
	else if (strcasecmp(av[0], s_ChanServ) == 0)
	    clientdesc = desc_ChanServ;
	else if (strcasecmp(av[0], s_MemoServ) == 0)
	    clientdesc = desc_MemoServ;
	else if (strcasecmp(av[0], s_NewsServ) == 0)
	    clientdesc = desc_NewsServ;
	else if (strcasecmp(av[0], s_OperServ) == 0)
	    clientdesc = desc_OperServ;
	else if (strcasecmp(av[0], s_GlobalNoticer) == 0)
	    clientdesc = desc_GlobalNoticer;
	else {
	    send_cmd(ServerName, "401 %s %s :No such service.", source, av[0]);
	    return;
	}
	send_cmd(ServerName, "311 %s %s %s %s :%s", source, av[0],
		ServiceUser, ServiceHost, clientdesc);
	send_cmd(ServerName, "312 %s %s %s :%s", source, av[0],
		ServerName, ServerDesc);
	send_cmd(ServerName, "318 End of /WHOIS response.");
    }
}
void m_capab(char *source, int ac, char **av)    
{
    char *capab = NULL;    
    char *capabval;
    
    if(ac!=1)
      log1("Invalid argument count(%i) for CAPAB!", ac);

    capab = strtok(av[0]," ");
    while(capab)
      {
        if(strncmp(capab,"PREFIX=",7)==0)
          {
            capabval=strtok(capab+7," ");
            if(capabval)
              {
 /*               strcpy(HostPrefix,capabval); */
              }
          }
        capab = strtok(NULL," ");          
      }
}


void m_umode(char *source, int ac, char **av)    
{
    av[1]=av[0];
    av[0]=source;
    do_umode(source,2,av);
}

/*
    added server domain to domains list, for global messages
*/
void m_server(char *source, int ac, char **av)
{
	char *ver;
	int  verflags;
	log2c("Server connected: %s using version %s",av[0], av[2]);
	ver = strchr(av[2],'_');
	verflags=ver ? atoi(ver) : 0;
    	add_send_domain(av[0]);
}

/** 
 ** av[0]= newmask
 **/
void m_newmask(char *source, int ac, char **av)
  {
	char	*newhost = NULL, *newuser = NULL;
	User *u = finduser(source);
	
    if (!u)
	    return ;
		
	newhost = strchr(av[0],'@');
	    
	if(newhost)
	  {
		(*newhost++) = '\0';
	        newuser = av[0];  
	  } 
	else    
	  newhost = av[0];
	  
	if(newhost)
	  {
		if(u->hiddenhost) 
		  free(u->hiddenhost);
		u->hiddenhost = sstrdup(newhost);
	  }

	if(newuser && *newuser)
	  {
		if(u->username) 
		   free(u->username);
		u->username = sstrdup(newuser);
	  }
		
	}

/*************************************************************************/
/*************************************************************************/

Message messages[] = {

    { "436",       m_nickcoll },
    { "AWAY",      m_away },
    { "JOIN",      m_join },
    { "SJOIN",     m_sjoin},
    { "NJOIN",     m_njoin},    
    { "NNICK",	   m_nnick}, /* we will need it soon */
    { "SNICK",	   m_snick},
    { "UMODE",	   m_umode},
    { "KICK",      m_kick },
    { "KILL",      m_kill },
    { "MODE",      m_mode },
    { "SAMODE",	   m_mode },
    { "MOTD",      m_motd },
    { "NICK",      m_nick },
    { "NOTICE",    NULL },
    { "PART",      m_part },
    { "PASS",      NULL },
    { "PING",      m_ping },
    { "PONG",      NULL },
    { "PRIVMSG",   m_privmsg },
    { "QUIT",      m_quit },
    { "SERVER",    m_server },
    { "SQUIT",     NULL },
    { "STATS",     m_stats },
    { "TIME",      m_time },
    { "TOPIC",     m_topic },
    { "VERSION",   m_version },
    { "WALLOPS",   NULL },
    { "WHOIS",     m_whois },
    { "NEWMASK",   m_newmask },
    { "SCSCHK",	   NULL },
    { "AKILL",     NULL },
    { "GLOBOPS",   NULL },
    { "TRACE",     NULL },	
    { "SANOTICE",  NULL },
    { "DCCDENY",   NULL },
    { "DCCALLOW",  NULL },
    { "ZOMBIE",    NULL },
    { "UNZOMBIE",  NULL },	
    { "SILENCE",   NULL },
    { "GLINE",	   NULL },
    { "UNGLINE",   NULL },    
    { "ZLINE",	   NULL },
    { "UNZLINE",   NULL },
    { "SVLINE",	   NULL },
    { "UNSVLINE",  NULL },
    { "484",	   NULL },
    { "401",	   NULL },
    { "CAPAB",	   m_capab }, 
    { "PROTOCTL",  NULL }, /* for now just ignore it */    
    { "SXLINE",	   NULL }, /* we have no usage for SXlines*/
    { "SVINFO",	   NULL },
    { "SVSINFO",   NULL },
    { NULL }

};

/*************************************************************************/

Message *find_message(const char *name)
{
    Message *m;

    for (m = messages; m->name; m++) {
	if (strcasecmp(name, m->name) == 0)
	    return m;
    }
    return NULL;
}

/*************************************************************************/
