/***********
 * One way tables using proc freq
 */
libname learn "/folders/myfolders/learning";
proc freq data=learn.survey;
run;

/************
 * adding a tables statement to proc freq
 */

proc freq data=learn.survey;
	tables Gender Ques1-Ques3 / nocum;
run;

/************
 * Adding formats 
 */

proc format;
	value $gender
		'F' = 'Female'
		'M' = 'Male';
	value $likert
		'1' = 'Strongly disagree'
		'2' = 'Disagree'
		'3' = 'No opinion'
		'4' = 'Agree'
		'5' = 'Strongly agree';
run;

proc freq data= learn.survey;
	tables 	Gender Ques1-Ques3 / nocum;
	format 	Gender $gender.
		Ques1-Ques3 $likert.;
run;
		
/********************
 * using formats to group values
 */

proc format;
	value agegroup
		low-<30 = 'Less than 30'
		30-<60 	= '30 to 59'
		60-high = '60 and higher';
	value $agree_disagree
		'1','2' = 'Generally disagree'
		'3'	= 'No opinion'
		'4','5' = 'Generally agree';
run;

proc freq data=learn.survey;
	tables 	Age Ques5 / nocum nopercent;
	format 	Age agegroup.
		Ques5 $agree_disagree.;
run;
		
/***************
 *  proc freq with missing value
 */

proc format;
	value two
		low-3 = 'Group 1'
		4-5   = 'Group 2'
		.     = 'Missing'
		other = 'Other values';
run;
proc freq data=learn.grouping;
	tables X / nocum nopercent;
	format X two.;
run;
		
proc freq data=learn.grouping;
	tables X /missing;
	format X two.;
run;

proc freq data=learn.grouping;
	format X two.;
	tables X;
run;
		
/**************
 * order option of proc freq
 */

proc format;
	value darwin
		1 = 'Yellow'
		2 = 'Blue'
		3 = 'Red'
		4 = 'Green'
		. = 'Missing';
run;
data test;
	input Color @@;
datalines;
3 4 1 2 3 3 3 1 2 2
;
title "formatted";
proc freq data=test order = formatted;
	tables Color / nocum nopercent missing;
	format Color darwin.;
run;
title "data";
proc freq data=test order = data;
	tables Color / nocum nopercent missing;
	format Color darwin.;
run;
title "freq";
proc freq data=test order = freq;
	tables Color / nocum nopercent missing;
	format Color darwin.;
run;
		
/********************
 * Requesting a two-way table
 */
		
proc freq data=learn.blood;	
	tables Gender * BloodType;
run;
		
/********************
 * Requesting a three-way table with proc freq
 */
proc freq data=learn.blood;
	tables Gender * AgeGroup * BloodType/
		nocol norow nopercent;
run;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		