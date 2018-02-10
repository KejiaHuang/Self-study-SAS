/**********
 * Program 4_1
 * Creating a permanent SAS data set
 */


libname mozart "/folders/myfolders/learning";

data mozart.test_scores;
	length ID $3 Name $ 15;
	input ID $ Score1-Score3 Name $;
datalines;
1 97 95 98 a
2 78 77 75 b
3 88 91 92 c
;

title "The Desciptor Portion of data set";
proc contents data=mozart.test_scores varnum;
run;

/****/

title"listing of test_scores";
proc print data=mozart.test_scores;
run;

data new;
	set mozart.test_scores;
	AveScore = mean(of score1-score3);
run;
title"listing of data set NEW";
proc print data=new noobs;
	var ID Score1-Score3 AveScore;
run;


/***/
data _null_;
	set mozart.test_scores;
	if Score1 ge 95 or Score2 ge 95 or Score3 ge 95 then
		put ID= Score1= Score2= Score3=;
run;
	
	