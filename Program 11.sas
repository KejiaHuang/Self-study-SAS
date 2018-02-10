/**************
 * Q1
 */
libname learn "/folders/myfolders/learning";
data health;
	set learn.health;
	BMI = (Weight/2.2)/((Height*0.0254)**2);
	BMIRound = round(BMI);
	BMITenth = round(BMI,0.1);
	BMIGroup = round(BMI,5);
	BMITrunc = int(BMI);
run;
title"Q1";
proc print data=health;
run;

/******************
 * Q2
 */
data missBlood;
	set learn.blood;
	if missing(WBC) then MissingWBC +1;
	if missing(RBC) then MissingRBC +1;
	if missing(Chol) then MissingChol +1;
run;
title "Q2";
proc print data=missBlood(obs=10);
run;

/******************
 * Q3
 */

data Miss_Blood;
	set learn.Blood;
	if missing(WBC) then call missing(RBC,Gender,Chol);
run;
title "Q3";
proc print data=Miss_Blood(obs=10);
run;

/**************
 * Q4
 */

title"Q4";
proc print data=learn.Psych noobs;
run;
data Evaluate;
	set learn.Psych;
	if n(of Ques1-Ques10) >7 then QuesAve = mean(of Ques1-Ques10);
	if nmiss(of Score1-Score5) eq 0 then do;
		MinScore = min(of Score1-Score5);
		MaxScore = max(of Score1-Score5);
		SecondHighest = largest(2,of Score1-Score5);
	end;
run;
title "Q4";
proc print data=Evaluate(obs=10);
run;


/************
 * Q5
 */

data Evaluate_5;
	set learn.psych;
	if n(of Score1-Score5) gt 3 then 
		ScoreAve = mean(	largest(1,of Score1-Score5),
					largest(2,of Score1-Score5),
					largest(3,of Score1-Score5));
	if n(of Ques1-Ques10) ge 7 then QuesAve = mean(of Ques1-Ques10);
	Composit = ScoreAve + 10* QuesAve;
	keep ID ScoreAve QuesAve Composit;
run;
title"Q5";
proc print data=Evaluate_5;
run;

/****************
 * Q6
 */
title "Q6";
data _NULL_;
	int3 = constant("exactint",3);
	int4 = constant("exactint",4);
	int5 = constant("exactint",5);
	int6 = constant("exactint",6);
	int7 = constant("exactint",7);
	file print;
	put	"Largest integer in 3 bytes is" int3 comma18.0/
		"Largest integer in 4 bytes is" int4 comma18.0/
		"Largest integer in 5 bytes is" int5 comma18.0/
		"Largest integer in 6 bytes is" int6 comma18.0/
		"Largest integer in 7 bytes is" int7 comma18.0/;
	run;
	
/**************
 * Q7
 */

title"Q7";
data _NULL_;
	x=10; y=20; z=-30;
	AbsZ = abs(z);
	Expx = round(exp(x),.001);
	Circumference = round(2*constant("pi")*y,.001);
	file print;
	put _all_;
	/*put 	"AbsZ=" AbsZ comma18.0/
		"Expx=" Expx comma18.0/
		"Circmuference=" Circumference comma18.0/;   */
run;

/********************
 * Q8
 */
title"Q8";

data Random;
	do n = 1 to 1000;
		ran = int(5*ranuni(0)+1);
		output;
	end;
run;
proc freq data=Random;
	tables ran;
run;

/*************
 * Q9
 */

data Fake;
	do Sujb = 1 to 100;
		if ranuni(0) le .4 then Gender = "Female";
		else Gender = "Male";
		Age = int(40*ranuni(0)+1);
		output;
	end;
title "Q9";
proc freq data= Fake;
	tables Gender;
run;
proc print data=Fake(obs=10);
run;

/***************
 * Q10
 */

title "Q10";
data Convert;
	set learn.Char_Num;
	NumAge 	  = input(Age,8.); 
	NumWeight = input(Weight,8.);
	CharSS    = put(SS,ssn11.);
	CharZip   = put(ZIp,z5.);
run;
proc print data=Convert;
run;

/**********************
 * Q11
 */
title "Q11";
data Convert_1;
	set learn.Char_Num(
				rename=(Age    = Char_Age
					Weight = Char_Weight
					SS     = Num_SS
					Zip    = Num_Zip));
	Age 	  = input(Char_Age,8.); 
	Weight = input(Char_Weight,8.);
	SS    = put(Num_SS,ssn11.);
	Zip   = put(Num_Zip,z5.);
	drop Char_Age Char_Weight Num_SS Num_Zip;
run;
proc print data=Convert_1;
run;

/******************************
 * Q12
 */
title"Q12";
Data diff;
	set learn.Stocks;
	DailyChanges = Dif(Price);
run;
proc plot data=diff;
	plot DailyChanges*Date;
run;


/**********************
 * Q13 
 */

data plot13;
	set learn.Stocks;
	Price1 = lag(Price);
	Price2 = lag2(Price);
	Ave = mean(Price , Price1, Price2);
run;
title"Q13";
proc plot data=plot13;
	plot Ave*Date;
run;





























































