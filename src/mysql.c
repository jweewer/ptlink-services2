/* Initalization and related routines.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2005
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * $Id: mysql.c,v 1.19 2005/03/12 21:08:17 jpinto Exp $
 */
/* MySQL functions.
 *
 * (C) 2003 Anope Team
 * Contact us at info@anope.org
 *
 * Please read COPYING and CREDITS for furhter details.
 *
 * Based on the original code of Epona by Lara.
 * Based on the original code of Services by Andy Church. 
 * 
 * $Id: mysql.c,v 1.19 2005/03/12 21:08:17 jpinto Exp $ 
 *
 */
#include "sysconf.h"
#include "services.h"

#if HAVE_MYSQL
#include <errmsg.h>
#include <mysql.h>
#include "stdinc.h"
#include "my_sql.h"

/*************************************************************************/

/* Database Global Variables */
MYSQL *mysql;                   /* MySQL Handler */
MYSQL_RES *mysql_res;           /* MySQL Result  */
MYSQL_FIELD *mysql_fields;      /* MySQL Fields  */
MYSQL_ROW mysql_row;            /* MySQL Row     */

/*************************************************************************/

#define NR_INSERT_FIELDS \
      "snid, nick," \
      "t_reg, t_ident, t_seen, t_sign," \
      "pass, email, url, imid, location, ontime," \
      "username, realhost, info,  nmask,  ajoin," \
      "status, flags, securitycode, lang, master_snid"
#define NR_INSERT_PARAM \
      "%d, %s," \
      "FROM_UNIXTIME(%d), FROM_UNIXTIME(%d), FROM_UNIXTIME(%d) ,FROM_UNIXTIME(%d)," \
      "%s, %s, %s, %s, %s, %d," \
      "%s, %s, %s, %d, %s," \
      "%d, %d, %s, %d, %d)", \
      ni->snid, sql_str(ni->nick), \
      (int) ni->time_registered, (int) ni->last_identify, (int) ni->last_seen, (int)ni->last_signon, \
      sql_str(hex_str(ni->pass,16)), sql_str(ni->email), \
      sql_str(ni->url), sql_str(ni->icq_number), sql_str(ni->location), ni->online, \
      sql_str(last_username), sql_str(last_host), sql_str(ni->last_realname), ni->news_mask, \
      "NULL", \
      ni->status, flags, NULL, lang, 0


void db_mysql_error(int severity, char *msg)
{
    static char buf[512];

    if (mysql_error(mysql)) {
        snprintf(buf, sizeof(buf), "MySQL %s %s: %s", msg,
                 severity == MYSQL_WARNING ? "warning" : "error",
                 mysql_error(mysql));
    } else {
        snprintf(buf, sizeof(buf), "MySQL %s %s", msg,
                 severity == MYSQL_WARNING ? "warning" : "error");
    }

    log1(buf);

    if (severity == MYSQL_ERROR) {
        log1("MySQL FATAL error... aborting.");
        exit(0);
    }

}

const char* sql_error(void)
{
  return mysql_error(mysql);
}
/*************************************************************************/


int db_mysql_open()
{
    mysql = mysql_init(NULL);

#if 0
    if (MysqlSock) {
        if ((!mysql_real_connect
             (mysql, MySQLHost, MySQLUser, MySQLPass, MySQLDB, 0,
              MysqlSock, 0))) {
            log_perror("Cant connect to MySQL: %s\n", mysql_error(mysql));
            return 0;
        }
    } else {
#endif    
        if ((!mysql_real_connect
             (mysql, MySQLHost, MySQLUser, MySQLPass, MySQLDB, 0,
              NULL, 0))) {
            log1("Cant connect to MySQL: %s\n", mysql_error(mysql));
            return 0;
        }
        log1("MySQL connected to %s", MySQLHost);
#if 0        
    }
#endif
    return 1;

}

/*************************************************************************/

int db_mysql_query(char *sql)
{

    int result, lcv;
    result = mysql_query(mysql, sql);

    if (result) {
        switch (mysql_errno(mysql)) {
        case CR_SERVER_GONE_ERROR:
        case CR_SERVER_LOST:
            /* Reconnect -> 5 tries (need to move to config file) */
            for (lcv = 0; lcv < 5; lcv++) {
                if (db_mysql_open()) {
                    result = mysql_query(mysql, sql);
                    return (result);
                }
                sleep(1);
            }

            /* If we get here, we could not connect. */
            log1("Unable to reconnect to database: %s\n",
                       mysql_error(mysql));
            db_mysql_error(MYSQL_ERROR, "connect");

            /* Never reached. */
            break;

        default:
            /* Unhandled error. */
            return (result);
        }
    }

    return (0);

}

/*************************************************************************/

char* db_mysql_quote(char *sql)
{
    int slen;
    char *quoted;

    if (sql == NULL)
      return strdup("");

    slen = strlen(sql);
    quoted = malloc((1 + (slen * 2)) * sizeof(char));

    mysql_real_escape_string(mysql, quoted, sql, slen);
    return quoted;

}

/*************************************************************************/

/* I don't like using res here, maybe we can pass it as a param? */
int db_mysql_close()
{
    mysql_free_result(mysql_res);
    mysql_close(mysql);
    return 1;
}

int db_mysql_init()
{
  char sqlcmd[MAX_SQL_BUF]; 

  snprintf(sqlcmd, MAX_SQL_BUF,"UPDATE nicks SET status=0 WHERE status<>0");
  if (db_mysql_query(sqlcmd))
    {
      log1("Can't create sql query: %s", sqlcmd);
        db_mysql_error(MYSQL_WARNING, "query");
        return 0;
    }  
  return 1;
}

/*************************************************************************/

/*
 * NickRecord functions
 */
 
/* Insert a new nick record */
int db_mysql_insert_nr(NickInfo* ni)
{
    char *last_username = NULL, *last_host = NULL;
    char sqlcmd[MAX_SQL_BUF];
    char *tmpmask = NULL;
    u_int32_t flags;
    int lang;
    if(ni->time_registered == 0)
      ni->time_registered = time(0);
    if(ni->last_identify == 0)
      ni->last_identify = time(0);
    if(ni->last_seen == 0)
      ni->last_seen = time(0);
    if(ni->last_signon == 0)
      ni->last_signon = time(0);
    irc_lower_nick(ni->nick);
    if(ni->last_usermask)
      {
        tmpmask = strdup(ni->last_usermask);
        last_username = strtok(tmpmask, "@");
        if(last_username)
          last_host = strtok(NULL, "");
      }    
    if(last_username == NULL) /* the sql column is mandatory */
      last_username = "";
    if(last_host == NULL) /* the sql column is mandatory */
      last_host = "";
    flags = 0;

    /* set default flags */    
    flags = 0;
    if (ni->status & NS_VERBOTEN)    
      flags |= NFL_FORBIDDEN;
    if(ni->flags & NI_PRIVATE)
      flags |= NFL_PRIVATE;
    if(ni->status & NS_NO_EXPIRE)
      flags |= NFL_NOEXPIRE;
    switch(ni->language)
    {
      case 1: lang = 1; break;
      case 5: lang = 2; break;
      case 6: lang = 3; break;
      default: lang = 0; break;
    }
    snprintf(sqlcmd, MAX_SQL_BUF,
      "INSERT INTO nickserv ("
      NR_INSERT_FIELDS
      ") VALUES ("
      NR_INSERT_PARAM
      );
      
    if(tmpmask)
      free(tmpmask);
      
    if (db_mysql_query(sqlcmd)) {
        log1("Can't create sql query: %s", sqlcmd);
        db_mysql_error(MYSQL_WARNING, "query");
        return -1;
    }
    return 0;
}

void clear_mysql_db(void)
{
  db_mysql_query("DELETE FROM nickserv");
  db_mysql_query("DELETE FROM memoserv");
}

/**
   returns a sql safe string (between "'") removing "\" and "'"
   it will also remove those chars from the param string;
*/
char* sql_str(char *str)
{
  static char bufs[20][512]; /* we can keep 20 strings */
  static int stri = 0; /* current string index */
  char* cbuf; /* current buffer */
  char* c; /* position on str */
  int i;
  
  if(str==NULL)
    return "NULL";
  cbuf = bufs[stri++];
  
  if(stri>19) /* reached end of array */
    stri = 0;
  
  cbuf[0] = '\''; /* Start the string */
  i = 1;
  c = str;
  while(*c && (i<507)) /* 511 - (2 for "\" + char), 2 for string end */
    {
      /* prefix with "\" */
      if((*c == '\'') || (*c == '\\'))
        cbuf[i++] = '\\';
        
      cbuf[i++] = *(c++);              
    }  
  cbuf[i] = '\''; /* Close the string */
  cbuf[i+1] = '\0';  
  
  return cbuf;
}

#endif  /* HAVE_MYSQL */
