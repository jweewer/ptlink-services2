/* botlist.c
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 * http://www.ptlink.net/Coders/ - coders@PTlink.net
 * This program is distributed under GNU Public License
 *
 * Please read the file COPYING for copyright information.
*/
#include "services.h"
#include "pseudo.h"
#include "ircdsetup.h"
#define DFV_BOTLIST 2

struct botlist {
    char *mask;
    char *reason;
    char who[NICKMAX];
    time_t time;
    time_t last_used;
    int16 max;
};

static struct botlist *fbotlist = NULL;
static int32 nbotlist = 0;
static int32 botlist_size = 0;

/*************************************************************************/
/********************* BOTLIST database load/save ************************/
/*************************************************************************/

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", AutokillDBName);	\
	nbotlist = i;					\
	break;						\
    }							\
} while (0)

void load_botlist(void)
{
    dbFILE *f;
    int i, ver;
    int16 sver=0; /* data file suberversion number */
    int16 tmp16;
    int32 tmp32;
    if (!(f = open_db("BOTLIST", BotListDBName, "r")))
	return;
    ver = get_file_version(f);
    if(ver==-1) read_int16(&sver, f);
    if(sver<1 || sver>DFV_BOTLIST) 
	fatal("Unsupported subversion (%d) on %s", sver, BotListDBName);      
    if(sver<DFV_BOTLIST) 
	log1("BotList DataBase WARNING: converting from subversion %d to %d",
	    sver,DFV_BOTLIST);	       	
    read_int16(&tmp16, f);
    nbotlist = tmp16;
    if (nbotlist < 8)
	botlist_size = 16;
    else if (nbotlist >= 16384)
	botlist_size = 32767;
    else
	botlist_size = 2*nbotlist;
    fbotlist = scalloc(sizeof(*fbotlist), botlist_size);
    for (i = 0; i < nbotlist; i++) {
	SAFE(read_string(&fbotlist[i].mask, f));
	SAFE(read_string(&fbotlist[i].reason, f));
	SAFE(read_buffer(fbotlist[i].who, f));
	SAFE(read_int32(&tmp32, f));
	fbotlist[i].time = tmp32;
	if(sver>1) {
	    SAFE(read_int32(&tmp32, f));
	    fbotlist[i].last_used = tmp32;
	    SAFE(read_int16(&fbotlist[i].max, f));
	} else {
	    fbotlist[i].last_used = time(NULL);
	    fbotlist[i].max = 50;
	}
    }
    close_db(f);
}

#undef SAFE

/*************************************************************************/

#define SAFE(x) do {							\
    if ((x) < 0) {							\
	restore_db(f);							\
	log_perror("Write error on %s", AutokillDBName);		\
	if (time(NULL) - lastwarn > WarningTimeout) {			\
	    wallops(NULL, "Write error on %s: %s", AutokillDBName,	\
			strerror(errno));				\
	    lastwarn = time(NULL);					\
	}								\
	return;								\
    }									\
} while (0)

void save_botlist(void)
{
    dbFILE *f;
    int i;
    static time_t lastwarn = 0;

    f = open_db("BOTLIST", BotListDBName, "w");
    write_int16(DFV_BOTLIST, f);
    write_int16(nbotlist, f);
    for (i = 0; i < nbotlist; i++) {
	SAFE(write_string(fbotlist[i].mask, f));
	SAFE(write_string(fbotlist[i].reason, f));
	SAFE(write_buffer(fbotlist[i].who, f));
	SAFE(write_int32(fbotlist[i].time, f));
	SAFE(write_int32(fbotlist[i].last_used, f));
	SAFE(write_int16(fbotlist[i].max, f));
    }
    close_db(f);
}

#undef SAFE
/*************************************************************************
    Returns the maximum connections allowed from that host or 0
    if host was not found.
 *************************************************************************/
int check_botlist(const char *host)
{
    int i;
    for (i = 0; i < nbotlist; i++) 
	if (match_wild_nocase(fbotlist[i].mask, host)) return fbotlist[i].max;
    return 0;
}


static void add_botlist(const char *mask, int max,const char *reason, const char *who)
{
    if (nbotlist >= 32767) {
	log1("%s: Attempt to add BOTLIST entry to full list!", s_OperServ);
	return;
    }
    if (nbotlist >= botlist_size) {
	if (botlist_size < 8)
	    botlist_size = 8;
	else
	    botlist_size *= 2;
	fbotlist = srealloc(fbotlist, sizeof(*fbotlist) * botlist_size);
    }
    fbotlist[nbotlist].mask = sstrdup(mask);
    fbotlist[nbotlist].reason = sstrdup(reason);
    fbotlist[nbotlist].time = time(NULL);
    fbotlist[nbotlist].max = max;
    strscpy(fbotlist[nbotlist].who, who, NICKMAX);
    nbotlist++;
}

/*************************************************************************/

/* Return whether the mask was found in the botlist. */

static int del_botlist(const char *mask)
{
    int i;

    for (i = 0; i < nbotlist && stricmp(fbotlist[i].mask, mask) != 0; i++)
	;
    if (i < nbotlist) {
	free(fbotlist[i].mask);
	free(fbotlist[i].reason);
	nbotlist--;
	if (i < nbotlist)
	    memmove(fbotlist+i, fbotlist+i+1, sizeof(*fbotlist) * (nbotlist-i));
	return 1;
    } else {
	return 0;
    }
}

void do_botlist(User *u)
{
    char *cmd, *mask, *max, *reason, *s;
    int i,maxn=0;
    cmd = strtok(NULL, " ");
    if (!cmd)
	cmd = "";

    if (stricmp(cmd, "ADD") == 0) {
	if (nbotlist >= 32767) {
	    notice_lang(s_OperServ, u, OPER_TOO_MANY_BOTLIST);
	    return;
	}
	mask = strtok(NULL, " ");
	max = strtok(NULL, " ");
	if(max) maxn = atoi(max);
	if (mask && (reason = strtok(NULL, "")) && maxn) {
/*	
	    if (strchr(mask, '*') || strchr(mask, '?')) 
		notice_lang(s_OperServ, u, OPER_BOTLIST_NO_NICK);	
	    else if (strchr(mask, '!'))
		notice_lang(s_OperServ, u, OPER_BOTLIST_NO_NICK);	
	    else {
*/	  
		if(del_botlist(mask))  /* delete old entry if it exists */
		    notice_lang(s_OperServ, u, BOTLIST_REMOVED, mask);
		add_botlist(mask, maxn,reason, u->nick);
		notice_lang(s_OperServ, u, OPER_BOTLIST_ADDED, mask);
//	    }
	    if (readonly)
		notice_lang(s_OperServ, u, READ_ONLY_MODE);
	} else {
	    syntax_error(s_OperServ, u, "BOT", OPER_BOTLIST_ADD_SYNTAX);
	}

    } else if (stricmp(cmd, "DEL") == 0) {
	mask = strtok(NULL, " ");
	if (mask) {
	    s = strchr(mask, '@');
	    if (s)
		strlower(s);
	    if (del_botlist(mask)) {
		notice_lang(s_OperServ, u, BOTLIST_REMOVED, mask);
		if (s) {
		    *s++ = 0;
		} else {
		    /* We lose... can't figure out what's a username and what's
		     * a hostname.  Ah well.
		     */
		}
		if (readonly)
		    notice_lang(s_OperServ, u, READ_ONLY_MODE);
	    } else {
		notice_lang(s_OperServ, u, OPER_BOTLIST_NOT_FOUND, mask);
	    }
	} else {
	    syntax_error(s_OperServ, u, "BOT", OPER_BOTLIST_DEL_SYNTAX);
	}

    } else if (stricmp(cmd, "LIST") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	if (strchr(s, '@'))
	    strlower(strchr(s, '@'));
	notice_lang(s_OperServ, u, OPER_BOTLIST_HEADER);
	for (i = 0; i < nbotlist; i++) {
	    if (!s || match_wild(s, fbotlist[i].mask)) {
		notice_lang(s_OperServ, u, OPER_BOTLIST_FORMAT,
					fbotlist[i].mask, 
					fbotlist[i].max, 
					fbotlist[i].reason);
	    }
	}

    } else if (stricmp(cmd, "VIEW") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	if (strchr(s, '@'))
	    strlower(strchr(s, '@'));
	notice_lang(s_OperServ, u, OPER_BOTLIST_HEADER);
	for (i = 0; i < nbotlist; i++) {
	    if (!s || match_wild(s, fbotlist[i].mask)) {
		char timebuf[32];
		struct tm tm;
		time_t t = time(NULL);

		tm = *localtime(fbotlist[i].time ? &fbotlist[i].time : &t);
		strftime_lang(timebuf, sizeof(timebuf),
			u, STRFTIME_SHORT_DATE_FORMAT, &tm);
		notice_lang(s_OperServ, u, OPER_BOTLIST_VIEW_FORMAT,
				fbotlist[i].mask,
				*fbotlist[i].who ? fbotlist[i].who : "<unknown>",
				timebuf, fbotlist[i].reason);
	      }		
	  }
    }
    else syntax_error(s_OperServ, u, "BOT", OPER_BOTLIST_SYNTAX );
}
