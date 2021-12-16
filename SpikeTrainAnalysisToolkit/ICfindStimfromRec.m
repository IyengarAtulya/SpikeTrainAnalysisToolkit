function abc=ICfindStimfromRec(T,V,gain,VThresh,TThresh)
fs=1./mean(diff(T));
V=V/gain;
dV=diff(V);
a=find(dV>VThresh);
da=diff(a);
b=find(da>(fs/(TThresh*1000)));
abc=[T(a([1,b'+1])),V(a([1,b'+1])),a([1,b'+1])];


