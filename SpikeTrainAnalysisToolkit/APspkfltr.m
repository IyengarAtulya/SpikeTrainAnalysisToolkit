function spkfltr=vdat(time,ch,thresh)
%sets voltage values less than the threshold standard deviations to zero
%M- an Nx2 matrix with the first row for time points and second row for
%voltage measurements
%thresh- the value (relative to SD) used to threshold the trace
%Version 0.91 Last Updated 4 Aug 2012
M(:,1)=time;
M(:,2)=ch;
L=size(M);
la=L(1);
time=M(:,1);
v=M(:,2);
v2=v;
meanv=nanmean(v);
v2=v2-meanv;
sdv=nanstd(v);
tthresh=sdv*thresh;
if tthresh>0.55
    tthresh=0.55;
end
for i=1:la
    if((v(i)-meanv)<tthresh)
        v2(i)=0;
    end
end
spkfltr=v2;
   