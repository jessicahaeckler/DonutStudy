OPTIONS LS = 80;
DATA donuts;
INPUT PERSON DRINK BRAND$ SCORE @@; 
CARDS;
1 1 D 6.67 1 2 C 7.33 1 3 A 8.00 1 4 B 4.67
2 1 A 4.33 2 2 D 8.33 2 3 B 7.33 2 4 C 5.00
3 1 B 4.33 3 2 A 4.66 3 3 C 7.00 3 4 D 5.66
4 1 C 4.00 4 2 B 5.66 4 3 D 6.33 4 4 A 2.66
;
RUN;
PROC GLM;
CLASS PERSON BRAND DRINK;
MODEL SCORE = BRAND DRINK PERSON/p;
MEANS BRAND/ LINES CLDIFF TUKEY;
output out = new predicted = yhat residual = resid;
run;
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
