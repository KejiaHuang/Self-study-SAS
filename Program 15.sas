/******************
 * Q1
 */

title "First 5 observation from Blood Data Set";
libname learn "/folders/myfolders/learning";
proc report data= learn.Blood(obs=5) headline;
	column Subject WBC RBC;
	define Subject / display "Subject Number";
	define WBC / display "White Blood Cells";
	define RBC / display "Red Blood Cells";
run;

/***********************
 * Q2
 */

title "Statistics from Blood by Gender";

proc report data= learn.blood headline;
	column Gender WBC RBC;
	define Gender / analysis group;
	define WBC / analysis mean "AverageWBC" format = comma6.0;
	define RBC / analysis mean "AgerageRBC" format = comma6.2;
	rbreak after / dol dul summarize;
run;
	
	
/****************************
 * Q3
 */

title "Hypertensive Patients";

proc report data= learn.BloodPressure headline;
	column Gender SBP DBP Hy;
	define Gender / group ;
	define SBP / display;
	define DBP /display;
	define Hy/ computed "Hypertensive?";
	compute Hy / character;
		if Gender eq "F" and (SBP gt 138 or DBP gt 88) then Hy = "Yes";
			else  Hy = "No";
		if Gender eq "M" and( SBP gt 140 or DBP gt 90 ) then Hy = "Yes";
			else  Hy = "No";
	endcomp;
run;
		
	
/*****************
 * Q5
 */
	
title "Patient Age Groups";
proc report data= learn.BloodPressure headline;
	column Gender Age AgeGroup;
	define Gender / display;
	define Age/ display;
	define AgeGroup / computed;
	compute AgeGroup / character;
		if Age le 50 then AgeGroup = "<=50";
		else AgeGroup = ">50";
	endcomp;
run;
	
/************************
 * Q6
 */

title "Subject's in Gender and Age Order";
proc report data = learn.BloodPressure headline;	
	column Gender Age SBP DBP;
	define Gender / Group width = 6;
	define Age / display width =4;
	define SBP / display "Systolic Blood Pressure" width = 9;
	define DBP / display "Diastolic Blood Pressure" width = 9;
run;
	
		
/********************************
 * Q7
 */

title "Mean Cholesterol by Gender and Blood Type";
proc report data = learn.Blood;
	column Gender BloodType Chol;
	define Gender / group;
	define BloodType / group;
	define Chol / analysis mean "Mean Cholesterol" format = 6.1;
run;

	
/************************************
 * Q8
 */

title "Average Blood Counts by Gender";
proc report data= learn.Blood headline nowd;
	column BloodType Gender, WBC Gender,RBC;
	define BloodType /Group;
	define Gender / across "-Gender-";
	define WBC / analysis mean format = comma8.;
	define RBC / analysis mean format = 8.2;
	
run;

/*******************************
 * Q9
 */

title "Report on the Survey Data Set";
proc report data= learn.Survey;
	column ID Age Gender Salary Ques1-Ques5  av;
	define ID / display;
	define Age / display "Age";
	define Gender/ display;
	define Salary / display format = dollar10.;
	define Ques1 / noprint;
	define Ques2 / noprint;
	define Ques3 / noprint;
	define Ques4 / noprint;
	define Ques5 / noprint;
	define av / computed "Average Response";
	compute av;
		av = mean(of Ques1-Ques5);
	endcomp;
run;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	