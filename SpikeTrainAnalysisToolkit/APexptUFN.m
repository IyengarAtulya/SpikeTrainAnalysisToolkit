function varargout = APexptUFN(varargin)
% APEXPTUFN MATLAB code for APexptUFN.fig
%      APEXPTUFN, by itself, creates a new APEXPTUFN or raises the existing
%      singleton*.
%
%      H = APEXPTUFN returns the handle to a new APEXPTUFN or the handle to
%      the existing singleton*.
%
%      APEXPTUFN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APEXPTUFN.M with the given input arguments.
%
%      APEXPTUFN('Property','Value',...) creates a new APEXPTUFN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APexptUFN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APexptUFN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APexptUFN

% Last Modified by GUIDE v2.5 22-Jan-2014 20:32:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APexptUFN_OpeningFcn, ...
                   'gui_OutputFcn',  @APexptUFN_OutputFcn, ...
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


% --- Executes just before APexptUFN is made visible.
function APexptUFN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APexptUFN (see VARARGIN)
% FILENAMES=handles.GROUPPOOL(get(handles.group_list,'Value')).files;
handles.recdir='D:\Recordings Hold';
handles.FILENAMES=varargin{1};
handles.GROUPNAME=varargin{2};
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
handles.FLYNUMXL=c;
for i=1:numel(handles.FILENAMES)
    try
        flynum(i)=APgetflynum(handles.FILENAMES{i},handles.FLYNUMXL);
    catch
        flynum(i)=0;
    end
end
for i=1:numel(handles.FILENAMES)
        [a b c]=fileparts(handles.FILENAMES{i});
        [t1 r]=strtok(b,'_');
        [t2 r]=strtok(r,'_');
        fname{i}=[handles.recdir,'\',t1,'_',t2,'.txt'];
end
info=APrecinfo(fname);
sinfo=struct2cell(info);
ages(1:size(sinfo,3))=sinfo(7,1,:);
sexes(1:size(sinfo,3))=sinfo(6,1,:);
A=num2cell(flynum);
B=num2cell(logical(zeros(numel(handles.FILENAMES),1)));
C=num2cell(logical(zeros(numel(handles.FILENAMES),1)));
handles.data=[A',handles.FILENAMES,B,C,ages',sexes'];
colformat={'numeric','char','logical','logical','numeric','char'};
colname={'UFN','FILENAME','Select','Select','Age','Sex'};

set(handles.uitable1,'Data',handles.data,'ColumnName',colname,'ColumnFormat',colformat)
set(handles.uitable1,'ColumnWidth',[{50}, {275}, {50},{50}, {50},{50}])
% Choose default command line output for APexptUFN
handles.output=handles.data;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APexptUFN wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APexptUFN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.output=handles.data;
% uiresume(handles.figure1);
% Get default command line output from handles structure
varargout{1} = handles.output;
close(handles.figure1);


% --- Executes on button press in expt_wkspc_btn.
function expt_wkspc_btn_Callback(hObject, eventdata, handles)
% hObject    handle to expt_wkspc_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
export2wsdlg({'UFN Set'},{['UFNvals']},{handles.data},'EXPORT UFN TO WORKSPACE');


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
% eventdata
handles.data(eventdata.Indices(1),eventdata.Indices(2))={(eventdata.EditData)};
% handles.data
set(handles.uitable1,'Data',handles.data);
guidata(hObject,handles);


% --- Executes on button press in done_btn.
function done_btn_Callback(hObject, eventdata, handles)
% hObject    handle to done_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output=handles.data;
guidata(hObject,handles)
uiresume(handles.figure1);
% close(handles.figure1);
