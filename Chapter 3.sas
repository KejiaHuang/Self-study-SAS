
/*************
 * Problem 3-1
 * Reading Data Values Separated by Blanks
 ****************/

data mydata_1 ;
	infile "/folders/myfolders/learning/mydata.txt";
	input Gender $ age height weight;
run;
 
title "read data from txt";
proc print data=mydata_1;
run;

/*****************
 * Program 3_2
 * Reading data values separated by commas
 *******************/

data mydata_2;
	infile "/folders/myfolders/learning/mydata.csv" dsd;
	input gender $ age heights weights;
run;
title "read data from csv";
proc print data=mydata_2;
run;

/***************
 * Program 3_3
 * Reading data using an alternative method 
 * to specify an external file
 ***************/

filename file_1 "/folders/myfolders/learning/mydata.csv";
data mydata_3;
	infile file_1 dsd;
	input gender $ age heights weights;
run;
title "read data using file name";
proc print data= mydata_3;
run;

/*******************
 * Problem 3_4
 * Placing data lines directly in your program
 *****************/

data mydata_4;
	input gender $ age heights weights;
datalines;
M 50 68 155
F 23 60 101
;
title"input data in program";
proc print data=mydata_4;
run;

/****************
 * Problem 3_5
 * Specifying INFILE Options with the datalines statement
 */
 data mydata_5;
 	infile datalines dsd;
 	input gender $ age heights weights;
 datalines;
 "M",50,69,155
 "F",23,60,101
 ;
 title "Specifying infile options with the datalines statement";
 proc print data=mydata_5;
 run;

/*****************
 * Problem 3_6
 * Reading Raw Data from Fixed Columns Method_1
 */

data financial_1;
	infile "/folders/myfolders/learning/bank.txt";
	input 	Subj 	$ 1-3
		DOB  	$ 4-13
		Gender	$ 14
		Balance  15-21;
run;
title "input data from fixed columns method 1";
proc print data=financial_1;
run;

/************
 * Problem 3_7
 * Reading Raw Data from Fixed Columns Method_2
 */
data financial_2;
	infile "/folders/myfolders/learning/bank.txt";
	input 	@1 	Subj 	$3.
		@4 	DOB 	mmddyy10.
		@14	Gender	$1.
		@15	Balance 7.;
run;
title"input data from fixed columns method 2";
proc print data=financial_2;
	format 	DOB 	mmddyy10.
	      /*DOB     data9.*/
		Balance	dollar11.2;
run;

/********
 * Problem 3_8
 * Reading 
 */

data list_example_1;
	infile "/folders/myfolders/learning/list.csv" dsd;
	input 	Subj 	:3.
		Name 	:$20.
		DOB	:mmddyy10.
		Salary 	:dollar8.;
	format DOB data9. Salary dollar8.;
run;
title "using informat with list input";
proc print data=list_example_1;
run;

/****************
 * Problem 3_9
 * Supplying an informat statement with list input
 */

data list_example_2;
	informat 	Subj 	$3.
			Name	$20.
			DOB 	mmddyy10.
			Salary 	dollar8.;
	infile "/folders/myfolders/learning/list.csv" dsd;
	input 	Subj
		Name
		DOB
		Salary;
	format DOB date9. Salary dollar8;
run;
title "using informat with list input";
proc print data=list_example_2;
run;
 