/*****************************************************************
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2003 *
 *                http://software.pt-link.net                     *
 * This program is distributed under GNU Public License          *
 * Please read the file COPYING for copyright information.       *
 *****************************************************************
                                                                                
  File: mysql.h
  Desc: mysql routines header file
                                                                                
 *  $Id: my_sql.h,v 1.5 2005/01/19 22:09:22 jpinto Exp $
*/
#define	MAX_SQL_BUF	1024
#define MYSQL_ERROR 1
#define MYSQL_WARNING 2

int db_mysql_open(void);
int db_mysql_insert_nr(NickInfo* nr);
int db_mysql_last_id(void);
int db_mysql_close(void);
void clear_mysql_db(void);
char* sql_str(char *str);
const char* sql_error(void);
