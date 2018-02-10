/********************
 * Using proc print to list the first four obervations in a data set
 */

title "The first four observations of wage_temporary";
proc print data=wages_temporary(obs=4);
run;


/**************
 * Using the firstobs= and obs options together
 */

title "Obervations 100 through 110 in verybig";
proc print data=project.verybig(firstobs=100 obs=110);
run;

/*****************
 *Using ODS to convert a SAS data set into a CSV file
 */

libname learn "/folders/myfolders/learning";

ods csv file = "/folders/myfolders/learning/chapter6.csv";
proc print data=learn.survery noobs;
run;
ods csv close;