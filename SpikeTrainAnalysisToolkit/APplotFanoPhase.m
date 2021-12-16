function abc=APplotFanoPhase(FILENAME,ETYPE,ROOT,FiltSz,filttype,sho,varargin)
%Plots instantaneous firing frequency vs Fano Factor or CV
%FILENAME- Excel File to be analyzed
%Etype= if = 2 will norm on LED ch
%       if =1, will normalize to the LAST stim time
%       if =0, will not normalize times
%Root= if =1 the result is the Fano Factor (units s)
%      if =2 the result is the CV (dimensionless)
%Filtsz= size of the runnin mean filter used in the FiltFilt command
%filttype= if =1 arithmetic means CV
%          if =2 geometric means and CV
if ~isnumeric(FILENAME)
    [a b c]=APloadSTdat(FILENAME);
    try
        maxt=a(1,4);
    catch
        maxt=max(a(:,1));
    end
    ST=a(4:end,1);
    
else
    ST=FILENAME;
end
if ETYPE==1
    try
        endstim=nanmax(a(:,3));
    catch
        endstim=0;
        ['Warning, endstim not found, set to 0'];
    end
else
    endstim=0;
end
if ETYPE==2
    try
        endstim=nanmax(a(:,8));
    catch
        endstim=0;
        ['Warning, endstim not found, set to 0'];
    end
end

if ETYPE ==3
    try
        TraceFile = APgetTraceFile(FILENAME);
        led_off = APLEDchTiming(TraceFile);
        endstim = led_off{1};
    catch
        try
            D =importdata(TraceFile);
            D =importdata(TraceFile);
            LedCh = D(:,5);
            led_off = APLEDstimProps(LedCh,D(:,1),20000);
            endstim = led_off(1);
        catch
           endstim=0;
        ['Warning, endstim not found, set to 0']; 
        end
        %endstim=0;
        %['Warning, endstim not found, set to 0'];
    end
end

yax='';
if ROOT==1
    if filttype==1
        yax='log(Fano Factor) (Hz)';
    end
    if filttype==2
        yax='F(log(1/ISI)) (Hz)';
    end
end
if ROOT==2
    yax='log(CV)';
end
if numel(varargin)>0
    endst=varargin{2};
    startst=0;
else
    endst=inf;
    startst=0;
end
if numel(varargin)>1
    startst=varargin{1};
else
    startst=0;
end

% return if insufficient # of pts

fST=ST(ST>endstim);

ST=fST;
ST=ST-endstim;
ST=ST(ST>=startst);
ST=ST(ST<=endst);

% if ETYPE==2
%     try
%         ST=ST(ST<20);
%     end
% end
if numel(ST)<3.5*FiltSz
    if numel(ST)>1
        {['Warning: Too Few Spikes in ',FILENAME];['Returning inst ISI and overall CV']}
        dST(1)=nan;
        dST(2:numel(ST))=1./diff(ST);
        mdST=nanmean(dST);
        dST(1)=mdST;
        CV=std(dST)./mean(dST);
        lfdST=ones(1,numel(ST)-2)*log10(mean(dST));
        dlfdST=diff(lfdST);
        dlfdST(end+1)=0;
        lCV=ones(1,numel(ST)-2)*log10(CV);
        dlCV=diff(lCV);
        dlCV(end+1)=0;
        abc=[ST(2:end-1)';dST(2:end-1);lfdST;lCV;dlfdST;dlCV]';
        if sho>0
            figure
            title({FILENAME;['Warning: Too Few Spikes returning inst ISI and overall CV']})
            try
                maxt=a(1,4);
                
                
                annotation('textbox',[.25 .25 .5 .5],'String',{num2str(ST);num2str(abc)})
                
            catch
                abc=[nan,nan,nan,nan,nan,nan];
            end
        end
        return;
    else
        
        {['Warning: 0 or 1 spike(s) detected in ',FILENAME];['Returning Null values for ISI and CV']}
        abc=[0,1/(maxt-endstim),log10(1/(maxt-endstim)),0,0,0];
        
        if sho>0
            
            figure
            
            title({FILENAME;['Warning: No spikes detected returning NaN values for ISI and CV']})
            abc=[0,1/(maxt-endstim),log10(1/(maxt-endstim)),0,0,0];
        end
        return;
    end
end
clear fST
dST(1)=nan;
dST(2:numel(ST))=1./diff(ST);

mdST=nanmean(dST);
dST(1)=mdST;


if filttype==1
    lstat=AParithFFCV(dST,FiltSz,ROOT);
    lfdST=lstat(1,:);
    lCV=lstat(2,:);
    clear lstat;
end
if filttype==2
    lstat=APgeomFFCV(dST,FiltSz,ROOT);
    lfdST=lstat(1,:);
    lCV=lstat(2,:);
    clear lstat;
end
if ROOT==1
    lowlCV=-5;
else
    lowlCV=-2.5;
end
    
dlCV=diff(lCV);
dlfdST=diff(lfdST);
if sho>=1
    figure
    subplot(4,1,2:4)
    hold all
    %     quiver(lfdST(1:end-2),lCV(1:end-2),dlfdST(1:end-1),dlCV(1:end-1),0,'Color','k');
    %scatter(lfdST,lCV,200,ST(2:end-1),'.');
    nlfdST=[lfdST,nan];
    nlCV=[lCV,nan];
    nST=[ST',nan];
    colormap(jet);
    load('ECScmap.mat')
    colormap(ECScmap);
    
%     colormapeditor
%     
   cmap=colormap;
%    %%%flip plot order
%    ST=flipud(ST);
%    nlfdST=fliplr(nlfdST);
%    nlCV=fliplr(nlCV);
%    nST=fliplr(nST);
%    %%%%
   
    patch(nlfdST,nlCV,nST(2:end-1),'facecolor','none','edgecolor','interp','LineWidth',2);
    % plot(log10(fdST),log10(fsdST./fdST),'k-.')
    colormap(cmap)
    axis([0 2.5 -2 0.5])
    %caxis([0 90])
    xlabel('log(1/ISI) (Hz)')
    ylabel(yax)
    axis('square')
    
    subplot(4,1,1)
    %plot(ST,log10(dST),'k.')
    hold all
    patch([ST(2:end-1)',nan],[10.^lfdST,nan],[ST(2:end-1)', nan],'facecolor','none','edgecolor','interp','LineWidth',2)
    %scatter(ST(2:end-1),lfdST,25,ST(2:end-1),'.');
    colormap(cmap)
     %caxis([0 90])
    ax=axis;
    ax(1)=0;
    ax(3)=0;
    ax(4)=50;
    axis(ax);
    
%     axis([0 90 0 50])
    %caxis([0 90])
    title(FILENAME,'Interpreter','none')
    xlabel('Time(s)');
    ylabel('(Hz)')
    % ST=flipud(ST);
%    nlfdST=fliplr(nlfdST);
%    nlCV=fliplr(nlCV);
%    nST=fliplr(nST);
end
if sho>1
    figure
    subplot(2,1,1)
    plot(ST,log10(dST),'k.')
    hold all
    scatter(ST(2:end-1),lfdST,25,ST(2:end-1),'.');
    axis([0 90 0 2.5])
    %caxis([0 90])
    title(FILENAME,'Interpreter','none')
    xlabel('Time(s)');
    ylabel('log(1/ISI) (Hz)')
    subplot(2,1,2)
    plot(ST,log10(dST),'k.')
    hold all
    scatter(ST(2:end-1),lCV,25,ST(2:end-1),'.');
    axis([0 90 lowlCV 2.5])
    %caxis([0 90])
    xlabel('Time(s)');
    ylabel('log(Fano Factor) (Hz)')
end
if sho>1
    figure
    scatterhist(lfdST,lCV,'Direction','out')
    axis([0 2.5 lowlCV 2.5])
end
boundpts=zeros(1,numel(lfdST));
blfdST=intersect(find(lfdST<quantile(lfdST,.95)),find(lfdST>quantile(lfdST,.05)));
blCV=intersect(find(lCV<quantile(lCV,.95)),find(lCV>quantile(lCV,.05)));
boundpts(intersect(blfdST,blCV))=1;
if sho>1
    figure
    hold all
    plot(lfdST,lCV,'k.-')
    slfdST=lfdST(find(boundpts));
    slCV=lCV(find(boundpts));
    k2=convhull(slfdST,slCV);
    plot(slfdST(k2),slCV(k2),'r')
    axis([0 2.5 lowlCV 2.5])
end
dlfdST=diff(lfdST);
dlfdST(end+1)=0;
dlCV=diff(lCV);
dlCV(end+1)=0;


   

abc=[ST(2:end-1)';dST(2:end-1);lfdST;lCV;dlfdST;dlCV]';




