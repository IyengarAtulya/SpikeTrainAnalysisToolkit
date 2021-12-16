function abc=APrsdplot2(Spks,npts,minbinsize,maxbinsize,overlap)
nr=50
dSpks=diff(Spks);
for i=1:nr
    p(i,:)=randperm(size(dSpks,1));
end
sSpks=nan(size(Spks,1),nr);
sSpks(1,:)=ones(1,nr)*Spks(1);
for i=1:size(dSpks,1)
    for j=1:nr
        sSpks(i+1,j)=dSpks(p(j,i))+sSpks(i,j);
    end
end
Binsizes=logspace(log10(minbinsize),log10(maxbinsize),npts);
wh=waitbar(0,'Computing RSD');
for i=1:npts
    for j=1:nr
        waitbar((j/nr)*1/npts+(i-1)/npts,wh)
        rbincount=APBinCounts(sSpks(:,j),Binsizes(i),overlap);
        rbstd(i,j)=std(rbincount(2,:));
    end
    bincount=APBinCounts(Spks,Binsizes(i),overlap);
    bstd(i)=std(bincount(2,:));
    waitbar(i/npts,wh);
end
close(wh);
mrbstd=mean(rbstd,2);
maxperct=prctile(rbstd,95,2);
minperct=prctile(rbstd,5,2);

h=figure;
loglog(Binsizes,bstd./Binsizes)
hold all
loglog(Binsizes,maxperct'./Binsizes,'g--')
loglog(Binsizes,minperct'./Binsizes,'g--')
loglog(Binsizes,mrbstd'./Binsizes,'r')

legend('RSD',' 95th %tile ShuffledRSD',' 5th %tile ShuffledRSD','Mean Shuffled RSD')
xlabel('Bin Size (s)')
ylabel ('RSD')
abc=h;
