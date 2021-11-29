*Jessica Haeckler
Generate random Latin Square;
title 'Latin Square Design';
proc plan seed=12345; *set seed for replication;
	factors Row=4 ordered Col=4 ordered / noprint;
	treatments Tmt=4 cyclic;
	output out=LatinSquare 
			Row cvals=('Andrew' 'Jack' 'Larry' 'Dan') random
			Col cvals=('Milk' 'Water' 'Coffee' 'Juice') random
			Tmt cvals=('Dunkin' 'Paradise' 'Kroger' 'Pink') random;
	quit;
	proc sort data=LatinSquare out=LatinSquare;
		by Row Col;
	*create output dataset;
	proc transpose data = LatinSquare(rename=(Col=_NAME_))
					out = tLatinSquare(drop=_NAME_);
		by Row;
		var Tmt;
	proc print data=tLatinSquare noobs;
	run;
