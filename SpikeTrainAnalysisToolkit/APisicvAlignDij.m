function abc=APisicvAlignDij(varargin)
%A spike train #1
%B spike train #2
%sho show analysis protocol
%type: 1- VP distance; 2- vanRossum distance; 3 log firing rate diff; 4 log CV
%diff; 5 log ISI and CV distance
%compparam: represents parameters used by each type
% Cmat=1- use C++ implementation, 2- matlab


if nargin==2
    A=varargin{1};
    B=varargin{2};
    sho=1;
    comptype=5;
    compparam=nan;
    Cmat=2;
end
if nargin==3
    A=varargin{1};
    B=varargin{2};
    sho=varargin{3};
    comptype=5;
    compparam=nan;
    Cmat=1;
end
if nargin==4
    A=varargin{1};
    B=varargin{2};
    sho=varargin{3};
    comptype=varargin{4};
    compparam=nan;
    Cmat=1;
end
if nargin==5
    A=varargin{1};
    B=varargin{2};
    sho=varargin{3};
    comptype=varargin{4};
    compparam=varargin{5};
    Cmat=1;
end
if nargin==6
    A=varargin{1};
    B=varargin{2};
    sho=varargin{3};
    comptype=varargin{4};
    compparam=varargin{5};
    Cmat=varargin{6};
end

A=real(A);
B=real(B);
if sho==1
    h=figure;
    subplot(4,1,1);
    hold all
    plot(A(:,1),.5,'+','Color',[.25 .25 .25],'MarkerSize',10)
    plot([0,90],[0.5 0.5],'-','Color',[.25 .25 .25]);
    plot(B(:,1),1.5,'+','Color',[0.2 0.5 1],'MarkerSize',10)
    plot([0,90],[1.5 1.5],'-','Color',[.2 .5 1]);
    axis([0 90 0 2])
    subplot(4,1,[2:4]);
    hold all
    plot(A(:,2),A(:,3),'-x','Color',[.25 .25 .25],'LineWidth',2)
    plot(B(:,2),B(:,3),'-x','Color',[0.25 0.5 1],'LineWidth',2);
    xlabel('log(FF)');
    ylabel('log(CV)')
   % legend('Spike Train #1','Spike Train #2')
    axis([0 2.5 -2 0.5])
    axis square
end
switch comptype
    case 1
        %VP distance, compparam represents the max "shift" value, values
        %above are considered to be a "remove/add" function
        if isnan(compparam)
            compparam=2;
        end
        
        dD=abs(bsxfun(@minus, A(:,1),B(:,1)'));
        dD(dD>compparam)=compparam;
        
    case 2
        if isnan(compparam)
            compparam=2;
        end
        dD=abs(bsxfun(@minus, A(:,1),B(:,1)'));
        dD=1-exp(-1*(dD./compparam));
    case 3
        %difference in log-spiking rate
        dD=abs(bsxfun(@minus, A(:,3),B(:,3)'));
    case 4
        %difference in log-CV
        dD=abs(bsxfun(@minus, A(:,3),B(:,3)'));
    case 5
        %combo of difference in log-spiking rate, log-CV
        dD=sqrt((bsxfun(@minus,A(:,2),B(:,2)')).^2+(bsxfun(@minus,A(:,3),B(:,3)')).^2);
    otherwise
        
        
end
% dT=bsxfun(@minus,A(:,1),B(:,1)');
dT=-1*ones(size(dD));
pdD=dD;

if sho==1
    cmap=[[1/256:1/256:1]',zeros(256,1),[1:-1/256:1/256]'];
    cmap(1,:)=[0 0 1];
    cmap(end,:)=[1 1 1];
    
    hh2 = figure
    imagesc(pdD)
    axis xy
    if comptype>2
        caxis([0 1.5])
    end
    colorbar
    colormap(jet)
    xlabel('Spike Train #1 (ordered)')
    ylabel('Spike Train #2 (ordered)')
    title('Distance from n^{th} spike to m^{th} spike');
end

if size(pdD,1)==size(pdD,2)
    if trace(pdD(1:end-1,1:end-1))==0
        Spt=[(1:size(pdD,1))',(1:size(pdD,2))'];
        abc.Spt=Spt;
        abc.aD=0;
        abc.visD=pdD;
        abc.pdD=pdD;
        return
        
    end
end
isv=zeros(size(pdD));
visD=inf(size(pdD));
nexD=nan(size(pdD));
Aidx=1;
Bidx=1;
isv(Aidx,Bidx)=1;
visD(Aidx,Bidx)=pdD(Aidx,Bidx);
if sho==1
    
    hh=figure;
end

iter=1;

%%%----------------- C++ mex implimentation
if Cmat==1
    
    % hh=figure
    %tic
    if min(size(pdD))>1
        pdD=pdD(1:end-1,1:end-1);
        %[d e f]=dp(pdD)
        [a b c]=dpfast(pdD);
        
        Spt=flipud([a',b']);
        
        abc.aD=c(end,end)+pdD(1,1);
    else
        Spt=[ones(max(size(dD)),1),[1:max(size(dD))]'];
        abc.pdD=dD;
        abc.aD=sum(dD);
    end
    

if sho==1
    figure(h)
    Spt=flipud(Spt);
    
    
    for i=[1,20:20:500,502:2:750,760:20:1000]
        subplot(4,1,[2:4]);
        line([A(Spt(i,1),2) B(Spt(i,2),2)],[A(Spt(i,1),3) B(Spt(i,2),3)],'Color','r', 'LineWidth',1);
        subplot(4,1,1)
        line([A(Spt(i,1),1) B(Spt(i,2),1)],[0.5 1.5],'Color','r');
        %FFF((i-1)/10+1)=getframe(h);
    end
    
end
end

%%%-----------------end C++ mex implementation



%%%%------------------MATLAB VISUALIZATION IMPLEMENT
if Cmat==2
    tic
    while Aidx<size(pdD,1)-1 || Bidx <size(pdD,2)-1
        %toc
        try
        currptval=visD(Aidx,Bidx);
        adjpts=[Aidx Bidx+1;Aidx+1 Bidx; Aidx+1 Bidx+1];
        adjpts=adjpts(adjpts(:,1)<=size(pdD,1)&adjpts(:,2)<=size(pdD,2),:);
        for i=1:size(adjpts,1)
            nexD(adjpts(i,1),adjpts(i,2))=pdD(adjpts(i,1),adjpts(i,2))+currptval;
        end
        nexD;
        visD((visD>nexD))=nexD((visD>nexD));
        ns=find(visD==min(visD(~isv)),1);
        newsub=ns(randi(numel(ns)));
        
        [Aidx Bidx]=ind2sub(size(pdD),newsub(1));
        isv(Aidx,Bidx)=1;
        iter=iter+1;
        
        
        if iter/250 ==round(iter/250)
            toc
            iter
            figure(hh)
            hold all
            imagesc(visD)
            plot(Bidx,Aidx,'g*')
            xlabel('Spike Train #1 (ordered)')
            ylabel('Spike Train #2 (ordered)')
            title('Minimum Distance from n^{th} spike to m^{th} spike');
            colormap(jet)
            colorbar
           % print -r600
            F(round(iter/25))=getframe(hh);
            %
        end
        try
            Aidx~=size(pdD,1)-1 || Bidx ~=size(pdD,2)-1;
        catch
            Aidx;
        end
        catch
            a=1;
        end
    end
    
    toc
    %toc
%     if sho==1
%         figure(hh)
%         imagesc(visD./max(size(pdD)))
%         colorbar;
%         colormap(cmap)
%         if comptype>2
%             caxis([0 4]);
%         end
%     end
    [v idx]=min(visD);
    count=1;
    optpat=zeros(size(visD));
    % hhh=figure;
    while Aidx~=1 || Bidx~=1
        if Aidx==1
            Sidx=2;
            v=visD(Aidx,Bidx-1);
        end
        if Bidx==1
            Sidx=1;
            v=visD(Aidx-1,Bidx);
        end
        if Aidx~=1 && Bidx~=1
            [v Sidx]=min([visD(Aidx-1,Bidx), visD(Aidx, Bidx-1), visD(Aidx-1, Bidx-1)]);
        end
        [Spt(count,1), Spt(count,2)]=ind2sub(size(visD),find(visD==v));
        Aidx=Spt(count,1);
        Bidx=Spt(count,2);
        optpat(Aidx,Bidx)=1;
        figure(hh2)
        hold all
        plot(Bidx,Aidx,'o','MarkerEdgeColor',[1 1 1])
        xlabel('Spike Train #1 (ordered)')
        ylabel('Spike Train #2 (ordered)')
        title('Minimum Distance from n^{th} spike to m^{th} spike');
        FF(count)=getframe(hh);
        count=count+1;
    end
    %toc
    if sho==1
        figure(h)
        
        for i=1:3:size(Spt,1)
            subplot(4,1,[2:4]);
            line([A(Spt(i,1),2) B(Spt(i,2),2)],[A(Spt(i,1),3) B(Spt(i,2),3)],'Color','g','LineWidth',3);
            subplot(4,1,1)
            legend off
            line([A(Spt(i,1),1) B(Spt(i,2),1)],[0.5 1.5],'Color','g','LineWidth',0.5);
            FFF((i-1)/3+1)=getframe(h);
        end
     
    end
    % nansum(nansum(optpat.*pdD));
    % if sho==1
    %     figure
    %
    %     imagesc(optpat.*pdD)
    %     colorbar
    %     caxis([0 2])
    % end
    % max(max(optpat.*pdD));
    % nanmean(nanmean(optpat.*pdD));
    abc.aD=sum(pdD((optpat==1)))+pdD(end-1,end-1);
end
%%%%--------------END MATLAB VISUALIZATION EX


% spdD=zeros(size(pdD));
% spdD(sub2ind(size(spdD),Spt(:,1),Spt(:,2)))=1;
abc.Spt=Spt;
% abc.aD=nansum(nansum(spdD.*pdD));
abc.visD=visD;
abc.pdD=pdD;
