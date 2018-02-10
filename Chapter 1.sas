* Program 1-1

options nocenter nonumber;

data veg;
	infile "/folders/myfolders/learning/veggies.txt";
	input Name $ Code $ Days Number Price;
	CostPerSeed = Price / Number;
run;

title "List of the Raw Data";
proc print data=veg;
run;

title "Frequency Distribution of Vegetable Names";
proc freq data=veg;
	tables Name;
run;

title "Average Cost of Seeds";
proc means data=veg;
	var Price Days;
run;