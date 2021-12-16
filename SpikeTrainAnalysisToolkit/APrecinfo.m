function abc=APrecinfo(FILENAMES)
if isnumeric(FILENAMES)
    [fn pn]=uigetfile('D:\Recordings Hold\*.txt');
    filename={[pn fn]};
end
if iscellstr(FILENAMES)
    filename=FILENAMES;
end
if ischar(FILENAMES)
    filename={FILENAMES};
end

for i=1:numel(filename)
    try
    info(i)=GetAPhysFileInfo(filename{i});
    catch
        info(i).Etype='';
        info(i).Operator='';
        info(i).Date='';
        info(i).Time='';
        info(i).Genotype='';
        info(i).Sex='';
        info(i).Age='';
        info(i).LineName='';
        info(i).PulseAmplitude='';
        info(i).TestPulseFrequency='';
        info(i).TestPulseDuration='';
        info(i).BurstFrequency='';
        info(i).BurstDuration='';
        info(i).SamplingRate='';
        info(i).Ch1Name='';
        info(i).Ch2Name='';
        info(i).Ch3Name='';
        info(i).Comments='';
    end
    
end
abc=info;