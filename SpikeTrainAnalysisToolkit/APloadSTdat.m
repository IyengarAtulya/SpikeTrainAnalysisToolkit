function [num, varargout]=APloadSTdat(FILENAME)
[p n e]=fileparts(FILENAME);

if strcmp(e(end),' ')
   e = '.xlsx'
   FILENAME = [p,'\',n,e]
end

try
    load([p,'\',n,'.stm'],'-mat');
catch
    disp([p,'\',n,'.stm not found'])
    disp(['loading .xlsx file'])
    %[num, txt, raw]=xlsread(FILENAME);
    num = readmatrix(FILENAME,'NumHeaderLines',0);
end
nout=max(nargout,1);


if nout>1
        txt  = readcell(FILENAME,'TextType','char','DatetimeType','text');
    txt(cellfun(@(x) any(ismissing(x)), txt)) = {''};
    varargout{1}=txt;
end
if nout>2
    raw  = readcell(FILENAME,'TextType','char','DatetimeType','text');
    raw(cellfun(@(x) any(ismissing(x)), raw)) = {''};
    varargout{2}=raw;
    
end
