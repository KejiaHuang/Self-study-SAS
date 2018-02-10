/***********
 * Question 1
 */

proc format;
	value Age 	low-<30  = "0-30"
			30-<50 	 = "31-50"
			50-<70 	 = "51-70"
			70-high	 = "70+";
	value $party   	 'D'	 = "Democrat"
			 'R'	 = "Republican";
	value $like            '1' = "Strongly Disagree"
	                       '2' = "Disagree"
	                       '3' = "NoOpinion"
	                       '4' = "Agree"
	                       '5' = "Strongly Agree";
run;	               
	              
		
data votor;
	input Age Party : $1. (Ques1-Ques4)($1. + 1);
	format  Age 		Age.
		Party		$party.
		Ques1-Ques4 	$like.;
	label 	Ques1 	=	"The president is doing a good job"
		Ques2 	=	"Congress is doing a good job"
		Ques3 	= 	"Taxed are too high"
		Ques4	=	"Government should cut speading";
datalines;
12 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3 
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;

title "Question 1";
proc print data = votor label;
run;
proc freq data=votor;
	tables Ques1-Ques4;
run;

/************
 * Question 2
 */

proc format;
	value $likeornot 	"1","2" = "Generally Disagree"
				"3"	= "No Opinion"
				"4","5" = "Generally Agree";
run;
title"Question 2";
proc freq data = votor;
	tables Ques1-Ques4;
	format Ques1-Ques4 $likeornot.;
run;
	
/**************
 * Question 3
 */
title "Question 3";

proc format;
	value 	$col 	'R','G','B'="Group1"
			'Y','O'    ="Group2"
			' '	   = "Not Given"
			Other = "Group3";
run;
		
data colors;
	input Color : $1. @@;
datalines;
R R B G Y Y . . B G R B G Y P O O V V B
;

proc freq data=colors;
	tables Color /nocum missing;
	format Color $col.;
run;

/****************
 * Question 4
 */
libname learn "/folders/myfolders/learning";
options fmtsearch=(learn);
proc format library = learn fmtlib;
	value Age 	low-<30  = "0-30"
			30-<50 	 = "31-50"
			50-<70 	 = "51-70"
			70-high	 = "70+";
	value $party   	 'D'	 = "Democrat"
			 'R'	 = "Republican";
	value $like            '1' = "Strongly Disagree"
	                       '2' = "Disagree"
	                       '3' = "NoOpinion"
	                       '4' = "Agree"
	                       '5' = "Strongly Agree";
run;	               
	              
		
data learn.votor;
	input Age Party : $1. (Ques1-Ques4)($1. + 1);
	format  Age 		Age.
		Party		$party.
		Ques1-Ques4 	$like.;
	label 	Ques1 	=	"The president is doing a good job"
		Ques2 	=	"Congress is doing a good job"
		Ques3 	= 	"Taxed are too high"
		Ques4	=	"Government should cut speading";
datalines;
12 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3 
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;

title "Question 4";
proc print data = votor label;
run;
proc freq data=votor;
	tables Ques1-Ques4;
run;

/**************
 * Question 5
 */

libname learn "/folders/myfolders/learning";
options fmtsearch=(learn);
title "Question 5";
proc format library=learn fmtlib;
	value YESNO 	1	= 'Yes'
			2	= 'No';
	value $YESNO      'Y'	= 'Yes'
			'N'	= 'No';
	value $Gender  	'M'	= 'Male'
			'F'	= 'Female';
	value age20yr   low-<20 = 1
			20-<40	= 2
			40-<60  = 3
			60-<80  = 4
			80-high= 5;
run; 







	