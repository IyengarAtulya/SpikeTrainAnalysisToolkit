function abc=APplotWBFcumudist(varargin)
%binsize =500 ms
%overlap=0.75
if nargin==0
    [n p e]=uigetfile('Z:\BioDataLab\Atulya\Physiology Summary and Organization\Flight Stats\*.mat','Select Group WBF dataset');
    load([p,n])
end
if nargin==1;
    load(varargin{1});
end
if nargin>1
    flynum=varargin{1};
    dat=varargin{2};
    spktms=varargin{3};
end
numel(unique(flynum))
ufn=unique(flynum);
allwbf=nan(1,0); 
allinstff=nan(1,0)
tc=1
for i=1:numel(unique(flynum))
    sf=find(flynum==ufn(i));
    sf;
    WBF=ones(1,0);
    instff=ones(1,0);
    for j=1:numel(sf)
        try
        if sum(isnan(dat(sf(j)).WBF))>1
            fnan=find(isnan(dat(sf(j)).WBF));
            if numel(fnan)>10
                EB=fnan(10)-60;
            else
                EB=numel(dat(sf(j)).WBF);
            end
            if EB<20
                EB=0;
                
            end
        else
            EB=numel(dat(sf(j)).WBF);
        end
        if EB~=0
            EB;
            WBF=cat(2,WBF,dat(sf(j)).WBF(1:EB));
            st=spktms(sf(j)).spktimes;
            dst=diff(st);
            fst=1./dst;
            bintimes=dat(sf(j)).TT;
            nbintimes=bintimes(~isnan(dat(sf(j)).WBF));
            ebintimes=nbintimes(nbintimes<EB);
            nearestbin=min(abs(bsxfun(@minus,st,ebintimes))');
              st=spktms(sf(j)).spktimes;
              est=st(nearestbin(1:end-1)<0.5);
            dst=diff(est);
            fst=1./dst;
            bfst=fst;
            instff=cat(2,instff,bfst');
            %calc ISICV
            isicv(tc).data=APplotFanoPhase(est,0,2,6,2,0);
            tc=tc+1;
            
        end
        catch
            [i,j]
        end
        
        
    end
   allinstff=[allinstff;instff'];
    if numel(WBF)>10
        try
        flyWBFmean(i)=nanmean(WBF);
        flyWBFRMSE(i)=sqrt(nansum((WBF-nanmean(WBF)).^2)/numel(WBF));
        flyDLMFFmean(i)=nanmean(instff);
        flyDLMFFRMSE(i)=sqrt(nansum((instff-nanmean(instff)).^2)/numel(instff));
        flyDLMFFCV(i)=nanstd(instff)/nanmean(instff);
        ffcv=APgeomFFCV(instff,6,2);
        flyDLMFFbinCV(i)=nanmean(ffcv(2,:));
        flyDLMFFbinCVstd(i)=nanstd(ffcv(2,:));
        allwbf=cat(2,WBF,allwbf);
        nbin(i)=numel(WBF);
        catch
            flyWBFmean(i)=nan;
        flyWBFRMSE(i)=nan;
        flyDLMFFmean(i)=nan;
        flyDLMFFRMSE(i)=nan;
        flyDLMFFCV(i)=nan;
        ffcv=nan;
        flyDLMFFbinCV(i)=nan;
        flyDLMFFbinCVstd(i)=nan;
        nbin(i)=nan;
        end
        
    else
        flyWBFmean(i)=nan;
        flyWBFRMSE(i)=nan;
        flyDLMFFmean(i)=nan;
        flyDLMFFRMSE(i)=nan;
        flyDLMFFCV(i)=nan;
        ffcv=nan;
        flyDLMFFbinCV(i)=nan;
        flyDLMFFbinCVstd(i)=nan;
        nbin(i)=nan;
    end
end
sstats=sortrows([flyWBFmean;flyWBFRMSE;flyDLMFFmean;flyDLMFFRMSE;flyDLMFFCV;ufn;nan(size(flyWBFmean));flyDLMFFbinCV;flyDLMFFbinCVstd;nbin]');
nanpad=nan(1,size(sstats,1));
ptile=[1:sum(~isnan(sstats(:,1)))]/sum(~isnan(sstats(:,1)));
nanpad(1:numel(ptile))=ptile;

sstats(:,7)=nanpad';
sstats=real(sstats);
figure
hold all
plot([1:sum(~isnan(sstats(:,1)))]/sum(~isnan(sstats(:,1))),sstats(~isnan(sstats(:,1)),1),'k.','MarkerSize',6)
errorbar([1:sum(~isnan(sstats(:,1)))]/sum(~isnan(sstats(:,1))),sstats(~isnan(sstats(:,1)),1),sstats(~isnan(sstats(:,1)),2),'LineStyle','none','Color',[0 0 0])
% plot(sstats(:,1),'k.','MarkerSize',6)
% errorbar(sstats(:,1),sstats(:,2),'LineStyle','none','Color',[0 0 0])
load('Z:\BioDataLab\Atulya\Physiology Summary and Organization\FltBoxUFN.mat')
Fboxadd(:,1)=sstats(:,6);
Fboxadd(:,2)=sstats(:,1);
Fboxadd(:,3)=sstats(:,2);
Fboxadd(:,4)=sstats(:,3);
Fboxadd(:,5)=sstats(:,4);
Fboxadd(:,6)=sstats(:,8);
Fboxadd(:,7)=sstats(:,9);
C=~ismember(FltBoxUFN(:,1),Fboxadd(:,1));
NFB=cat(1,FltBoxUFN(C,:),Fboxadd);
FltBoxUFN=sortrows(NFB);
FltBoxUFN=real(FltBoxUFN);
save('Z:\BioDataLab\Atulya\Physiology Summary and Organization\FltBoxUFN.mat','FltBoxUFN')
abc=sstats;
% % F Test CODE HERE
% dffly=(sum(~isnan(sstats(:,1)))-1)
% MSB=nansum((sstats(:,1)-nanmean(sstats(:,1))).^2)/(sum(~isnan(sstats(:,1)))-1)
% dfall=nansum(sstats(:,10))
% MSW=nansum(sstats(:,2).^2.*sstats(:,10))./nansum(sstats(:,10))
% Frat=MSB/MSW
% df=[dffly,dfall]




