/* sqvline.c
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 * http://www.ptlink.net/Coders/ - coders@PTlink.net
 * This program is distributed under GNU Public License
 *
 * Please read the file COPYING for copyright information.
 * $Id: sqvline.c,v 1.2 2004/11/21 12:10:23 jpinto Exp $  
*/
#include "services.h"
#include "pseudo.h"
#include "ircdsetup.h"
#define DFV_SQLINE 1
       
struct sqline {
    char *mask;
    char *reason;
    char who[NICKMAX];
    time_t time;
};



static struct sqline *sqlines = NULL;
static int32 nsqline = 0;
static int32 sqline_size = 0;

/*************************************************************************/
/********************* SQLINE database load/save *************************/
/*************************************************************************/

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", SQlineDBName);	\
	nsqline = i;					\
	break;						\
    }							\
} while (0)

void load_sq_dbase(void)
{
    dbFILE *f;
    int i, ver;
    int16 sver; /* data file suberversion number */
    int16 tmp16;
    int32 tmp32;
    if (!(f = open_db("SQLINE", SQlineDBName, "r")))
	return;
    ver = get_file_version(f);
    if(ver==-1) read_int16(&sver, f); else sver=0;
    if(sver!=1) fatal("Unsupported subversion (%d) on %s", sver, SQlineDBName);
    read_int16(&tmp16, f);
    nsqline = tmp16;
    if (nsqline < 8)
	sqline_size = 16;
    else if (nsqline >= 16384)
	sqline_size = 32767;
    else
	sqline_size = 2*nsqline;
    sqlines = scalloc(sizeof(*sqlines), sqline_size);

    switch (ver) {
      case -1: {
	for (i = 0; i < nsqline; i++) {
	    SAFE(read_string(&sqlines[i].mask, f));
	    SAFE(read_string(&sqlines[i].reason, f));
	    SAFE(read_buffer(sqlines[i].who, f));
	    SAFE(read_int32(&tmp32, f));
	    sqlines[i].time = tmp32;
	}
	break;

      } /* case 10 */
      default:
	fatal("Unsupported version (%d) on %s", ver, SQlineDBName);
    } /* switch (version) */

    close_db(f);
}

#undef SAFE

/*************************************************************************/

#define SAFE(x) do {							\
    if ((x) < 0) {							\
	restore_db(f);							\
	log_perror("Write error on %s", SQlineDBName);			\
	if (time(NULL) - lastwarn > WarningTimeout) {			\
	    wallops(NULL, "Write error on %s: %s", SQlineDBName,	\
			strerror(errno));				\
	    lastwarn = time(NULL);					\
	}								\
	return;								\
    }									\
} while (0)

void save_sq_dbase(void)
{
    dbFILE *f;
    int i;
    static time_t lastwarn = 0;

    f = open_db("SQLINE", SQlineDBName, "w");
    write_int16(DFV_SQLINE, f);
    write_int16(nsqline, f);
    for (i = 0; i < nsqline; i++) {
	SAFE(write_string(sqlines[i].mask, f));
	SAFE(write_string(sqlines[i].reason, f));
	SAFE(write_buffer(sqlines[i].who, f));
	SAFE(write_int32(sqlines[i].time, f));
    }
    close_db(f);
}

#undef SAFE


/*
    Is the user hostname on the sqline list ?
    
*/
int check_sqline(const char* nick)
{
    char buf[512];
    int i;
    strlower(strcpy(buf,nick));
    for (i = 0; i < nsqline; i++) 
	if (match_wild_nocase(sqlines[i].mask, buf)) return 1;
    return 0;
}

static int del_sqline(const char *mask)
{
    int i;

    for (i = 0; i < nsqline && strcmp(sqlines[i].mask, mask) != 0; i++)
	;
    if (i < nsqline) {
	free(sqlines[i].mask);
	free(sqlines[i].reason);
	nsqline--;
	if (i < nsqline)
	    memmove(sqlines+i, sqlines+i+1, sizeof(*sqlines) * (nsqline-i));
	return 1;
    } else {
	return 0;
    }
}


static void add_sqline(const char *mask, const char *reason, const char *who)
{
    del_sqline(mask);
    if (nsqline >= 32767) {
	log1("%s: Attempt to add SQline entry to full list!", s_OperServ);
	return;
    }
    if (nsqline >= sqline_size) {
	if (sqline_size < 8)
	    sqline_size = 8;
	else
	    sqline_size *= 2;
	sqlines = srealloc(sqlines, sizeof(*sqlines) * sqline_size);
    }
    sqlines[nsqline].mask = sstrdup(mask);
    sqlines[nsqline].reason = sstrdup(reason);
    sqlines[nsqline].time = time(NULL);
    strscpy(sqlines[nsqline].who, who, NICKMAX);
    nsqline++;
}


void do_sqline(User *u)
{
    char *cmd, *mask, *reason, *s;
    int i;

    cmd = strtok(NULL, " ");
    if (!cmd)
	cmd = "";

    if (strcasecmp(cmd, "ADD") == 0) {
	if (nsqline >= 32767) {
	    notice_lang(s_OperServ, u, OPER_TOO_MANY_SQLINE);
	    return;
	}
	mask = strtok(NULL, " ");
	if (mask && (reason = strtok(NULL, ""))) {
	    if (strchr(mask, '!') || strchr(mask, '@'))
		notice_lang(s_OperServ, u, OPER_SQLINE_JUST_NICK);
	    add_sqline(mask, reason, u->nick);
	    send_cmd(ServerName,"SQLINE %s :%s", mask, reason);
	    notice_lang(s_OperServ, u, OPER_SQLINE_ADDED, mask);
	    if (readonly)
		notice_lang(s_OperServ, u, READ_ONLY_MODE);
	} else {
	    syntax_error(s_OperServ, u, "SQLINE", OPER_SQLINE_ADD_SYNTAX);
	}

    } else if (strcasecmp(cmd, "DEL") == 0) {
	mask = strtok(NULL, " ");
	if (mask) {
	    s = strchr(mask, '@');
	    if (s)
		strlower(s);
	    if (del_sqline(mask)) {
	    	    send_cmd(ServerName,"UNSQLINE %s", mask);
		notice_lang(s_OperServ, u, OPER_SQLINE_REMOVED, mask);
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
		notice_lang(s_OperServ, u, OPER_SQLINE_NOT_FOUND, mask);
	    }
	} else {
	    syntax_error(s_OperServ, u, "SQLINE", OPER_SQLINE_DEL_SYNTAX);
	}

    } else if (strcasecmp(cmd, "LIST") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	notice_lang(s_OperServ, u, OPER_SQLINE_HEADER);
	for (i = 0; i < nsqline; i++) {
	    if (!s || match_wild(s, sqlines[i].mask)) {
		notice_lang(s_OperServ, u, OPER_SQLINE_FORMAT,
					sqlines[i].mask, sqlines[i].reason);
	    }
	}

    } else if (strcasecmp(cmd, "VIEW") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	notice_lang(s_OperServ, u, OPER_SQLINE_HEADER);
	for (i = 0; i < nsqline; i++) {
	    if (!s || match_wild(s, sqlines[i].mask)) {
		char timebuf[32];
		struct tm tm;
		time_t t = time(NULL);

		tm = *localtime(sqlines[i].time ? &sqlines[i].time : &t);
		strftime_lang(timebuf, sizeof(timebuf),
			u, STRFTIME_SHORT_DATE_FORMAT, &tm);
		notice_lang(s_OperServ, u, OPER_SQLINE_VIEW_FORMAT,
				sqlines[i].mask,
				*sqlines[i].who ? sqlines[i].who : "<unknown>",
				timebuf, sqlines[i].reason);
	      }		
	  }
    }
    else syntax_error(s_OperServ, u, "SQLINE", OPER_SQLINE_SYNTAX );
}

void set_sqlines (void)
{
    int i;
    for (i = 0; i < nsqline; i++) send_cmd(ServerName,"SQLINE %s :%s",sqlines[i].mask,sqlines[i].reason);
}

/*********************************************************************************************************
 * V-Lines related code                                                                                  *    
 *                                                                                                       *
 *                                                                                                       * 
 *                                                                                                       * 
 *********************************************************************************************************/

#define DFV_VLINE 1
       
struct vline {
    char *mask;
    char *reason;
    char who[NICKMAX];
    time_t time;
};



static struct vline *vlines = NULL;
static int32 nvline = 0;
static int32 vline_size = 0;

/*************************************************************************/
/********************* vline database load/save *************************/
/*************************************************************************/

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", VlineDBName);	\
	nvline = i;					\
	break;						\
    }							\
} while (0)

void load_vl_dbase(void)
{
    dbFILE *f;
    int i, ver;
    int16 sver; /* data file suberversion number */
    int16 tmp16;
    int32 tmp32;
    if (!(f = open_db("VLINE", VlineDBName, "r")))
	return;
    ver = get_file_version(f);
    if(ver==-1) read_int16(&sver, f); else sver=0;
    if(sver!=1) fatal("Unsupported subversion (%d) on %s", sver, VlineDBName);
    read_int16(&tmp16, f);
    nvline = tmp16;
    if (nvline < 8)
	vline_size = 16;
    else if (nvline >= 16384)
	vline_size = 32767;
    else
	vline_size = 2*nvline;
    vlines = scalloc(sizeof(*vlines), vline_size);

    switch (ver) {
      case -1: {
	for (i = 0; i < nvline; i++) {
	    SAFE(read_string(&vlines[i].mask, f));
	    SAFE(read_string(&vlines[i].reason, f));
	    SAFE(read_buffer(vlines[i].who, f));
	    SAFE(read_int32(&tmp32, f));
	    vlines[i].time = tmp32;
	}
	break;

      } /* case 10 */
      default:
	fatal("Unsupported version (%d) on %s", ver, VlineDBName);
    } /* switch (version) */

    close_db(f);
}

#undef SAFE

/*************************************************************************/

#define SAFE(x) do {							\
    if ((x) < 0) {							\
	restore_db(f);							\
	log_perror("Write error on %s", VlineDBName);			\
	if (time(NULL) - lastwarn > WarningTimeout) {			\
	    wallops(NULL, "Write error on %s: %s", VlineDBName,	\
			strerror(errno));				\
	    lastwarn = time(NULL);					\
	}								\
	return;								\
    }									\
} while (0)

void save_vl_dbase(void)
{
    dbFILE *f;
    int i;
    static time_t lastwarn = 0;

    f = open_db("vline", VlineDBName, "w");
    write_int16(DFV_VLINE, f);
    write_int16(nvline, f);
    for (i = 0; i < nvline; i++) {
	SAFE(write_string(vlines[i].mask, f));
	SAFE(write_string(vlines[i].reason, f));
	SAFE(write_buffer(vlines[i].who, f));
	SAFE(write_int32(vlines[i].time, f));
    }
    close_db(f);
}

#undef SAFE


/*
    Is the vline mask on the vline list ?
    
*/
int check_vline(const char* mask)
{
    char buf[512];
    int i;
    strlower(strcpy(buf,mask));
    for (i = 0; i < nvline; i++) 
	if (match_wild_nocase(vlines[i].mask, buf)) return 1;
    return 0;
}

static int del_vline(const char *mask)
{
    int i;

    for (i = 0; i < nvline && strcmp(vlines[i].mask, mask) != 0; i++)
	;
    if (i < nvline) {
	free(vlines[i].mask);
	free(vlines[i].reason);
	nvline--;
	if (i < nvline)
	    memmove(vlines+i, vlines+i+1, sizeof(*vlines) * (nvline-i));
	return 1;
    } else {
	return 0;
    }
}


static void add_vline(const char *mask, const char *reason, const char *who)
{
    del_vline(mask);
    if (nvline >= 32767) {
	log1("%s: Attempt to add VLINE entry to full list!", s_OperServ);
	return;
    }
    if (nvline >= vline_size) {
	if (vline_size < 8)
	    vline_size = 8;
	else
	    vline_size *= 2;
	vlines = srealloc(vlines, sizeof(*vlines) * vline_size);
    }
    vlines[nvline].mask = sstrdup(mask);
    vlines[nvline].reason = sstrdup(reason);
    vlines[nvline].time = time(NULL);
    strscpy(vlines[nvline].who, who, NICKMAX);
    nvline++;
}


void do_vline(User *u)
{
    char *cmd, *mask, *reason, *s;
    int i;

    cmd = strtok(NULL, " ");
    if (!cmd)
	cmd = "";

    if (strcasecmp(cmd, "ADD") == 0) {
	if (nvline >= 32767) {
	    notice_lang(s_OperServ, u, OPER_TOO_MANY_VLINE);
	    return;
	}
	mask = strtok(NULL, " ");
	if (mask && (reason = strtok(NULL, ""))) {
	    add_vline(mask, reason, u->nick);
	    send_cmd(ServerName,"SVLINE %s :%s", mask, reason);
	    notice_lang(s_OperServ, u, OPER_VLINE_ADDED, mask);
	    if (readonly)
		notice_lang(s_OperServ, u, READ_ONLY_MODE);
	} else {
	    syntax_error(s_OperServ, u, "VLINE", OPER_VLINE_ADD_SYNTAX);
	}

    } else if (strcasecmp(cmd, "DEL") == 0) {
	mask = strtok(NULL, " ");
	if (mask) {
	    s = strchr(mask, '@');
	    if (s)
		strlower(s);
	    if (del_vline(mask)) {
	    	    send_cmd(ServerName,"UNSVLINE %s", mask);
		notice_lang(s_OperServ, u, OPER_VLINE_REMOVED, mask);
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
		notice_lang(s_OperServ, u, OPER_VLINE_NOT_FOUND, mask);
	    }
	} else {
	    syntax_error(s_OperServ, u, "VLINE", OPER_VLINE_DEL_SYNTAX);
	}

    } else if (strcasecmp(cmd, "LIST") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	notice_lang(s_OperServ, u, OPER_VLINE_HEADER);
	for (i = 0; i < nvline; i++) {
	    if (!s || match_wild(s, vlines[i].mask)) {
		notice_lang(s_OperServ, u, OPER_VLINE_FORMAT,
					vlines[i].mask, vlines[i].reason);
	    }
	}

    } else if (strcasecmp(cmd, "VIEW") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	notice_lang(s_OperServ, u, OPER_VLINE_HEADER);
	for (i = 0; i < nvline; i++) {
	    if (!s || match_wild(s, vlines[i].mask)) {
		char timebuf[32];
		struct tm tm;
		time_t t = time(NULL);

		tm = *localtime(vlines[i].time ? &vlines[i].time : &t);
		strftime_lang(timebuf, sizeof(timebuf),
			u, STRFTIME_SHORT_DATE_FORMAT, &tm);
		notice_lang(s_OperServ, u, OPER_VLINE_VIEW_FORMAT,
				vlines[i].mask,
				*vlines[i].who ? vlines[i].who : "<unknown>",
				timebuf, vlines[i].reason);
	      }		
	  }
    }
    else syntax_error(s_OperServ, u, "VLINE", OPER_VLINE_SYNTAX );
}

void set_vlines (void)
{
    int i;
    for (i = 0; i < nvline; i++) send_cmd(ServerName,"SVLINE %s :%s",vlines[i].mask,vlines[i].reason);
}

/*********************************************************************************************************
 * SX-Lines related code                                                                                  *    
 *                                                                                                       *
 *                                                                                                       * 
 *                                                                                                       * 
 *********************************************************************************************************/

#define DFV_SXLINE 1
       
struct sxline {
    char *mask;
    char *reason;
    char who[NICKMAX];
    time_t time;
};



static struct sxline *sxlines = NULL;
static int32 nsxline = 0;
static int32 sxline_size = 0;

/*************************************************************************/
/********************* sxline database load/save *************************/
/*************************************************************************/

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", SXlineDBName);	\
	nvline = i;					\
	break;						\
    }							\
} while (0)

void load_sxl_dbase(void)
{
    dbFILE *f;
    int i, ver;
    int16 sver; /* data file suberversion number */
    int16 tmp16;
    int32 tmp32;
    if (!(f = open_db("SXLINE", SXlineDBName, "r")))
	return;
    ver = get_file_version(f);
    if(ver==-1) read_int16(&sver, f); else sver=0;
    if(sver!=1) fatal("Unsupported subversion (%d) on %s", sver, SXlineDBName);
    read_int16(&tmp16, f);
    nsxline = tmp16;
    if (nsxline < 8)
	sxline_size = 16;
    else if (nsxline >= 16384)
	sxline_size = 32767;
    else
	sxline_size = 2*nsxline;
    sxlines = scalloc(sizeof(*sxlines), sxline_size);

    switch (ver) {
      case -1: {
	for (i = 0; i < nsxline; i++) {
	    SAFE(read_string(&sxlines[i].mask, f));
	    SAFE(read_string(&sxlines[i].reason, f));
	    SAFE(read_buffer(sxlines[i].who, f));
	    SAFE(read_int32(&tmp32, f));
	    sxlines[i].time = tmp32;
	}
	break;

      } /* case 10 */
      default:
	fatal("Unsupported version (%d) on %s", ver, SXlineDBName);
    } /* switch (version) */

    close_db(f);
}

#undef SAFE

/*************************************************************************/

#define SAFE(x) do {							\
    if ((x) < 0) {							\
	restore_db(f);							\
	log_perror("Write error on %s", SXlineDBName);			\
	if (time(NULL) - lastwarn > WarningTimeout) {			\
	    wallops(NULL, "Write error on %s: %s", SXlineDBName,	\
			strerror(errno));				\
	    lastwarn = time(NULL);					\
	}								\
	return;								\
    }									\
} while (0)

void save_sxl_dbase(void)
{
    dbFILE *f;
    int i;
    static time_t lastwarn = 0;

    f = open_db("sxline", SXlineDBName, "w");
    write_int16(DFV_SXLINE, f);
    write_int16(nsxline, f);
    for (i = 0; i < nsxline; i++) {
	SAFE(write_string(sxlines[i].mask, f));
	SAFE(write_string(sxlines[i].reason, f));
	SAFE(write_buffer(sxlines[i].who, f));
	SAFE(write_int32(sxlines[i].time, f));
    }
    close_db(f);
}

#undef SAFE

int check_sxline(const char* mask)
{
    char buf[512];
    int i;
    strlower(strcpy(buf,mask));
    for (i = 0; i < nsxline; i++) 
	if (match_wild_nocase(sxlines[i].mask, buf)) return 1;
    return 0;
}

static int del_sxline(const char *mask)
{
    int i;

    for (i = 0; i < nsxline && strcmp(sxlines[i].mask, mask) != 0; i++)
	;
    if (i < nsxline) {
	free(sxlines[i].mask);
	free(sxlines[i].reason);
	nsxline--;
	if (i < nsxline)
	    memmove(sxlines+i, sxlines+i+1, sizeof(*sxlines) * (nsxline-i));
	return 1;
    } else {
	return 0;
    }
}

static void add_sxline(const char *mask, const char *reason, const char *who)
{
    del_sxline(mask);
    if (nsxline >= 32767) {
	log1("%s: Attempt to add SXLINE entry to full list!", s_OperServ);
	return;
    }
    if (nsxline >= sxline_size) {
	if (sxline_size < 8)
	    sxline_size = 8;
	else
	    sxline_size *= 2;
	sxlines = srealloc(sxlines, sizeof(*sxlines) * sxline_size);
    }
    sxlines[nsxline].mask = sstrdup(mask);
    sxlines[nsxline].reason = sstrdup(reason);
    sxlines[nsxline].time = time(NULL);
    strscpy(sxlines[nsxline].who, who, NICKMAX);
    nsxline++;
}

void do_sxline(User *u)
{
    char *cmd, *mask, *reason, *s;
    int i;

    cmd = strtok(NULL, " ");
    mask = strtok(NULL, "");
    if (!cmd)
	cmd = "";
    if ((strcasecmp(cmd, "ADD") == 0) && mask) {
	if (nsxline >= 32767) {
	    notice_lang(s_OperServ, u, OPER_TOO_MANY_SXLINE);
	    return;
	}
	s = strchr(mask, ':');
	if (s && *s) {
	    *s='\0';
	    reason=(char*)(s+1);	
	    add_sxline(mask, reason, u->nick);
	    send_cmd(ServerName,"SXLINE %d :%s:%s", strlen(mask), mask, reason);
	    notice_lang(s_OperServ, u, OPER_SXLINE_ADDED, mask);
	    if (readonly)
		notice_lang(s_OperServ, u, READ_ONLY_MODE);
	} else {
	    syntax_error(s_OperServ, u, "SXLINE", OPER_SXLINE_ADD_SYNTAX);
	}
    } else if ((strcasecmp(cmd, "DEL") == 0) && mask) {
	if (del_sxline(mask)) 
	  {
	    send_cmd(ServerName,"UNSXLINE :%s", mask);
	    notice_lang(s_OperServ, u, OPER_SXLINE_REMOVED, mask);
	  }
	else 
	    notice_lang(s_OperServ, u, OPER_SXLINE_NOT_FOUND, mask);

	if (readonly)
	    notice_lang(s_OperServ, u, READ_ONLY_MODE);	  
    } else if (strcasecmp(cmd, "LIST") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	notice_lang(s_OperServ, u, OPER_SXLINE_HEADER);
	for (i = 0; i < nsxline; i++) {
	    if (!s || match_wild(s, sxlines[i].mask)) {
		notice_lang(s_OperServ, u, OPER_SXLINE_FORMAT,
					sxlines[i].mask, sxlines[i].reason);
	    }
	}

    } else if (strcasecmp(cmd, "VIEW") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	notice_lang(s_OperServ, u, OPER_SXLINE_HEADER);
	for (i = 0; i < nsxline; i++) {
	    if (!s || match_wild(s, sxlines[i].mask)) {
		char timebuf[32];
		struct tm tm;
		time_t t = time(NULL);

		tm = *localtime(sxlines[i].time ? &sxlines[i].time : &t);
		strftime_lang(timebuf, sizeof(timebuf),
			u, STRFTIME_SHORT_DATE_FORMAT, &tm);
		notice_lang(s_OperServ, u, OPER_SXLINE_VIEW_FORMAT,
				sxlines[i].mask,
				*sxlines[i].who ? sxlines[i].who : "<unknown>",
				timebuf, sxlines[i].reason);
	      }		
	  }
    }
    else syntax_error(s_OperServ, u, "SXLINE", OPER_SXLINE_SYNTAX );
}

void set_sxlines (void)
{
    int i;
    for (i = 0; i < nsxline; i++) send_cmd(ServerName,"SXLINE %d :%s:%s",strlen(sxlines[i].mask), sxlines[i].mask,sxlines[i].reason);
}

/*********************************************************************************************************
 * V-Link related code                                                                                  *    
 *                                                                                                       *
 *                                                                                                       * 
 *                                                                                                       * 
 *********************************************************************************************************/

#define DFV_VLINK 1
       
struct vlink {
    char *mask;
    char *reason;
    char who[NICKMAX];
    time_t time;
};



static struct vlink *vlinks = NULL;
static int32 nvlink = 0;
static int32 vlink_size = 0;

/*************************************************************************/
/********************* vlink database load/save *************************/
/*************************************************************************/

#define SAFE(x) do {					\
    if ((x) < 0) {					\
	if (!forceload)					\
	    fatal("Read error on %s", VlinkDBName);	\
	nvlink = i;					\
	break;						\
    }							\
} while (0)

void load_vlink_dbase(void)
{
    dbFILE *f;
    int i, ver;
    int16 sver; /* data file suberversion number */
    int16 tmp16;
    int32 tmp32;
    if (!(f = open_db("VLINK", VlinkDBName, "r")))
	return;
    ver = get_file_version(f);
    if(ver==-1) read_int16(&sver, f); else sver=0;
    if(sver!=1) fatal("Unsupported subversion (%d) on %s", sver, VlinkDBName);
    read_int16(&tmp16, f);
    nvlink = tmp16;
    if (nvlink < 8)
	vlink_size = 16;
    else if (nvlink >= 16384)
	vlink_size = 32767;
    else
	vlink_size = 2*nvlink;
    vlinks = scalloc(sizeof(*vlinks), vlink_size);

    switch (ver) {
      case -1: {
	for (i = 0; i < nvlink; i++) {
	    SAFE(read_string(&vlinks[i].mask, f));
	    SAFE(read_string(&vlinks[i].reason, f));
	    SAFE(read_buffer(vlinks[i].who, f));
	    SAFE(read_int32(&tmp32, f));
	    vlinks[i].time = tmp32;
	}
	break;

      } /* case 10 */
      default:
	fatal("Unsupported version (%d) on %s", ver, VlinkDBName);
    } /* switch (version) */

    close_db(f);
}

#undef SAFE

/*************************************************************************/

#define SAFE(x) do {							\
    if ((x) < 0) {							\
	restore_db(f);							\
	log_perror("Write error on %s", VlinkDBName);			\
	if (time(NULL) - lastwarn > WarningTimeout) {			\
	    wallops(NULL, "Write error on %s: %s", VlinkDBName,	\
			strerror(errno));				\
	    lastwarn = time(NULL);					\
	}								\
	return;								\
    }									\
} while (0)

void save_vlink_dbase(void)
{
    dbFILE *f;
    int i;
    static time_t lastwarn = 0;

    f = open_db("vlink", VlinkDBName, "w");
    write_int16(DFV_VLINK, f);
    write_int16(nvlink, f);
    for (i = 0; i < nvlink; i++) {
	SAFE(write_string(vlinks[i].mask, f));
	SAFE(write_string(vlinks[i].reason, f));
	SAFE(write_buffer(vlinks[i].who, f));
	SAFE(write_int32(vlinks[i].time, f));
    }
    close_db(f);
}

#undef SAFE


/*
    Is the vlink mask on the vlink list ?
    
*/
int check_vlink(const char* mask)
{
    char buf[512];
    int i;
    strlower(strcpy(buf,mask));
    for (i = 0; i < nvlink; i++) 
	if (match_wild_nocase(vlinks[i].mask, buf)) return 1;
    return 0;
}

static int del_vlink(const char *mask)
{
    int i;

    for (i = 0; i < nvlink && strcmp(vlinks[i].mask, mask) != 0; i++)
	;
    if (i < nvlink) {
	free(vlinks[i].mask);
	free(vlinks[i].reason);
	nvlink--;
	if (i < nvlink)
	    memmove(vlinks+i, vlinks+i+1, sizeof(*vlinks) * (nvlink-i));
	return 1;
    } else {
	return 0;
    }
}


static void add_vlink(const char *mask, const char *reason, const char *who)
{
    del_vlink(mask);
    if (nvlink >= 32767) {
	log1("%s: Attempt to add VLINK entry to full list!", s_OperServ);
	return;
    }
    if (nvlink >= vlink_size) {
	if (vlink_size < 8)
	    vlink_size = 8;
	else
	    vlink_size *= 2;
	vlinks = srealloc(vlinks, sizeof(*vlinks) * vlink_size);
    }
    vlinks[nvlink].mask = sstrdup(mask);
    vlinks[nvlink].reason = sstrdup(reason);
    vlinks[nvlink].time = time(NULL);
    strscpy(vlinks[nvlink].who, who, NICKMAX);
    nvlink++;
}

void do_vlink(User *u)
{
    char *cmd, *mask, *reason, *s;
    int i;

    cmd = strtok(NULL, " ");
    if (!cmd)
	cmd = "";

    if (strcasecmp(cmd, "ADD") == 0) {
	if (nvlink >= 32767) {
	    notice_lang(s_OperServ, u, OPER_TOO_MANY_VLINK);
	    return;
	}
	mask = strtok(NULL, " ");
	if (mask && (reason = strtok(NULL, ""))) {
	    add_vlink(mask, reason, u->nick);
	    send_cmd(ServerName,"VLINK %s :%s", mask, reason);
	    notice_lang(s_OperServ, u, OPER_VLINK_ADDED, mask);
	    if (readonly)
		notice_lang(s_OperServ, u, READ_ONLY_MODE);
	} else {
	    syntax_error(s_OperServ, u, "VLINK", OPER_VLINK_ADD_SYNTAX);
	}

    } else if (strcasecmp(cmd, "DEL") == 0) {
	mask = strtok(NULL, " ");
	if (mask) {
	    s = strchr(mask, '@');
	    if (s)
		strlower(s);
	    if (del_vlink(mask)) {
	    	    send_cmd(ServerName,"VLINK -%s", mask);
		notice_lang(s_OperServ, u, OPER_VLINK_REMOVED, mask);
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
		notice_lang(s_OperServ, u, OPER_VLINK_NOT_FOUND, mask);
	    }
	} else {
	    syntax_error(s_OperServ, u, "VLINK", OPER_VLINK_DEL_SYNTAX);
	}

    } else if (strcasecmp(cmd, "LIST") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	notice_lang(s_OperServ, u, OPER_VLINK_HEADER);
	for (i = 0; i < nvlink; i++) {
	    if (!s || match_wild(s, vlinks[i].mask)) {
		notice_lang(s_OperServ, u, OPER_VLINK_FORMAT,
					vlinks[i].mask, vlinks[i].reason);
	    }
	}

    } else if (strcasecmp(cmd, "VIEW") == 0) {
	s = strtok(NULL, " ");
	if (!s)
	    s = "*";
	notice_lang(s_OperServ, u, OPER_VLINK_HEADER);
	for (i = 0; i < nvlink; i++) {
	    if (!s || match_wild(s, vlinks[i].mask)) {
		char timebuf[32];
		struct tm tm;
		time_t t = time(NULL);

		tm = *localtime(vlinks[i].time ? &vlinks[i].time : &t);
		strftime_lang(timebuf, sizeof(timebuf),
			u, STRFTIME_SHORT_DATE_FORMAT, &tm);
		notice_lang(s_OperServ, u, OPER_VLINK_VIEW_FORMAT,
				vlinks[i].mask,
				*vlinks[i].who ? vlinks[i].who : "<unknown>",
				timebuf, vlinks[i].reason);
	      }		
	  }
    }
    else syntax_error(s_OperServ, u, "VLINK", OPER_VLINK_SYNTAX );
}

void set_vlinks (void)
{
    int i;
    for (i = 0; i < nvlink; i++) send_cmd(ServerName,"VLINK %s :%s",vlinks[i].mask,vlinks[i].reason);
}
