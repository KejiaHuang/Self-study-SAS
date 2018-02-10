/******************
*	Creating a data set with serveral observations per subject 
*	from a data set with one observation per subject 
*/

libname learn 'd:/sasfile/learning';

data learn.manyper;
	set learn.oneper;
	array Dx[3]; 
	do visit = 1 to 3;
		if missing(Dx[visit]) then leave;
		Diagnosis = Dx[visit];
		output;
	end;
	keep Subj Diagnosis visit;
run;

proc print data = learn.manyper;
run;

/************************************
*	Creating a data set with one observation per subject
*	from a data set with several observations per subject	
*/

proc sort data = learn.manyper out = manyper;
	by Subj visit;
run;

data oneper;
	set manyper;
	by Subj visit;
	array Dx[3];
	retain Dx1 - Dx3;
	if first.Subj then call missing(of Dx1-Dx3);
	Dx[visit] = Diagnosis;
	if last.Subj then output;
	keep Subj Dx1-Dx3;
run;

proc print data = oneper;
run;

/************************************************
*	Using PROC TRANSPOSE to convert a data set with 
*	one observation per subject into a data set 
* 	with several observations per subject
*/

proc transpose data = learn.oneper
			   out  = manyper;
	by Subj;
	var Dx1 - Dx3;
run;

proc print data = manyper;
run;

proc transpose data = learn.oneper
			   out  = t_manyper(rename = (col1  = Diagnosis)
								drop   = _name_
								where  = (Diagnosis is not null));
	by Subj;
	var Dx1 - Dx3;
run;

proc print data =t_manyper;
run;

/******************************
*	Using PROC TRANSPOSE to convert a sas data set 
*	with serval observations per subject into one 
*	with one observation per subject
*/
proc print data = learn.manyper;
run;

proc transpose data = learn.manyper perfix = Dx
			  out  = oneper(drop = _NAME_ );
	by 	Subj;
	id 	Visit;
	var Diagnosis;
run;

proc print data = oneper;
run; 


















