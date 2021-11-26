*Jessica Haeckler
Generate random Latin Square;
title 'Latin Square Design';
proc plan seed=12345; *set seed for replication;
	factors Row=4 ordered Col=4 ordered / noprint;
	treatments Tmt=4 cyclic;
	output out=LatinSquare 
			Row cvals=('Person 1' 'Person 2' 'Person 3' 'Person 4') random
			Col cvals=('Milk' 'Water' 'Coffee' 'Juice') random
			Tmt cvals=('Brand 1' 'Brand 2' 'Brand 3' 'Brand 4') random;
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
