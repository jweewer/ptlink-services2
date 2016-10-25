/* stats routines
 * NickServ functions.
 *
 * PTlink Services is (C) CopyRight PTlink IRC Software 1999 
 *                http://software.pt-link.net       
 * This program is distributed under GNU Public License
 * Please read the file COPYING for copyright information.
 */
#include "services.h"

void clearDayStats(void) {
    DayStats.ns_registered = 0;
    DayStats.ns_dropped = 0;
    DayStats.ns_expired = 0;
    DayStats.cs_registered = 0;
    DayStats.cs_dropped = 0;
    DayStats.cs_expired = 0;    
}

/*
 * Save statistics for today
 */
void saveDayStats(void) {
    FILE *savefile;
    time_t t;
    struct tm tm;    
    char buf[63];
    if(DayStats.ns_total==0) {
        log2c("Total nicknames=0 saving daily stats");
        return;
    }
    if(!(savefile=fopen(DayStatsFN,"wt"))) {
	log2c("Error creating DayStats file!");
	return;
    }
    time(&t);
    tm = *localtime(&t);
    strftime(buf, sizeof(buf)-1, "%Y/%m/%d", &tm);
    fprintf(savefile,"%s\n",buf);
    fprintf(savefile,"NickServ\n");
    fprintf(savefile,"Reg: %ld\n",(long int) DayStats.ns_registered);
    fprintf(savefile,"Drp: %ld\n",(long int) DayStats.ns_dropped);
    fprintf(savefile,"Exp: %ld\n",(long int) DayStats.ns_expired);    
    fprintf(savefile,"ChanServ\n");
    fprintf(savefile,"Reg: %ld\n",(long int) DayStats.cs_registered);
    fprintf(savefile,"Drp: %ld\n",(long int) DayStats.cs_dropped);
    fprintf(savefile,"Exp: %ld\n",(long int) DayStats.cs_expired);        
    fclose(savefile);
}
/*
 * Load statistics for today (if data file is for today)
 */
void loadDayStats(void) {
    FILE *loadfile;
    time_t t;
    struct tm tm;    
    char buf[63];
    char line[63];
    long int value;
    if(!(loadfile=fopen(DayStatsFN,"rt"))) {
	log1("DayStats: File not found.");
	return;
    }
    time(&t);
    tm = *localtime(&t);
    strftime(buf, sizeof(buf)-1, "%Y/%m/%d", &tm);
    fscanf(loadfile,"%s",line);
    if(strcmp(line,buf)) {
        fclose(loadfile);        
	log1("DayStats: stats on file %s are not for today! Please remove it to run services\n",
		DayStatsFN);
	fprintf(stderr,"DayStats: stats on file %s are not for today! Please remove it to run services\n",
		DayStatsFN);		
	close_log();
	exit(1);
    }
    if(debug) log1("Debug: Loading DayStats");
    fscanf(loadfile,"%s",line); /* NickServ */
    fscanf(loadfile,"%s %ld",line,&value);
    DayStats.ns_registered=value;
    fscanf(loadfile,"%s %ld",line,&value);
    DayStats.ns_dropped=value;
    fscanf(loadfile,"%s %ld",line,&value);
    DayStats.ns_expired=value;    
    fscanf(loadfile,"%s",line); /* ChanServ */
    fscanf(loadfile,"%s %ld",line,&value);
    DayStats.cs_registered=value;
    fscanf(loadfile,"%s %ld",line,&value);
    DayStats.cs_dropped=value;
    fscanf(loadfile,"%s %ld",line,&value);
    DayStats.cs_expired=value;        
    fclose(loadfile);
}

/*
 * Save balance summary (should be called by end_of_day_stats() )
 */
void saveSummary(void)
{
    FILE *savefile;
    time_t t;
    struct tm tm;    
    char buf[63];
    if(!BalanceHistoryFN) return;
    if(!(savefile=fopen(BalanceHistoryFN,"at"))) {
	log2c("Error opening Balance History file!");
	return;
    }
    time(&t);
    tm = *localtime(&t);
    strftime(buf, sizeof(buf)-1, "%Y/%m/%d", &tm);
    fprintf(savefile,"%s NS: %li %ld %ld %ld", buf,
	DayStats.ns_total, DayStats.ns_registered,
	DayStats.ns_expired, DayStats.ns_dropped);
    fprintf(savefile," CS: %ld %ld %ld %ld\n",
	DayStats.cs_total, DayStats.cs_registered,
	DayStats.cs_expired, DayStats.cs_dropped);	
    fclose(savefile);
    log1("Saved Daily Balance");
}
/*
 * end of day tasks
 */
void end_of_day_stats(void) {
    saveSummary();
    saveDayStats();
    clearDayStats();
};
