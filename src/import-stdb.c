/* import-stdb	- Imports database from other services
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2002
 * http://www.ptlink.net/Coders/ - coders@PTlink.net
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 */

#include "services.h"
#include "datafiles.h"
#include "newsserv.h"
#include "extern.h"
#include "path.h"
#define NickDBName "nick.db"
#define ChanDBName "chan.db"
#define DFV_NICKSERV 10	/* NickServ datafile version */
#define DFV_CHANSERV 9	/* ChanServ datafile version */

#define NOT_MAIN
static NickInfo *nicklists[256];	/* One for each initial character */
static ChannelInfo *chanlists[256];
char *services_dir = DATAPATH;

/* Insert a nick alphabetically into the database. */

static void alpha_insert_nick(NickInfo *ni)
{
    NickInfo *ptr, *prev;
    char *nick = ni->nick;

    for (prev = NULL, ptr = nicklists[tolower(*nick)];
			ptr && stricmp(ptr->nick, nick) < 0;
			prev = ptr, ptr = ptr->next)
	;
    ni->prev = prev;
    ni->next = ptr;
    if (!prev)
	nicklists[tolower(*nick)] = ni;
    else
	prev->next = ni;
    if (ptr)
	ptr->prev = ni;
}

#include "ns_save.c"

void load_nicks(FILE *f) {
    NickInfo *ni;
    char *tmp;
    char line[512];    
    int count=0;
    fgets(line,sizeof(line),f); /* read header */
    while (!feof(f)) {
	line[0]='\0';
	fgets(line,sizeof(line),f);
	if(strlen(line)<3)
	    break;
	ni = malloc(sizeof(NickInfo));
	ni->forcednicks = 0;
	DayStats.ns_total++;
	tmp = strtok(line," ");
	strcpy(ni->nick, tmp);
	tmp = strtok(NULL," ");
	if(EncryptMethod==3)
	 hex_bin(ni->pass, tmp);
	else
	 strcpy(ni->pass, tmp);
	ni->crypt_method = EncryptMethod;
	ni->url = ni->email = ni->icq_number = ni->location = NULL;
	ni->last_usermask = ni->last_quit = NULL;
	ni->last_realname = strdup("unknow on .db import");
	ni->online = 0;
	tmp = strtok(NULL," ");
	ni->time_registered = atol(tmp);
	tmp = strtok(NULL,"");
	ni->last_identify = atol(tmp);
	if(stricmp(ni->pass,"*"))
	    ni->status = 0;	    
	else
	    ni->status = NS_VERBOTEN;	   
	tmp = strtok(NULL," ");
	if(tmp)
	  ni->email = strdup(tmp);	 
	ni->last_seen = ni->last_identify;
	ni->news_mask = NM_ALL;
	ni->news_status = NW_WELCOME;
	ni->link = NULL;
	ni->linkcount = 0;
	ni->ajoincount = 0;
	ni->autojoin = NULL;		    
	ni->memos.memocount = 0;
	ni->memos.memomax = MSMaxMemos;
	ni->memos.memos = NULL;
	ni->channelmax = CSMaxReg;
	ni->language = DefLanguage;	
        ni->notes.max = NSMaxNotes;
        ni->notes.count = 0;
        ni->notes.note = malloc(ni->notes.max * sizeof(char*));  		    	
	ni->channelcount = 0;
        ni->flags |= NI_KILLPROTECT;
        if (NSDefKillQuick)
          ni->flags |= NI_KILL_QUICK;
        if (NSDefPrivate)
          ni->flags |= NI_PRIVATE;
        if (NSDefHideEmail)
          ni->flags |= NI_HIDE_EMAIL;
        if (NSDefHideQuit)
          ni->flags |= NI_HIDE_QUIT;
        if (NSDefMemoSignon)
          ni->flags |= NI_MEMO_SIGNON;
        if (NSDefMemoReceive)
          ni->flags |= NI_MEMO_RECEIVE;	
	++count;
	alpha_insert_nick(ni); /* add nick to list */
    }
    printf("%i Done.\n",count);
}

NickInfo *findnick(const char *nick)
{
    NickInfo *ni;

    for (ni = nicklists[tolower(*nick)]; ni; ni = ni->next) {
	if (stricmp(ni->nick, nick) == 0)
	    return ni;
    }
    return NULL;
}

/*************************************************************************/

#include "cs_save.c"

static int def_levels[][2] = {
    { CA_AUTOOP,             5 },
    { CA_AUTOVOICE,          3 },
    { CA_AUTODEOP,          -1 },
    { CA_NOJOIN,            -1 },
    { CA_INVITE,             5 },
    { CA_AKICK,             10 },
    { CA_SET,   ACCESS_INVALID },
    { CA_CLEAR, ACCESS_INVALID },
    { CA_UNBAN,              5 },
    { CA_OPDEOP,             5 },
    { CA_ACCESS_LIST,        0 },
    { CA_ACCESS_CHANGE,      1 },
    { CA_MEMOREAD,           5 },
    { CA_PROTECT, ACCESS_INVALID },
    { CA_KICK,		    10 },            
    { CA_MEMOSEND,	    10 },
    { CA_MEMODEL,	    10 },        
    { -1 }
};

/* Insert a channel alphabetically into the database. */

static void alpha_insert_chan(ChannelInfo *ci)
{
    ChannelInfo *ptr, *prev;
    char *chan = ci->name;

    for (prev = NULL, ptr = chanlists[tolower(chan[1])];
			ptr != NULL && stricmp(ptr->name, chan) < 0;
			prev = ptr, ptr = ptr->next)
	;
    ci->prev = prev;
    ci->next = ptr;
    if (!prev)
	chanlists[tolower(chan[1])] = ci;
    else
	prev->next = ci;
    if (ptr)
	ptr->prev = ci;
}

static void reset_levels(ChannelInfo *ci)
{
    int i;

    if (ci->levels)
	free(ci->levels);
    ci->levels = malloc(CA_SIZE * sizeof(*ci->levels));
    for (i = 0; def_levels[i][0] >= 0; i++)
	ci->levels[def_levels[i][0]] = def_levels[i][1];
}

void load_chans(FILE *f) {
    ChannelInfo* ci;
    NickInfo* ni;
    char line[512];    
    int count=0;
    int newflags=0;
    int delchan;
    char *founder, *name, *founderpass, *ch;
    fgets(line,sizeof(line),f); /* read header */
    while (!feof(f)) {
	line[0]='\0';
	fgets(line,sizeof(line),f);
	while((ch=strchr(line,'\n'))) 
	    *ch='\0';
	name = strtok(line," ");
	if (!name) {
	    break;
	}
	founder = strtok(NULL," ");
	delchan=0;
	ci = malloc(sizeof(ChannelInfo));
	if(founder[0]=='*') {
	    newflags = CI_VERBOTEN;
	    ci->founder=NULL;
	} else {
	    ni = findnick(founder);
	    if(!ni) {
		printf("Deleting founderless channel %s, founder was %s\n",name,founder);
		delchan=1;
	    } else {
		if (ni->channelcount+1 > ni->channelcount)  /* Avoid wraparound */
		    ni->channelcount++;
	    }
	    ci->founder=ni;
	    newflags = 0;
	}
	ci->successor=NULL;
	strcpy(ci->name,name);				
	ci->flags = newflags;
	founderpass = strtok(NULL," ");
	ci->time_registered = atol(strtok(NULL," "));
	ci->last_used = atol(strtok(NULL," "));
        if(EncryptMethod==3)
          hex_bin(ci->founderpass, founderpass);
        else
	  strcpy(ci->founderpass, founderpass);
	ci->crypt_method = EncryptMethod;
	ci->levels = NULL;
	reset_levels(ci);
	ci->email = ci-> url = ci->last_topic = ci->entry_message = NULL;
	ci->maxusers = 0;
	ci->maxtime = time(NULL);
	ci->desc = strdup("please use /chanserv set #chan desc description");
	strcpy(ci->last_topic_setter,"");
	ci->last_topic_time = time(NULL);
	ci->crypt_method = 0;
	ci->flags = CI_KEEPTOPIC;
	ci->mlock_on = CMODE_n | CMODE_T;	               
	fgets(line,sizeof(line),f); /* read ACCESS tag */
	while((ch=strchr(line,'\n'))) 
	    *ch='\0';
	if(!stricmp(line,"ACCESS")) {
	    char ac_nick[1024][NICKMAX];
	    int	ac_level[1024];
	    int aci = 0;	    
	    do {
		line[0]='\0';
		fgets(line,sizeof(line),f); /* read nick level pair */
		while((ch=strchr(line,'\n'))) 
		    *ch='\0';		
		if(line[0] == '-') /* end of list */
		    break;
		strcpy(ac_nick[aci],strtok(line," ")); 
		ac_level[aci] = atoi(strtok(NULL,""));
		++aci;	/* next access*/
	    } while(line[0] != '-'); 
	    ci->accesscount = aci;
	    ci->access = aci ? malloc(ci->accesscount *sizeof(ChanAccess)): NULL;
	    
	    for (aci = 0; aci < ci->accesscount; aci++) {
		ci->access[aci].level=ac_level[aci];
		ci->access[aci].ni=findnick(ac_nick[aci]);
		ci->access[aci].in_use =  ci->access[aci].ni ? 1 : 0;
		ci->access[aci].who = NULL;
	    }
	    ++count;
	}
	ci->akickcount = 0;
	ci->akick = NULL;
	ci->mlock_on = CMODE_n | CMODE_T;
	ci->mlock_off = 0;
	ci->mlock_limit = 0;
	ci->mlock_key = 0;
	ci->memos.memocount = 0;
	ci->memos.memomax = 
	ci->memos.memomax = MSMaxMemos;
	if(!delchan)
	    alpha_insert_chan(ci);
    }
    printf("%i Done.\n",count);    
}

int main(int argc, char **argv) {
    char *datadir;
    FILE *stdb;
    char fn[255]; 
    printf("import-stdb 1.1.0 - Read .stdb data files and creates PTlink.Services .db\n");
    if(argc>1) {
	if(!strcasecmp(argv[1],"--version")) {
	    return 0;
	} else if(argv[1][0]=='-') {
	    printf("usage: import-stdb [stdb_directory]\n\n");
	    printf("	stdb_directory specifies nick.stdb and chan.stdb location\n");
	    printf("	current directory will be used as default\n");
	    return 0;
	}
    }
    /* Chdir to Services data directory. */
    if (chdir(services_dir) < 0) 
      {
        fprintf(stderr, "chdir(%s): %s\n", services_dir, strerror(errno));
        return -1;
      }                                
    if (!read_config(0))
	return 1;
    datadir = (argc>1) ? argv[1]: ".";
    sprintf(fn,"%s/nick.stdb",datadir);
    stdb=fopen(fn,"r");
    if(!stdb) {
	printf("Error: Could not open %s\n",fn);
	return 2;
    }
    printf("Reading nicknames info...\n");
    load_nicks(stdb);
    fclose(stdb);
    printf("Saving nick.db...\n");
    save_ns_dbase();
    printf("Done\n");
    sprintf(fn,"%s/chan.stdb",datadir);
    stdb=fopen(fn,"r");
    if(!stdb) {
	printf("Error: Could not open %s\n",fn);
	return 2;
    }
    printf("Reading channels info...\n");
    load_chans(stdb);
    fclose(stdb);
    printf("Saving chan.db...\n");
    save_cs_dbase();
    printf("Done\n");
    return 0;
}
#undef NOT_AMIN
