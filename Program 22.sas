/*************
* 	Q1
*/

libname learn "D:/sasfile/learning";
proc format;
	value SBPf	
		low	-	140	 = 'Normal'
		140< -	high = 'High SBP' ;
	value DBPf
		low -	90 	 = 'Normal'
		90< -   high = 'High DBP';
run;

proc freq data = learn.BloodPressure ;
	tables SBP DBP / nucum nopercent;
	format 	SBP SBPf.
			DBP DBPf.;
run;

/*************************
*	Q2
*/

proc format;
	value grades
		low - 65  = 'F'
		65< - 75  = 'C'
		75< - 85  = 'B'
		85< -<100 = 'A';
run;

proc freq data = learn.grades order=formatted;
	tables Grade / nocum nopercent;
	format Grade grades.;
run;

/*******************************
*	Q3
*/ 


libname learn "D:/sasfile/learning";
proc format;
	value SBPf	
		low	-	140	 = 'Normal'
		140< -	high = 'High SBP' ;
	value DBPf
		low -	90 	 = 'Normal'
		90< -   high = 'High DBP';
run;

data bloodQ3;
	set learn.BloodPressure;
	SBPGroup = put(SBP,SBPf.);
	DBPGroup = put(DBP,DBPf.);
run;
proc print data = bloodQ3;
run;

/***********************************
*	Q4
*/

proc format;
	value grades
		low - 65  = 'F'
		65< - 75  = 'C'
		75< - 85  = 'B'
		85< -<100 = 'A';
run;

data G4;
	set learn.grades;
	LetterGrade = put(Grade,grades.);
run;

proc print data = G4;
run;

/********************************
*	Q5
*/
	
proc format;
	invalue $gformt
		low - 65  = 'F'
		65< - 75  = 'C'
		75< - 85  = 'B'
		85< -high  = 'A'
		other     = ' ';
run;

data G5;
	infile 'd:/sasfile/learning/NumGrades.txt';
	input	ID $ LetterG $gformt. @@;
run;	

proc print data = G5;
run;

/**************************
*	Q6
*/

proc format;
	invalue letter(upcase)
		'A'	= 4.5
		'B' = 5.5
		'C' = 3.5
		'X' = .
	  other = _same_;
run;

data Q6;
	input Char : letter. @@;
datalines;
A 6.7 X b c a 10.9 11.6 C
;
run;

proc print data = Q6;
run; 
	
/*****************
*	Q7
*/

proc print data = learn.dxcodes;
run;

data control;
	set learn.dxcodes(rename = (	Dx = Start
									Description = Label   ))
		end = last;
	retain fmtname '$dxcodes' Type 'C';
run;

proc format cntlin = control;
	select $dxcodes;
run;

/**********************
*	Q8
*/	

data control;
	set learn.dxcodes(rename = (	Dx = Start
									Description = Label   ))
		end = last;
	retain fmtname '$dxcodes' Type 'C';
	if last then do;
		Start = '';
		Hlo = 'o';
		Label = 'Not Found';
	end;
run;

proc format cntlin = control;
	select $dxcodes;
run;

/*******************************
*	Q9
*/

proc format;
	value dayss
		'01jan1990'd - '31dec2004'd = 'Too Early'
		'01jan2005'd - '31dec2005'd = [mmddyy10.]
		'01jan2007'd - high         = 'Too Late';
run;


proc print data = learn.gym noobs;
	format Date dayss.;
run;

