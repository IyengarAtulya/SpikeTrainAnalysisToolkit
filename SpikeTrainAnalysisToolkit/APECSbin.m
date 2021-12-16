function abc=ECSbin(SpkTimes, StimTimes, binsz, overlap)
STimes=StimTimes(~isnan(StimTimes));
ECSstart=STimes(1);
CST=SpkTimes-ECSstart;
bstart=ceil(CST(1)/binsz)*binsz;
bend=floor(CST(end)/binsz)*binsz;
nbins=(bend-bstart)/(binsz*(1-overlap));
BinnedResp=zeros([nbins 3]);
cbin=bstart;
for i=1:nbins
    BinnedResp(i,1)=cbin;
    BinnedResp(i,2)=cbin+binsz;
    BinnedResp(i,3)=numel(find(CST>cbin))-numel(find(CST>cbin+binsz));
    cbin=cbin+((1-overlap)*binsz);
end
abc=BinnedResp;
    
    
