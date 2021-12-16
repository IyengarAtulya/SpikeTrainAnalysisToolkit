function abc=APgeomFFCV(IFF,FiltSz,ROOT)
lIFF=log10(IFF);
b=ones(1,FiltSz)./FiltSz;
%running geometric mean
lgm=filtfilt(b,1,lIFF);
%geometric SD/CV calc
gsd=(lIFF-lgm).^2;
fgsd=filtfilt(b,1,gsd);
lCV=log10(fgsd.^(1/ROOT)./lgm);

% output on log10 scale
abc=[lgm(:,2:end-1); lCV(:,2:end-1)];