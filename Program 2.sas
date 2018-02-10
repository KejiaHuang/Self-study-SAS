/******
 * Question 1
 */

data Portfolio;
	infile "/folders/myfolders/learning/stocks.txt";
	input 	symbol $ price shares;
		Value = price * shares; 
run;
title "Answer of question 1";
proc print data = portfolio noobs;
run;
proc means data= Portfolio;
	var price shares;
run;

/***************
 * Question 2
 */

data prob2; 
	input 	ID $
		Height
		Weight
		SBP
		DBP;
		WtKg 		= Weight/2.2;
		HtCm 		= 2.54*Height;
		AveBP		= DBP + 1/3*(SBP-DBP);
		HtPloynomial 	= 2*Height**2 + 1.5*Height**3;
	
		
datalines;
001 68 150 110 70
002 73 240 150 90
003 62 101 120 80
;
title "listing of probs";
proc print data=prob2;
run;





