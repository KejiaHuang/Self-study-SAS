/*************
 * Missing values at the end of a line with list input
 */

data missing;
	infile '/folders/myfolders/learning/missing.txt' missover;
	input x y z;
run;
proc print data=missing;
run;

/************
 * reading a raw data file with short records
 */

data short;
	infile "/folders/myfolders/learning/short.txt" truncover;
	input 	Subject $ 1 -  3
		Name	$ 4 -  19
		Quiz1	  20 - 22
		Quiz2     23 - 25
		Quiz3     26 - 28;
run;
proc print data=short;
run;

/***********
 * Demonstrating the END= option in the INFILE statement
 */

data _null_;
	file print;
	infile '/folders/myfolders/learning/month.txt' end=Last;
	input 	@1 Month $3.
		@5 MonthTotal 4.;
	YearTotal + MonthTotal;
	if last then	
		put "Total for the year is " YearTotal dollar8.;
run;

/*********
 * Demonstrating the obs= infile option to read the first three lines of data
 */
data readthree;
	infile '/folders/myfolders/learning/month.txt' obs=3;
	input 	@1 Month $3.
		@5 MonthTotal 4.;
run;
proc print data=readthree;
run;


data read5to7;
	infile "/folders/myfolders/learning/month.txt" firstobs=5 obs=7;
	input 	@1 Month $3.
		@5 MonthTotal 4.;
run;
proc print data= read5to7;
run;

/**************
 * Using the END= option to read data from multiple files
 */

data  combined;
	if finished = 0 then infile '/folders/myfolders/learning/file_a.txt' end=finished;
	else infile '/folders/myfolders/learning/file_b.txt';
	input 	x y z;
run;
proc print data=combined;
run;

filename bilbo ('/folders/myfolders/learning/file_a.txt'
                '/folders/myfolders/learning/file_b.txt');
data combined;
	infile bilbo;
	input x y z;
run;
proc print data=combined;
run;

/*****************
 * reading external filenames from an external file
 */



data readmany;
	input ExternalNames $40.;
	infile dummy filevar = ExternalNames end=Last;
	do until (Last);
		input x y z;
		output;
	end;
datalines;
/folders/myfolders/learning/file_a.txt
/folders/myfolders/learning/file_b.txt
;
run;
proc print data=readmany;
run;

/****************
 * Reading multiple lines of data to create one observation
 */

data health;	
	infile "/folders/myfolders/learning/health.txt" truncover;
	input #1 	@1	Sujb 	$3.
			@4  	DOB 	mmddyy10.
			@14	Weight 	3.
	      #2	@4 	HR	3.
	      		@7 	SBP	3.
	      		@10 	DBP	3.;
	 format DOB mmddyy10.;
run;
proc print data=health;
run;

/********************
 * alternate method of reading multiple lines of data
 */

data health;	
	infile "/folders/myfolders/learning/health.txt" truncover;
	input 		@1	Sujb 	$3.
			@4  	DOB 	mmddyy10.
			@14	Weight 	3./
	      		@4 	HR	3.
	      		@7 	SBP	3.
	      		@10 	DBP	3.;
	 format DOB mmddyy10.;
run;
proc print data=health;
run;

/**************
 * Using a trailing @ to read a file with mixed record types
 */

data survey;
	infile "/folders/myfolders/learning/survey56.txt" pad;
	input @9 Year $4. @;
	if Year = '2005' then	
		input 	@1 Number 	$3.
			@4 Q1		$1.
			@5 Q2		$1.
			@6 Q3		$1.
			@7 Q4		$1.;
	else if Year = '2006' then
		input 	@1 Number	$3.
			@4 Q1		$1.
			@5 Q2		$1.
			@6 Q2B		$1.
			@7 Q3		$1.
			@8 Q4		$1.;
run;
proc print data=survey;
run;

/*****************
 * Another example of a trailing @ sign
 */
data females;
	infile '/folders/myfolders/learning/bank.txt' truncover;
	input @14 Gender $1. @;
	if Gender ne "F" then delete;
	input 	@1 Subj		$3.
		@4 DOB 		mmddyy10.
		@15 Balance 	7.;
	format DOB mmddyy10.;
run;
proc print data=females;
run;

/***************
 * Creating one observation from one line of data
 */
data pairs;
	input X Y;
datalines;
1 2
3 4
5 6
7 8
11 14
30 40
;
proc print data=pairs;
run;

/***********
 * Creating several observations from one line of data
 */

data pairs;
	input X Y @@;
datalines;
1 2  3 4  5 6  7 8  11 14  25 28
;
proc print data=pairs;
run;









































