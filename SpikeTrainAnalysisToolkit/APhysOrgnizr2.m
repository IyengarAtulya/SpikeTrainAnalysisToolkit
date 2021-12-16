function abc=APhysOrgnizr
%Adds new recordings to the database of recordings, Checks for validity of
%all files and re-makes database.
RAWDATPATH='D:\Recordings Hold';
% TABLEPATH='\\biodata1\Wu Lab\Lab\Atulya\Physiology Summary and Organization';
TABLEPATH='R:\BioDataLab\Atulya\Physiology Summary and Organization';
RECTABLENAME='R:\BioDataLab\Atulya\Physiology Summary and Organization\Recording Table.xlsx';
ICRECTABLENAME='R:\BioDataLab\Atulya\Physiology Summary and Organization\IC Recording Table.xlsx';
%RAWDATPATH=pwd;
PATHWAY=uigetdir(RAWDATPATH,'Please Select Folder to Analyze');
FILES=findfiles('txt',PATHWAY);
for i=1:size(FILES,2)
    [a b c]=fileparts(FILES{i});
    FN{i}=b;
end
rig=questdlg('Flight or Intracellular Recording?','Rig Identity','Flight','Intracellular','Flight');
if strcmp(rig,'Flight')
    [n,t,r]=xlsread(RECTABLENAME,'A2:A32000');
    clear n;
    clear r;
    NEXTline=size(t,1)+2;
    ADDpt=['A',num2str(NEXTline)];
    NF=setdiff(FN,t);
end
if strcmp(rig,'Intracellular')
    [n,t,r]=xlsread(ICRECTABLENAME,'A2:A32000');
    clear n;
    clear r;
    NEXTline=size(t,1)+2;
    ADDpt=['A',num2str(NEXTline)];
    NF=setdiff(FN,t);
end


if ~isempty(NF)
    for i=1:size(NF,2)
        NEWFILES{i}=[a,'\',NF{i},'.txt'];
    end
    LL=size(NEWFILES,2);
    infotable=cell(LL,20);
    for i=1:LL
        [pathn filen extn]=fileparts(NEWFILES{i});
        clear pathn;
        clear extn;
        infotable{i,1}=filen;
        infotable{i,5}=NEWFILES{i};
        try
            info=GetAPhysFileInfo(NEWFILES{i});
            infotable{i,2}=info.Operator;
            infotable{i,3}=info.Date;
            infotable{i,4}=info.Time;
            infotable{i,6}=info.Genotype;
            infotable{i,7}=info.Sex;
            infotable{i,8}=info.Age;
            infotable{i,9}=info.EType;
            infotable{i,10}=info.Comments;
            infotable{i,11}=info.LineName;
        catch
        end
    end
    if strcmp(rig,'Flight')
        xlswrite(RECTABLENAME,infotable,'Sheet1',ADDpt);
    end
    if strcmp(rig,'Intracellular')
        xlswrite(ICRECTABLENAME,infotable,'Sheet1',ADDpt);
    end
end
abc=NF;