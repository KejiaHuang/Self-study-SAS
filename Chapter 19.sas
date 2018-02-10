/*************
 * Sending SAS output to an HTML file
 */
ods html file='d:/sasfile/learning/sample.html';

title "Lising of Test_Scores";
libname learn "d:/sasfile/learning";
proc print data=learn.test_score;
	title2 "Sample of HTML Output - all defaults";
	id ID;
	var Name Score1-Score3;
run;
title "Descriptive Statistics";
proc means data=learn.test_scores n mean min max;
	var Score1-Score3;
run;
ods html close;


/*****************
 * Creating a table of contents for HTML output
 */

ods html body = 'body_sample.html'
	contents='contents_sample.html'
	frame = 'frame_sample.html'
	path = 'd:/sasfile/learning'(url=none);
title 'Using ODS to create a Table of Contents';
proc print data=learn.test_score;
	id ID;
	var Name Score1-Score3;
run;
title "Descriptive Statistics";
proc means data=learn.test_scores n mean min max;
	var Score1-Score3;
run;
ods html close;

/****************
 * Choosing a style for HTML output
 */
ods html file = 'd:/sasfile/learning/styles.html'
		style = FancyPrinter;
title "Listing of Test_score";
proc print data=learn.test_scores;
	id ID;
	var Name Score1-Score3;
run;
ods html close;

/*****************
 * Using an ODS Select statement to restrict PROC UNIVARIATE output
 */
ods trace on;
title "Extreme values of RBC";
proc univariate data=learn.blood;
	id Subject;
	var RBC;
run;
proc print data=learn.blood;
run;
ods trace off;

/********************
* Using ODS to send procedure output to a SAS data set
*/

ods listing close;
ods output ttests=t_test_data;

proc ttest data=learn.blood;
	class Gender;
	var RBC WBC Chol;
run;
ods listing;
title "Listing of T_TEST_DATA";
proc print data=t_test_data;
run;


















