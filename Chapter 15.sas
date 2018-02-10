/*************
 * using proc report 
 */

proc report data=learn.medical nowd;
run;

/************************
 * adding a column statement to proc report
 */


proc report data=learn.medical nowd;
	column Patno DX HR Weight;
run;

/************************************
 * using proc report with only numeric variable
 */

proc report data=learn.medical nowd;
	column HR Weight;
run;


/***********************************
 * using define statement to define a display usage
 */

proc report data=learn.medical nowd;
	column HR Weight;
	define HR / display "Heart Rate" width=5;
	define Weight / display width =6;
run;

/************************************
 * specifying a group usage to create a summary report
 */

proc report data=learn.medical nowd;
	column Clinic HR Weight;
	define Clinic / group width=11;
	define HR / analysis mean "Average Heart Rate" width=12
			format = 5.;
	define Weight / analysis mean "Average Weigth" width=12
			format = 6.;
run;

/*************************************
 * demonstrating the flow option with proc report
 */

proc report data = learn.medical nowd headline
		split = ' ' ls=74;
	column Patno VisitDate DX HR Weight Comment;
	define Patno / "Patient Number" width = 7;
	define VisitDate / "Visit Date" width = 9 format = date9.;
	define Dx / "DX Code" width = 4 right;
	define Weight / width =6;
	define Comment / width=30 flow;
run;

/*****************************
 * demonstrating the effect of two variables with group usage
 */

proc report data=learn.bicycles nowd headline ls = 80;
	column Country Model Units TotalSales;
	define Country / group width = 14;
	define Model / group width = 13;
	define Units / sum "Number of Units" width=8
			format = comma8.;
	define TotalSales / sum "Total Sales (in thousands)"
			width = 15 format= dollar10.;
run;

/*******************************
 * Creating a multi-column report
 */
proc report data=learn.assign nowd panels=99
		headline ps =18;
	columns Subject Group;
	define Subject / display width = 7;
	define Group / width = 5;
run;


**************************************/**************************
 * requesting a report break
 */

proc report data=learn.sales  nowd headline;
	column Region Quantity TotalSales;
	define Region / width = 6;
	define Quantity / sum width =8 format =  comma8.;
	define TotalSales / sum "Total Sales" width = 9
				format = dollar9.;
	rbreak after / dol dul summarize;
run;


/**********************
 * Computing a new variable with proc report
 */

proc report data=learn.medical nowd;
	column Patno Weight WtKg;
	define Patno / display "Patient Number" width = 7;
	define Weight / display noprint width = 6;
	define WtKg / computed "Weight in KG" width = 6 format =  6.1;
	compute WtKg;
		WtKg = Weight /2.2;
	endcomp;
run;


/****************************
 * Computing a character variable in a compute block
 */

proc report data=learn.medical nowd;
	column Patno HR Weight Rate;
	define Patno / display "Patient Number" width = 7;
	define HR /display "Heart Rate" width =5;
	define Weight / display noprint width = 6;
	define Rate / computed width = 6;
	compute Rate / character length=6;
		if HR gt 75 then Rate = 'Fast';
		else if HR gt 55 then Rate = 'Normal';
		else if not missing(HR) then Rate = 'Slow';
	endcomp;
	
run;


/********************
 * across usage in proc report
 */

proc report data= learn.bicycles nowd headline ls=80;
	column Model, Units Country;
	define Country /group width = 14;
	define Model / across "Model";
	define Units / sum "# of Units" width=14
			format= comma8.;
run;
















