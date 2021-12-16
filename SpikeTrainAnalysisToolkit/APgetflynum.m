function abc=APgetflynum(FILENAME,FLYNUMXL)
[p n e]=fileparts(FILENAME);
FILENAME=n;
if ~iscell(FLYNUMXL)
    'Loading fly num excel sheet'
    [a b c]=xlsread('R:\Lab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
    FLYNUMXL=c;
end
[recday remain]=strtok(FILENAME,'_');
recn=strtok(remain,'_');
rec=[recday,'_',recn];
idx=find(strcmp(rec,FLYNUMXL(:,1)));
if isempty(idx)
    abc=nan;
else
    abc=FLYNUMXL{idx,2};
end


    