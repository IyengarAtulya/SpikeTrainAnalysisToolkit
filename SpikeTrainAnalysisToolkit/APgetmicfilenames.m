function abc=APgetmicfilenames(FILENAMES,PATHWAY,report)
ALLWAV=dir([PATHWAY,'*.wav']);

for i=1:size(ALLWAV,1)
    micrecname{i}=[PATHWAY,'\',ALLWAV(i).name];
end

for i=1:size(FILENAMES,1)
    [p n e]=fileparts(FILENAMES{i});
    [t1,r]=strtok(n,'_');
    [t2,r]=strtok(r,'_');
    propmicname{i}=[PATHWAY,'\',t1,'_',t2,'.wav'];
end
[selmicrec, ia, ib]=intersect(micrecname,propmicname);
if report==1
    msgbox(selmicrec,'Found Mic Files');
    uiwait;
end
abc.names=selmicrec;
abc.values=ib;