/*****************
* Reset graph option
*/
goptions 	reset  = all
			ftext  = 'arial'
			htext  = 1.0
			ftitle = 'arial/bo'
			htitle = 1.5
			colors = (black)
			vsize  = 4;

/*********
* Producing a simple bar chart using PROC GCHART
*/
libname learn 'D:/sasfile/learning';
title "Distribution of Blood Types";
pattern value = empty;
title1 'vertical bar chart';
proc gchart data=learn.blood;
	vbar BloodType;
run;
quit;
title1 'horizontal bar chart';
proc gchart data=learn.blood;
	hbar BloodType;
run;
quit;
title1 '3-d  vertical bar chart';
proc gchart data=learn.blood;
	vbar3d BloodType;
run;
quit;
title1 '3-d horizontal bar chart';
proc gchart data=learn.blood;
	hbar3d BloodType;
run;
quit;
title1 'pie chart';
proc gchart data=learn.blood;
	pie BloodType;
run;
quit;
title1 '3-d pie chart';
proc gchart data=learn.blood;
	pie3d BloodType;
run;
quit;
title1 'donut chart';
proc gchart data=learn.blood;
	donut BloodType;
run;
quit;
title1 'star chart';
proc gchart data=learn.blood;
	star BloodType;
run;
quit;
/*************
* creating pie charts
*/

title 'Creating a Pie Chart';
pattern value = pempty;
proc gchart data = learn.blood;
	pie BloodType / noheading;
run;
quit;

/**********
* Creating a bar chart for a continuous variable
*/

pattern value = empty;
proc gchart data = learn.blood;
	vbar WBC;
run;
/*****************
* Selecting your own midpoints for the chart
*/
pattern value=L2;
title "Distribution of WBC's";
proc gchart data = learn.blood;
	vbar WBC / midpoints = 4000 to 11000 by 1000;
	format WBC comma6.;
run;
/*************
* Demonstrating the need for the DISCRETE option of PROC GCHART
*/
data day_of_week;
	set learn.dailyprices;
	Day = weekday(Date);
run;
title 'Visits by Day of Week';
pattern value = R1;
proc gchart data = day_of_week;
	vbar Day / discrete;
run;
/***************
* Creating a bar chart where the height of the bars represents sums
*/
title 'Total Sales by Region';
pattern1 value = L1;
axis1 order = ('North' 'South' 'East' 'West');
proc gchart data= learn.sales;
	vbar Region / 	sumvar = TotalSales
					type = sum
					maxis = axis1;
	format TotalSales dollar8.;
run;
quit;
/*********************
* Creating a bar chart where the height of the bars represents means
*/

title 'average cholesterol by Gender';
pattern1 value = L1;
proc gchart data=learn.blood;
	vbar Gender / 	sumvar = Chol
					type   = mean;
run;
quit;
/***********
* Adding another variable to the chart
*/
title 'Average Choeterol by Gender';
pattern1 value = L1;
proc gchart data = learn.blood;
	vbar Gender / 	sumvar = Chol
					type   = mean
					group  = BloodType;
run;
quit;
/******************
* Demonstrating the subgroup = option
*/
title 'Average Cholesterol by Gender';
pattern1 value = L1;
pattern2 value = R3;
proc gchart data=learn.blood;
	vbar BloodType 	/ subgroup = Gender;
	run;
quit;
/************************
* Creating a simple scatter plot using all the defaults
*/
title 'Scatter plot of SBP by DBP';
proc gplot data=learn.clinic;
	plot SBP * DBP;
run;
/*******************
* Changing the plotting symbol and controlling the axis ranges
*/
title 'Scatter plot of SBP by DBP';
symbol value = dot;
proc gplot data=learn.clinic;
	plot SBP * DBP / 	haxis =  70 to 120 by 5
						vaxis =  100 to 220 by 10;
run;
/**********************
* joining the points with straight lines
*/
title 'Scatter Plot of SBP by DBP';
title h = 1.2 'Interpolation Methods';
proc sort data=learn.clinic out = clinic;
	by DBP;
run;
symbol value = dot interpol = join width=2;
proc gplot data=clinic;
	plot SBP * DBP;
run;
/********************
* Drawing a smooth line through your data points
*/
title 'Scatter Plot of SBP by DBP';
title2 h=1.2 "interprelation methods";
symbol value = dot interpol = sms line = 1 width = 2;
proc gplot data=learn.clinic;
	plot SBP * DBP;
run;


















