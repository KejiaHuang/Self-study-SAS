/**********************
 * proc means with all defaults
 */

libname learn "/folders/myfolders/learning";
proc means data=learn.blood;
run;

/*************
 * add a VAR statement
 */

proc means data=learn.blood n nmiss mean median min max maxdec=1;
	var RBC WBC;
run;

/**********************
 * adding a by statement
 */

proc sort data=learn.blood out=blood;
	by Gender;
run;
proc means data=blood n nmiss mean median min max maxdec=1;
	by Gender;
	var RBC WBC;
run;


/********************
 * using a class statement with proc means
 */

proc means data=learn.blood n nmiss mean median min max maxdec=1;
	class Gender;
	var RBC WBC;
run;

/**********************
 * the effect of a formated class variable
 */

proc format;
	value chol_group
	low -< 200 = 'Low'
	200 - high = 'High';
run;

proc means data=learn.blood n nmiss mean median maxdec=1;
	class Chol;
	format Chol chol_group.;
	var RBC WBC;
run;

/***********************
 * outputting more than one statistic with PROC MEANS
 */

proc means data=learn.blood noprint;
	var RBC WBC;
	output 	out 	= many_stats
		mean 	= M_RBC M_WBC
		n	= N_RBC N_WBC
		nmiss	= Miss_RBC Miss_WBC
		median  = Med_RBC Med_WBC;
run;


proc print data=many_stats;
run;

/*****************
 * autoname in output option
 */

proc means data = learn.blood noprint;
	var RBC WBC;
	output out= 	many_statss
			mean	=
			n	=
			nmiss 	=
			median	= / autoname;
run;
proc print data= many_statss;
run;

/**********************
 * by statement to proc means
 */

proc sort data=learn.blood out=blood;
	by Gender;
run;

proc means data=blood noprint;
	by Gender;
	var RBC WBC;
	output  out  = by_gender
		mean = 
		n    = /autoname;
run;
proc print data = by_gender;
run;

/***************************
 * adding a class statement to proc means
 */

proc means data = blood noprint;
	class Gender;
	var RBC WBC;
	output 	out  = with_class
		mean = 
		n    = /autoname;
run;
proc print data= with_class;
run;

/***********************************
 *  adding the NWAY option to proc means
 */

proc means data=blood noprint nway;
	class Gender;
	Var RBC WBC;
	output 	out  = with_class1
		mean = 
		n    = /autoname;
run;
proc print data=with_class1;
run;

/*************************************
 * Using two class variables with proc means
 */
proc means data=learn.blood noprint;
	class Gender AgeGroup;
	var RBC WBC;
	output 	out  = summary
		mean =
		n    = /autoname;
run;
proc print data=summary;
run;

/***********************
 * adding the chartype procedure option to proc means
 */

proc means data=learn.blood noprint chartype;
	class Gender AgeGroup;
	var RBC WBC;
	output 	out = summary_1
		mean = 
		n = /autoname;
run;

proc print data=summary_1;
run;

/******************
 * Using the _TYPE_ variable to select cell means 
 */

proc print data=summary_1(drop = _freq_) noobs;
	where _TYPE_ = '10';
run;

/**********************
 * using a data step to create separate summary data sets
 */

data grand(drop = Gender AgeGroup)
	by_gender(drop = AgeGroup)
	by_age(drop = Gender)
	cellmeans;
	set summary;
	drop _type_;
	rename _freq_ = Number;
	if _type_ = '00' then output grand;
	else if _type_ = '01' then output by_age;
	else if _type_ = '10' then output by_gender;
	else if _type_ = '11' then output cellmeans;
run;
proc print data=grand;
run;

/*********************
 * Selecting different statistics for each variable using PROC MEANS
 */

proc means data=learn.blood noprint nway;
	class Gender AgeGroup;
	output 	out = summary_2(drop = _:)
		mean(RBC WBC) = 
		n(RBC WBC Chol) =
		median(Chol) = /autoname;
run;

proc print data= summary_2;
run;


































