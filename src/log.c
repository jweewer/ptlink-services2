/* Logging routines.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services 
 */

#include "services.h"
#include "options.h"

static FILE *logfile = NULL;
static char stamp[20];

/* some functions prototypes */
void end_of_day(void);

/*************************************************************************/

/* Open the log file.  Return -1 if the log file could not be opened, else
 * return 0. */

int open_log(void)
{
    /* 02/05/1999 Lamego - Log file named created with date stamp */
    time_t t;
    struct tm tm;
    char buf[256];
    char fn[256];
    if (logfile)
      return 0;
    time(&t);
    tm = *localtime(&t);
    strftime(buf, sizeof(buf)-1, "%Y%m%d", &tm);
    sprintf(fn,"logs/Services_%s.log",buf);
    strcpy(stamp,buf);
    logfile = fopen(fn, "a");
    if (logfile)
      setbuf(logfile, NULL);
    return logfile!=NULL ? 0 : -1;
}

/* Close the log file. */

void close_log(void)
{
    if (!logfile)
	return;
    fclose(logfile);
    logfile = NULL;
}

/*************************************************************************/

/* Log stuff to the log file with a datestamp.  Note that errno is
 * preserved by this routine and log_perror().
 */

void log1(const char *fmt, ...)
{
    va_list args;
    time_t t;
    struct tm tm;
    char buf[50]; /* for full time stamp */
    char tmpstamp[20];
    int errno_save = errno;
    va_start(args, fmt);
    time(&t);
    tm = *localtime(&t);
#if HAVE_GETTIMEOFDAY
    if (debug) {
	char *s;
	struct timeval tv;
	gettimeofday(&tv, NULL);
	strftime(buf, sizeof(buf)-1, "[%b %d %H:%M:%S", &tm);
	s = buf + strlen(buf);
	s += snprintf(s, sizeof(buf)-(s-buf), ".%06d", (uint32) tv.tv_usec);
	strftime(s, sizeof(buf)-(s-buf)-1, " %Y] ", &tm);
    } else {
#endif
	strftime(buf, sizeof(buf)-1, "[%Y %b %d %H:%M:%S ] ", &tm);
        /* 02/05/1999 Lamego - Swap log filename matching date */
	strftime(tmpstamp, sizeof(tmpstamp)-1, "%Y%m%d", &tm);
	if (logfile && strcmp(stamp,tmpstamp)) {
	    end_of_day();
	}
#if HAVE_GETTIMEOFDAY
    }
#endif
    if (logfile) {
	fputs(buf, logfile);
	vfprintf(logfile, fmt, args);
	fputc('\n', logfile);
    } 
    if (nofork || !logfile) {
	fputs(buf, stdout);
	vfprintf(stdout, fmt, args);
	fputc('\n', stdout);
    }
    errno = errno_save;
}

void log2c(const char *fmt, ...)
{
    va_list args;
    time_t t;
    struct tm tm;
    char buf[50]; /* for full time stamp */
    char buf2[512];   /* for message logging */
    char tmpstamp[20];
    int errno_save = errno;
    va_start(args, fmt);
    time(&t);
    tm = *localtime(&t);
#if HAVE_GETTIMEOFDAY
    if (debug) {
	char *s;
	struct timeval tv;
	gettimeofday(&tv, NULL);
	strftime(buf, sizeof(buf)-1, "[%b %d %H:%M:%S", &tm);
	s = buf + strlen(buf);
	s += snprintf(s, sizeof(buf)-(s-buf), ".%06d", (int32)tv.tv_usec);
	strftime(s, sizeof(buf)-(s-buf)-1, " %Y] ", &tm);
    } else {
#endif
	strftime(buf, sizeof(buf)-1, "[%Y %b %d %H:%M:%S ] ", &tm);
        /* 02/05/1999 Lamego - Swap log filename matching date */
	strftime(tmpstamp, sizeof(tmpstamp)-1, "%Y%m%d", &tm);
	if (strcmp(stamp,tmpstamp)) {
	    end_of_day();
	}
#if HAVE_GETTIMEOFDAY
    }
#endif
    if (logfile) {
	fputs(buf, logfile);
	vfprintf(logfile, fmt, args);
	fputc('\n', logfile);
    }
    if(ccompleted && LogChan) {
        vsprintf(buf2, fmt, args);    
        strcat(buf2,"\n");
	send_cmd(s_OperServ, "PRIVMSG #%s :%s",LogChan,buf2);
    }
    if (nofork) {
	fputs(buf, stderr);
	vfprintf(stderr, fmt, args);
	fputc('\n', stderr);
    }    
    errno = errno_save;
}

/* sends log to #services.log */
void chanlog(const char *fmt, ...)
{
    va_list args;
    char buf[512];
    if(!LogChan)  return;
    va_start(args, fmt);
    vsprintf(buf, fmt, args);
    strcat(buf,"\n");
    send_cmd(s_OperServ, "PRIVMSG #%s :%s",LogChan,buf);    
}

/* Like log(), but tack a ": " and a system error message (as returned by
 * strerror()) onto the end.
 */

void log_perror(const char *fmt, ...)
{
    va_list args;
    time_t t;
    struct tm tm;
    char buf[256];
    int errno_save = errno;

    va_start(args, fmt);
    time(&t);
    tm = *localtime(&t);
#if HAVE_GETTIMEOFDAY
    if (debug) {
	char *s;
	struct timeval tv;
	gettimeofday(&tv, NULL);
	strftime(buf, sizeof(buf)-1, "[%b %d %H:%M:%S", &tm);
	s = buf + strlen(buf);
	s += snprintf(s, sizeof(buf)-(s-buf), ".%06d", (uint32) tv.tv_usec);
	strftime(s, sizeof(buf)-(s-buf)-1, " %Y] ", &tm);
    } else {
#endif
	strftime(buf, sizeof(buf)-1, "[%Y %b %d %H:%M:%S] ", &tm);
#if HAVE_GETTIMEOFDAY
    }
#endif
    if (logfile) {
	fputs(buf, logfile);
	vfprintf(logfile, fmt, args);
	fprintf(logfile, ": %s\n", strerror(errno_save));
    }
    if (nofork) {
	fputs(buf, stderr);
	vfprintf(stderr, fmt, args);
	fprintf(stderr, ": %s\n", strerror(errno_save));
    }
    errno = errno_save;
}

/*************************************************************************/

/* We've hit something we can't recover from.  Let people know what
 * happened, then go down.
 */

void fatal(const char *fmt, ...)
{
    va_list args;
    time_t t;
    struct tm tm;
    char buf[256], buf2[4096];

    va_start(args, fmt);
    time(&t);
    tm = *localtime(&t);
#if HAVE_GETTIMEOFDAY
    if (debug) {
	char *s;
	struct timeval tv;
	gettimeofday(&tv, NULL);
	strftime(buf, sizeof(buf)-1, "[%b %d %H:%M:%S", &tm);
	s = buf + strlen(buf);
	s += snprintf(s, sizeof(buf)-(s-buf), ".%06d", (uint32)tv.tv_usec);
	strftime(s, sizeof(buf)-(s-buf)-1, " %Y] ", &tm);
    } else {
#endif
	strftime(buf, sizeof(buf)-1, "[%b %d %H:%M:%S %Y] ", &tm);
#if HAVE_GETTIMEOFDAY
    }
#endif
    vsnprintf(buf2, sizeof(buf2), fmt, args);
    if (logfile)
	fprintf(logfile, "%sFATAL: %s\n", buf, buf2);
    if (nofork)
	fprintf(stderr, "%sFATAL: %s\n", buf, buf2);
    if (servsock >= 0)
	wallops(NULL, "FATAL ERROR!  %s", buf2);
    exit(1);
}


/* Same thing, but do it like perror(). */

void fatal_perror(const char *fmt, ...)
{
    va_list args;
    time_t t;
    struct tm tm;
    char buf[256], buf2[4096];
    int errno_save = errno;

    va_start(args, fmt);
    time(&t);
    tm = *localtime(&t);
#if HAVE_GETTIMEOFDAY
    if (debug) {
	char *s;
	struct timeval tv;
	gettimeofday(&tv, NULL);
	strftime(buf, sizeof(buf)-1, "[%b %d %H:%M:%S", &tm);
	s = buf + strlen(buf);
	s += snprintf(s, sizeof(buf)-(s-buf), ".%06d", (uint32) tv.tv_usec);
	strftime(s, sizeof(buf)-(s-buf)-1, " %Y] ", &tm);
    } else {
#endif
	strftime(buf, sizeof(buf)-1, "[%b %d %H:%M:%S %Y] ", &tm);
#if HAVE_GETTIMEOFDAY
    }
#endif
    vsnprintf(buf2, sizeof(buf2), fmt, args);
    if (logfile)
	fprintf(logfile, "%sFATAL: %s: %s\n", buf, buf2, strerror(errno_save));
    if (stderr)
	fprintf(stderr, "%sFATAL: %s: %s\n", buf, buf2, strerror(errno_save));
    if (servsock >= 0)
	wallops(NULL, "FATAL ERROR!  %s: %s", buf2, strerror(errno_save));
    exit(1);
}

/*************************************************************************/
void end_of_day(void) {
    if(logfile)
      {
        fprintf(logfile,"-+ LOG FILENAME ROTATION +-\n");
        close_log();
        open_log();
        fprintf(logfile,"-+ LOG FILENAME ROTATION +-\n");
        end_of_day_stats();                 
      }        
};
