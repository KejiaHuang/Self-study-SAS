* Program 2_1;

/**************************************************************
 * comments type I
 * 
 * 
 * 
 **************************************************************/


/***************************************************************\
|     comments type II                                          |
|                                                               |
\***************************************************************/

data mydata;
	infile "/folders/myfolders/learning/mydata.txt";
	input  Gender $ Age /* age is in years */ Height Weight;
run;

title "Frequency on Gender";
proc freq data=mydata;
	table Gender;
run;
	
title "Summary Statistics";
proc means data=mydata;
	var Age Height Weight;
run;