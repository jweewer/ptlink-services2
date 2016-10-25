
/*************************************************************************
    NewsServ structures/constants
 *************************************************************************/
#include "services.h"

#define MAX_NEWSADMINS 	16 /* maximum news admins allowed */
#define MAX_NEWSOPERS 	32 /* maximum news opers allowed */
#define MAX_SUBJECTS 	20 /* maximum subjects, mut be < 32 */
#define MAX_LASTNEWS 	32 /* capacity of last news buffer */
#define NEWSQLEN	32 /* maximum queue capacity */

/* NewsMask */
/* the only representative bit in newsmask is 
 bit 0, values: 0 = receive news via privmsg, 1 = receive news via notice */
#define NM_NOTICE	0x00000001
#define NM_ALL		0xFFFFFFFE

/* Flags */
#define NW_WELCOME	0x0001 /* needing welcome service msg */
#define NW_NONEWS	0x0002

typedef struct newsinfo_ NewsInfo;
struct newsinfo_ {
    time_t	sent_time;	/* sent time */
    char	sender[NICKMAX];	/* news sender */
    char	*message;		/* news message */
    int16	number;		/* subject number, 0 = deleted item */
};
