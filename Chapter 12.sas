/**************
 * length of a character value
 */

libname learn "/folders/myfolders/learning";
data long_names;
	set learn.sales;
	if lengthn(Name) gt 12;
run;
proc print data=long_names;
run;
/*****************
 * changing values to uppercase
 */

data mixed;
	set learn.mixed;
	Name= upcase(Name);
run;
data both;
	merge 	mixed
		learn.upper;
	by Name;
run;
proc print data=both;
run;

/******************
 * converting mulitiple blanks to a single blank and
 * demonstrating the propcase function
 */

data standard;
	set learn.address;
	Name   = compbl(propcase(Name));
	Street = compbl(propcase(Street));
	City   = compbl(propcase(City));
	State  = upcase(State);
run;
proc print data=standard;
run;


/*****************
 * concatenation functions
 */

data _NULL_;
	Length Join Name1-Name4 $15;
	First = "Ron   ";
	Last  = "Cody  ";
	Join  = ":" ||First ||":";
	Name1 = First||Last;
	Name2 = cat(First,Last);
	Name3 = cats(First,Last);
	Name4 = catx('',First,Last);
	file print;
	put 	Join = /
		Name1 = /
		Name2 = /
		Name3 = /
		Name4 = /;
run;

/************************
 * Trim left strip
 */

data blanks;
	String = '   ABC  ';
	joinLeft = ':'||left(String)||':';
 	joinTrim = ':'||trim(String)||':';
 	joinStrip = ':'||strip(String)||':';
run;
proc print data=blanks;
run;

/******************
 * compress function remove characters
 */

data phone;
	length PhoneNumber $ 10;
	set learn.phone;
	PhoneNumber = compress(Phone,'( ) - .');
	drop Phone;
run;
proc print data=phone;
run;

/*************
 * Compress modifiers
 */

data phone1;
	length PhoneNumber $ 10;
	set learn.phone;
	PhoneNumber = compress(Phone,,'kd');
	drop Phone;
run;

proc print data=phone1;
run;

/**********************
 * Find and compress functions
 */

data English;
	set learn.mixed_nuts(rename=
			(Weight = Char_Weight
			 Height = Char_Height));
	if find(Char_Weight, 'lb','i') then
		Weight = input(compress(Char_Weight,,'kd'),8.);
	else if find(Char_Weight, 'kg','i') then	
		Weight = 2.2*input(compress(Char_Weight,,'kd'),8.);
	if find(Char_Height, 'in', 'i') then
		Height = input(compress(Char_Height,,'kd'),8.);
	else if find(Char_Height,'cm','i') then
	        Height = input(compress(Char_Height,,'kd'),8.)/2.54;
	drop Char_:;
run;
proc print data=English;
run;

/*****************
 * findw function
 */

data look_for_roger;
	input String $40.;
	if findw(String,'Roger') then Match = 'Yes';
	else Match = 'No';
datalines;
Will Rogers
Roger Cody
Was roger here?
Was Roger here?
;

proc print data=look_for_roger;
run;

/************
 * anydigit function
 */
	
data only_alpha mixed;
	infile "/folders/myfolders/learning/id.txt" truncover;
	input ID $10.;
	if anydigit(ID) then output mixed;
	else output only_alpha;
run;
proc print data=only_alpha;
run;
proc print data= mixed;
run;
	
/********
 * substr function
 */

data extract;
	input ID: $10. @@;
	length State $ 2 Gender $ 1 Last $ 5;
	State = substr(ID,1,2);
	Number = input(substr(ID,3,2),3.);
	Gender = substr(ID,5,1);
	Last = substr(ID,6);
datalines;
NJ12M99 NY76F4512 TX91M5
;

proc print data=extract;
run;
	
/***********
 * Scan function
 */
 
 data original;
 	input Name $ 30.;
 datalines;
 Jeffrey Smith
 Ron Cody
 Alan Wilson
 Alfred E. Newman
 ;
 data first_last;
 	set original;
 	length First Last $ 15;
 	First = scan(Name, 1, ' ');
 	Last  = scan(Name, 2, ' ');
 run;
 proc print data=first_last;
 run;
 
 /**********
  * scan function to extract the last name
  */
 
 data last;
 	set original;
 	length LastName $15;
 	LastName = scan(Name,-1,' ');
 run;
 proc print data=last;
 run;
 
 
 /************************
  *  Compare function
  */
 
 data diagnosis;
 	input Code $10.;
 	if compare(Code, 'V450', 'i') eq 0 then Match = 'Yes';
 	else Match = 'No';
 datalines;
 V450
 v450
 v450.100
 V900
 ;
 proc print data=diagnosis;
 run;
 
 
 /********************
  * Clarifying the use of colon modifier with the COMPARE function
  */
 
 data _NULL_;
 	string1 = 'ABC   ';
 	string2 = 'ABCxyz';
 	compare1 = compare(string1, string2, ':');
 	compare2 = compare(trim(string1),string2,':');
 	file print;
 	put string1 = string2= compare1= compare2 =;
 run;

 /******************
  * spedis function to perform a fuzzy match
  */
 
 data fuzzy;
 	input Name $20.;
 	Value = spedis(Name,'Friedman');
 datalines;
 Friedman
 Freedman
 Xriedman
 Freidman
 Friedmann
 Alfred
 FRIEDMAN
 ;
 proc print data=fuzzy;
 run;
 
 
 /***********************
  * Translate function
  */
 
 
 data trans;
 	input answer : $ 5.;
 	 Answer = translate(Answer,'ABCDE','12345');
 datalines;
 14235
 AB123
 51492
 ;
 proc print data= trans;
 run;
 
 
 
/*****************
 * tranwrd
 */
 
 data address;
 	infile datalines dlm=' ,';
 	input 	#1 Name $30.
 		#2 Line1 $40.
 		#3 City & $20. State :$2. Zip :$5.;
 	Name = tranwrd( Name, 'Mr.', ' ');
 	Name = tranwrd( Name, 'Mrs.', ' ');
 	Name = tranwrd( Name, 'Dr.', ' ');
 	Name = tranwrd( Name, 'Ms.', ' ');
 	Name = left(Name);
 	
 	Line1 = tranwrd(Line1, 'Street', 'St.');
 	Line1 = tranwrd(Line1, 'Road', 'Rd.');
 	Line1 = tranwrd(Line1, 'Avenue', 'Ave.');
 
 datalines;
 Dr. Peter Benchley
 123 River Road
 Oceanside, NY 11518
 Mr. Robert Merrill
 878 Ocean Avenue
 Long Beach, CA 90818
 Mrs. Laura Smith
 80 Lazy Brook Road
 Flemington, NJ 08822
 ;
 proc print data=address;
 run;
 
 
	
	
	
	
































