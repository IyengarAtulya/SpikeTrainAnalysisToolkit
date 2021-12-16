function abc=APaddtoICspktmtable(ch_disc)
NAME=ch_disc{1};
SPKTMTABLE=('Z:\Lab\Atulya\Physiology Summary and Organization\IC SpikeTimeAnalysis Table.xlsx');
[n t r]=xlsread(SPKTMTABLE,'A2:A32000');
ADDline=size(t,1)+2;
[k r]=ismember(NAME,t);
if k==1
    ADDline=r+1;
end
CRN=['A',num2str(ADDline)];
xlswrite(SPKTMTABLE,ch_disc,'Sheet1',CRN);


