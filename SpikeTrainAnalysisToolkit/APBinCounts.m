function abc=APBinCounts(Spks, Binsize,overlap)
ebinsize=Binsize*(1-overlap);
nbins=floor(nanmax(Spks)/ebinsize);
cbinmin=0;
cbinmax=Binsize;
binstep=ebinsize;
nspks=numel(Spks);
for i=1:nspks
    if Spks(i)>2
        
    end
    
    cspks=intersect(find(Spks>cbinmin),find(Spks<cbinmax));
    sc(i)=numel(cspks);
    t(i)=(cbinmin+cbinmax)/2;
    cbinmin=cbinmin+binstep;
    cbinmax=cbinmax+binstep;
end
abc(1,:)=t;
abc(2,:)=sc;
    
    