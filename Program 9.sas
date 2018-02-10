/********************
 * Q1
 */

data dates;
	input	@1 	Subj 	$3.
		@4 	DOB 	mmddyy10.
		@14	Visit	date9.;
		age = yrdif(DOB,Visit,'Actual');
		format DOB Visit date9.;
datalines;
00110/21/195011Nov2006
00201/02/195525May2005
00312/25/200525Dec2006
;
title "Q1";
proc print data=dates;
run;

/******************
 * Q2
 */

data ThreeDates;
	input 	Date1: mmddyy10.
		Date2: mmddyy10.
		Date3: date9.;
	Year12 = round(yrdif(Date1,Date2,'Actual'));
	Year23 = round(yrdif(Date2,Date3,'Actual'));
	format Date1 Date2 Date3 mmddyy10.;
datalines;
01/03/1950 01/03/1960 03Jan1970
05/15/2000 03/15/2002 15May2003
10/10/1998 11/12/2000 25Dec2005
;

title "Q2";
proc print data=ThreeDates;
run;
		
/************************
 * Q3
 */

options yearcutoff= 1910;
data Dates1910_2006;
	input @1 year mmddyy8.;
	format year date9.;
datalines;
01/01/11
02/23/05
03/15/15
05/09/06
;

title "Q3";
proc print data=Dates1910_2006;
run;

/********************************
 * Q4
 */


title "Q4";


data ages;
	set learn.HOSP(keep = DOB);
	AgeJan1  = yrdif(DOB,"01Jan2006"d,"Actual");
	AgeToday = yrdif(DOB,Today(),'Actual');
	format DOB date10.;
run;
proc print data=ages noobs;
run;

/****************
 * Q5
 */

title "Q5";

data hospnew;
	set learn.Hosp(keep =DOB);
	day 	= weekday(DOB);
	month 	= Month(DOB);
	year	= year(DOB);
run;
proc print data=hospnew;
run;
proc freq data=hospnew;
	tables day month year;
run;

/****************
 * Q6
 */
title "Q6";


data medical_6;
	set learn.medical;
	day = weekday(VisitDate);
run;
proc freq data=medical_6;
	tables day;
run;

/*******************
 * Q7
 */

title "Q7";
proc print data=learn.hosp;
	where DOB le '01Junl2002'd and 
		DOB is not missing;
run;

/*************
 * Q8
 */

title "Q8";
data date;
	input 	day  	
		month 	
		year 	;
	if missing(day) then Date = mdy(month,15,year);
	else Date = mdy(month,day,year);
	format 	Date mmddyy10.;
datalines;
25 12 2005
.  5 2002
21 10 1946
;
proc print data= date noobs;
run;
	

/*****************
 * Q11
 */
title "Q11";
data Interval;
	set learn.medical(keep=VisitDate);
	Quarter = intck('qtr',"01Jan2006"d,VisitDate);
run;
proc print data=Interval;
run;

/************
 * Q12
 */
title "Q12";

data return;
	set learn.Medical(keep= Patno VisitDate);
	Returns = intnx("week",VisitDate,5,'sameday');
	format VisitDate Returns mmddyy10.;
run;
proc print data=return;
run;
	
	
/**********
 * Q13
 */
title "Q12";

data return_1;
	set learn.Medical(keep= Patno VisitDate);
	Returns = intnx("month",VisitDate,6,'sameday');
	format VisitDate Returns mmddyy10.;
run;
proc print data=return_1;
run;
	




















		
		
		
		
		
























		