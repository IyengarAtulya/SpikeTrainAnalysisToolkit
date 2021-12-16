function varargout = APrecmanager(varargin)
% APRECMANAGER MATLAB code for APrecmanager.fig
%      APRECMANAGER, by itself, creates a new APRECMANAGER or raises the existing
%      singleton*.
%
%      H = APRECMANAGER returns the handle to a new APRECMANAGER or the handle to
%      the existing singleton*.
%
%      APRECMANAGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APRECMANAGER.M with the given input arguments.
%
%      APRECMANAGER('Property','Value',...) creates a new APRECMANAGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APrecmanager_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APrecmanager_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APrecmanager

% Last Modified by GUIDE v2.5 17-Oct-2013 14:08:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APrecmanager_OpeningFcn, ...
                   'gui_OutputFcn',  @APrecmanager_OutputFcn, ...
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


% --- Executes just before APrecmanager is made visible.
function APrecmanager_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APrecmanager (see VARARGIN)
set(handles.seltype_menu,'String',{'All';'All Un-Analyzed';'Selection';'Un-Analyzed Selection'});
handles.FILEPOOL=cell(0,1);
handles.ANAPOOL=cell(0,1);
set(handles.filepool_list,'String',handles.FILEPOOL);
set(handles.anapool_list,'String',handles.ANAPOOL);
%handles.RAWDATPATH is for Dell i5 comp
handles.RAWDATPATH='D:\Recordings Hold';
handles.TABLEPATH='R:\BioDataLab\Atulya\Physiology Summary and Organization';
handles.RECTABLENAME='R:\BioDataLab\Atulya\Physiology Summary and Organization\Recording Table.xlsx';
handles.SPKTMANASUM='R:\BioDataLab\Atulya\Physiology Summary and Organization\SpikeTimeAnalysis Table.xlsx';
handles.ICSPKTMANASUM='R:\BioDataLab\Atulya\Physiology Summary and Organization\IC SpikeTimeAnalysis Table.xlsx';
handles.DO_NOT_ANALYZE_LIST='R:\BioDataLab\Atulya\Physiology Summary and Organization\do_not_analyze.xlsx';
set(handles.text1,'String',[num2str(size(handles.FILEPOOL,1)),' items']);
set(handles.text2,'String',[num2str(size(handles.ANAPOOL,1)),' items']);
% Choose default command line output for APrecmanager
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APrecmanager wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APrecmanager_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in filepool_list.
function filepool_list_Callback(hObject, eventdata, handles)
% hObject    handle to filepool_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filepool_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filepool_list


% --- Executes during object creation, after setting all properties.
function filepool_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filepool_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in seltype_menu.
function seltype_menu_Callback(hObject, eventdata, handles)
% hObject    handle to seltype_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns seltype_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from seltype_menu


% --- Executes during object creation, after setting all properties.
function seltype_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seltype_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in anapool_list.
function anapool_list_Callback(hObject, eventdata, handles)
% hObject    handle to anapool_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns anapool_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from anapool_list


% --- Executes during object creation, after setting all properties.
function anapool_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anapool_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addtoana_btn.
function addtoana_btn_Callback(hObject, eventdata, handles)
% hObject    handle to addtoana_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.seltype_menu,'Value')==1
    handles.ANAPOOL=union(handles.ANAPOOL,handles.FILEPOOL);
    set(handles.anapool_list,'String',handles.ANAPOOL);
    
end
if get(handles.seltype_menu,'Value')==3
    handles.ANAPOOL=union(handles.ANAPOOL,handles.FILEPOOL(get(handles.filepool_list,'Value')));
    set(handles.anapool_list,'String',handles.ANAPOOL);
end
if get(handles.seltype_menu,'Value')==2
    rig=questdlg('Flight or Intracellular Recording?','Rig Identity','Flight','Intracellular','Flight')
    if strcmp(rig,'Intracellular')
        [n t r]=xlsread(handles.ICSPKTMANASUM,'A2:A32000');
    end
    if strcmp(rig,'Flight')
        [n t r]=xlsread(handles.SPKTMANASUM,'A2:A32000');
    end
    analyzed=t;
    for i=1:numel(handles.FILEPOOL)
       [a b c]=fileparts(handles.FILEPOOL{i});
        FP{i}=b;
    end
    [x y z]=xlsread(handles.DO_NOT_ANALYZE_LIST);
    cPROANA=handles.FILEPOOL(~ismember(FP,analyzed));
    PROANA=cPROANA(~ismember(cPROANA,y));
    handles.ANAPOOL=union(handles.ANAPOOL,PROANA);
end
set(handles.anapool_list,'String',handles.ANAPOOL);
set(handles.anapool_list,'Value',1);
set(handles.text2,'String',[num2str(numel(handles.ANAPOOL)),' items']);
guidata(hObject,handles)

% --- Executes on button press in addfiles_btn.
function addfiles_btn_Callback(hObject, eventdata, handles)
% hObject    handle to addfiles_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FILE PATH IDX]=uigetfile('*.txt','Please Select File(s) to add',handles.RAWDATPATH,'MultiSelect','on');
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
    set(handles.filepool_list,'String',handles.FILEPOOL);
    set(handles.filepool_list,'Value',1);
end
set(handles.text1,'String',[num2str(size(handles.FILEPOOL,2)),' items']);
guidata(hObject,handles);

    

% --- Executes on button press in analyze_btn.
function analyze_btn_Callback(hObject, eventdata, handles)
% hObject    handle to analyze_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i=1;
filestoanalyze=cell(0,1);

while i<numel(handles.ANAPOOL)+1
    try
        tic
    detout=APhysSpkDet({handles.ANAPOOL{i}},i);
    toc
    succ=detout.succ;
    STfiles=detout.createdSTfiles;
    filestoanalyze=union(STfiles,filestoanalyze);
    catch
        succ=0;
    end
    if succ==0
        RESP=questdlg({['Warning: ', handles.ANAPOOL{i},' was not analyzed properly.'];['Do you want to retry?']});
        if strcmp(RESP,'Yes')
            i=i-1;
        end
    end 
    i=i+1;
   
end
for i=1:numel(handles.ANAPOOL)
    [p FN{i} e]=fileparts(handles.ANAPOOL{i});
end
APassignflynum(FN);



% --- Executes on button press in addfolder_btn.
function addfolder_btn_Callback(hObject, eventdata, handles)
% hObject    handle to addfolder_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PATH=uigetdir(handles.RAWDATPATH,'Select Folder to Analyze');
if ~isnumeric(PATH)
    FILES=findfiles('txt',PATH);
    handles.FILEPOOL=union(handles.FILEPOOL,FILES);
    set(handles.filepool_list,'String',handles.FILEPOOL);
    set(handles.filepool_list,'Value',1);
end
set(handles.text1,'String',[num2str(numel(handles.FILEPOOL)),' items']);
guidata(hObject,handles);


% --- Executes on button press in removefiles_btn.
function removefiles_btn_Callback(hObject, eventdata, handles)
% hObject    handle to removefiles_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
remvals=get(handles.filepool_list,'Value');
stvals=[1:numel(handles.FILEPOOL)];
kepvals=stvals(~ismember(stvals,remvals));
FPOOL=cell(1,size(kepvals,2));
FPOOL=handles.FILEPOOL(kepvals);
clear handles.FILEPOOL
handles.FILEPOOL=FPOOL;
set(handles.filepool_list,'String',handles.FILEPOOL);
if max(get(handles.filepool_list,'Value'))> size(handles.FILEPOOL,2)
    set(handles.filepool_list,'Value',size(handles.FILEPOOL,2));
end
set(handles.text1,'String',[num2str(numel(handles.FILEPOOL)),' items']);
guidata(hObject,handles);


% --- Executes on button press in rmvitem_btn.
function rmvitem_btn_Callback(hObject, eventdata, handles)
% hObject    handle to rmvitem_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
remvals=get(handles.anapool_list,'Value');
stvals=[1:numel(handles.ANAPOOL)];
kepvals=stvals(~ismember(stvals,remvals));
APOOL=cell(1,size(kepvals,2));
APOOL=handles.ANAPOOL(kepvals);
clear handles.ANAPOOL
handles.ANAPOOL=APOOL;
set(handles.anapool_list,'String',handles.ANAPOOL);
if max(get(handles.anapool_list,'Value'))> size(handles.ANAPOOL,2)
    set(handles.anapool_list,'Value',size(handles.ANAPOOL,2));
end
set(handles.text2,'String',[num2str(numel(handles.ANAPOOL)),' items']);
guidata(hObject,handles);


% --------------------------------------------------------------------
function File_menu_Callback(hObject, eventdata, handles)
% hObject    handle to File_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function About_menu_Callback(hObject, eventdata, handles)
% hObject    handle to About_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Run_Organizer_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Run_Organizer_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=msgbox(['Finding Files'], 'Organizer');
A=APhysOrgnizr2;
msgbox(['Found ', num2str(size(A,2)),' Files'], 'Organizer','replace');


% --------------------------------------------------------------------
function Close_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Close_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in plot_trac_btn.
function plot_trac_btn_Callback(hObject, eventdata, handles)
% hObject    handle to plot_trac_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
APhysPlotTraces(handles.ANAPOOL)


% --- Executes on button press in add_list_btn.
function add_list_btn_Callback(hObject, eventdata, handles)
% hObject    handle to add_list_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pFILE PATH]=uigetfile('*.txt','Please Select File','Z:\Lab\Atulya\Physiology Summary and Organization\Lists','MultiSelect','on');
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
        [rname, r]=strtok(b,'_');
        [recn,r]=strtok(r,'_');
        recfilename{j}=[handles.RAWDATPATH,'\',rname,'_',recn,'.txt'];
        
    end
    clear nfiles;
    handles.ANAPOOL=union(handles.ANAPOOL,recfilename);
    
end

set(handles.anapool_list,'String',handles.ANAPOOL);
set(handles.anapool_list,'Value',1);
set(handles.text2,'String',[num2str(size(handles.ANAPOOL,2)),' items']);
guidata(hObject,handles)


% --- Executes on button press in DoNotAnalyze_Btn.
function DoNotAnalyze_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to DoNotAnalyze_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    [A B C]=xlsread(handles.DO_NOT_ANALYZE_LIST);
catch
    msgbox([handles.DO_NOT_ANALYZE_LIST, ' does not exist will create new']);
    A=cell(1,0);
    B=cell(1,0);
end

RMVNAMES=handles.ANAPOOL(get(handles.anapool_list,'Value'));
WRMVNAMES=union(B,RMVNAMES);
xlswrite(handles.DO_NOT_ANALYZE_LIST,WRMVNAMES');
remvals=get(handles.anapool_list,'Value');
stvals=[1:size(handles.ANAPOOL,1)];
kepvals=stvals(~ismember(remvals,stvals));
APOOL=cell(1,size(kepvals,1));
APOOL=handles.ANAPOOL(kepvals);
clear handles.ANAPOOL
handles.ANAPOOL=APOOL;
set(handles.anapool_list,'String',handles.ANAPOOL);
if max(get(handles.anapool_list,'Value'))> size(handles.ANAPOOL,2)
    set(handles.anapool_list,'Value',size(handles.ANAPOOL,2));
end
set(handles.text2,'String',[num2str(size(handles.ANAPOOL,2)),' items']);
guidata(hObject,handles);
