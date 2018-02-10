/*********
 * Q1
 */

libname learn "/folders/myfolders/learning";

data Subset_1 Subset_2;
	set learn.blood;
 	Combined =  0.001*WBC + RBC;
	if 	Gender = "Female" and BloodType = "AB" 
	then output Subset_1;
        if Gender = "Female" and BloodType eq "AB" and Combined ge 14 
	then output Subset_2;
run;

title "Q1";
proc print data= Subset_1;
run;
proc print data= Subset_2;
run;

/*******************************
 * Q3
 */

title"Q3";

data Lowmale Lowfemale;
	set learn.blood;
	if Chol lt 100 and not missing(Chol) then 
		if 	Gender eq "Male" 	then output Lowmale;
		else if Gender eq "Female" 	then output Lowfemale;
		;
run;
proc print data= Lowmale;
run;
proc print data=lowfemale;
run;

/************
 * Q4
 */

title "Q4";
data Mountain_USA Road_France;
	set learn.Bicycles;
	if Country eq "USA" and Model eq "Mountain Bike" then output Mountain_USA;
	if Country eq "France" and Model eq "Road Bike" then output Road_France;
run;
proc print data=Mountain_USA;
run;
proc print data= Road_France;
run;

/*************************
 * Q5
 */

title "Q5";

proc print data= learn.INVENTORY noobs;
run;
proc print data= learn.NewProducts noobs;
run;
data Updated;
 	set learn.Inventory learn.Newproducts;
run;
proc sort data= Updated;
	by Model;
run;

proc print data=Updated noobs;
run;

/*********************
 * Q6
 */
title "Q6";
proc sort data= learn.INVENTORY;
	by Model;
run;
proc sort data= learn.NewProducts;
	by Model;
run;
data Updated_1;
	set learn.INVENTORY learn.Newproducts;
	by Model;
run;
proc print data=Updated_1 noobs;
run;


/********************
 * Q7
 */

title "Q7";
proc means data= learn.gym;
	var fee;
	output out = means(drop = _type_ _freq_);
	Mean = Avefee;
data Percent;
	set learn.gym;
	if _n_ =1 then output means;
run;
proc print data= Percent(obs=5);
run;

/************
 * Q8
 */
title "Q8";
proc print data = learn.Bicycles(obs = 5);
run;
proc sort data= learn.Bicycles out= bicycles;
	by Manuf;
run;


data markup;
	input Manuf : $10. Markup;
datalines;
Cannondale 1.05
Trek 1.07
;

proc sort data=markup;
	by Manuf;
run;
data Markup_Price;
	merge bicycles markup;
	by Manuf;
run;
proc print data= Markup_Price;
run;

/*************
 * Q9
 */
title"Purchase";
proc print data=learn.Purchase(obs=5);
run;
title"Inventory";
proc print data=learn.Inventory(obs=5);
run;

proc sort data= learn.Purchase;
	by Model;
run;
proc sort data=learn.Inventory;
	by Model;
run;
data Pur_Price;
	merge learn.Purchase(in=Pur) learn.Inventory(in=Invent);
	by Model;
	if Invent and Pur;
	TotalCost= Quantity * Price;
run;
title "Pur_Price without cleaning";
proc print data= Pur_Price;
run;

/********************
 * Q10
 */
title "Q10";
roc sort data= learn.Purchase;
	by Model;
run;
proc sort data=learn.Inventory;
	by Model;
run;
data Pur_Price_1(keep = Model);
	merge learn.Purchase(in=Pur) learn.Inventory(in=Invent);
	by Model;
	if Invent and not Pur;
run;
title "Pur_Price without cleaning";
proc print data= Pur_Price_1 noobs;
run;

/********************
 *Q11 
 */
title "Q11";
opinions mergenoby = nowarn;

data try_1;
	merge learn.Purchase learn.Inventory;
run;
title "list of try1";
proc print data= try_1 noobs;
run;

opinions mergenoby = warn;

data try_2;
	merge learn.Purchase learn.Inventory;
run;
title "list of try2";
proc print data= try_2 noobs;
run;

opinions mergenoby = error;

data try_3;
	merge learn.Purchase learn.Inventory;
run;
title "list of try3";
proc print data= try_3 noobs;
run;

/*********
 * Q12
 */
title"Q12";
proc sort data =learn.demographic;
	by ID;
run;
proc sort data=learn.Survey1;
	by Subj;
run;
data merged;
	merge 	learn.demographic
		learn.Survey1(rename=(Subj=ID));
	by ID;
run;
proc print data=merged;
run;

/***********
 * Q13
 */
title"Q13";
proc sort data=learn.Demographic;
	by ID;
run;

data survey_2;
	set learn.Survey2(rename=(ID=idd));
	ID = put(idd,z3.);
	drop idd;
run;
proc print data = survey_2;
run;
proc sort data=survey_2;
	by ID;

data dou;
	merge 	learn.Demographic
		survey_2;
	by ID;
run;
title "Q13";
proc print data= dou;
run;

/***********
 * Q14
 */

data new;
	input Model $ Price;
datalines;
M567 25.69
X999 35.99
;
proc sort data=learn.inventory out= inventory;
	by Model;
run;
data newprice;
	update inventory new;
	by Model;
run;
title "Q14";
proc print data=newprice;
run;








