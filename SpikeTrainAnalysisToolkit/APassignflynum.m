function varargout = APassignflynum(varargin)
% APASSIGNFLYNUM MATLAB code for APassignflynum.fig
%      APASSIGNFLYNUM, by itself, creates a new APASSIGNFLYNUM or raises the existing
%      singleton*.
%
%      H = APASSIGNFLYNUM returns the handle to a new APASSIGNFLYNUM or the handle to
%      the existing singleton*.
%
%      APASSIGNFLYNUM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APASSIGNFLYNUM.M with the given input arguments.
%
%      APASSIGNFLYNUM('Property','Value',...) creates a new APASSIGNFLYNUM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APassignflynum_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APassignflynum_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APassignflynum

% Last Modified by GUIDE v2.5 06-Mar-2013 09:31:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APassignflynum_OpeningFcn, ...
                   'gui_OutputFcn',  @APassignflynum_OutputFcn, ...
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


% --- Executes just before APassignflynum is made visible.
function APassignflynum_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APassignflynum (see VARARGIN)
handles.FILENAMES=cell(0,1);
if nargin>=4
    FN=varargin{1};
    handles.FILENAMES=union(handles.FILENAMES,FN,'stable');
    set(handles.File_List,'String',handles.FILENAMES);
end
handles.DataTable=cell(0,2);
try
%[FILE, PATH]=uigetfile('Z:\Lab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
%[a b c]=xlsread([PATH,'\',FILE]);
[a b c]=xlsread('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
handles.DataTable=c(2:end,:);
set(handles.uitable1,'Data',flipud(handles.DataTable));
set(handles.curr_fly_num,'String',num2str(max(a)+1));
catch
    warndlg('Default Table not found, manually create/find')
end
% Choose default command line output for APassignflynum
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APassignflynum wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APassignflynum_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in File_List.
function File_List_Callback(hObject, eventdata, handles)
% hObject    handle to File_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns File_List contents as cell array
%        contents{get(hObject,'Value')} returns selected item from File_List


% --- Executes during object creation, after setting all properties.
function File_List_CreateFcn(hObject, eventdata, handles)
% hObject    handle to File_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load_files_btn.
function Load_files_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Load_files_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FN=uigetfile('D:\Recordings Hold\*.txt','MultiSelect','on');
FILENAMES=strtok(FN,'.');
handles.FILENAMES=union(handles.FILENAMES,FILENAMES,'stable');
set(handles.File_List,'String',handles.FILENAMES);
guidata(hObject,handles);




% --- Executes on button press in Save_xls_btn.
function Save_xls_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Save_xls_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FILE,PATH]=uiputfile('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
xlswrite([PATH,'\',FILE],handles.DataTable,1,'A2');
xlswrite([PATH,'\',FILE],{'Rec Name','Fly Num'});
guidata(hObject,handles);

% --- Executes on button press in fly_num_btn.
function fly_num_btn_Callback(hObject, eventdata, handles)
% hObject    handle to fly_num_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
V=get(handles.File_List,'Value');
filestoadd=handles.FILENAMES(V);
afn=handles.DataTable(:,1);
fta=filestoadd(~ismember(filestoadd,afn));
toadd=[fta,num2cell(ones(size(fta))*str2num(get(handles.curr_fly_num,'String')))];

handles.DataTable=[handles.DataTable;toadd];
set(handles.uitable1,'Data',flipud(handles.DataTable));

cfn=str2num(get(handles.curr_fly_num,'String'));
if~isempty(fta)
    cfn=cfn+1;
    
end
set(handles.curr_fly_num,'String',num2str(cfn));
guidata(hObject,handles);




function curr_fly_num_Callback(hObject, eventdata, handles)
% hObject    handle to curr_fly_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of curr_fly_num as text
%        str2double(get(hObject,'String')) returns contents of curr_fly_num as a double


% --- Executes during object creation, after setting all properties.
function curr_fly_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to curr_fly_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Load_xls_btn.
function Load_xls_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Load_xls_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FILE, PATH]=uigetfile('R:\BioDataLab\Atulya\Physiology Summary and Organization\FlyNum Table.xlsx');
[a b c]=xlsread([PATH,'\',FILE]);
handles.DataTable=c(2:end,:);
set(handles.uitable1,'Data',flipud(handles.DataTable));
set(handles.curr_fly_num,'String',num2str(max(a)+1));
guidata(hObject,handles);

% --- Executes on key press with focus on File_List and none of its controls.
function File_List_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to File_List (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key,'a')
    fly_num_btn_Callback(hObject, eventdata, handles)
end

    

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


% --- Executes on button press in Update_DataTable_btn.
function Update_DataTable_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Update_DataTable_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DT=get(handles.uitable1,'Data');
handles.DataTable=flipud(DT);
guidata(hObject,handles);
