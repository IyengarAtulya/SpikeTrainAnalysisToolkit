function abc = APLEDchTiming(FILENAME)
D = importdata(FILENAME);
d = D(:,7)>4;
dd = diff(d);
on_D = find (dd == 1);
on_T = D(on_D,1);
off_D = find (dd == -1);
off_T = D(off_D,1);
abc = [{on_T}, {off_T}];