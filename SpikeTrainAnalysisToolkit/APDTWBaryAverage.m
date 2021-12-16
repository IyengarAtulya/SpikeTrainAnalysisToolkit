%DTW Barycenter Align Dev Script
%SigIn -ISICV structure, NR=number of iterations ~40 varargin=sho?
function abc=DTWBaryAlign(SigIn,NR,varargin)
if nargin>2
    sho=varargin{1};
else
    sho=1;
end
Sigs=SigIn;

if sho==1
    h=figure;
end
hold all
load('ECScmap2.mat')
cmap=ECScmap2;
if numel(Sigs)>10
    k=randperm(numel(Sigs),10);
else
    k=1:numel(Sigs);
end


for i=1:numel(Sigs)
    
    try
        if ismember(i,k)
            if sho==1
                plot(Sigs(i).data(:,3),Sigs(i).data(:,4),'Color',[0.5 0.5 0.5],'LineWidth',0.5)
                %patch([Sigs(i).data(:,3);nan],[Sigs(i).data(:,4);nan],[Sigs(i).data(:,1);nan],'facecolor','none','edgecolor','interp','LineWidth',1);
                axis([0 2.5 -2 0.5]);
                caxis([0 80]);
            end
        end
        nsk(i)=size(Sigs(i).data,1);
    catch
        nsk(i)=nan;
    end
end
fidx=find(nsk>20);
idx=fidx(randi(numel(fidx),1));
%idx = 1
disp(idx)
% snsk=sort(nsk);
% idx=find(nsk==snsk(floor(numel(snsk)/2)));
iniBarySig=real(Sigs(idx).data(:,[1,3,4]));
if isnan(iniBarySig(end,1))
    iniBarySig = iniBarySig(1:end-1,:);
end

    
iBS=iniBarySig;
%figure; plot(iniBarySig(:,2),iniBarySig(:,3))
axis([0 2.5 -2 0.5]);
npts=size(iniBarySig,1);
if sho==1
    h2= figure
end

for jj=1:NR
    jj;
    for i=1:npts
        toX{i}=[];
        toY{i}=[];
        toT{i}=[];
    end
    
    
    for i=1:numel(Sigs)
        try
            if ~isnan(nsk(i)) & nsk(i)>3
                B=real(Sigs(i).data(:,[1,3,4]));
                if isnan(B(end,1))
                    B = B(1:end-1,:);
                end
            else
                B=nan(1,3);
            end
            %     plot(B(:,2),B(:,3))
            %     plot(iniBarySig(:,2),iniBarySig(:,3));
            al=APisicvAlignDij(iniBarySig,B);
            if size(B,1)>18
                
                
                for j=1:npts
                    idx2=find(al.Spt(:,1)==j);
                    
                    if ~isempty(idx2)
                        try
                            
                            idx3=al.Spt(idx2,2);
                            tX=toX{j};
                            tY=toY{j};
                            tT=toT{j};
                            tT(end+1:end+numel(idx3))=B(idx3,1)';
                            tX(end+1:end+numel(idx3))=B(idx3,2)';
                            tY(end+1:end+numel(idx3))=B(idx3,3)';
                            toT{j}=tT;
                            toX{j}=tX;
                            toY{j}=tY;
                            
                        catch
                            tX
                        end
                        
                        
                    end
                    
                    
                end
            else
                %disp('nep');
            end
            
        catch
            1;
        end
        
    end
    
    for i=1:npts
        aT(i)=nanmean(toT{i});
        aX(i)=nanmean(toX{i});
        aY(i)=nanmean(toY{i});
        if isnan(aT(i))
            aT(i)=0;
        end
        if isnan(aX(i))
            aX(i)=0;
        end
        if isnan(aY(i))
            aY(i)=0;
        end
    end
    %filter aX and aY
    aX=filtfilt(ones(1,3)/3,1,aX(~isnan(aX)&~isinf(aY)));
    aY=filtfilt(ones(1,3)/3,1,aY(~isnan(aY)&~isinf(aY)));
    %     hold off
    %     plot(iBS(:,2),iBS(:,3))
    %     hold all
    %     plot(aX,aY)
    %     axis([0 2.5 -2.5 0.5])
    %     title(num2str(jj));
    %     hold  off
    
    iniBarySig(1:numel(aX),2)=aX';
    iniBarySig(1:numel(aX),3)=aY';
    if sho==1
        figure(h2)
        patch([aX(1:end-3)';nan],[aY(1:end-3)';nan],[aT(1:numel(aX)-3)';nan],'facecolor','none','edgecolor','interp','LineWidth',2);
        title(num2str(jj));
        axis([0 2.5 -2 0.5]);
        caxis([0 80]);
    end
end
if sho==1
    figure(h)
   % patch([aX(1:end-3)';nan],[aY(1:numel(aX)-3)';nan],[aT(1:numel(aX)-3)';nan],'facecolor','none','edgecolor','interp','LineWidth',2);
    patch(flipud([aX(1:end-3)';nan]),flipud([aY(1:numel(aX)-3)';nan]),flipud([aT(1:numel(aX)-3)';nan]),'facecolor','none','edgecolor','interp','LineWidth',2);
    colormap(cmap)
    caxis([0 90])
    
    axis([0 2.5 -2 0.5])
    
    xlabel('log(ISI^{-1}) (Hz)');
    ylabel('log(CV_2)');
    title('DTW Average');
end;
abc=[aT(1:numel(aX))',aX',aY'];



