/* ChanServ save function
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2002
 * http://www.ptlink.net/Coders/ - coders@PTlink.net
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services
*/

/*************************************************************************/

/*************************************************************************/

#ifdef NOT_MAIN
#define SAFE(x) do {						\
    if ((x) < 0) {						\
	restore_db(f);						\
	if (time(NULL) - lastwarn > WarningTimeout) {		\
	    printf("Write error on %s: %s\n", ChanDBName,	\
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
	log_perror("Write error on %s", ChanDBName);		\
	if (time(NULL) - lastwarn > WarningTimeout) {		\
	    wallops(NULL, "Write error on %s: %s", ChanDBName,	\
			strerror(errno));			\
	    lastwarn = time(NULL);				\
	}							\
	return;							\
    }								\
} while (0)
#endif
void save_cs_dbase(void)
{
#if HAVE_MYSQL
	MYSQL my_connection;  
	int res;
	char sqlstr[1024];
#endif
    dbFILE *f;
    int i, j;
    ChannelInfo *ci;
    Memo *memos;
    static time_t lastwarn = 0;
#if HAVE_MYSQL	
if(MySQLDB)
  {
	mysql_init(&my_connection);	    
    if (!mysql_real_connect(&my_connection, MySQLHost,
      	  MySQLUser, MySQLPass, MySQLDB, 0, NULL, 0)) 
	  {
        log2c("MySQL: Connection failed\n");
        if (mysql_errno(&my_connection)) 
		  {
    		log1("MySQL: Connection error %d: %s\n",
    		mysql_errno(&my_connection), mysql_error(&my_connection));
    	  }	  
	  } 
	else 
	  {
    	    log2c("MySQL: Saving channels data on %s", MySQLDB);
	    mysql_query(&my_connection, "DELETE FROM chanserv");
	    mysql_query(&my_connection, "DELETE FROM cs_role_temp");
/*	    
        mysql_query(&my_connection, "DELETE FROM chans_accesses");
        mysql_query(&my_connection, "DELETE FROM chans_akicks");
*/        
        for (i = 0; i < C_MAX; i++) 
        for (ci = chanlists[i]; ci; ci = ci->next) 
          {
            char tmpname[65+3];
      	    char tmppass[64+3];
	    char tmpurl[64+3];
	    char tmpemail[64+3];
            char tmptopic[355];
            char tmptsetter[32+3];
            char entrymsg[255];
            char tmpdesc[255];
            u_int32_t flags;
            
            
            if((ci->url!=NULL) && strlen(ci->url)>60)
              ci->url[60]='\0';
            if((ci->email!=NULL) && strlen(ci->email)>60)
              ci->email[60]='\0';
            if((ci->last_topic!=NULL) && strlen(ci->last_topic)>300)
              ci->last_topic[300]='\0';

            if((ci->entry_message!=NULL) && strlen(ci->entry_message)>200)
              ci->entry_message[200]='\0';

            if((ci->desc!=NULL) && strlen(ci->desc)>200)
              ci->desc[200]='\0';              
            set_sql_string(tmpdesc, ci->desc);
            irc_lower(tmpname);
            set_sql_string(tmpname, ci->name);
            if(ci->crypt_method==3)
              set_sql_string(tmppass, hex_str(ci->founderpass,16));            	
            else
              set_sql_string(tmppass, ci->founderpass);
            set_sql_string(tmpurl, ci->url);
			set_sql_string(tmpemail, ci->email);
            set_sql_string(tmptopic, ci->last_topic);
            set_sql_string(tmptsetter, ci->last_topic_setter);
            set_sql_string(entrymsg, ci->entry_message);
            
            /* This will convert to svs3 flags*/
            flags = 0;
            if (ci->flags & CI_VERBOTEN)
              flags |= CFL_FORBIDDEN;
            if(ci->flags & CI_NO_EXPIRE)
              flags |= CFL_NOEXPIRE;                            
            if(ci->flags & CI_PRIVATE)
              flags |= CFL_PRIVATE;
            if(ci->flags & CI_OPNOTICE)
              flags |= CFL_OPNOTICE;
            if(ci->last_topic_time == 0)
              ci->last_topic_time = time(NULL);
            if(ci->time_registered == 0)
              ci->time_registered  = time(NULL);
            if(ci->last_used == 0)
              ci->last_used = time(NULL);
            if(ci->maxtime == 0)
              ci->maxtime = time(NULL);
            
  	    sprintf(sqlstr,"INSERT INTO chanserv VALUES"
                /* name url em fou succ lto lts tlto treg, ml*/
               "(%i,%s, %s, %s, %i, %i, %s, %s, FROM_UNIXTIME(%lu), FROM_UNIXTIME(%lu),  FROM_UNIXTIME(%lu),%s, 0,"
               "%i, %s, %s, FROM_UNIXTIME(%lu) , %i)",
                ci->scid, tmpname, tmpurl, tmpemail, 
                (ci->founder) ? ci->founder->snid : 0, 
                (ci->successor) ? ci->successor->snid : 0,
                tmptopic, tmptsetter,
                (unsigned long)ci->last_topic_time,
                (unsigned long)ci->time_registered,
                (unsigned long)ci->last_used, 
                "'+nt'",
                (unsigned long)flags,
                entrymsg, 
                tmpdesc,
                (unsigned long)ci->maxtime, 
                ci->maxusers); 

			res = mysql_query(&my_connection, sqlstr);
			if(res)
			  {	
                            log2c("sqlstr: %s", sqlstr);
			    log2c("Insert error %d: %s\n", mysql_errno(&my_connection),
            	              mysql_error(&my_connection));
                            break;
			  }
	        for (j = 0; j < ci->accesscount; j++) 
              {
              	if (ci->access[j].in_use && ci->access[j].ni->snid!= ci->founder->snid) 
                  {
                    int rtype = 0;
                    if((ci->levels[CA_PROTECT] != ACCESS_INVALID) && ci->access[j].level >= ci->levels[CA_PROTECT])
                      rtype = 1;
                    else
                    if((ci->levels[CA_AUTOOP] != ACCESS_INVALID) && ci->access[j].level >= ci->levels[CA_AUTOOP])
                      rtype = 2;
                    else if((ci->levels[CA_AUTOVOICE] != ACCESS_INVALID) && ci->access[j].level >= ci->levels[CA_AUTOVOICE])
                      rtype = 3;
                    if(rtype)
                    {
                    sprintf(sqlstr,"INSERT INTO cs_role_temp VALUES"
                    /* cid who nid level */
                    "(%d, %d, %d, %d)",                    
                    ci->scid, 
                    ci->access[j].ni->snid,                     
                    (ci->access[j].who) ? ci->access[j].who->snid : ci->founder->snid,
                    rtype);
			        res = mysql_query(&my_connection, sqlstr);
			        if(res)
			          {	
                        log2c("sqlstr: %s", sqlstr);
				        log2c("Insert error %d: %s\n", mysql_errno(&my_connection),
            	        mysql_error(&my_connection));
                        break;
                    }
			          }                    
                  }
              }
	        for (j = 0; j < ci->akickcount; j++) 
              {
              	if (ci->akick[j].in_use) 
                  {
                    char tmpmask[64];
                    char tmpreason[255];
                    set_sql_string(tmpmask, ci->akick[j].mask);
                    set_sql_string(tmpreason, ci->akick[j].reason);
                    sprintf(sqlstr,"INSERT INTO chans_akicks VALUES"
                  /* cid who  t_kick               mask reason */
                    "(%i, %i, FROM_UNIXTIME(%lu)+0, %s, %s)",
		              ci->scid, 
                      (ci->akick[j].who) ? ci->akick[j].who->snid : ci->founder->snid ,
                      (unsigned long) ci->akick[j].last_kick,
                      tmpmask, tmpreason);
			        res = mysql_query(&my_connection, sqlstr);
			        if(res)
			          {	
                        log2c("sqlstr: %s", sqlstr);
				        log2c("Insert error %d: %s\n", mysql_errno(&my_connection),
            	        mysql_error(&my_connection));
                        break;
			          }                    
                  }
              }
          }
        mysql_close(&my_connection);	                
      }
    }
#else
#ifndef NOT_MAIN
  if(MySQLDB)    
    log1("MySQLDB defined but services compiled without MySQL support!");
#endif    
#endif /* HAVE_MYSQL */
    if (!(f = open_db(s_ChanServ, ChanDBName, "w")))
	return;
    write_int16(DFV_CHANSERV, f);
    SAFE(write_int32(DayStats.cs_total, f));
    for (i = 0; i < C_MAX; i++) {
	int16 tmp16;

	for (ci = chanlists[i]; ci; ci = ci->next) {	    
	    SAFE(write_int8(1, f));
            SAFE(write_int32(ci->scid, f));
	    SAFE(write_buffer(ci->name, f));
	    if (ci->founder)
		SAFE(write_string(ci->founder->nick, f));
	    else
		SAFE(write_string(NULL, f));
	    if (ci->successor)
		SAFE(write_string(ci->successor->nick, f));
	    else
		SAFE(write_string(NULL, f));
	    tmp16 = ci->maxusers;
	    SAFE(write_int16(tmp16, f));
	    SAFE(write_int32(ci->maxtime, f));	   
	    SAFE(write_buffer(ci->founderpass, f));
	    SAFE(write_string(ci->desc, f));
	    SAFE(write_string(ci->url, f));
	    SAFE(write_string(ci->email, f));
	    SAFE(write_int32(ci->time_registered, f));
	    SAFE(write_int32(ci->last_used, f));
	    SAFE(write_string(ci->last_topic, f));
	    SAFE(write_buffer(ci->last_topic_setter, f));
	    SAFE(write_int32(ci->last_topic_time, f));
	    SAFE(write_int32(ci->flags, f));
	    tmp16 = ci->crypt_method;
	    SAFE(write_int16(tmp16, f));
	    if (ci->flags & CI_DROPPED)    {
		SAFE(write_int32(ci->drop_time, f));	    
	    }
	    tmp16 = CA_SIZE;
	    SAFE(write_int16(tmp16, f));
	    for (j = 0; j < CA_SIZE; j++)
		SAFE(write_int16(ci->levels[j], f));

	    SAFE(write_int16(ci->accesscount, f));
	    for (j = 0; j < ci->accesscount; j++) {
		SAFE(write_int16(ci->access[j].in_use, f));
		if (ci->access[j].in_use) {
		    SAFE(write_int16(ci->access[j].level, f));
		    SAFE(write_string(ci->access[j].ni->nick, f));
		    if(ci->access[j].who) 
			SAFE(write_string(ci->access[j].who->nick, f)); 
		    else
			SAFE(write_string("*", f));
		}		
	    }

	    SAFE(write_int16(ci->akickcount, f));
	    for (j = 0; j < ci->akickcount; j++) {
		SAFE(write_int16(ci->akick[j].in_use, f));
		if (ci->akick[j].in_use) {
		    SAFE(write_string(ci->akick[j].mask, f));
		    SAFE(write_string(ci->akick[j].reason, f));
		    if(ci->akick[j].who) 
			SAFE(write_string(ci->akick[j].who->nick, f));
		    else
			SAFE(write_string("*", f));
		    SAFE(write_int32(ci->akick[j].last_kick, f));
		}
	    }

	    SAFE(write_int32(ci->mlock_on, f));
	    SAFE(write_int32(ci->mlock_off, f));
	    SAFE(write_int32(ci->mlock_limit, f));
	    SAFE(write_string(ci->mlock_key, f));

	    SAFE(write_int16(ci->memos.memocount, f));
	    SAFE(write_int16(ci->memos.memomax, f));
	    memos = ci->memos.memos;
	    for (j = 0; j < ci->memos.memocount; j++, memos++) {
		SAFE(write_int32(memos->number, f));
		SAFE(write_int16(memos->flags, f));
		SAFE(write_int32(memos->time, f));
		SAFE(write_buffer(memos->sender, f));
		SAFE(write_string(memos->text, f));
	    }

	    SAFE(write_string(ci->entry_message, f));

	} /* for (chanlists[i]) */

	SAFE(write_int8(0, f));

    } /* for (i) */

    close_db(f);
}

#undef SAFE

