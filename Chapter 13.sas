/***************
 *  Converting values of 999 to a SAS missing value using arrays
 */
libname learn "/folders/myfolders/learning";
data new;
	set learn.SPSS;
	array myvars {3} Height Weight Age;
	do i=1 to 3;
		if myvars{i} = 999 then myvars{i}=.;
	end;
	drop i;
run;
proc print data= new;
run;

/*******************************
 * Using call missing and arrays
 */

data new_1;
	set learn.SPSS;
	array myvars {3} Height Weight Age;
	do i=1 to 3;
		if myvars{i} = 999 then call missing(myvars{i});
	end;
	drop i;
run;
proc print data= new_1;
run;


/***************************
 * Converting values of NA and ? to missing character values
 */
proc print data=learn.chars;
run;
data missing;
	set learn.chars;
	array char_vars{*} $ _CHARACTER_;
	do loop = 1 to dim(char_vars);
		if char_vars(loop) in ('NA','?') then
			call missing(char_vars(loop));
	end;
	drop loop;
run;

proc print data=missing;
run;
	
/*******************
 * converting all chars values to lowercase
 */

data lower;
	set learn.careless;
	array all_chars{*} _CHARACTER_;
	do loop =1 to dim(all_chars);
		all_chars{loop} = lowcase(all_chars{loop});
	end;
	drop loop;
run;
proc print data=lower;
run;
	
/************************
 * Using an array to create new variables
 */
	
data temp;
	input Fahren1-Fahren24 @@;
	array Fahren[24];
	array Celsius[24] Celsius1-Celsius24;
	do hour =1 to 24;
		Celsius[hour] = (Fahren[hour]-32)/1.8;
	end;
	drop Hour;
datalines;
35 37 40 42 44 48 55 59 62 62 64 66 68 70 72 75 75 72 66 55 53 52 50 45
;
proc print data=temp;
run;
	
	
/*********************************
 * Changing the array bounds
 */

data account;
	input ID Income1999-Income2006;
	array income[1999:2006] Income1999-Income2006;
	array taxed[1999:2006] Taxes1999-Taxes2006;
	do Year = 1999 to 2006;
		Taxed[Year] = .25*Income[Year];
	end;
	drop Year;
	format 	Income1999-Income2006
		Taxes1999-Taxes2006 dollar10.;
datalines;
001 45000 47000 47500 48000 48000 52000 53000 55000
002 67130 68000 72000 70000 65000 52000 49000 40100
;
proc print data=account;
run;
	
/*********************
 * Using a temporary array to score a test
 */

data socre;
	array ans[10] $ 1;
	array key{10} $ 1 _TEMPORARY_
	('A','B','C','D','E','E','D','C','B','A');
	input ID (Ans1-Ans10) ($1.);
	RawScore = 0;
	do Ques = 1 to 10;
		RawScore + (key(Ques) eq Ans(Ques));
	end;
	Percent = 100*RawScore/10;
	keep ID RawScore Percent;
datalines;
123 ABCDEDDDCA
126 ABCDEEDCBA
129 DBCBCEDDEB
;
proc print data= socre;
run;

/**********************
 * Loading the initial values of a temporary array from a raw data file
 */

data socre_1;
	array ans[10] $ 1 ;
	array key[10] $ 1 _temporary_;
	if _n_ =1 then do Ques =1 to 10;
		input key[Ques] $1. @;
	end;
	input ID (Ans1-Ans10) ($1.);
	RawScore = 0;
	do Ques = 1 to 10;
		RawScore + (key(Ques) eq Ans(Ques));
	end;
	Percent = 100*RawScore/10;
	keep ID RawScore Percent;
datalines;
ABCDEEDCBA
123 ABCDEDDDCA
126 ABCDEEDCBA
129 DBCBCEDDEB
;
proc print data= socre_1;
run;

	
/************************
 * Loading a two-dimensional, temporary array with data values
 */
proc print data= learn.expose;
run;
data look_up;
	array level[1944:1949,5] _TEMPORARY_;
	if _n_ =1 then 
	do Year = 1944 to 1949;
		do Job =1 to 5;
			input level[Year,Job] @;
		end;
	end;
	
	set learn.expose;
	Job = input(translate(Jobcode,'12345','ABCDE'),1.);
	Benzene = level[Year,Job];
	drop Job;
datalines;
220 180 210 110 90
202 170 208 100 85
150 110 150 60 50
105 56 88 40 30
60 30 40 20 10 
45 22 22 10 8
;
proc print data=look_up;
run;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	