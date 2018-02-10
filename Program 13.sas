/***********
 * Q1
 */

libname learn "/folders/myfolders/learning";
data Survey1;
	set learn.survey1;
	array Q[5] $ Q1-Q5;
	do i =1 to 5;
		Q[i] = translate(Q[i],'54321','12345');
	end;
	drop i;
run;
title"Q1";
proc print data=Survey1;
run;

/********************
 * Q2
 */

data Survery2;
	set learn.survey1;
	array Q[5] Q1-Q5;
	do i = 1 to 5;
		Q[i] = 6- Q[i];
	end;
	drop i;
run;
title "Q2";
proc print data= Survery2;
run;

/***************
 * Q3
 */

data Nonines;
	set learn.Nines;
	array Num[*] _NUMERIC_;
	do i = 1 to dim(Num);
		if Num[i] eq 999 then call missing(Num[i]);
	end;
	drop i;
run;
title "Q3";
proc print data =learn.nines;
run;
proc print data=Nonines;
run;


/****************************
 * Q4
 */

data Q4;
	set learn.Survey2;
	array Q[5] Q1-Q5;
	ANY5 = "NO";
	do i = 1 to 5;
		if Q[i] eq 5 then do;
			ANY5 = "Yes";
			leave;
			end;
	end;
	drop i;
run;
title "Q4";
proc print data=Q4;
run;

/*****************
 * Q5
 */
data Q5;
	array pass[5] _temporary_
	(65,70,60,62,68);
	input ID $3. Test1-Test5;
	array Test[5] Test1-Test5;
	PassNum = 0;
	do i = 1 to 5;
	 PassNum + (Test[i] ge pass[i]);
	end;
	drop  i;
datalines;
001 90 88 92 95 90
002 64 64 77 72 71
003 68 69 80 75 70
004 88 77 66 77 67
;
run;
title "Q5";
proc print data=Q5;
run;
		

































