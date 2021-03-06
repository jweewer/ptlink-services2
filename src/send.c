/* Routines for sending stuff to the network.
 *
 * Services is copyright (c) 1996-1999 Andy Church.
 *     E-mail: <achurch@dragonfire.net>
 * This program is free but copyrighted software; see the file COPYING for
 * details.
 */

#include "services.h"
#include "ircdsetup.h"

/* domain list for global send */
static SendDomain *domainlist=NULL;


/*************************************************************************/

/* Send a command to the server.  The two forms here are like
 * printf()/vprintf() and friends. */

void send_cmd(const char *source, const char *fmt, ...)
{
    va_list args;

    va_start(args, fmt);
    vsend_cmd(source, fmt, args);
    va_end(args);
}

void vsend_cmd(const char *source, const char *fmt, va_list args)
{
    char buf[BUFSIZE];

    vsnprintf(buf, sizeof(buf), fmt, args);
    if (source) {
	sockprintf(servsock, ":%s %s\r\n", source, buf);
	if (debug)
	    log1("debug: Sent: :%s %s", source, buf);
    } else {
	sockprintf(servsock, "%s\r\n", buf);
	if (debug)
	    log1("debug: Sent: %s", buf);
    }
}


/*************************************************************************/

/* Send out a WALLOPS (a GLOBOPS on ircd.dal). */

void wallops(const char *source, const char *fmt, ...)
{
    va_list args;
    char buf[BUFSIZE];
    va_start(args, fmt);
    vsnprintf(buf, sizeof(buf), fmt, args);
    send_cmd(source ? source : ServerName,  "GLOBOPS :%s", buf);
    va_end(args);
}

void sanotice(const char *source, const char *fmt, ...)
{
    va_list args;
    char buf[BUFSIZE];
    va_start(args, fmt);
    vsnprintf(buf, sizeof(buf), fmt, args);
    send_cmd(source ? source : ServerName,"SANOTICE :%s", buf);
    va_end(args);
}

/*************************************************************************/

/* Send a NOTICE from the given source to the given nick. */
void notice(const char *source, const char *dest, const char *fmt, ...)
{
    va_list args;
    char buf[BUFSIZE];

    va_start(args, fmt);
    vsnprintf(buf, sizeof(buf), fmt, args);
#ifdef JUSTMSG
    send_cmd(source, "PRIVMSG %s :%s", dest, buf);
#else
    send_cmd(source, "NOTICE %s :%s", dest, buf);
#endif
    va_end(args);
}

/* Send a NOTICE from the given source to the given nick. 
   it will ignore the JUSTMSG option
*/
void notice_s(const char *source, const char *dest, const char *fmt, ...)
{
    va_list args;
    char buf[BUFSIZE];

    va_start(args, fmt);
    vsnprintf(buf, sizeof(buf), fmt, args);
    send_cmd(source, "NOTICE %s :%s", dest, buf);
    va_end(args);
}


/* Send a NULL-terminated array of text as NOTICEs. */
void notice_list(const char *source, const char *dest, const char **text)
{
    while (*text) {
	/* Have to kludge around an ircII bug here: if a notice includes
	 * no text, it is ignored, so we replace blank lines by lines
	 * with a single space.
	 */
	if (**text)
	    notice(source, dest, *text);
	else
	    notice(source, dest, " ");
	text++;
    }
}


/* Send a message in the user's selected language to the user using NOTICE. */
void notice_lang(const char *source, User *dest, int message, ...)
{
    va_list args;
    char buf[4096];	/* because messages can be really big */
    char *s, *t;
    const char *fmt;

    if (!dest)
	  return;
    
    va_start(args, message);
    fmt = getstring(dest, message);
    if (!fmt)
	  return;
    vsnprintf(buf, sizeof(buf), fmt, args);
    s = buf;
    while (*s) 
      {
	    t = s;
	    s += strcspn(s, "\n");
	    if(*s)
	      *s++ = 0;
#ifdef JUSTMSG
	      send_cmd(source, "PRIVMSG %s :%s", dest->nick, *t ? t : " ");
#else
	      if(dest->is_msg)
	        send_cmd(source, "PRIVMSG %s :%s", dest->nick, *t ? t : " ");
	      else
	        send_cmd(source, "NOTICE %s :%s", dest->nick, *t ? t : " ");
#endif
      }
}

/* Send a message in the user's selected language to the user using PRIVMSG. */
void private_lang(const char *source, User *dest, int message, ...)
{
    va_list args;
    char buf[4096];	/* because messages can be really big */
    char *s, *t;
    const char *fmt;

    if (!dest)
	return;
    va_start(args, message);
    fmt = getstring(dest, message);
    if (!fmt)
	return;
    vsnprintf(buf, sizeof(buf), fmt, args);
    s = buf;
    while (*s) {
	t = s;
	s += strcspn(s, "\n");
	if (*s)
	    *s++ = 0;
	send_cmd(source, "PRIVMSG %s :%s", dest->nick, *t ? t : " ");
    }
}


/* Like notice_lang(), but replace %S by the source.  This is an ugly hack
 * to simplify letting help messages display the name of the pseudoclient
 * that's sending them.
 */
void notice_help(const char *source, User *dest, int message, ...)
{
    va_list args;
    char buf[4096], buf2[4096], outbuf[BUFSIZE];
    char *s, *t;
    const char *fmt;
    if (!dest)
	  return;
    va_start(args, message);
    fmt = getstring(dest, message);
    if (!fmt)
	return;
    /* Some sprintf()'s eat %S or turn it into just S, so change all %S's
     * into \1\1... we assume this doesn't occur anywhere else in the
     * string. */
    strscpy(buf2, fmt, sizeof(buf2));
    strnrepl(buf2, sizeof(buf2), "%S", "\1\1");
    vsnprintf(buf, sizeof(buf), buf2, args);
    s = buf;
    while (*s) 
      {
	    t = s;
	    s += strcspn(s, "\n");
	    if (*s)
	      *s++ = 0;          
	    strscpy(outbuf, t, sizeof(outbuf));
	    strnrepl(outbuf, sizeof(outbuf), "\1\1", source);
#ifdef JUSTMSG	
	    send_cmd(source, "PRIVMSG %s :%s", dest->nick, *outbuf ? outbuf : " ");
#else
	    if(dest->is_msg)
	      send_cmd(source, "PRIVMSG %s :%s", dest->nick, *outbuf ? outbuf : " ");
	    else
	      send_cmd(source, "NOTICE %s :%s", dest->nick, *outbuf ? outbuf : " ");
#endif
      }
  va_end(args);
}

/*************************************************************************/

/* Send a PRIVMSG from the given source to the given nick. */
void privmsg(const char *source, const char *dest, const char *fmt, ...)
{
    va_list args;
    char buf[BUFSIZE];

    va_start(args, fmt);
    vsnprintf(buf, sizeof(buf), fmt, args);
    send_cmd(source, "PRIVMSG %s :%s", dest, buf);    
    va_end(args);
}

/*************************************************************************/
/* Adds a new domain to the domain send list, 
    if domain is not new, discard it */
void add_send_domain(char* domain) {
    SendDomain *d = domainlist;
    char *dom;
    dom = &domain[strlen(domain)];
    while(dom>domain && dom[0]!='.') --dom;
    if(dom[0]!='.') {
	log1("Got invalid server name %s",domain);
	return;
    }
    while(d && strcasecmp(d->domain,dom)) d = d->next;
    if(!d) // domain was not on the list
    {
	d = scalloc(sizeof(SendDomain), 1);
	d->domain = sstrdup(dom);
	d->next = domainlist;
	domainlist = d;
    }
}

/* sends to all domains received from SERVER messages */
void send_global(char* msg) {
    SendDomain *d = domainlist;
    while(d) {
#ifdef JUSTMSG
	send_cmd(s_GlobalNoticer, "PRIVMSG $*%s :%s",d->domain,msg);
#else
	send_cmd(s_GlobalNoticer, "NOTICE $*%s :%s",d->domain,msg);
#endif
	d = d->next;
    }
};
