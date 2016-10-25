/* NickServ save function
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2002
 * http://www.ptlink.net/Coders/ - coders@PTlink.net
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services
*/

#include "my_sql.h"

/*************************************************************************/
#ifdef NOT_MAIN
#define SAFE(x) do {						\
    if ((x) < 0) {						\
	restore_db(f);						\
	if (time(NULL) - lastwarn > WarningTimeout) {		\
	    printf("Write error on %s: %s\n", NickDBName,	\
			strerror(errno));			\
	    lastwarn = time(NULL);				\
	}							\
	return;							\
    }								\
} while (0)
#else
#define SAFE(x) do {						\
    if ((x) < 0) {						\
	restore_db(f);						\
	log_perror("Write error on %s", NickDBName);		\
	if (time(NULL) - lastwarn > WarningTimeout) {		\
	    wallops(NULL, "Write error on %s: %s", NickDBName,	\
			strerror(errno));			\
	    lastwarn = time(NULL);				\
	}							\
	return;							\
    }								\
} while (0)
#endif
void save_ns_dbase(void)
{
    dbFILE *f;
    int i, j;
    NickInfo *ni;
    char **autojoin;
    Memo *memos;
    static time_t lastwarn = 0;
#if HAVE_MYSQL	
if(MySQLDB)
  {
    if (db_mysql_open()==0) 
	  {
            log2c("MySQL: Connection failed\n");
	  } 
	else 
	  {	  	  		
            log2c("MySQL: Saving nicks data on %s", MySQLDB);
            clear_mysql_db();
  	    for (i = 0; i < N_MAX; i++)
  	      for (ni = nicklists[i]; ni; ni = ni->next) 
                {
	          db_mysql_insert_nr(ni);
	          memos = ni->memos.memos;
	          for (j = 0; j < ni->memos.memocount; j++, memos++)
	            {
	              int res;
	              char sqlstr[1024];
	              u_int32_t sender_snid = 0;
	              char sender_name[64];
	              NickInfo* sender_ni;
	              strcpy(sender_name, memos->sender);
	              irc_lower_nick(sender_name);
	              if(sender_ni = findnick(sender_name))
	                sender_snid = sender_ni->snid;	                
                      sprintf(sqlstr, "INSERT INTO memoserv VALUES(0,"
                        "%d, %d, %s, %d, FROM_UNIXTIME(%d), %s)", 
                        ni->snid, sender_snid, sql_str(sender_name), memos->flags, (unsigned) memos->time, sql_str(memos->text));
                      res = db_mysql_query(sqlstr);
               	      if(res)
               	        {
               	          printf("Error on: %s\n", sqlstr);
               	          printf("%s\n", sql_error());
               	          log2c("error inserting memo");
               	          break;
                        }                      
                    }
	        }
	    db_mysql_close();
	  }		  
  }  
#endif
    if (!(f = open_db(s_NickServ, NickDBName, "w")))
	return;
    SAFE(write_int16(DFV_NICKSERV, f));
    SAFE(write_int32(DayStats.ns_total, f));
    for (i = 0; i < N_MAX; i++) {
	for (ni = nicklists[i]; ni; ni = ni->next) {
	    SAFE(write_int32(ni->snid, f));	    
	    SAFE(write_buffer(ni->nick, f));
	    SAFE(write_buffer(ni->pass, f));
	    SAFE(write_buffer(ni->auth, f));	    
	    SAFE(write_string(ni->url, f));
	    SAFE(write_string(ni->email_request, f));	    
	    SAFE(write_string(ni->email, f));	    
	    SAFE(write_string(ni->icq_number, f));
	    SAFE(write_string(ni->location, f));
	    SAFE(write_string(ni->last_usermask, f));
	    SAFE(write_string(ni->last_realname, f));
	    SAFE(write_string(ni->last_quit, f));
	    SAFE(write_int32(ni->time_registered, f));
	    SAFE(write_int32(ni->last_identify, f));
	    SAFE(write_int32(ni->last_seen, f));
	    SAFE(write_int32(ni->last_email_request, f));	    
	    SAFE(write_int32(ni->birth_date, f));
	    SAFE(write_int16(ni->status, f));
	    SAFE(write_int16(ni->crypt_method, f));	    	    	    
	    SAFE(write_int32(ni->news_mask, f));
	    SAFE(write_int16(ni->news_status, f));	    
	    if (ni->link) {	    
		SAFE(write_string(ni->link->nick, f));
		SAFE(write_int16(ni->linkcount, f));
		SAFE(write_int16(ni->channelcount, f));
	    } else {
		SAFE(write_string(NULL, f));
		SAFE(write_int16(ni->linkcount, f));
		SAFE(write_int32(ni->flags, f));
		SAFE(write_int32(ni->online, f));	    		
		if (ni->flags & (NI_SUSPENDED|NI_OSUSPENDED))
		    SAFE(write_int32(ni->suspension_expire, f));
		SAFE(write_int16(ni->ajoincount, f));
		for (j=0, autojoin=ni->autojoin; j<ni->ajoincount; j++, autojoin++)		    
		    SAFE(write_string(*autojoin, f));    
		SAFE(write_int16(ni->memos.memocount, f));
		SAFE(write_int16(ni->memos.memomax, f));
		memos = ni->memos.memos;
		for (j = 0; j < ni->memos.memocount; j++, memos++) {
		    SAFE(write_int32(memos->number, f));
		    SAFE(write_int16(memos->flags, f));
		    SAFE(write_int32(memos->time, f));
		    SAFE(write_buffer(memos->sender, f));
		    SAFE(write_string(memos->text, f));
		}
		SAFE(write_int16(ni->notes.count, f));
		SAFE(write_int16(ni->notes.max, f));		
		for (j = 0; j < ni->notes.count; j++) {
		    SAFE(write_string(ni->notes.note[j], f));
		}
		SAFE(write_int16(ni->channelcount, f));
		SAFE(write_int16(ni->channelmax, f));
		SAFE(write_int16(ni->language, f));
	    }
	} /* for (ni) */
    } /* for (i) */
    close_db(f);
}

#undef SAFE
