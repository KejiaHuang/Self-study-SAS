/*************
 * Subsetting a SAS data set using a where statement
 */

data females ;
	libname learn "/folders/myfolders/learning";
	set learn.survey;
	where gender = "F";
run;
proc print data = females;
run;

/*******************
 * Demonstrating a drop = data set option
 */

data females_1;
	libname learn "/folders/myfolders/learning";
	set learn.survey(drop=Salary);
	where gender = "F";
run;
proc print data = females_1;
run;

/***************
 * creating two data set in ono data step
 */

data males_2 females_2;
	libname learn "/folders/myfolders/learning";
	set learn.survey;
	if gender = "F" then output females_2;
	else if gender = "M" then output males_2;
run;
proc print data= males_2;
run;

proc print data= females_2;
run;

/****************
 * combining detail and summary data
 */

title "q";
proc means data = learn.blood noprint;
	var Chol;
	output out = means(keep=AveChol)
		mean = AveChol;
run;

proc print data= means;
run;
data percent;
	set learn.blood(keep = Subject Chol);
	if _n_ = 1 then set means;
	PerChol = Chol / AveChol;
	format PerChol percent8.;
run;
proc print data= percent(obs = 10);
run;

/*****************
 * Merging two sas data set
 */

title "Merging two sas data set";
data employee;
	input ID NAME $;
datalines;
1 Smith
2 Schneider
4 Gregory
5 Washington
7 Adams
;

data hours;
	input ID JOB_Clase $ Hours;
datalines;
1 A 39
4 B 44
5 A 35
9 B 57
;

proc sort data=employee;
	by ID;
run;
proc sort data=hours;
	by ID;
run;
data combine;
	merge employee hours ;
	by ID;
run;

proc print data = combine ;

run;

/*********************
 * Demonstrating the IN= data set option
 */

data new;
	merge 	employee(in=InEmploy)
		hours(in=InHours);
	by ID;
	file print;
	put ID= InEmploy= InHours= Name= JobClass= Hours=;
run;

/************************
 * Using IN= variable to select IDs that are in both data sets;
 */

data combine_1;
	merge 	employee(in = InEmploy)
		hours(in = InHours);
	by ID;
	if InEmploy and InHours;
run;

proc print data = combine_1;
run;

/***********************
 * More examples of using IN= variables
 */

data in_both missing_name(drop = Name);
	merge 	employee(in=InEmploy)
		hours(in=InHours);
	by ID;
	if InEmploy and InHours then output in_both;
	else if not InEmploy and InHours then	
		output missing_name;
run;
title "in_both";
Eproc print data=in_both;
run;
title"missing_name";
proc print data=missing_name;
run;

/*************
 * merging two data sets by renaming a variable in one data set
 */

data bert;
	input ID X;
datalines;
123 90
222 95
333 100
;
data ernie;
	input EmpNo Y;
datalines;
123 200
222 205
333 317
;

data sesame;
	merge 	bert
		ernie(rename =(EmpNo = ID));
	by ID;
run;

title "sesame";
proc print data= sesame;
run;

/*******************
 * Merging two data sets 
 * when the by variable are different data type
 */

data division1;
	input 	@1	SS	9. 
		@11 	DOB 	mmddyy8. 
		@22 	Gender	$1.;
	format DOB mmddyy8.;
datalines;
111223333 11/14/1956 M
123445678 05/17/1946 F
876654321 04/01/1977 F
;
proc print data=division1;
run;

data division2;
	input 	@1	SS 	$11.
		@13	JobCode	$3.
		@17	Salary	5.;
datalines;
111-22-3333 A10 45123
123-44-5678 B5  35400
876-65-4321 A20 87900
;
proc print data=division2;
run;

data divisionic;
	set division1(rename=(SS= NumSS));
	SS = put(NumSS,ssn11.);
	drop NumSS;
run;

data both_divisions;
	merge divisionic division2;
	by SS;
run;
proc print data= both_divisions;
run;








