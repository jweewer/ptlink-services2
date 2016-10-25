/*********************************************************************
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999-2003
 * http://www.ptlink.net/Coders/ - coders@PTlink.net
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
*/
/************************************************************************
 *   IRC - Internet Relay Chat, src/hash.c
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
 *  $Id: hash.c,v 1.3 2004/12/06 22:20:33 jpinto Exp $
 */
#include "stdinc.h"
#include "irc_string.h"
#include "hash.h"

static struct HashEntry userTable[U_MAX];
static struct HashEntry snidTable[U_MAX];
static struct HashEntry channelTable[CH_MAX];

struct HashEntry hash_get_channel_block(int i)
{
  return channelTable[i];
}

size_t hash_get_channel_table_size(void)
{
  return sizeof(struct HashEntry) * CH_MAX;
}

size_t hash_get_user_table_size(void)
{
  return sizeof(struct HashEntry) * U_MAX;
}

/*
 *
 * look in whowas.c for the missing ...[WW_MAX]; entry
 *   - Dianora
 */

/*
 * Hashing.
 *
 *   The server uses a chained hash table to provide quick and efficient
 * hash table mantainence (providing the hash function works evenly over
 * the input range).  The hash table is thus not susceptible to problems
 * of filling all the buckets or the need to rehash.
 *    It is expected that the hash table would look somehting like this
 * during use:
 *                   +-----+    +-----+    +-----+   +-----+
 *                ---| 224 |----| 225 |----| 226 |---| 227 |---
 *                   +-----+    +-----+    +-----+   +-----+
 *                      |          |          |
 *                   +-----+    +-----+    +-----+
 *                   |  A  |    |  C  |    |  D  |
 *                   +-----+    +-----+    +-----+
 *                      |
 *                   +-----+
 *                   |  B  |
 *                   +-----+
 *
 * A - GOPbot, B - chang, C - hanuaway, D - *.mu.OZ.AU
 *
 * The order shown above is just one instant of the server.  Each time a
 * lookup is made on an entry in the hash table and it is found, the entry
 * is moved to the top of the chain.
 *
 *    ^^^^^^^^^^^^^^^^ **** Not anymore - Dianora
 *
 */

unsigned int hash_nick_name(const char* name)
{
  unsigned int h = 0;

  while (*name)
    {
      h = (h << 4) - (h + (unsigned char)ToLower(*name++));
    }

  return(h & (U_MAX - 1));
}

/* simple hash for snid */
u_int32_t hash_snid(u_int32_t snid)
{
  return (snid % U_MAX);
}

/*
 * hash_channel_name
 *
 * calculate a hash value on at most the first 30 characters of the channel
 * name. Most names are short than this or dissimilar in this range. There
 * is little or no point hashing on a full channel name which maybe 255 chars
 * long.
 */
unsigned int hash_channel_name(const char* name)
{
  register int i = 30;
  unsigned int h = 0;

  while (*name && --i)
    {
      h = (h << 4) - (h + (unsigned char)ToLower(*name++));
    }

  return (h & (CH_MAX - 1));
}

/*
 * clear_user_hash_table
 *
 * Nullify the hashtable and its contents so it is completely empty.
 */
void clear_user_hash_table()
{
  memset(userTable, 0, sizeof(struct HashEntry) * U_MAX);
}

void clear_snid_hash_table()
{
  memset(snidTable, 0, sizeof(struct HashEntry) * U_MAX);
}

static void clear_channel_hash_table()
{
  memset(channelTable, 0, sizeof(struct HashEntry) * CH_MAX);
}


void init_hash(void)
{
  clear_user_hash_table();
  clear_snid_hash_table();
  clear_channel_hash_table();
}

/*
 * add_to_user_hash_table
 */
void add_to_user_hash_table(const char* name, IRC_User* cptr)
{
  unsigned int hashv;

  hashv = hash_nick_name(name);
  cptr->hnext = (IRC_User*) userTable[hashv].list;
  userTable[hashv].list = (void*) cptr;
  ++userTable[hashv].links;
  ++userTable[hashv].hits;
}

/*
 * add_to_snid_hash_table
 */
void add_to_snid_hash_table(u_int32_t snid, NickInfo* ni)
{
  u_int32_t hashv;

  hashv = hash_snid(snid);
  ni->hnextsnid = snidTable[hashv].list;
  snidTable[hashv].list = ni;
  ++snidTable[hashv].links;
  ++snidTable[hashv].hits;
}

/*
 * add_to_channel_hash_table
 */
void add_to_channel_hash_table(const char* name, IRC_Chan* chptr)
{
  unsigned int hashv;

  hashv = hash_channel_name(name);
  chptr->hnextch = (IRC_Chan*) channelTable[hashv].list;
  channelTable[hashv].list = (void*) chptr;
  ++channelTable[hashv].links;
  ++channelTable[hashv].hits;
}

/*
 * del_from_user_hash_table - remove a user/server from the user
 * hash table
 */
void del_from_user_hash_table(const char* name, IRC_User* cptr)
{
  IRC_User* tmp;
  IRC_User* prev = NULL;
  unsigned int   hashv;
  assert(0 != name);
  assert(0 != cptr);

  hashv = hash_nick_name(name);
  tmp = (IRC_User*) userTable[hashv].list;

  for ( ; tmp; tmp = tmp->hnext)
    {
      if (tmp == cptr)
        {
          if (prev)
            prev->hnext = tmp->hnext;
          else
            userTable[hashv].list = (void*) tmp->hnext;
          tmp->hnext = NULL;

          assert(userTable[hashv].links > 0);
          if (userTable[hashv].links > 0)
            --userTable[hashv].links;
          return;
        }
      prev = tmp;
    }
}

/*
 * del_from_snid_hash_table - remove a snid/server from the snid
 * hash table
 */
void del_from_snid_hash_table(u_int32_t snid, NickInfo* ni)
{
  NickInfo* tmp;
  NickInfo* prev = NULL;
  u_int32_t   hashv;

  hashv = hash_snid(snid);
  tmp = snidTable[hashv].list;

  for ( ; tmp; tmp = tmp->hnextsnid)
    {
      if (tmp == ni)
        {
          if (prev)
            prev->hnextsnid = tmp->hnextsnid;
          else
            snidTable[hashv].list = tmp->hnextsnid;
          tmp->hnextsnid = NULL;

          if (snidTable[hashv].links > 0)
            --snidTable[hashv].links;
          return;
        }
      prev = tmp;
    }
}

/*
 * del_from_channel_hash_table
 */
void del_from_channel_hash_table(const char* name, IRC_Chan* chptr)
{
  IRC_Chan* tmp;
  IRC_Chan* prev = NULL;
  unsigned int    hashv;
  assert(0 != name);
  assert(0 != chptr);

  hashv = hash_channel_name(name);
  tmp = (IRC_Chan*) channelTable[hashv].list;

  for ( ; tmp; tmp = tmp->hnextch)
    {
      if (tmp == chptr)
        {
          if (prev)
            prev->hnextch = tmp->hnextch;
          else
            channelTable[hashv].list = (void*) tmp->hnextch;
          tmp->hnextch = NULL;

          assert(channelTable[hashv].links > 0);
          if (channelTable[hashv].links > 0)
            --channelTable[hashv].links;
          return;
        }
      prev = tmp;
    }
}

/*
 * hash_find_user
 */
IRC_User* hash_find_user(const char* name)
{
  IRC_User* tmp;
  u_int32_t hashv;

  hashv = hash_nick_name(name);
  tmp = (IRC_User*) userTable[hashv].list;
  /*
   * Got the bucket, now search the chain.
   */
  for ( ; tmp; tmp = tmp->hnext)
    if (irccmp(name, tmp->nick) == 0)
      {
        return tmp;
      }
  return NULL;
}

/*
 * hash_find_snid
 */
NickInfo* hash_find_snid(u_int32_t snid)
{
  NickInfo* tmp;

  u_int32_t hashv = hash_snid(snid);
  tmp = snidTable[hashv].list;
  /*
   * Got the bucket, now search the chain.
   */
  for ( ; tmp; tmp = tmp->hnextsnid)
    if (snid==tmp->snid)
      {
        return tmp;
      }
  return NULL;
}

/*
 * hash_find_channel
 */
IRC_Chan* hash_find_channel(const char* name)
{
  IRC_Chan*    tmp;
  unsigned int hashv;
  
  assert(0 != name);
  hashv = hash_channel_name(name);
  tmp = (IRC_Chan*) channelTable[hashv].list;

  for ( ; tmp; tmp = tmp->hnextch)
    if (irccmp(name, tmp->name) == 0)
      {
        return tmp;
      }
  return NULL;
}

/*
 * hash_next_user
 */
IRC_User *hash_next_user(int reset)
{
    static u_int32_t next_index = 0;
    static IRC_User *current = NULL;
    if(reset)
      {
        next_index=0;
        current=NULL;              
      }

    if (current)
        current = current->hnext;

    /* check for the next used bucket */
    while (current == NULL && next_index < U_MAX)
        current = userTable[++next_index].list;
        
    return current;
}

/*
 * hash_next_chan
 */
IRC_Chan *hash_next_channel(int reset)
{
    static u_int32_t next_index = 0;
    static IRC_Chan *current = NULL;
    if(reset)
      {
        next_index=0;
        current=NULL;       
      }

    if (current)
        current = current->hnextch;

    /* check for the next used bucket */
    while (current == NULL && next_index < CH_MAX)
       current = channelTable[next_index++].list;
   
    return current;
}
