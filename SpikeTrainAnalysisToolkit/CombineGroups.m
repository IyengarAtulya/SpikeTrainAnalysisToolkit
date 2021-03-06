function varargout = CombineGroups(varargin)
% COMBINEGROUPS MATLAB code for CombineGroups.fig
%      COMBINEGROUPS, by itself, creates a new COMBINEGROUPS or raises the existing
%      singleton*.
%
%      H = COMBINEGROUPS returns the handle to a new COMBINEGROUPS or the handle to
%      the existing singleton*.
%
%      COMBINEGROUPS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMBINEGROUPS.M with the given input arguments.
%
%      COMBINEGROUPS('Property','Value',...) creates a new COMBINEGROUPS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CombineGroups_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CombineGroups_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CombineGroups

% Last Modified by GUIDE v2.5 25-Sep-2011 23:15:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CombineGroups_OpeningFcn, ...
                   'gui_OutputFcn',  @CombineGroups_OutputFcn, ...
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


% --- Executes just before CombineGroups is made visible.
function CombineGroups_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CombineGroups (see VARARGIN)
handles.GROUPNAMES=varargin{1};
set(handles.listbox1,'String',handles.GROUPNAMES);
% Choose default command line output for CombineGroups
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CombineGroups wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CombineGroups_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
close(gcf);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Done_btn.
function Done_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Done_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output=get(handles.listbox1,'Value');
guidata(hObject,handles);
uiresume;
