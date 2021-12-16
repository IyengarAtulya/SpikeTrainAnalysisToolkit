function abc=AParithFFCV(IFF,FiltSz,ROOT)
b=ones(1,FiltSz)./FiltSz;
fdST=filtfilt(b,1,IFF);
sdST=(IFF-fdST).^2;
%running SD, CV calculation
fsdST=filtfilt(b,1,sdST);
fsdST=fsdST.^(1/ROOT);
CV=fsdST./fdST;
%output on log10 scale
lCV=log10(CV(2:end-1));
lfdST=log10(fdST(2:end-1));
abc=[lfdST;lCV];