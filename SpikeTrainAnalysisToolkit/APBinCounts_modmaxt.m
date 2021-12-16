function abc=APBinCounts(Spks, Binsize,overlap,maxt)
%Bin Size in seconds

ebinsize=Binsize*(1-overlap);
nbins=floor(max(maxt)/ebinsize);
lspkbin=ceil(max(Spks)/ebinsize);
cbinmin=0;
cbinmax=Binsize;
binstep=ebinsize;
abc=nan(2,nbins);
for i=1:nbins
    cspks=intersect(find(Spks>cbinmin),find(Spks<cbinmax));
    abc(2,i)=numel(cspks);
    abc(1,i)=(cbinmin+cbinmax)/2;
    cbinmin=cbinmin+binstep;
    cbinmax=cbinmax+binstep;
end

    
    