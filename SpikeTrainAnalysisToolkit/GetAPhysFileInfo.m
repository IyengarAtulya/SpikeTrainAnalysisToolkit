function abc=GetAPhysFileInfo(FILENAME)
%Returns structure of file info from APhys data
fid=fopen(FILENAME);
fseek(fid,-3000,'eof');
tline=fgetl(fid);
linefound=0;
while linefound==0
    tline=fgetl(fid);
    if strcmp(tline,'----------')==1
        linefound=1;
    end
    if strcmp(tline,'Electroconvulsive Seizure Paradigm')==1
        linefound=2;
    end
    if strcmp(tline,'==========')==1
        linefound=3;
    end
    if tline==-1
        error('Invalid File Type');
    end
end

% while strcmp(tline,'Electroconvulsive Seizure Paradigm')==0
%     tline=fgetl(fid);
%     if tline==-1
%         error('Invalid File Type');
%     end
% end
if linefound==1
    nline=fgetl(fid);
    abc.EType=nline;
    nline=fgetl(fid);
    abc.Operator=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Date=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Time=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Genotype=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Sex=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Age=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.PulseAmplitude=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.TestPulseFrequency=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.TestPulseDuration=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.BurstFrequency=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.BurstDuration=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.SamplingRate=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.Ch1Name=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Ch2Name=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Ch3Name=strtok(nline,'--');
    nline=fgetl(fid);
    [tok, rem]=strtok(nline,':');
    abc.Comments=rem;
end
if linefound==2
    abc.EType=tline;
    nline=fgetl(fid);
    abc.Operator=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Date=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Time=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Genotype=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Sex=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Age=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.PulseAmplitude=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.TestPulseFrequency=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.TestPulseDuration=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.BurstFrequency=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.BurstDuration=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.SamplingRate=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    [tok, rem]=strtok(nline,':');
    abc.Comments=rem;
end
if linefound==3
    nline=fgetl(fid);
    abc.EType=nline;
    nline=fgetl(fid);
    abc.Operator=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Date=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Time=strtok(nline,'--');
    nline=fgetl(fid);
    while ~strcmp(nline,'----------') && ischar(nline)
        nline = fgetl(fid);
    end
    nline=fgetl(fid);
    gt=strsplit(nline,'--');
    abc.Genotype=gt{1};
    nline=fgetl(fid);
    abc.Sex=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Age=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.LineName=strtok(nline,'--');
    nline=fgetl(fid);
    while ~strcmp(nline,'__________') && ischar(nline)
        nline = fgetl(fid);
    end
    nline=fgetl(fid);
    abc.PulseAmplitude=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.TestPulseFrequency=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.TestPulseDuration=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.BurstFrequency=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.BurstDuration=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.SamplingRate=str2num(strtok(nline,' '));
    nline=fgetl(fid);
    abc.Ch1Name=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Ch2Name=strtok(nline,'--');
    nline=fgetl(fid);
    abc.Ch3Name=strtok(nline,'--');
    nline=fgetl(fid);
     while ~strcmp(nline,'----------') && ischar(nline)
        nline = fgetl(fid);
    end
    nline=fgetl(fid);
    [tok, rem]=strtok(nline,':');
    abc.Comments=rem;
end
fclose(fid);





