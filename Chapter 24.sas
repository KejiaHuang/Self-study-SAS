/***********************
*	Creating FIRST and LAST variables
*/

data europe;
   input ID $ 1-3 @5 VisitDate date7. @13 Depart time5.
         Orig $ 19-21 Dest $ 23-25 Miles 27-30 Mail 32-34
         Freight 36-38 Boarded 40-42 Transferred 44-45
         NonRevenue 47 Deplaned 49-51 Capacity 53-55 DayOfMonth 57-58
         Revenue 60-65;
   format VisitDate date7. Depart time5.;
   drop Depart Orig Dest Miles  Boarded Transferred 
		NonRevenue Deplaned Capacity DayOfMonth Revenue;
datalines;
821 04MAR99 9:31  LGA LON 3442 403 209 167 17 7 222 250  1 150634
271 04MAR99 11:40 LGA PAR 3856 492 308 146  8 3 163 250  1 156804
271 05MAR99 12:19 LGA PAR 3857 366 498 177 15 5 227 250  1 190098
821 06MAR99 14:56 LGA LON 3442 345 243 167 13 4 222 250  1 150634
821 07MAR99 13:17 LGA LON 3635 248 307 215 14 6 158 250  1 193930
271 07MAR99 9:31  LGA PAR 3442 353 205 155 18 7 172 250  2 166470
821 08MAR99 11:40 LGA LON 3856 391 395 186  8 1 114 250  2 167772
271 08MAR99 12:19 LGA PAR 3857 366 279 152  7 4 187 250  2 163248
821 09MAR99 14:56 LGA LON 3442 219 368 203  6 3 210 250  2 183106
271 09MAR99 13:17 LGA PAR 3635 357 282 159 15 4 191 250  2 170766
821 10MAR99 9:31  LGA LON 3442 389 479 188  8 6 211 250  3 169576
271 10MAR99 11:40 LGA PAR 3856 415 463 182  9 6 153 250  3 195468
622 03MAR99 12:19 LGA FRA 3857 296 414 180 16 4 200 250  3 187636
821 03MAR99 14:56 LGA LON 3442 448 282 151 17 4 172 250  3 143561
271 03MAR99 13:17 LGA PAR 3635 352 351 147 29 7 183 250  3 123456
219 04MAR99 9:31  LGA LON 3442 331 376 232 18 0 250 250  4 189065
387 04MAR99 11:40 LGA CPH 3856 395 217  81 21 1 103 250  4 196540
622 04MAR99 12:19 LGA FRA 3857 296 232 137 14 4 155 250  4 165456
821 04MAR99 14:56 LGA LON 3442 403 209 167  9 6 182 250  4 170766
271 04MAR99 13:17 LGA PAR 3635 492 308 146 13 4 163 250  4 125632
219 05MAR99 9:31  LGA LON 3442 485 267 160  4 3 167 250  5 197456
387 05MAR99 11:40 LGA CPH 3856 393 304 142  8 2 152 250  5 134561
622 05MAR99 12:19 LGA FRA 3857 340 311 185 11 3 199 250  5 125436
271 05MAR99 13:17 LGA PAR 3635 366 498 177 22 4 203 250  5 128972
219 06MAR99 9:31  LGA LON 3442 388 298 163 14 6 183 250  6 162343
821 06MAR99 14:56 LGA LON 3442 345 243 167 16 2 185 250  6 129560
219 07MAR99 9:31  LGA LON 3442 421 356 241  9 0 250 250  7 134520
387 07MAR99 11:40 LGA CPH 3856 546 204 131  5 6 142 250  7 135632
622 07MAR99 12:19 LGA FRA 3857 391 423 210 22 5 237 250  7 107865
821 07MAR99 14:56 LGA LON 3442 248 307 215 11 5 231 250  7 196736
271 07MAR99 13:17 LGA PAR 3635 353 205 155 21 4 180 250  7 153423
219 08MAR99 9:31  LGA LON 3442 447 299 183 11 3 197 250  8 106753
387 08MAR99 11:40 LGA CPH 3856 415 367 150  9 3 162 250  8 128564
622 08MAR99 12:19 LGA FRA 3857 346   . 176  5 6 187 250  8 178543
821 08MAR99 14:56 LGA LON 3442 391 395 186 11 5 202 250  8 125344
271 08MAR99 13:17 LGA PAR 3635 366 279 152 20 4 176 250  8 133345
219 09MAR99 9:31  LGA LON 3442 356 547 211 18 6 235 250  9 122766
387 09MAR99 11:40 LGA CPH 3856 363 297 128 14 3 145 250  9 134523
622 09MAR99 12:19 LGA FRA 3857 317 421 173 11 5 189 250  9 100987
821 09MAR99 14:56 LGA LON 3442 219 368 203 11 4 218 250  9 166543
271 09MAR99 13:17 LGA PAR 3635 357 282 159 18 5 182 250  9 126543
219 10MAR99 9:31  LGA LON 3442 272 370 167  7 7 181 250 10 198744
387 10MAR99 11:40 LGA CPH 3856 336 377 154 18 5 177 250 10 109885
622 10MAR99 12:19 LGA FRA 3857 272 363 129 12 6 147 250 10 134459
821 10MAR99 14:56 LGA LON 3442 389 479 188  5 4 197 250 10 129745
271 10MAR99 13:17 LGA PAR 3635 415 463 182  9 7 198 250 10 134976
;



libname learn "d:/sasfile/learning";

proc print data = europe;
run;

proc sort data = europe;
	by ID VisitDate;
run;

data last;
 	set europe;
	by ID;
	put ID = VisitDate= First.ID= Last.ID=;
	if last.ID;
run;

proc print data = last;
run;

/************************
*	Counting the number of visits per patient using a DATA step
*/

data count;
	set europe;
	by ID;
	if first.ID then N_visit = 0;
	N_visit + 1;
	if last.ID then output;
run;

proc print data = count;
run;

/**************************
*	Using PROC FREQ to count the number of observations in a BY group
*/

proc freq data = europe noprint;
	tables ID / out = counts;
run;

proc print data = counts;
run;

/******************************
*	Using the RENAME= and DROP= data set options 
*	to control the output data set
*/

proc freq data = europe noprint;
	tables ID / out = counts  (rename = (count = N_Visits)
										drop = percent);
run;

data europe;
	merge europe counts;
	by ID;
run;

proc print data = europe;
run;

/************************************
*	Using PROC MEANS to count 
* 	the number of observations in a BY group
*/


proc means data = europe nway noprint;
	class ID;
	output out = counts(rename = (_freq_ = N_Visits)
						drop   = _STAT_ _type_);
run;

proc print data = counts;
run;

/**************************************
*	Computing differences between observations
*/

data difference;
	set europe;
	by ID;
	if first.ID and last.ID then delete;
	diff_Mail 	 = 	Mail - lag(Mail);
	diff_Freight = 	Freight - lag(Freight);
	if not first.ID then output;
run;

proc print data = europe;
run;
proc print data = difference;
run;

/*******************************************
*	Computing difference between the first 
*	and last obervation in a BY group
*/

data first_last;
	set europe;
	by ID;
	if first.ID and last.ID then delete;
	if first.ID or last.ID then do;
		diff_Mail = Mail - lag(Mail);
	end;
	if last.ID then output;
run;

proc print data = first_last;
run;

/***********************************************
*	Demonstrating the use of retained variables
*/

data first_last;
	set europe;
	by ID;
	if first.ID and last.ID then delete;

	retain first_Mail;

	if first.ID then first_Mail = Mail;
	if last.ID then do;
		diff_Mail = Mail - first_Mail;
		output;
	end;
	drop First_: ;
run;

proc print data = first_last;
run;
		
/**********************************
*	Using a retained variable to remember a previous value
*/

data hyper;
	set europe;
	by ID;
	retain HighMail;
	if first.ID then HighMail = 'No ';
	if Mail gt 300 then HighMail = 'Yes';
	if last.ID then output;
run;
proc print data = hyper;
run;























