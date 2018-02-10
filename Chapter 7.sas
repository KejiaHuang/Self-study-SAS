/*************
 * group ages into age groups
 */

data conditional;
	length 	Gender 	$1
		Quiz	$2;
	input Age Gender Midterm Quiz FinalExam;
	if Age lt 20 and not missing(age) then AgeGroup = 1;
	else if Age ge 20 and Age lt 40 then AgeGroup =2;
	else if Age ge 40 and Age lt 60 then AgeGroup =3;
	else if Age ge 60 then AgeGroup =4;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F .  .  76
59 F 96 A+ 97
15 M 88 .  93'
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "listing of conditional";
proc print data=conditional noobs;
run;


/*************
 *  Demonstrating a subsetting IF statement
 */

data females;
	length 	Gender 	$1
		Quiz	$2;
	input Age Gender Midterm Quiz FinalExam;
	if Gender eq 'F';
	
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F .  .  76
59 F 96 A+ 97
15 M 88 .  93'
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "listing of Females";
proc print data=females noobs;
run;


/**************
 *  select-expression
 */

data conditional_1;
	length 	Gender 	$1
		Quiz	$2;
	input Age Gender Midterm Quiz FinalExam;
	select;
		when (missing(Age)) AgeGroup =.;
		when (Age lt 20)    AgeGroup = 1;
		when (Age lt 40)    AgeGroup = 2;
		when (Age lt 60)    AgeGroup = 3;
		when (Age ge 60)    AgeGroup = 3;
		otherwise;
	end;
datalines;
21 M 80 B- 82
.  F 90 A  93
35 M 87 B+ 85
48 F .  .  76
59 F 96 A+ 97
15 M 88 .  93'
67 F 97 A  91
.  M 62 F  67
35 F 77 C- 77
49 M 59 C  81
;
title "listing of conditional_1";
proc print data=conditional_1 noobs;
run;

/*****************
 * combining various Boolean opearators
 */

title "Example of Boolan Expressions";
libname learn "/folders/myfolders/learning";
proc print data=learn.medical;
	where Clinic eq 'HMC' and
		(DX in ('7','9') or
		 Weight gt 180);
	id Patno;
	var Patno Clinic DX Weight VisitDate;
run;

/**********************
 *  Using a Where statement to subset a SAS data set
 */

data female_where;
	set conditional;
	where Gender eq 'F';
run;

proc print data = female_where;
run;







