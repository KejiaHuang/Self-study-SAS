/******************
 * Q1
 */

data vitals;
	input 	ID :$3.
		Age
		Pulse
		SBP
		DBP;
	label 	SBP = "Systolic Blood Pressure"
		DBP = "Diastolic Blood Pressure";
	if Age lt 50 then do;
		if Pulse lt 70 then PulseGroup ='Low';
		else PulseGroup = 'High';
		if SBP lt 130 then SBPGroup = 'Low';
		else SBPGroup = 'High';
	end;
	if Age ge 50 then do;
		if Pulse lt 74 then PulseGroup = 'Low';
		else PulseGroup = 'High';
		if SBP lt 140 then SBPGroup = 'Low';
		else SBPGroup = 'High';
	end;
	
datalines;
001 23 68 120 80
002 55 72 188 96
003 78 82 200 100
004 18 58 110 70
005 43 52 120 82
006 37 74 150 98
007 .  82 140 100
;
 
 
 title "Q1";
 proc print data=vitals;
 run;
 
 /********************
  * Q2
  */
 data monthsales;
 	input month sales @@;
 	SumSales + sales;	
 datalines;
 1 4000 2 5000 3 . 4 5500 5 5000 6 6000 7 6500 8 4500
 9 5100 10 5700 11 6500 12 7500
 ;
 title "Q2";
 proc print data=monthsales;
 run;
 
 
/******************
 * Q3
 */
data test;
	input score1-score3;
	Subj +1 ;
datalines;
90 88 92
75 76 88
72 68 70
;
title "Q3";
proc print data=test;
run;

/************
 * Q4
 */

libname learn "/folders/myfolders/learning";
data count;
	set learn.missing;
	if missing(A) then MissA +1;
	if missing(B) then MissB+1;
	if missing(C) then MissC+1;
run;
title "Q4";
proc print data=count;
run;
	
	
/***********
 * Q5
 */

data log_num;
	do N =1 to 20;
		logN = log(N);
		output;
	end;
run;
title "Q5";
proc print data=log_num;
run;
	

/*************
 * Q6
 */

data log_5;
	do N =5 to 100 by 5;
		logN = log(N);
		output;
	end;
run;
title "Q6";
proc print data=log_5;
run;

/*************
 * Q7
 */

data ploty;
	do x = 0 to 10 by 0.1;
		y = 3*x**2 - 5*x + 10;
		output;
	end;
run;
title "Q7";
proc plot data= ploty;
	plot y*x;
run;
	

/***************
 * Q8
 */

data logplot;
	do p = 0 to 1 by 0.05;
		logit = log(p/(1-p));
		output;
	end;
run;

title "Q8";
proc plot data = logplot;
	plot logit*p;
run;


/****************
 * Q9
 */

data Temperatures;
	do day = 'Mon','Tue','Wed','Thu','Fri','Sat','Sun';
		input Temp @;
		output;
	end;
datalines;
70 72 74 76 77 78 85
;
title "Q9";
proc print data=Temperatures;
run;

/*************
 * Q10
 */

data Speed;
	do Method = 'A','B','C';
		do i = 1 to 10;
			input score @;
			output;
		end;
	end;
datalines;
250 255 256 300 244 268 301 322 256 333
267 275 256 320 250 340 345 290 280 300
350 350 340 290 377 401 380 310 299 399
;
run;
title "Q10";
proc print data=Speed;
run;

/***********************
 * Q11
 */

data temperature;
	do city = 'Dallas', 'Austin';
		do hour = 1 to 24;
			input temp @;
			output;
		end;
	end;
datalines;
80 81 82 83 84 84 87 88 89 89
91 93 93 95 96 97 99 95 92 90 88
86 84 80 78 76 77 78
80 81 82 82 86
88 90 92 92 93 96 94 92 90
88 84 82 78 76 74
;
title "Q11";
proc print data=temperature;
run;

/*****************
 * Q12  compound interest 
 */
title "Q12";
data sum;
	s = 0;
	do year =1 to 999 until(s gt 30000);
		s = (s + 1000)*1.0425;
		output;
	end;
	format s dollar10.;
run;

proc print data=sum;
run;

/***********************
 * Q13
 */

title "Q13";
data money;
	do year = 1 to 999 until( Amount gt 30000);
		Amount + 1000;
		do quarter = 1 to 4;
			Amount + Amount*(0.0425/4);
			output;
			if Amount gt 30000 then leave;
		end;
	end;
run;
proc print data = money;
run;
	
/**********************
 * Q14
 */


title "Q14";
data math;
	do integer = 1 to 1000 until (square gt 100);
		square = integer**2;
		output;
	end;
run;
proc print data= math;
run;







 
 
 
 
 