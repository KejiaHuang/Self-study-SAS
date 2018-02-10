/***************
* 	Q1
*/

libname learn 'D:/sasfile/learning';

data Long;
	set learn.Wide;
	array X_[5] X1-X5;
	array Y_[5] Y1-Y5;
	do time = 1 to 5;
		X = X_[time];
		Y = Y_[time];
		output;
	end;
	keep Subj Time X Y;
run;

proc print data = Long;
run;

/*******************************
*	Q2
*/

data Stretch;
	set learn.Narrow;
	by Subj;
	array S[5];
	retain S1-S5;
	if first.Subj then call missing(S1-S5);
	S[time] = Score;
	if last.Subj then output;
	drop time Score;
run;

proc print data = Stretch;
run;

/***************************
*	Q3
*/

proc transpose data = learn.Wide
			   out  = Long(	rename = ( COL1 = X )
									drop = _name_);
	by Subj;
run;

proc print data = Long;
run;

/********************************
*	Q4
*/

proc transpose data = learn.Narrow prefix = S
			   out  = Strech (drop = _name_) ;
	by Subj;
	id Time;
	var Score;
run;

proc print data = Strech;
run;
