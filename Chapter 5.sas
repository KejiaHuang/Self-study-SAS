/***********
 * Add label to variable
 */

libname learn "/folders/myfolders/learning";

data learn.test_score;
	length ID $ 3 Name $ 15;
	input ID $ Score1-Score3;
	label 	ID = "Student ID"
		Score1 = "Math Score"
		Score2 = "Science Score"
		Score3 = "English Score";
datalines;
1 95 96 98
2 78 77 76
3 88 91 92
;

proc means data= learn.test_score;
run;

/*************
 * Create user-defined formats 
 */

proc format;
	value$gender 	'M'   	= 'Male'
			'F'   	= 'Female'
			' '   	= 'Not entered'
			other 	= 'Miscoded';
	value$age 	low-29	= 'Less than 30'
			30-50   = '30-50'
			51-high = '51+';
	value$likert  	'1'	= 'Strongly disagree'
			'2'	= 'Disagree'
			'3'     = 'No opinion'
			'4'	= 'Agree'
			'5'	= 'Strongly agree';
run;

/*********
 *  Add format statement in PROC PRINT
 */

title "Data Set SURVEY with Formatted Values";
proc print data= learn.survey;
	id ID;
	var Gender Age Salary Ques1-Ques5;
	format 	Gender 		$gender.
		Age		age.
		Ques1-Ques5	$likert.
		Salary		dolllar11.2;
run;

/********
 * Regrouping Values using Formats
 */

proc format;
	value $three 	'1','2' = 'Disagreement'
			'3'	= 'No opinion'
			'4','5'	= 'Agreement';
run;

proc freq data=learn.survey;
	title "Question Frequencies Using the $three Format";
	tables Ques1-Ques5;
	format Ques1-Ques5 $three.;
run;

/************
 * Creating a permanent format library
 */

libname myfmts '/folders/myfolders/learning';

proc format library = myfmts;
	value$gender 	'M'   	= 'Male'
			'F'   	= 'Female'
			' '   	= 'Not entered'
			other 	= 'Miscoded';
	value$age 	low-29	= 'Less than 30'
			30-50   = '30-50'
			51-high = '51+';
	value$likert  	'1'	= 'Strongly disagree'
			'2'	= 'Disagree'
			'3'     = 'No opinion'
			'4'	= 'Agree'
			'5'	= 'Strongly agree';
run;


/*****************
 * Adding LABEL and FORMAT statemtns in the DATA step
 */

libname learn  "/folders/myfolders/learning";
libname myfmts "/folders/myfolders/learning";
options fmtsearch = (myfmts work library);

data learn.survey;
	infile "/folders/myfolders/survey.txt" pad;
	input 	ID : $3.
		Gender : $1.
		Age
		Salary
		(Ques1-Ques5)(:$1.);
	format 	Gender 		$gender.
		Age		age.
		Ques1-Ques5	$likert.
		Salary		dolllar10.2;
	label 	ID	= 'Subject ID'
		Gender	= 'Gender'
		Age 	= 'Age as of 1/1/2006'
		Salary  = 'Yearly Salary'
		Ques1	= 'The governor is doing a good job'
		Ques2	= 'The property tax should be lowered'
		Ques3	= 'Guns should be banned'
		Ques4	= 'Expand the Green Acre program'
		Ques5   = 'The school needs to be expanded';
run;

title "Data set Survey";
proc contents data=learn.survey varnum;
run;
		 

/************
 * displaying format definitions
 * 
 */

title "Format Definition in MYFMTS LIBRARY";
proc format library=myfmts fmtlib;
run;
