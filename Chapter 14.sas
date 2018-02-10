/******************************
 * using a by statement in proc print 
 */

libname learn "/folders/myfolders/learning";
proc sort data=learn.sales out = sales;
	by Region;
run;

title "Using labels as column headings";
proc print data=sales label;
	by Region;
	id EmpID;
	var TotalSales Quantity;
	label 	EmpID = "Employee ID"
		TotalSales = "Total Sales"
		Quantity = "Number Sold";
	format TotalSales dollar10.2 Quantity comma7.;
run;

/************************
 * adding totals and subtotals to listing
 */

proc sort data=learn.sales out = sales;
	by Region;
run;
title "Adding Totals and Subtotals to listing";
proc print data=sales label n="Total number of obs: ";
	by Region;
	id EmpID;
	var TotalSales Quantity;
	sum Quantity TotalSales;
	label 	EmpID = 'Employee ID'
		TotalSales = 'Total Sales'
		Quantity = 'Number Sold';
	format TotalSales dollar10.2 Quantity comma7.;
run;


/***********************
 * listing the first five obs
 */
proc print data=learn.sales(obs=5) heading= h;
run;













