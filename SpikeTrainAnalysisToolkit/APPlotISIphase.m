function abc=APPlotISIphase(FILENAME,order,align,sho,varargin)
%order input not currently used
[a b c]=xlsread(FILENAME);
nST=a(4:end,1);
ST=nST(~isnan(nST));
try
    maxT=a(1,4);
catch
    maxT=max(ST);
    disp('Warning: maxT set to last spike')
end
if nargin>4
    range=varargin{1};
else
    range=[0 maxT]
end
try
    stimtimes=a(:,3);
catch
    stimtimes=nan;
end
offset=0;
if align==1
    offset=nanmax(stimtimes);
    sST=ST-offset;
    clear ST;
    ST=sST(sST>0);
    ST=ST(ST>=range(1)&ST<=range(2));
end
if numel(ST)>4
    
    
    
    if sho>0
        figure
        subplot(5,1,1)
        scatter(ST(1:end-1),log10(1./diff(ST)),10,ST(1:end-1),'filled');
        axis([0 100 0 2]);
        caxis([0 60]);
        load('ECScmap.mat')
        colormap(ECScmap);
        title(FILENAME,'Interpreter','none');

        subplot(5,1,2:5);
        if sho==1
            patch(flipud([-1*log10(diff(ST(1:end-1)));nan]),flipud([-1*log10(diff(ST(2:end)));nan]),flipud([ST(2:end-1);nan]),'facecolor','none','edgecolor','interp','LineWidth',2);
        else
             scatter(([-1*log10(diff(ST(1:end-1)));nan]),([-1*log10(diff(ST(2:end)));nan]),25,([ST(2:end-1);nan]),'filled');
        end
        axis([-1 2.5 -1 2.5])
        line([-1 2.5],[-1 2.5],'Color','k','LineStyle','--')
        xlabel('Inst. Firing Rate (Hz,z-1)');
        ylabel('Inst. Firing Rate (Hz, z+1)');
        
        colorbar
        %caxis([0 60])
        %print commands
%         [p n e]=fileparts(FILENAME);
%         PATH=['M:\Lab\Atulya\Lab Meetings\Figures for 15apr Mtg\Poincare Plots\'];
%         PRINTNAME=[PATH,n,'.jpeg'];
%         set(gcf,'PaperSize',[5 5])
%         set(gcf,'PaperPosition',[.5 .5 4.5 4.5])
%         print(gcf,'-r600','-djpeg',PRINTNAME)
    end
    abc(:,1)=ST(2:end-1);
    abc(:,2)=diff(ST(1:end-1));
    abc(:,3)=diff(ST(2:end));
    
else
    %if between 1-4 spikes
    if numel(ST)>0
        ['Few Spikes Available']
        pST(1)=0;
        pST(2:numel(ST)+1)=ST;
        pST(end+1)=maxT;
        abc(:,1)=pST(2:end-1);
        abc(:,2)=diff(pST(1:end-1));
        abc(:,3)=diff(pST(2:end));
    else
        %if no spikes
        ['No Spikes Available']
        abc(:,1)=maxT/2;
        abc(:,2)=maxT;
        abc(:,3)=maxT;
    end
end





