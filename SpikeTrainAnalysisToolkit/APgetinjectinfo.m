function abc=APgetinjectinfo(varargin)

if nargin<1
     [fn pn]=uigetfile('D:\Recordings Hold\*.txt','MultiSelect','on');
    if iscell(fn)
        for i=1:numel(fn)
        FILENAME{i}=[pn,fn{i}];
        end
    else
        FILENAME{1}=[pn,'\',fn];
    end
else
    FILENAME=varargin{1};
end

if nargin<2
    'Loading fly num excel sheet'
    [a b c]=xlsread('Z:\Lab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
    FLYNUMXL=c;
else
    FLYNUMXL=varargin{2};
end
for i=1:numel(FILENAME)
    FN(i)=APgetflynum(FILENAME{i},FLYNUMXL);
end
UFNs=cell2mat(FLYNUMXL(2:end,2));

if nargin<3
    'Loading etype excel sheet'
    [a b c]=xlsread('Z:\Lab\Atulya\Physiology Summary and Organization\Experiment Type Table.xlsx');
    ETYPE=c;
else
    ETYPE=varargin{3};
end


allFNs=FLYNUMXL(find(ismember(UFNs,FN))+1,1);

FNetype=ETYPE(ismember(ETYPE(:,1),allFNs),:);
injectname=FNetype{strcmp('Inject Activity',FNetype(:,3)),1};

Ij=FNetype(strcmp('Inject Activity',FNetype(:,3)),1);
for i=1:numel(Ij)
InjectFiles{i}=['D:\Recordings Hold\',Ij{i},'.txt'];
end
Injectinfo=APrecinfo(InjectFiles');
for i=1:numel(Ij)
IFN(i)=APgetflynum(Ij{i},FLYNUMXL);
end

[im, icob]=ismember(FN',IFN');
notfound=unique(FN(icob==0));
for i=1:numel(notfound)
    if ~isnan(notfound(i))
        SELMETH=questdlg(['Select Acq',num2str(notfound(i))],'NotFound','Time','Trace','Trace');
        if strcmp(SELMETH,'Trace')
            tosel=FLYNUMXL(find(cell2mat(FLYNUMXL(2:end,2))==notfound(i))+1,1);
            selval=listdlg('PromptString',num2str(notfound(i)),'ListString',tosel);
            Injectinfo(end+1)=APrecinfo(['D:\Recordings Hold\',tosel{selval},'.txt']);
            IFN(end+1)=notfound(i);
        else
            injecttime=inputdlg('Injection Time','InjectTime',1,'12:00:00 PM');
            IFN(end+1)=notfound(i);
            Injectinfo(end+1).Time=injecttime;
        end
    end
end

[im, icob]=ismember(FN',IFN');
for i=1:numel(icob)
if icob(i)>0
injecttime{i}=Injectinfo(icob(i)).Time;
end
end


for i=1:numel(FILENAME)
    try
        reci(i)=APrecinfo(FILENAME(i));
        recT{i}=reci(i).Time;
    end
end
t=[injecttime',recT'];

for i=1:size(t,1)
for j=1:size(t,2)
try
DT(i,j)=datetime(t(i,j),'InputFormat','hh:mm:ss a');
catch
DT(i,j)=datetime(01,01,01,00,00,01);
end
end
end
ET=DT(:,2)-DT(:,1);
ET(abs(ET)>duration(24,0,0))=nan;
offset=duration(0,4,30);
ET=seconds(ET+offset);
abc=[FILENAME',num2cell(ET)];

