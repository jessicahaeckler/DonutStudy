OPTIONS LS = 80;
*input data collected in Excel;
DATA donuts;
INPUT PERSON$ DRINK$ BRAND$ SCORE @@; 
CARDS;
Andrew Coffee Pink     5.25 Andrew Juice Dunkin   7.50 Andrew Milk Kroger   7.75 Andrew Water Paradise 5.00
Dan    Coffee Kroger   6.25 Dan    Juice Pink     5.75 Dan    Milk Paradise 5.75 Dan    Water Dunkin   6.25
Jack   Coffee Dunkin   5.25 Jack   Juice Paradise 4.50 Jack   Milk Pink     6.00 Jack   Water Kroger   6.00
Larry  Coffee Paradise 4.00 Larry  Juice Kroger   5.50 Larry  Milk Dunkin   6.25 Larry  Water Pink     2.75
;
RUN;
*data analysis;
PROC GLM;
CLASS PERSON BRAND DRINK;
MODEL SCORE = BRAND DRINK PERSON/p;
MEANS BRAND/ LINES CLDIFF TUKEY;
output out = new predicted = yhat residual = resid;
run;
*residual analysis;
proc timeplot data = new;
plot resid/joinref ref = 0;
run;
PROC GPLOT data = new;
PLOT resid*yhat/vref=0;
PLOT resid*BRAND/vref=0;
PLOT resid*PERSON/vref=0;
PLOT resid*DRINK/vref=0;
run;
PROC UNIVARIATE plot normal;
QQPLOT resid / normal;
var resid;
run;

*Bar graph of taste scores by brand and person;
axis1 value=none label=none;                                                                                                          
axis2 label=(angle=90 "Taste Score");                                                                                                
axis3 label=none; 
title 'Donut Scores per Brand by Person';
proc gchart data=donuts;                                                                                                       
vbar brand / subgroup=brand group=person sumvar=score 
space=0 gspace=4
maxis=axis1 raxis=axis2 gaxis=axis3;                                                                                   
run;                                                                                                                                    
quit;

*Bar graph of taste scores by brand and drink; 
title 'Donut Scores per Brand by Drink';
proc gchart data=donuts;                                                                                                       
vbar brand / subgroup=brand group=drink sumvar=score 
space=0 gspace=4
maxis=axis1 raxis=axis2 gaxis=axis3;                                                                                   
run;                                                                                                                                    
quit;
