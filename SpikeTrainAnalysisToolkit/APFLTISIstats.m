function abc=APFLTISIstats(varargin)
FILENAME=varargin{1};
selspkval=0;
if nargin>1
selspkval=varargin{2};
end
pltff=0;
if nargin>2
pltiff=varargin{3};
end
timerange=[0 100000];
[p n e]=fileparts(FILENAME)
if strcmp(n(1:2),'20')
    timerange=[0 100000];
end


if nargin>3
timerange=varargin{4};
end


    [n t r]=APloadSTdat(FILENAME);

if size(n,1)>2
    ST=n(3:end,1);
    try
        maxT=n(1,4);
    catch
        maxT=max(ST);
    end
    if isnan(ST(1,1))
        ST=ST(2:end);
    end
else
    ST=[];
end
%ST(end+1)=maxT;
ST=ST(ST>timerange(1)&ST<timerange(2));
if ~isempty(ST)
    if selspkval==1
        Vals=ones(size(ST,1),1);
        ha=figure;
        plot(ST,Vals,'.');
        title(FILENAME)
        [ps xs ys]=selectdata;
        ST=xs;
        close(ha)
    end
    ISI=diff(ST);
    if pltiff==1
        t=ST(2:end);
        hb=figure;
        plot(t,1./ISI)
        axis([0, 1.1*max(t),0,1.1*max(1./ISI)])
        
    end
    
    abc.ISImean=nanmean(ISI);
    abc.ISIvar=nanvar(ISI);
    abc.ISIstd=nanstd(ISI);
    abc.ISIcv=nanstd(ISI)/nanmean(ISI);
    abc.ISI=ISI;
    abc.SCT=numel(ST)./maxT;
else
    abc.ISImean=nan;
    abc.ISIvar=nan;
    abc.ISIstd=nan;
    abc.ISIcv=nan;
    abc.ISI=nan;
    abc.SCT=0;
end