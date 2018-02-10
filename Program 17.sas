/************
 * Q1
 */

proc freq data=learn.Blood;
	tables Gender BloodType AgeGroup /nocum nopercent;
run;

/****************
 * Q2
 */
proc format;	
	value agedis
		low-<40  = 'young'
		41-<60   = 'mid'
		61-high = 'high';
run;
proc freq data=learn.bloodpressure;
	tables Age / nocum nopercent;
	format Age agedis.;
run;

/***************
 * Q3
 */

proc format;
	value dis
		low-<200 = 'normal'
		201-high = 'high'
		.        = 'missing'
run;

proc freq data= learn.blood;
	tables Chol  / missing;
	format Chol dis.;
run;
proc freq data= learn.blood;
	tables Chol  ;
	format Chol dis.;
run;

/***************
 * Q4
 */

proc freq data=learn.VOTOR;
	tables Party * (Ques1-Ques4);
run;

/*********
 * Q5
 */

proc format;
	value rank
		low-70  = 'Lower'
		71-high = 'Higher';
run;
proc freq data=learn.College;
	tables Scholarship * ClassRank;
	format ClassRank rank.;
run;

/*******************
 * Q6
 */
proc freq data = learn.College;
	tables Gender * Scholarship * SchoolSize;
run;

/**********************
 * Q7
 */

proc freq data=learn.Blood order = freq;
	tables BloodType;
run;













