/************************
 * read dates from raw data
 */

data four_dates;
	infile "/folders/myfolders/learning/dates.txt" truncover;
	input 	@1  	Subject	 	$3.
		@5  	DOB 		mmddyy10.
		@16	VisitDate	mmddyy8.
		@26 	TwoDigit	mmddyy8.
		@34	LastDate	date9.;
	format 	DOB VisitDate date9.
		TwoDigit LastDate mmddyy10.;
run;
title "read dates from raw data";
proc print data = four_dates;
run;
	
	
/**************
 * Compute a person's age in years
 */

data ages;	
	set four_dates;
	Age = yrdif(DOB,VisitDate,'Actual');
run;

title "Listing of AGES";
proc print data = ages;
	id Subject;
	var DOB VisitDate Age;
run;

/****************
 * a date constant
 */

data ages;
	set four_dates;
	Age = yrdif(DOB,'01Jan2006'd,'Actual');
run;

title "listing of Ages";
proc print data = ages;
	id Subject;
	var DOB Age;
	format Age 5.1;
run;

/**************
 * today function
 */

data ages;
	set four_dates;
	Age = yrdif(DOB,today(),'Actual');
run;

title "today function";

proc print data=ages;
run;

/************
 * Extracting the day of the week, day of the month, month,year
 */


data extract;
	set four_dates;
	Day = weekday(DOB);
	DayofMonth = day(DOB);
	Month = Month(DOB);
	Year = year(DOB);
run;

title "Listing of Extract";
proc print data=extract noobs;
	var DOB Day--Year;
run;

/***********
 * Using the MDY function to create a SAS date from month, day, and year values
 */

data mdy_example;
	set learn.month_day_year;
	Date = mdy(Month,Day,Year);
	format Date  mmddyy10.;
run;
title "mdy function";
proc print data=mdy_example;
run;

/*********
 * substituting the 15th of the month when a Day value is missing
 */

data substitute;
	set learn.month_day_year;
	if missing(Day) then Date = mdy(Month,15,Year);
	else Date = mdy(Month,Day,Year);
	format Date mmddyy10.
run;
title "substituting";
proc print data=substitute;
run;


/**************
 * Demonstraing the intck function
 */

data frequency;
	set learn.hosp(keep = AdmitDate
			where =(AdmitDate between '01Jan2003'd and 
						  '30Jun2006'd));
	Quarter = intck('qtr','01Jan2003'd,AdmitDate);
run;

title "Frequency of Admissions";
proc freq data=frequency ;
	tables Quarter /out=admit_per_quarter;
run;

/*************
 * using the intnk function
 */
data followup;
	set learn.discharge;
	FollowDate = intnx('month',DischrDate,6);
	format FollowDate date9.;
run;

title"using the intnk function";
proc print data=followup;
	id PatNo;
run;


























