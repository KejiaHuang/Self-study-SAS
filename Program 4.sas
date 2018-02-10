/****
 * Question 1
 */

libname mozart "/folders/myfolders";

data mozart.perm;
	input ID :$3. Gender : $1. DOB : mmddyy10.
		Height Weight;
	label 	DOB ='Date of Birth'
		Height = 'Height in inches'
		Weight = 'Weight in pounds';
	format DOB date9;
datalines;
001 M 10/21/1946 68 150
002 F 5/26/1950 63 122
;

proc  contents data = mozart.perm;
run;

proc print data= mozart.perm;
run;

		