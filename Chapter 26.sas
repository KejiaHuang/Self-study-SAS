/**********************
*	Demonstrating a simple query from a single data set
*/

libname learn "d:/sasfile/learning";

proc sql;
	select 	Subj,
			Height,
			Weight
	from	learn.health
	where Height gt 66;
quit;

/**********************************
*	Using an asterisk t select all the variables in a data set
*/

proc sql;
	select *
	from learn.health
	where Height gt 66;
quit;

/*************************************
*	Using PROC SQL to create a SAS data set
*/	

proc sql;
	create table height65 as
	select *
	from learn.health
	where Height gt 66;
quit;

/***********************
*	Joining two tables (Cartesian product)
*	Renaming the two Subj variables
*	Using aliases to simplify naming variables
*/

proc sql;
	select 	h.Subj as Health_Subj,
			d.ID as Demog_ID,
			Height,
			Weight,
			Gender
	from	learn.health as h,
			learn.demographic as d
	where 	h.Subj eq d.ID;
quit;

/*******************
*	Performing an inner join
*/

proc sql;
	select 	h.Subj as Subj_Health,
			d.ID   as Subj_Demog,
			Height,
			Weight,
			Gender
	from	learn.health as h inner join
			learn.demographic as d
	on		h.Subj eq d.ID;
quit;

/***********************
*	left right and full join
*/


proc sql;
	title "left join";
	select 	h.subj as Subj_Health,
			d.ID   as Subj_Demog,
			Height,
			Weight,
			Gender
	from	learn.health as h left join
			learn.demographic as d
	on		h.Subj eq d.ID;
quit;


proc sql;
	title "right join";
	select 	h.Subj as Subj_Health,
			d.ID   as Subj_Demog,
			Height,
			Weight,
			Gender
	from	learn.health as h right join
			learn.demographic as d
	on		h.Subj eq d.ID;
quit;


proc sql;
	title "full join";
	select 	h.Subj as Subj_Health,
			d.ID   as Subj_Demog,
			Height,
			Weight,
			Gender
	from	learn.health as h full join
			learn.demographic as d
	on		h.Subj eq d.ID;
quit;


/****************************
*	concatenating two tables
*/

proc sql;
	create demog_complete as 
	select *
	from learn.survey1 union all corresponding
	select *
	from learn.survey2
quit;

/********************************
*	Using a summary function in proc sql
*/

proc sql;
	select 	Subj,
			Height,
			Weight,
			mean(Height) as Ave_Height,
			100*Height / calculated Ave_Height as
				Percent_Height
	from learn.health
quit;

/*************************************
*	Demonstrating an order clause
*/

proc sql;
	select 	Subj,
			Height,
			Weight
	from	learn.health
	order by Height;
quit;





















