function abc=APLEDstimProps(LEDch,T,fs);
%input LED/Stim Channel, negative deflections (nom 5V) for LED stim.
%fs=20000;

SV=LEDch<-1;
dSV=diff(SV);
fdSV=find(dSV==1);
nfdSV=find(dSV==-1);
loc=fdSV/fs;
onT=(nfdSV-fdSV)./fs;
offT=(fdSV(2:end)-nfdSV(1:end-1))./fs;
DC=ones(size(onT));
DC(2:end)=onT(1:end-1)./(offT+onT(1:end-1));
dloc=diff(loc);
% cutoff for 'flash' is 10 ms 0.01 s
fdloc=find(dloc>=0.01);
% flash loc
ploc(1,1)=loc(1);
ploc(2:1+numel(fdloc),1)=loc(fdloc+1);
%flash duration
pdur=loc(fdloc)-ploc(1:end-1,1)+onT(fdloc);
pdur(end+1,1)=onT(end)+loc(end)-ploc(end,1);
%flash duty cycle
if numel(DC)>1
    pDC=round(100*[DC(2);DC(fdloc)])/100;
else
    pDC=DC(1);
end



abc=[ploc,pdur,pDC];