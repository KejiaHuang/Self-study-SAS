/*************************
 * Q1
 */
title "Q1";
proc print data=learn.blood(obs=10) label noobs;
	laebl 	WBC = "White Blood Cells"
		RBC = "Red Blood Cells"
		Chol = "Cholesterol";
	ID Subject;
	var WBC RBC Chol;
run;

/***************************
 * Q2
 */


title "Q2";
proc sort data= learn.sales;
	by Region;
run;
proc print data=learn.sales;
	by Region;
	id Region;
	sum Quantity TotalSales;
	var Quantity TotalSales;
run;

/***************************
 * Q3
 */

title1 "Selected Patients from HOSP Data Set";
title2 "Admitted in September of 2004";
title3 "Older than 83 years of age";
title3 "----------------------------------------";

proc print data= learn.hosp double label n = "Number of Patients = ";
	label 	AdmitDate = "Admission Date"
		DischrDate = "Discharge Date"
		DOB = "Date of Birth";
run;
		
	
proc print data=learn.hosp;
run;



















