/* Services -- main source file. 
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2004
 * http://software.pt-link.net
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program (see the file COPYING); if not, write to the
 * Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 * $Id: main.c,v 1.5 2004/11/24 18:49:35 stinger Exp $
 */

#include "services.h"
#include "timeout.h"
#include "language.h"
#include "patchlevel.h"
#include "path.h"
#define SAVE_SV 	-20
#define EXPORT_NW	-26

/******** Global variables! ********/

/* Command-line options: (note that configuration variables are in config.c) */
char *services_dir = DATAPATH;	/* -dir dirname */
//char *log_filename = LOG_FILENAME;	/* -log filename */
int   	debug        	= 0;		/* -debug */
int   	readonly     	= 0;		/* -readonly */
int   	skeleton     	= 0;		/* -skeleton */
int   	nofork       	= 0;		/* -nofork */
int   	forceload    	= 0;		/* -forceload */
int	expiremail	= 0;		/* -expiremail days */


/* set to 1 if connection was complete */
int	ccompleted	= 1;

/* Set to 1 if we are to quit */
int quitting = 0;

/* Set to 1 if we are to quit after saving databases */
int delayed_quit = 0;

/* Contains a message as to why services is terminating */
char *quitmsg = NULL;

/* Input buffer - global, so we can dump it if something goes wrong */
char inbuf[BUFSIZE];

/* Socket for talking to server */
int servsock = -1;

/* Should we update the databases now? */
int save_data = 0;

/* At what time were we started? */
time_t start_time;


/******** Local variables! ********/

/* Set to 1 if we are waiting for input */
static int waiting = 0;

/* Set to 1 after we've set everything up */
static int started = 0;

/* If we get a signal, use this to jump out of the main loop. */
static sigjmp_buf panic_jmp;


/* extern variables */
extern char* last_updater;
extern time_t last_update_request;

/* let's core dump on SIGUSR2 */
void sigusr2(int signum) {
    abort();
}

/*************************************************************************/

/* If we get a weird signal, come here. */

void sighandler(int signum)
{
    if (started) {
	if (signum == SIGHUP) {  /* SIGHUP = save databases and restart */
	    save_data = -2;
	    signal(SIGHUP, sighandler);
	    log1("Received SIGHUP, restarting.");
	    if (!quitmsg)
		quitmsg = "Restarting on SIGHUP";
	    siglongjmp(panic_jmp, 1);
	} else if (signum == SIGTERM) {
	    save_data = 1;
	    delayed_quit = 1;
	    signal(SIGTERM, SIG_IGN);
	    signal(SIGHUP, SIG_IGN);
	    log1("Received SIGTERM, exiting.");
	    quitmsg = "Shutting down on SIGTERM";
	    siglongjmp(panic_jmp, 1);
	} else if (signum == SIGINT || signum == SIGQUIT) {
	    /* nothing -- terminate below */
	} else if (!waiting) {
	    log1("PANIC! buffer = %s", inbuf);
	    /* Cut off if this would make IRC command >510 characters. */
	    if (strlen(inbuf) > 448) {
		inbuf[446] = '>';
		inbuf[447] = '>';
		inbuf[448] = 0;
	    }
	    wallops(NULL, "PANIC! buffer = %s\r\n", inbuf);
	} else if (waiting < 0) {
	    /* This is static on the off-chance we run low on stack */
	    static char buf[BUFSIZE];
	    switch (waiting) {
		case  -1: snprintf(buf, sizeof(buf), "in timed_update");
		          break;
		case -11: snprintf(buf, sizeof(buf), "saving %s", NickDBName);
		          break;
		case -12: snprintf(buf, sizeof(buf), "saving %s", ChanDBName);
	    	          break;
		case -13: snprintf(buf, sizeof(buf), "saving %s", NewsServDBName);
	    	          break;				  
		case -14: snprintf(buf, sizeof(buf), "saving %s", OperDBName);
		          break;
		case -15: snprintf(buf, sizeof(buf), "saving %s", AutokillDBName);
		          break;
		case -16: snprintf(buf, sizeof(buf), "saving %s", NewsDBName);
		          break;
		case -17: snprintf(buf, sizeof(buf), "saving %s", BotListDBName);
		          break;			
		case -18: snprintf(buf, sizeof(buf), "saving %s", SQlineDBName);		
		          break;
		case SAVE_SV: snprintf(buf, sizeof(buf), "saving %s", VlineDBName);		
		          break;		  
		case -19: snprintf(buf, sizeof(buf), "saving %s", DayStatsFN);
		          break;				    
		case -21: snprintf(buf, sizeof(buf), "expiring nicknames");
		          break;
		case -22: snprintf(buf, sizeof(buf), "expiring channels");
		          break;
		case -23: snprintf(buf, sizeof(buf), "saving %s", SXlineDBName);
			  break;
		case -24: snprintf(buf, sizeof(buf), "saving %s", VlinkDBName);
			  break;			
		case -25: snprintf(buf, sizeof(buf), "expiring autokills");
		          break;
		case EXPORT_NW: snprintf(buf, sizeof(buf), "exporting newsserv data");
		          break;			  
		default : snprintf(buf, sizeof(buf), "waiting=%d", waiting);
	    }
	    wallops(NULL, "PANIC! %s (%s)", buf, strsignal(signum));
	    log1("PANIC! %s (%s)", buf, strsignal(signum));
	}
    }
    if (signum == SIGUSR1 || !(quitmsg = malloc(BUFSIZE))) {
	quitmsg = "Out of memory!";
	quitting = 1;
    } else {
#if HAVE_STRSIGNAL
	snprintf(quitmsg, BUFSIZE, "Services terminating: %s", strsignal(signum));
#else
	snprintf(quitmsg, BUFSIZE, "Services terminating on signal %d", signum);
#endif
	quitting = 1;
    }
	if(signum==SIGSEGV) {
	    abort();
	}
    if (started)
	siglongjmp(panic_jmp, 1);
    else {
	log1("%s", quitmsg);
	if (isatty(2))
	    fprintf(stderr, "%s\n", quitmsg);
	exit(1);
    }
}

/*************************************************************************/

/* Main routine.  (What does it look like? :-) ) */

int main(int ac, char **av, char **envp)
{
    volatile time_t last_update; /* When did we last update the databases? */
    volatile time_t last_expire; /* When did we last expire nicks/channels? */
    volatile time_t last_check;  /* When did we last check timeouts? */
    volatile time_t last_export;
	User* user;
    int i;
    char *progname;
#ifdef  FORCE_CORE
    struct rlimit corelim;
    corelim.rlim_cur = corelim.rlim_max = RLIM_INFINITY;
    setrlimit(RLIMIT_CORE, &corelim);
#endif 
    srandom(time(NULL));
    /* Find program name. */
    if ((progname = strrchr(av[0], '/')) != NULL)
	progname++;
    else
	progname = av[0];

    /* Were we run under "listnicks" or "listchans"?  Do appropriate stuff
     * if so. */
#ifdef __CYGWIN__
    if (strcmp(progname, "listnicks.exe") == 0) 
#else   
    if (strcmp(progname, "listnicks") == 0) 
#endif    
	  {
		do_listnicks(ac, av);
		return 0;
  	  } 
#ifdef __CYGWIN__  	  
	else if (strcmp(progname, "listchans.exe") == 0) 
#else	
	else if (strcmp(progname, "listchans") == 0) 	
#endif
	  {
		do_listchans(ac, av);
		return 0;	
  	  }
	
    printf("Loading %s - (C) 1999-2004 PTlink IRC Software\n",
    PATCHLEVEL);    
    
    if ((i = init(ac, av)) <= 0)
    	return i;   
    	    	
    /* We have a line left over from earlier, so process it first. */
    process();

    /* Set up timers. */
    last_update = time(NULL);
    last_expire = time(NULL);
    last_check  = time(NULL);
    last_export = time(NULL);
    
    /* The signal handler routine will drop back here with quitting != 0
     * if it gets called. */
    sigsetjmp(panic_jmp,1);

    started = 1;


    /*** Main loop. ***/

    while (!quitting) {
	time_t t = time(NULL);

	if (debug >= 2)
	    log1("debug: Top of main loop");
	if (!readonly && (save_data || t-last_expire >= ExpireTimeout)) {
	    waiting = -3;
	    if (debug)
		log1("debug: Running expire routines");
	    if (!skeleton) {
		waiting = -21;
		expire_nicks();
		waiting = -22;
		expire_chans();
	    }
	    waiting = -25;
	    expire_akills();
	    last_expire = t;
	}
#ifdef NEWS	
	if (!readonly && ExportRefresh && (save_data || t-last_export >= ExportRefresh)) {
	    waiting = EXPORT_NW;
	    newsserv_export();
	    last_export=time(NULL);
	} 
#endif
	if (!readonly && (save_data || t-last_update >= UpdateTimeout)) {
	    waiting = -2;
	    if (debug)
		  log1("debug: Saving databases");
	    if (!skeleton) 
		  {
			waiting = -11;
			save_ns_dbase();
			waiting = -12;
			save_cs_dbase();
#ifdef NEWS
			waiting = -13;
			save_nw_dbase();
#endif
	  	  }
		  
	  	waiting = -14;
	    save_os_dbase();
	    waiting = -15;
	    save_akill();
	    waiting = -16;
	    save_news();
	    waiting = -17;	    
	    save_botlist();		
	    waiting = -18;
	    save_sq_dbase();
	    waiting = SAVE_SV;
	    save_vl_dbase();
	    waiting = -19;
	    save_sxl_dbase();
	    waiting = -23;
	    save_vlink_dbase();
	    waiting = -24;	    	    
	    saveDayStats();
	    if (save_data < 0)
		break;	/* out of main loop */

	    save_data = 0;

		if(last_updater)
		  {
		  	if((user = finduser(last_updater)))
			  {
				notice_lang(s_OperServ, user, UPDATE_DONE, t-last_update_request);
			  }
			free(last_updater);
			last_updater = NULL;
		  };
	    last_update = t;
	}
	if (delayed_quit)
	    break;
	waiting = -1;
	if (t-last_check >= TimeoutCheck) {
	    check_timeouts();
	    last_check = t;
	}
	waiting = 1;
	i = (int)(long)sgets2(inbuf, sizeof(inbuf), servsock);
	waiting = 0;
	if (i > 0) {
	    process();
	} else if (i == 0) {
	    int errno_save = errno;
	    quitmsg = malloc(BUFSIZE);
	    if (quitmsg) {
		snprintf(quitmsg, BUFSIZE,
			"Read error from server: %s", strerror(errno_save));
	    } else {
		quitmsg = "Read error from server";
	    }
	    quitting = 1;
	}
	waiting = -4;
    }


    /* Check for restart instead of exit */
    if (save_data == -2) {
	log1("Restarting");
	if (!quitmsg)
	    quitmsg = "Restarting";
	send_cmd(ServerName, "SQUIT %s :%s", ServerName, quitmsg);
	disconn(servsock);
	close_log();
	execve(BINPATH "/services", av, envp);
	if (!readonly) {
	    open_log();
	    log_perror("Restart failed");
	    close_log();
	}
	return 1;
    }

    /* Disconnect and exit */
    if (!quitmsg)
	quitmsg = "Terminating, reason unknown";
    log1("%s", quitmsg);
    if (started)
	send_cmd(ServerName, "SQUIT %s :%s", ServerName, quitmsg);
    disconn(servsock);
    return 0;
}

/*************************************************************************/
