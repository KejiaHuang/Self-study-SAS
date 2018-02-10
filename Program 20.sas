/********
*Q1
*/
libname learn 'd:/sasfile/learning';
pattern value = empty;
proc gchart data = learn.Bicycles;
	vbar  Country;
run;
quit;
proc gchart data = learn.Bicycles;
	vbar  Model;
run;
quit;

/***********
* Q2
*/
pattern value = empty;
proc gchart data = learn.Bicycles;
	pie  Country;
run;
quit;
proc gchart data = learn.Bicycles;
	pie  Model;
run;
quit;
/**************
*Q3
*/
proc gchart data = learn.Bicycles;
	vbar TotalSales / midpoints = 0 to 12000 by 2000;
run;
quit;
/**************
* Q4
*/
pattern value = solid;
proc gchart data = learn.Bicycles;
	vbar Units / 	midpoints = 0 to 12000 by 2000
					group =  Model;
run;
quit;
/************
* Q5
*/
pattern value = solid;
proc gchart data = learn.Bicycles;
	vbar Country 	/	subgroup =  Model;
run;
quit;

/****************
* Q6
*/
pattern value = empty;
proc gchart data= learn.Bicycles;
	vbar Country	/ sumvar = TotalSales
					  type   = sum;
run;
quit;

/****************
* Q7
*/
options FMTSEARCH = (learn);
pattern value = empty;
proc gchart data = learn.College;
	vbar SchoolSize 	/	sumvar = GPA
							type   = mean;
run;
quit;
/**********************
* Q8
*/
goptions 	reset  = all
			ftext  = 'arial'
			htext  = 1.0
			ftitle = 'arial/bo'
			htitle = 1.5
			colors = (black)
			vsize  = 4;

symbol value = dot;
proc gplot data = learn.Fitness;
	plot   TimeMile *  RestPulse;
run;	
quit;

/*****************
* Q9
*/
symbol value = dot i = sm line = 1 width = 2;
proc gplot data = learn.Stocks;
	plot Price * Date;
run;
quit;













