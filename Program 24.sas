/**************************************
*	Q1
*/

libname learn "d:/sasfile/learning";

proc sort data = learn.DailyPrices;
	by Symbol;
run;



data Q1; 
	set learn.DailyPrices;
	by Symbol;
	if last.Symbol then output;
run;

proc print data = Q1;
run;

/************************************
*	Q2
*/

proc means data = learn.DailyPrices nway;
	class Symbol;
	var Price;
	output out = counts(
						drop   = _freq_ _type_)
			mean=
			n=
			max=
			min= / autoname;
run;

proc print data = counts;
run;

/***************************************************
*	Q3
*/

data Q3;
	set learn.DailyPrices(keep = Symbol);
	by Symbol;
	if first.Symbol then N_Days = 0;
	N_Days + 1;
	if last.Symbol then output;
run;

proc print data = Q3;
run;
	
/**********************************************
*	Q4
*/

proc freq data = learn.DailyPrices	noprint;
	tables Symbol /
	out = Q4(	rename = (	Count = N_Days)
							keep = Symbol Count);
run;

proc print data = Q4;
run;

/***********************************************
*	Q5
*/

data Q5;
	set learn.DailyPrices;
	by Symbol;
	if first.Symbol and last.Symbol then delete;
	retain first_Price;
	if first.Symbol then first_Price = Price;
	if last.Symbol then do;
		Diff_Price = Price - first_Price;
		output;
	end;
run;

proc print data = Q5;
run;

/***************************************
*	Q6
*/

data Q6;
	set learn.DailyPrices;
	by Symbol;
	if first.Symbol and last.Symbol then delete;
	retain first_Price;
	if first.Symbol or last.Symbol then Diff = dif(Price);
	if last.Symbol then
		output;
run;

proc print data = Q6;
run;

/*******************************************
*	Q7
*/

data Q7;
	set learn.DailyPrices;
	by Symbol;
	if first.Symbol and last.Symbol then delete;
	Diff = dif(Price);
	if not first.Symbol  then output;
run;
proc print data = Q7;
run;






























