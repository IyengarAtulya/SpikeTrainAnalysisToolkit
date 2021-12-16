function abc=APreconstspktrain(SpkTIMES,FS)
espkt=max(SpkTIMES);
npts=round(espkt*FS);
nspks=numel(SpkTIMES);
abc=zeros(npts,1);
for i=1:nspks
    abc(round(SpkTIMES(i)*FS),1)=1;
end

   


