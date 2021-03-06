/* Autokill list functions.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services
 */

#include "services.h"
#include "pseudo.h"
#define DFV_AKILL 1

/*************************************************************************/

struct akill {
    char *mask;
    char *reason;
    char who[NICKMAX];
    time_t time;
    time_t expires;	/* or 0 for no expiry */
};

static int32 nakill = 0;
static int32 akill_size = 0;
static struct akill *akills = NULL;

/*************************************************************************/
/****************************** Statistics *******************************/
/*************************************************************************/

void get_akill_stats(long *nrec, long *memuse)
{
    long mem;
    int i;

    mem = sizeof(struct akill) * akill_size;
    for (i = 0; i < nakill; i++) {
	mem += strlen(akills[i].mask)+1;
	mem += strlen(akills[i].reason)+1;
    }
    *nrec = nakill;
    *memuse = mem;
}


int num_akills(void)
{
    return (int) nakill;
}

/*************************************************************************/
/*********************** AKILL database load/save ************************/
/*************************************************************************/

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", AutokillDBName);	\
	nakill = i;					\
	break;						\
    }							\
} while (0)

void load_akill(void)
{
    dbFILE *f;
    int i, ver;
    int16 tmp16;
    int32 tmp32;
    int16 sver;
    if (!(f = open_db("AKILL", AutokillDBName, "r")))
	return;

    ver = get_file_version(f);
    if(ver==-1) read_int16(&sver, f);		    
    read_int16(&tmp16, f);
    nakill = tmp16;
    if (nakill < 8)
	akill_size = 16;
    else if (nakill >= 16384)
	akill_size = 32767;
    else
	akill_size = 2*nakill;
    akills = scalloc(sizeof(*akills), akill_size);

    switch (ver) {
      case -1: 
	  if(sver!=1) fatal("Unsupported subversion (%d) on %s", sver, AutokillDBName);
      case 8:
      case 7:
      case 6:
      case 5:
	for (i = 0; i < nakill; i++) {
	    SAFE(read_string(&akills[i].mask, f));
	    SAFE(read_string(&akills[i].reason, f));
	    SAFE(read_buffer(akills[i].who, f));
	    SAFE(read_int32(&tmp32, f));
	    akills[i].time = tmp32;
	    SAFE(read_int32(&tmp32, f));
	    akills[i].expires = tmp32;
	}
	break;

      case 4:
      case 3: {
	struct {
	    char *mask;
	    char *reason;
	    char who[NICKMAX];
	    time_t time;
	    time_t expires;
	    long reserved[4];
	} old_akill;

	for (i = 0; i < nakill; i++) {
	    SAFE(read_variable(old_akill, f));
	    strscpy(akills[i].who, old_akill.who, NICKMAX);
	    akills[i].time = old_akill.time;
	    akills[i].expires = old_akill.expires;
	}
	for (i = 0; i < nakill; i++) {
	    SAFE(read_string(&akills[i].mask, f));
	    SAFE(read_string(&akills[i].reason, f));
	}
	break;
      } /* case 3/4 */

      case 2: {
	struct {
	    char *mask;
	    char *reason;
	    char who[NICKMAX];
	    time_t time;
	} old_akill;

	for (i = 0; i < nakill; i++) {
	    SAFE(read_variable(old_akill, f));
	    akills[i].time = old_akill.time;
	    strscpy(akills[i].who, old_akill.who, sizeof(akills[i].who));
	    akills[i].expires = 0;
	}
	for (i = 0; i < nakill; i++) {
	    SAFE(read_string(&akills[i].mask, f));
	    SAFE(read_string(&akills[i].reason, f));
	}
	break;
      } /* case 2 */

      case 1: {
	struct {
	    char *mask;
	    char *reason;
	    time_t time;
	} old_akill;

	for (i = 0; i < nakill; i++) {
	    SAFE(read_variable(old_akill, f));
	    akills[i].time = old_akill.time;
	    akills[i].who[0] = 0;
	    akills[i].expires = 0;
	}
	for (i = 0; i < nakill; i++) {
	    SAFE(read_string(&akills[i].mask, f));
	    SAFE(read_string(&akills[i].reason, f));
	}
	break;
      } /* case 1 */

      default:
	fatal("Unsupported version (%d) on %s", ver, AutokillDBName);
    } /* switch (version) */

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

void save_akill(void)
{
    dbFILE *f;
    int i;
    static time_t lastwarn = 0;

    f = open_db("AKILL", AutokillDBName, "w");
    write_int16(DFV_AKILL, f);    
    write_int16(nakill, f);
    for (i = 0; i < nakill; i++) {
	SAFE(write_string(akills[i].mask, f));
	SAFE(write_string(akills[i].reason, f));
	SAFE(write_buffer(akills[i].who, f));
	SAFE(write_int32(akills[i].time, f));
	SAFE(write_int32(akills[i].expires, f));
    }
    close_db(f);
}

#undef SAFE

/*************************************************************************/
/************************** External functions ***************************/
/*************************************************************************/

/* Does the user match any AKILLs? */

int check_akill(const char *nick, const char *username, const char *host)
{
    char buf[512];
    int i;

    strscpy(buf, username, sizeof(buf)-2);
    i = strlen(buf);
    buf[i++] = '@';
    strlower(strscpy(buf+i, host, sizeof(buf)-i));
    
    for (i = 0; i < nakill; i++) {
	if (match_wild_nocase(akills[i].mask, buf)) {
	    /* time_t now = time(NULL); for gline */
	    /* Don't use kill_user(); that's for people who have already
	     * signed on.  This is called before the User structure is
	     * created.
	     */
	    send_cmd(s_OperServ,
			"KILL %s :%s (%s)",
			nick, s_OperServ , 
			akills[i].reason ? akills[i].reason : "Services AKILL" );
	    send_cmd(s_OperServ,"GLINE %s %lu %s :%s",
		akills[i].mask,(long) CLONEGLINETIME, s_OperServ,
		akills[i].reason ? akills[i].reason : "Services AKILL");	  
	    return 1;
	}
    }
    return 0;
}

/*************************************************************************/

/* Delete any expired autokills. */

void expire_akills(void)
{
    int i;
    time_t now = time(NULL);
    
    for (i = 0; i < nakill; i++) {
	if (akills[i].expires == 0 || akills[i].expires > now)
	    continue;
	if (WallAkillExpire)
	    wallops(s_OperServ, "AKILL on %s has expired", akills[i].mask);
	free(akills[i].mask);
	free(akills[i].reason);
	nakill--;
	if (i < nakill)
	    memmove(akills+i, akills+i+1, sizeof(*akills) * (nakill-i));
	i--;
    }
}

/*************************************************************************/
/************************** AKILL list editing ***************************/
/*************************************************************************/

/* Note that all parameters except expiry are assumed to be non-NULL.  A
 * value of NULL for expiry indicates that the AKILL should not expire.
 */

void add_akill(const char *mask, const char *reason, const char *who,
		      const char *expiry)
{
    if (nakill >= 32767) {
	log1("%s: Attempt to add AKILL to full list!", s_OperServ);
	return;
    }
    if (nakill >= akill_size) {
	if (akill_size < 8)
	    akill_size = 8;
	else
	    akill_size *= 2;
	akills = srealloc(akills, sizeof(*akills) * akill_size);
    }
    akills[nakill].mask = sstrdup(mask);
    akills[nakill].reason = sstrdup(reason);
    akills[nakill].time = time(NULL);
    strscpy(akills[nakill].who, who, NICKMAX);
    if (expiry) {
	int amount = strtol(expiry, (char **)&expiry, 10);
	if (amount == 0) {
	    akills[nakill].expires = 0;
	} else {
	    switch (*expiry) {
		case 'd': amount *= 24;
		case 'h': amount *= 60;
		case 'm': amount *= 60; break;
		default : amount = -akills[nakill].time;
	    }
	    akills[nakill].expires = amount + akills[nakill].time;
	}
    } else {
	akills[nakill].expires = AutokillExpiry + akills[nakill].time;
    }
    nakill++;
}

/*************************************************************************/

/* Return whether the mask was found in the AKILL list. */

static int del_akill(const char *mask)
{
    int i;

    for (i = 0; i < nakill && strcmp(akills[i].mask, mask) != 0; i++)
	;
    if (i < nakill) {
	free(akills[i].mask);
	free(akills[i].reason);
	nakill--;
	if (i < nakill)
	    memmove(akills+i, akills+i+1, sizeof(*akills) * (nakill-i));
	return 1;
    } else {
	return 0;
    }
}

/*************************************************************************/

/* Handle an OperServ AKILL command. */

void do_akill(User *u)
{
    char *cmd, *mask, *reason, *expiry, *s;
    int i;

    cmd = strtok(NULL, " ");
    if (!cmd)
	cmd = "";

    if (stricmp(cmd, "ADD") == 0) {
	if (nakill >= 32767) {
	    notice_lang(s_OperServ, u, OPER_TOO_MANY_AKILLS);
	    return;
	}
	mask = strtok(NULL, " ");
	if (mask && *mask == '+') {
	    expiry = mask;
	    mask = strtok(NULL, " ");
	} else {
	    expiry = NULL;
	}
	if (mask && (reason = strtok(NULL, ""))) {
	    s = strchr(mask, '@');
	    if (s) {
		strlower(s);
	    } else {
		notice_lang(s_OperServ, u, BAD_USERHOST_MASK);
		return;
	    }
	    if (strchr(mask, '!'))
		notice_lang(s_OperServ, u, OPER_AKILL_NO_NICK);
	    del_akill(mask);
	    add_akill(mask, reason, u->nick, expiry);
	    notice_lang(s_OperServ, u, OPER_AKILL_ADDED, mask);
	    if (WallOSAkill) {
		char buf[128], *s = NULL;
		int amount = AutokillExpiry;
		if (expiry) {
		    amount = strtol(expiry, (char **)&expiry, 10);
		    if (amount) {
			switch (*expiry) {
			    case 'd': s = "day";    break;
			    case 'h': s = "hour";   break;
			    case 'm': s = "minute"; break;
			    default : amount = 0;
			}
		    }
		} else s="second";
		if (!amount)
		    strcpy(buf, "does not expire");
		else
		    snprintf(buf, sizeof(buf), "expires in %d %s%s",
					amount, s, amount==1 ? "" : "s");
		wallops(s_OperServ, "%s added an AKILL for %s (%s)",
			u->nick, mask, buf);
	    }
	    if (readonly)
		notice_lang(s_OperServ, u, READ_ONLY_MODE);
	} else {
	    syntax_error(s_OperServ, u, "AKILL", OPER_AKILL_ADD_SYNTAX);
	}

    } else if (stricmp(cmd, "DEL") == 0) {
	mask = strtok(NULL, " ");
	if (mask) {
	    s = strchr(mask, '@');
	    if (s)
		strlower(s);
	    if (del_akill(mask)) {
		notice_lang(s_OperServ, u, OPER_AKILL_REMOVED, mask);
		if (readonly)
		    notice_lang(s_OperServ, u, READ_ONLY_MODE);
	    } else {
		notice_lang(s_OperServ, u, OPER_AKILL_NOT_FOUND, mask);
	    }
	} else {
	    syntax_error(s_OperServ, u, "AKILL", OPER_AKILL_DEL_SYNTAX);
	}

    } else if (stricmp(cmd, "LIST") == 0) {
	expire_akills();
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	if (strchr(s, '@'))
	    strlower(strchr(s, '@'));
	notice_lang(s_OperServ, u, OPER_AKILL_LIST_HEADER);
	for (i = 0; i < nakill; i++) {
	    if (!s || match_wild(s, akills[i].mask)) {
		notice_lang(s_OperServ, u, OPER_AKILL_LIST_FORMAT,
					akills[i].mask, akills[i].reason);
	    }
	}

    } else if (stricmp(cmd, "VIEW") == 0) {
	expire_akills();
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	if (strchr(s, '@'))
	    strlower(strchr(s, '@'));
	notice_lang(s_OperServ, u, OPER_AKILL_LIST_HEADER);
	for (i = 0; i < nakill; i++) {
	    if (!s || match_wild(s, akills[i].mask)) {
		char timebuf[32], expirebuf[256];
		struct tm tm;
		time_t t = time(NULL);

		tm = *localtime(akills[i].time ? &akills[i].time : &t);
		strftime_lang(timebuf, sizeof(timebuf),
			u, STRFTIME_SHORT_DATE_FORMAT, &tm);
		if (akills[i].expires == 0) {
		    snprintf(expirebuf, sizeof(expirebuf),
				getstring(u, OPER_AKILL_NO_EXPIRE));
		} else if (akills[i].expires <= t) {
		    snprintf(expirebuf, sizeof(expirebuf),
				getstring(u, OPER_AKILL_EXPIRES_SOON));
		} else {
		    time_t t2 = akills[i].expires - t;
		    t2 += 59;
		    if (t2 < 3600) {
			t2 /= 60;
			if (t2 == 1)
			    snprintf(expirebuf, sizeof(expirebuf),
				getstring(u, OPER_AKILL_EXPIRES_1M), t2);
			else
			    snprintf(expirebuf, sizeof(expirebuf),
				getstring(u, OPER_AKILL_EXPIRES_M), t2);
		    } else if (t2 < 86400) {
			t2 /= 60;
			if (t2/60 == 1) {
			    if (t2%60 == 1)
				snprintf(expirebuf, sizeof(expirebuf),
				    getstring(u, OPER_AKILL_EXPIRES_1H1M),
				    t2/60, t2%60);
			    else
				snprintf(expirebuf, sizeof(expirebuf),
				    getstring(u, OPER_AKILL_EXPIRES_1HM),
				    t2/60, t2%60);
			} else {
			    if (t2%60 == 1)
				snprintf(expirebuf, sizeof(expirebuf),
				    getstring(u, OPER_AKILL_EXPIRES_H1M),
				    t2/60, t2%60);
			    else
				snprintf(expirebuf, sizeof(expirebuf),
				    getstring(u, OPER_AKILL_EXPIRES_HM),
				    t2/60, t2%60);
			}
		    } else {
			t2 /= 86400;
			if (t2 == 1)
			    snprintf(expirebuf, sizeof(expirebuf),
				getstring(u, OPER_AKILL_EXPIRES_1D), t2);
			else
			    snprintf(expirebuf, sizeof(expirebuf),
				getstring(u, OPER_AKILL_EXPIRES_D), t2);
		    }
				
		}
		notice_lang(s_OperServ, u, OPER_AKILL_VIEW_FORMAT,
				akills[i].mask,
				*akills[i].who ? akills[i].who : "<unknown>",
				timebuf, expirebuf, akills[i].reason);
	    }
	}

    } else {
	syntax_error(s_OperServ, u, "AKILL", OPER_AKILL_SYNTAX);
    }
}

/*************************************************************************/
