/*******************************
*	Q1
*/

libname learn "d:/sasfile/learning";

proc sql;
	select *
	from learn.Inventory
	where Price gt 20;
quit;
	
/*************************
*	Q2
*/

proc sql;
	create table Price20 as 
	select *
	from learn.Inventory
	where Price gt 20;
quit;
proc sql;
	select *
	from Price20;
quit;

/***************************
*	Q3
*/

proc sql;
	create table N_Sales as 
	select Name, TotalSales
	from learn.Sales
	where Region eq 'North';
quit;
proc sql;
	select *
	from N_Sales
quit;

/************************
*	Q4
*/

data inventory;
	set learn.inventory;
	format Price 8.2;
run;

proc print data = inventory;
run;



proc sql;
	select 	CustNumber, p.Model, Quantity, Price
			/*Price * Quantity as Cost*/
	from 	learn.purchase as p	left join
			inventory as i
	on 	p.Model eq i.Model;
quit;

/*****************************
*	Q5
*/

title "first";
proc sql;
	select 	l.Subj as L_ID,
			r.Subj as R_ID,
			Height,
			Weight,
			Salary
	from 	learn.Left as l inner join
			learn.Right as r
	on 	l.Subj eq r.Subj;
quit;

title "second";
proc sql;
	select 	l.Subj as L_ID,
			r.Subj as R_ID,
			Height,
			Weight,
			Salary
	from 	learn.Left as l full join
			learn.Right as r
	on	 	l.Subj eq r.Subj;
quit;

title "third";
proc sql;
	select 	l.Subj as L_ID,
			r.Subj as R_ID,
			Height,
			Weight,
			Salary
	from 	learn.Left as l left join
			learn.Right as r
	on	 	l.Subj eq r.Subj;
quit;

/*********************************************
*	Q6 7
*/

proc sql;
	create table allproducts as 
	select *
	from 	learn.first union all corresponding
	select*
	from 	learn.second;
quit;

proc sql;
	select *
	from allproducts;
run;

/*********************************
*	Q8 9
*/

proc sql;
	select 	RBC,
			WBC,
			mean(RBC) as Mean_RBC,
			mean(WBC) as Mean_WBC,
			100 * RBC / calculated Mean_RBC as Percent_RBC,
			100 * WBC / calculated Mean_WBC as Percent_WBC
	from learn.Blood;
quit;

/*******************************************
*	Q10
*/

data xxx;
	input NameX : $15. PhoneX: $13.;
datalines;
Friedman (908)848-2323
Chien (212)777-1324
;

data yyy;
	input NameY : $15.  PhoneY:$13.;
datalines;
Chen (212)888-1325
Chambliss (830)257-8362
Saffer (740)470-5887
;

proc sql;
	select 	NameX, 
			PhoneX,
			NameY,
			PhoneY
	from 	xxx,
			yyy
	where	spedis(xxx.NameX,yyy.NameY) le 25;
run;






































