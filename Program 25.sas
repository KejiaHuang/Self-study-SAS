/**************************
* 	Q1
*/

title "Listing produced on &SYSDAY,  &SYSDATE9 at &SYSTIME";
proc print data = learn.Stocks(obs=5);
run;

/*****************************
*	Q2
*/
%let start 	1;
%let end 	5;

data sqrt_table;
	do n = &start to &end;
		Sqrt_n = sqrt(n);
		output;
	end;
run;

proc print data = sqrt_table noobs;
run;

/****************************
*	Q3
*/

%macro print_N(n,name);

title "Listing of the frist &n obs from"
		"Data set &name";
proc print data = learn.&name(obs=&n) noobs;
run;
%mend print_N;
%print_N(5,bicycles);

/**************************************************
*	Q4
*/

%macro STATS(Dsn, Class, Vars);
proc means data = &Dsn n mean min max maxdec = 1;
	class &Class;
	var &Vars;
run;

%mend STATS;
%STATS(learn.bicycles, Country, Units TotalSales);

/***************************
*	Q5
*/

proc means data = learn.Fitness noprint;
	var TimeMile RestPulse MaxPulse;
	output out = summary 
		   mean= /autoname;
run;

proc print data = summary;
run;

data _null_;
	set summary;
	call symput('M_TimeMile',TimeMile_Mean);
	call symput('M_RestPulse',RestPulse_Mean);
	call symput('M_MaxPulse',MaxPulse_Mean);

run;

data Q5;
	set learn.fitness;
	P_TimeMile = round(100*TimeMile/(&M_TimeMile),1);
	P_RestPulse = round(100*RestPulse/(&M_RestPulse),1);
	P_MaxPulse = round(100*MaxPulse/(&M_MaxPulse),1);
run;

proc print data = Q5;
run;



















