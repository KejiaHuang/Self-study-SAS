/************
 * Q1
 */

proc means data=learn.college mean median min max n nmiss maxdec=2;
run;

/****************
 * Q2
 */
options nofmterr;
title "by statement";
proc sort data=learn.college;
	by Gender SchoolSize;
run;
proc means data= learn.college mean median min max n nmiss maxdec=2;
	by Gender SchoolSize;
	Var ClassRank GPA;
run;
title "Class statement";
proc means data= learn.college mean median min max n nmiss maxdec=2;
	class Gender SchoolSize;
	Var ClassRank GPA;
run;
/***********
 * Q3
 */
title "BY statement";
proc sort data=learn.college;
	by SchoolSize;
run;
proc means data=learn.college mean median;
	by SchoolSize;
	var GPA ClassRank;
run;
title "CLASS statement";
proc means data=learn.college mean median;
	class SchoolSize;
	var GPA ClassRank;
run;

/**************
 * Q4
 */
proc format;
	value $groupsize 
	'S','M' = "Small and Medium"
	'L'	= "Large";
run;
proc means data=learn.college mean median;
	class SchoolSize;
	var GPA ClassRank;
	format SchoolSize $groupsize.;
run;

/******************
 * Q5
 */
proc format;
	value class 
		low-50 = "bottom half"
		51-74 = "3rd quartile"
		75-100 = "top quarter";
run;
proc means data= learn.college mean;
	class ClassRank;
	var GPA;
	format ClassRank class.;
run;

/*******************
 * Q6
 */
proc means data=learn.college noprint nway;
	class SchoolSize;
	var ClassRank GPA;
	output 	out = Class_summary
		n=
		mean=
		median= / autoname;
run;
proc print data=Class_summary;
run;

/************************
 * Q7
 */

proc means data=learn.college noprint nway;
	class SchoolSize Gender;
	var ClassRank GPA;
	output 	out = summary
		n =
		nmiss=
		mean=
		min=
		max= / autoname;
run;
data 	grand
	bygender
	bysize
	cell;
	drop _freq_;
	set summary;
	if _type_ = "00" then output grand;
	else if _type_ = '01' then output bygender;
	else if _type_ = '10' then output bysize;
	else output cell;
run;




























































