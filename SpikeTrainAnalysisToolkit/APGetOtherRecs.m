function abc=APGetOtherRecs(FILENAME)
%Returns other available Channel Spike Trains
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\SpikeTimeAnalysis Table.xlsx');
recn=b(:,1);
for i=1:numel(FILENAME)
    abc{i,1}=FILENAME{i};
    try
        [p n e]=fileparts(FILENAME{i});
        [t1 r]=strtok(n,'_');
        [t2 r]=strtok(r,'_');
        chtype=strtok(r(2:end));
        fn=[t1,'_', t2];
        idx=find(ismember(recn,fn));
        abc{i,2}='';
        for j=1:3
            [pp nn ee]=fileparts(b{idx,j*3+1});
            if ~strcmp(nn,n)
                if ~strcmp(nn,'')
                    abc{i,2}=[p,'\',nn,e];
                end
                
                
                
            end
            abc{i};
        end
    catch
        ['error with ',num2str(i)]
    end
    
    
    
    
end
