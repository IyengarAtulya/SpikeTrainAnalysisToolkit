function varargout = APSpkStatMenu_v2(varargin)
% APSPKSTATMENU_V2 MATLAB code for APSpkStatMenu_v2.fig
%      APSPKSTATMENU_V2, by itself, creates a new APSPKSTATMENU_V2 or raises the existing
%      singleton*.
%
%      H = APSPKSTATMENU_V2 returns the handle to a new APSPKSTATMENU_V2 or the handle to
%      the existing singleton*.
%
%      APSPKSTATMENU_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APSPKSTATMENU_V2.M with the given input arguments.
%
%      APSPKSTATMENU_V2('Property','Value',...) creates a new APSPKSTATMENU_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APSpkStatMenu_v2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APSpkStatMenu_v2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APSpkStatMenu_v2

% Last Modified by GUIDE v2.5 30-Dec-2020 23:23:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @APSpkStatMenu_v2_OpeningFcn, ...
    'gui_OutputFcn',  @APSpkStatMenu_v2_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before APSpkStatMenu_v2 is made visible.
function APSpkStatMenu_v2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APSpkStatMenu_v2 (see VARARGIN)
handles.FILEPOOL=cell(0,1);
handles.GROUPPOOL=struct('name',{},'files',{});

handles.STDATPATH='D:\Spike Time Data\';
handles.LISTPATH='R:\BioDataLab\Atulya\Physiology Summary and Organization\Lists';
handles.DATAPATH='D:\';
handles.MICDATPATH='D:\Recordings Hold\';

set(handles.text1,'String','0 items')

if ~isempty(varargin)
    FILENAMES=varargin{1};
    handles.FILEPOOL=union(handles.FILEPOOL,FILENAMES);
    set(handles.file_list,'String',handles.FILEPOOL);
    set(handles.file_list,'Value',1);
    
    set(handles.text1,'String',[num2str(size(handles.FILEPOOL,2)),' items']);
    
end


handles.instphaseoptions=[0 0 0];

% Choose default command line output for APSpkStatMenu_v2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APSpkStatMenu_v2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APSpkStatMenu_v2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function O_Callback(hObject, eventdata, handles)
% hObject    handle to O (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function About_btn_Callback(hObject, eventdata, handles)
% hObject    handle to About_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=msgbox('Created by Atulya Iyengar, Wu Lab, University of Iowa','About','help');

% --------------------------------------------------------------------
function Steady_State_Analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Steady_State_Analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ECS_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to ECS_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Disc_Stats_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Disc_Stats_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filevalue=get(handles.group_file_list,'Value');
fv=filevalue(1);
fname=handles.GROUPFILE{fv};
fltstat=APFLTISIstats(fname,0,0);
msgbox({[fname];['ISI mean: ',num2str(fltstat.ISImean)];['ISI SD: ',num2str(fltstat.ISIstd)];['ISI CV: ',num2str(fltstat.ISIcv)];['ISI^{-1}: ',num2str(1./fltstat.ISImean)]})
clear filevalue;

% --------------------------------------------------------------------
function Grp_Stats_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Grp_Stats_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AnalyzeAll=questdlg('Analyze Groups or Specified Group?','Group Analysis','All','Specified','Cancel','All');

if strcmp(AnalyzeAll,'Specified')==1
    clear GROUP;
    clear A;
    clear B;
    clear C;
    clear M;
    clear ISImean;
    clear ISIstd;
    clear ISIcv;
    clear fltstat;
    GroupN=get(handles.group_list,'Value');
    GROUP=handles.GROUPPOOL(GroupN);
    for i=1:numel(GROUP.files)
        
        try
            fltstat(i)=APFLTISIstats(GROUP.files{i},0,0);
            ISImean(i)=fltstat(i).ISImean;
            ISIstd(i)=fltstat(i).ISIstd;
            ISIcv(i)=fltstat(i).ISIcv;
            [pathstr, B{i}, extn]=fileparts(GROUP.files{i});
        catch
            ISImean(i)=nan;
            ISIstd(i)=nan;
            ISIcv(i)=nan;
        end
    end
    [FILE PATH]=uiputfile('*.xlsx');
    M(1,:)=ISImean;
    M(2,:)=ISIstd;
    M(3,:)=ISIcv;
    M=M';
    A={'Mean ISI','SD ISI','CV ISI'};
    C=handles.GROUPPOOL(GroupN).name;
    xlswrite([PATH,FILE],M,'Sheet1','B2');
    xlswrite([PATH,FILE],A,'Sheet1','B1');
    xlswrite([PATH,FILE],B','Sheet1','A2');
    xlswrite([PATH,FILE],C,'Sheet1','A1');
end
if strcmp(AnalyzeAll,'All')==1
    h=waitbar(0,'Currently Analyzing Group #');
    [FILE PATH]=uiputfile('*.xlsx');
    for j=1:numel(handles.GROUPPOOL)
        waitbar(j/size(handles.GROUPPOOL,2),h,['Currently Analyzing Group #',num2str(j)]);
        clear GROUP;
        clear A;
        clear B;
        clear C;
        clear M;
        clear ISImean;
        clear ISIstd;
        clear ISIcv;
        clear fltstat;
        Sheet=['Sheet',num2str(j)];
        GROUP=handles.GROUPPOOL(j);
        for i=1:size(GROUP.files,2)
            try
                fltstat(i)=APFLTISIstats(GROUP.files{i},0,0);
                ISImean(i)=fltstat(i).ISImean;
                ISIstd(i)=fltstat(i).ISIstd;
                ISIcv(i)=fltstat(i).ISIcv;
                [pathstr, B{i}, extn]=fileparts(GROUP.files{i});
            catch
                ISImean(i)=nan;
                ISIstd(i)=nan;
                ISIcv(i)=nan;
            end
        end
        M(1,:)=ISImean;
        M(2,:)=ISIstd;
        M(3,:)=ISIcv;
        M=M';
        A={'Mean ISI','SD ISI','CV ISI'};
        C=handles.GROUPPOOL(j).name;
        xlswrite([PATH,FILE],M,Sheet,'B2');
        xlswrite([PATH,FILE],A,Sheet,'B1');
        xlswrite([PATH,FILE],B',Sheet,'A2');
        xlswrite([PATH,FILE],C,Sheet,'A1');
    end
    close(h);
end
guidata(hObject,handles);




% --------------------------------------------------------------------
function RSD_Analysis_btn_Callback(hObject, eventdata, handles)
% hObject    handle to RSD_Analysis_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filevalue=get(handles.group_file_list,'Value');
fv=filevalue(1);
fname=handles.GROUPFILE{fv};
[a b c]=xlsread(fname);
ST=a(3:end,1);
if isnan(ST(1,1))
    ST=ST(2:end,1);
end
inputs=inputdlg({'please enter min bin size'; 'please enter max bin size';'please enter number of steps';'please enter bin overlap (0-.99)'}, 'rate SD analysis', 1,{'0.1';'10';'10';'0'});
if ~isempty(inputs)
    minbinsz=str2num(inputs{1});
    maxbinsz=str2num(inputs{2});
    nbins=str2num(inputs{3});
    overlap=str2num(inputs{4});
    h=APrsdplot2(ST,nbins,minbinsz,maxbinsz,overlap);
    figure(h)
    title([fname, 'RSD Analysis']);
end




% --------------------------------------------------------------------
function Fano_Factor_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Fano_Factor_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AnalysisType=questdlg('Choose Analysis Type','Analysis Type','Within Group','Across Groups','Cancel','Within Group');
inputs=inputdlg({'please enter min bin size'; 'please enter max bin size';'please enter number of steps';'please enter bin overlap (0-.99)'}, 'rate SD analysis', 1,{'0.1';'10';'20';'0'});
if ~isempty(inputs)
    Binmin=str2num(inputs{1});
    Binmax=str2num(inputs{2});
    NBinSizes=str2num(inputs{3});
    overlap=str2num(inputs{4});
end
if isempty(inputs)
    overlap=0;
    Binmin=0.01;
    Binmax=10;
    NBinSizes=10;
end
Binsizes=logspace(log10(Binmin),log10(Binmax),NBinSizes);
if strcmp(AnalysisType, 'Within Group')==1
    h=waitbar(0,'Processing file #0');
    FILES=handles.GROUPFILE(get(handles.group_file_list,'Value'));
    for i=1:numel(FILES);
        waitbar(i/numel(FILES),h,['Processing file#',num2str(i)]);
        [a b c]=xlsread(FILES{i});
        ST=a(3:end,1);
        for j=1:NBinSizes
            try
                Ni=APBinCounts(ST,Binsizes(j),overlap);
                FF(i,j)=var(Ni(2,:))/mean(Ni(2,:));
            catch
                FF(i,j)=nan;
            end
            
        end
        
    end
    close(h)
    figure
    hold all
    for i=1:numel(FILES);
        plot(-log10(Binsizes),log10(FF(i,:)),'Color',[.25 .25 .25])
    end
    figure
    plot(-log10(Binsizes),log10(nanmean(FF)),'k');
    
    
end
if strcmp(AnalysisType, 'Across Groups')==1
    h=waitbar(0,['Processing Group #0, File#0']);
    nGRPS=size(handles.GROUPPOOL,2);
    for i=1:nGRPS
        
        ntraces=size(handles.GROUPPOOL(i).files,2);
        lnames(i)=handles.GROUPPOOL(i).name;
        for j=1:ntraces
            waitbar(((i-1)/nGRPS)+(j/ntraces)*1/nGRPS,h,['Processing Group #',num2str(i),', File #',num2str(j)]);
            [a b c]=xlsread(handles.GROUPPOOL(i).files{j});
            ST=a(3:end,1);
            for k=1:NBinSizes
                try
                    Ni=APBinCounts(ST,Binsizes(k),overlap);
                    FF(j,k)=var(Ni(2,:))/mean(Ni(2,:));
                catch
                    FF(j,k)=nan;
                end
            end
        end
        mFnF(i,:)=nanmean(log10(FF));
        semFnF(i,:)=nanstd(log10(FF))/sqrt(ntraces);
    end
    close(h)
    figure
    hold all
    for i=1:nGRPS;
        errorbar(log10(Binsizes),mFnF(i,:),semFnF(i,:));
    end
end


% --------------------------------------------------------------------
function Allen_Factor_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Allen_Factor_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Periodogram_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Periodogram_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Load_File_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Load_File_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FILE PATH IDX]=uigetfile('*.xlsx','Please Select File(s) to add',handles.STDATPATH,'MultiSelect','on');
if ~isnumeric(FILE)
    if ~iscell(FILE)
        cFILE=cell(1,1);
        cFILE{1}=FILE;
        FILE=cFILE;
        clear cFILE;
    end
    for i=1:size(FILE,2)
        FILE{1,i}=[PATH,'\',FILE{1,i}];
    end
    handles.FILEPOOL=union(handles.FILEPOOL,FILE);
    set(handles.file_list,'String',handles.FILEPOOL);
    set(handles.file_list,'Value',1);
end
set(handles.text1,'String',[num2str(size(handles.FILEPOOL,2)),' items']);
guidata(hObject,handles);

% --------------------------------------------------------------------
function Load_List_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Load_List_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pFILE PATH]=uigetfile('R:\BioDataLab\Atulya\Physiology Summary and Organization\Lists\*.txt','MultiSelect','on');
if ~iscell(pFILE)
    if pFILE==0
        return
    end
end
FILE={};
if ~iscell(pFILE)
    FILE{1}=pFILE;
end
if iscell(pFILE)
    FILE=pFILE;
end
clear pFILE;

for i=1:size(FILE,2)
    nfiles=importdata([PATH,'\',FILE{i}]);
    for j=1:size(nfiles,1)
        [a b c]=fileparts(nfiles{j});
        fn{j}=[handles.STDATPATH,b,c];
    end
    if ~isempty(strfind(PATH,'JsL Lists'));
        disp(['using original path']);
        clear fn
        for j=1:size(nfiles,1)
            [a b c]=fileparts(nfiles{j});
            fn{j}=[a,'\',b,c];
        end
    end
    clear nfiles;
    nfiles=fn;
    clear fn;
    handles.FILEPOOL=union(nfiles',handles.FILEPOOL);
end
set(handles.file_list,'String',handles.FILEPOOL);
set(handles.file_list,'Value',1);
set(handles.text1,'String',[num2str(size(handles.FILEPOOL,2)),' items']);
CreateGrp=questdlg('Do you want to create a group from this list?');
if strcmp(CreateGrp,'Yes')
    GROUPNAME={};
    if ~isempty(handles.GROUPPOOL)
        for i=1:size(handles.GROUPPOOL,2)
            GROUPNAME(i)=handles.GROUPPOOL(i).name;
        end
    end
    prevGRPsz=size(GROUPNAME,2);
    for i=1:size(FILE,2)
        [a pGn c]=fileparts([PATH,'\',FILE{i}]);
        nG={};
        nG{1}=pGn;
        while ismember(nG,GROUPNAME)
            nG=inputdlg('Warning: proposed name matches previously named group. Please re-enter name.','Group Name',1,nG(1));
        end
        GROUPNAME(prevGRPsz+i)=nG;
        handles.GROUPPOOL(prevGRPsz+i).name=nG;
        %         handles.GROUPPOOL(prevGRPsz+i).files=importdata([PATH,'\',FILE{i}]);
        nfiles=importdata([PATH,'\',FILE{i}]);
        for j=1:size(nfiles,1)
            [a b c]=fileparts(nfiles{j});
            fn{j}=[handles.STDATPATH,b,c];
        end
        if ~isempty(strfind(PATH,'JsL Lists'));
            disp(['using original path']);
            clear fn
            for j=1:size(nfiles,1)
                [a b c]=fileparts(nfiles{j});
                fn{j}=[a,'\',b,c];
            end
        end
        clear nfiles;
        handles.GROUPPOOL(prevGRPsz+i).files=fn';
        clear fn;
        
        handles.GROUPPOOL(prevGRPsz+i).loc=[PATH,'\',FILE{i}];
        
    end
    
end
clear GROUPNAME
if ~isempty(handles.GROUPPOOL)
    for i=1:size(handles.GROUPPOOL,2)
        GROUPNAME(i)=handles.GROUPPOOL(i).name;
    end
end
set(handles.group_list,'String',GROUPNAME);
set(handles.group_list,'Value',1);
handles.GROUPFILE=handles.GROUPPOOL(1).files;
set(handles.group_file_list,'String',handles.GROUPFILE);
set(handles.group_file_list,'Value',1);
guidata(hObject,handles);


%-----------------------------------------
function Save_List_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Save_List_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Options_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Options_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Close_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Close_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in file_list.
function file_list_Callback(hObject, eventdata, handles)
% hObject    handle to file_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns file_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from file_list


% --- Executes during object creation, after setting all properties.
function file_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Plt_Binned_Spike_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Plt_Binned_Spike_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


A=questdlg('Select Data Source','Binned Firing Freq. Plot','All','Group','Trace','All');
BinSzst=inputdlg('Enter Bin Size (ms)','Bin Size',1,{'1000'});
BinSz=str2num(BinSzst{1});
BinOlst=inputdlg('Enter Bin Overlap (0=None to 1=Complete)','Bin Overlap',1,{'0'});
BinOl=str2num(BinOlst{1});
if~isempty (BinSz)
    if ~isempty(BinOl)
        if strcmp(A,'All')
            TGTPATH=uigetdir;
            TGTflSfx=inputdlg('Enter Target File Suffix','Suffix');
            for cg=1:size(handles.GROUPPOOL,2)
                selg=get(handles.group_list,'Value');
                ntraces=size(handles.GROUPPOOL(cg).files,1);
                nfigs=ceil(ntraces/5);
                ctn=0;
                for i=1:nfigs
                    h=figure;
                    set(gcf,'PaperPositionMode','manual');
                    set(gcf,'Units','inches');
                    set(gcf,'PaperPosition',[0.1 0.1 8.3 10.8])
                    hold all
                    %FIRST PLOT
                    subplot(5,1,1)
                    try
                        ctn=ctn+1;
                        [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                        FILENAME=handles.GROUPPOOL(selg).files{ctn};
                        [P F I]=fileparts(FILENAME);
                        ST=a(3:end,1);
                        if isnan(ST(1))
                            ST=ST(2:end);
                        end
                        sst=a(3:end,3);
                        if isnan(sst(1))
                            sst=sst(2:end);
                        end
                        maxt=a(1,4);
                        stimtimes=sst(~isnan(sst));
                        offset=stimtimes(1);
                        oend=stimtimes(end)-stimtimes(1);
                        oST=ST-offset;
                        BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                        %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                        plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                        axis([0 100 0 50]);
                        annotation('textbox',[.1 .85 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                    catch
                    end
                    %SECOND PLOT
                    subplot(5,1,2)
                    try
                        ctn=ctn+1;
                        [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                        FILENAME=handles.GROUPPOOL(selg).files{ctn};
                        [P F I]=fileparts(FILENAME);
                        ST=a(3:end,1);
                        if isnan(ST(1))
                            ST=ST(2:end);
                        end
                        sst=a(3:end,3);
                        if isnan(sst(1))
                            sst=sst(2:end);
                        end
                        maxt=a(1,4);
                        stimtimes=sst(~isnan(sst));
                        offset=stimtimes(1);
                        oend=stimtimes(end)-stimtimes(1);
                        oST=ST-offset;
                        BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                        %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                        plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                        axis([0 100 0 50]);
                        annotation('textbox',[.1 .68 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                    catch
                    end
                    %THIRD PLOT
                    subplot(5,1,3)
                    try
                        ctn=ctn+1;
                        [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                        FILENAME=handles.GROUPPOOL(selg).files{ctn};
                        [P F I]=fileparts(FILENAME);
                        ST=a(3:end,1);
                        if isnan(ST(1))
                            ST=ST(2:end);
                        end
                        sst=a(3:end,3);
                        if isnan(sst(1))
                            sst=sst(2:end);
                        end
                        maxt=a(1,4);
                        stimtimes=sst(~isnan(sst));
                        offset=stimtimes(1);
                        oend=stimtimes(end)-stimtimes(1);
                        oST=ST-offset;
                        BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                        %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                        plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                        axis([0 100 0 50]);
                        annotation('textbox',[.1 .51 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                    catch
                    end
                    %FOURTH PLOT
                    subplot(5,1,4)
                    try
                        ctn=ctn+1;
                        [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                        FILENAME=handles.GROUPPOOL(selg).files{ctn};
                        [P F I]=fileparts(FILENAME);
                        ST=a(3:end,1);
                        if isnan(ST(1))
                            ST=ST(2:end);
                        end
                        sst=a(3:end,3);
                        if isnan(sst(1))
                            sst=sst(2:end);
                        end
                        maxt=a(1,4);
                        stimtimes=sst(~isnan(sst));
                        offset=stimtimes(1);
                        oend=stimtimes(end)-stimtimes(1);
                        oST=ST-offset;
                        BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                        %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                        plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                        axis([0 100 0 50]);
                        annotation('textbox',[.1 .335 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                    catch
                    end
                    %FIFTH PLOT
                    subplot(5,1,5)
                    try
                        ctn=ctn+1;
                        [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                        FILENAME=handles.GROUPPOOL(selg).files{ctn};
                        [P F I]=fileparts(FILENAME);
                        ST=a(3:end,1);
                        if isnan(ST(1))
                            ST=ST(2:end);
                        end
                        sst=a(3:end,3);
                        if isnan(sst(1))
                            sst=sst(2:end);
                        end
                        maxt=a(1,4);
                        stimtimes=sst(~isnan(sst));
                        offset=stimtimes(1);
                        oend=stimtimes(end)-stimtimes(1);
                        oST=ST-offset;
                        BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                        %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                        plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                        axis([0 100 0 50]);
                        annotation('textbox',[.1 .16 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                    catch
                    end
                    CI(1,1)=handles.GROUPPOOL(selg).name;
                    CI{2,1}=['Binned ECS plot  BinSize ms: ',num2str(BinSz),'  Overlap: ',num2str(BinOl)];
                    
                    CI{3,1}=date;
                    annotation('textbox',[.1 .9 .85 .1],'String',CI,'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
                    annotation('textbox',[.1 .05 .85 .01],'String',[num2str(i),' of ',num2str(nfigs),' pages'],'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                    %                 print('-dpdf','-r600',h,'BinnedSPKTest.pdf');
                    if i==1
                        print('-dpsc2','-r600',h,'SPKTEST11.ps')
                    end
                    if i~=1
                        print('-dpsc2','-r600','-append',h,'SPKTEST11.ps')
                    end
                    delete(h);
                end
                TGTFILE=[handles.GROUPPOOL(cg).name{1},'_',TGTflSfx{1}];
                ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
                delete('SPKTEST11.ps');
                msgbox('PDF Creation Complete');
                
            end
        end
        if strcmp(A,'Group')
            [TGTFILE,TGTPATH]=uiputfile('*.pdf','Save Inst FF Set As');
            selg=get(handles.group_list,'Value');
            ntraces=size(handles.GROUPPOOL(selg).files,1);
            nfigs=ceil(ntraces/5);
            ctn=0;
            for i=1:nfigs
                h=figure;
                set(gcf,'PaperPositionMode','manual');
                set(gcf,'Units','inches');
                set(gcf,'PaperPosition',[0.1 0.1 8.3 10.8])
                hold all
                %FIRST PLOT
                subplot(5,1,1)
                try
                    ctn=ctn+1;
                    [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                    FILENAME=handles.GROUPPOOL(selg).files{ctn};
                    [P F I]=fileparts(FILENAME);
                    ST=a(3:end,1);
                    if isnan(ST(1))
                        ST=ST(2:end);
                    end
                    sst=a(3:end,3);
                    if isnan(sst(1))
                        sst=sst(2:end);
                    end
                    maxt=a(1,4);
                    stimtimes=sst(~isnan(sst));
                    offset=stimtimes(1);
                    oend=stimtimes(end)-stimtimes(1);
                    oST=ST-offset;
                    BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                    %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                    plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                    axis([0 100 0 50]);
                    annotation('textbox',[.1 .85 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                catch
                end
                %SECOND PLOT
                subplot(5,1,2)
                try
                    ctn=ctn+1;
                    [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                    FILENAME=handles.GROUPPOOL(selg).files{ctn};
                    [P F I]=fileparts(FILENAME);
                    ST=a(3:end,1);
                    if isnan(ST(1))
                        ST=ST(2:end);
                    end
                    sst=a(3:end,3);
                    if isnan(sst(1))
                        sst=sst(2:end);
                    end
                    maxt=a(1,4);
                    stimtimes=sst(~isnan(sst));
                    offset=stimtimes(1);
                    oend=stimtimes(end)-stimtimes(1);
                    oST=ST-offset;
                    BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                    %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                    plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                    axis([0 100 0 50]);
                    annotation('textbox',[.1 .68 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                catch
                end
                %THIRD PLOT
                subplot(5,1,3)
                try
                    ctn=ctn+1;
                    [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                    FILENAME=handles.GROUPPOOL(selg).files{ctn};
                    [P F I]=fileparts(FILENAME);
                    ST=a(3:end,1);
                    if isnan(ST(1))
                        ST=ST(2:end);
                    end
                    sst=a(3:end,3);
                    if isnan(sst(1))
                        sst=sst(2:end);
                    end
                    maxt=a(1,4);
                    stimtimes=sst(~isnan(sst));
                    offset=stimtimes(1);
                    oend=stimtimes(end)-stimtimes(1);
                    oST=ST-offset;
                    BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                    %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                    plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                    axis([0 100 0 50]);
                    annotation('textbox',[.1 .51 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                catch
                end
                %FOURTH PLOT
                subplot(5,1,4)
                try
                    ctn=ctn+1;
                    [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                    FILENAME=handles.GROUPPOOL(selg).files{ctn};
                    [P F I]=fileparts(FILENAME);
                    ST=a(3:end,1);
                    if isnan(ST(1))
                        ST=ST(2:end);
                    end
                    sst=a(3:end,3);
                    if isnan(sst(1))
                        sst=sst(2:end);
                    end
                    maxt=a(1,4);
                    stimtimes=sst(~isnan(sst));
                    offset=stimtimes(1);
                    oend=stimtimes(end)-stimtimes(1);
                    oST=ST-offset;
                    BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                    %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                    plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                    axis([0 100 0 50]);
                    annotation('textbox',[.1 .335 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                catch
                end
                %FIFTH PLOT
                subplot(5,1,5)
                try
                    ctn=ctn+1;
                    [a b c]=xlsread(handles.GROUPPOOL(selg).files{ctn});
                    FILENAME=handles.GROUPPOOL(selg).files{ctn};
                    [P F I]=fileparts(FILENAME);
                    ST=a(3:end,1);
                    if isnan(ST(1))
                        ST=ST(2:end);
                    end
                    sst=a(3:end,3);
                    if isnan(sst(1))
                        sst=sst(2:end);
                    end
                    maxt=a(1,4);
                    stimtimes=sst(~isnan(sst));
                    offset=stimtimes(1);
                    oend=stimtimes(end)-stimtimes(1);
                    oST=ST-offset;
                    BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                    %                     bar(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k','BarWidth',1);
                    plot(BinnedST(1,:),BinnedST(2,:)/(BinSz/1000),'k-s');
                    axis([0 100 0 50]);
                    annotation('textbox',[.1 .16 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                catch
                end
                CI(1,1)=handles.GROUPPOOL(selg).name;
                CI{2,1}=['Binned ECS plot  BinSize ms: ',num2str(BinSz),'  Overlap: ',num2str(BinOl)];
                
                CI{3,1}=date;
                annotation('textbox',[.1 .9 .85 .1],'String',CI,'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
                annotation('textbox',[.1 .05 .85 .01],'String',[num2str(i),' of ',num2str(nfigs),' pages'],'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                %                 print('-dpdf','-r600',h,'BinnedSPKTest.pdf');
                if i==1
                    print('-dpsc2','-r600',h,'SPKTEST11.ps')
                end
                if i~=1
                    print('-dpsc2','-r600','-append',h,'SPKTEST11.ps')
                end
                delete(h);
            end
            ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
            delete('SPKTEST11.ps');
            msgbox('PDF Creation Complete');
        end
        
        
        
        
        
    end
end







% --- Executes on selection change in group_list.
function group_list_Callback(hObject, eventdata, handles)
% hObject    handle to group_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns group_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from group_list
GroupN=get(hObject,'Value');
clear handles.GROUPFILE;
handles.GROUPFILE=handles.GROUPPOOL(GroupN).files;
set(handles.group_file_list,'String',handles.GROUPFILE);
set(handles.group_file_list,'Value',1);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function group_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to group_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Remove_File_btn.
function Remove_File_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_File_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
remvals=get(handles.file_list,'Value');
stvals=[1:numel(handles.FILEPOOL)];
kepvals=stvals(~ismember(stvals,remvals));
FPOOL=cell(1,size(kepvals,2));
FPOOL=handles.FILEPOOL(kepvals);
clear handles.FILEPOOL
handles.FILEPOOL=FPOOL;
set(handles.file_list,'String',handles.FILEPOOL);
if max(get(handles.file_list,'Value'))> numel(handles.FILEPOOL)
    set(handles.file_list,'Value',numel(handles.FILEPOOL));
end
set(handles.text1,'String',[num2str(numel(handles.FILEPOOL)),' items']);
guidata(hObject,handles);

% --- Executes on button press in Create_Group_btn.
function Create_Group_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Create_Group_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reselectgroup=1;
GROUPNAME={};
if ~isempty(handles.GROUPPOOL)
    for i=1:size(handles.GROUPPOOL,2)
        GROUPNAME(i)=handles.GROUPPOOL(i).name;
    end
end
Source=questdlg('Create group from ALL or SELECTED?','Group Source','All','Selected','Cancel','Cancel');
if strcmp(Source,'All')
    while reselectgroup==1
        gname=inputdlg('Enter Group Name');
        reselectgroup=0;
        if ismember(gname,GROUPNAME)
            reselectgroup=1;
        end
    end
    prevGPsz=size(handles.GROUPPOOL,2);
    if ~isempty(gname)
        handles.GROUPPOOL(prevGPsz+1).name=gname;
        handles.GROUPPOOL(prevGPsz+1).files=handles.FILEPOOL;
    end
    for i=1:size(handles.GROUPPOOL,2)
        GROUPNAME(i)=handles.GROUPPOOL(i).name;
    end
    set(handles.group_list,'String',GROUPNAME);
end
if strcmp(Source,'Selected')
    while reselectgroup==1
        gname=inputdlg('Enter Group Name');
        reselectgroup=0;
        if ismember(gname,GROUPNAME)
            reselectgroup=1;
        end
    end
    prevGPsz=size(handles.GROUPPOOL,2);
    if ~isempty(gname)
        handles.GROUPPOOL(prevGPsz+1).name=gname;
        handles.GROUPPOOL(prevGPsz+1).files=handles.FILEPOOL(get(handles.file_list,'Value'));
        handles.GROUPPOOL(prevGPsz+1).loc='';
    end
    for i=1:size(handles.GROUPPOOL,2)
        GROUPNAME(i)=handles.GROUPPOOL(i).name;
    end
    set(handles.group_list,'String',GROUPNAME);
end
set(handles.group_list,'Value',prevGPsz+1);
GroupN=get(handles.group_list,'Value');
handles.GROUPFILE=handles.GROUPPOOL(GroupN).files;
set(handles.group_file_list,'String',handles.GROUPFILE);
set(handles.group_file_list,'Value',1);
guidata(hObject,handles)

% --- Executes on button press in Create_List_Grp_Btn.
function Create_List_Grp_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Create_List_Grp_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GroupN=get(handles.group_list,'Value');
GroupName=handles.GROUPPOOL(GroupN).name;
GroupFILES=handles.GROUPPOOL(GroupN).files;
if strcmp(handles.GROUPPOOL(GroupN).loc,'')
    [FILE PATH]=uiputfile(['R:\BioDataLab\Atulya\Physiology Summary and Organization\Lists','\',GroupName{1},'.txt'],'Select Location to Save');
    if FILE==0
        warndlg('Invalid Target A');
    end
end
if ~strcmp(handles.GROUPPOOL(GroupN).loc,'')
    [FILE PATH]=uiputfile(handles.GROUPPOOL(GroupN).loc,'Select Location to Save');
    if FILE==0
        warndlg('Invalid Target B');
    end
end
if ischar(FILE)
    dlmwrite([PATH,FILE],char(GroupFILES'),'')
end
guidata(hObject,handles);



% --- Executes on selection change in group_file_list.
function group_file_list_Callback(hObject, eventdata, handles)
% hObject    handle to group_file_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns group_file_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from group_file_list


% --- Executes during object creation, after setting all properties.
function group_file_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to group_file_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Remove_Group_btn.
function Remove_Group_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_Group_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
remvals=get(handles.group_list,'Value');
stvals=[1:size(handles.GROUPPOOL,2)];
kepvals=stvals(~ismember(stvals,remvals));
GPOOL=struct('name',{},'files',{});
GPOOL=handles.GROUPPOOL(kepvals);
clear handles.GROUPPOOL
handles.GROUPPOOL=GPOOL;
if isempty(GPOOL)
    GROUPNAME=cell(0,1);
end
if ~isempty(GPOOL)
    for i=1:size(handles.GROUPPOOL,2)
        GROUPNAME(i)=handles.GROUPPOOL(i).name;
    end
end
set(handles.group_list,'String',GROUPNAME);
if max(get(handles.group_list,'Value'))> size(handles.GROUPPOOL,2)
    set(handles.group_list,'Value',size(handles.GROUPPOOL,2));
end
GroupN=get(handles.group_list,'Value');
if GroupN>0
    handles.GROUPFILE=handles.GROUPPOOL(GroupN).files;
    set(handles.group_file_list,'String',handles.GROUPFILE);
    set(handles.group_file_list,'Value',1);
end
if GroupN==0
    set(handles.group_file_list,'String','');
    set(handles.group_file_list,'Value',0);
end
%set(handles.text1,'String',[num2str(size(handles.GROUPPOOL,2)),' items']);
guidata(hObject,handles);

% --- Executes on button press in Add_File_to_Group_btn.
function Add_File_to_Group_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Add_File_to_Group_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILENAMES=handles.FILEPOOL(get(handles.file_list,'Value'));
GROUP=handles.GROUPPOOL(get(handles.group_list,'Value'));
GroupN=get(handles.group_list,'Value');
overlapfiles=intersect(FILENAMES,GROUP.files);
if~isempty(overlapfiles)
    h=warndlg([{'Warning, the following file(s) are already in the group: '};overlapfiles']);
    uiwait(h);
end
GROUP.files=union(FILENAMES,GROUP.files);

addfile=questdlg([{'Do you want to add: '};FILENAMES';{['To ', cell2mat( GROUP.name),' ?']}]);
if strcmp(addfile,'Yes')==1
    handles.GROUPPOOL(GroupN)=GROUP;
end
clear handles.GROUPFILE;
handles.GROUPFILE=handles.GROUPPOOL(GroupN).files;
set(handles.group_file_list,'String',handles.GROUPFILE);
guidata(hObject,handles);


% --- Executes on button press in Get_File_Info.
function Get_File_Info_Callback(hObject, eventdata, handles)
% hObject    handle to Get_File_Info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILENAME=handles.FILEPOOL{get(handles.file_list,'Value')};
APgetspiketraininfo(FILENAME);

% --- Executes on button press in Get_File_Info_2_btn.
function Get_File_Info_2_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Get_File_Info_2_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILENAME=handles.GROUPFILE{get(handles.group_file_list,'Value')};
APgetspiketraininfo(FILENAME);


% --------------------------------------------------------------------
function Inst_FF_plt_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Inst_FF_plt_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sv=get(handles.group_file_list,'Value');

for i=1:numel(sv)
FILENAME=handles.GROUPFILE{sv(i)};
[a b c]=xlsread(FILENAME);
spktimes=a(3:end,1);
if get(handles.align_stim_chk,'Value')==1
    ST=a(3:end,3);
    stimtimes=ST(~isnan(ST));
    spktimes=spktimes-stimtimes(1);
end
% figure
% scatter(spktimes(1:end-1),1./diff(spktimes), 25,spktimes(1:end-1),'filled')
% load('ECScmap.mat')
% colormap(ECScmap)
% caxis([0 60])
% figure
% hold all
% plot(spktimes(1:end-1),1./diff(spktimes),'k.');
% hold off
figure
hold all
plot(spktimes(1:end-1),log10(1./diff(spktimes)),'k.');
axis([0 60 0 2.25])
hold off
end

% --------------------------------------------------------------------
function Bin_FF_plt_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Bin_FF_plt_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILENAME=handles.GROUPFILE{get(handles.group_file_list,'Value')};
[a b c]=xlsread(FILENAME);
spktimes=a(3:end,1);
ST=a(3:end,3);
stimtimes=ST(~isnan(ST));
if get(handles.align_stim_chk,'Value')==0
    binsz=0.25;
    overlap=0;
    bstart=ceil(spktimes(1)/binsz)*binsz;
    bend=floor(spktimes(end)/binsz)*binsz;
    nbins=(bend-bstart)/(binsz*(1-overlap));
    BinnedResp=zeros([nbins 3]);
    cbin=bstart;
    for i=1:nbins
        BinnedResp(i,1)=cbin;
        BinnedResp(i,2)=cbin+binsz;
        BinnedResp(i,3)=numel(find(spktimes>cbin))-numel(find(spktimes>cbin+binsz));
        cbin=cbin+((1-overlap)*binsz);
    end
    bff=BinnedResp;
end
if get(handles.align_stim_chk,'Value')==1
    bff=APECSbin(spktimes,stimtimes,0.25,0);
end
figure
plot(bff(:,1),bff(:,3));


% --- Executes on button press in Plot_Spike_Train.
function Plot_Spike_Train_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Spike_Train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fn=get(handles.group_file_list,'Value');
h=figure;
for i=1:numel(fn)
    try
        FILENAME=handles.GROUPFILE{fn(i)};
        APreconstspktrn(FILENAME,h,(i-1)*1.2,1);
    catch
        i
    end
end


% --- Executes on button press in align_stim_chk.
function align_stim_chk_Callback(hObject, eventdata, handles)
% hObject    handle to align_stim_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of align_stim_chk


% --- Executes on button press in Remove_File_Grp_btn.
function Remove_File_Grp_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_File_Grp_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
remvals=get(handles.group_file_list,'Value');
stvals=[1:size(handles.GROUPFILE,1)];
kepvals=stvals(~ismember(stvals,remvals));
FPOOL=cell(1,size(kepvals,2));
FPOOL=handles.GROUPFILE(kepvals);
clear handles.GROUPFILE
handles.GROUPFILE=FPOOL;
set(handles.group_file_list,'String',handles.GROUPFILE);
nv=min(remvals)-1;
if nv<1
    nv=1;
end
set(handles.group_file_list,'Value',nv);
if max(get(handles.group_file_list,'Value'))> size(handles.GROUPFILE,2)
    set(handles.group_file_list,'Value',size(handles.GROUPFILE,2));
end
GroupN=get(handles.group_list,'Value');
clear handles.GROUPPOOL(GroupN).files;
handles.GROUPPOOL(GroupN).files=handles.GROUPFILE;
guidata(hObject,handles);

% --------------------------------------------------------------------
function Raster_Plot_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Raster_Plot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
grpsel=questdlg('Which groups do you want to analyze?','Group Analysis','All','Single','Cancel','Cancel');
if strcmp(grpsel,'Single')==1
    cgv=get(handles.group_list,'value');
    ntraces=size(handles.GROUPPOOL(cgv).files,1);
    h1 =figure
    hold all

        h2 = waitbar(0,'starting');
  
    for i=1:ntraces
        try
            waitbar(i/ntraces,h2,'loading');
            disp(handles.GROUPPOOL(cgv).files{i});
            [a b c]=APloadSTdat(handles.GROUPPOOL(cgv).files{i});
            figure(h1)
            hold all;
            ST=a(3:end,1);
            oST=ST;
            doST(1)=0;
            doST(2:numel(oST))=diff(oST);
            scatter(oST,i*ones(1,size(oST,1)),10,1./doST,'filled');
            caxis([0 20]);
            [p n e]= fileparts(handles.GROUPPOOL(cgv).files{i});
            tickname{i}=n;
             dat(i).doST = doST;
            clear doST
            dat(i).ST = ST;
            clear ST
            %dat(i).sst = sst;
            %clear sst
            %dat(i).stimtimes = stimtimes;
            %clear stimtimes
%             dat(i).offset = offset;
%             clear offset
%             dat(i).oST = oST;
%             clear oST
        catch
               dat(i).doST = nan;
            clear doST
            dat(i).ST = nan;
            clear ST
            %dat(i).sst = sst;
            %clear sst
            %dat(i).stimtimes = stimtimes;
            %clear stimtimes
%             dat(i).offset = nan;
%             clear offset
%             dat(i).oST = nan;
%             clear oST
        end
        
    end
    axis([0 60 0 ntraces+1]);
    title(handles.GROUPPOOL(cgv).name{1});
    xlabel('Time (s)')
    set(gca,'YTick',[1:1:ntraces]);
    set(gca,'YTickLabel',tickname)
    colorbar
    export2wsdlg({'Dat'},{'dat'},{dat});
end
if strcmp(grpsel,'All')==1
    figure
    hold all
    ngrps=size(handles.GROUPPOOL,2);
    ttn=0;
    
    for j=1:ngrps
        cmap=colormap(lines(ngrps));
        ntraces=size(handles.GROUPPOOL(j).files,1);
        for i=1:ntraces
            ttn=ttn+1;
            try
                [a b c]=APloadSTdat(handles.GROUPPOOL(j).files{i});
                ST=a(3:end,1);
                plot(ST,ttn*ones(1,size(ST,1)),'LineStyle','none','Marker','.','MarkerEdgeColor',cmap(j,:));
            catch
            end
        end
        
        
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function ffcv_plot_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ffcv_plot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ngrps=size(handles.GROUPPOOL,2);
h=waitbar(0 ,'Loading Data');
for i=1:ngrps
    ntraces=size(handles.GROUPPOOL(i).files,1);
    lnames(i)=handles.GROUPPOOL(i).name;
    for j=1:ntraces
        try
            fname=handles.GROUPPOOL(i).files{j};
            fltstat=APFLTISIstats(fname,0,0);
            gntypffcv(i).ff(j)=1/fltstat.ISImean;
            gntypffcv(i).cv(j)=fltstat.ISIcv;
        catch
        end
    end
    waitbar(i/ngrps,h,'Loading Data');
end
delete(h);
FFarray=zeros(0);
CVarray=zeros(0);
IDgrp=zeros(0);
for i=1:ngrps
    FFarray=cat(2,FFarray,gntypffcv(i).ff);
    CVarray=cat(2,CVarray,gntypffcv(i).cv);
    IDgrp=cat(2,IDgrp,ones(size(gntypffcv(i).ff))*i);
end
FFarray(isnan(FFarray))=0;
CVarray(isnan(CVarray))=1;
CVarray(find(CVarray==0))=1;
mf=figure;
ffcvhand=subplot(3,3, [2,3,5,6]);
for i=1:ngrps
    try
        semilogy(FFarray(find(IDgrp==i)),CVarray(find(IDgrp==i)),'.');
        hold all
    catch
    end
end
axis([0 20 0.01 10]);

% legend(lnames,'Location','SouthWestOutside');
%xlabel('Inst. Firing Freq.(Hz)');
%ylabel('CV');



%figure
figure(mf);
ffhand=subplot(3,3,[8:9])
boxplot(FFarray,IDgrp,'plotstyle','compact','extrememode','compress','symbol','rx')
axis([0.5 ngrps+0.5 0 20]);
ylabel('Inst Firing Freq');
view(90,90)

%kruskalwallis(FFarray,IDgrp);

%figure
figure(mf);
cvhand=subplot (3,3,[1, 4]);
boxplot(log10(CVarray(~isnan(CVarray))),IDgrp(~isnan(CVarray)),'plotstyle','compact','extrememode','compress','symbol','rx');
axis([0.5 ngrps+0.5 -2 1]);
ylabel('Coeff. Var.')
%kruskalwallis(log10(CVarray(~isnan(CVarray))),IDgrp(~isnan(CVarray)));

axisranges=inputdlg({'FFCV axis range';'FF box range';'CV box range'},'Set Range',1,{'0,20,0.01,10';'0,20';'-2,1'});
if~isempty(axisranges)
    ffcvrange=str2num(axisranges{1});
    axes(ffcvhand)
    axis(ffcvrange);
    axes(ffhand)
    v=axis;
    ffrange=str2num(axisranges{2});
    v(3:4)=ffrange;
    axis(v);
    axes(cvhand)
    v=axis;
    cvrange=str2num(axisranges{3});
    v(3:4)=cvrange;
    axis(v);
    
    
end
axes(ffhand);
view(90,90);

SLD=questdlg('Do you want to select data');
if strcmp(SLD,'Yes')
    figure(mf);
    axes(ffcvhand);
    [p x y]=selectdata;
    if iscell(p)
        p=flipud(p);
        for i=1:ngrps
            GSelCell(i).files=handles.GROUPPOOL(i).files(p{i});
        end
        SMdlg=questdlg('Do you want to save as a single or multiple group (s)?','Save Selection', 'Single','Multiple','Cancel','Cancel');
        if strcmp(SMdlg,'Single')
            OutputCell=cell(0,0);
            for i=1:ngrps
                if~isempty(GSelCell(i).files)
                    OutputCell=cat(1,OutputCell,GSelCell(i).files);
                end
            end
            [FILE, PATH]=uiputfile(['Sel_','.txt'],['Save Selected List']);
            if~isempty(FILE)
                dlmwrite([PATH,FILE],char(OutputCell'),'')
            end
            
            [a b c]=fileparts(FILE);
            gn=b;
            nG={};
            nG{1}=gn;
            prevGRPsz=ngrps;
            GROUPNAME={};
            for i=1:ngrps
                GROUPNAME(i)=handles.GROUPPOOL(1).name;
            end
            
            while ismember(gn,GROUPNAME(i))
                nG=inputdlg('Warning: proposed group name matches previously named group. Please re-enter name.','Group Name',1,nG{1});
            end
            handles.GROUPPOOL(prevGRPsz+1).name=nG;
            handles.GROUPPOOL(prevGRPsz+1).files=OutputCell;
            handles.GROUPPOOL(prevGRPsz+1).loc=[PATH,'\',FILE];
            clear GROUPNAME
            if ~isempty(handles.GROUPPOOL)
                for i=1:size(handles.GROUPPOOL,2)
                    GROUPNAME(i)=handles.GROUPPOOL(i).name;
                end
            end
            set(handles.group_list,'String',GROUPNAME);
            set(handles.group_list,'Value',1);
            handles.GROUPFILE=handles.GROUPPOOL(1).files;
            set(handles.group_file_list,'String',handles.GROUPFILE);
            set(handles.group_file_list,'Value',1);
            guidata(hObject,handles);
            
        end
        if strcmp(SMdlg,'Multiple')
            for i=1:ngrps
                if ~isempty(GSelCell(i).files)
                    [FILE, PATH]=uiputfile(['Sel_',handles.GROUPPOOL(i).name{1},'.txt'],['Save Selected List (Group #',num2str(i),' of ',num2str(ngrps),'Groups)']);
                    if ~isempty(FILE)
                        dlmwrite([PATH,FILE],char(GSelCell(i).files'),'')
                    end
                    [a b c]=fileparts(FILE);
                    gn=b;
                    nG={};
                    nG{1}=gn;
                    prevGRPsz=size(handles.GROUPPOOL,2);
                    GROUPNAME={};
                    for j=1:ngrps
                        GROUPNAME(j)=handles.GROUPPOOL(j).name;
                    end
                    
                    while ismember(gn,GROUPNAME(i))
                        nG=inputdlg('Warning: proposed group name matches previously named group. Please re-enter name.','Group Name',1,nG{1});
                    end
                    handles.GROUPPOOL(prevGRPsz+1).name=nG;
                    handles.GROUPPOOL(prevGRPsz+1).files=GSelCell(i).files;
                    handles.GROUPPOOL(prevGRPsz+1).loc=[PATH,'\',FILE];
                    clear GROUPNAME
                    if ~isempty(handles.GROUPPOOL)
                        for j=1:size(handles.GROUPPOOL,2)
                            GROUPNAME(j)=handles.GROUPPOOL(j).name;
                        end
                    end
                    set(handles.group_list,'String',GROUPNAME);
                    set(handles.group_list,'Value',1);
                    handles.GROUPFILE=handles.GROUPPOOL(1).files;
                    set(handles.group_file_list,'String',handles.GROUPFILE);
                    set(handles.group_file_list,'Value',1);
                    guidata(hObject,handles);
                end
            end
        end
    end
    if ~iscell(p)
        SelCell=handles.GROUPPOOL(1).files(p);
        mh=msgbox(SelCell,'Selected Files');
        uiwait(mh);
        [FILE, PATH]=uiputfile('*.txt','Save Selected List');
        if ~isempty(FILE)
            dlmwrite([PATH,FILE],char(SelCell'),'')
        end
        [a b c]=fileparts(FILE);
        gn=b;
        nG={};
        nG{1}=gn;
        prevGRPsz=ngrps;
        GROUPNAME={};
        for i=1:ngrps
            GROUPNAME(i)=handles.GROUPPOOL(1).name;
        end
        
        while ismember(gn,GROUPNAME(i))
            nG=inputdlg('Warning: proposed group name matches previously named group. Please re-enter name.','Group Name',1,nG{1});
        end
        handles.GROUPPOOL(prevGRPsz+1).name=nG;
        handles.GROUPPOOL(prevGRPsz+1).files=SelCell;
        handles.GROUPPOOL(prevGRPsz+1).loc=[PATH,'\',FILE];
        clear GROUPNAME
        if ~isempty(handles.GROUPPOOL)
            for i=1:size(handles.GROUPPOOL,2)
                GROUPNAME(i)=handles.GROUPPOOL(i).name;
            end
        end
        set(handles.group_list,'String',GROUPNAME);
        set(handles.group_list,'Value',1);
        handles.GROUPFILE=handles.GROUPPOOL(1).files;
        set(handles.group_file_list,'String',handles.GROUPFILE);
        set(handles.group_file_list,'Value',1);
        guidata(hObject,handles);
        
        
    end
    MOREDATA=questdlg('Do you want to select additional data?');
    
    if strcmp (MOREDATA,'Yes')
        reselectdata=1;
    end
    if ~strcmp(MOREDATA,'Yes')
        reselectdata=0;
    end
    if reselectdata==1;
        while reselectdata==1
            figure(mf);
            axes(ffcvhand);
            [p x y]=selectdata;
            if iscell(p)
                p=flipud(p);
                for i=1:ngrps
                    GSelCell(i).files=handles.GROUPPOOL(i).files(p{i});
                end
                SMdlg=questdlg('Do you want to save as a single or multiple group (s)?','Save Selection', 'Single','Multiple','Cancel','Cancel');
                if strcmp(SMdlg,'Single')
                    OutputCell=cell(0,0)
                    for i=1:ngrps
                        if~isempty(GSelCell(i).files)
                            OutputCell=cat(2,OutputCell,GSelCell(i).files);
                        end
                    end
                    [FILE, PATH]=uiputfile(['Sel_','.txt'],['Save Selected List']);
                    if~isempty(FILE)
                        dlmwrite([PATH,FILE],char(OutputCell'),'')
                    end
                    [a b c]=fileparts(FILE);
                    gn=b;
                    nG={};
                    nG{1}=gn;
                    prevGRPsz=ngrps;
                    GROUPNAME={};
                    for i=1:ngrps
                        GROUPNAME(i)=handles.GROUPPOOL(1).name;
                    end
                    
                    while ismember(gn,GROUPNAME(i))
                        nG=inputdlg('Warning: proposed group name matches previously named group. Please re-enter name.','Group Name',1,nG{1});
                    end
                    handles.GROUPPOOL(prevGRPsz+1).name=nG;
                    handles.GROUPPOOL(prevGRPsz+1).files=OutputCell;
                    handles.GROUPPOOL(prevGRPsz+1).loc=[PATH,'\',FILE];
                    clear GROUPNAME
                    if ~isempty(handles.GROUPPOOL)
                        for i=1:size(handles.GROUPPOOL,2)
                            GROUPNAME(i)=handles.GROUPPOOL(i).name;
                        end
                    end
                    set(handles.group_list,'String',GROUPNAME);
                    set(handles.group_list,'Value',1);
                    handles.GROUPFILE=handles.GROUPPOOL(1).files;
                    set(handles.group_file_list,'String',handles.GROUPFILE);
                    set(handles.group_file_list,'Value',1);
                    guidata(hObject,handles);
                end
                if strcmp(SMdlg,'Multiple')
                    for i=1:ngrps
                        if ~isempty(GSelCell(i).files)
                            [FILE, PATH]=uiputfile(['Sel_',handles.GROUPPOOL(i).name,'.txt'],['Save Selected List (Group #',num2str(i),' of ',num2str(ngrps),'Groups)']);
                            if ~isempty(FILE)
                                dlmwrite([PATH,FILE],char(SelCell'),'')
                            end
                            [a b c]=fileparts(FILE);
                            gn=b;
                            nG={};
                            nG{1}=gn;
                            prevGRPsz=size(handles.GROUPPOOL,2);
                            GROUPNAME={};
                            for j=1:ngrps
                                GROUPNAME(j)=handles.GROUPPOOL(j).name;
                            end
                            
                            while ismember(gn,GROUPNAME(i))
                                nG=inputdlg('Warning: proposed group name matches previously named group. Please re-enter name.','Group Name',1,nG{1});
                            end
                            handles.GROUPPOOL(prevGRPsz+1).name=nG;
                            handles.GROUPPOOL(prevGRPsz+1).files=GSelCell(i).files;
                            handles.GROUPPOOL(prevGRPsz+1).loc=[PATH,'\',FILE];
                            clear GROUPNAME
                            if ~isempty(handles.GROUPPOOL)
                                for j=1:size(handles.GROUPPOOL,2)
                                    GROUPNAME(j)=handles.GROUPPOOL(j).name;
                                end
                            end
                            set(handles.group_list,'String',GROUPNAME);
                            set(handles.group_list,'Value',1);
                            handles.GROUPFILE=handles.GROUPPOOL(1).files;
                            set(handles.group_file_list,'String',handles.GROUPFILE);
                            set(handles.group_file_list,'Value',1);
                            guidata(hObject,handles);
                        end
                    end
                end
            end
            
            if ~iscell(p)
                SelCell=handles.GROUPPOOL(1).files(p);
                mh=msgbox(SelCell,'Selected Files');
                uiwait(mh);
                [FILE, PATH]=uiputfile('*.txt','Save Selected List')
                if ~isempty(FILE)
                    dlmwrite([PATH,FILE],char(SelCell'),'')
                end
                [a b c]=fileparts(FILE);
                gn=b;
                nG={};
                nG{1}=gn;
                prevGRPsz=ngrps;
                GROUPNAME={};
                for i=1:ngrps
                    GROUPNAME(i)=handles.GROUPPOOL(1).name;
                end
                
                while ismember(gn,GROUPNAME(i))
                    nG=inputdlg('Warning: proposed group name matches previously named group. Please re-enter name.','Group Name',1,nG{1});
                end
                handles.GROUPPOOL(prevGRPsz+1).name=nG;
                handles.GROUPPOOL(prevGRPsz+1).files=SelCell;
                handles.GROUPPOOL(prevGRPsz+1).loc=[PATH,'\',FILE];
                clear GROUPNAME
                if ~isempty(handles.GROUPPOOL)
                    for i=1:size(handles.GROUPPOOL,2)
                        GROUPNAME(i)=handles.GROUPPOOL(i).name;
                    end
                end
                set(handles.group_list,'String',GROUPNAME);
                set(handles.group_list,'Value',1);
                handles.GROUPFILE=handles.GROUPPOOL(1).files;
                set(handles.group_file_list,'String',handles.GROUPFILE);
                set(handles.group_file_list,'Value',1);
                guidata(hObject,handles);
            end
            
            MOREDATA=questdlg('Do you want to select additional data?');
            if strcmp (MOREDATA,'Yes')
                reselectdata=1;
            end
            if ~strcmp(MOREDATA,'Yes')
                reselectdata=1;
            end
        end
    end
end




% --------------------------------------------------------------------
function ECS_Raster_plot_menu_Callback(hObject, eventdata, handles, varargin)
% hObject    handle to ECS_Raster_plot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RastOrder=0;
if ~isempty(varargin)
    grpsel=varargin{1};
    if nargin>4
       RastOrder=varargin{2}; 
    end
else
    grpsel=questdlg('Which groups do you want to analyze?','Group Analysis','All','Single','Cancel','Cancel');
end

[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;

if strcmp(grpsel,'Single')==1
    ntraces=size(handles.GROUPFILE,1);
    h1 =figure;
    if ntraces>20;
        h2 = waitbar(0,'n> 20');
    end
    hold all
    for i=1:ntraces
        if ntraces>20
        waitbar(i/ntraces,h2,[num2str(i),' of ',num2str(ntraces)]);
        end
        figure(h1);
        hold all;
        try
            if RastOrder(1)~=0
                ii=RastOrder(i);
            else
               ii=i; 
            end
            UFN(i)=APgetflynum(handles.GROUPFILE{ii},FLYNUMXL);
            UFNtk{i}=num2str(UFN(i));
            disp(handles.GROUPFILE{ii})
            [a b c]=APloadSTdat(handles.GROUPFILE{ii});
            ST=a(3:end,1);
            sst=a(3:end,3);
            stimtimes=sst(~isnan(sst));
            [f idx]=find(stimtimes>2,1);
            offset=stimtimes(f);
            oST=ST-offset;
            dat(i).ost=oST;
            sc(i)=sum(oST>2&oST<40);
            doST(1)=0;
            doST(2:numel(oST))=diff(oST);
            dat(i).doST=doST;
%             scatter(oST,i*ones(1,size(oST,1)),10,1./doST,'filled');
%             caxis([0 20]);
            scatter(oST,i*ones(1,size(oST,1)),20,log10(1./doST),'.','LineWidth',1.5);
            caxis([-1 2])
            axis([0 100 0 ntraces+1]);
            title(handles.GROUPPOOL(handles.group_list.Value).name{1});
            clear doST
            clear ST
            clear sst
            clear stimtimes
            clear offset
            clear oST
            clear a
         catch
             ['error with',num2str(i)]
         end
    end
    
    
    colorbar
    axis([0 100 0 ntraces+1]);
    set(gca,'YTickLabel',UFNtk)
    set(gca,'YTick',[1:numel(UFN)])
    export2wsdlg([{'Dat'},{'SpikeCount'},{'UFNs'}],[{'dat'},{'sc'},{'UFNs'}],[{dat},{sc},{UFN}]);
end

if strcmp(grpsel,'All')==1
    figure
    hold all
    ngrps=size(handles.GROUPPOOL,2);
    ttn=0;
    
    for j=1:ngrps
        subplot(ngrps,1,j);
        hold all
        ntraces=size(handles.GROUPPOOL(j).files,1);
        for i=1:ntraces
            try
                UFN(i)=APgetflynum(handles.GROUPPOOL(j).files{i},FLYNUMXL);
                UFNtk{i}=num2str(UFN(i));
                %[a b c]=xlsread(handles.GROUPPOOL(j).files{i});
                [a b c]=APloadSTdat(handles.GROUPPOOL(j).files{i});
                ST=a(3:end,1);
                sst=a(3:end,3);
                stimtimes=sst(~isnan(sst));
                offset=stimtimes(1);
                oST=ST-offset;
                doST(1)=0;
                doST(2:numel(oST))=diff(oST);
                scatter(oST,i*ones(1,size(oST,1)),10,1./doST,'filled');
                caxis([0 20]);
                clear doST
                clear ST
                clear sst
                clear stimtimes
                clear offset
                clear oST
                clear a
            catch
                ['error with',num2str(i)]
            end
        end
        title(handles.GROUPPOOL(j).name);
        colorbar
        axis([0 100 0 ntraces+1]);
        set(gca,'YTickLabel',UFNtk)
        set(gca,'YTick',[1:numel(UFN)])
        clear UFN
        clear UFNtk
    end
    
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function ECS_PCA_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ECS_PCA_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ngrps=size(handles.GROUPPOOL,2);
grpbinST=struct('gname',{},'bin',{});
nt=0;
Binsize=0.5;
overlap=0;
pcaTmax=80;
for i=1:ngrps
    ntraces=size(handles.GROUPPOOL(i).files,2);
    for j=1:ntraces
        fname=handles.GROUPPOOL(i).files{j};
        [a b c]=xlsread(fname);
        try
            maxrect(nt+1)=a(1,4);
        catch
            maxrect(nt+1)=0;
        end
        
        nt=nt+1;
    end
end
mrt=max(maxrect);
ttn=0;
for i=1:ngrps
    ntraces=size(handles.GROUPPOOL(i).files,2);
    grpbinST(i).gname=handles.GROUPPOOL(i).name;
    for j=1:ntraces
        fname=handles.GROUPPOOL(i).files{j};
        [a b c]=xlsread(fname);
        ST=a(3:end,1);
        sst=a(3:end,3);
        try
            stimtimes=sst(~isnan(sst));
            
            offset=stimtimes(1);
        catch
            offset=0;
        end
        oST=ST-offset;
        bin=APBinCounts_modmaxt(oST,Binsize,overlap,mrt);
        grpbinST(i).bin(j,:)=bin(2,:);
        X(ttn+1,:)=bin(2,:);
        %indicator, 'color'
        grpN(ttn+1)=j;
        grpNa{ttn+1}=fname;
        ttn=ttn+1;
    end
end
sX=X(:,round(3/Binsize):round(pcaTmax/Binsize));
for i=1:size(sX,1);
    rownan(i)=0;
    if isnan(sX(i,:))
        rownan(i)=1;
    end
end
nX=sX(~rownan,:);
for i=1:size(nX,2);
    colnan(i)=0;
    if isnan(nX(:,i))
        colnan(i)=1;
    end
end
nnX=nX(:,~colnan);
%mean subtraction

uX=ones(size(nnX,1),1)*nanmean(nnX);
suX=nnX-uX;
S=nancov(suX);
[D V]=eig(S);
h1=figure;
plot(cumsum(sort(diag(V),1,'descend'))/sum(diag(V)));
xlabel('Dimension')
ylabel('Proportion of Variance');
axis([0,size(nnX,1),0 1]);
h2=figure;
hold all
eigenvals=sort(diag(V),1,'descend');

for i=1:5
    plot(sqrt(eigenvals(i))*D(:,end-(i-1))+nanmean(nnX)','LineWidth',3-(i/2));
end
plot(nanmean(nnX),'k--')
h3=figure;
for i=1:size(nnX,1)
    x(i)=nnX(i,~isnan(nnX(i,:)))*D(~isnan(nnX(i,:)),end);
    y(i)=nnX(i,~isnan(nnX(i,:)))*D(~isnan(nnX(i,:)),end-1);
    z(i)=nnX(i,~isnan(nnX(i,:)))*D(~isnan(nnX(i,:)),end-2);
end
% scatter(x,y,10,grpN(~rownan));
plot(x,y,'bx');













% --------------------------------------------------------------------
function Inst_FF_resp_ecs_Callback(hObject, eventdata, handles, varargin)
% hObject    handle to Inst_FF_resp_ecs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(varargin)
    A=questdlg('Select Data Source','Inst. Firing Freq. Plot','All','Group','Trace','All');
else
    A=varargin{1};
end
if nargin>4
    fh=varargin{2};
else
    fh=-1;
end
if strcmp(A,'All')
    ngrps=size(handles.GROUPPOOL,2);
    h=figure;
    hold all
    for i=1:ngrps
        
        clear Tcmap
        subplot(ngrps,1,i);
        hold all
        ntraces=size(handles.GROUPPOOL(i).files,1);
        Tcmap=colormap(jet(ntraces));
        %         figure
        %         hold all
        for j=1:ntraces
            
            try
                [a b c]=APloadSTdat(handles.GROUPPOOL(i).files{j});
                ST=a(4:end,1);
                if isnan(ST(1))
                    ST=ST(2:end);
                end
                sst=a(4:end,3);
                if isnan(sst(1))
                    sst=sst(2:end);
                end
                stimtimes=sst(~isnan(sst));
                offset=stimtimes(1);
                oend=stimtimes(end)-stimtimes(1);
                oST=ST-offset;
                dST=diff(oST);
                T=oST(1:end-1);
                nspks=numel(T);
            catch
            end
            outlier=nan(1,numel(dST));
            outlier(find(dST<0.020))=0.020;
            idx=ones(1,numel(dST))*j;
            plot(T,1./dST,'.','LineWidth',.5,'Color',Tcmap(j,:));
            plot(T,1./outlier,'^','Color',Tcmap(j,:));
            %             plot3(T,1./dST,idx,'.','LineWidth',.5,'Color',Tcmap(j,:));
            axis([0 100 0 50]);
            colorbar;
            
        end
    end
end

if strcmp(A,'Group')
    [TGTFILE,TGTPATH]=uiputfile('*.pdf','Save Inst FF Set As');
    selg=get(handles.group_list,'Value');
    ntraces=size(handles.GROUPPOOL(selg).files,1);
    nfigs=ceil(ntraces/5);
    ctn=0;
    for i=1:nfigs
        h=figure;
        set(gcf,'PaperPositionMode','manual');
        set(gcf,'Units','inches');
        set(gcf,'PaperPosition',[0.1 0.1 8.3 10.8])
        subplot(5,1,1);
        %First of 5
        ctn=ctn+1;
        try
            [a b c]=APloadSTdat(handles.GROUPPOOL(selg).files{ctn});
            FILENAME=handles.GROUPPOOL(selg).files{ctn};
            [P F I]=fileparts(FILENAME);
            ST=a(3:end,1);
            if isnan(ST(1))
                ST=ST(2:end);
            end
            sst=a(3:end,3);
            if isnan(sst(1))
                sst=sst(2:end);
            end
            stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oend=stimtimes(end)-stimtimes(1);
            oST=ST-offset;
            dST=diff(oST);
            T=oST(1:end-1);
            nspks=numel(T);
            plot(T,1./dST,'k.','LineWidth',.5);
            axis([0 100 0 50]);
            annotation('textbox',[.1 .85 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
        catch
        end
        %Second of 5
        subplot(5,1,2);
        ctn=ctn+1;
        try
            [a b c]=APloadSTdat(handles.GROUPPOOL(selg).files{ctn});
            FILENAME=handles.GROUPPOOL(selg).files{ctn};
            [P F I]=fileparts(FILENAME);
            ST=a(3:end,1);
            if isnan(ST(1))
                ST=ST(2:end);
            end
            sst=a(3:end,3);
            if isnan(sst(1))
                sst=sst(2:end);
            end
            stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oend=stimtimes(end)-stimtimes(1);
            oST=ST-offset;
            dST=diff(oST);
            T=oST(1:end-1);
            nspks=numel(T);
            plot(T,1./dST,'k.','LineWidth',.5);
            axis([0 100 0 50]);
            annotation('textbox',[.1 .68 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
        catch
        end
        %Third of 5
        subplot(5,1,3);
        ctn=ctn+1;
        try
            [a b c]=APloadSTdat(handles.GROUPPOOL(selg).files{ctn});
            FILENAME=handles.GROUPPOOL(selg).files{ctn};
            [P F I]=fileparts(FILENAME);
            ST=a(3:end,1);
            if isnan(ST(1))
                ST=ST(2:end);
            end
            sst=a(3:end,3);
            if isnan(sst(1))
                sst=sst(2:end);
            end
            stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oend=stimtimes(end)-stimtimes(1);
            oST=ST-offset;
            dST=diff(oST);
            T=oST(1:end-1);
            nspks=numel(T);
            plot(T,1./dST,'k.','LineWidth',.5);
            axis([0 100 0 50]);
            annotation('textbox',[.1 .51 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
        catch
        end
        %Fourth of 5
        subplot(5,1,4);
        ctn=ctn+1;
        try
            [a b c]=APloadSTdat(handles.GROUPPOOL(selg).files{ctn});
            FILENAME=handles.GROUPPOOL(selg).files{ctn};
            [P F I]=fileparts(FILENAME);
            ST=a(3:end,1);
            if isnan(ST(1))
                ST=ST(2:end);
            end
            sst=a(3:end,3);
            if isnan(sst(1))
                sst=sst(2:end);
            end
            stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oend=stimtimes(end)-stimtimes(1);
            oST=ST-offset;
            dST=diff(oST);
            T=oST(1:end-1);
            nspks=numel(T);
            plot(T,1./dST,'k.','LineWidth',.5);
            axis([0 100 0 50]);
            annotation('textbox',[.1 .335 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
        catch
        end
        %Fifth of 5
        subplot(5,1,5);
        ctn=ctn+1;
        try
            [a b c]=APloadSTdat(handles.GROUPPOOL(selg).files{ctn});
            FILENAME=handles.GROUPPOOL(selg).files{ctn};
            [P F I]=fileparts(FILENAME);
            ST=a(3:end,1);
            if isnan(ST(1))
                ST=ST(2:end);
            end
            sst=a(3:end,3);
            if isnan(sst(1))
                sst=sst(2:end);
            end
            stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oend=stimtimes(end)-stimtimes(1);
            oST=ST-offset;
            dST=diff(oST);
            T=oST(1:end-1);
            nspks=numel(T);
            plot(T,1./dST,'k.','LineWidth',.5);
            axis([0 100 0 50]);
            annotation('textbox',[.1 .16 .85 .1],'String',F,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
        catch
        end
        CI(1,1)=handles.GROUPPOOL(selg).name;
        CI{2,1}=date;
        annotation('textbox',[.1 .9 .85 .1],'String',CI,'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
        annotation('textbox',[.1 .05 .85 .01],'String',[num2str(i),' of ',num2str(nfigs),' pages'],'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
        if i==1
            print('-dpsc2','-r600',h,'SPKTEST11.ps')
        end
        if i~=1
            print('-dpsc2','-r600','-append',h,'SPKTEST11.ps')
        end
        delete(h);
    end
    ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
    delete('SPKTEST11.ps');
    msgbox('PDF Creation Complete');
end




if strcmp(A,'Trace')
    if fh>0
        figure(fh)
    else
        figure
        hold all
    end
    tn=get(handles.group_file_list,'Value');
    for i=1:numel(tn)
    [a b c]=APloadSTdat(handles.GROUPFILE{tn(i)});
    FILENAME=handles.GROUPFILE{tn(i)};
    [P F I]=fileparts(FILENAME);
    ST=a(3:end,1);
    if isnan(ST(1))
        ST=ST(2:end);
    end
    sst=a(3:end,3);
    if isnan(sst(1))
        sst=sst(2:end);
    end
    if ~isempty(sst(~isnan(sst)));
        stimtimes=sst(~isnan(sst));
        offset=stimtimes(end);
        oend=stimtimes(end)-stimtimes(1);
    else
        offset=0;
        oend=0;
        ['Stim not found']
    end
    oST=ST-offset;
    %oST(oST<15)=nan
    dST=diff(oST);
    T=oST(1:end-1);
    nspks=numel(T);
%    plot(T,1./dST,'k.','LineWidth',.5);
%     plot(T,1./dST,'.-');
    scatter(T,1./dST,10,T,'filled');
    load('ECScmap.mat')
    colormap(ECScmap(1:end-1,:))
    caxis([0 60])
    axis([0 100 0 50]);
    
    end
end
% for i=1:ngrps
%     allST=zeros(0,2);
%     ntraces=size(handles.GROUPPOOL(i).files,1);
%     tsn=0;
%     for j=1:ntraces
%         try
%             [a b c]=xlsread(handles.GROUPPOOL(i).files{j});
%             ST=a(3:end,1);
%             if isnan(ST(1))
%                 ST=ST(2:end);
%             end
%              sst=a(3:end,3);
%     stimtimes=sst(~isnan(sst));
%     offset=stimtimes(1);
%     oST=ST-offset;
%             dST=diff(oST);
%             T=oST(1:end-1);
%             nspks=numel(T);
%             allST(tsn+1:tsn+nspks,1)=T;
%             allST(tsn+1:tsn+nspks,2)=dST;
%             tsn=tsn+nspks;
%         catch
%         end
%     end
%     Tafterstim=find(T>2);
%     plot(allST(:,1),1./allST(:,2),'-.','MarkerSize',0.25);
%     maxT(i)=max(allST(:,1))*1.1;
%     maxFF(i)=max(1./allST(Tafterstim,2))*1.1;
%
%
% end
% maxTT=max(maxT);
% maxFFF=max(maxFF);
% axis([2 120 0 50]);
% xlabel('Elapsed Time (s)');
% ylabel('Inst. Firing Freq. (Hz)')





% --- Executes on button press in up_btn.
function up_btn_Callback(hObject, eventdata, handles)
% hObject    handle to up_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
groupN=get(handles.group_list,'Value');
if groupN>1
    gpool=handles.GROUPPOOL;
    gpool(groupN-1)=gpool(groupN);
    gpool(groupN)=handles.GROUPPOOL(groupN-1);
    handles.GROUPPOOL=gpool;
    for i=1:size(handles.GROUPPOOL,2)
        GROUPNAME(i)=handles.GROUPPOOL(i).name;
    end
    groupN=groupN-1;
    set(handles.group_list,'String',GROUPNAME);
    set(handles.group_list,'Value',groupN);
    handles.GROUPFILE=handles.GROUPPOOL(groupN).files;
    set(handles.group_file_list,'String',handles.GROUPFILE);
    set(handles.group_file_list,'Value',1);
end
guidata(hObject,handles);

% --- Executes on button press in down_btn.
function down_btn_Callback(hObject, eventdata, handles)
% hObject    handle to down_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
groupN=get(handles.group_list,'Value');
if groupN<size(get(handles.group_list,'String'),1);
    gpool=handles.GROUPPOOL;
    gpool(groupN+1)=gpool(groupN);
    gpool(groupN)=handles.GROUPPOOL(groupN+1);
    handles.GROUPPOOL=gpool;
    for i=1:size(handles.GROUPPOOL,2)
        GROUPNAME(i)=handles.GROUPPOOL(i).name;
    end
    groupN=groupN+1;
    set(handles.group_list,'String',GROUPNAME);
    set(handles.group_list,'Value',groupN);
    handles.GROUPFILE=handles.GROUPPOOL(groupN).files;
    set(handles.group_file_list,'String',handles.GROUPFILE);
    set(handles.group_file_list,'Value',1);
end
guidata(hObject,handles);


% --- Executes on button press in Rename_Group_btn.
function Rename_Group_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Rename_Group_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
renamecont=questdlg('Warning renaming this group will remove location and date information. Do you wish to continue?');
if strcmp(renamecont,'Yes')
    for i=1:size(handles.GROUPPOOL,2)
        GROUPNAME(i)=handles.GROUPPOOL(i).name;
    end
    groupN=get(handles.group_list,'Value');
    grpName=handles.GROUPPOOL(groupN).name;
    newName=inputdlg('Please enter new group name','Rename',1,grpName);
    while ismember(newName,GROUPNAME)
        newName=inputdlg('Prev Match, please enter new group name','Rename',1,grpName);
    end
    handles.GROUPPOOL(groupN).name=newName;
    handles.GROUPPOOL(groupN).loc='';
    clear GROUPNAME
    for i=1:size(handles.GROUPPOOL,2)
        GROUPNAME(i)=handles.GROUPPOOL(i).name;
    end
    set(handles.group_list,'String',GROUPNAME);
end
guidata(hObject,handles);



% --- Executes on button press in Grp_Info_btn.
function Grp_Info_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Grp_Info_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
groupN=get(handles.group_list,'Value');
grpName=handles.GROUPPOOL(groupN).name;
grpLoc=handles.GROUPPOOL(groupN).loc;
if strcmp(grpLoc,'')
    gLoc='Not Assigned';
    grpDate='Not Assigned';
end
if ~strcmp(grpLoc,'')
    listinfo=dir(grpLoc);
    gLoc=grpLoc;
    grpDate=listinfo.date;
end
msgbox({['Name: ', grpName{1}];['Location: ',grpLoc];['Date Modified: ',grpDate]},'Info');


% --------------------------------------------------------------------
function Group_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Group_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Combine_Groups_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Combine_Groups_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:size(handles.GROUPPOOL,2)
    GROUPNAME(i)=handles.GROUPPOOL(i).name;
end
prevGPsz=size(handles.GROUPPOOL,2);
GC=CombineGroups(GROUPNAME);
newName=inputdlg('Please enter new group name','Rename',1);
while ismember(newName,GROUPNAME)
    newName=inputdlg('Prev Match, please enter new group name','Rename',1,newName);
end
handles.GROUPPOOL(prevGPsz+1).name=newName;
afilelist={};
for i=1:size(GC,2)
    afilelist=union(afilelist,handles.GROUPPOOL(GC(i)).files);
end
handles.GROUPPOOL(prevGPsz+1).files=afilelist;
handles.GROUPPOOL(prevGPsz+1).loc='';
for i=1:size(handles.GROUPPOOL,2)
    GROUPNAME(i)=handles.GROUPPOOL(i).name;
end
set(handles.group_list,'String',GROUPNAME);
set(handles.group_list,'Value',prevGPsz+1);
handles.GROUPFILE=handles.GROUPPOOL(prevGPsz+1).files;
set(handles.group_file_list,'String',handles.GROUPFILE);
set(handles.group_file_list,'Value',1);
guidata(hObject,handles);

% --------------------------------------------------------------------
function Create_Grp_Rastr_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Create_Grp_Rastr_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
traceSelect=APSelRastrPoints(handles.GROUPFILE);
grpName=inputdlg('Please enter new group name','Name Group',1);
for i=1:size(handles.GROUPPOOL,2)
    GROUPNAME(i)=handles.GROUPPOOL(i).name;
end
while ismember(grpName,GROUPNAME)
    grpName=inputdlg('Prev Match, please enter new group name','Rename',1,newName);
end
prevGPsz=size(handles.GROUPPOOL,2);
handles.GROUPPOOL(prevGPsz+1).name=grpName;
newGroupFile=handles.GROUPFILE(traceSelect);
handles.GROUPPOOL(prevGPsz+1).files=newGroupFile;
handles.GROUPPOOL(prevGPsz+1).loc='';
clear GROUPNAME;
for i=1:size(handles.GROUPPOOL,2)
    GROUPNAME(i)=handles.GROUPPOOL(i).name;
end
set(handles.group_list,'String',GROUPNAME);
set(handles.group_list,'Value',prevGPsz+1);
handles.GROUPFILE=handles.GROUPPOOL(prevGPsz+1).files;
set(handles.group_file_list,'String',handles.GROUPFILE);
set(handles.group_file_list,'Value',1);
guidata(hObject,handles);


% --------------------------------------------------------------------
function ID_Inst_Phase_Callback(hObject, eventdata, handles)
% hObject    handle to ID_Inst_Phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function DD_ana_menu_Callback(hObject, eventdata, handles)
% hObject    handle to DD_ana_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ID_Raster_Callback(hObject, eventdata, handles)
% hObject    handle to ID_Raster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
grpsel=questdlg('Which groups do you want to analyze?','Group Analysis','All','Single','Cancel','Cancel');
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
UFNXL=c;
clear a
clear b
clear c
if strcmp(grpsel,'Single')==1
    ntraces=size(handles.GROUPFILE,1);
    figure
    hold all
    
    for i=1:ntraces
        try
            
            fn(i)=APgetflynum(handles.GROUPFILE{i},UFNXL);
            UFNtk{i}=fn(i);
            [a b c]=xlsread(handles.GROUPFILE{i});
            ST=a(3:end,1);
            sst=a(3:end,3);
            stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oST=ST-offset;
            doST(1)=0;
            doST(2:numel(oST))=diff(oST);
            scatter(oST,i*ones(1,size(oST,1)),10,1./doST,'filled');
            caxis([0 20]);
            
            numspksp=find(oST>2);
            numspksn=find(oST>10);
            IDspiketimes=setdiff(numspksp,numspksn);
            IDspikecount(i)=numel(IDspiketimes);
            if IDspikecount(i)>10
                isID(i)=1;
            else
                isID(i)=0;
            end
            clear doST
            clear ST
            clear sst
            clear stimtimes
            clear offset
            clear oST
        catch
            ['error with',num2str(i)]
        end
    end
    
    colorbar
    axis([0 10 0 ntraces+1]);
    SkC=[ones(ntraces,1),fn',IDspikecount'];
    set(gca,'YTickLabel',UFNtk)
    set(gca,'YTick',[1:numel(UFNtk)])
    clear UFN
    clear UFNtk
end
if strcmp(grpsel,'All')==1
    figure
    hold all
    ngrps=size(handles.GROUPPOOL,2);
    ttn=0;
    
    for j=1:ngrps
        
        subplot(ngrps,1,j);
        hold all
        ntraces=size(handles.GROUPPOOL(j).files,1);
        for i=1:ntraces
            try
                ttn=ttn+1;
                [a b c]=xlsread(handles.GROUPPOOL(j).files{i});
                SkC(ttn,1)=j;
                SkC(ttn,2)=APgetflynum(handles.GROUPPOOL(j).files{i},UFNXL);
                UFNtk{i}=SkC(ttn,2);
                ST=a(3:end,1);
                sst=a(3:end,3);
                stimtimes=sst(~isnan(sst));
                offset=stimtimes(1);
                oST=ST-offset;
                doST(1)=0;
                doST(2:numel(oST))=diff(oST);
                scatter(oST,i*ones(1,size(oST,1)),10,1./doST,'filled');
                caxis([0 20]);
                
                numspksp=find(oST>2);
                numspksn=find(oST>10);
                IDspiketimes=setdiff(numspksp,numspksn);
                IDspikecount=numel(IDspiketimes);
                SkC(ttn,3)=numel(IDspiketimes);
                if IDspikecount>10
                    isID(i)=1;
                else
                    isID(i)=0;
                end
                
                clear doST
                clear ST
                clear sst
                clear stimtimes
                clear offset
                clear oST
                
            catch
                ['error with',num2str(i)]
            end
            
        end
        IDprop(j,1)=sum(isID);
        IDprop(j,2)=numel(isID);
        IDprop(j,3)=IDprop(j,1)/IDprop(j,2);
        title(handles.GROUPPOOL(j).name);
        colorbar
        axis([0 10 0 ntraces+1]);
        
        
        set(gca,'YTickLabel',UFNtk)
        set(gca,'YTick',[1:numel(UFNtk)])
        clear UFN
        clear UFNtk
        
    end
    
end
export2wsdlg({'Dat'},{'SkC'},{SkC});
guidata(hObject, handles);


% --------------------------------------------------------------------
function ID_Total_Spikes_Callback(hObject, eventdata, handles)
% hObject    handle to ID_Total_Spikes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILES=handles.GROUPFILE;
h=figure;
for i=1:numel(FILES)
    try
        figure(h);
        [a b c]=xlsread(FILES{i});
        ST=a(3:end,1);
        sst=a(3:end,3);
        stimtimes=sst(~isnan(sst));
        offset=max(stimtimes);
        oST=ST-offset;
        numspksp=find(oST>0);
        numspksn=find(oST>20);
        FF=1./diff(oST);
        selspk=setdiff(numspksp,numspksn);
        if ~isempty(selspk)
            plot(oST(selspk),log10(FF(selspk)),'k.')
            title(FILES{i});
            hold all
            line([10 10],[-0.5 2.5],'LineStyle','--','Color','r')
            axis([0 20 -0.5 2.5]);
            [ps xs ys]=selectdata;
            if~isempty(ps{2})
                dat.dur(i)=max(xs{2});
                dat.peak(i)=10.^max(ys{2});
                dat.sc(i)=numel(xs{2});
                dat.ave_rate(i)=dat.sc(i)./dat.dur(i);
            else
                dat.dur(i)=0;
                dat.peak(i)=0;
                dat.sc(i)=0;
                dat.ave_rate(i)=0;
            end
        else
            cla
            dat.dur(i)=0;
            dat.peak(i)=0;
            dat.sc(i)=0;
            dat.ave_rate(i)=0;
            warndlg('no spikes found');
        end
        
    catch
        dat.dur(i)=nan;
        dat.peak(i)=nan;
        dat.sc(i)=nan;
        dat.ave_rate(i)=nan;
        
    end
    
end
export2wsdlg({'Spike Data'},{'ID_data'},{dat});

%%% See ID spike count box plot fcn
% figure
% hold all
% ngrps=size(handles.GROUPPOOL,2);
% ttn=0;
% [a b c]=xlsread('Z:\Lab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
% UFNXL=c;
% clear a
% clear b
% clear c
% for j=1:ngrps
%     ntraces=size(handles.GROUPPOOL(j).files,1);
%     clear gUFNs
%     for i=1:ntraces
%         try
%             
%             [a b c]=xlsread(handles.GROUPPOOL(j).files{i});
%             gUFNs(i)=APgetflynum(handles.GROUPPOOL(j).files{i},UFNXL);
%             ST=a(3:end,1);
%             sst=a(3:end,3);
%             stimtimes=sst(~isnan(sst));
%             offset=stimtimes(1);
%             oST=ST-offset;
%             numspksp=find(oST>2);
%             numspksn=find(oST>10);
%             nspks(i)=numel(setdiff(numspksp,numspksn));
%             clear doST
%             clear ST
%             clear sst
%             clear stimtimes
%             clear offset
%             clear oST
%         catch
%             nspks(i)=nan;
%             ['error with',num2str(i)]
%         end
%     end
%     tnspks(j).nspks=nspks;
%     tnspks(j).name=handles.GROUPPOOL(j).name{1};
%     tnspks(j).UFNs=gUFNs;
%     midspks(j)=nanmean(nspks);
%     medspks(j)=nanmedian(nspks);
%     semidspks(j)=nanstd(nspks)/sqrt(numel(nspks));
%     clear nspks
%     
%     
% end
% errorbar(midspks,semidspks,'LineStyle','none');
% hold all
% bar(midspks);
% figure
% bar(medspks);
% figure
% maxnspks=0;
% for i=1:ngrps
%     if maxnspks<max(tnspks(i).nspks)
%         maxnspks=max(tnspks(i).nspks);
%     end
% end
% X=linspace(0,maxnspks,10);
% for i=1:ngrps
%     hnspks(:,i)=histc(tnspks(i).nspks,X)/numel(tnspks(i).nspks);
% end
% bar3(X,hnspks);




% --- Executes on button press in Print_Traces_btn.
function Print_Traces_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Print_Traces_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PM=questdlg('Open APhysPlotTraces or Auto-Generate?','Print Traces','PlotTraces','Auto','Cancel','Cancel');
if strcmp(PM,'PlotTraces')
    ntraces=size(handles.GROUPFILE,1);
    groupn=get(handles.group_list,'Value');
    grpNAME=handles.GROUPPOOL(groupn).name{1};
    recdir=uigetdir('D:\Recordings Hold');
    if isnumeric(recdir)
        recdir='D:\Recordings Hold';
    end
    
    for i=1:ntraces
        [a b c]=fileparts(handles.GROUPFILE{i});
        [t1 r]=strtok(b,'_');
        [t2 r]=strtok(r,'_');
        fname{i}=[recdir,'\',t1,'_',t2,'.txt'];
    end
    APhysPlotTraces(fname);
end
if strcmp(PM,'Auto')
    UA=questdlg('Print traces for all or selected group(s)?','Print Traces','Selected','All','Cancel');
    if strcmp(UA,'Selected')==1
        ntraces=size(handles.GROUPFILE,1);
        groupn=get(handles.group_list,'Value');
        grpNAME=handles.GROUPPOOL(groupn).name{1};
        recdir=uigetdir('C:\Users\wulab\Documents\Recordings Hold');
        [TGTFILE,TGTPATH,IDX]=uiputfile('R:\BioDataLab\Atulya\Physiology Summary and Organization\*.pdf','Save Set As');
        for i=1:ntraces
            [a b c]=fileparts(handles.GROUPFILE{i});
            [t1 r]=strtok(b,'_');
            [t2 r]=strtok(r,'_');
            fname{i}=[recdir,'\',t1,'_',t2,'.txt'];
        end
        nfigs=ceil(ntraces/3);
        h1=waitbar(0,'0 done');
        cfilea=1;
        for i=1:nfigs
            
            ptf=figure ('Visible','off');
            set(gcf,'PaperPositionMode','manual');
            set(gcf,'Units','inches');
            set(gcf,'PaperPosition',[0.1 0.1 8.3 10.8])
            %ANALYZE FIRST FILE in FIGURE
            if cfilea<=ntraces
                [num2str(cfilea)]
                FILEinfo=dir(fname{cfilea});
                FSIZE=FILEinfo.bytes;
                if (FSIZE/1000000)<200
                    
                    
                    try
                        waitbar(cfilea/ntraces,h1,[num2str(cfilea),' of ',num2str(ntraces),' files analyzing']);
                        A=importdata(fname{cfilea});
                        
                        time=A(:,1);
                        ch1=A(:,2);
                        ch2=A(:,3);
                        ch3=A(:,4);
                        stim=A(:,5);
                        clear A
                        finfo=GetAPhysFileInfo(fname{cfilea});
                        CI={['Genotype: ',finfo.Genotype,' Sex: ',finfo.Sex,' Age: ',num2str(finfo.Age)];[finfo.Date,' ',finfo.Time];['tpf: ',num2str(finfo.TestPulseFrequency),' tpd: ',num2str(finfo.TestPulseDuration),' bf: ',num2str(finfo.BurstFrequency),' bd: ',num2str(finfo.BurstDuration),' pa: ',num2str(finfo.PulseAmplitude)]};
                        figure(ptf);
                        set(ptf,'Visible','off');
                        subplot(14,1,1:2);
                        plot(time,ch1,'k');
                        axis([0 100 -1 6]);
                        ylabel(finfo.Ch1Name,'Interpreter','None');
                        subplot(14,1,3:4)
                        plot(time,ch2,'k');
                        axis([0 100 -1 6]);
                        ylabel(finfo.Ch2Name,'Interpreter','None');
                        annotation('textbox',[.1 .9 .85 .1],'String',fname{cfilea},'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
                        annotation('textbox',[.1 .9 .85 .1],'String',CI,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                        
                    catch
                        ['error with', num2str(cfilea)]
                        
                    end
                end
                cfilea=cfilea+1;
            end
            %ANALYZE Second FILE in FIGURE
            if cfilea<=ntraces
                [num2str(cfilea)]
                FILEinfo=dir(fname{cfilea});
                FSIZE=FILEinfo.bytes;
                if (FSIZE/1000000)<200
                    try
                        waitbar(cfilea/ntraces,h1,[num2str(cfilea),' of ',num2str(ntraces),' files analyzing']);
                        A=importdata(fname{cfilea});
                        time=A(:,1);
                        ch1=A(:,2);
                        ch2=A(:,3);
                        ch3=A(:,4);
                        stim=A(:,5);
                        clear A
                        finfo=GetAPhysFileInfo(fname{cfilea});
                        CI={['Genotype: ',finfo.Genotype,' Sex: ',finfo.Sex,' Age: ',num2str(finfo.Age)];[finfo.Date,' ',finfo.Time];['tpf: ',num2str(finfo.TestPulseFrequency),' tpd: ',num2str(finfo.TestPulseDuration),' bf: ',num2str(finfo.BurstFrequency),' bd: ',num2str(finfo.BurstDuration),' pa: ',num2str(finfo.PulseAmplitude)]};
                        figure(ptf);
                        set(ptf,'Visible','off');
                        subplot(14,1,6:7);
                        plot(time,ch1,'k');
                        axis([0 100 -1 6]);
                        ylabel(finfo.Ch1Name,'Interpreter','None');
                        subplot(14,1,8:9)
                        plot(time,ch2,'k');
                        axis([0 100 -1 6]);
                        ylabel(finfo.Ch2Name,'Interpreter','None');
                        annotation('textbox',[.1 .58 .85 .1],'String',fname{cfilea},'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
                        annotation('textbox',[.1 .58 .85 .1],'String',CI,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                        
                    catch
                        ['error with', num2str(cfilea)];
                        
                    end
                end
                cfilea=cfilea+1;
            end
            %ANALYZE third FILE in FIGURE
            if cfilea<=ntraces
                [num2str(cfilea)]
                FILEinfo=dir(fname{cfilea});
                FSIZE=FILEinfo.bytes;
                if (FSIZE/1000000)<200
                    try
                        waitbar(cfilea/ntraces,h1,[num2str(cfilea),' of ',num2str(ntraces),' files analyzing']);
                        A=importdata(fname{cfilea});
                        time=A(:,1);
                        ch1=A(:,2);
                        ch2=A(:,3);
                        ch3=A(:,4);
                        stim=A(:,5);
                        clear A
                        finfo=GetAPhysFileInfo(fname{cfilea});
                        CI={['Genotype: ',finfo.Genotype,' Sex: ',finfo.Sex,' Age: ',num2str(finfo.Age)];[finfo.Date,' ',finfo.Time];['tpf: ',num2str(finfo.TestPulseFrequency),' tpd: ',num2str(finfo.TestPulseDuration),' bf: ',num2str(finfo.BurstFrequency),' bd: ',num2str(finfo.BurstDuration),' pa: ',num2str(finfo.PulseAmplitude)]};
                        figure(ptf);
                        set(ptf,'Visible','off');
                        subplot(14,1,11:12);
                        plot(time,ch1,'k');
                        axis([0 100 -1 6]);
                        ylabel(finfo.Ch1Name,'Interpreter','None');
                        subplot(14,1,13:14)
                        plot(time,ch2,'k');
                        axis([0 100 -1 6]);
                        ylabel(finfo.Ch2Name,'Interpreter','None');
                        annotation('textbox',[.1 .28 .85 .1],'String',fname{cfilea},'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
                        annotation('textbox',[.1 .28 .85 .1],'String',CI,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                        
                    catch
                        ['error with', num2str(cfilea)];
                        
                    end
                end
                cfilea=cfilea+1;
            end
            CB={[grpNAME,': Page ',num2str(i),' of ',num2str(nfigs)]};
            annotation('textbox',[.1 .0 .85 .06],'String',['Traces printed: ',date],'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
            annotation('textbox',[.1 .0 .85 .06],'String',CB,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
            if i==1
                print('-dpsc2','-r600',ptf,'SPKTEST11.ps')
            end
            if i~=1
                print('-dpsc2','-r600','-append',ptf,'SPKTEST11.ps')
            end
            delete(ptf);
        end
        ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
        delete('SPKTEST11.ps');
        delete(h1);
        msgbox('PDF Creation Complete');
    end
    if strcmp(UA,'All')==1
        ngrps=size(handles.GROUPPOOL,2);
        [TGTFILE,TGTPATH,IDX]=uiputfile('R:\BioDataLab\Atulya\Physiology Summary and Organization\*.pdf','Save Set As');
        isfirst=1;
        h1=waitbar(0,'0 done');
        for j=1:ngrps
            clear fname;
            ntraces=size(handles.GROUPPOOL(j).files,1);
            groupn=j;
            grpNAME=handles.GROUPPOOL(groupn).name{1};
            recdir=uigetdir('C:\Users\wulab\Documents\Recordings Hold');
            for i=1:ntraces
                [a b c]=fileparts(handles.GROUPPOOL(j).files{i});
                [t1 r]=strtok(b,'_');
                [t2 r]=strtok(r,'_');
                fname{i}=[recdir,'\',t1,'_',t2,'.txt'];
            end
            nfigs=ceil(ntraces/3);
            cfilea=1;
            for i=1:nfigs
                ptf=figure ('Visible','off');
                set(gcf,'PaperPositionMode','manual');
                set(gcf,'Units','inches');
                set(gcf,'PaperPosition',[0.1 0.1 8.3 10.8])
                %ANALYZE FIRST FILE in FIGURE
                if cfilea<=ntraces
                    [num2str(cfilea)]
                    FILEinfo=dir(fname{cfilea});
                    FSIZE=FILEinfo.bytes;
                    if (FSIZE/1000000)<200
                        try
                            waitbar((j-1)/ngrps+cfilea/(ntraces*ngrps),h1,{['group #', num2str(j),' of ', num2str(ngrps)];[num2str(cfilea),' of ',num2str(ntraces),' files analyzing']});
                            A=importdata(fname{cfilea});
                            time=A(:,1);
                            ch1=A(:,2);
                            ch2=A(:,3);
                            ch3=A(:,4);
                            stim=A(:,5);
                            clear A
                            finfo=GetAPhysFileInfo(fname{cfilea});
                            CI={['Genotype: ',finfo.Genotype,' Sex: ',finfo.Sex,' Age: ',num2str(finfo.Age)];[finfo.Date,' ',finfo.Time];['tpf: ',num2str(finfo.TestPulseFrequency),' tpd: ',num2str(finfo.TestPulseDuration),' bf: ',num2str(finfo.BurstFrequency),' bd: ',num2str(finfo.BurstDuration),' pa: ',num2str(finfo.PulseAmplitude)]};
                            figure(ptf);
                            set(ptf,'Visible','off');
                            subplot(14,1,1:2);
                            plot(time,ch1,'k');
                            axis([0 100 -1 6]);
                            ylabel(finfo.Ch1Name,'Interpreter','None');
                            subplot(14,1,3:4)
                            plot(time,ch2,'k');
                            axis([0 100 -1 6]);
                            ylabel(finfo.Ch2Name,'Interpreter','None');
                            annotation('textbox',[.1 .9 .85 .1],'String',fname{cfilea},'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
                            annotation('textbox',[.1 .9 .85 .1],'String',CI,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                            
                        catch
                            ['error with', num2str(cfilea)]
                            
                        end
                    end
                    cfilea=cfilea+1;
                end
                %ANALYZE Second FILE in FIGURE
                if cfilea<=ntraces
                    [num2str(cfilea)]
                    FILEinfo=dir(fname{cfilea});
                    FSIZE=FILEinfo.bytes;
                    if (FSIZE/1000000)<200
                        try
                            waitbar((j-1)/ngrps+cfilea/(ntraces*ngrps),h1,{['group #', num2str(j),' of ', num2str(ngrps)];[num2str(cfilea),' of ',num2str(ntraces),' files analyzing']});
                            A=importdata(fname{cfilea});
                            time=A(:,1);
                            ch1=A(:,2);
                            ch2=A(:,3);
                            ch3=A(:,4);
                            stim=A(:,5);
                            clear A
                            finfo=GetAPhysFileInfo(fname{cfilea});
                            CI={['Genotype: ',finfo.Genotype,' Sex: ',finfo.Sex,' Age: ',num2str(finfo.Age)];[finfo.Date,' ',finfo.Time];['tpf: ',num2str(finfo.TestPulseFrequency),' tpd: ',num2str(finfo.TestPulseDuration),' bf: ',num2str(finfo.BurstFrequency),' bd: ',num2str(finfo.BurstDuration),' pa: ',num2str(finfo.PulseAmplitude)]};
                            figure(ptf);
                            set(ptf,'Visible','off');
                            subplot(14,1,6:7);
                            plot(time,ch1,'k');
                            axis([0 100 -1 6]);
                            ylabel(finfo.Ch1Name,'Interpreter','None');
                            subplot(14,1,8:9)
                            plot(time,ch2,'k');
                            axis([0 100 -1 6]);
                            ylabel(finfo.Ch2Name,'Interpreter','None');
                            annotation('textbox',[.1 .58 .85 .1],'String',fname{cfilea},'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
                            annotation('textbox',[.1 .58 .85 .1],'String',CI,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                            
                        catch
                            ['error with', num2str(cfilea)];
                            
                        end
                    end
                    cfilea=cfilea+1;
                end
                %ANALYZE Third FILE in FIGURE
                if cfilea<=ntraces
                    [num2str(cfilea)]
                    FILEinfo=dir(fname{cfilea});
                    FSIZE=FILEinfo.bytes;
                    if (FSIZE/1000000)<200
                        try
                            waitbar((j-1)/ngrps+cfilea/(ntraces*ngrps),h1,{['group #', num2str(j),' of ', num2str(ngrps)];[num2str(cfilea),' of ',num2str(ntraces),' files analyzing']});
                            A=importdata(fname{cfilea});
                            time=A(:,1);
                            ch1=A(:,2);
                            ch2=A(:,3);
                            ch3=A(:,4);
                            stim=A(:,5);
                            clear A
                            finfo=GetAPhysFileInfo(fname{cfilea});
                            CI={['Genotype: ',finfo.Genotype,' Sex: ',finfo.Sex,' Age: ',num2str(finfo.Age)];[finfo.Date,' ',finfo.Time];['tpf: ',num2str(finfo.TestPulseFrequency),' tpd: ',num2str(finfo.TestPulseDuration),' bf: ',num2str(finfo.BurstFrequency),' bd: ',num2str(finfo.BurstDuration),' pa: ',num2str(finfo.PulseAmplitude)]};
                            figure(ptf);
                            set(ptf,'Visible','off');
                            subplot(14,1,11:12);
                            plot(time,ch1,'k');
                            axis([0 100 -1 6]);
                            ylabel(finfo.Ch1Name,'Interpreter','None');
                            subplot(14,1,13:14)
                            plot(time,ch2,'k');
                            axis([0 100 -1 6]);
                            ylabel(finfo.Ch2Name,'Interpreter','None');
                            annotation('textbox',[.1 .28 .85 .1],'String',fname{cfilea},'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
                            annotation('textbox',[.1 .28 .85 .1],'String',CI,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                            
                        catch
                            ['error with', num2str(cfilea)];
                            
                        end
                    end
                    cfilea=cfilea+1;
                end
                CB={[grpNAME,': Page ',num2str(i),' of ',num2str(nfigs)]};
                annotation('textbox',[.1 .0 .85 .06],'String',['Traces printed: ',date],'LineStyle','none','HorizontalAlignment','left','VerticalAlignment','top','Interpreter','None');
                annotation('textbox',[.1 .0 .85 .06],'String',CB,'LineStyle','none','HorizontalAlignment','right','VerticalAlignment','top','Interpreter','None');
                if isfirst==1
                    print('-dpsc2','-r600',ptf,'SPKTEST11.ps')
                end
                if isfirst~=1
                    print('-dpsc2','-r600','-append',ptf,'SPKTEST11.ps')
                end
                delete(ptf);
                isfirst=0;
            end
            
        end
        ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
        delete('SPKTEST11.ps');
        delete(h1);
        msgbox('PDF Creation Complete');
    end
end


% --------------------------------------------------------------------
function BSCM_menu_Callback(hObject, eventdata, handles)
% hObject    handle to BSCM_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matsrc=questdlg('Do you want to load or create a binned spike count matrix?','BSCM Source','Load','Create','Cancel','Load');
if strcmp(matsrc,'Load')
    LOADNAME=uigetfile('*.mat');
    load(LOADNAME);
    waithan=waitbar(0,'Adding Groups')
    ctn=size(BSCM,1);
    ngrps=size(handles.GROUPPOOL,2);
    prevgrps=numel(GREE)/2;
    for i=1:2:numel(GREE)-1
        GRN((i+1)/2)=TLN(i);
    end
end
if strcmp(matsrc,'Create')
    ngrps=size(handles.GROUPPOOL,2);
    BinSzst=inputdlg('Enter Bin Size (ms)','Bin Size',1,{'1000'});
    BinSz=str2num(BinSzst{1});
    BinOlst=inputdlg('Enter Bin Overlap (0=None to 1=Complete)','Bin Overlap',1,{'0'});
    BinOl=str2num(BinOlst{1});
    ebinsize=(BinSz/1000)*(1-BinOl);
    nbins=floor(max(90)/ebinsize);
    BSCM=nan(0,nbins);
    ctn=0;
    waithan=waitbar(0,'Starting');
    prevgrps=0;
end
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
for i=1:ngrps
    waitbar(i/ngrps,waithan,['Group #', num2str(i),' of ', num2str(ngrps)]);
    nfiles=numel(handles.GROUPPOOL(i).files);
    Lists(i).name=handles.GROUPPOOL(i).name;
    
    for j=1:nfiles
        try
            ctn=ctn+1;
            Lists(i+prevgrps).nfiles(j)=handles.GROUPPOOL(i).files(j);
            Lists(i+prevgrps).UFNs(j)=APgetflynum(handles.GROUPPOOL(i).files{j},FLYNUMXL);
            [a b c]=xlsread(handles.GROUPPOOL(i).files{j});
            ST=a(3:end,1);
            if isnan(ST(1))
                ST=ST(2:end);
            end
            sst=a(3:end,3);
            if isnan(sst(1))
                sst=sst(2:end);
            end
            maxt=90;
            stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oend=stimtimes(end)-stimtimes(1);
            oST=ST-offset;
            BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
            BSCM(ctn,:)=BinnedST(2,1:size(BSCM,2));
            Lists(i+prevgrps).BSCM(j,:)=BSCM(ctn,:);
            Lists(i+prevgrps).erf(j)=0;
        catch
            BSCM(ctn,1:nbins)=nan(1,nbins);
            Lists(i+prevgrps).BSCM(j,:)=BSCM(ctn,:);
            Lists(i+prevgrps).erf(j)=1;
            ['error with group ', num2str(i),' trace ', num2str(j)]
        end
        
    end
    GRN(i+prevgrps)=handles.GROUPPOOL(i).name;
    GRE(i+prevgrps)=ctn;
end

figure
imagesc(BSCM)
caxis([0 20]);
load('BSCMcolormap.mat')
colormap(BSCMcolormap);

if  strcmp(matsrc,'Create')
    pGRE=0;
else
    pGRE=GREE(end);
end
for k=prevgrps+1:numel(GRE)
    GREE(k*2-1)=(GRE(k)-pGRE)/2+pGRE;
    GREE(k*2)=GRE(k);
    pGRE=GRE(k);
end

set(gca,'YTick',GREE)

TL=get(gca,'YTickLabel');
for k=1:size(TL,1)
    TLN{k}=TL(k,1:end);
end
for k=1:numel(GRE)
    TLN(k*2-1)=GRN(k);
end

set(gca,'YTickLabel',TLN);
xlabel('Elapsed Time (s)');

svws=questdlg('Do you want to save workspace?');
ep=GREE(2:2:end);
sp=[1,ep(1:end-1)+1];
if strcmp(svws,'Yes')
    SAVENAME=uiputfile('*.mat');
    save(SAVENAME,'BSCM','TLN','GREE','BinSz','BinOl','ebinsize','nbins','sp','ep','Lists');
    
end


% --------------------------------------------------------------------
function DimRM_Callback(hObject, eventdata, handles)
% hObject    handle to DimRM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function BSCMCov_menu_Callback(hObject, eventdata, handles)
% hObject    handle to BSCMCov_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    LOADNAME=uigetfile('*.mat');
    load(LOADNAME);

BSCM(isnan(BSCM))=0;
StartBind=inputdlg('Enter Starting Bin','Starting Bin',1,{num2str(2/ebinsize+1)});
startbin=str2num(StartBind{1});
cBSCM=nancov(BSCM(:,startbin:end)');
stdBSCM=nanstd(BSCM(:,startbin:end)');
smatBSCM=stdBSCM'*stdBSCM;
figure
imagesc(cBSCM);
set(gca,'XTick',GREE)
set(gca,'YTick',GREE)
set(gca,'XTickLabel',TLN)
title('Covariance Matrix');
set(gca,'YTickLabel',TLN)
cmax=max(max(cBSCM));
caxis([-1*cmax, cmax]);
load('RGcmap.mat');
colormap(RGcmap);
colorbar;

figure
imagesc(cBSCM./smatBSCM);
set(gca,'XTick',GREE)
set(gca,'YTick',GREE)
set(gca,'XTickLabel',TLN)
set(gca,'YTickLabel',TLN)
title('Normalized Covariance Matrix');
load('RGcmap.mat');
colormap(RGcmap);

colorbar;

for i=1:numel(TLN)/2
    Lists(i).name=TLN((2*i)-1);
    nfiles(i)=ep(i)-sp(i)+1;
end
export2wsdlg({'Covariance','STD Mat','Normalized Cov'},{'cBSCM','smatBSCM','ncBSCM'},{cBSCM,smatBSCM,cBSCM./smatBSCM});
SAVENAME=uiputfile('*.mat');
save(SAVENAME,'BSCM','TLN','GREE','BinSz','BinOl','ebinsize','nbins','sp','ep','Lists','cBSCM','smatBSCM');



% --------------------------------------------------------------------
function BSCM_XCorr_menu_Callback(hObject, eventdata, handles)
% hObject    handle to BSCM_XCorr_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function BSCM_JS_Div_menu_Callback(hObject, eventdata, handles)
% hObject    handle to BSCM_JS_Div_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles


% --------------------------------------------------------------------
function VP_dist_mat_menu_Callback(hObject, eventdata, handles)
% hObject    handle to VP_dist_mat_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q_val=0;
inpt=inputdlg('Please enter "q" value (in s)','q Value',1,{'1'});
qval=inpt{1};
if ~isempty(str2num(qval))
    if str2num(qval)>0
        q_val=qval;
    end
end
if q_val<=0
    msgbox('Error with q value');
end
if q_val>0
    ctn=1;
    ngrps=size(handles.GROUPPOOL,2);
    VPdistmat=nan(0,0);
    waithan=waitbar(0);
    for i=1:ngrps
        waitbar(i/ngrps,waithan,['Group #', num2str(i),' of ', num2str(ngrps)]);
        nfiles=numel(handles.GROUPPOOL(i).files);
        for j=1:nfiles
            try
                [a b c]=xlsread(handles.GROUPPOOL(i).files{j});
                ST=a(3:end,1);
                if isnan(ST(1))
                    ST=ST(2:end);
                end
                sst=a(3:end,3);
                if isnan(sst(1))
                    sst=sst(2:end);
                end
                maxt=90;
                stimtimes=sst(~isnan(sst));
                offset=stimtimes(1);
                oend=stimtimes(end)-stimtimes(1);
                oST=ST-offset;
                noST=oST(~isnan(oST));
                fST=oST(find(noST>oend));
                ct(ctn).st=fST;
                ctn=ctn+1;
                
            catch
                ct(ctn).st=nan;
                ctn=ctn+1;
            end
        end
        GRN(i)=handles.GROUPPOOL(i).name;
        GRE(i)=ctn;
    end
    delete(waithan);
    for i=1:size(ct,2)
        tic
        for j=i:size(ct,2)
            
            VPdistmat(i,j)=APVPdist(ct(i).st,ct(j).st,q_val);
            VPdistmat(j,i)=VPdistmat(i,j);
            
        end
        toc
    end
    figure
    imagesc(VPdistmat)
    
    
end












% --------------------------------------------------------------------
function FFGrpBxPlt_Callback(hObject, eventdata, handles)
% hObject    handle to FFGrpBxPlt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ngrps=size(handles.GROUPPOOL,2);
UFNs=zeros(0,1);
FFarray=zeros(0,1);
CVarray=zeros(0,1);
IDgrp=zeros(0,1);
ISIarray=zeros(0,1);
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
for i=1:ngrps
    ntraces=size(handles.GROUPPOOL(i).files,1);
    lnames(i)=handles.GROUPPOOL(i).name;
    for j=1:ntraces
        try
            disp(j)
            fname=handles.GROUPPOOL(i).files{j};
            fltstat=APFLTISIstats(fname,0,0);
            gntypffcv(i).ff(j)=fltstat.SCT;
            gntypffcv(i).cv(j)=fltstat.ISIcv;
            FFarray(end+1)=fltstat.SCT;
            CVarray(end+1)=fltstat.ISIcv;
            IDgrp(end+1)=i;
            UFNs(end+1)=APgetflynum(handles.GROUPPOOL(i).files{j},FLYNUMXL);
            ISIarray=[ISIarray;fltstat.ISI];
        catch ME
           FFarray(end+1)=nan;
            CVarray(end+1)=nan;
            IDgrp(end+1)=i;
            UFNs(end+1)=APgetflynum(handles.GROUPPOOL(i).files{j},FLYNUMXL);
        end
    end
    
    
end
% FFarray=zeros(0);
% CVarray=zeros(0);
% IDgrp=zeros(0);
% for i=1:ngrps
%     FFarray=cat(2,FFarray,gntypffcv(i).ff);
%     CVarray=cat(2,CVarray,gntypffcv(i).cv);
%     IDgrp=cat(2,IDgrp,ones(size(gntypffcv(i).ff))*i);
% end
% FFarray(isnan(FFarray))=0;
% CVarray(isnan(CVarray))=0;
% figure
% boxplot(FFarray,IDgrp,'plotstyle','compact','extrememode','compress','symbol','rx')
% figure
% boxplot(log10(FFarray),IDgrp,'plotstyle','compact','extrememode','compress','symbol','rx')


export2wsdlg([{'FFarray'}, {'CVarray'},{'IDgrp'},{'ISIarray'},{'UFNs'}],[{'FFarray'}, {'CVarray'},{'IDgrp'},{'ISIarray'},{'UFNs'}],[{FFarray}, {CVarray},{IDgrp},{ISIarray},{UFNs}]);

kruskalwallis(FFarray,IDgrp);


% --------------------------------------------------------------------
function LogHist_menu_Callback(hObject, eventdata, handles)
% hObject    handle to LogHist_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ngrps=size(handles.GROUPPOOL,2);
grpisi=zeros(0);
gid=zeros(0);
mh=waitbar(0,'Loading Files');
for i=1:ngrps
    ntraces=size(handles.GROUPPOOL(i).files,1);
    
    
    for j=1:ntraces
        disp(j)
        [a b c]=APloadSTdat(handles.GROUPPOOL(i).files{j});
        
        ST=a(3:end,1);
        dST=diff(ST(~isnan(ST)));
        gn=i*ones(size(dST));
        grpisi=cat(2,grpisi,dST');
        gid=cat(2,gid,gn');
    end
    waitbar(i/ngrps,mh,'Loading Files');
end
delete(mh);
ScPar=inputdlg({'min','max','step','type (linear=0/log=1)'},'Enter Scale Parameters',[1;1;1;1],{'-3','1','50','1'});
binmin=str2num(ScPar{1});
binmax=str2num(ScPar{2});
binstep=str2num(ScPar{3});
if str2num(ScPar{4})
    X=logspace(binmin,binmax,binstep);
end
if ~str2num(ScPar{4})
    X=linspace(binmin,binmax,binstep);
end

figure;
for i=1:ngrps
    N(i,:)=hist(grpisi(find(gid==i)),X);
    loglog(X,N(i,:)./sum(N(i,:),2),'x-');
    hold all
end
xlabel('ISI duration (s)');
ylabel('Relative Frequency');






% --------------------------------------------------------------------
function BSCM_entropy_menu_Callback(hObject, eventdata, handles)
% hObject    handle to BSCM_entropy_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matsrc=questdlg('Do you want to load or create a binned spike count matrix?','BSCM Source','Load','Create','Cancel','Load');
if strcmp(matsrc,'Create')
    ngrps=size(handles.GROUPPOOL,2);
    BinSzst=inputdlg('Enter Bin Size (ms)','Bin Size',1,{'1000'});
    BinSz=str2num(BinSzst{1});
    BinOlst=inputdlg('Enter Bin Overlap (0=None to 1=Complete)','Bin Overlap',1,{'0'});
    BinOl=str2num(BinOlst{1});
    ebinsize=(BinSz/1000)*(1-BinOl);
    nbins=floor(max(90)/ebinsize);
    BSCM=nan(0,nbins);
    ctn=0;
    waithan=waitbar(0,'Starting');
    for i=1:ngrps
        waitbar(i/ngrps,waithan,['Group #', num2str(i),' of ', num2str(ngrps)]);
        nfiles=numel(handles.GROUPPOOL(i).files);
        for j=1:nfiles
            ctn=ctn+1;
            try
                [a b c]=xlsread(handles.GROUPPOOL(i).files{j});
                ST=a(3:end,1);
                if isnan(ST(1))
                    ST=ST(2:end);
                end
                sst=a(3:end,3);
                if isnan(sst(1))
                    sst=sst(2:end);
                end
                maxt=90;
                stimtimes=sst(~isnan(sst));
                offset=stimtimes(1);
                oend=stimtimes(end)-stimtimes(1);
                oST=ST-offset;
                BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
                BSCM(ctn,:)=BinnedST(2,1:size(BSCM,2));
            catch
                BSCM(ctn,:)=nan(1,size(BSCM,2));
                ['error with', num2str(ctn)]
            end
        end
        GRN(i)=handles.GROUPPOOL(i).name;
        GRE(i)=ctn;
    end
    figure
    imagesc(BSCM)
    caxis([0 20]);
    pGRE=0;
    for k=1:numel(GRE)
        GREE(k*2-1)=(GRE(k)-pGRE)/2+pGRE;
        GREE(k*2)=GRE(k);
        pGRE=GRE(k);
    end
    set(gca,'YTick',GREE)
    TL=get(gca,'YTickLabel');
    for k=1:size(TL,1)
        TLN{k}=TL(k,1:end);
    end
    for k=1:numel(GRE)
        TLN(k*2-1)=GRN(k);
    end
    set(gca,'YTickLabel',TLN);
    
    svws=questdlg('Do you want to save workspace?');
    if strcmp(svws,'Yes')
        SAVENAME=uiputfile('*.mat');
        save(SAVENAME,'BSCM','TLN','GREE','BinSz','BinOl','ebinsize','nbins');
        
    end
end
if strcmp(matsrc,'Load')
    LOADNAME=uigetfile('*.mat');
    load(LOADNAME);
end


% --------------------------------------------------------------------
function ID_Total_Spks_BxPlt_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ID_Total_Spks_BxPlt_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ngrps=size(handles.GROUPPOOL,2);
nspikes=zeros(1,1);
groupnumber=ones(1,1);
ctn=1;
for i=1:ngrps
    grpnames(i)=handles.GROUPPOOL(i).name;
    ntraces=size(handles.GROUPPOOL(i).files,1);
    for j=1:ntraces
        try
            
            [a b c]=xlsread(handles.GROUPPOOL(i).files{j});
            ST=a(3:end,1);
            sst=a(3:end,3);
            stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oST=ST-offset;
            numspksp=find(oST>2);
            numspksn=find(oST>10);
            nspikes(ctn)=numel(setdiff(numspksp,numspksn));
            groupnumber(ctn)=i;
            ctn=ctn+1;
            clear doST
            clear ST
            clear sst
            clear stimtimes
            clear offset
            clear oST
            
        catch
            nspikes(ctn)=nan;
            groupnumber(ctn)=i;
            ctn=ctn+1;
            ['error with',num2str(i)]
        end
    end
    
end
figure
boxplot(nspikes,groupnumber,'labels',grpnames,'labelorientation','inline');

figure
notBoxPlot(nspikes,groupnumber);


figure
boxplot(nspikes,groupnumber);
[p t s]=kruskalwallis(nspikes,groupnumber,'off')

export2wsdlg({'nspks','groupnum','groupname'},{'nspks','groupnum','groupname'},{nspikes,groupnumber,grpnames})
p
t
s



% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Mic_Periodogram_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Mic_Periodogram_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
MN=APgetmicfilenames(FILENAMES,handles.MICDATPATH,0);
MICNAMES=MN.names;
[s,v]=listdlg('PromptString','Select a file to analyze:','SelectionMode','multiple','ListString',MICNAMES);
for i=1:numel(s)
    MICFILE{i}=MICNAMES{s(i)};
end
clear MICNAMES;
MICNAMES=MICFILE;
F=linspace(1,500,500);
wbFrange=[150,250];
if ~isempty(MICNAMES)
    h=waitbar(0,'Begining Analysis');
    for i=1:size(MICNAMES,2)
        try
            waitbar(i/size(MICNAMES,2),h,'Creating Periodogram');
            [Y fs n]=wavread(MICNAMES{i});
            
            [Pxx freq]=periodogram(Y(:,1),[],F,fs);
            figure
            semilogx(freq,10*log10(Pxx));
            xlabel('Frequency (Hz)');
            ylabel('Power (dB)');
            title(MICNAMES{i})
            axis([10 10000 -80 -20])
            SP=sum(Pxx);
            nPow(i,:)=Pxx./SP;
        catch
            nPow(i,:)=nan(1,size(nPow,2));
            ['error with ',num2str(i)]
        end
    end
    delete(h);
    qsub=questdlg('Do you want to subtract noise?');
    if strcmp(qsub,'Yes')
        [POWFILE POWPATH]=uigetfile([handles.LISTPATH,'\','*.mat']);
        load([POWPATH,POWFILE]);
        noisepsd=nanmean(powsd)
        for i=1:size(nPow,1)
            nPow(i,:)=(nPow(i,:)-noisepsd);
            nPow(i,find(nPow(i,:)<0))=0;
        end
    end
    figure
    hold all
    for i=1:size(nPow,1)
        plot(F,10*log10(nPow(i,:)),'b');
        [maxPow(i) maxPfreq(i)]=max(nPow(i,:));
        plot(F(maxPfreq(i)),10*log10(maxPow(i)),'r+');
    end
    WBfreqs=nan(1,size(nPow,1));
    cminwbf=find(F(maxPfreq)>wbFrange(1));
    cmaxwbf=find(F(maxPfreq)<wbFrange(2));
    WBfreqs(intersect(cmaxwbf,cminwbf))=F(maxPfreq(intersect(cmaxwbf,cminwbf)));
    dbnPow=10*log10(nPow);
    dbnPow(isinf(dbnPow))=nan;
    plot(F,nanmean(dbnPow),'k','LineWidth',3);
    xlabel('Frequency (Hz)');
    ylabel('Relative Power (dB)');
    PopMeanWBF=nanmean(WBfreqs);
    PopSEMW=nanstd(WBfreqs)./sqrt(sum(~isnan(WBfreqs)));
    SNR=10*log10(maxPow)-10*log10(1/200)
    export2wsdlg({'NormalizedPower','WBFreqs'},{'NormalizedPower','WBF'},{nPow,WBfreqs});
end









% --------------------------------------------------------------------
function Mic_Spectrogram_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Mic_Spectrogram_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BinSize=1000;
Overlap=0.5;
F=[100:2:300];
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
MN=APgetmicfilenames(FILENAMES,handles.MICDATPATH,0);
MICNAMES=MN.names;
if ~isempty(MICNAMES)
[s,v]=listdlg('PromptString','Select a file to analyze:','SelectionMode','multiple','ListString',MICNAMES);
for i=1:numel(s)
    MICFILE{i}=MICNAMES{s(i)};
end
else
    wh=warndlg('No Mic Files Found, DLM spiking analyzed only','modal');
    uiwait(wh);
    MICFILE=FILENAMES;
    MN.names=FILENAMES;
    MN.values=1:numel(FILENAMES);
    s=1:numel(FILENAMES);
end
%Get spectrogram Params
BinSize=500;
Overlap=.75;
cco=-50;
PKco=4;
F=[100:2:300];
% % for robusta-cap @ 200Hz
% F=[50:2:200];
A=inputdlg({'Bin Size (ms)','Overlap (0=none,.999=max)'},'Spectrogram Parameters',1,{num2str(BinSize),num2str(Overlap)});
bs=str2num(A{1});
if ~isempty(bs)
    if bs>0
        BinSize=bs;
    end
end
olp=str2num(A{2});
if ~isempty(olp)
    if olp>=0
        if olp<0.9999;
            Overlap=olp;
        end
    end
end
BinOl=[BinSize Overlap];
A=inputdlg({'Power cutoff (dB)','Skew cutoff'},'WBF ID Parameters',1,{num2str(cco),num2str(PKco)});
bs=str2num(A{1});
if ~isempty(bs)
    if bs>0
        cco=bs;
    end
end
olp=str2num(A{2});
if ~isempty(olp)
    if olp>0
        PKco=olp;
    end
end
SNRK=[cco PKco];
hh=figure;
gg=figure;
wh=waitbar(0,'Initializing');
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
for i=1:numel(MICFILE)
    try
        flynum(i)=APgetflynum(MICFILE{i},FLYNUMXL);
    catch
        flynum(i)=0;
    end
end
[C ia flyc]=unique(flynum);
cmap=colormap(jet(numel(C)));
if numel(flynum)==1
    cmap=[0 0 0];
end
%profile on
for i=1:numel(MICFILE)
    waitbar(i/numel(MICFILE),wh,{['Analyzing ' num2str(i),' of ',num2str(numel(MICFILE)),' Files'];MICFILE{i}});
    
    try
        
        dat(i)=APmicfileanalysis(MICFILE{i},BinOl,F,SNRK,0,0);
        figure(hh)
        hold all
        plot(dat(i).TT,dat(i).WBF,'Color',cmap(flyc(i),:))
        colorbar
        axis([0 100 100 250]);
        xlabel('Time (s)')
        ylabel('WBF (Hz)')
        title(handles.GROUPPOOL(get(handles.group_list,'Value')).name);
    catch ME
        ['Mic error with ',num2str(i)]
        ME
        dat(i).TT=nan;
        dat(i).FF=nan;
        dat(i).nPP=nan;
        dat(i).SNR=nan;
        dat(i).Pkurt=nan;
        dat(i).cc=nan;
        dat(i).spectrogram=nan;
        dat(i).WBF=nan;
        
    end
    try
        FILENAME=FILENAMES{MN.values(s(i))};
        [a b c]=xlsread(FILENAME);
        maxt=a(1,4);
        spktimes=a(4:end,1);
        spt(i).spktimes=spktimes;
        mxt(i).maxt=maxt;
        ST=a(3:end,1);
        sst=a(3:end,3);
        stimtimes=sst(~isnan(sst));
        offset=0;
        oST=spktimes-offset;
        
        bst=APBinCounts_modmaxt(spktimes,(BinSize/1000),Overlap,maxt);
        if ~isnan(dat(i).TT)
            binspktm=bst(2,1:numel(dat(i).TT));
        else
            binspktm=bst(2,:);
        end
        sbst(i).binspktm=binspktm;
        sbst(i).offset=offset;
        ff=figure;
        subplot(5,1,1:2)
        plot(oST(1:end-1),1./diff(spktimes),'k.');
        hold all
        plot(dat(i).TT-offset,binspktm./(BinSize/1000),'r-');
        plot(dat(i).TT(~isnan(dat(i).WBF))-offset,binspktm(~isnan(dat(i).WBF))./(BinSize/1000),'g-')
        xlabel('Time (s)')
        ylabel('Inst. Freq. (Hz)');
        title([FILENAME,' DLM-WBF trace']);
        subplot(5,1,3:5)
        imagesc(dat(i).TT-offset,F,10*log10(dat(i).nPP));
        axis('xy');
        xlabel('Time (s)')
        ylabel('Frequency (Hz)')
        c=colorbar('location','EastOutside');
        ylabel(c,'Power (dB)');
        caxis([-55 -35]);
        cax=axis;
        cax(3)=0;
        cax(4)=50;
        subplot(5,1,1:2)
        axis(cax);
        colorbar
        figure(gg)
        hold all
        plot(binspktm./(BinSize/1000),dat(i).WBF,'.','MarkerEdgeColor',cmap(flyc(i),:))
        axis([0 50 100 300])
        colorbar
    catch ME
         ['SPK Time error with ',num2str(i)]
        ME
    end
    
end
%profile viewer
delete(wh)
ctrs{1}=F;
ctrs{2}=[0:1:50];
nh=zeros(numel(ctrs{1}),numel(ctrs{2}));
for i=1:numel(dat)
    try
        h=hist3([dat(i).WBF;sbst(i).binspktm]',ctrs);
        nh=nh+h;
    catch
    end
    
end
nnh=nh/(nansum(nansum(nh)));

figure
imagesc(ctrs{2},ctrs{1},log10(nnh));
axis('xy')
xlabel('Binned DLM Freq (Hz)')
ylabel('Wing Beat Frequency (Hz)')
title(handles.GROUPPOOL(get(handles.group_list,'Value')).name);
cmap2=colormap('gray');
cmap2=1-cmap2;
colormap(cmap2)
caxis([-3 -1]);

MICFILE;

try
    sstats=APplotWBFcumudist(flynum,dat,spt);
catch
    sstats=nan
end
export2wsdlg({'WBF data';'Binned Spike Time Data';'fly #'; 'Steady State flight Stats';'spike times';'maxt'},{'dat';'sbst';'flynum';'sstats';'spktms';'maxt'},{dat;sbst;flynum;sstats;spt;mxt},'Export Data to Workspace')


MICFILE;















% --------------------------------------------------------------------
function WBF_trace_btn_Callback(hObject, eventdata, handles)
% hObject    handle to WBF_trace_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Follow_Freq_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Follow_Freq_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% for 20-40-60-80-100-120-140-180-200-200-160-120-80-40 format stimuation
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
burstsize=10;
for i=1:size(FILENAMES,1)
    try
        [a b c]= APloadSTdat(FILENAMES{i});
        stimtimes=a(~isnan(a(:,3)),3);
        stimtimes=stimtimes(stimtimes>2);
        stimfreqs=1./diff(stimtimes);
        stimfreqs(find(stimfreqs<1))=stimfreqs(find(stimfreqs<1)-1);
        stimfreqs(end+1)=stimfreqs(end);
        rstimfreqs=round(stimfreqs/10)*10;
        burstnum(1)=1;
        stimnum(1)=1;
        mxfqpt=find(rstimfreqs==200);
        respv=a(4:end,5);
        for j=1:9
            bbf(j)=20*j;
            rrp(j)=sum(respv(find(rstimfreqs(1:mxfqpt(1)-1)==bbf(j))));
            if rrp(j)==0
                rrp(j)=nan;
            end
            stmct(j)=numel(find(rstimfreqs(1:mxfqpt(1)-1)==bbf(j)));
        end
        rrp(10)=sum(respv(mxfqpt(1:10)));
        stmct(10)=10;
        rrp(11)=sum(respv(mxfqpt(11:end)));
        stmct(11)=numel(mxfqpt(11:end));
        
        for j=12:15
            bbf(j)=200-40*(j-11);
            rrp(j)=sum(respv(find(rstimfreqs(mxfqpt(end):end)==bbf(j))+mxfqpt(end)-1));
             if rrp(j)==0
                rrp(j)=nan;
            end
            stmct(j)=numel(find(rstimfreqs(mxfqpt(end):end)==bbf(j))+mxfqpt(end)-1);
        end
        rp(i,:)=rrp./stmct;
        sc(i,:)=stmct;
    catch
        rp(i,:)=nan(1,15);
        sc(i,:)=nan(1,15);
    end
    
    
    
    
end
bf=[20 40 60 80 100 120 140 160 180 200 200 160 120 80 40];
dbf=diff(bf,1,2);
drp=diff(rp,1,2);
dbf(:,end+1)=zeros(size(dbf,1),1);
drp(:,end+1)=zeros(size(drp,1),1);
figure
try
    for i=1:size(rp,1)
        quiver(bf,rp(i,:)*100,dbf,drp(i,:)*100,.33,'k')
        hold all
        plot(bf,rp(i,:)*100,'k*')
    end
    axis([0 210 0 110])
catch
end
try
    hold all
    errorbar(bf,nanmean(rp)*100,nanstd(rp)*100/sqrt(size(rp,1)),'r');
catch
end
try
    line([0 210],[50 50],'LineStyle','--');
    xlabel('Stimulation Frequency (Hz)');
    ylabel('% Responses');
    title(['Following Frequency for ',handles.GROUPPOOL(get(handles.group_list,'Value')).name]);
end

lx=@(b,x)(1./(1+exp(-1*b(1)*(x-b(2)))))
bini=[0.02 200];

bdl=NonLinearModel.fit(bf(1:10),1-nanmean(rp(:,1:10)),lx,bini)
export2wsdlg({'FollowRate'},{handles.GROUPPOOL(get(handles.group_list,'Value')).name{1}},{rp})




% --------------------------------------------------------------------
function TwinPulse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to TwinPulse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Mic_Noise_Periodogram_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Mic_Noise_Periodogram_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
MN=APgetmicfilenames(FILENAMES,handles.MICDATPATH,0);
MICNAMES=MN.names;
F=100:300;
A=questdlg('Do you want to create a new PSD or load one?','Noise PSD','Create','Load','Cancel','Cancel');

if strcmp(A,'Create')
    powsd=zeros(0,numel(F));
    micfilenames=cell(1,0);
end
if strcmp(A,'Load')
    [POWFILE POWPATH]=uigetfile([handles.LISTPATH,'\','*.mat']);
    load([POWPATH,POWFILE]);
end
micfilenames=cat(2,micfilenames,MICNAMES);

if ~isempty(MICNAMES)
    h=waitbar(0,'Begining Analysis');
    for i=1:size(MICNAMES,2)
        i
        try
            waitbar(i/size(MICNAMES,2),h,'Creating Periodogram');
            [Y fs n]=wavread(MICNAMES{i});
            [Pxx freq]=periodogram(Y(:,1),[],F,fs);
            SP=sum(Pxx);
            nPow(i,:)=Pxx./SP;
        catch
            if exist('nPow')
                nPow(i,:)=nan(1,size(nPow,2));
                ['error with ',num2str(i)]
            end
        end
    end
end
delete(h)
powsd=cat(1,powsd,nPow);

[TGTFILE TGTPATH]=uiputfile([handles.LISTPATH,'\','*.mat']);
save([TGTPATH,TGTFILE],'powsd','micfilenames');


% --------------------------------------------------------------------
function ID_user_props_Callback(hObject, eventdata, handles)
% hObject    handle to ID_user_props (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure
hold all
ngrps=size(handles.GROUPPOOL,2);
ttn=0;
groupn=0;
for j=1:ngrps
    ntraces=size(handles.GROUPPOOL(j).files,1);
    groupn=groupn+1;
    for i=1:ntraces
        ttn=ttn+1;
        groupnum(ttn)=groupn;
        
        %         try
        
        [a b c]=xlsread(handles.GROUPPOOL(j).files{i});
        ST=a(3:end,1);
        sst=a(3:end,3);
        stimtimes=sst(~isnan(sst));
        offset=stimtimes(1);
        oST=ST-offset;
        doST(1)=0;
        doST(2:numel(oST))=diff(oST);
        scatter(oST,ttn*ones(1,size(oST,1)),10,1./doST,'filled');
        caxis([0 20]);
        
        numspksp=find(oST>2);
        numspksn=find(oST>10);
        totalIDspikes(ttn)=numel(setdiff(numspksp,numspksn));
        
        clear doST
        clear ST
        clear sst
        clear stimtimes
        clear offset
        clear oST
        
        %         catch
        %             ['error with',num2str(i)]
        %         end
    end
    title(handles.GROUPPOOL(j).name);
    colorbar
    axis([2 10 0 ntraces+1]);
    
    
end



% --------------------------------------------------------------------
function ID_bin_spk_ana_Callback(hObject, eventdata, handles)
% hObject    handle to ID_bin_spk_ana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ngrps=size(handles.GROUPPOOL,2);
ttn=0
ctn=0;
groupn=0;
ngrps=size(handles.GROUPPOOL,2);
BinSzst=inputdlg('Enter Bin Size (ms)','Bin Size',1,{'1000'});
BinSz=str2num(BinSzst{1});
BinOlst=inputdlg('Enter Bin Overlap (0=None to 1=Complete)','Bin Overlap',1,{'0'});
BinOl=str2num(BinOlst{1});
ebinsize=(BinSz/1000)*(1-BinOl);
nbins=floor(max(10)/ebinsize);
BSCM=nan(0,nbins);

for i=1:ngrps
    
    groupn=groupn+1;
    nfiles=numel(handles.GROUPPOOL(i).files);
    for j=1:nfiles
        try
            ctn=ctn+1;
            [a b c]=xlsread(handles.GROUPPOOL(i).files{j});
            ST=a(3:end,1);
            if isnan(ST(1))
                ST=ST(2:end);
            end
            sst=a(3:end,3);
            if isnan(sst(1))
                sst=sst(2:end);
            end
            maxt=90;
            stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oend=stimtimes(end)-stimtimes(1);
            oST=ST-offset;
            BinnedST=APBinCounts_modmaxt(oST,BinSz/1000,BinOl,maxt);
            BSCM(ctn,:)=BinnedST(2,1:size(BSCM,2));
            trg(ctn)=groupn;
        catch
            BSCM(ctn,1:nbins)=nan(1,nbins);
            ['error with group ', num2str(i),' trace ', num2str(j)]
            trg(ctn)=nan;
        end
        
    end
    GRN(i)=handles.GROUPPOOL(i).name;
    GRE(i)=ctn;
end
figure
imagesc(BSCM)
caxis([0 20]);
load('BSCMcolormap.mat')
colormap(BSCMcolormap);

pGRE=0;
for k=1:numel(GRE)
    GREE(k*2-1)=(GRE(k)-pGRE)/2+pGRE;
    GREE(k*2)=GRE(k);
    pGRE=GRE(k);
end

set(gca,'YTick',GREE)

TL=get(gca,'YTickLabel');
for k=1:size(TL,1)
    TLN{k}=TL(k,1:end);
end
for k=1:numel(GRE)
    TLN(k*2-1)=GRN(k);
end

set(gca,'YTickLabel',TLN);
xlabel('Elapsed Time (s)');


GRE;
sBSCM=BSCM>10*ebinsize;
cBSCM=sBSCM(:,round(2/ebinsize)+1:end);
figure
imagesc(cBSCM)
set(gca,'YTick',GREE)
set(gca,'YTickLabel',TLN);
xlabel('Elapsed Time (s)');


% --------------------------------------------------------------------
function STFFT_Binn_Spk_Ct_Callback(hObject, eventdata, handles)
% hObject    handle to STFFT_Binn_Spk_Ct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BinSize=1000;
Overlap=0.5;
F=[100:2:300];
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
MN=APgetmicfilenames(FILENAMES,handles.MICDATPATH,0);
MICNAMES=MN.names;
[s,v]=listdlg('PromptString','Select a file to analyze:','SelectionMode','multiple','ListString',MICNAMES);
for i=1:numel(s)
    MICFILE{i}=MICNAMES{s(i)};
end
%Get spectrogram Params
BinSize=500;
Overlap=.75;
cco=-50;
PKco=4;
F=[100:2:300];
A=inputdlg({'Bin Size (ms)','Overlap (0=none,.999=max)'},'Spectrogram Parameters',1,{num2str(BinSize),num2str(Overlap)});
bs=str2num(A{1});
if ~isempty(bs)
    if bs>0
        BinSize=bs;
    end
end
olp=str2num(A{2});
if ~isempty(olp)
    if olp>=0
        if olp<0.9999;
            Overlap=olp;
        end
    end
end
BinOl=[BinSize Overlap];
A=inputdlg({'Power cutoff (dB)','Skew cutoff'},'WBF ID Parameters',1,{num2str(cco),num2str(PKco)});
bs=str2num(A{1});
if ~isempty(bs)
    if bs>0
        cco=bs;
    end
end
olp=str2num(A{2});
if ~isempty(olp)
    if olp>0
        PKco=olp;
    end
end
SNRK=[cco PKco];
hh=figure;
wh=waitbar(0,'Initializing');
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
for i=1:numel(MICFILE)
    try
        flynum(i)=APgetflynum(MICFILE{i},FLYNUMXL);
    catch
        flynum(i)=0;
    end
end
[C ia flyc]=unique(flynum);
for i=1:numel(MICFILE)
    waitbar(i/numel(MICFILE),wh,{['Analyzing ' num2str(i),' of ',num2str(numel(MICFILE)),' Files'];MICFILE{i}});
    try
        dat(i)=APmicfileanalysis(MICFILE{i},BinOl,F,SNRK,0,0);
        FILENAME=FILENAMES{MN.values(s(i))};
        [a b c]=APloadSTdat(FILENAME);
       
        maxt=a(1,4);
        mxt(i)=maxt;
        spktimes=a(4:end,1);
        
        
        ST=a(3:end,1);
        sst=a(3:end,3);
        stimtimes=sst(~isnan(sst));
        offset=stimtimes(1);
        oST=spktimes-offset;
        offV(i)=offset;
        spt(i).spktimes=spktimes;
        spt(i).stimtimes=stimtimes;
        bst=APBinCounts_modmaxt(spktimes,(BinSize/1000),Overlap,maxt);
        
        binspktm=bst(2,1:numel(dat(i).TT));
        sbst(i).binspktm=binspktm;
        sbst(i).offset=offset;
        sbst(i).fn=FILENAME;
        ff=figure;
        subplot(5,1,1:2)
        plot(oST(1:end-1),1./diff(spktimes),'ko','MarkerFaceColor','k','MarkerSize',4);
        hold all
        %plot(dat(i).TT-offset,binspktm./(BinSize/1000),'r-');
       %plot(dat(i).TT(~isnan(dat(i).WBF))-offset,binspktm(~isnan(dat(i).WBF))./(BinSize/1000),'g-')
        xlabel('Time (s)')
        ylabel('Inst. Freq. (Hz)');
        title([FILENAME,' DLM-WBF trace']);
        axis([0 90 0 50])
        axis([0 60 0 50])
        subplot(5,1,3:5)
        imagesc(dat(i).TT-offset,F,10*log10(dat(i).nPP));
        axis('xy');
        axis([0 90 100 300]);
        axis([0 60 120 240]);
        xlabel('Time (s)')
        ylabel('Frequency (Hz)')
        c=colorbar('location','EastOutside');
        ylabel(c,'Power (dB)');
        caxis([-55 -35]);
        cax=axis;
        %cax(1)=0;
        %cax(2)=90;
        cax(3)=0;
        cax(4)=50;
        subplot(5,1,1:2)
        axis(cax);
        colorbar
        colormap(flipud(gray));
        %         gg=figure;
        %         patch(log10(binspktm./(BinSize/1000)),dat(i).WBF,dat(i).TT-offset,'facecolor','none','edgecolor','interp','LineWidth',1);
        %         xlabel ('log_{10}(bin spike count) (Hz)')
        %         ylabel('WBF (Hz)')
        %         title([FILENAME,' DLM-WBF trace']);
        hold all
        
        %axis([0 1.5 150 250]);
        figure(hh)
        hold all
        scatter(dat(i).TT-offset,i*ones(size(dat(i).WBF)),10,dat(i).WBF,'s','filled');
        
    catch
        ['error with ',num2str(i)]
        sbst(i).binspktm=nan;
        sbst(i).offset=nan;
    end
    
end
delete(wh)
MICFILE;

MICFILE;

try
    sstats=APplotWBFcumudist(flynum,dat,spt);
catch
    sstats=nan
end
export2wsdlg({'WBF data';'Binned Spike Time Data';'fly #'; 'Steady State flight Stats';'spike times';'maxt';'offV'},{'dat';'sbst';'flynum';'sstats';'spktms';'maxt';'offV'},{dat;sbst;flynum;sstats;spt;mxt;offV},'Export Data to Workspace')


% --------------------------------------------------------------------
function Summary_Sht_1_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Summary_Sht_1_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%genotype summary sheet comparing Sp firing and Flight data

h=figure;
set(h,'Units','inches')
set(h,'PaperPositionMode','auto')
set(h,'Position',[0 0 8.5 11]);
set(h,'PaperUnits','Inches');
set(h,'PaperSize',[8.5 11]);
INFO{1}=['Date Created ',date];
INFO{2}=['Group Names:'];
STATS{1}=['STATS (N, mean, SD, SEM, 5%, 25%, 50%, 75%, 95%)']
ngrps=size(handles.GROUPPOOL,2);
for i=1:ngrps
    INFO{i+2}=[handles.GROUPPOOL(i).name{1},' ',num2str(size(handles.GROUPPOOL(i).files,1))];
end


mtxtbx=uicontrol('style','text');
set(mtxtbx,'Units','inches')
set(mtxtbx,'Position',[6.7 9 1.5 1]);
set(mtxtbx,'String',INFO);
set(mtxtbx,'HorizontalAlignment','left');

stxtbx=uicontrol('style','text');
set(stxtbx,'Units','inches')
set(stxtbx,'Position',[6.7 7.0 1.5 2]);
set(stxtbx,'String',STATS);
set(stxtbx,'HorizontalAlignment','left');

subplot(6,6,[1:5]);


ttn=0;
j=1;
ntraces=size(handles.GROUPPOOL(j).files,1);
dotsize=3;
if ntraces<50
    dotsize=4;
end
if ntraces<25
    dotsize=6;
end
if ntraces<10
    dotsize=8;
end
if ntraces<5
    dotsize=10;
end
for i=1:ntraces
    ttn=ttn+1;
    try
        [a b c]=xlsread(handles.GROUPPOOL(j).files{i});
        age(ttn)=c{2,5};
        ST=a(3:end,1);
        offset=0;
        oST=ST-offset;
        doST(1)=0;
        doST(2:numel(oST))=diff(oST);
        scatter(oST,i*ones(1,size(oST,1)),2,1./doST,'filled');
        caxis([0 20]);
        meanISI(ttn)=nanmean(doST);
        
        hold all
        clear doST
        clear ST
        clear sst
        clear stimtimes
        clear offset
        clear oST
    catch
        ['error with',num2str(i)]
        age(ttn)=nan;
    end
end
INFO{end+1}=['Age (min,mean,max)'];
INFO{end+1}=[num2str(nanmin(age)),',',num2str(nanmean(age)),',',num2str(nanmax(age))];
clear age;
STATS{end+1}=[handles.GROUPPOOL(j).name{1},': ', num2str(numel(meanISI)),', ',num2str(mean(meanISI),3),', ', num2str(std(meanISI),3),', ',num2str(std(meanISI)./sqrt(numel(meanISI)),3)];
STATS{end+1}=[num2str(quantile(meanISI,0.05),3),', ',num2str(quantile(meanISI,0.25),3),', ',num2str(quantile(meanISI,0.5),3),', ',num2str(quantile(meanISI,0.75),3),', ',num2str(quantile(meanISI,0.95))];

set(mtxtbx,'String',INFO);
set(stxtbx,'String',STATS);
lax=axis;
lax(1)=0;
lax(2)=60;
axis(lax);
xlabel('Time (s)')
ylabel('Trace #')
colorbar


if ngrps>1
    j=2;
    subplot(6,6, [7:11]);
    ntraces=size(handles.GROUPPOOL(j).files,1);
    dotsize=3;
    if ntraces<50
        dotsize=4;
    end
    if ntraces<25
        dotsize=6;
    end
    if ntraces<10
        dotsize=8;
    end
    if ntraces<5
        dotsize=10;
    end
    
    for i=1:ntraces
        ttn=ttn+1;
        try
            [a b c]=xlsread(handles.GROUPPOOL(j).files{i});
            age(ttn)=c{2,5};
            ST=a(3:end,1);
            offset=0;
            oST=ST-offset;
            doST(1)=0;
            doST(2:numel(oST))=diff(oST);
            
            scatter(oST,i*ones(1,size(oST,1)),dotsize,1./doST,'filled');
            caxis([0 20]);
            meanISI(ttn)=nanmean(doST);
            
            
            hold all
            clear doST
            clear ST
            clear sst
            clear stimtimes
            clear offset
            clear oST
        catch
            ['error with',num2str(i)]
            age(ttn)=nan;
        end
    end
    INFO{end+1}=[num2str(nanmin(age)),', ',num2str(nanmean(age)),', ',num2str(nanmax(age))];
    clear age;
    STATS{end+1}=[handles.GROUPPOOL(j).name{1},': ', num2str(numel(meanISI)),', ',num2str(mean(meanISI),3),', ', num2str(std(meanISI),3),', ',num2str(std(meanISI)./sqrt(numel(meanISI)),3)];
    STATS{end+1}=[num2str(quantile(meanISI,0.05),3),', ',num2str(quantile(meanISI,0.25),3),', ',num2str(quantile(meanISI,0.5),3),', ',num2str(quantile(meanISI,0.75),3),', ',num2str(quantile(meanISI,0.95),3)];
    
    set(mtxtbx,'String',INFO);
    set(stxtbx,'String',STATS);
    lax=axis;
    lax(1)=0;
    lax(2)=60;
    axis(lax);
    xlabel('Time (s)')
    ylabel('Trace #')
    colorbar
end

subplot(6,6,[13:15])
FILENAMES=handles.GROUPPOOL(1).files;
MN=APgetmicfilenames(FILENAMES,handles.MICDATPATH,0);
MICNAMES=MN.names;
cFILENAME=handles.GROUPPOOL(1).files(MN.values);
F=100:300;
wbFrange=[150,250];
if ~isempty(MICNAMES)
    hh=waitbar(0,'Begining Analysis');
    for i=1:size(MICNAMES,2)
        try
            waitbar(i/size(MICNAMES,2),hh,'Creating Periodogram');
            [Y fs n]=wavread(MICNAMES{i});
            V(i).mic=Y(:,1);
            [a b c]=xlsread(cFILENAME{i});
            maxt=a(4,1);
            spktimes=a(4:end,1);
            ST=a(3:end,3);
            spktimes=spktimes-0;
            V(i).bst=APBinCounts_modmaxt(spktimes,(1000/1000),0,maxt);
            
            spr(i)=fs;
            
            [Pxx freq]=periodogram(Y(:,1),[],F,fs);
            
            SP=sum(Pxx);
            nPow(i,:)=Pxx./SP;
        catch ME
            ME
            nPow(i,:)=nan(1,size(nPow,2));
            ['error with ',num2str(i)]
        end
    end
    delete(hh)
    %     qsub=questdlg('Do you want to subtract noise?');
    %     if strcmp(qsub,'Yes')
    %        [POWFILE POWPATH]=uigetfile([handles.LISTPATH,'\','*.mat']);
    %        load([POWPATH,POWFILE]);
    %        noisepsd=nanmean(powsd)
    %        for i=1:size(nPow,1)
    %            nPow(i,:)=(nPow(i,:)-noisepsd);
    %            nPow(i,find(nPow(i,:)<0))=0;
    %        end
    %     end
    subplot(6,6,[13:15])
    hold all
    for i=1:size(nPow,1)
        plot(F,10*log10(nPow(i,:)),'b');
        [maxPow(i) maxPfreq(i)]=max(nPow(i,:));
        plot(F(maxPfreq(i)),10*log10(maxPow(i)),'r+');
    end
    xlabel('Frequency (Hz)');
    ylabel('Relative Power (dB)');
    axis([130 260 -60 0]);
    
    
    subplot(6,6,[16:18])
    hold all
    for i=1:size(V,2)
        try
            [SS FF TT PP]=spectrogram(V(i).mic,spr(i)*1000/1000,0,F,spr(i));
            [mPP cPP]=max(PP);
            basePow=10+mean(10*log10(sum(PP)/numel(F)));
            isflying=(10*log10(mPP)>basePow);
            WBF=F(cPP);
            WBF(~isflying)=nan;
            if numel(TT)>=60;
                WBFs(:,i)=WBF(1:60);
            end
            if numel(TT)<60
                WBF(end+1:60)=nan;
                WBFs(:,i)=WBF(1:60);
            end
            plot(TT(1:60),WBF(1:60),'g');
            clear SS
            clear TT
            clear FF
            clear PP
            clear mPP
            clear cPP
            clear WBF
            clear isflying
        catch ME
            ME
            ['spectrogram error with ', num2str(i)]
            WBFs(:,i)=nan(1,60);
        end
    end
    axis([0 60 120 240]);
    
    
    
    subplot(6,6, [19 27])
    hold all
    for i=1:size(V,2)
        try
            bff=V(i).bst(2,:);
            if numel(bff)<60
                bff(end+1:60)=nan;
            end
            if numel(bff)>=60
                bff=bff(1:60);
            end
            plot(bff,WBFs(:,i),'k.')
        catch
        end
    end
    axis([0 20 120 240]);
    xlabel('DLM Firing Frequency');
    ylabel('Wing Beat Frequency');
    
    
end



ngrps=size(handles.GROUPPOOL,2);
hh=waitbar(0 ,'Loading Data');
for i=1:ngrps
    ntraces=size(handles.GROUPPOOL(i).files,1);
    lnames(i)=handles.GROUPPOOL(i).name;
    for j=1:ntraces
        try
            fname=handles.GROUPPOOL(i).files{j};
            fltstat=APFLTISIstats(fname,0,0);
            gntypffcv(i).ff(j)=1/fltstat.ISImean;
            gntypffcv(i).cv(j)=fltstat.ISIcv;
        catch
        end
    end
    waitbar(i/ngrps,hh,'Loading Data');
end
delete(hh);
FFarray=zeros(0);
CVarray=zeros(0);
IDgrp=zeros(0);
for i=1:ngrps
    FFarray=cat(2,FFarray,gntypffcv(i).ff);
    CVarray=cat(2,CVarray,gntypffcv(i).cv);
    IDgrp=cat(2,IDgrp,ones(size(gntypffcv(i).ff))*i);
end
FFarray(isnan(FFarray))=0;
CVarray(isnan(CVarray))=1;
CVarray(find(CVarray==0))=1;
subplot(6,6, [23 30]);
for i=1:ngrps
    try
        semilogy(FFarray(find(IDgrp==i)),CVarray(find(IDgrp==i)),'.');
        hold all
    catch
    end
end
axis([0 20 0.01 10]);

% legend(lnames,'Location','SouthWestOutside');
xlabel('Inst. Firing Freq.(Hz)');
ylabel('CV');

% figure(mf);
subplot(6,6,[35 36])
boxplot(FFarray,IDgrp,'plotstyle','compact','extrememode','compress','symbol','rx')
axis([0.5 ngrps+0.5 0 20]);
ylabel('Inst Firing Freq');
view(90,90)

%kruskalwallis(FFarray,IDgrp);

%figure
% figure(mf);
subplot (6,6,[22 28]);
boxplot(log10(CVarray(~isnan(CVarray))),IDgrp(~isnan(CVarray)),'plotstyle','compact','extrememode','compress','symbol','rx');
axis([0.5 ngrps+0.5 -2 1]);
ylabel('Coeff. Var.')



% --------------------------------------------------------------------
function ECS_ISIdRdT_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ECS_ISIdRdT_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%__FOR USER SEL___
svsg=questdlg('Do you want to plot for a single file (vs time) or for the group?','Selection Type','Single','Group','Single');
prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
while isempty(str2num(prtcl{1}))
    prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
end

spkrange=inputdlg({'Min spike time';'Max spike time'},'Analysis Range',1,{'0';'100'});
spkstarttime=str2num(spkrange{1});
spkendtime=str2num(spkrange{2});



    
% %for quick complete defaults <comment out as necessary
% svsg='Group';
% prtcl{1}='2';
% prtcl{2}='6';
% prtcl{3}='2';
if strcmp(svsg,'Single')
    FILENAME=handles.GROUPFILE{get(handles.group_file_list,'Value')};
    groupname=handles.GROUPPOOL(get(handles.group_list,'Value')).name{1};
    
    svpdf=questdlg('Do you want to save figures as a pdf?');
    
    if strcmp(svpdf,'Yes')
        [TGTFILE,TGTPATH]=uiputfile(['*.pdf'],'Save Inst FF Set As',[groupname,' ECS_ISI_CV_plot.pdf']);
    end
    if numel(get(handles.group_file_list,'Value'))==1
        
        
        ISICV(1).data=APplotFanoPhase(FILENAME,1,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1,spkstarttime,spkendtime);
        ISICV(1).params=[1 2 6];
        %idx=APclusterISIFanoData(dat,1);
    end
    load('ECScmap.mat');
    cmap=ECScmap;
    if numel(get(handles.group_file_list,'Value'))>1
        vals=get(handles.group_file_list,'Value');
        for i=1:numel(vals)
            FILENAME=handles.GROUPFILE{vals(i)};
            ISICV(i).data=APplotFanoPhase(FILENAME,1,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1,spkstarttime,spkendtime);
             colormap(cmap)
            colorbar;
            caxis([0 90])
            ISICV(i).params=[1 2 6];
            h=gcf;
            if strcmp(svpdf,'Yes')
                if i==1
                    print('-dpsc2','-r600',h,'SPKTEST11.ps')
                end
                if i~=1
                    print('-dpsc2','-r600','-append',h,'SPKTEST11.ps')
                end
            end
        end
        if strcmp(svpdf,'Yes')
            ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
            delete('SPKTEST11.ps');
            msgbox('PDF Creation Complete');
        end
    end
    export2wsdlg({'ISICV data struct'},{'ISICV'},{ISICV})
end
if strcmp(svsg,'Group')
    AutoSave=questdlg('Do you want to autosave?');
    %AutoSave='Yes';
    gv=get(handles.group_list,'Value');
    groupname=handles.GROUPPOOL(get(handles.group_list,'Value')).name{1};
    hh=waitbar(0,['0',' of ','0',' Traces']);
    gg=figure;
    ff=figure;
    ee=figure;
    cmp=colormap(jet(numel(handles.GROUPFILE)));
    load('ECScmap.mat');
    cmap=ECScmap;
    overalldat=zeros(0,6);
    [a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
    FLYNUMXL=c;
    clear a
    clear b
    clear c
%     colormapeditor
%     cmap=colormap;
    
    for i=1:numel(handles.GROUPFILE)
        try
            waitbar(i/numel(handles.GROUPFILE),hh, [num2str(i),' of ',num2str(numel(handles.GROUPFILE)),' Traces']);
            FILENAME=handles.GROUPFILE{i};
            fanoplot(i).FILENAME=FILENAME;
            fanoplot(i).UFN=APgetflynum(FILENAME,FLYNUMXL);
            fanoplot(i).data=APplotFanoPhase(FILENAME,1,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),0,spkstarttime,spkendtime);
            fanoplot(i).data(end+1,:)=nan(1,6);
            overalldat=cat(1,overalldat,fanoplot(i).data);
            figure(ff)
            hold all
            %        plot(fanoplot(i).dat(:,1),fanoplot(i).dat(:,2),'k.');
            plot(fanoplot(i).data(:,1),10.^fanoplot(i).data(:,3),'.','Color',cmp(i,:));
            hold off
            ax=axis;
            ax(1)=0;
            ax(2)=100;
            axis(ax);
            figure(gg)
            subplot(4,1,1:3)
            hold all
            %        scatter(fanoplot(i).dat(:,3),fanoplot(i).dat(:,4),10,fanoplot(i).dat(:,1),'filled');
            %         plot(fanoplot(i).dat(:,3),fanoplot(i).dat(:,4),'-','Color',cmp(i,:));
            patch(fanoplot(i).data(:,3),fanoplot(i).data(:,4),fanoplot(i).data(:,1),'facecolor','none','edgecolor','interp','LineWidth',2);
            axis([0 2.5 -2.5 2.5])
            colormap(cmap)
            colorbar;
            caxis([0 90])
            hold off
            subplot(4,1,4)
            hold all
            plot(fanoplot(i).data(:,1),i*ones(1,numel(fanoplot(i).data(:,1))),'k+')
            axis([0 100 0 i+1])
            hold off
            %        figure(ee)
            %
            %        edges{1}=[0:0.05:2.5];
            %        edges{2}=[-2.5:0.05:2.5];
            %        h=hist3(fanoplot{i}(:,3:4),edges);
            %        contour(edges{1},edges{2},h')
            
        catch
            ['error with ',num2str(i)]
            fanoplot(i).data=nan;
        end
    end
    delete(hh);
    DTWok='Yes';
    while strcmp(DTWok,'Yes')
        APDTWBaryAverage(fanoplot,40);
        DTWok=questdlg('Re-run DTW?')
    end
    figure(gg)
    
    subplot(4,1,1:3)
    title(handles.GROUPPOOL(gv).name);
    xlabel('log(1/ISI) (Hz)');
    ylabel('log(CV) (Hz)');
    colormap(cmap)
    colorbar;
    caxis([0 90])
    subplot(4,1,4)
    xlabel('time(s)')
    figure(ff)
    title(handles.GROUPPOOL(gv).name);
    xlabel('Time (s)')
    ylabel('Filtered Firing Frequency (Hz)');
    colorbar
%     edges{1}=[0:0.05:2.5];
%     edges{2}=[-2.5:0.05:2.5];
%     figure;
%     h=hist3(overalldat(:,3:4),edges);
%     sc=nansum(nansum(h));
%     contour(edges{1},edges{2},log10(h./sc)')
%     caxis([-2.5 -1])
%     yd=APISICVoverallvecfield(overalldat,edges);
%     hold all
%     quiver(yd(:,1),yd(:,2),yd(:,3),yd(:,4))
%     
    if strcmp(AutoSave,'Yes')
        sws='Yes';
        save(['R:\BioDataLab\Atulya\Physiology Summary and Organization\ISI CV Datasets\',groupname,'.mat'],'fanoplot')
    else
        sws=questdlg('Do you want to export ISI CV data to .mat file?');
        
        if strcmp(sws,'Yes')
            [FN PN]=uiputfile('*.mat','Save ISI CV data',['R:\BioDataLab\Atulya\Physiology Summary and Organization\ISI CV Datasets\',groupname,'.mat']);
            save([PN,FN],'fanoplot')
        end
    end
    export2wsdlg({'ISICV data struct'},{'ISI_CV'},{fanoplot})
end

% --------------------------------------------------------------------
function ISI_dRdT_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ISI_dRdT_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
svsg=questdlg('Do you want to plot for a single file (vs time) or for the group?','Selection Type','Single','Group','Single');
prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
while isempty(str2num(prtcl{1}))
    prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
end
spkrange=inputdlg({'Min spike time';'Max spike time'},'Analysis Range',1,{'0';'600'});
mintval=str2num(spkrange{1});
maxtval=str2num(spkrange{2});
%mintval=inputdlg('enter min spike time','min time',1,{'0'});
if strcmp(svsg,'Single')
    svpdf=questdlg('Do you want to save figures as a pdf?');
    groupname=handles.GROUPPOOL(get(handles.group_list,'Value')).name{1};
    
    if strcmp(svpdf,'Yes')
        [TGTFILE,TGTPATH]=uiputfile(['*.pdf'],'Save Inst FF Set As',[groupname,' ECS_ISI_CV_plot.pdf']);
    end
    if numel(get(handles.group_file_list,'Value'))==1
        
        FILENAME=handles.GROUPFILE{get(handles.group_file_list,'Value')};
        ISICV(1).data=APplotFanoPhase(FILENAME,0,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1,mintval,maxtval);
        ISICV(1).FILENAME=FILENAME;
        export2wsdlg({'ISICV data struct'},{'ISI_CV'},{ISICV})
%         X=data(:,3:4);
%         idx=APclusterISIFanoData(data,1);
%         edges{1}=[0:0.1:2.5];
%         edges{2}=[-2.5:0.1:2.5];
%         h=hist3(X,edges);
    end
    
    
    
    if numel(get(handles.group_file_list,'Value'))>1
        vals=get(handles.group_file_list,'Value');
        for i=1:numel(vals)
            try
                FILENAME=handles.GROUPFILE{vals(i)};
                ISICV(i).data=APplotFanoPhase(FILENAME,0,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1,mintval,maxtval);
                ISICV(i).FILENAME=FILENAME;
                
                h=gcf;
                if strcmp(svpdf,'Yes')
                    if i==1
                        print('-dpsc2','-r600',h,'SPKTEST11.ps')
                    end
                    if i~=1
                        print('-dpsc2','-r600','-append',h,'SPKTEST11.ps')
                    end
                end
            catch
                ['error with',num2str(i)]
                ISICV(i).data=nan(1,6);
                ISICV(i).FILENAME=FILENAME;
            end
        end
        if strcmp(svpdf,'Yes')
            ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
            delete('SPKTEST11.ps');
            msgbox('PDF Creation Complete');
        end
        %APplotISICVboundscatter(ISICV);
        export2wsdlg({'ISICV data struct'},{'ISI_CV'},{ISICV})
    end
    
end
if strcmp(svsg,'Group')
    gv=get(handles.group_list,'Value');
    
    hh=waitbar(0,['0',' of ','0',' Traces']);
    gg=figure;
    ff=figure;
    ee=figure;
    cmp=colormap(jet(numel(handles.GROUPFILE)));
    overalldat=zeros(0,6);
    
    for i=1:numel(handles.GROUPFILE)
        try
            waitbar(i/numel(handles.GROUPFILE),hh, [num2str(i),' of ',num2str(numel(handles.GROUPFILE)),' Traces']);
            FILENAME=handles.GROUPFILE{i};
    
            fanoplot(i).data=APplotFanoPhase(FILENAME,0,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),0,mintval,maxtval);
            [a b c]=APloadSTdat(FILENAME);
            try
                fanoplot(i).maxt=a(1,4);
            catch
                fanoplot(i).maxt=max(a(:,1));
            end
            overalldat=cat(1,overalldat,fanoplot(i).data);
            fanoplot(i).data(end+1,:)=nan(1,6);
            figure(ff)
            hold all
            %        plot(fanoplot(i).dat(:,1),fanoplot(i).dat(:,2),'k.');
            plot(fanoplot(i).data(:,1),10.^fanoplot(i).data(:,3),'.','Color',cmp(i,:));
            hold off
            ax=axis;
            ax(1)=0;
            ax(2)=120;
            axis(ax);
            figure(gg)
            hold all
            %        scatter(fanoplot(i).dat(:,3),fanoplot(i).dat(:,4),10,fanoplot(i).dat(:,1),'filled');
            %         plot(fanoplot(i).dat(:,3),fanoplot(i).dat(:,4),'-','Color',cmp(i,:));
            patch(fanoplot(i).data(:,3),fanoplot(i).data(:,4),fanoplot(i).data(:,1),'facecolor','none','edgecolor','interp','LineWidth',1);
            axis([0 2.5 -2.5 2.5])
            hold off
            %        figure(ee)
            %
            %        edges{1}=[0:0.05:2.5];
            %        edges{2}=[-2.5:0.05:2.5];
            %        h=hist3(fanoplot{i}(:,3:4),edges);
            %        contour(edges{1},edges{2},h')
            
        catch
            ['error with ',num2str(i)]
            fanoplot(i).data=nan;
        end
        fanoplot(i).FILENAME=handles.GROUPFILE{i};
    end
    delete(hh);
    figure(gg)
    title(handles.GROUPPOOL(gv).name);
    xlabel('log(1/ISI) (Hz)');
    ylabel('log(CV_2) (Hz)');
    colorbar;
    %caxis([0 120])
    figure(ff)
    title(handles.GROUPPOOL(gv).name);
    xlabel('Time (s)')
    ylabel('Filtered Firing Frequency (Hz)');
    colorbar
    edges{1}=[-0.5:0.05:2.5];
    edges{2}=[-2.5:0.05:0.5];
    h=figure;
    %     h=hist3(overalldat(:,3:4),edges);
    %     sc=nansum(nansum(h));
    %     contour(edges{1},edges{2},log10(h./sc)')
    load('ECScmap.mat')
    cmap=ECScmap;
    redoDTW=0;
    
    while redoDTW==1
        DTW=APDTWBaryAverage(fanoplot,40,0);
        figure(h)
        hold off
        patch([DTW(:,2);nan],[DTW(:,3);nan],[DTW(:,1);nan],'facecolor','none','edgecolor','interp','LineWidth',2);
        axis([-0.5 2.5 -2.5 0.5]);
        colormap(cmap)
        caxis([0 90]);
        reANS=questdlg('RedoDTW?');
        if strcmp(reANS,'Yes')
            redoDTW=1;
            
        else
            redoDTW=0;
        end
        
    end
    
   
    yd=APISICVdensityplot(overalldat,edges);
    figure(h);
%     imagesc(yd.XBinEdges,yd.YBinEdges,yd.Values)
    
    sws=questdlg('Do you want to export ISI CV data to .mat file?');
    if strcmp(sws,'Yes')
        [FN PN]=uiputfile('*.mat','Save ISI CV data','R:\BioDataLab\Atulya\Physiology Summary and Organization\ISI CV Datasets\*.mat');
        save([PN,FN],'fanoplot')
    end
    export2wsdlg({'ISICV data struct'},{'ISI_CV'},{fanoplot})
end


% --------------------------------------------------------------------
function AP_flt_Raster_Callback(hObject, eventdata, handles)
% hObject    handle to AP_flt_Raster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILES=handles.GROUPFILE;
figure
hold all
V=randperm(numel(FILES));
V=[1:numel(FILES)]
for i=1:numel(FILES)
    
    try
        [a b c]=APloadSTdat(FILES{V(i)});
        ST=a(4:end,1);
        puffT=a(~isnan(a(:,8)),8);
        oST=ST-max(puffT);
        doST(1)=0;
        doST(2:numel(oST))=diff(oST);
        scatter(oST,i*ones(1,size(oST,1)),10,log10(1./doST),'filled');
        %plot(oST,ones(size(oST))*i,'k.');
        axis([0 10 0 i])
        dat(i).oST = oST;
        clear oST
        dat(i).doST = doST;
        clear doST
        dat(i).ST = ST;
        clear ST
    catch ME
        ['error with ',num2str(i)]
    end
    
    
end
export2wsdlg({'Dat'},{'APdat'},{dat});


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function AP_Flt_Spectrogram_Callback(hObject, eventdata, handles)
% hObject    handle to AP_Flt_Spectrogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BinSize=1000;
Overlap=0.5;
F=[100:2:300];
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
MN=APgetmicfilenames(FILENAMES,handles.MICDATPATH,0);
MICNAMES=MN.names;
[s,v]=listdlg('PromptString','Select a file to analyze:','SelectionMode','multiple','ListString',MICNAMES);
for i=1:numel(s)
    MICFILE{i}=MICNAMES{s(i)};
end
%Get spectrogram Params
BinSize=500;
Overlap=.5;
cco=-50;
PKco=4;
F=[100:2:250];
A=inputdlg({'Bin Size (ms)','Overlap (0=none,.999=max)'},'Spectrogram Parameters',1,{num2str(BinSize),num2str(Overlap)});
bs=str2num(A{1});
if ~isempty(bs)
    if bs>0
        BinSize=bs;
    end
end
olp=str2num(A{2});
if ~isempty(olp)
    if olp>=0
        if olp<0.9999;
            Overlap=olp;
        end
    end
end
BinOl=[BinSize Overlap];
A=inputdlg({'Power cutoff (dB)','Skew cutoff'},'WBF ID Parameters',1,{num2str(cco),num2str(PKco)});
bs=str2num(A{1});
if ~isempty(bs)
    if bs>0
        cco=bs;
    end
end
olp=str2num(A{2});
if ~isempty(olp)
    if olp>0
        PKco=olp;
    end
end
SNRK=[cco PKco];
hh=figure;
gg=figure;
wh=waitbar(0,'Initializing');
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
for i=1:numel(MICFILE)
    try
        flynum(i)=APgetflynum(MICFILE{i},FLYNUMXL);
    catch
        flynum(i)=0;
    end
end
[C ia flyc]=unique(flynum);
cmap=colormap(jet(numel(C)));
if numel(flynum)==1
    cmap=[0 0 0];
end
for i=1:numel(MICFILE)
    waitbar(i/numel(MICFILE),wh,{['Analyzing ' num2str(i),' of ',num2str(numel(MICFILE)),' Files'];MICFILE{i}});
    try
        dat(i)=APmicfileanalysis(MICFILE{i},BinOl,F,SNRK,0,0);
        
        FILENAME=FILENAMES{MN.values(s(i))};
        [a b c]=APloadSTdat(FILENAME);
        maxt=a(1,4);
        spktimes=a(4:end,1);
        
        
        ST=a(3:end,1);
        sst=a(3:end,3);
        stimtimes=sst(~isnan(sst));
        
        offset=0;
        try
            offset=a(find(~isnan(a(:,8)),1,'last'),8);
            APoffset(i)=offset;
        catch
            APoffset(i)=0;
            offset=0;
        end
        oST=spktimes-offset;
        
        bst=APBinCounts_modmaxt(spktimes,(BinSize/1000),Overlap,maxt);
        binspktm=bst(2,1:numel(dat(i).TT));
        sbst(i).binspktm=binspktm;
        sbst(i).offset=offset;
        
        figure(hh)
        hold all
        plot(dat(i).TT-offset,dat(i).WBF,'Color',cmap(flyc(i),:))
        %         dat(i).rTT=round(2*(dat(i).TT-offset))/2;
        colorbar
        axis([0 100 150 250]);
        xlabel('Time (s)')
        ylabel('WBF (Hz)')
        title(handles.GROUPPOOL(get(handles.group_list,'Value')).name);
        %Plot Raw WBF and DLM traces
                ff(i)=figure;
                subplot(5,1,1:2)
                plot(oST(1:end-1),1./diff(spktimes),'k.');
                hold all
                plot(dat(i).TT-offset,binspktm./(BinSize/1000),'r-');
                plot(dat(i).TT(~isnan(dat(i).WBF))-offset,binspktm(~isnan(dat(i).WBF))./(BinSize/1000),'g-')
                xlabel('Time (s)')
                ylabel('Inst. Freq. (Hz)');
                title([FILENAME,' DLM-WBF trace']);
                subplot(5,1,3:5)
                imagesc(dat(i).TT-offset,F,10*log10(dat(i).nPP));
                axis('xy');
                xlabel('Time (s)')
                ylabel('Frequency (Hz)')
                c=colorbar('location','EastOutside');
                ylabel(c,'Power (dB)');
                caxis([-55 -35]);
                cax=axis;
                cax(3)=0;
                cax(4)=50;
                subplot(5,1,1:2)
                axis(cax);
                colorbar
        %plot WBF vs time
        %         figure(gg)
        %         hold all
        %         plot(binspktm./(BinSize/1000),dat(i).WBF,'.','MarkerEdgeColor',cmap(flyc(i),:))
        %         axis([0 50 100 300])
        %         colorbar
        %Plot rel to steady-state WBF
%         load('Z:\Lab\Atulya\Physiology Summary and Organization\FltBoxUFN.mat');
%         fxr(i)=find(FltBoxUFN(:,1)==flynum(i));
%         ee(i)=figure;
%         subplot(2,1,1)
%         plot(oST(1:end-1),1./diff(spktimes),'k.');
%         hold all
%         plot(dat(i).TT-offset,binspktm./(BinSize/1000),'r-');
%         plot(dat(i).TT(~isnan(dat(i).WBF))-offset,binspktm(~isnan(dat(i).WBF))./(BinSize/1000),'g-')
%         xlabel('Time (s)')
%         ylabel('Inst. Freq. (Hz)');
%         title([FILENAME,' DLM-WBF vs Flt Box']);
%         xr=[min(dat(i).TT-offset),max(dat(i).TT-offset)];
%         line(xr,[FltBoxUFN(fxr(i),4),FltBoxUFN(fxr(i),4)],'Color','b','LineStyle','--');
%         line(xr,[FltBoxUFN(fxr(i),4)+1.96*FltBoxUFN(fxr(i),5),FltBoxUFN(fxr(i),4)+1.96*FltBoxUFN(fxr(i),5)],'Color','c','LineStyle','--');
%         line(xr,[FltBoxUFN(fxr(i),4)-1.96*FltBoxUFN(fxr(i),5),FltBoxUFN(fxr(i),4)-1.96*FltBoxUFN(fxr(i),5)],'Color','c','LineStyle','--');
%         subplot(2,1,2)
%         plot(dat(i).TT-offset,dat(i).WBF,'k');
%         hold all
%         line(xr,[FltBoxUFN(fxr(i),2),FltBoxUFN(fxr(i),2)],'Color','b','LineStyle','--');
%         line(xr,[FltBoxUFN(fxr(i),2)+1.96*FltBoxUFN(fxr(i),3),FltBoxUFN(fxr(i),2)+1.96*FltBoxUFN(fxr(i),3)],'Color','c','LineStyle','--');
%         line(xr,[FltBoxUFN(fxr(i),2)-1.96*FltBoxUFN(fxr(i),3),FltBoxUFN(fxr(i),2)-1.96*FltBoxUFN(fxr(i),3)],'Color','c','LineStyle','--');
%         xlabel('Time (s)')
%         ylabel('Frequency (Hz)')
    catch ME
        ['error with ',num2str(i)]
        ME
    end
    
end
delete(wh)
ctrs{1}=F;
ctrs{2}=[0:1:50];
nh=zeros(numel(ctrs{1}),numel(ctrs{2}));
inh=nh;
for i=1:numel(dat)
    if APoffset(i)>0
        try
            h=hist3([dat(i).WBF;sbst(i).binspktm]',ctrs);
            nh=nh+h;
            iniT=(dat(i).TT-APoffset(i)>0).*(dat(i).TT-APoffset(i)<10);
            ih=hist3([dat(i).WBF(find(iniT));sbst(i).binspktm(find(iniT))]',ctrs);
            inh=inh+ih;
        catch
        end
    end
    
end
nnh=nh/(nansum(nansum(nh)));

figure
imagesc(ctrs{2},ctrs{1},log10(nnh));
axis('xy')
xlabel('Binned DLM Freq (Hz)')
ylabel('Wing Beat Frequency (Hz)')
title(handles.GROUPPOOL(get(handles.group_list,'Value')).name);
cmap2=colormap('gray');
cmap2=1-cmap2;
colormap(cmap2)
caxis([-3 -1]);
hold all
for i=1:numel(dat)
    if APoffset(i)>0
        try
            iniT=(dat(i).TT-APoffset(i)>0).*(dat(i).TT-APoffset(i)<10);
            plot(sbst(i).binspktm(find(iniT)),dat(i).WBF(find(iniT)));
        end
    end
end
% figure
% hold all
% for i=1:numel(dat)
%     if APoffset(i)>0
%         try
%             figure
%             iniT=(dat(i).TT-APoffset(i)>0).*(dat(i).TT-APoffset(i)<20);
%
%             %running mean - 6 bins = 1.5 s
%             plot(sbst(i).binspktm(find(iniT))-FltBoxUFN(fxr(i),4),dat(i).WBF(find(iniT))-FltBoxUFN(fxr(i),2));
%         end
%     end
% end
%APdlmwbftraj(flynum,dat,sbst,APoffset);
%export2wsdlg({'WBF data';'Binned Spike Time Data';'AP offset values';'fly #'},{'dat';'sbst';'APoffset';'flynum'},{dat;sbst;APoffset;flynum},'Export Data to Workspace')
%MICFILE;


% --------------------------------------------------------------------
function AP_ISICV_Callback(hObject, eventdata, handles)
% hObject    handle to AP_ISICV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
while isempty(str2num(prtcl{1}))
    prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
end

spkrange=inputdlg({'Min spike time';'Max spike time'},'Analysis Range',1,{'0';'20'});
spkstarttime=str2num(spkrange{1});
spkendtime=str2num(spkrange{2});

svpdf=questdlg('Do you want to save figures as a pdf?');
groupname=handles.GROUPPOOL(get(handles.group_list,'Value')).name{1};

if strcmp(svpdf,'Yes')
    [TGTFILE,TGTPATH]=uiputfile(['*.pdf'],'Save Inst FF Set As',[groupname,' ECS_ISI_CV_plot.pdf']);
end
if numel(get(handles.group_file_list,'Value'))==1
    
    FILENAME=handles.GROUPFILE{get(handles.group_file_list,'Value')};
    dat=APplotFanoPhase(FILENAME,2,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1,spkstarttime, spkendtime);
    X=dat(:,3:4);
    %     idx=APclusterISIFanoData(dat,1);
    %     edges{1}=[0:0.1:2.5];
    %     edges{2}=[-2.5:0.1:2.5];
    %     h=hist3(X,edges);
end



if numel(get(handles.group_file_list,'Value'))>1
    vals=get(handles.group_file_list,'Value');
    h2 = waitbar(0,'initializing');
    for i=1:numel(vals)
        waitbar(i/numel(vals),h2,'running')
        FILENAME=handles.GROUPFILE{vals(i)};
        AP_ISICV(i).data=APplotFanoPhase(FILENAME,2,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1,spkstarttime, spkendtime);
        AP_ISICV(i).FILENAME=FILENAME;
        
        h=gcf;
        if strcmp(svpdf,'Yes')
            if i==1
                print('-dpsc2','-r600',h,'SPKTEST11.ps')
            end
            if i~=1
                print('-dpsc2','-r600','-append',h,'SPKTEST11.ps')
            end
        end
    end
    if strcmp(svpdf,'Yes')
        ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
        delete('SPKTEST11.ps');
        msgbox('PDF Creation Complete');
    end
    %APplotISICVboundscatter(ISICV);
    export2wsdlg({'ISICV data struct'},{'AP_ISICV'},{AP_ISICV})
    %     sws=questdlg('Do you want to export ISI CV data to .mat file?');
    %     if strcmp(sws,'Yes')
    %         [FN PN]=uiputfile('*.mat','Save ISI CV data','Z:\Lab\Atulya\Physiology Summary and Organization\ISI CV Datasets\*.mat')
    %         save([PN,FN],'ISICV')
    %     end
    
    
    
end


% --------------------------------------------------------------------
function const_flight_box_menu_Callback(hObject, eventdata, handles)
% hObject    handle to const_flight_box_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
while isempty(str2num(prtcl{1}))
    prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
end
svpdf=questdlg('Do you want to save figures as a pdf?');
groupname=handles.GROUPPOOL(get(handles.group_list,'Value')).name{1};


if strcmp(svpdf,'Yes')
    [TGTFILE,TGTPATH]=uiputfile(['*.pdf'],'Save Inst FF Set As',[groupname,' ECS_ISI_CV_plot.pdf']);
end

%Get spectrogram Params
BinSize=1000;
Overlap=.5;
cco=-50;
PKco=4;
F=[100:2:250];
BinOl=[BinSize Overlap];
SNRK=[cco PKco];
flyingX=zeros(0,2);
allX=zeros(0,2);
vals=get(handles.group_file_list,'Value');
h=figure;
for i=1:numel(vals)
    try
        clear flst
        clear X
        clear spwbf
        clear td
        
        FILENAME=handles.GROUPFILE{vals(i)};
        %     FILENAME=handles.GROUPFILE{get(handles.group_file_list,'Value')};
        dat=APplotFanoPhase(FILENAME,2,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1);
        X=dat(:,3:4);
        
        MN=APgetmicfilenames({FILENAME},handles.MICDATPATH,0);
        MICFILE=MN.names{1};
        micdat=APmicfileanalysis(MICFILE,BinOl,F,SNRK,0,0);
        for j=1:size(dat,1)
            for k=1:numel(micdat.TT)
                td(j,k)=dat(j,1)-micdat.TT(k);
            end
        end
        [v idx]=min(abs(td)');
        for j=1:numel(idx)
            spwbf(j)=micdat.WBF(idx(j));
        end
        flst=intersect(find(spwbf>125),find(spwbf<250));
        
        figure(h);
        hold all
        plot(X(:,1),X(:,2),'.','MarkerEdgeColor',[.5 .5 .5])
        if numel(flst>1)
            plot(X(flst,1),X(flst,2),'k.')
        end
        axis([0 2.5 -2.5 2.5])
        flyingX=[flyingX;X(flst,:)];
        allX=[allX;X];
    catch
        ['error with', num2str(i)]
    end
end
export2wsdlg({'flyingX', 'allX'},{'flyingX', 'allX'},{flyingX, allX},'export var');

flyingX;
allX;


% if numel(get(handles.group_file_list,'Value'))>1
%     vals=get(handles.group_file_list,'Value');
%     for i=1:numel(vals)
%         FILENAME=handles.GROUPFILE{vals(i)};
%         ISICV(i).dat=APplotFanoPhase(FILENAME,2,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1);
%
%         h=gcf;
%         if strcmp(svpdf,'Yes')
%             if i==1
%                 print('-dpsc2','-r600',h,'SPKTEST11.ps')
%             end
%             if i~=1
%                 print('-dpsc2','-r600','-append',h,'SPKTEST11.ps')
%             end
%         end
%     end
%     if strcmp(svpdf,'Yes')
%         ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
%         delete('SPKTEST11.ps');
%         msgbox('PDF Creation Complete');
%     end
%     APplotISICVboundscatter(ISICV);
%     export2wsdlg({'ISICV data struct'},{'ISI_CV'},{ISICV})
% end


% --------------------------------------------------------------------
function AP_WBFDLMFF_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to AP_WBFDLMFF_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILENAME=uigetfile('*.mat');
load(FILENAME)

for i=1:numel(APoffset)
    try
        if touse(i)==1
            rTT=round((dat(i).TT-APoffset(i))*8)/8;
            bst(i,:)=sbst(i).binspktm(0<=rTT&rTT<20);
            WBF(i,:)=dat(i).WBF(0<=rTT&rTT<20);
        else
            bst(i,:)=nan(1,160);
            WBF(i,:)=nan(1,160);
        end
    catch
        bst(i,:)=nan(1,160);
        WBF(i,:)=nan(1,160);
    end
end
srTT=0<=rTT&rTT<20;
bst



% --- Executes on button press in fly_num_btn.
function fly_num_btn_Callback(hObject, eventdata, handles)
% hObject    handle to fly_num_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;

for i=1:numel(FILENAMES)
    FLX{i,1}=FILENAMES{i};
    FLX{i,2}=APgetflynum(FILENAMES{i},FLYNUMXL);
end
figure
t=uitable;
set(t,'Data',FLX,'Position',[20 20 500 400],'ColumnWidth',{300 50});


% --------------------------------------------------------------------
function Expt_UFN_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Expt_UFN_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ALLfiles=questdlg('Use All Groups?')
if strcmp(ALLfiles,'No')
    FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
    GROUPNAME=handles.GROUPPOOL(get(handles.group_list,'Value')).name;
end
if strcmp(ALLfiles,'Yes')
    FILENAMES=cell(0,1);
    for i=1:numel(handles.GROUPPOOL)
        FILENAMES=[FILENAMES;handles.GROUPPOOL(i).files];
    end
    GROUPNAME=''
end
outputex=APexptUFN(FILENAMES,GROUPNAME);
UFNs=cell2mat(outputex(:,1));
chkv=cell2mat(outputex(:,3));
nselfly=numel(unique(UFNs(find(chkv))));
nfly=numel(unique(UFNs));
selprop=nselfly/nfly;
msgbox({['total flies: ',num2str(nfly)];['selected flies: ',num2str(nselfly)];['Selected Proportion: ', num2str(selprop)]},'Selection Summary')


% --------------------------------------------------------------------
function Align_ISI_CV_plots_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Align_ISI_CV_plots_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% LISTFILEsel=questdlg('Select based on individual lists?');
% if strcmp(LISTFILEsel,'Yes')
%     addfiles=1;
%     Lists=cell(0,1);
%     while addfiles==1
%         [FILES, PATH]=uigetfile('Z:\Lab\Atulya\Physiology Summary and Organization\Lists\*.txt','MultiSelect','on');
%         if ~iscell(FILES)
%             FN=FILES;
%
%             clear FILES
%             FILES={FN};
%         end
%         sp=size(Lists,1);
%         for i=1:size(FILES,2)
%             Lists(sp+i)={[PATH,FILES{i}]};
%         end
%         addfiles=0;
%         cont=questdlg('Do you want to add more Lists?');
%         if strcmp(cont,'Yes')
%             addfiles=1;
%         end
%
%     end
% end
% if strcmp(LISTFILEsel,'No')
%     PATH=uigetdir('\\biodata3.biology.uiowa.edu\wu_lab\Lab\Atulya\Physiology Summary and Organization\Lists');
%     ['finding files']
%     Lists=findfiles('txt',PATH);
%     ['files found']
%
% end
% [a b c]=xlsread('Z:\Lab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
% FLYNUMXL=c;
% h=waitbar(0,'ISI CV Analysis');
% tc=0;
% erc=0;
% tic
% for i=1:numel(Lists)
%     et=toc;
%     tg=et*(numel(Lists)-i)/i;
%     tgh=floor(tg/3600);
%     tgm=floor(tg/60)-(tgh*60);
%     tgs=tg-(tgh*3600+tgm*60);
%     waitbar(i/numel(Lists),h,[num2str(i),' of ',num2str(numel(Lists)),' ETA:',num2str(tgh),':',num2str(tgm),':',num2str(tgs)]);
%
%     nfiles=importdata(Lists{i});
%
%     try
%         %tic
%         List(i).name=Lists{i};
%         for j=1:numel(nfiles)
%            % tic
%             try
%                % tc=tc+1;
%                 List(i).UFNs(j)=APgetflynum(nfiles{j},FLYNUMXL);
%
%                 [p n e]=fileparts(nfiles{j});
%                 fn=[handles.STDATPATH,n,e];
%                 warning off all
%                 List(i).ISICV(j).data=APplotISICV(fn,0,2,6,2,0);
%                 warning on all
%                 List(i).ISICV(j).params=[0 2 6];
%                 List(i).erf(j)=0;
%                 %toc
%             catch
%                 erc=erc+1;
%                 nfiles{j};
%                 %erc/tc
%                 List(i).UFNs(j)=nan ;
%                 List(i).ISICV(j).data=nan(1,6);
%                 List(i).ISICV(j).params=[0 2 6];
%                 List(i).erf(j)=1;
%                 %toc
%             end
%         end
%
%
%
%         %toc
%     catch
%         ['error with List: ',num2str(i),' of ',num2str(numel(Lists))]
%     end
% %     if (i/50)==round(i/50)
% %         ['saving']
% %         save('TempList_ISICV.mat','List')
% %
% %     end
% end
% ['saving']
% save('TempList_ISICV.mat')
%
%
%
%
%
% ntraces=0;
% erfile=zeros(1,numel(List));
% for i=1:numel(List)
%     try
%
%         ntraces=numel(List(i).ISICV)+ntraces ;
%
%     catch
%         erfile(i)=1;
%     end
% end
% ntraces
%
% tracedist=nan(ntraces);
% meantracedist=nan(ntraces);
% tracenames=cell(1,ntraces);
% ctni=0;
% ctnj=0;
% %
% h=figure
%
% hh1=waitbar(0,'Progress')
% hh2=waitbar(0,'Progress2')
%
% sp(1)=1;
% ep(1)=numel(List(1).ISICV);
% for fi=2:numel(List)
%     sp(fi)=sp(fi-1)+numel(List(fi-1).ISICV);
%     ep(fi)=sp(fi)+numel(List(fi).ISICV)-1;
% end
% t1=tic;
% %profile on
%%%--comment in for re-runs---------
h=figure

hh1=waitbar(0,'Progress')
hh2=waitbar(0,'Progress2')
t1=tic
%%%%%______________________ALIGNMENTLOOP BELOW%%
nl=856
sv=710
for fi=711:numel(List)
    nL=numel(List);
    et=toc(t1);
    tg=et*(((nL-sv)-(fi-sv))^2/2)/((fi-sv)^2/2+(fi-sv)*(nL-(fi-sv)));
    tgh=floor(tg/3600);
    tgm=floor(tg/60)-(tgh*60);
    tgs=tg-(tgh*3600+tgm*60);
    
    waitbar(fi/numel(List),hh1,[num2str(fi),' of ', num2str(numel(List)),' ETA:',num2str(tgh),':',num2str(tgm),':',num2str(tgs) ]);
    tic
    if erfile(fi)<1
        
        %ctnj=ctni;
        for fj=fi:numel(List)
            tic
            waitbar(fj/numel(List),hh2,[num2str(fj),' of ', num2str(numel(List))]);
            if erfile(fj)<1
                
                if fi==fj
                    for ii=1:numel(List(fi).ISICV)
                        for jj=ii:numel(List(fj).ISICV)
                            %tic
                            try
                                ijad=APisicvAlignDij(real(List(fi).ISICV(ii).data(:,[1,3,4])),real(List(fj).ISICV(jj).data(:,[1,3,4])));
                                tracedist(sp(fi)+ii-1,sp(fj)+jj-1)=ijad.aD;
                                meantracedist(sp(fi)+ii-1,sp(fj)+jj-1)=ijad.aD./sum(size(ijad.pdD));
                                %                                 figure(h)
                                %                                 imagesc(meantracedist)
                                %                                 colorbar
                                %                                 caxis([0 2.5])
                            end
                            %toc
                        end
                    end
                    
                else
                    for ii=1:numel(List(fi).ISICV)
                        for jj=1:numel(List(fj).ISICV)
                            
                            try
                                ijad=APisicvAlignDij(real(List(fi).ISICV(ii).data(:,[1,3,4])),real(List(fj).ISICV(jj).data(:,[1,3,4])));
                                tracedist(sp(fi)+ii-1,sp(fj)+jj-1)=ijad.aD;
                                meantracedist(sp(fi)+ii-1,sp(fj)+jj-1)=ijad.aD./sum(size(ijad.pdD));
                            end
                        end
                        ix=sp(fi)+ii-1;
                        jx=sp(fj);
                        tracedist(ix,jx:jx+numel(AD)-1)=AD;
                        meantracedist(ix,jx:jx+numel(AD)-1)=mAD;
                        %                                 figure(h)
                        %                                 imagesc(meantracedist)
                        %                                 colorbar
                        %                                 caxis([0 2.5])
                        
                    end
                    
                end
                
                %ctnj=ctnj+numel(List(fj).ISICV);
            end
            figure(h)
            imagesc(meantracedist)
            colorbar
            caxis([0 2.5])
            toc
        end
        %ctni=ctni+numel(List(fi).ISICV);
        ['saving']
        save('TempList_ISICV.mat')
    end
    toc
end
toc
profile viewer
figure;
imagesc(tracedist);
['saving']
save('TempList_ISICV2.mat','List','tracedist','meantracedist')






% --------------------------------------------------------------------
function AP_Spike_Count_menu_Callback(hObject, eventdata, handles)
% hObject    handle to AP_Spike_Count_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
MN=APgetmicfilenames(FILENAMES,handles.MICDATPATH,0);
MICNAMES=MN.names;
[s,v]=listdlg('PromptString','Select a file to analyze:','SelectionMode','multiple','ListString',MICNAMES);
for i=1:numel(s)
    MICFILE{i}=MICNAMES{s(i)};
end
for i=1:numel(MICFILE)
    FILENAME=FILENAMES{MN.values(s(i))};
    [a b c]=xlsread(FILENAME);
    maxt=a(1,4);
    spktimes=a(4:end,1);
    
    
    ST=a(3:end,1);
    sst=a(3:end,3);
    stimtimes=sst(~isnan(sst));
    
    aptimes=0;
    try
        FlyAP(i).aptimes=a(find(~isnan(a(:,8))),8);
        FlyAP(i).apdur=a(find(~isnan(a(:,8))),9);
        
    catch
        FlyAP(i).aptimes=nan;
        FlyAP(i).apdur=nan;
        FlyAP(i).count=nan;
        FlyAP(i).rate=nan;
    end
    if ~isnan(FlyAP(i).aptimes)
        for k=1:numel(FlyAP(i).aptimes)
            FlyAP(i).count(k)=sum(ST>FlyAP(i).aptimes(k) & ST<(FlyAP(i).aptimes(k)+FlyAP(i).apdur(k)));
            FlyAP(i).rate(k)=FlyAP(i).count(k)./FlyAP(i).apdur(k);
            rate(i)=FlyAP(i).count(k)./FlyAP(i).apdur(k);
        end
    end
end
X=[0,logspace(0,2,9)];
H=histc(rate,X);
figure;
bar([0.5:1:9.5],H./sum(H))
xlabel('Spike Rate (Hz)');
ylabel('Proportion');
axis([0 11 0 1])
set(gca,'XTickLabel',{'0';'1';'2';'3';'6';'10';'18';'32';'56';'100'});
title(handles.GROUPPOOL(get(handles.group_list,'Value')).name);
FlyAP


% --------------------------------------------------------------------
function Acoustic_Analysis_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to Acoustic_Analysis_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Bilateral_Firing_Frequency_Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Bilateral_Firing_Frequency_Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.FILEPOOL;
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
recsum=APGetOtherRecs(handles.GROUPFILE);
j=1;
for i=1:numel(recsum(:,2))
    if ~strcmp(recsum{i,2},'')
        try
            if regexp(recsum{i,1},'L_DLM')
                fltstat(j).ch1name=recsum{i,1};
                fltstat(j).ch1=APFLTISIstats(recsum{i,1},0,0);
                fltstat(j).ch2name=recsum{i,2};
                fltstat(j).ch2=APFLTISIstats(recsum{i,2},0,0);
            else
                fltstat(j).ch2name=recsum{i,1};
                fltstat(j).ch2=APFLTISIstats(recsum{i,1},0,0);
                fltstat(j).ch1name=recsum{i,2};
                fltstat(j).ch1=APFLTISIstats(recsum{i,2},0,0);
            end
        catch
            fltstat(j).ch2name=recsum{i,1};
            fltstat(j).ch2=nan;
            fltstat(j).ch1name=recsum{i,2};
            fltstat(j).ch1=nan;
        end
        j=j+1;
        
        
    end
end
for i=1:numel(fltstat)
    try
        UFN(i)=APgetflynum(fltstat(i).ch1name,FLYNUMXL);
        LDLMrate(i)=1./fltstat(i).ch1.ISImean;
        RDLMrate(i)=1./fltstat(i).ch2.ISImean;
        LDLMcv(i)=fltstat(i).ch1.ISIcv;
        RDLMcv(i)=fltstat(i).ch2.ISIcv;
        diffrate(i)=1./fltstat(i).ch1.ISImean-1./fltstat(i).ch2.ISImean;
    catch
        UFN(i)=nan;
        LDLMrate(i)=nan;
        RDLMrate(i)=nan;
        LDLMcv(i)=nan;
        RDLMcv(i)=nan;
        diffrate(i)=nan;
    end
end
uUFN=unique(UFN);
export2wsdlg([{'LDLMrate'},{'RDLMrate'}],[{'LDLMrate'},{'RDLMrate'}],[{[UFN',LDLMrate']},{[UFN',RDLMrate']}]);

figure;
axis([0 2 -2 2])
hold all
for i=1:sum(~isnan(uUFN))
    LDLMrUFN(i)=mean(LDLMrate(find(UFN==uUFN(i))));
    RDLMrUFN(i)=mean(RDLMrate(find(UFN==uUFN(i))));
    if RDLMrUFN(i)>LDLMrUFN(i)
        plot([0.5 1.5],[log10(RDLMrUFN(i)), log10(LDLMrUFN(i))],'bo-');
        mosflp(i)=1;
    else
        plot([0.5 1.5],[log10(LDLMrUFN(i)), log10(RDLMrUFN(i))],'bo-');
        mosflp(i)=0;
    end
    
end

UFN





% --------------------------------------------------------------------
function Bilateral_FF_Analysis_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Bilateral_FF_Analysis_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.FILEPOOL;
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
recsum=APGetOtherRecs(handles.GROUPFILE);
FILENAMES=reshape(recsum',numel(recsum),1);
for i=1:numel( FILENAMES)
    UFN(i)=APgetflynum(FILENAMES{i},FLYNUMXL);
    try
        [a b c]= xlsread(FILENAMES{i});
        stimtimes=a(~isnan(a(:,3)),3);
        stimfreqs=1./diff(stimtimes);
        stimfreqs(find(stimfreqs<1))=stimfreqs(find(stimfreqs<1)-1);
        stimfreqs(end+1)=stimfreqs(end);
        rstimfreqs=round(stimfreqs/10)*10;
        burstnum(1)=1;
        stimnum(1)=1;
        mxfqpt=find(rstimfreqs==200);
        respv=a(4:end,5);
        for j=1:9
            bbf(j)=20*j;
            rrp(j)=sum(respv(find(rstimfreqs(1:mxfqpt(1)-1)==bbf(j))));
            stmct(j)=numel(find(rstimfreqs(1:mxfqpt(1)-1)==bbf(j)));
        end
        rrp(10)=sum(respv(mxfqpt(1:10)));
        stmct(10)=10;
        rrp(11)=sum(respv(mxfqpt(11:end)));
        stmct(11)=numel(mxfqpt(11:end));
        
        for j=12:15
            bbf(j)=200-40*(j-11);
            rrp(j)=sum(respv(find(rstimfreqs(mxfqpt(end):end)==bbf(j))+mxfqpt(end)-1));
            stmct(j)=numel(find(rstimfreqs(mxfqpt(end):end)==bbf(j))+mxfqpt(end)-1);
        end
        rp(i,:)=rrp./stmct;
        sc(i,:)=stmct;
    catch
        rp(i,:)=nan(1,15);
        sc(i,:)=nan(1,15);
    end
    
    
end

bf=[20 40 60 80 100 120 140 160 180 200 200 160 120 80 40];
dbf=diff(bf,1,2);
drp=diff(rp,1,2);
dbf(:,end+1)=zeros(size(dbf,1),1);
drp(:,end+1)=zeros(size(drp,1),1);
for i=1:size(rp,1)/2
    sUFN(i)=UFN(i*2-1);
    h=figure;
    plot(bf,abs(rp(i*2-1,:)-rp(i*2,:))*100,'k')
    hold all
    quiver(bf,abs(rp(i*2-1,:)-rp(i*2,:))*100,dbf,[diff(abs(rp(i*2-1,:)-rp(i*2,:)))*100,0],.33,'k');
    sdrp(i)=sum(abs(rp(i*2-1,:)-rp(i*2,:)));
    delete(h);
end
export2wsdlg({'FF diff'},{'ffdiff'},{[sUFN',sdrp']});
[sUFN';sdrp']


% --------------------------------------------------------------------
function Mos_Ana_Callback(hObject, eventdata, handles)
% hObject    handle to Mos_Ana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Y=evalin('base','who');
s=listdlg('PromptString','Select Variable','ListString',Y);
mosvar=evalin('base',Y{s});
load('R:\BioDataLab\Atulya\Physiology Summary and Organization\MosaicTemplates.mat');
mosfound=intersect(mosvar(:,1),mosUFN);
MosOutline=im2bw(MosTemplate);
headthoraxmask=sum(MosMasks(:,:,1:6),3);
leftflip=0;
for i=1:numel(mosfound)
    flymask=zeros(size(MosOutline));
    for j=1:numel(MaskLabels)
        flymask=flymask+MosMasks(:,:,j)*mospatches(find(mosUFN==mosfound(i)),j);
    end
    
    
    flymask=logical(flymask);
    if leftflip==1
        if sum(sum(flymask(:,1:449).*headthoraxmask(:,1:449)))<sum(sum(flymask(:,450:900).*headthoraxmask(:,450:900)))
            flymask=fliplr(flymask);
        end
    end
    
    h=figure;
    MosScore(:,:,i)=flymask.*mean(mosvar(find(mosfound(i)==mosvar(:,1)),2));
    imagesc(MosScore(:,:,i));
    colorbar
    caxis([min(mosvar(:,2)),max(mosvar(:,2))]);
    colormap(redgreenmap);
    delete(h)
    
    
end
mMosScore=nanmean(MosScore,3);
sMosMask=sum(MosMasks,3);
MosMap=mMosScore;

export2wsdlg([{'Map'},{'Outline'},{'Colormap'}],[{'MosMap'},{'MosOutline'},{'RGcmap'}],[{MosMap},{MosOutline},{redgreenmap}])
MosMap(~MosOutline)=1000;
figure

imagesc(MosMap)
colorbar
caxis([min(mosvar(:,2)),max(mosvar(:,2))]);
colormap(redgreenmap);
caxis([-1 1]);


% --------------------------------------------------------------------
function Bilat_ISICV_Plot_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Bilat_ISICV_Plot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.FILEPOOL;

handles.FILEPOOL;
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
recsum=APGetOtherRecs(handles.GROUPFILE);
sc=nan(size(recsum,1),2);
mx=nan(size(recsum,1),2);
idx=cellfun(@isempty,recsum(:,2));
recFILES=recsum(~idx,:);
[s,v]=listdlg('PromptString','Select a file to analyze:','SelectionMode','multiple','ListString',recFILES(:,1));
for i=1:numel(s)
    FILES(i,:)=recFILES(s(i),:);
end

% selv=get(handles.group_file_list,'Value');
% [a b c]=xlsread('Z:\Lab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
% FLYNUMXL=c;
% recsum=APGetOtherRecs(handles.GROUPFILE(selv));
% FILENAMES=reshape(recsum',numel(recsum),1);
svsg= 'Single'; %questdlg('Do you want to plot for a single file (vs time) or for the group?','Selection Type','Single','Group','Single');
prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
while isempty(str2num(prtcl{1}))
    prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
end

sho=2;
seldat=0;
checkmale=0;

for i=1:size(FILES,1)
if isempty(strfind(FILES{i,1},'L_DLM'));
FILES(i,:)=fliplr(FILES(i,:));
end
end

for i=1:size(FILES,1)
    try
        UFN(i)=APgetflynum(FILES{i,1},FLYNUMXL);
        if checkmale==1
          A=inputdlg('Is Male? (L,R)','Sex',1,{'0,0'});
          m=str2num(A{1});
          m=m*-1;
          isfemale=m+(m>=0);
        else
            isfemale=[1,1];   
        end
        ISICV(i,1).dat=APplotFanoPhase(FILES{i,1},0,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),0);
        ISICV(i,2).dat=APplotFanoPhase(FILES{i,2},0,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),0);
        ISICV(i,1).ufn=UFN(i);
        ISICV(i,2).ufn=UFN(i);
        ISICV(i,1).fn=FILES{i,1};
        ISICV(i,2).fn=FILES{i,2};
        if sho>0
            figure
            
            hold all
            cmapM(:,1)=[[128:2:255],ones(1,64)*255]./255;
            cmapM(:,2)=[zeros(1,64),[1:2:127]]./255;
            cmapM(:,3)=[zeros(1,64),[1:2:127]]./255;
            cmapF(:,3)=[127:-1:0]./255;
            cmapF(:,2)=[127:-1:0]./255;
            cmapF(:,1)=[127:-1:0]./255;
            cmap=[cmapM;flipud(cmapF)];
            colormap(cmap)
            
            subplot(5,1,1)
            if isempty(strfind(FILES{i,1},'L_DLM'))
                scatter(ISICV(i,1).dat(:,1),ISICV(i,1).dat(:,3),200,ISICV(i,1).dat(:,1)*isfemale(1),'.')
            else
                scatter(ISICV(i,2).dat(:,1),ISICV(i,2).dat(:,3),200,ISICV(i,2).dat(:,1)*isfemale(1),'.')
            end
            caxis([-90 90])
            hold all
            if isempty(strfind(FILES{i,2},'L_DLM'))
                scatter(ISICV(i,1).dat(:,1),ISICV(i,1).dat(:,3),200,ISICV(i,1).dat(:,1)*isfemale(2),'.')
            else
                scatter(ISICV(i,2).dat(:,1),ISICV(i,2).dat(:,3),200,ISICV(i,2).dat(:,1)*isfemale(2),'.')
            end
            axis([0 90 -1 2])
            title(FILES{i,1})
            if sho>1
                subplot(5,1,[2,3]);
            else
                subplot(5,1,[2:5]);
            end
            if isempty(strfind(FILES{i,1},'L_DLM'))
                scatter(ISICV(i,1).dat(:,3),ISICV(i,1).dat(:,4),200,ISICV(i,1).dat(:,1)*isfemale(2),'.');
                patch([ISICV(i,1).dat(:,3);nan],[ISICV(i,1).dat(:,4);nan],[ISICV(i,1).dat(:,1);nan]*isfemale(2),'facecolor','none','edgecolor','interp','LineWidth',1);
            else
                scatter(ISICV(i,2).dat(:,3),ISICV(i,2).dat(:,4),200,ISICV(i,2).dat(:,1)*isfemale(2),'.');
                patch([ISICV(i,2).dat(:,3);nan],[ISICV(i,2).dat(:,4);nan],[ISICV(i,2).dat(:,1);nan]*isfemale(2),'facecolor','none','edgecolor','interp','LineWidth',1);
            end
            axis([-1 2.5 -2 1])
            caxis([-100 100]);
            title('R_DLMn')
            
            %colorbar
            if sho>1
                subplot(5,1,[4,5])
            else
                subplot(5,1,[2:5]);
            end
            if isempty(strfind(FILES{i,2},'L_DLM'))
                scatter(ISICV(i,1).dat(:,3),ISICV(i,1).dat(:,4),200,ISICV(i,1).dat(:,1)*isfemale(1),'.');
                patch([ISICV(i,1).dat(:,3);nan],[ISICV(i,1).dat(:,4);nan],[ISICV(i,1).dat(:,1);nan]*isfemale(1),'facecolor','none','edgecolor','interp','LineWidth',1);
            else
                scatter(ISICV(i,2).dat(:,3),ISICV(i,2).dat(:,4),200,ISICV(i,2).dat(:,1)*isfemale(1),'.');
                patch([ISICV(i,2).dat(:,3);nan],[ISICV(i,2).dat(:,4);nan],[ISICV(i,2).dat(:,1);nan]*isfemale(1),'facecolor','none','edgecolor','interp','LineWidth',1);
            end
            axis([-1 2.5 -2 1])
            caxis([-100 100]);
            title('L_DLMn')
            % colorbar
            if seldat
                [pl xs ys]=selectdata;
                ptsel(i).pl=pl{1};
                ptsel(i).xs=xs{1};
                ptsel(i).ys=ys{1};
                ptsel(i).UFN=UFN(i);
            end
            
        end
    catch
    end
end
export2wsdlg({'ISICV'},{'ISICV'},{ISICV});
if seldat
export2wsdlg({'selectedpoints'},{'ptsel'},{ptsel});
end




% --------------------------------------------------------------------
function ECS_ISI_phaseplot_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ECS_ISI_phaseplot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
for i=1:numel(FILENAMES)
    try
        APPlotISIphase(FILENAMES{i},1,1,1);
    catch
        ['error with: ',num2str(i)]
        FILENAMES{i}
    end
end


% --------------------------------------------------------------------
function ISI_Phase_Plot_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to ISI_Phase_Plot_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
allfiles=questdlg('Use Selected files? (No for all files)');
if strcmp('Yes',allfiles)
   selfiles=get(handles.group_file_list,'Value');
   FILENAMES=handles.GROUPFILE(selfiles);
else
    FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
end

for i=1:numel(FILENAMES)
    tic
    try
        output(i).FILENAME=FILENAMES{i};
        output(i).dat=APPlotISIphase(FILENAMES{i},1,0,1);
        
    catch
        ['error with: ',num2str(i)]
        FILENAMES{i}
    end
    toc
end
toexport=questdlg('Export Poincare Data?');
if strcmp('Yes',toexport) 
    export2wsdlg({'Poincare output'},{'output'},{output})
end

% --------------------------------------------------------------------
function GF_Latency_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to GF_Latency_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.GROUPPOOL;
ntraces=size(handles.GROUPFILE,1);
groupn=get(handles.group_list,'Value');
grpNAME=handles.GROUPPOOL(groupn).name{1};
A = inputdlg('Stim # to analyze','Stim #',[1 30],{'1'});
StimNum = str2num(A{1});

recdir=uigetdir('D:\Recordings Hold');
if isnumeric(recdir)
    recdir='D:\Recordings Hold';
end
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
for i=1:ntraces
    
    disp(i)
    disp(handles.GROUPFILE{i})
    %[a b c]=xlsread(handles.GROUPFILE{i});
    a = readmatrix(handles.GROUPFILE{i});
    ST=a(~isnan(a(:,3)),3);
    stimtimes = ST(ST>3);
    
    [aa bb cc]=fileparts(handles.GROUPFILE{i});
    [t1 r]=strtok(bb,'_');
    [t2 r]=strtok(r,'_');
    fname{i}=[recdir,'\',t1,'_',t2,'.txt'];
    data=importdata(fname{i});
    
    for j = 1:numel(StimNum)
        iniST (i,j) = stimtimes(StimNum(j));
        try
            %         if stimtimes(1)>3
            %             iniST(i)=stimtimes(1);
            %         else
            %             iniST(i)=stimtimes(2);
            %         end
            startpt=(floor(iniST(i,j)*1000)-2)/1000;
            endpt=(ceil(iniST(i,j)*1000)+4)/1000;
            
            plr=(data(:,1)>startpt & data(:,1)<endpt);
            seldat=data(plr,:);
            if isempty(strfind(handles.GROUPFILE{i},'L_DLM'))
                Ch=2;
            else
                Ch=3;
            end
            FF=figure;
            hold all;
            plot(seldat(:,1),seldat(:,Ch),'bx-')
            
            plot(seldat(:,1),seldat(:,5),'r')
            [pk1 loc1]=findpeaks(seldat(:,Ch),'MINPEAKDISTANCE',10,'MINPEAKHEIGHT',1.25);
            [pk2 loc2]=findpeaks(-1*seldat(:,Ch),'MINPEAKDISTANCE',10,'MINPEAKHEIGHT',-1);
            sloc1=loc1(end);
            sloc2=max(loc2(loc2<sloc1))  ;
            ig1=plot(seldat(sloc1,1),seldat(sloc1,Ch),'go');
            ig2=plot(seldat(sloc2,1),seldat(sloc2,Ch),'ro');
            xp=seldat(sloc2,Ch)+(seldat(sloc1,Ch)-seldat(sloc2,Ch))/2;
            [xv xloc]=min(abs(seldat(sloc2:sloc1,Ch)-xp));
            xloc=sloc2+xloc-1;
            
            plot(seldat(xloc,1),seldat(xloc,Ch),'k*')
            latency(i,j)=(seldat(xloc,1)-iniST(i,j))*1000;
            ACC=questdlg(['Calc Latency = ',num2str(latency(i,j)),'.  Accept (else NaN)?']);
            if ~strcmp(ACC,'Yes')
                while strcmp(ACC,'No')
                    [pl1 xs1 ys1]=selectdata('SelectionMode','Closest','ignore',[ig1,ig2]);
                    sloc1=mean(cell2mat(pl1));
                    [pl2 xs2 ys2]=selectdata('SelectionMode','Closest','ignore',[ig1,ig2]);
                    sloc2=mean(cell2mat(pl2));
                    xp=seldat(sloc2,Ch)+(seldat(sloc1,Ch)-seldat(sloc2,Ch))/2;
                    [xv xloc]=min(abs(seldat(sloc2:sloc1,Ch)-xp));
                    xloc=sloc2+xloc-1;
                    figure(FF)
                    hold all
                    plot(seldat(xloc,1),seldat(xloc,Ch),'kd');
                    latency(i,j)=(seldat(xloc,1)-iniST(i,j))*1000;
                    ACC=questdlg(['Calc Latency = ',num2str(latency(i,j)),'.  Accept (else NaN)?']);
                end
                if strcmp(ACC,'Cancel')
                    latency(i,j)=nan;
                end
            end
            delete(FF);
            UFN(i)=APgetflynum(handles.GROUPFILE{i},FLYNUMXL);
        catch
            latency(i)=nan;
            UFN(i)=nan;
            
        end
    end
    
end

export2wsdlg({'Latency Data'},{'LatDat'},{[UFN;latency']'});


% --------------------------------------------------------------------
function MicFFanalysis_Callback(hObject, eventdata, handles)
% hObject    handle to MicFFanalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function SupernumarySpikes_Callback(hObject, eventdata, handles)
% hObject    handle to SupernumarySpikes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.GROUPPOOL
for i=1:numel(handles.GROUPPOOL)
    try
        ESr=APextraspikeanalysis(handles.GROUPPOOL{i})
        ESmat(:,i)=ESr(:,2);
    catch
        ESmat(:,i)=nan(150,1);
    end
    
    
end

export2wsdlg('ESmat','ESmat',ESmat);


% --------------------------------------------------------------------
function DD_onset_analysis_menu_Callback(hObject, eventdata, handles)
% hObject    handle to DD_onset_analysis_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
SCwindow=10;
ECS_Raster_plot_menu_Callback(hObject, eventdata, handles, 'Single')
for i=1:numel(handles.GROUPFILE)
    try
        set(handles.group_file_list,'Value',i)
        FILENAME=handles.GROUPFILE{get(handles.group_file_list,'Value')};
        DD_UFN(i)=APgetflynum(FILENAME,FLYNUMXL);
        Inst_FF_resp_ecs_Callback(hObject, eventdata, handles, 'Trace')
        h=gcf;
        figure(h)
        hold all
        line([10 10],[0 50],'LineStyle','--')
        title({[FILENAME];[num2str(i), ' of ',num2str(numel(handles.GROUPFILE)),'     #',num2str(DD_UFN(i))]});
        [pl xs ys]=selectdata('SelectionMode','lasso');
        if ~isempty(pl{2})
            DD_onset(i)=min(xs{2});
            try
                [a b c]=APloadSTdat(FILENAME);
                ST=a(:,1);
                offset=min(a(~isnan(a(:,3)),3));
                oST=ST-offset;
                doST=diff(oST).^-1;
                DD_sC(i)=numel(find(oST>DD_onset(i)&oST<(DD_onset(i)+10)));
                DD_max(i)=max(doST(find(oST>DD_onset(i)&oST<(DD_onset(i)+10))))
            catch
                DD_sC(i)=nan;
                DD_max(i)=nan;
            end
        else
            DD_onset(i)=nan;
            DD_sC(i)=nan;
            DD_max(i)=nan;
        end
        delete(h)
    catch
        DD_UFN(i)=nan;
        DD_onset(i)=nan;
        DD_sC(i)=nan;
        DD_max(i)=nan;
    end
    
    
    
end
X=[0:80];
a_i=[20,5];
b=nan;
nb=nan;
if sum(~isnan(DD_onset))/size(DD_onset,2)<=0.40
    ContDTE=questdlg('Warning <40% Del Disch found Do you want to model as a DTE');
    
else
    ContDTE='Yes';
end

if strcmp(ContDTE,'Yes')
    % as Dead-Time process
    
    try
        
        pDD=histc(DD_onset,X)./sum(histc(DD_onset,X));
        cDD=cumsum(pDD);
        
        cdtp=@(a,x)((1-exp(-1*(x-a(1))/a(2))).*((x-a(1))>=0));
        b=nlinfit(X,cDD,cdtp,a_i);
        figure;
        plot(X,cDD,'bx-')
        hold all
        plot(X,cdtp(b,X),'r-')
        xlabel('Time (s)');
        ylabel('Cum. Prob. DD onset');
        legend('Prop.','DTE Model','Location','NorthWest')
        title({[handles.GROUPPOOL(get(handles.group_list,'Value')).name{1}];['DTE (delay,\lambda)     ', num2str(b)]})
       nb = [nan nan];
        for i=1:1000
            try
            idx=round(rand(1,numel(DD_onset))*(numel(DD_onset)-1))+1;
            ncDD=cumsum(histc(DD_onset(idx),X)./sum(histc(DD_onset(idx),X)));
            nb(i,:)=nlinfit(X,ncDD,cdtp,a_i);
            catch
                nb(i,:) = [ nan nan];
            end
        end
    catch
        ['Error with DTE Analysis'];
    end
    
end

[s idx]=sort(DD_onset);
ECS_Raster_plot_menu_Callback(hObject, eventdata, handles, 'Single',idx)

export2wsdlg({'DD_UFN','DD_onset','DD_sC','DD_max','DTE param','DTE Bootstrap','Time'},{'DD_UFN','DD_onset','DD_sC','DD_max','DTEparam','DTEbootstrp','T'},{DD_UFN,DD_onset,DD_sC,DD_max,b,nb,X});


% --------------------------------------------------------------------
function DD_onset_ISICV_menu_Callback(hObject, eventdata, handles)
% hObject    handle to DD_onset_ISICV_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ID_Bilat_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to ID_Bilat_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.FILEPOOL;
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
recsum=APGetOtherRecs(handles.GROUPFILE);
sc=nan(size(recsum,1),2);
mx=nan(size(recsum,1),2);
for i=1:size(recsum,1)
    try
    if ~(isempty(strfind(recsum{i,2},'L_DLM')))||~(isempty(strfind(recsum{i,2},'R_DLM')))
        h=figure
        hold all
        if strfind(recsum{i,2},'L_DLM')
            FILENAME1=recsum{i,1};
            FILENAME2=recsum{i,2};
        else
            FILENAME2=recsum{i,1};
            FILENAME1=recsum{i,2};
        end
        [a b c]=xlsread(FILENAME1);
        [P F I]=fileparts(FILENAME1);
        ST=a(3:end,1);
        if isnan(ST(1))
            ST=ST(2:end);
        end
        sst=a(3:end,3);
        if isnan(sst(1))
            sst=sst(2:end);
        end
        stimtimes=sst(~isnan(sst));
        offset=stimtimes(1);
        oend=stimtimes(end)-stimtimes(1);
        oST=ST-offset;
        dST=diff(oST);
        T=oST(1:end-1);
        nspks=numel(T);
        plot(T(T>oend),log10(1./dST(T>oend)),'b.','LineWidth',.5);
        axis([0 10 0 3]);
        [a b c]=xlsread(FILENAME2);
        [P F I]=fileparts(FILENAME2);
        ST=a(3:end,1);
        if isnan(ST(1))
            ST=ST(2:end);
        end
        sst=a(3:end,3);
        if isnan(sst(1))
            sst=sst(2:end);
        end
        stimtimes=sst(~isnan(sst));
        offset=stimtimes(1);
        oend=stimtimes(end)-stimtimes(1);
        oST=ST-offset;
        dST=diff(oST);
        T=oST(1:end-1);
        nspks=numel(T);
        plot(T(T>oend),log10(1./dST(T>oend)),'r.','LineWidth',.5);
        axis([0 10 0 3]);
        
        [pl xs ys]=selectdata
        R(i).ST=xs{1};
        L(i).ST=xs{2};
        sc(i,1)=numel(R(i).ST);
        sc(i,2)=numel(L(i).ST);
        mx(i,1)=max(R(i).ST);
        mx(i,2)=max(L(i).ST);
        delete(h)
    end
    end
end
export2wsdlg({'R_DLM','L_DLM','sc','mx'},{'R_DLM','L_DLM','sc','mx'},{R,L,sc,mx})


% --------------------------------------------------------------------
function FormatJSLFiles_menu_Callback(hObject, eventdata, handles)
% hObject    handle to FormatJSLFiles_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:numel(handles.FILEPOOL)
    try
FormatJSLfile(handles.FILEPOOL{i})    
    catch
        ['error', num2str(i)] 
        
    end
end


% --------------------------------------------------------------------
function ECS_ISIpoincarePlot_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ECS_ISIpoincarePlot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ana=questdlg('Do you want to use all or selection?','Analyze List','Sel','All','Sel');
if strcmp(ana,'Sel')
    v=get(handles.group_file_list,'Value');
    FILENAMES=handles.GROUPFILE(v);
elseif strcmp(ana,'All')
    FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files; 
end
a=inputdlg('Enter Range','Range',1,{'0 60'});
range=str2num(a{1});
for i=1:numel(FILENAMES)
    tic
    try
        APPlotISIphase(FILENAMES{i},1,1,1,range);
        
    catch
        ['error with: ',num2str(i)]
        FILENAMES{i}
    end
    toc
end



% --------------------------------------------------------------------
function DD_SC_box_plot_menu_Callback(hObject, eventdata, handles)
% hObject    handle to DD_SC_box_plot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ngrps=size(handles.GROUPPOOL,2);
UFNs=zeros(0,1);
FFarray=zeros(0,1);
CVarray=zeros(0,1);
IDgrp=zeros(0,1);
ISIarray=zeros(0,1);
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
for i=1:ngrps
    ntraces=size(handles.GROUPPOOL(i).files,1);
    lnames(i)=handles.GROUPPOOL(i).name;
    for j=1:ntraces
        try
            fname=handles.GROUPPOOL(i).files{j};
            fltstat=APFLTISIstats(fname,0,0,[10 100000]);
            gntypffcv(i).ff(j)=1/fltstat.ISImean;
            gntypffcv(i).cv(j)=fltstat.ISIcv;
            FFarray(end+1)=1/fltstat.ISImean;
            CVarray(end+1)=fltstat.ISIcv;
            IDgrp(end+1)=i;
            UFNs(end+1)=APgetflynum(handles.GROUPPOOL(i).files{j},FLYNUMXL);
            ISIarray=[ISIarray;fltstat.ISI];
        catch
           FFarray(end+1)=nan;
            CVarray(end+1)=nan;
            IDgrp(end+1)=i;
            UFNs(end+1)=APgetflynum(handles.GROUPPOOL(i).files{j},FLYNUMXL);
        end
    end
    
    
end
% FFarray=zeros(0);
% CVarray=zeros(0);
% IDgrp=zeros(0);
% for i=1:ngrps
%     FFarray=cat(2,FFarray,gntypffcv(i).ff);
%     CVarray=cat(2,CVarray,gntypffcv(i).cv);
%     IDgrp=cat(2,IDgrp,ones(size(gntypffcv(i).ff))*i);
% end
% FFarray(isnan(FFarray))=0;
% CVarray(isnan(CVarray))=0;
% figure
% boxplot(FFarray,IDgrp,'plotstyle','compact','extrememode','compress','symbol','rx')
% figure
% boxplot(log10(FFarray),IDgrp,'plotstyle','compact','extrememode','compress','symbol','rx')


export2wsdlg([{'FFarray'}, {'CVarray'},{'IDgrp'},{'ISIarray'},{'UFNs'}],[{'FFarray'}, {'CVarray'},{'IDgrp'},{'ISIarray'},{'UFNs'}],[{FFarray}, {CVarray},{IDgrp},{ISIarray},{UFNs}]);

kruskalwallis(FFarray,IDgrp);


% --------------------------------------------------------------------
function Bilat_inst_phase_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Bilat_inst_phase_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.FILEPOOL;
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
recsum=APGetOtherRecs(handles.GROUPFILE);
sc=nan(size(recsum,1),2);
mx=nan(size(recsum,1),2);
idx=cellfun(@isempty,recsum(:,2));
recFILES=recsum(~idx,:);
[s,v]=listdlg('PromptString','Select a file to analyze:','SelectionMode','multiple','ListString',recFILES(:,1));
for i=1:numel(s)
    FILES(i,:)=recFILES(s(i),:);
end
allph=zeros(1,0);
anestspk=zeros(1,0);
er=0;
h1=figure;
hold all
X=[0:0.025:1];
for i=1:size(FILES,1)
    try
    ST1=APFLTrdspktms(FILES{i,1});
    ST2=APFLTrdspktms(FILES{i,2});
    if handles.instphaseoptions(1)==1
        [n t r]=xlsread(FILES{i,1});
         sst=n(3:end,3);
         stimtimes=sst(~isnan(sst));
            offset=stimtimes(1);
            oend=stimtimes(end);
            ST1=ST1-oend;
            ST2=ST2-oend;
            ST1=ST1(ST1>handles.instphaseoptions(2)&ST1<handles.instphaseoptions(3));
            ST2=ST2(ST2>handles.instphaseoptions(2)&ST2<handles.instphaseoptions(3));
    end
    C=bsxfun(@minus,ST1,ST2');
    nC=C;
    nC(C>0)=nan;
    [v,prevS]=max(nC);
    prevS(isnan(v))=1;
    mC=C;
    mC(C<0)=nan;
    [v,nxtS]=min(mC);
    nxtS(isnan(v))=max(nxtS);
    ph=(ST2-ST1(prevS))./(ST1(nxtS)-ST1(prevS)); 
    ph(ph>1)=nan;
    ph(ph<0)=nan;
    figure
    
        plot(ST2,ph,'ko');
        title(FILES{i})
   
    axis([0 60 0 1]);
    allph=[allph;ph];
    nearestspk=nanmin(mC);
    anestspk=[anestspk;nearestspk'];
    hph=hist(ph,X);
    nhph=hph./sum(hph);
    figure(h1)
    plot(X,nhph,'Color',[.5 .5 .5]);
    axis([0 1 0 0.25])
    catch
        i;
        er=er+1;
        [i er]
    end
    
end
allph=allph(~isinf(allph));
h2=figure;
haph=hist(allph,X);
naph=haph./sum(haph);
bar(X,naph)
hold all
line([0 1],[.025 .025],'LineStyle','--','Color','r')
numel(allph)
axis([-0.1 1.1 0 .25])
rsk=anestspk(anestspk>0)
XX=[-3.5:.1:0]
figure; hist(log10(rsk),XX)



% --------------------------------------------------------------------
function Bilat_binned_cov_menu_Callback(hObject, eventdata, handles, varargin)
% hObject    handle to Bilat_binned_cov_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.FILEPOOL;
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
recsum=APGetOtherRecs(handles.GROUPFILE);
sc=nan(size(recsum,1),2);
mx=nan(size(recsum,1),2);
idx=cellfun(@isempty,recsum(:,2));
recFILES=recsum(~idx,:);
[s,v]=listdlg('PromptString','Select a file to analyze:','SelectionMode','multiple','ListString',recFILES(:,1));
for i=1:numel(s)
    FILES(i,:)=recFILES(s(i),:);
end
BinSize=1000;
Overlap=.5;
cco=-50;
PKco=4;
F=[100:2:250];
A=inputdlg({'Bin Size (ms)','Overlap (0=none,.999=max)'},'Spectrogram Parameters',1,{num2str(BinSize),num2str(Overlap)});
bs=str2num(A{1});
if ~isempty(bs)
    if bs>0
        BinSize=bs;
    end
end
olp=str2num(A{2});
if ~isempty(olp)
    if olp>=0
        if olp<0.9999;
            Overlap=olp;
        end
    end
end
BinOl=[BinSize Overlap];
gabst=zeros(1,0);
labst=zeros(1,0);
h=figure;
ctrs{1}=[0:2:20,40:20:200];
ctrs{2}=[0:2:20,40:20:200];
for i=1:size(FILES,1)
    try
        i
        [a b c]=xlsread(FILES{i,1});
        maxt1=a(1,4);
        ST1=a(4:end,1);
        
        [a b c]=xlsread(FILES{i,2});
        maxt2=a(1,4);
        ST2=a(4:end,1);
        
        
        bst1=APBinCounts_modmaxt(ST1,(BinSize/1000),Overlap,maxt1);
        bst2=APBinCounts_modmaxt(ST2,(BinSize/1000),Overlap,maxt2);
        if numel(ST1)>numel(ST2)
            gabst=[gabst;bst1(2,:)'];
            labst=[labst;bst2(2,:)'];
        else
            gabst=[gabst;bst2(2,:)'];
            labst=[labst;bst1(2,:)'];
        end
        
        h3=hist3([labst./(BinSize/1000),gabst./(BinSize/1000)],ctrs);
        sh3=sum(sum(h3));
        nh3=h3./(sh3-h3(1,1));
        nh3(1,1)=nan;
        figure(h)
        cmap=colormap(hot);
        colormap(flipud(cmap));
        imagesc(ctrs{1},ctrs{2},nh3)
        colorbar
        caxis([0 .3])
        set(gca,'Ydir','normal')
        
    catch
        ['err ' num2str(i)];
        
        
    end
end
sabst=gabst+labst;
zbst=(sabst>0);
corrcoef([gabst(zbst),labst(zbst)])
[R P Rlo Rup]=corrcoef([gabst(zbst),labst(zbst)])


% --------------------------------------------------------------------
function DD_Inst_Phase_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to DD_Inst_Phase_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.instphaseoptions=[1 10 100];
Bilat_inst_phase_menu_Callback(hObject, eventdata, handles)
handles.instphaseoptions=[0 0 0];
guidata(hObject,handles);

% --------------------------------------------------------------------
function ID_Inst_Phase_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ID_Inst_Phase_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function InjectTime_menu_Callback(hObject, eventdata, handles)
% hObject    handle to InjectTime_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ntraces=size(handles.GROUPFILE,1);
groupn=get(handles.group_list,'Value');
grpNAME=handles.GROUPPOOL(groupn).name{1};
recdir=uigetdir('D:\Recordings Hold');
if isnumeric(recdir)
    recdir='D:\Recordings Hold';
end

for i=1:ntraces
    [a b c]=fileparts(handles.GROUPFILE{i});
    [t1 r]=strtok(b,'_');
    [t2 r]=strtok(r,'_');
    fname{i}=[recdir,'\',t1,'_',t2,'.txt'];
end

InjectTimes=APgetinjectinfo(fname);
export2wsdlg({'Times'},{'InjectTimes'},{InjectTimes});


% --------------------------------------------------------------------
function get_other_rec_menu_Callback(hObject, eventdata, handles)
% hObject    handle to get_other_rec_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename=handles.GROUPFILE(handles.group_file_list.Value);
OT=APGetTracesFly(filename);
ATL=questdlg('Add to the filename pool?');
if strcmp(ATL,'Yes')
   
    nfiles=OT(:,4);
 handles.FILEPOOL=union(nfiles',handles.FILEPOOL);
set(handles.file_list,'Value',1);
 set(handles.file_list,'String',handles.FILEPOOL);
    

set(handles.text1,'String',[num2str(numel(handles.FILEPOOL)),' items']);
guidata(hObject,handles);

end


% --- Executes on button press in exp_ST2WS_btn.
function exp_ST2WS_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exp_ST2WS_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cv=handles.group_file_list.Value;
SELFILE=handles.GROUPFILE{cv};
[a b c]=xlsread(SELFILE);
[numdata txtdata celldata]=xlsread(SELFILE);
[p n e]=fileparts(SELFILE);
fn=strtok(n);

export2wsdlg([{['ST numeric'];['ST text'];['ST cell']}],[{['STnum_',fn]};{['STtxt_',fn]};{['STcell_',fn]}],[{numdata};{txtdata};{celldata}]);


% --------------------------------------------------------------------
function ISI_CV2_Dens_Plt_Menu_Callback(hObject, eventdata, handles)
% hObject    handle to ISI_CV2_Dens_Plt_Menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ISICV2origplot_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ISICV2origplot_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
svsg=questdlg('Do you want to plot for a single file (vs time) or for the group?','Selection Type','Single','Group','Single');
prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
while isempty(str2num(prtcl{1}))
    prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
end
mintval=inputdlg('enter min spike time','min time',1,{'15'});
groupname=handles.GROUPPOOL(get(handles.group_list,'Value')).name{1};

FILENAME=handles.GROUPFILE{get(handles.group_file_list,'Value')};
filtsz=str2num(prtcl{2})
APplotISICV2orig(FILENAME,str2num(mintval{1}),filtsz);


% --------------------------------------------------------------------
function optogenetics_Callback(hObject, eventdata, handles)
% hObject    handle to optogenetics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Raster_align_LED_Callback(hObject, eventdata, handles)
% hObject    handle to Raster_align_LED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
grpsel=questdlg('Which groups do you want to analyze?','Group Analysis','All','Single','Cancel','Cancel');
if strcmp(grpsel,'Single')==1
    cgv=get(handles.group_list,'value');
    ntraces=size(handles.GROUPPOOL(cgv).files,1);
    h1 =figure
    hold all

        h2 = waitbar(0,'starting');
  
    for i=1:ntraces
        try
            waitbar(i/ntraces,h2,'loading');
            disp(handles.GROUPPOOL(cgv).files{i});
            [a b c]=APloadSTdat(handles.GROUPPOOL(cgv).files{i});
            TraceFile = APgetTraceFile(handles.GROUPPOOL(cgv).files{i});
            try
                led_off = APLEDchTiming(TraceFile);
                offset = led_off{1};
            catch
                try
                    D =importdata(TraceFile);
                    %D =importdata(TraceFile);
                    LedCh = D(:,5);
                    led_off = APLEDstimProps(LedCh,D(:,1),20000);
                    offset = led_off(1);
                catch
                    offset=0;
                    ['Warning, endstim not found, set to 0'];
                end
                %offset=0;
                %['Warning, endstim not found, set to 0'];
            end
            
            
            figure(h1)
            hold all;
            ST=a(3:end,1);
            oST=ST-offset;
            doST(1)=0;
            doST(2:numel(oST))=diff(oST);
            scatter(oST,i*ones(1,size(oST,1)),10,log10(1./doST),'filled');
            caxis([0 20]);
            [p n e]= fileparts(handles.GROUPPOOL(cgv).files{i});
            tickname{i}=n;
            dat(i).doST = doST;
            clear doST
            dat(i).ST = ST;
            clear ST
            %dat(i).sst = sst;
            %clear sst
            %dat(i).stimtimes = stimtimes;
            %clear stimtimes
            dat(i).offset = offset;
            clear offset
            dat(i).oST = oST;
            clear oST
        catch
             dat(i).doST = nan;
            clear doST
            dat(i).ST = nan;
            clear ST
            %dat(i).sst = nan;
            %clear sst
            %dat(i).stimtimes = nan;
            %clear stimtimes
            dat(i).offset = nan;
            clear offset
            dat(i).oST = nan;
            clear oST
        end
        
    end
    caxis([0 2]);
    axis([0 60 0 ntraces+1]);
    title(handles.GROUPPOOL(cgv).name{1});
    xlabel('Time (s)')
    set(gca,'YTick',[1:1:ntraces]);
    set(gca,'YTickLabel',tickname)
    colorbar
    export2wsdlg({'Dat'},{'dat'},{dat});
end
if strcmp(grpsel,'All')==1
    figure
    hold all
    ngrps=size(handles.GROUPPOOL,2);
    ttn=0;
    
    for j=1:ngrps
        cmap=colormap(lines(ngrps));
        ntraces=size(handles.GROUPPOOL(j).files,1);
        for i=1:ntraces
            ttn=ttn+1;
            try
                [a b c]=APloadSTdat(handles.GROUPPOOL(j).files{i});
                ST=a(3:end,1);
                plot(ST,ttn*ones(1,size(ST,1)),'LineStyle','none','Marker','.','MarkerEdgeColor',cmap(j,:));
            catch
            end
        end
        
        
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function LED_align_STFFT_menu_Callback(hObject, eventdata, handles)
% hObject    handle to LED_align_STFFT_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles
BinSize=1000;
Overlap=0.5;
F=[100:2:300];
FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
MN=APgetmicfilenames(FILENAMES,handles.MICDATPATH,0);
MICNAMES=MN.names;
[s,v]=listdlg('PromptString','Select a file to analyze:','SelectionMode','multiple','ListString',MICNAMES);
for i=1:numel(s)
    MICFILE{i}=MICNAMES{s(i)};
end
%Get spectrogram Params
BinSize=500;
Overlap=.75;
cco=-50;
PKco=4;
F=[100:2:300];
A=inputdlg({'Bin Size (ms)','Overlap (0=none,.999=max)'},'Spectrogram Parameters',1,{num2str(BinSize),num2str(Overlap)});
bs=str2num(A{1});
if ~isempty(bs)
    if bs>0
        BinSize=bs;
    end
end
olp=str2num(A{2});
if ~isempty(olp)
    if olp>=0
        if olp<0.9999;
            Overlap=olp;
        end
    end
end
BinOl=[BinSize Overlap];
A=inputdlg({'Power cutoff (dB)','Skew cutoff'},'WBF ID Parameters',1,{num2str(cco),num2str(PKco)});
bs=str2num(A{1});
if ~isempty(bs)
    if bs>0
        cco=bs;
    end
end
olp=str2num(A{2});
if ~isempty(olp)
    if olp>0
        PKco=olp;
    end
end
SNRK=[cco PKco];
hh=figure;
wh=waitbar(0,'Initializing');
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
FLYNUMXL=c;
for i=1:numel(MICFILE)
    try
        flynum(i)=APgetflynum(MICFILE{i},FLYNUMXL);
    catch
        flynum(i)=0;
    end
end
[C ia flyc]=unique(flynum);
for i=1:numel(MICFILE)
    waitbar(i/numel(MICFILE),wh,{['Analyzing ' num2str(i),' of ',num2str(numel(MICFILE)),' Files'];MICFILE{i}});
    try
        dat(i)=APmicfileanalysis(MICFILE{i},BinOl,F,SNRK,0,0);
        FILENAME=FILENAMES{MN.values(s(i))};
        [a b c]=APloadSTdat(FILENAME);
        TraceFile = APgetTraceFile(FILENAME);
        led_off = APLEDchTiming(TraceFile);
       
        maxt=a(1,4);
        mxt(i)=maxt;
        spktimes=a(4:end,1);
        
        
        ST=a(3:end,1);
%         sst=a(3:end,3);
%         stimtimes=sst(~isnan(sst));
        offset=led_off{1};
        oST=spktimes-offset;
        offV(i)=offset;
        spt(i).spktimes=spktimes;
        spt(i).stimtimes=led_off;
        bst=APBinCounts_modmaxt(spktimes,(BinSize/1000),Overlap,maxt);
        
        binspktm=bst(2,1:numel(dat(i).TT));
        sbst(i).binspktm=binspktm;
        sbst(i).offset=offset;
        sbst(i).fn=FILENAME;
        ff=figure;
        subplot(5,1,1:2)
        plot(oST(1:end-1),1./diff(spktimes),'ko','MarkerFaceColor','k','MarkerSize',4);
        hold all
        %plot(dat(i).TT-offset,binspktm./(BinSize/1000),'r-');
       %plot(dat(i).TT(~isnan(dat(i).WBF))-offset,binspktm(~isnan(dat(i).WBF))./(BinSize/1000),'g-')
        xlabel('Time (s)')
        ylabel('Inst. Freq. (Hz)');
        title([FILENAME,' DLM-WBF trace']);
        axis([0 90 0 50])
        axis([0 60 0 50])
        subplot(5,1,3:5)
        imagesc(dat(i).TT-offset,F,10*log10(dat(i).nPP));
        axis('xy');
        axis([0 90 100 300]);
        axis([0 60 100 250]);
        xlabel('Time (s)')
        ylabel('Frequency (Hz)')
        c=colorbar('location','EastOutside');
        ylabel(c,'Power (dB)');
        caxis([-55 -35]);
        cax=axis;
        %cax(1)=0;
        %cax(2)=90;
        cax(3)=0;
        cax(4)=50;
        subplot(5,1,1:2)
        axis(cax);
        colorbar
        colormap(flipud(gray));
        %         gg=figure;
        %         patch(log10(binspktm./(BinSize/1000)),dat(i).WBF,dat(i).TT-offset,'facecolor','none','edgecolor','interp','LineWidth',1);
        %         xlabel ('log_{10}(bin spike count) (Hz)')
        %         ylabel('WBF (Hz)')
        %         title([FILENAME,' DLM-WBF trace']);
        hold all
        
        %axis([0 1.5 150 250]);
        figure(hh)
        hold all
        scatter(dat(i).TT-offset,i*ones(size(dat(i).WBF)),10,dat(i).WBF,'s','filled');
        
    catch
        ['error with ',num2str(i)]
        sbst(i).binspktm=nan;
        sbst(i).offset=nan;
    end
    
end
delete(wh)
MICFILE;

MICFILE;

try
    sstats=APplotWBFcumudist(flynum,dat,spt);
catch
    sstats=nan
end
export2wsdlg({'WBF data';'Binned Spike Time Data';'fly #'; 'Steady State flight Stats';'spike times';'maxt';'offV'},{'dat';'sbst';'flynum';'sstats';'spktms';'maxt';'offV'},{dat;sbst;flynum;sstats;spt;mxt;offV},'Export Data to Workspace')




% --------------------------------------------------------------------
function LED_ISI_CV_Traj_menu_Callback(hObject, eventdata, handles)
% hObject    handle to LED_ISI_CV_Traj_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
svsg=questdlg('Do you want to plot for a single file (vs time) or for the group?','Selection Type','Single','Group','Single');
prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
while isempty(str2num(prtcl{1}))
    prtcl=inputdlg([{'Filter Type (1/2 (arith vs geom))'};{'Enter Filter Size (spikes)'};{'Enter Root (1=Fano, 2=CV)'}],'Phase Reset Time', 1,[{'2'};{'6'};{'2'}]);
end

spkrange=inputdlg({'Min spike time';'Max spike time'},'Analysis Range',1,{'0';'100'});
spkstarttime=str2num(spkrange{1});
spkendtime=str2num(spkrange{2});



    
% %for quick complete defaults <comment out as necessary
% svsg='Group';
% prtcl{1}='2';
% prtcl{2}='6';
% prtcl{3}='2';
if strcmp(svsg,'Single')
    FILENAME=handles.GROUPFILE{get(handles.group_file_list,'Value')};
    groupname=handles.GROUPPOOL(get(handles.group_list,'Value')).name{1};
    
    svpdf=questdlg('Do you want to save figures as a pdf?');
    
    if strcmp(svpdf,'Yes')
        [TGTFILE,TGTPATH]=uiputfile(['*.pdf'],'Save Inst FF Set As',[groupname,' ECS_ISI_CV_plot.pdf']);
    end
    if numel(get(handles.group_file_list,'Value'))==1
        
        
        ISICV(1).data=APplotFanoPhase(FILENAME,3,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1,spkstarttime,spkendtime);
        ISICV(1).params=[1 2 6];
        %idx=APclusterISIFanoData(dat,1);
    end
    load('ECScmap.mat');
    cmap=ECScmap;
    if numel(get(handles.group_file_list,'Value'))>1
        vals=get(handles.group_file_list,'Value');
        for i=1:numel(vals)
            FILENAME=handles.GROUPFILE{vals(i)};
            ISICV(i).data=APplotFanoPhase(FILENAME,3,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),1,spkstarttime,spkendtime);
             colormap(cmap)
            colorbar;
            caxis([0 90])
            ISICV(i).params=[1 2 6];
            h=gcf;
            if strcmp(svpdf,'Yes')
                if i==1
                    print('-dpsc2','-r600',h,'SPKTEST11.ps')
                end
                if i~=1
                    print('-dpsc2','-r600','-append',h,'SPKTEST11.ps')
                end
            end
        end
        if strcmp(svpdf,'Yes')
            ps2pdf('psfile','SPKTEST11.ps','pdffile',[TGTPATH,TGTFILE],'gspapersize','letter');
            delete('SPKTEST11.ps');
            msgbox('PDF Creation Complete');
        end
    end
    export2wsdlg({'ISICV data struct'},{'ISICV'},{ISICV})
end
if strcmp(svsg,'Group')
    AutoSave=questdlg('Do you want to autosave?');
    %AutoSave='Yes';
    gv=get(handles.group_list,'Value');
    groupname=handles.GROUPPOOL(get(handles.group_list,'Value')).name{1};
    hh=waitbar(0,['0',' of ','0',' Traces']);
    gg=figure;
    ff=figure;
    ee=figure;
    cmp=colormap(jet(numel(handles.GROUPFILE)));
    load('ECScmap.mat');
    cmap=ECScmap;
    overalldat=zeros(0,6);
    [a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
    FLYNUMXL=c;
    clear a
    clear b
    clear c
%     colormapeditor
%     cmap=colormap;
    
    for i=1:numel(handles.GROUPFILE)
        try
            waitbar(i/numel(handles.GROUPFILE),hh, [num2str(i),' of ',num2str(numel(handles.GROUPFILE)),' Traces']);
            FILENAME=handles.GROUPFILE{i};
            fanoplot(i).FILENAME=FILENAME;
            fanoplot(i).UFN=APgetflynum(FILENAME,FLYNUMXL);
            fanoplot(i).data=APplotFanoPhase(FILENAME,3,str2num(prtcl{3}),str2num(prtcl{2}),str2num(prtcl{1}),0,spkstarttime,spkendtime);
            fanoplot(i).data(end+1,:)=nan(1,6);
            overalldat=cat(1,overalldat,fanoplot(i).data);
            figure(ff)
            hold all
            %        plot(fanoplot(i).dat(:,1),fanoplot(i).dat(:,2),'k.');
            plot(fanoplot(i).data(:,1),10.^fanoplot(i).data(:,3),'.','Color',cmp(i,:));
            hold off
            ax=axis;
            ax(1)=0;
            ax(2)=100;
            axis(ax);
            figure(gg)
            subplot(4,1,1:3)
            hold all
            %        scatter(fanoplot(i).dat(:,3),fanoplot(i).dat(:,4),10,fanoplot(i).dat(:,1),'filled');
            %         plot(fanoplot(i).dat(:,3),fanoplot(i).dat(:,4),'-','Color',cmp(i,:));
            patch(fanoplot(i).data(:,3),fanoplot(i).data(:,4),fanoplot(i).data(:,1),'facecolor','none','edgecolor','interp','LineWidth',2);
            axis([0 2.5 -2.5 2.5])
            colormap(cmap)
            colorbar;
            caxis([0 90])
            hold off
            subplot(4,1,4)
            hold all
            plot(fanoplot(i).data(:,1),i*ones(1,numel(fanoplot(i).data(:,1))),'k+')
            axis([0 100 0 i+1])
            hold off
            %        figure(ee)
            %
            %        edges{1}=[0:0.05:2.5];
            %        edges{2}=[-2.5:0.05:2.5];
            %        h=hist3(fanoplot{i}(:,3:4),edges);
            %        contour(edges{1},edges{2},h')
            
        catch
            ['error with ',num2str(i)]
            fanoplot(i).data=nan;
        end
    end
    delete(hh);
    DTWok='Yes';
    while strcmp(DTWok,'Yes')
        APDTWBaryAverage(fanoplot,40);
        DTWok=questdlg('Re-run DTW?')
    end
    figure(gg)
    
    subplot(4,1,1:3)
    title(handles.GROUPPOOL(gv).name);
    xlabel('log(1/ISI) (Hz)');
    ylabel('log(CV) (Hz)');
    colormap(cmap)
    colorbar;
    caxis([0 90])
    subplot(4,1,4)
    xlabel('time(s)')
    figure(ff)
    title(handles.GROUPPOOL(gv).name);
    xlabel('Time (s)')
    ylabel('Filtered Firing Frequency (Hz)');
    colorbar
%     edges{1}=[0:0.05:2.5];
%     edges{2}=[-2.5:0.05:2.5];
%     figure;
%     h=hist3(overalldat(:,3:4),edges);
%     sc=nansum(nansum(h));
%     contour(edges{1},edges{2},log10(h./sc)')
%     caxis([-2.5 -1])
%     yd=APISICVoverallvecfield(overalldat,edges);
%     hold all
%     quiver(yd(:,1),yd(:,2),yd(:,3),yd(:,4))
%     
    if strcmp(AutoSave,'Yes')
        sws='Yes';
        save(['R:\BioDataLab\Atulya\Physiology Summary and Organization\ISI CV Datasets\',groupname,'.mat'],'fanoplot')
    else
        sws=questdlg('Do you want to export ISI CV data to .mat file?');
        
        if strcmp(sws,'Yes')
            [FN PN]=uiputfile('*.mat','Save ISI CV data',['R:\BioDataLab\Atulya\Physiology Summary and Organization\ISI CV Datasets\',groupname,'.mat']);
            save([PN,FN],'fanoplot')
        end
    end
    export2wsdlg({'ISICV data struct'},{'ISI_CV'},{fanoplot})
end