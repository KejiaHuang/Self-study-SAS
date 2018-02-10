/*******
 * Question 1
 */

data  score;
	infile "/folders/myfolders/learning/scores.txt";
	input gender $1. English history math science;
	average = 1/4*(English + history + math + science);
run;

title"Question 1";
proc print data=score noobs;
run;

/***********
 * Question 2
 */

data Vote;
	infile "/folders/myfolders/learning/political.csv" dsd;
	informat State $2. Party $3.;
	input State  Party  Age;
run;

title"Question 2";
proc print data = Vote;
run;
proc freq data = Vote;
	table Party/nocum;
run;

/********
 * Question 3
 */

data Company;
	infile "/folders/myfolders/learning/company.txt" dsd dlm='$';
	input LastName $ EmpNo $ Salary;
	format Salary dollar8.;
run;
title"Question 3";
proc print data=Company noobs;
run;

/********
 * Question 4
 */

filename file "/folders/myfolders/learning/company.txt";
data Company_n;
	infile file dsd dlm='$';
	input LastName $ EmpNo $ Salary;
	format Salary dollar8.;
run;
title"Question 4";
proc print data=Company_n noobs;
run;

/********
 * Question 5
 */

data math;
	input 	x y ;
		z = 100+50*x+2*x**2-25*y+y**2;
	datalines;
	1 2
	3 6
	5 9
	9 11
	;

title "Question 5";
proc print data=math noobs;
run;

/*******
 * Question 6
 */
data Bank;
	infile "/folders/myfolders/learning/bankdata.txt" pad;
	input 	@1	Name 	$15.	 
		@16	Acct 	$4.
		@21	Balance	7.
		@27 	Rate	5.;
run;
title "Question 6";
proc print data=Bank noobs;
run;

/*******
 * Question 8
 */
data Bank_n;
	infile "/folders/myfolders/learning/bankdata.txt" pad;
	input 	Name 	$ 	1-15
		Acct 	$ 	16-20
		Balance		21-25
		Rate		27-30;
run;
title "Question 8";
proc print data=Bank_n noobs;
run;

/************
 * Question 10
 */

data Stocks;
	infile "/folders/myfolders/learning/stockprices.txt" pad;
	input 	@1 	Stock 		$4.
		@5 	PurDate		mmddyy10.
		@15	PurPrice	dollar6.
		@21	Number		4.
		@25	SellDate	mmddyy10.
		@35	SellPrice	dollar6.;
		TotalPur  = Number * PurPrice;
		TotalSell = Number * SellPrice;
		Profit    = TotalSell - TotalPur;
	format PurPrice SellPrice TotalPur TotalSell Profit dollar10.
		PurDate SellDate mmddyy10.;
	
run;
title"Question 10";
proc print data=Stocks;
run;

/*************
 * Question 11
 */
data Employ;
	infile "/folders/myfolders/learning/employee.csv" dsd;
	informat 	ID 		$3.
			Name		$20.
			Depart		$8.
			DateHire	mmddyy10.
			Salary		dollar8.;
	input ID Name Depart DateHire Salary;
	format 	DateHire mmddyy10.
		Salary 	 dollar8.;
run;
title "Question 11";
proc print data = Employ noobs;
run;
