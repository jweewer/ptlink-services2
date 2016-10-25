/* Declarations for command data.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 *
 * These services are based on Andy Church Services 
 */

/*************************************************************************
    Structure for information about a *Serv command.     
    (new format - Lamego)
 *************************************************************************/
typedef struct {
    const char *name; /* "" means privilege check function */
    int (*routine)(User *u);
    int helpmsg;
    const char *help_param1;
    const char *help_param2;
    const char *help_param3;
    const char *help_param4;
} nCommand;

/*************************************************************************/

/* Structure for information about a *Serv command. */

typedef struct {
    const char *name;
    void (*routine)(User *u);
    int (*has_priv)(User *u);	/* Returns 1 if user may use command, else 0 */

    /* Regrettably, these are hard-coded to correspond to current privilege
     * levels (v4.0).  Suggestions for better ways to do this are
     * appreciated.
     */
    int helpmsg_all;	/* Displayed to all users; -1 = no message */
    int helpmsg_reg;	/* Displayed to regular users only */
    int helpmsg_oper;	/* Displayed to Services operators only */
    int helpmsg_admin;	/* Displayed to Services admins only */
    int helpmsg_root;	/* Displayed to Services root only */
    const char *help_param1;
    const char *help_param2;
    const char *help_param3;
    const char *help_param4;
} Command;

/*************************************************************************/

/* Routines for looking up commands.  Command lists are arrays that must be
 * terminated with a NULL name.
 */

extern Command *lookup_cmd(Command *list, const char *name);
extern void run_cmd(const char *service, User *u, Command *list,
		const char *name);
extern void help_cmd(const char *service, User *u, Command *list,
		const char *name);

extern nCommand *nlookup_cmd(nCommand *list, const char *name, User *u);		
extern void nrun_cmd(const char *service, User *u, nCommand *list,
		const char *name);
extern void nhelp_cmd(const char *service, User *u, nCommand *list,
		const char *name);

/*************************************************************************/
