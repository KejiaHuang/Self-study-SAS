/************
 * Q1
 */

data score;
	infile "/folders/myfolders/learning/Scores.txt" missover;
	input Score1-Score3;
run;
proc print data=score noobs;
run;

/**************
 * Q2
 */

data score;
	infile "/folders/myfolders/learning/Scores_comma.csv" dsd missover;
	input Score1-Score3;
run;
proc print data=score noobs;
run;


/**********
 * Q3
 */
data score;
	infile "/folders/myfolders/learning/scores_column.txt" pad;
	input		Score1 1-2
			Score2 3-4
			Score3 5-6;
run;
proc print data=score noobs;
run;


/**********
 * Q4
 */
data score;
	infile "/folders/myfolders/learning/scores_column.txt" pad;
	input	@1 	Score1 2.
		@3	Score2 2.
		@5	Score3 2.;
run;
proc print data=score noobs;
run;

/************
 * Q5
 */
libname learn "/folders/myfolders/learning";
proc print data=learn.bicycles;
run;
data _null_;
	set learn.Bicycles END=last;
	TotalUnits + Units;
	Sum_of_Sales + TotalSales;
	if last then 
		put "---------------------------------"/
		    "Total Units Sold is " TotalUnits comma10./ 
		    "Sales Total is "	Sum_of_Sales dollar10.;
run;

/********************
 * Q6
 */

data month;
	infile "/folders/myfolders/learning/Month.txt" missover firstobs=2 obs=5;
	input 	@1 month $3.
		@5 total 4.;
	format total dollar8.;
run;
proc print data=month;
run;

/*****************
 * Q7
 */

data comb;
	infile "/folders/myfolders/learning/file_a.txt" 
		firstobs = 2
		end = last;
	if last then 
		infile "/folders/myfolders/learning/file_b.txt"
		firstobs = 2;
	input x y z;
run;
proc print data=comb;
run;

/***********
 * Q8
 */

data wildcard;
	infile "/folders/myfolders/learning/xyz*.txt";
	input x y z;
run;
proc print data=wildcard;
run;

/*********
 * Q9
 */

data com;
	filename two (	"/folders/myfolders/learning/xyz1.txt"
			"/folders/myfolders/learning/xyz2.txt" );
	infile two;
	input x y z;
run;
proc print data=com;
run;
			
/**********
 * Q10
 */

data 	SALES(keep = Date Amount) 
	INVENTORY(keep = PartNumber Quantity);
	infile "/folders/myfolders/learning/Mixed_Recs.txt";
	input @16 flag 1. @;
	if flag eq 1 then do;
		input 	@1 Date mmddyy10.
			@11 Amount 4.;
		output SALES;
	end;
	else if flag eq 2 then do;
		input 	@1	PartNumber $6.
			@8 	Quantity 3.;
		output INVENTORY;
	end;
	format Date mmddyy10.;
	drop flag;
run;
proc print data=SALES;
run;
proc print data=INVENTORY;
run;
	
/**************
 * Q11
 */

data readmany;
	infile "/folders/myfolders/learning/Three_Per_Line.txt";
	input 	@1 (HR1-HR3) 	($3. +6)
		@4 (SBP1-SBP3)	(3.  +6)
		@7 (DBP1-DBP3)  (3. +6);
run;
proc print data=readmany;
run;












































































