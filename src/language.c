/* Multi-language support.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2000
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services
 */

#include "services.h"
#include "language.h"
#include "path.h"

/*************************************************************************/

/* The list of lists of messages. */
char **langtexts[NUM_LANGS];

/* The list of auth emails */
char authemail[NUM_LANGS][2048];

/* The list of setemails */
char setemail[NUM_LANGS][2048];

/* The list of names of languages. */
char *langnames[NUM_LANGS];

/* Indexes of available languages: */
int langlist[NUM_LANGS];

/* Order in which languages should be displayed: (alphabetical) */
static int langorder[NUM_LANGS] = {
    LANG_EN_US,		/* English (US) */
    LANG_PT,		/* Portugese */
    LANG_TR,		/* Turkish */
    LANG_DE,		/* German */
    LANG_IT,		/* Italian */
    LANG_NL,		/* Dutch */
    LANG_PT_BR		/* Brazil Portuguese */
};

static LangInfo domslist[NUM_DOMS]; /* List of domain and their language setting */
static int numdom = 0; /* number of existing domain language definitions */

/*************************************************************************/

/* Load a language file. */

static int read_int32(int32 *ptr, FILE *f)
{
    int a = fgetc(f);
    int b = fgetc(f);
    int c = fgetc(f);
    int d = fgetc(f);
    if (a == EOF || b == EOF || c == EOF || d == EOF)
	return -1;
    *ptr = a<<24 | b<<16 | c<<8 | d;
    return 0;
}

static void load_lang(int index, const char *filename)
{
    char buf[256];
    FILE *f;
    int num, i;

    if (debug) {
	log1("debug: Loading language %d from file `languages/%s'",
		index, filename);
    }
    snprintf(buf, sizeof(buf), "languages/%s", filename);
    if (!(f = fopen(buf, "r"))) {
	printf("Error\n");
	log_perror("Failed to load language %d (%s)", index, filename);
	return;
    } else if (read_int32(&num, f) < 0) {
	log1("Failed to read number of strings for language %d (%s)",
		index, filename);
	return;
    } else if (num != NUM_STRINGS) {
	log1("Warning: Bad number of strings (%d, wanted %d) "
	    "for language %d (%s)", num, NUM_STRINGS, index, filename);
    }
    langtexts[index] = scalloc(sizeof(char *), NUM_STRINGS);
    if (num > NUM_STRINGS)
	num = NUM_STRINGS;
    for (i = 0; i < num; i++) {
	int32 pos, len;
	fseek(f, i*8+4, SEEK_SET);
	if (read_int32(&pos, f) < 0 || read_int32(&len, f) < 0) {
	    log1("Failed to read entry %d in language %d (%s) TOC",
			i, index, filename);
	    while (--i >= 0) {
		if (langtexts[index][i])
		    free(langtexts[index][i]);
	    }
	    free(langtexts[index]);
	    langtexts[index] = NULL;
	    return;
	}
	if (len == 0) {
	    langtexts[index][i] = NULL;
	} else if (len >= 65536) {
	    log1("Entry %d in language %d (%s) is too long (over 64k)--"
		"corrupt TOC?", i, index, filename);
	    while (--i >= 0) {
		if (langtexts[index][i])
		    free(langtexts[index][i]);
	    }
	    free(langtexts[index]);
	    langtexts[index] = NULL;
	    return;
	} else if (len < 0) {
	    log1("Entry %d in language %d (%s) has negative length--"
		"corrupt TOC?", i, index, filename);
	    while (--i >= 0) {
		if (langtexts[index][i])
		    free(langtexts[index][i]);
	    }
	    free(langtexts[index]);
	    langtexts[index] = NULL;
	    return;
	} else {
	    langtexts[index][i] = smalloc(len+1);
	    fseek(f, pos, SEEK_SET);
	    if (fread(langtexts[index][i], 1, len, f) != len) {
		log1("Failed to read string %d in language %d (%s)",
			i, index, filename);
		while (--i >= 0) {
		    if (langtexts[index][i])
			free(langtexts[index][i]);
		}
		free(langtexts[index]);
		langtexts[index] = NULL;
		return;
	    }
	    langtexts[index][i][len] = 0;
	}
    }
   fclose(f);

    if(!NSNeedAuth)
      return;
      
    if (debug) {
	log1("debug: Loading auth email %d from file `languages/%s.auth'",
	  index, filename);
    }
    snprintf(buf, sizeof(buf), "languages/%s.auth", filename);
    if (!(f = fopen(buf, "r"))) {
	log_perror("Failed to load auth email %d (%s.auth)", index, filename);
	exit(2);
    }
    bzero(&authemail[index], sizeof(authemail[index]));
    fread(&authemail[index], 1,sizeof(authemail[index]), f);
    fclose(f);
    if (debug) {
	log1("debug: Loading setemail %d from file `languages/%s.setemail'",
	  index, filename);
    }
    snprintf(buf, sizeof(buf), "languages/%s.setemail", filename);
    if (!(f = fopen(buf, "r"))) {
	log_perror("Failed to load auth email %d (%s.setemail)", index, filename);
	exit(2);
    }
    bzero(&setemail[index], sizeof(setemail[index]));
    fread(&setemail[index], 1,sizeof(setemail[index]), f);
    fclose(f);

}

/*************************************************************************/

/* Initialize list of lists. */

void lang_init()
{
    FILE *domfile;
    char tmp[100]; /* dummy buffer */
    int i, j, n = 0;
   
    load_lang(LANG_EN_US, "en_us");
    load_lang(LANG_PT, "pt");
    load_lang(LANG_TR, "tr");
    load_lang(LANG_DE, "de");
    load_lang(LANG_IT, "it");
    load_lang(LANG_NL, "nl");
    load_lang(LANG_PT_BR, "pt_br");
    
    for (i = 0; i < NUM_LANGS; i++) {
	if (langtexts[langorder[i]] != NULL) {
	    langnames[langorder[i]] = langtexts[langorder[i]][LANG_NAME];
	    langlist[n++] = langorder[i];
	    for (j = 0; j < NUM_STRINGS; j++) {
		if (!langtexts[langorder[i]][j]) {
		    langtexts[langorder[i]][j] =
				langtexts[langorder[DefLanguage]][j];
		}
		if (!langtexts[langorder[i]][j]) {
		    langtexts[langorder[i]][j] =
				langtexts[langorder[LANG_EN_US]][j];
		}
	    }
	}
    }
    while (n < NUM_LANGS)
	langlist[n++] = -1;

    if (!langtexts[DefLanguage])
	fatal("Unable to load default language");
    for (i = 0; i < NUM_LANGS; i++) {
	if (!langtexts[i])
	    langtexts[i] = langtexts[DefLanguage];
    }
    domslist[0].language = DefLanguage;
    if(!DomainLangFN) 
      return;
    snprintf(tmp, sizeof(tmp), ETCPATH "/%s", DomainLangFN);
    if(!(domfile = fopen(tmp,"rt"))) {
	log1("Domain Language file not found for Smart Language Selection");
	return;
    } else 
      if(debug)
        log1("Loading Domain Language data file for Smart Language Selection");
    tmp[0]=fgetc(domfile);
    while(tmp[0]=='#')
    {	
	fgets(tmp,100,domfile); /* Read comment line */
	tmp[0]=fgetc(domfile);
    };
    if(tmp[0]=='*') {
	fscanf(domfile, "%i",&domslist[0].language);
	log1("(*) entry is not used any more, using DefLanguage for unresolved domains");	
    } else fgets(tmp,100,domfile);
    for (i = 1; !(feof(domfile)) && i < NUM_DOMS; i++) {
	fscanf(domfile, "%s %i\n",domslist[i].domain,&domslist[i].language);
	if(domslist[i].language>NUM_LANGS){
	    domslist[i].language=domslist[0].language;
	    log1("Invalid language setting for domain .%s setting as default",domslist[i].domain);
	} else 
	{
	    domslist[i].language=langlist[domslist[i].language-1]; /* to match help definitions */
	}
    }
    numdom = i;
    fclose(domfile);
}

/*************************************************************************/
/*************************************************************************/

/* Format a string in a strftime()-like way, but heed the user's language
 * setting for month and day names.  The string stored in the buffer will
 * always be null-terminated, even if the actual string was longer than the
 * buffer size.
 * Assumption: No month or day name has a length (including trailing null)
 * greater than BUFSIZE.
 */

int strftime_lang(char *buf, int size, User *u, int format, struct tm *tm)
{
    int language = u && u->ni ? u->ni->language : DefLanguage;
    char tmpbuf[BUFSIZE], buf2[BUFSIZE];
    char *s;
    int i, ret;

    strscpy(tmpbuf, langtexts[language][format], sizeof(tmpbuf));
    if ((s = langtexts[language][STRFTIME_DAYS_SHORT]) != NULL) {
	for (i = 0; i < tm->tm_wday; i++)
	    s += strcspn(s, "\n")+1;
	i = strcspn(s, "\n");
	strncpy(buf2, s, i);
	buf2[i] = 0;
	strnrepl(tmpbuf, sizeof(tmpbuf), "%a", buf2);
    }
    if ((s = langtexts[language][STRFTIME_DAYS_LONG]) != NULL) {
	for (i = 0; i < tm->tm_wday; i++)
	    s += strcspn(s, "\n")+1;
	i = strcspn(s, "\n");
	strncpy(buf2, s, i);
	buf2[i] = 0;
	strnrepl(tmpbuf, sizeof(tmpbuf), "%A", buf2);
    }
    if ((s = langtexts[language][STRFTIME_MONTHS_SHORT]) != NULL) {
	for (i = 0; i < tm->tm_mon; i++)
	    s += strcspn(s, "\n")+1;
	i = strcspn(s, "\n");
	strncpy(buf2, s, i);
	buf2[i] = 0;
	strnrepl(tmpbuf, sizeof(tmpbuf), "%b", buf2);
    }
    if ((s = langtexts[language][STRFTIME_MONTHS_LONG]) != NULL) {
	for (i = 0; i < tm->tm_mon; i++)
	    s += strcspn(s, "\n")+1;
	i = strcspn(s, "\n");
	strncpy(buf2, s, i);
	buf2[i] = 0;
	strnrepl(tmpbuf, sizeof(tmpbuf), "%B", buf2);
    }
    ret = strftime(buf, size, tmpbuf, tm);
    if (ret == size)
	buf[size-1] = 0;
    return ret;
}

/*************************************************************************/
/*************************************************************************/

/* Send a syntax-error message to the user. */

void syntax_error(const char *service, User *u, const char *command, int msgnum)
{
    const char *str = getstring(u, msgnum);
    notice_lang(service, u, SYNTAX_ERROR, str);
    notice_lang(service, u, MORE_INFO, service, command);
}

/*************************************************************************/
char* getstring(User *u,int index)
{
    return langtexts[((u)?u->language:DefLanguage)][(index)];
}

/*************************************************************************/
char* getstringnick(NickInfo *ni,int index)
{
    return langtexts[((ni)?ni->language:DefLanguage)][(index)];
}


char* igetstring(int i,int index)
{
    return langtexts[i][index];
}


/****************************************************
  Returns the language number defined for the domain
 ****************************************************/
int domain_language(char *domain) 
{
    int i=0;
    if(!DomainLangFN) return DefLanguage;    
    if(domain[0]>'0' && domain[0]<'9') /* numeric hostname (unresolved) */
	return domslist[0].language;   /* will use default language */
    while(++i<numdom+1) {
	if(strcmp(domain,domslist[i].domain)==0) 
	    return domslist[i].language;
    }
    return domslist[0].language;
}

void send_auth_email(NickInfo *ni, char *pass)
{
  char buf[2048];
  FILE *p;
  char sendmail[PATH_MAX];

#ifdef SENDMAIL
  sprintf(buf, authemail[ni->language],
  	ni->nick, pass , ni->auth, ni->last_usermask);
  
  snprintf(sendmail, sizeof(sendmail), "%s %s", 
    SENDMAIL,  ni->email_request);
#else
  return ;    
#endif

  if (!(p = popen(sendmail, "w"))) 
    {
      log2c(s_NickServ,"ERROR, could not popen on send_mail_auth()");
      return;
    }

  fprintf(p, "From: \"%s\" <%s>\n", SendFromName, SendFrom);
  fprintf(p, "To: \"%s\" <%s>\n", ni->nick, ni->email_request);
  
  fprintf(p, "Subject: %s\n", getstringnick(ni,AUTH_EMAIL_SUBJECT));
  fprintf(p, "\n");
  fprintf(p, "%s", buf);
  
  pclose(p);

}

void send_setemail(NickInfo *ni)
{
  char buf[2048];
  FILE *p;
  char sendmail[PATH_MAX];

#ifdef SENDMAIL
  sprintf(buf, setemail[ni->language],
  	ni->nick, ni->auth, ni->last_usermask);
  
  snprintf(sendmail, sizeof(sendmail), "%s %s", 
    SENDMAIL,  ni->email_request);
#else
  return;
#endif
  
  if (!(p = popen(sendmail, "w"))) 
    {
      log2c(s_NickServ,"ERROR, could not popen on send_setemail()");
      return;
    }

  fprintf(p, "From: \"%s\" <%s>\n", SendFromName, SendFrom);
  fprintf(p, "To: \"%s\" <%s>\n", ni->nick, ni->email_request);  
  fprintf(p, "Subject: %s\n", getstringnick(ni,SET_EMAIL_SUBJECT));
  fprintf(p, "\n");
  fprintf(p, "%s", buf);
  
  pclose(p);

}
