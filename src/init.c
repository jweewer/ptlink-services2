/* Initalization and related routines.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services 
 * $Id:
 */

#include "services.h"
#include "ircdsetup.h"
#include "language.h"
#include "path.h"
#include "patchlevel.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

/* external functions */
extern void dbinit(void);

User u_OperServ;	/* to make it join LogChan */

/*************************************************************************/

/* Send a NICK command for the given pseudo-client.  If `user' is NULL,
 * send NICK commands for all the pseudo-clients. */
#define NICK(nick,name) \
    do { \
	send_cmd(NULL, "NICK %s 1 %lu %s %s %s %s %s :%s", (nick), (unsigned long int) time(NULL), \
		"+o", ServiceUser, ServiceHost, ServiceHost, ServerName, (name)); \
    } while (0)
	
void introduce_user(const char *user)
{
    /* Watch out for infinite loops... */
#define LTSIZE 20
    static int lasttimes[LTSIZE];
    if (lasttimes[0] >= time(NULL)-3)
	fatal("introduce_user() loop detected");
    memmove(lasttimes, lasttimes+1, sizeof(lasttimes)-sizeof(int));
    lasttimes[LTSIZE-1] = time(NULL);
#undef LTSIZE

    if (!user || strcasecmp(user, s_NickServ) == 0) 
	  NICK(s_NickServ, desc_NickServ);
	  
    if (!user || strcasecmp(user, s_ChanServ) == 0) 
	  NICK(s_ChanServ, desc_ChanServ);
	  
    if (!user || strcasecmp(user, s_MemoServ) == 0)
	  NICK(s_MemoServ, desc_MemoServ);

    if (!user || strcasecmp(user, s_GlobalNoticer) == 0) 
	  NICK(s_GlobalNoticer, desc_GlobalNoticer);

    if (!user || strcasecmp(user, s_NewsServ) == 0)
	  NICK(s_NewsServ, desc_NewsServ);

    if (!user || strcasecmp(user, s_OperServ) == 0)
	  {
		NICK(s_OperServ, desc_OperServ);
  	  if(LogChan)
  	    {	
  	  	char tmpch[CHANMAX+1];
		send_cmd(ServerName,"SJOIN 1 #%s +As :@%s",
			LogChan,s_OperServ);
  	  	snprintf(tmpch,CHANMAX,"#%s", LogChan);
  	  	strcpy(u_OperServ.nick,"OperServ");
  	  	u_OperServ.username = strdup("");
  	  	u_OperServ.host = strdup("");
  	  	u_OperServ.hiddenhost = strdup("");
		chan_adduser(&u_OperServ, tmpch, 0);
	    }
  	  if(AdminChan) /* just enter channel to lock +A on it */
  	     {
		send_cmd(ServerName,"SJOIN 1 #%s +As :@%s",
			AdminChan,s_OperServ);
		send_cmd(s_OperServ,"PART #%s",AdminChan);
	    }
    }	
}

#undef NICK

/*************************************************************************/

/* Parse command-line options for the "-dir" option only.  Return 0 if all
 * went well or -1 for a syntax error.
 */

/* XXX this could fail if we have "-some-option-taking-an-argument -dir" */

static int parse_dir_options(int ac, char **av)
{
    int i;
    char *s;

    for (i = 1; i < ac; i++) {
	s = av[i];
	if (*s == '-') {
	    s++;
	    if (strcmp(s, "dir") == 0) {
		if (++i >= ac) {
		    fprintf(stderr, "-dir requires a parameter\n");
		    return -1;
		}
		services_dir = av[i];
	    }
	}
    }
    return 0;
}

/*************************************************************************/

/* Parse command-line options.  Return 0 if all went well, -1 for an error
 * with an option, or 1 for -help.
 */

static int parse_options(int ac, char **av)
{
    int i;
    char *s;

    for (i = 1; i < ac; i++) {
	s = av[i];
	if (*s == '-') {
	    s++;
	    if (strcmp(s, "dir") == 0) {
		/* Handled by parse_dir_options() */
		i++;  /* Skip parameter */
	    } else if (strcasecmp(s, "d") == 0) {
		debug++;
	    } else if (strcasecmp(s, "r") == 0) {
		readonly = 1;
		skeleton = 0;
	    } else if (strcasecmp(s, "s") == 0) {
		readonly = 0;
		skeleton = 1;
	    } else if (strcasecmp(s, "n") == 0) {
		nofork = 1;
	    } else if (strcasecmp(s, "f") == 0) {
		forceload = 1;
	    }
#if HAVE_MYSQL
            else if (strcasecmp(s, "i") == 0) {
              dbinit();
              exit(0);
            }
#endif /* HAVE_MYSQL */		
	    else if (strcasecmp(s, "-help") == 0)
	      {
	        printf(" OPTIONS\n");
	        printf("-d		- debug mode\n");
	        printf("-f		- force load (ignore db read errors)\n");	        
#if HAVE_MYSQL	        
	        printf("-i		- MySQL db init (initalize database)\n");
#endif	        	        	        
	        printf("-n		- do not fork, run in foreground\n");	        
	        printf("-r		- start services in read-only mode\n");
	        printf("-s		- skeleton mode (no services client)\n");
	        exit(0);

	    } else {
		fprintf(stderr, "Unknown option -%s\n", s);
		fprintf(stderr, "List available options using --help\n");
		return -1;
	    }
	} else {
	    fprintf(stderr, "Non-option arguments not allowed\n");
	    return -1;
	}
    }
    return 0;
}

/*************************************************************************/

/* Remove our PID file.  Done at exit. */

static void remove_pidfile(void)
{
    remove(ETCPATH "/" PIDFilename);
}

/*************************************************************************/

/* Create our PID file and write the PID to it. */

static void write_pidfile(void)
{
    FILE *pidfile;

    pidfile = fopen(ETCPATH "/" PIDFilename, "w");
    if (pidfile) {
	fprintf(pidfile, "%d\n", (int)getpid());
	fclose(pidfile);
	atexit(remove_pidfile);
    } else {
	log_perror("Warning: cannot write to PID file %s", ETCPATH "/" PIDFilename);
    }
}

/*
 * check_pidfile
 *
 * inputs       - nothing
 * output       - nothing
 * side effects - reads pid from pidfile and checks if ircd is in process
 *                list. if it is, gracefully exits
 * -kre
 */
static void check_pidfile(void)
{
  int fd;
  char buff[20];
  pid_t pidfromfile;

  if ((fd = open(ETCPATH "/" PIDFilename, O_RDONLY)) >= 0 )
  {
    if (read(fd, buff, sizeof(buff)) == -1)
    {
      /* printf("NOTICE: problem reading from %s (%s)\n", PPATH,
          strerror(errno)); */
    }
    else
    {
      pidfromfile = atoi(buff);
      if (pidfromfile != (int)getpid() && !kill(pidfromfile, 0))
      {
        printf("ERROR: services already running with pid=%i\n", pidfromfile);
        exit(-1);
      }
    }
    close(fd);
  }
  /*
  else
  {
    printf("WARNING: problem opening %s: %s\n", PPATH, strerror(errno));
  }
  */
}

/*************************************************************************/

/* Overall initialization routine.  Returns 0 on success, -1 on failure. */

int init(int ac, char **av)
{
    int i;
    int openlog_failed = 0, openlog_errno = 0;
    int started_from_term = isatty(0) && isatty(1) && isatty(2);

    /* Imported from main.c */
    extern void sighandler(int signum);
    extern void sigusr2(int signum); 


    /* Set file creation mask and group ID. */
#if defined(DEFUMASK) && HAVE_UMASK
    umask(DEFUMASK);
#endif

    /* Parse command line for -dir option. */
    parse_dir_options(ac, av);

    /* Chdir to Services data directory. */
    if (chdir(services_dir) < 0) {
	fprintf(stderr, "chdir(%s): %s\n", services_dir, strerror(errno));
	return -1;
    }

    check_pidfile();

    /* Open logfile, and complain if we didn't. */
    if (open_log() < 0) {
	openlog_errno = errno;
	if (started_from_term) {
	    fprintf(stderr, "Warning: unable to open log file: %s\n"
			, strerror(errno));
	} else {
	    openlog_failed = 1;
	}
    }

    /* Read configuration file; exit if there are problems. */
    if (!read_config(0))
	return -1;

    /* Parse all remaining command-line options. */
    parse_options(ac, av);

    memset(&DayStats,0,sizeof(struct DayStats_));
    memset(&Count,0,sizeof(struct Count_));
    loadDayStats();
    /* Detach ourselves if requested. */
    if (!nofork) {
	if ((i = fork()) < 0) {
	    perror("fork()");
	    return -1;
	} else if (i != 0) {
	    return 0;
	}
	if (started_from_term) {
	    close(0);
	    close(1);
	    close(2);
	}
	if (setpgid(0, 0) < 0) {
	    perror("setpgid()");
	    return -1;
	}
        /* Write our PID to the PID file. */
        write_pidfile();	
    }

    /* Announce ourselves to the logfile. */
    if (debug || readonly || skeleton) {
	log1("%s starting up (options:%s%s%s)",
		PATCHLEVEL,
		debug ? " debug" : "", readonly ? " readonly" : "",
		skeleton ? " skeleton" : "");
    } else {
	log1("%s starting up",
		PATCHLEVEL);
    }
    start_time = time(NULL);

    /* If in read-only mode, close the logfile again. */
    if (readonly)
	close_log();
    signal(SIGINT, sighandler);
    signal(SIGTERM, sighandler);
    signal(SIGQUIT, sighandler);
//    signal(SIGSEGV, sighandler);
    signal(SIGBUS, sighandler); 
    signal(SIGPIPE, SIG_IGN);
    signal(SIGHUP, sighandler);
    signal(SIGILL, sighandler);
    signal(SIGUSR1, sighandler);  /* This is our "out-of-memory" panic switch */
    signal(SIGUSR2, sigusr2);  /* This is our core dump panic switch */
    /* Initialization stuff. */        

    /* Initialize multi-language support */
    lang_init();
    if (debug)
	log1("debug: Loaded languages");

    /* Initialiize subservices */
    ns_init();
    cs_init();
    ms_init();
    os_init();
#ifdef NEWS
    nw_init();
#endif
    /* Load up databases */
    if (!skeleton) {
	load_ns_dbase();
	if (debug)
	    log1("debug: Loaded %s database (1/11)", s_NickServ);
	load_cs_dbase();
	if (debug)
	    log1("debug: Loaded %s database (2/11)", s_ChanServ);
	load_nw_dbase();
	if (debug)
	    log1("debug: Loaded %s database (3/11)", s_NewsServ);
	    
    }
    load_os_dbase();
    if (debug)
	log1("debug: Loaded %s database (4/11)", s_OperServ);
    load_akill();
    if (debug)
	log1("debug: Loaded AKILL database (5/11)");
    load_news();
    if (debug)
	log1("debug: Loaded news database (6/11)");
    load_botlist();	
    if (debug)
    	log1("debug: Loaded BOTLIST database (7/11)");
    load_sq_dbase();	
    if (debug)
    	log1("debug: Loaded SQLINE database (8/11)");			
    load_vl_dbase();	
    if (debug)
    	log1("debug: Loaded VLINE database (9/11)");				
    load_sxl_dbase();
    if(debug)
	log1("debug: Loaded SXLINE database (10/11)");
    load_vlink_dbase();
    if(debug)
	log1("debug: Loaded VLINK database (11/11)");
    log1("Databases loaded");

    /* Connect to the remote server */
    servsock = conn(RemoteServer, RemotePort, LocalHost, LocalPort);
    if (servsock < 0)
	fatal_perror("Can't connect to server");
    send_cmd(NULL, "PASS %s :TS", RemotePassword);
    send_cmd(NULL, "CAPAB :PTS4");
    send_cmd(NULL, "SERVER %s 1 %s :%s",
	ServerName, PATCHLEVEL, ServerDesc);
    send_cmd(NULL, "SVINFO %d %d %lu", TS_CURRENT, TS_MIN, (unsigned long int) time(NULL));
    send_cmd(NULL, "SVSINFO %lu %d", 
	(unsigned long int) time(NULL), Count.users_max);
    sgets2(inbuf, sizeof(inbuf), servsock);
	
    if (strncmp(inbuf, "ERROR", 5) == 0) 
	  {
		/* Close server socket first to stop wallops, since the other
		 * server doesn't want to listen to us anyway */
		disconn(servsock);
		servsock = -1;
		fatal("Remote server returned: %s", inbuf);
  	  }

    /* Announce a logfile error if there was one */
    if (openlog_failed)
	  wallops(NULL, "Warning: couldn't open logfile: %s",
		strerror(openlog_errno));

    /* Bring in our pseudo-clients */
    if (!skeleton)
	  introduce_user(NULL);

    /* set sqlines from sqline list */
    set_sqlines();
    /* set vlines from vline list */
    set_vlines();
    /* set sxlines from sxline list */
    set_sxlines();
    /* set vlinks from vlink list */
    set_vlinks();
    /* Success! */
    send_cmd(NULL,"PING :%s", ServerName);
    return 1;
}

/*************************************************************************/
