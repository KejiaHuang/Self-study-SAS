/*****************
 * proc tabulate with all the defaults and a single class variable
 */

proc tabulate data=learn.blood;	
	class Gender;
	table Gender;
run;

/****************
 * concatenation with proc tabulate
 */

proc tabulate data=learn.blood format = 6.;
	class Gender BloodType;
	table Gender BloodType;
run;

/******************
 * demonstrating table dimensions with proc tabulate
 */

proc tabulate data = learn.blood format = 6.;
	class Gender BloodType;
	table Gender,
	      BloodType;
run;

/**********************
 * demonstrating the nesting operator with PROC TABULATE
 */

proc tabulate data = learn.blood format= 6.;
	class Gender BloodType;
	table Gender * BloodType;
run;

/************************
 * Adding the keyword ALL to your table request
 */

proc tabulate data = learn.blood format = 6.;
	class Gender BloodType;
	table Gender ALL,
	      BloodType All;
run;

/***********************
 * Using PROC TABULATE to produce descriptive statistic
 */

proc tabulate data=learn.blood;
	var RBC WBC;
	table RBC WBC;
run;

/*****************
 * Specifying statistics on an analysis variable with PROC TABULATE
 */

proc tabulate data=learn.blood;
	var RBC WBC;
	table RBC*mean WBC*mean;
run;

/*************
 * Specifying more than one descriptive statistic with PROC TABULATE
 */

proc tabulate data = learn.blood format = comma9.2;
	var RBC WBC;
	table (RBC WBC) * (mean min max);
run;

/*************
 * Combining CLASS and analysis variables in a table
 */

proc tabulate data=learn.blood format=comma11.2;
	class Gender AgeGroup;
	var RBC WBC Chol;
	table (Gender ALL)*(AgeGroup ALL),
		(RBC WBC Chol)*mean;
run;

/****************
 * Associating a different format with each variable in a table
 */

proc tabulate data=learn.blood;
	var RBC WBC;
	table RBC*mean*f=7.2 WBC*mean*f=comma7.;
run;

/*****************
 * Renaming keywords with PROC TABULATE
 */

proc tabulate data=learn.blood;
	class Gender;
	var RBC WBC;
	table 	Gender ALL,
		RBC*(mean*f=9.1 std*f=9.2)
		WBC*(mean*f=comma9. std*f=comma9.1);
	keylabel 	ALL = 'Total'
			mean = 'Average'
			std = 'Standard Deviation';
run;


/*****************
 * Eliminating the N column in a PROC TABULATE table
 */

proc tabulate data=learn.blood format=6.;
	class Gender;
	table Gender;
run;
proc tabulate data=learn.blood format=6.;
	class Gender;
	table Gender*n='';
run;

/**********
 * Demonstrating a more complex table
 */

proc tabulate data=learn.blood format=comma9.2 noseps;
	class Gender AgeGroup;
	var RBC WBC Chol;
	table 	(Gender='' ALL)*(AgeGroup='' ALL),
		RBC*(n*f=3. mean*f=5.1)
		WBC*(n*f=3. mean*f=comma7.)
		Chol*(n*f=4. mean*f=7.1);
	keylabel ALL = 'Total';
run;

/*********
 * computing percentages in a one-dimensional table
 */
proc tabulate data=learn.blood format =6.;
	class BloodType;
	table BloodType*(n pctn);
run;

/***********
 * Improving the appearance of output 
 */
proc format;
	picture pctfmt low-high = "009.9%";
run;
proc tabulate data=learn.blood;
	class BloodType;
	table (BloodType All) * (n*f=5. pctn*f=pctfmt7.1);
	keylabel n	= 'Count'
		 pctn	= 'Percent';
run;

/***********
 * Counts and percentage in a two-dimensional table
 */

proc format;
	picture pctfmt low-high='009.9%';
run;
proc tabulate data=learn.blood noseps;
	class Gender BloodType;
	table 	(BloodType ALL),
		(Gender ALL) * (n*f = 5. pctn*f=pctfmt7.1) / RTS = 25;
	keylabel ALL  = 'Both Genders'
		 n    = 'Count'
		 pctn = 'Percent';
run;


/*************
 * using COLPCTN to compute column percentages
 */
proc tabulate data=learn.blood noseps;
	class Gender BloodType;
	table (BloodType All = 'ALL Blood Types'),
	      (Gender ALL)*(n*f=5. colpctn*f=pctfmt7.1)/RTS=25;
	keylabel ALL 	= 'Both Genders'
		 n      = 'Count'
		 colpctn= 'Percent';
run;

/**************
 * Computing percentage on a numeric value
 */

proc tabulate data=learn.sales;
	class Region;
	var TotalSales;
	table (Region ALL),
		TotalSales*(n*f=6. sum*f=dollar8.
			    pctsum*f=pctfmt7.);
	keylabel ALL  	= "All Regions"
		 n    	= "Number of Sales"
		 sum  	= "Average"
		 pctsum = "Percent";
	label TotalSales = 'Total Sales';
run;
 
/**************
 * Demonstrating the effect of missing values on CLASS variables
 */
proc print data=learn.missing;
run;
proc tabulate data=learn.missing format=4.;
	class A B;
	table (A ALL), (B ALL);
run;

proc tabulate data=learn.missing format=4.;
	class A B C;
	table A ALL, B ALL;
run;
proc tabulate data=learn.missing format=4. missing;
	class A B;
	table A ALL, B ALL/misstext='no data';
run;




























