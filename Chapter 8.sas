/*************
 * Do group
 */

data grades;
	length 	Gender 	$1
		Quzi	$2
		AgeGrp	$13;
	infile '/folders/myfolders/learning/grades.txt' missover;
	input Age Gender Midterm Quiz FinalExam;
	if missing(Age) then delete;
	if Age le 39 then do;
		Agegrp = 'Younger group';
		Grade  = .4*Midterm + .6*FinalExam;
	end;
	else if Age gt 39 then do;
		Agegrp = 'Older group';
		Grade  = (Midterm + FinalExam)/2;
	end;
run;

title "listing of Grades";
proc print data=grades noobs;
run;

/****************
 * cumulative total
 */

data revenue;
	input 	Day : $3.
		Revenue: dollar6.;
	Total + Revenue;
	format Revenue Total dollar8.;
datalines;
Mon $1,000
Tue $1,500
Wed $.
Thu $2,000
Fri $3,000
;

title "cumulative total";
proc print data=revenue;
run;

/************
 * using a sum statement to create a counter
 */

data test;
	input x;
	if missing(x) then MissCounter + 1;
datalines;
2
.
7
.
;
title "counter";
proc print data = test;
run;


/**************************
 *  Do loop
 */

data compound;
	Interest = .0375;
	Total = 100;
	do year = 1 to 3;
		Total + Interest*Total;
		output;
	end;
	format Total dollar10.2;
run;
title("do loop");

proc print data=compound;
run;

/**********************
 * Do loop to make a table 
 */

data table;
	do n =1 to 10;
		square= n*n;
		squareRoot = sqrt(n);
		output;
	end;
run;

title "Table of Squares and Square Roots";
proc print data=table noobs;
run;

/***********************
 * Do loop to graph an equation
 */
data equation;
	do x = -10 to 10 by .01;
		y = 2*x**3 - 5*x**2 + 15*x -8;
		output;
	end;
run;

symbol value=none interpol=sm width=2;
title "Plot of Y versus X";

proc plot data=equation; /*** bug ***/
	plot y*x;
run;

/**************************
 *  LEAVE
 */

data leave_it;
	Interest = .0375;
	Total = 100;
	do year = 1 to 100;
		Total = Total + Interest*Total;
		output;
		if Total ge 200 then leave;
	end;
	format Total dollar10.2;
run;
title"Leave ";
proc print data=leave_it;
run;



data continue_on;
	Interest = .0375;
	Total = 100;
	do year = 1 to 100 until (Total ge 200);
		Total = Total + Interest*Total;
		if Total le 150 then continue;
		output;
	end;
	format Total dollar10.2;
run;
title "continue";
proc print data=continue_on;
run;















