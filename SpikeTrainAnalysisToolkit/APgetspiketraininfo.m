function abc=APgetspiketraininfo(FILENAME)
%[a b c]=xlsread(FILENAME);
b = readcell(FILENAME,'TextType','char','DatetimeType','text');
info.SpkParadigm=b{1,1};
b(cellfun(@(x) any(ismissing(x)), b)) = {''};
info.DateAnalyzed=b{1,2};
info.FileName=b{2,1};
info.Genotype=b{2,2};
info.LineID=b{2,3};
info.Sex=b{2,4};
msgbox({['Paradigm: ',info.SpkParadigm];['File: ', info.FileName];['Date Analyzed: ', info.DateAnalyzed]; ['Genotype: ', info.Genotype]; ['Line ID: ', info.LineID]; ['Sex: ', info.Sex]});
abc=info;
