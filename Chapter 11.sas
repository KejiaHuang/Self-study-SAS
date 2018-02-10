/**********************************
 * Round and Int truncation functions
 */

data truncate;
	input Age Weight;
	Age = int(Age);
	WtKg = round(2.2*Weight,.1);
	Weight=round(Weight);
datalines;
18.8 100.7
25.12 122.4
64.99 188
;
proc print data=truncate;
run;

/***************
 * Missing function
 */
libname learn "/folders/myfolders/learning";
data test_miss;
	set learn.blood;
	if missing(Gender) then MissGender +1 ;
	if missing(WBC) then MissWBC +1;
	if missing(RBC) then MissRBC +1;
	if Chol lt 200 and not missing(Chol) then
		Level = "Low";
	else if Chol ge 200 then Level = "High";
run;
proc print data=test_miss(obs=5);
run;
	
/*********************
 * N MEAN MIN MAX
 */

data psych;
	input ID $ Q1-Q10;
	if n(of Q1-Q10) ge 7 then Score = mean(of Q1-Q10);
	MaxScore = max(of Q1-Q10);
	MinScore = min(of Q1-Q10);
datalines;
001 4 1 3 9 1 2 3 5 . 3
002 3 5 4 2 . . . 2 4 .
003 9 8 7 6 5 4 3 2 1 5
;
proc print data=psych;
run;
		
/**********************
 * sum of the three largest values
 */
		
data three_large;
	set psych(keep = ID Q1-Q10);
	SumThree = sum( largest(1,of Q1-Q10),
			largest(2, of Q1-Q10),
			largest(3, of Q1-Q10));
run;
proc print data=three_large;
run;

/**************
 * sum function
 */
data sum;
	set learn.EndOfYear;
	Total = sum(0, of Pay1-Pay12, of Extra1-Extra12);
run;
proc print data=sum;
run;

/***************
 * ABS SQRT EXP LOG 
 */

data math;
	input x @@;
	Absolute = abs(x);
	Square = sqrt(x);
	Exponent = exp(x);
	Natural = log(x);
datalines;
2 -2 10 100
;
proc print data=math;
run;
		
/*******************
 * constant
 */
	
data constance;
	Pi 	= constant("pi");
	e	= constant("e");
	Integer1= constant("exactint",1); 
	Integer2= constant("exactint",2);
	Integer3= constant("exactint",3);
	Integer4= constant("exactint",4);
	Integer5= constant("exactint",5);
	Integer6= constant("exactint",6);
	Integer7= constant("exactint",7);
	Integer8= constant("exactint",8);
run;
proc print data= constance;
run;		
		
/****************
 * ranuni function
 */
		
data subset;
	set learn.blood;
	if ranuni(1345453) le .1;
run;
proc print data=subset(obs=10);
run;
		
		
/*********************
 * proc surveyselect
 */
		
proc surveyselect 	data=learn.blood
			out=subset
			method=srs
			sampsize=100;
run;
		
proc print data=subset(obs = 10);
run;
		
/***************************
 * input
 */
data nums;
	set learn.chars(rename=(
			Height= Char_Height
			Weight= Char_Weight
			Date  = Char_Date));
	Height = input(Char_Height,8.);
	Weight = input(Char_Weight,8.);
	Date   = input(Char_Date,mmddyy10.);
	format Date mmddyy10.;
	drop Char_Height Char_Weight Char_Date;
run;
proc print data=nums;
run;
	
	
/**********************
 * put function
 */

proc format;
	values agefmt  	low-<20 = "Group one"
			20-<40  = "Group two"
			40-high = "Group three";
run;

data convert;
	set learn.numeric;
	Char_Date = put(Date,date9.);
	AgeGroup  = put(Age,agefmt.);
	Char_Cost = put(Cost,dollar10.);
	drop Date Cost;
run;
proc print data= convert(obs=10);
run;
	
/******************
 * lag lagn
 */

data look_back;
	input Time Temperature;
	Prev_temp = lag(Temperature);
	Two_back = lag2(Temperature);
datalines;
1 60
2 62
3 65
4 70
;
proc print data=look_back(obs=10);
run;
	
/**********************
 * Lag function conditionally
 */

data laggard;
	input x @@;
	if X ge 5 then Last_x = lag(x);
datalines;
9 8 7 1 2 12
;
proc print data=laggard;
run;
	
/*******************
 * Using lag function to compute interobservation differences
 */

data diff;
	input Time Temperature;
	Diff_temp = Temperature - lag(Temperature);
datalines;
1 60
2 62
3 65
4 70
 ;
 proc print data=diff;
 run;
 
 /******************
  * Dif function
  */

data diff;
	input Time Temperature;
	Diff_temp = dif(Temperature);
datalines;
1 60 
2 61
3 63
4 66
5 70
;
proc print data=diff;
run;





	
	
	
	
	
	
	
	
	
	
	
	
	
	
	