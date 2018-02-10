/*************
 * Question 1 
 */

data school;
	input Age Quiz : $1. Midterm Final;
	if Age eq 12 then Grade = 6;
	else if Age eq 13 then Grade = 8;
	if Quiz eq 'A' then Quiz_grade = 95 ;
	else if Quiz eq 'B' then Quiz_grade = 85;
	else if Quiz eq 'C' then Quiz_grade = 75;
	else if Quiz eq 'D' then Quiz_grade = 70;
	else if Quiz eq 'F' then Quiz_grade = 65;
	Course = 0.2*Quiz_grade + 0.3*Midterm + 0.5*Final;
datalines;
12 A 92 95
12 B 98 88
13 C 78 75
13 A 92 93
12 F 55 62
13 B 88 82
;

title "Question 1";
proc print data=school;
run;




/***************
 * Question 2
 */

title "Q2_1";
proc print data=learn.Hosp noobs;
	where Subject eq 5 	or Subject eq 100 
	   or Subject eq 150	or Subject eq 200;
run;


title "Q2_2";
proc print data = learn.Hosp noobs;
	where Subject in (5,100,150,200);
run;

/**************
 * Question 3
 */

title "Q3_1";
proc print data=learn.Sales noobs;
	where EmpID = '9888' or EmpID = '0177';
run;

title "Q3_2";
proc print data=learn.Sales noobs;
	where EmpID in ('9888','0177');
run;

/*************
 * Question 4
 */
data temp;
	set learn.Sales(keep=Region TotalSales);
	select (Region);
		when ('North')  Weight = 1.5;
		when ('North') Weight = 1.5;
		when ('South') Weight = 1.7;
		when ('West' ,'East') Weight = 2.0;
		otherwise;
	end;
run;

title "Q4";
proc print data= temp noobs;
run;

/******************
 * Question 5
 */

data temp_1;
	set learn.Blood;
	length CholGroup $6;
	select;
		when (missing(Chol)) CholGroup = '';
		when (Chol le 110) CholGroup = 'Low';
		when (Chol le 140) CholGroup = 'Medium';
		otherwise CholGroup = 'High';
	end;
run;
title"Q5";
proc print data=temp_1;
run;
		
		
		
/****************
 * Question 6
 */

title "Q6";
proc print data=learn.Sales;
	where (Region eq "North" and Quantity lt 60 and Quantity is not missing) or
		Customer = "Pet's are Us";
run;
	
/********************
 * Question 7
 */
		
title "Q7";
proc print data= learn.bicycles;
	where Model eq "Road Bike" and UnitCost gt 2500 or 
	      Model eq "Hybrid"    and UnitCost gt 660;
run;
		
		
		
		
		
		
		
		
		








