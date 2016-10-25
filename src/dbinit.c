/*****************************************************************
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2003 *
 *                http://software.pt-link.net                     *
 * This program is distributed under GNU Public License          *
 * Please read the file COPYING for copyright information.       *
 *****************************************************************
                                                                                
  File: dbinit.c
  Desc: db init/update routines
                                                                                
 *  $Id: dbinit.c,v 1.9 2004/11/21 12:10:21 jpinto Exp $
*/
#include "sysconf.h"
#include "services.h"
#include "stdinc.h"
#include "path.h"
#include "extern.h"

#ifdef HAVE_MYSQL
void mysql_from_file(MYSQL connection, char *fn);
extern void dbinit(void);

void dbinit(void)
{
  MYSQL my_connection;
  char dbhost[128];
  char dbuser[128];
  char dbpass[128];
  char sql[1024];
  int opt;
  int res;
  
  if (!MySQLDB || !MySQLUser || !MySQLHost || !MySQLPass)
    {
      fprintf(stderr, "First you must define MySQLDB, MySQLUser, MySQLHost, MySQLPass on services.dconf !\n");
      return;
    }    
  mysql_init(&my_connection);
  
  do
    {
      printf("Database initialization request\n\n");  
      printf("1 - Create db/user/tables (needs mysql admin)\n");
      printf("2 - Create tables (db/user already exists)\n");  
      printf("3 - Exit\n");
      printf("\n\nEnter Option: ");
      scanf("%i", &opt);
    } while(opt<0 || opt>3);
    
    if(opt == 3)
      return;
      
    if(opt == 1)
      {
        getchar(); /* strip end of line from options */
        printf("MySQL host [localhost]: ");
	fgets(dbhost, sizeof(dbhost), stdin);
	strip_rn(dbhost);
        if(dbhost[0] == '\0')
          strcpy(dbhost,"localhost");
        printf("MySQL admin user [root]: ");
	fgets(dbuser, sizeof(dbuser), stdin);
	strip_rn(dbuser);
        if(dbuser[0] == '\0')
          strcpy(dbuser,"root");
        printf("MySQL admin pass []: "); fflush(stdout);
	get_pass(dbpass, sizeof(dbpass));
	strip_rn(dbpass);
	printf("\n");
        printf("MySQL connect to %s as %s\n", dbhost, dbuser);
        if (!mysql_real_connect(&my_connection, dbhost,
                      dbuser, dbpass, "mysql", 0, NULL, 0))
        {
          fprintf(stderr,"Could not connect: %s\n",
          	mysql_error(&my_connection));
          return ;
        }
        printf("Creating database %s\n", MySQLDB);
        snprintf(sql, sizeof(sql), "CREATE DATABASE %s", MySQLDB);
        res = mysql_query(&my_connection, sql);
        if(res<0)
          {
            fprintf(stderr,"MySQL Error: %s\n", mysql_error(&my_connection));
            fprintf(stderr,"SQL was: %s\n", sql);
          }        
        printf("Granting privileges to %s@%s\n", MySQLUser, MySQLHost);
        snprintf(sql, sizeof(sql), "GRANT ALL ON %s.* TO %s@%s IDENTIFIED BY '%s'",
          MySQLDB, MySQLUser, MySQLHost, MySQLPass);
        res = mysql_query(&my_connection, sql);
        if(res<0)
          {
            fprintf(stderr,"MySQL Error: %s\n", mysql_error(&my_connection));
            fprintf(stderr,"SQL was: %s\n", sql);
          }                
        mysql_close(&my_connection);
      }

  printf("MySQL connect to %s as %s, database %s\n", 
    MySQLHost, MySQLUser, MySQLDB);      
  if (!mysql_real_connect(&my_connection, MySQLHost,
    MySQLUser, MySQLPass, MySQLDB, 0, NULL, 0))
    {
      fprintf(stderr,"Could not connect: %s\n",
        mysql_error(&my_connection));
        return ;
    }
  
  printf("Executing %s", ETCPATH "/create_tables.sql\n");  
  mysql_from_file(my_connection, ETCPATH "/create_tables.sql");
  mysql_close(&my_connection);
  printf("Tables creation completed\n");
}

void mysql_from_file(MYSQL connection, char *fn)
{
  FILE *f;
  char buf[32000];
  char *sql;
  int res;  
  f = fopen(fn,"rt");

  
  if(f == NULL)
    {
      fprintf(stderr, "Could not open %s \n", fn); 
      exit(2);
      return ;
    }
  fread(buf, sizeof(buf), 1, f);
  sql = strtok(buf,";");
  while(sql && strlen(sql)>10)
    {    
      res = mysql_query(&connection, sql);
      if(res<0)
        {
          fprintf(stderr,"MySQL Error: %s\n", mysql_error(&connection));
          fprintf(stderr,"SQL was: %s\n", sql);
        }
      sql = strtok(NULL, ";");            
    }
  fclose(f);
}
#endif /* MYSQL */
