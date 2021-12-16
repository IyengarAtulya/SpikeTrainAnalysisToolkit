function abc=APGetTracesFly(varargin)

if nargin>1
    FLYNUMXL=varargin{2};
else
    'Loading fly num excel sheet'
    [a b c]=xlsread('Z:\Lab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
    FLYNUMXL=c;
end

inpt=varargin{1};
if iscell(inpt)
    FILENAME=inpt;
    UFN=APgetflynum(FILENAME{1},FLYNUMXL);
else
    UFN=inpt;
end

allUFNs=cell2mat(FLYNUMXL(2:end,2));
idx=find(allUFNs==UFN);
sFN=FLYNUMXL(idx+1,:);
if nargin<3
    'Loading etype excel sheet'
    [a b c]=xlsread('Z:\Lab\Atulya\Physiology Summary and Organization\Experiment Type Table.xlsx');
    ETYPE=c;
else
    ETYPE=varargin{3};
end

ETYPE(ismember(ETYPE(:,1),sFN(:,1)),:);
retval=ETYPE(ismember(ETYPE(:,1),sFN(:,1)),:);

[p n e]=fileparts(FILENAME{1});
[s t]=strtok(n,'_');
[s t]=strtok(t,'_');

for i=1:size(retval,1)
retval(i,4)={[p,'\',retval{i,1},t,e]};
end


export2wsdlg({'Other Traces'},{['OT_',num2str(UFN)]},{retval},'export to workspace')
abc=retval;

