/* Miscellaneous routines.
 *
 * Services is copyright (c) 1996-1999 Andy Church.
 *     E-mail: <achurch@dragonfire.net>
 * This program is free but copyrighted software; see the file COPYING for
 * details.
 */

#include <sys/types.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <termios.h>
#include <assert.h>

#include "services.h"
#include "options.h"
#include "language.h"
#include "irc_string.h"

/*************************************************************************/

/* toupper/tolower:  Like the ANSI functions, but make sure we return an
 *                   int instead of a (signed) char.
 */

int toupper(char c)
{
    if (islower(c))
	return (unsigned char)c - ('a'-'A');
    else
	return (unsigned char)c;
}

int tolower(char c)
{
    if (isupper(c))
	return (unsigned char)c + ('a'-'A');
    else
	return (unsigned char)c;
}

/*************************************************************************/

/* strscpy:  Copy at most len-1 characters from a string to a buffer, and
 *           add a null terminator after the last character copied.
 */

char *strscpy(char *d, const char *s, size_t len)
{
    char *d_orig = d;

    if (!len)
	return d;
    while (--len && (*d++ = *s++))
	;
    *d = 0;
    return d_orig;
}

/*************************************************************************/

/* stristr:  Search case-insensitively for string s2 within string s1,
 *           returning the first occurrence of s2 or NULL if s2 was not
 *           found.
 */

char *stristr(char *s1, char *s2)
{
    register char *s = s1, *d = s2;

    while (*s1) {
	if (tolower(*s1) == tolower(*d)) {
	    s1++;
	    d++;
	    if (*d == 0)
		return s;
	} else {
	    s = ++s1;
	    d = s2;
	}
    }
    return NULL;
}

/*************************************************************************/

/* strupper, strlower:  Convert a string to upper or lower case.
 */

char *strupper(char *s)
{
    char *t = s;
    while (*t)
      {
	*t = toupper(*t);
        ++t;	
      }
    return s;
}

char *strlower(char *s)
{
    char *t = s;
    while (*t)
      {
	*t = tolower(*t);
	++t;
      }
    return s;
}

/*************************************************************************/

/* strnrepl:  Replace occurrences of `old' with `new' in string `s'.  Stop
 *            replacing if a replacement would cause the string to exceed
 *            `size' bytes (including the null terminator).  Return the
 *            string.
 */

char *strnrepl(char *s, int32 size, const char *old, const char *new)
{
    char *ptr = s;
    int32 left = strlen(s);
    int32 avail = size - (left+1);
    int32 oldlen = strlen(old);
    int32 newlen = strlen(new);
    int32 diff = newlen - oldlen;

    while (left >= oldlen) {
	if (strncmp(ptr, old, oldlen) != 0) {
	    left--;
	    ptr++;
	    continue;
	}
	if (diff > avail)
	    break;
	if (diff != 0)
	    memmove(ptr+oldlen+diff, ptr+oldlen, left+1);
	strncpy(ptr, new, newlen);
	ptr += newlen;
	left -= oldlen;
    }
    return s;
}

/*************************************************************************/
/*************************************************************************/

/* merge_args:  Take an argument count and argument vector and merge them
 *              into a single string in which each argument is separated by
 *              a space.
 */

char *merge_args(int argc, char **argv)
{
    int i;
    static char s[4096];
    char *t;

    t = s;
    for (i = 0; i < argc; i++)
	t += snprintf(t, sizeof(s)-(t-s), "%s%s", *argv++, (i<argc-1) ? " " : "");
    return s;
}

/*************************************************************************/
/*************************************************************************/

/* match_wild:  Attempt to match a string to a pattern which might contain
 *              '*' or '?' wildcards.  Return 1 if the string matches the
 *              pattern, 0 if not.
 */

static int do_match_wild(const char *pattern, const char *str, int docase)
{
    char c;
    const char *s;

    /* This WILL eventually terminate: either by *pattern == 0, or by a
     * trailing '*'. */

    for (;;) {
	switch (c = *pattern++) {
	  case 0:
	    if (!*str)
		return 1;
	    return 0;
	  case '?':
	    if (!*str)
		return 0;
	    str++;
	    break;
	  case '*':
	    if (!*pattern)
		return 1;	/* trailing '*' matches everything else */
	    s = str;
	    while (*s) {
		if ((docase ? (*s==*pattern) : (tolower(*s)==tolower(*pattern)))
					&& do_match_wild(pattern, s, docase))
		    return 1;
		s++;
	    }
	    break;
	  default:
	    if (docase ? (*str++ != c) : (tolower(*str++) != tolower(c)))
		return 0;
	    break;
	} /* switch */
    }
}


int match_wild(const char *pattern, const char *str)
{
    return do_match_wild(pattern, str, 1);
}

int match_wild_nocase(const char *pattern, const char *str)
{
    return do_match_wild(pattern, str, 0);
}

/*************************************************************************/
/*************************************************************************/

/* Process a string containing a number/range list in the form
 * "n1[-n2][,n3[-n4]]...", calling a caller-specified routine for each
 * number in the list.  If the callback returns -1, stop immediately.
 * Returns the sum of all nonnegative return values from the callback.
 * If `count' is non-NULL, it will be set to the total number of times the
 * callback was called.
 *
 * The callback should be of type range_callback_t, which is defined as:
 *	int (*range_callback_t)(User *u, int num, va_list args)
 */

int process_numlist(const char *numstr, int *count_ret,
		range_callback_t callback, User *u, ...)
{
    int n1, n2, i;
    int res = 0, retval = 0, count = 0;
    va_list args;

    va_start(args, u);

    /*
     * This algorithm ignores invalid characters, ignores a dash
     * when it precedes a comma, and ignores everything from the
     * end of a valid number or range to the next comma or null.
     */
    for (;;) {
	n1 = n2 = strtol(numstr, (char **)&numstr, 10);
	numstr += strcspn(numstr, "0123456789,-");
	if (*numstr == '-') {
	    numstr++;
	    numstr += strcspn(numstr, "0123456789,");
	    if (isdigit(*numstr)) {
		n2 = strtol(numstr, (char **)&numstr, 10);
		numstr += strcspn(numstr, "0123456789,-");
	    }
	}
	if(n1>10000 || n2>10000) return 0; /* fixed memoserv freezing bug - Lamego 1999 */
	for (i = n1; i <= n2; i++) {
	    int res = callback(u, i, args);
	    count++;
	    if (res < 0)
		break;
	    retval += res;
	}
	if (res < 0)
	    break;
	numstr += strcspn(numstr, ",");
	if (*numstr)
	    numstr++;
	else
	    break;
    }
    if (count_ret)
	*count_ret = count;
    return retval;
}

/*************************************************************************/

/* dotime:  Return the number of seconds corresponding to the given time
 *          string.  If the given string does not represent a valid time,
 *          return -1.
 *
 *          A time string is either a plain integer (representing a number
 *          of seconds), or an integer followed by one of these characters:
 *          "s" (seconds), "m" (minutes), "h" (hours), or "d" (days).
 */

int dotime(const char *s)
{
    int amount;

    amount = strtol(s, (char **)&s, 10);
    if (*s) {
	switch (*s) {
	    case 's': return amount;
	    case 'm': return amount*60;
	    case 'h': return amount*3600;
	    case 'd': return amount*86400;
	    default : return -1;
	}
    } else {
	return amount;
    }
}

#ifndef NOT_MAIN
void ago_time(char *buf,time_t t, User *u) {
    int days,hours,minutes,seconds;
    days = t/(24*3600);
    t %= 24*3600;
    hours = t/3600;
    t %= 3600;
    minutes = t/60;
    t %= 60;
    seconds = t;
    if(days)
	sprintf(buf,getstring(u,AGO_TIME_D),
	    days,
	    hours,
	    minutes,
	    seconds);
    else	    
	sprintf(buf,getstring(u,AGO_TIME),
	    hours,
	    minutes,
	    seconds);
    
}

void total_time(char *buf,time_t t, User *u) {
    int days,hours,minutes,seconds;
    days = t/(24*3600);
    t %= 24*3600;
    hours = t/3600;
    t %= 3600;
    minutes = t/60;
    t %= 60;
    seconds = t;
    sprintf(buf,getstring(u,TOTAL_TIME),
	    days,
	    hours,
	    minutes,
	    seconds);
}

/* Copied from IRCd - Lamego */
void dumpcore(msg, p1, p2, p3, p4, p5, p6, p7, p8, p9)
    char *msg, *p1, *p2, *p3, *p4, *p5, *p6, *p7, *p8, *p9;
{ 
    static time_t lastd = 0;
    static int dumps = 0;
    char corename[12];
    time_t now;
    int p;

    now = time(NULL);

    if (!lastd)
        lastd = now;
    if (now - lastd > 60) {
        lastd = now;
        dumps = 1;
    } else
        dumps++; 
    p = getpid();
    signal(SIGSEGV,SIG_DFL);
    if (fork() > 0) {
        kill(p, 3);
        kill(p, 9);  
    } 
    (void) sprintf(corename, "core.%d", p);
    if(rename("core", corename)==-1)
	log1("No core dump available");
    else
	wallops(s_OperServ,"Dumped core : core.%d", p);
    //log("Dumped core : core.%d", p);
    exit(0);
}
#endif

/* generates a random string */
void rand_string(char *target, int minlen, int maxlen)
  {
	int i;
    int len=minlen+(random()%(maxlen-minlen+1));
    for(i=0;i<len;++i) 
	  {
		target[i]= 'a'+(random()%('z'-'a'+1));
        if(random()%2) target[i]=toupper(target[i]);
	  }
    target[i]='\0';
  }
  
#if HAVE_MYSQL
void set_sql_string(char* dest, char* src)
  {
	if(src && *src)
	  {
		dest[0]='\'';
		mysql_escape_string(&dest[1], src, strlen(src));
		strcat(dest,"\'");
	  }
	  else
		strcpy(dest,"NULL");
  }

#endif

char* hex_str(unsigned char *str, int len)
{
  static char hexTab[] = "0123456789abcdef";
  static char buffer[200];
  int i;
  if(len>sizeof(buffer))
    abort();
  for(i=0;i<len;++i)
    {
      buffer[i*2]=hexTab[str[i] >> 4];
      buffer[(i*2)+1]=hexTab[str[i] & 0x0F];
    }
  return buffer;
} 

char* hex_bin(unsigned char *dest, char* source)
{
  /* static char hexTab[] = "0123456789abcdef"; */
  int i=0,h1,h2;
  char *s = source;
  while(*s && *(s+1))
    {
      *s = toupper(*s);
      *(s+1) = toupper(*(s+1));
      if(*s>'9')
        h1 = 10 + (*s-'A');
      else 
        h1 = *s - '0'; 
      if(*(s+1)>'9')
        h2 = 10 + (*(s+1)-'A');
      else 
        h2 = *(s+1) - '0';         
      dest[i++] = (h1 << 4) + h2;
      s += 2;
    }
    dest[i]='\0';
    return dest;
} 

/* 
 * Stripes \R and \N from string
 */
void strip_rn(char *txt)
{
  char *c;
  while((c = strchr(txt, '\r'))) *c = '\0';
  while((c = strchr(txt, '\n'))) *c = '\0';
}

/*
 * get password
 */
int get_pass(char *dest, size_t maxlen)
{
  unsigned int i;
  char c;
  int old_status, ttyfd;
  struct termios orig, new;
  
  ttyfd = fileno(stdin);

  old_status = tcgetattr(ttyfd, &orig);
  new = orig;
  
  new.c_lflag &= ~ECHO; /* disable echo */
  new.c_lflag &= ~ISIG; /* ignore signals */ 
  
  tcsetattr(ttyfd, TCSAFLUSH, &new);

  /* get the input */
  i = 0;
  while(i < (maxlen-1)) 
    {
       if (read(ttyfd, &c, 1) <= 0)
         break;
       if (c == '\n')
         break;
       dest[i] = c;
       i++;
    }
  dest[i] = '\0';
  
  tcsetattr(ttyfd, TCSAFLUSH, &orig);
  
  return i;
}

/*
 * valid_hostname - check hostname for validity
 *
 * Inputs       - char pointer to hostname
 * Output       - 1 if valid, 0 if not
 * Side effects - NONE
 *
 * NOTE: this doesn't allow a hostname to begin with a dot and
 * will not allow more dots than chars.
 *
 * Hard-copy from PTlink IRCd source
 */
int valid_hostname(const char* hostname)
{
  int         dots  = 0;
  int         chars = 0;
  const char* p     = hostname;

  assert(0 != p);

  if ('.' == *p)
    return 0;

  while (*p) {
    if (!IsHostChar(*p))
      return 0;
    if ('.' == *p || ':' == *p)
    {
      ++p;
      ++dots;
    }
    else
    {
      ++p;
      ++chars;
    }
  }
  return ( 0 == dots || chars < dots) ? 0 : 1;
}
