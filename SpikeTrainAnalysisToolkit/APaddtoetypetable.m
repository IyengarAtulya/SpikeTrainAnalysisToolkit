function abc=APaddtoetypetable(FILENAME,Etype)
ETABLE=('R:\BioDataLab\Atulya\Physiology Summary and Organization\Experiment Type Table.xlsx');
if strcmp('Intracellular',Etype)
    ETABLE=('R:\BioDataLab\Atulya\Physiology Summary and Organization\IC Experiment Type Table.xlsx');
end
[n t r]=xlsread(ETABLE,'B2:B32000');
ADDline=size(t,1)+2;
[k r]=ismember(FILENAME,t);
if k==1
    ADDline=r+1;
end
CRN=['A',num2str(ADDline)];
LINE=cell(1,3);
[path name extn]=fileparts(FILENAME);
LINE{1}=name;
LINE{2}=FILENAME;
LINE{3}=Etype;
xlswrite(ETABLE,LINE,'Sheet1',CRN);
abc=1;