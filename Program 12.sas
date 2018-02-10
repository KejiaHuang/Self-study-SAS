/*************
 * Q2
 */
libname learn "/folders/myfolders/learning";

data Mixed;
	set learn.Mixed;
	Namelow = lowcase(Name);
	NameProp = propcase(Name);
	First = lowcase(scan(Name,1,''));
	Last = lowcase(scan(Name,2,''));
	substr(First,1,1) = upcase(substr(First,1,1));
	substr(Last,1,1) = upcase(substr(Last,1,1));
	Name = cats(First,Last);
	drop First Last;

run;
title "Q2";
proc print data=Mixed;
run;

/*********************
 * Q3
 */

data Name_And_More_1;
	set learn.NAMES_AND_MORE;
	Name = compbl(Name);
	Phone = compress(Phone,"() -");
run;
title"Q3";
proc print data=Name_And_More_1;
run;

/******************
 * Q4
 */

title "Q4";
data Name_And_More_2;
	set learn.NAMES_AND_MORE;
	Height = compress(Height,"FTIN.","i");
	feet = input(scan(Height, 1, " "),8.);
	inch = input(scan(Height, 2, " "),8.);
	if feet eq . then feet = 0;
	if inch eq . then inch = 0;
	Height = 12 * feet + inch;
	drop feet inch;
run;
proc print data=Name_And_More_2;
run;

/******************
 * Q5
 */

data Name_And_More_3;
	set learn.NAMES_AND_MORE;
	int = scan(Mixed, 1, ' _/');
	up  = scan(Mixed, 2, ' _/');
	dow = scan(Mixed, 3, ' _/');
	if up eq . and dow eq . then
	Mixed = input(int,8.);
	else
	Mixed = round(input(int,8.) + input(up,8.)/input(dow,8.),.001);
	drop int up dow;
run;
title"Q5";
proc print data= Name_And_More_3;
run;

/****************
 * Q6
 */

data study;
	set learn.Study;
	length GroupDose $6.;
	GroupDose = cat(Group,'.',Dose);
	GroupDose1 = Group||'.'||Dose;
run;
title "Q6";
proc print data= study;
run;

/*****************
 * Q7
 */

data Q7;
	set learn.Study;
	length Combined $3.;
	Combined = catx('_', trim(Group), put(Subgroup,1.));
	Combined1= trim(Group)||'_' ||put(Subgroup,1.);
run;
title "Q7";
proc print data=Q7;
run;

/*************
 * Q8
 */

data Q8;
	set learn.Study;
	if find(Weight, "lbs", "i") then 
		Weight = round(put(compress(Weight,,'kd'),8.),10);
	else Weight = round(put(compress(Weight,,'kd'),8.)*2.2,10);
run;
title "Q8";
proc print data= Q8;
run;

/*****************
 * Q9
 */

title "Q9";

data Spirited;
	set learn.Sales;
	where find(Customer,'spirit', 'i');
run;
proc print data=Spirited;
run;

/****************************
 * Q10
 */

title "Q10";
data Check1;
	set learn.Errors;
	where notdigit(trim(Subj)) or verify(trim(PartNumber),"0123456789LS");
run;
proc print data=Check1;
run;

/***********************
 * Q11
 */
title "Q11";
data Check2;
	set learn.Errors;
	where anydigit(trim(Name));
	keep Subj;
run;
proc print data=Check2;
run;
	
/*********************
 * Q12
 */
title "Q12";
data Check3;
	set learn.Errors;
	where findc(Subj,'XD','i');
run;
proc print data=Check3;
run;

/****************************
 * Q13
 */

title "Q13";
data Exact Within25;
	set learn.Social;
	if spedis(SS1,SS2) eq 0 then output Exact;
	else if spedis(SS1,SS2) le 25 then output Within25;
run;
proc print data=Exact;
run;
proc print data=Within25;
run;

/***************************
 * Q14
 */
title "Q14";
proc print data=learn.Medical;
	where findw(Comment,'antibiotics');
run;

/*******************
 * Q15
 */
title "Q15";
data area;
	set learn.names_and_more;
	length AreaC $3.;
	AreaC = substr(Phone,2,3);
run;
proc print data=area;
run;

/***********************
 * Q16
 */

title "Q16";
data Order;
	set learn.names_and_more(rename = (Name = OriName));
	length Name $15.;
	Name = compbl(OriName);
	Last = scan(Name,2,' ');
	drop OriName;
run;
proc sort data=Order;
	by Last;
run;
proc print data= Order;
run;
	
/***************************
 * Q17
 */
title "Q17";
proc print data= learn.Personal;
run;


data Personal1;
	set learn.personal;
	substr(SS,1,7) = '*';
	substr(AcctNum,5,1) = '_';
	drop Food1-Food8;
run;
proc print data=Personal1;
run;




