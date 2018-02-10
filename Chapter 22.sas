
data conference;
    input   @1  Name    $10.
            @11 Date    mmddyy10.;
    format  Date registration.;
datalines;
Smith     10/21/2005
Jones     06/12/2005
Harris    01/03/2007
Arnold    09/12/2005
;
proc print data = conference;
run;
/***********
*	Using a format to recode a variable
*/

proc format;	
	value agefmt 	0 - <20	= '<20'
				   20 - <40 = '20 to 39'
				   40 - <60 = '40 to 59'
				   60 - high= '60+';
run;

title "Using a Format to Recode a Variable";
proc freq data = learn.survey;
	tables Age	/ 	nocum nopercent;
	format Age agefmt.;
run;

/*****************************
*	Using a format and a PUT function to create a new variable
*/

data survey;
	set learn.survey;
	AgeGroup = put(Age,agefmt.);
run;

/***********************************
*	Demonstrating a user-written informat
*/	

proc format;
	invalue convert	'A+' = 100
					'A'  = 96
					'A-' = 92
					'B+' = 88
					'B'  = 84
					'B-' = 80
					'C+' = 76
					'C'  = 72
					'F'  = 65;
run;

data grades;
	input 	@1 	ID		$3.
			@4	Grade	convert2.;
datalines;
001A-
002B+
003F
004C+
005A
;
proc print data = grades;
run;

/*************************************
*	Demonstrating informat options UPCASE and JUST
*/
proc format;
	invalue converts (upcase just)	
					'A+' = 100
					'A'  = 96
					'A-' = 92
					'B+' = 88
					'B'  = 84
					'B-' = 80
					'C+' = 76
					'C'  = 72
					'F'  = 65
				  other  =  .;
run;
data grade;
	input	@1 	ID		$3.
			@4	Grade	converts2.;
datalines;
001A-
002b+
003F
004c+
005 A
006X
;
proc print data = grade noobs;
run;

/**********************************
*	A traditional approach to reading 
*	a combination of character and numeric data 
*/

data temperatures;
	input Dummy $ @@;
	if upcase(Dummy) = 'N' then Temp = 98.6;
	else Temp = input(Dummy,8.);
	drop Dummy;
datalines;
101 N 97.3 n N 104.5
;
proc print data = temperatures;
run;

/**************************
*	Using an enhanced numeric informat 
*	to read a combination of character and numeric data
*/

proc format;
	invalue readtem(upcase)
			96 - 106 	= _same_
			'N'		 	= 98.6
			other		= .;
run;
data temps;
	input Temp :	readtem5. @@;
datalines;
101 N 97.3 N n 67 104.5
;
proc print data = temps;
run;

/*******************
*	Using formats and informats to perform a table lookup
*/

proc format;
	value namelookup
		122  = 	'Salt'
		188	 =  'Sugar'
		101	 =  'Cereal'
		755  =  'Eggs'
	  other  =  ' ';
	invalue pricelookup
		'Salt'		=	3.76
		'Sugar' 	= 	4.99
		'Cereal'	=	5.97
		'Eggs'		= 	2.65
		other		=  	.;
run;

data grocery;
	input ItemNumber	@@;
	Name 	= put(ItemNumber, namelookup.);
	Price	= input(Name,pricelookup.);
datalines;
101 755 122 188 999 755
;
proc print data = grocery;
run; 

/*************************
*	Creating a test data set 
*	that will be used to make a CNTLIN data set
*/
libname learn "d:/sasfile/learning";
data learn.codes;
	input 	ICD9 : $5.	
			Description & $21.;
datalines;
020 Plague
022 Anthrax
390 Rheumatic fever
410	Myocardial Iinfarction
493 Asthma
540 Appendicitis
;

/**************************
*	Creating a CNTLIN data set from an existing SAS data set
*/

data control;
	set learn.codes(	rename	=	
						(	ICD9 = Start
							Description = Label));
	retain 	Fmtname '$ICDFMT'
			Type	'C';
run;

proc format cntlin = control fmtlib;
run;

proc print data = control;
run;
/*************************************
*	Using the CNTLIN= created data set
*/

data disease;
	input ICD9 	: $5. @@;
datalines;
020 410 500 493
;
proc print data = disease noobs;
	format ICD9 $ICDFMT.;
run;

/*******************************
*	Adding an OTHER category to your format
*/

data control1 	/	view = control1;
	set learn.codes(	rename = (
									ICD9 		= Start
									Description = Label))
									end			= last;
	retain 	Fmtname	'$ICDFMT'
			Type	'C';
	if 	last then do;
		Start  = ' ';
		Hlo    = 'o';
		Label  = 'Not Found';
	end;
run; 
proc format cntlin = control1 fmtlib;
run;

proc print data = control1;
run;


/****************************************
*	Updating an existing format using a 
*	CNTLOUT = data set option 
*/

proc format cntlout = control_out;
	select $ICDFMT;
run;
proc print data = control_out;
run;
data new_control;
	length Label $21;
	set control_out end = Last;
	output;
	if Last then do;
		Hlo 	= ' ';
		Start	= '427.5';
		End		= Start;
		Label   = 'Cardiac Arrest';
		output;
		Start 	= '466';
		End   	= Start;
		Label  	= 'Bronchitis';
		output;
	end;
run;

proc format cntlin = new_control;
	select $ICDFMT;
run;
proc print data = new_control;
run;

/*****************
*	Demonstrating nested formats
*/

proc format;
	value registration 
			     low - < '15Jul2005'd = 'Not Open'
   		  '15Jul2005'd - '31Dec2006'd = [mmddyy10.]
		  '01Jan2007'd - high		  = 'Too Late';
run;

data conference;
	input 	@1 	Name 	$10.
			@11	Date	mmddyy10.;
	format	Date registration.;
datalines;
Smith	  10/21/2005
Jones	  06/12/2005
Harris    01/03/2007
Arnold	  09/12/2005
;
proc print data = conference;
run;
	
/****************
*	Create a MULTILABEL format
*/

proc format;
	value agegroup (multilabel)
		0	-<	20		= 	'0 to <20'
		20	-<	40  	= 	'20 to 40'
		40	-<	60  	= 	'40 to 60'
		60  -<  80		= 	'60 to 80'
		80	-	high	=	'80	+'

		0 	-<	50 		=	'Less than 50'
		50	- 	high	=	'> or = to 50';
run;

/******************************
*	Using a MULTILABEL format with PROC MEANS
*/	

proc means data = learn.survey;
	class Age / MLF;
	var Salary;
	format Age agegroup.;
run;

/*******************************
*	MULTILABEL with PROC TABULATE
*/ 

proc print data = learn.survey;
run;


proc tabulate data = learn.survey;
	class Age  Gender / MLF;
	table Age, Gender;
	/*format Age agegroup.;*/
run;
quit;




























	














