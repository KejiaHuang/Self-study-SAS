/************
 * format
 */

proc format;
	value $yesno 	'Y','1' = 'Yes'
			'N','0' = 'No'
			' '	= 'Not Given';
	value $size   	'S'	= 'Small'
			'M' 	= 'Medium'
			'L'	= 'Large'
			' '     = 'Missing';
	value $gender	'F' = 'Female'
			'M'	    = 'Male'
			' '	    = 'Not Given';
run;

/************
 * Q1
 */
proc tabulate data=learn.college;
	class Gender Scholarship SchoolSize;
	table (Gender Scholarship ALL), SchoolSize*n='';
	format 	Gender $gender.
		Scholarship $yesno.
		SchoolSize $size.;
run;

/************
 * Q2
 */
proc tabulate data=learn.college;
	class Gender Scholarship SchoolSize;
	table SchoolSize ALL , (Gender  Scholarship ALL)*n='';
	format 	Gender $gender.
		Scholarship $yesno.
		SchoolSize $size.;
	keylabel ALL = 'Total';
run;
	

/**************
 * Q3
 */

proc tabulate data=learn.college;
	class Gender Scholarship SchoolSize;
	table (Gender ALL) *(Scholarship ALL) , SchoolSize*n='' ALL;
	format 	Gender $gender.
		Scholarship $yesno.
		SchoolSize $size.;
	keylabel ALL = 'Total';
run;

/***************
 * Q4
 */

proc format;
	value Rank
		low-70 = 'Low to 70'
		71-high = '71 to higher';
	value $gender	'F' = 'Female'
			'M'	    = 'Male';
run;

proc tabulate data=learn.college;
	class Scholarship Gender ClassRank;
	table (Scholarship ALL) , (ClassRank) *(Gender ALL)/RTS=15;
	format 	Scholarship $yesno.
		ClassRank Rank.
		Gender $gender.;
	keylabel n=' ' 
			ALL = 'Total';
run;
/*********
 * Q5
 */


proc tabulate data=learn.college format=4.1;
	class Gender;
	var GPA;
	table GPA*(n mean min max),Gender ALL;
	format Gender $gender.;
	keylabel 	n 	= 'Number'
			mean	= 'Average'
			min	= 'Minimun'
			max 	= 'Maximum'
			all 	= 'Total';
			
run;

/**********
 * Q6
 */

proc tabulate data=learn.college format=6.1;
	class Gender;
	var GPA ClassRank;
	table (GPA*(n*f= 4. mean*f= 4.1) ClassRank*(n*f= 4.  mean*f= 4.1)),Gender ALL;
	keylabel 	ALL  = 'Total'
			n    = 'Number'
			mean = 'Average';
	label ClassRank = 'Class Rank';
run;

/***********
 * Q7
 */
proc tabulate data=learn.college noseps format =6.1;
	class SchoolSize;
	var GPA ClassRank;
	format 	SchoolSize $size.;
	table (SchoolSize ALL),(GPA*(median min max) ClassRank*(median*f=4. min*f=4. max*f=4.));
	keylabel 	ALL = 'Total'
			median = 'Median'
			min = 'Minimum'
			max = 'Maximum';
	
	label 	SchoolSize = 'School Size'
		ClassRank = 'Class Rank';
run;
		
/*******************
 * Q8
 */
libname learn "/folders/myfolders/learning";
proc tabulate data=learn.college noseps format = 6.;
	class Gender Scholarship;
	tables (Gender ALL) , (Scholarship*rowpctn ALL*rowpctn);
	keylabel rowpctn= "Percent";
	format 	Gender $gender.
		Scholarship $yesno.;
run;
	
/****************
 * Q9
 */
proc tabulate data=learn.college noseps format = 6. order=data;
	class Gender Scholarship;
	table (Gender ALL),(Scholarship*colpctn ALL*colpctn);
	keylabel colpctn="Percent"
		 ALL = "Total";
	format Gender $gender.
		Scholarship $yesno.;
run;
	
/******************
 * Q10
 */

proc tabulate data=learn.Sales noseps format = 6.;
	class Region;
	var Quantity TotalSales;
	table (Region ALL), (Quantity*pctsum TotalSales*pctsum);
	keylabel pctsum = 'Percent of Total';
	label TotalSales = 'Total Sales';
run;






















