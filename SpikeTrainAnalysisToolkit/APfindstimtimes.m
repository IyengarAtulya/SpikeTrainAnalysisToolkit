function abc=APfindstimtimes(Data)
D=Data(:,5);
D(D<-0.2)=-0.2;
dstim=diff(D);
time=Data(:,1);
st=find(dstim>4);
abc=time(st);