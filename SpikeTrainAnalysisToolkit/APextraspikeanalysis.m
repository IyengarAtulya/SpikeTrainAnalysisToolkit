function abc=APextraspikeanalysis(varargin)
if nargin>=1
    FILENAME=varargin{1};
    lat=20;
end
if nargin>=2
    FILENAME=varargin{1}
    lat=varargin{2};
end
RecPath='D:\Recordings Hold';
[p n e]=fileparts(FILENAME)
[t1 r]=strtok(n,'_');
[t2 r]=strtok(r,'_');
RecNAME=[RecPath,'\',t1,'_',t2,'.txt'];
ch=0
if strfind(r,'L_DLM')
    ch=3;
end
if strfind(r,'R_DLM')
    ch=2;
end
if ch>0
    [a b c]=xlsread(FILENAME);
    dat=importdata(RecNAME);
    abc=APshortlatencyanalysis(dat,ch,lat);
else
    abc=nan(150,3);
end


