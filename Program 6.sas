/********************
 *  Question 1
 */

/** Import an XLSX file.  **/

PROC IMPORT DATAFILE="/folders/myfolders/learning/drugtest.xls"
		    OUT=WORK.drugtest
		    DBMS=XLS
		    REPLACE;
RUN;

/** Print the results. **/

title "Question 1";
PROC PRINT DATA=WORK.drugtest; RUN;

/************************
 * Question 2
 */

