/*********************************
*	Using an automatic macro variable 
*	to include a date and time in a title
*/

title "The Date is &sysdate9 - the time is &systime";

libname learn "d:/sasfile/learning";

proc print data = learn.test_scores noobs;
run;

/**************************************
*	Assigning a value to a macro variable with a %LET statement
*/

%let var_list = RBC WBC Chol;

proc means data = learn.blood n mean max maxdec = 1;
	var &var_list;
run;

/**************************
*	Assigning a value to a macro variable with a %LET statement
*/

%let n = 3;

data generate;
	do Subj = 1 to &n;
		x = int(100*ranuni(0) + 1);
		output;
	end;
run;
title "Date set with &n Random Numbers";
proc print data = generate noobs;
run;

/*******************************
*	Writing a simple macro
*/

%macro gen(	n,		/*	number of random numbers	*/
			Start,	/*	Starting value				*/
			End		/*	Ending value				*/);
	/****************************************************
			Example: To generate 4 random numbers from
			1 to 100 use:
			%gen(4,1,100)
	*****************************************************/

	data generate;
		do Subj = 1 to &n;
			x = int((&End - &Start + 1)*ranuni(0) + &Start);
			output;
		end;
	run;

	proc print data = generate noobs;
		title "Randomly Genrated Data Set with &n Obs";
		title2 "Values are integers from &start to &End";
	run;
%mend gen;
		
%gen(4,1,100);

/**************************
*	Demonstrating a program with resolving a macro variable
*/

%let prefix = abc;

data &prefix.123;
	x  = 3;
run;

proc print data = abc123;
run;

/*************************************
*	Using a macro variable as a prefix
*/
%let libref = learn;

proc print data = &libref..survey1;
	title " Listing of SURVEY";
run;

/************************************
*	Using a macro variables to transfer values 
*	from one DATA step to another 
*/

proc means data = learn.blood noprint;
	var RBC WBC;
	output out = means mean = M_RBC M_WBC;
run;

data _NULL_;
	set means;
	call symput('AveRBC', M_RBC);
	call symput('AveWBC', M_WBC);
run;


data new;
	set learn.blood(obs=5 keep=Subject RBC WBC);
	Per_RBC = RBC / &AveRBC;
	Per_WBC = WBC / &AveWBC;
	format Per_RBC Per_WBC percent8.;
run;

proc print data = new;
run;






























