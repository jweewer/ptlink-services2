/************************************************************************
 *   IRC - Internet Relay Chat, include/hash.h
 *   Copyright (C) 1991 Darren Reed
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 1, or (at your option)
 *   any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 *   $Id: hash.h,v 1.2 2004/12/06 22:20:28 jpinto Exp $
 */
#ifndef INCLUDED_hash_h
#define INCLUDED_hash_h
#include "stdinc.h"
#include "services.h"
#include "irc_string.h"
/* 
 * Client hash table size
 *
 */
#define U_MAX 65536

/* 
 * Channel hash table size
 *
 * used in hash.c
 */
#define CH_MAX 16384

struct HashEntry {
  int    hits;
  int    links;
  void*  list;
};


extern struct HashEntry hash_get_channel_block(int i);
extern size_t hash_get_user_table_size(void);
extern size_t hash_get_channel_table_size(void);
extern void   init_hash(void);
extern void   add_to_user_hash_table(const char* name, 
                                        IRC_User* use);
extern void   del_from_user_hash_table(const char* name, 
                                         IRC_User* user);
extern void   add_to_channel_hash_table(const char* name, 
                                        IRC_Chan* chan);
extern void   del_from_channel_hash_table(const char* name, 
                                          IRC_Chan* chan);
extern void add_to_snid_hash_table(u_int32_t snid, 
					  NickInfo* ni);
extern void del_from_snid_hash_table(u_int32_t snid, 
					  NickInfo* ni);
extern IRC_Chan* hash_find_channel(const char* name);
extern IRC_Chan *hash_next_channel(int reset);
extern IRC_User* hash_find_user(const char* name);
extern NickInfo* hash_find_snid(u_int32_t);
extern IRC_User *hash_next_user(int reset);
extern unsigned int hash_nick_name(const char* name);
extern unsigned int hash_channel_name(const char* name);

extern void  clear_user_hash_table();
#endif  /* INCLUDED_hash_h */
