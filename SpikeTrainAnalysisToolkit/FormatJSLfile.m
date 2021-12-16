function abc=FormatJSLfile(FILENAME)
PATH='D:\JSL Spike Time Data\';
[p n e]=fileparts(FILENAME);
XLFILENAME=[PATH,n];
[a b c]=xlsread(FILENAME);
ST=a(:,1);
h=figure;
plot(ST(2:end),1./diff(ST),'k*');
title(n)
axis([0 max([90,max(ST)]) 0 200])
[pl xs ys]=selectdata;
nST=[ST(1);xs];
prompt={'Etype';  'Genotype'; 'Sex'; 'Age';'Date';};
default={'ECS'; ''; ''; ''; ''};
answer=inputdlg(prompt,'MetaData',1,default);

demographics=cell(3,9);
demographics{1,1}=answer{1};
demographics{1,2}=answer{5};
demographics{1,3}='End Time';
demographics{1,4}=num2str(max(xs));
demographics{2,1}=n;
demographics{2,2}=answer{2};
demographics{2,3}='';
demographics{2,4}=answer{3};
demographics{2,5}=answer{4};
demographics{3,1}='Spike Time';
demographics{3,2}='Spike Amplitude';
demographics{3,3}='Stim Times';
demographics{3,4}='Stim Amplitude';
xlswrite(XLFILENAME,demographics,'Sheet1','A1');
try
    xlswrite(XLFILENAME,[nST, ones(size(nST))],'Sheet1','A4');
catch
    warndlg('Warning: No Spikes Detected or Selected');
end

abc=1;
delete(h);








