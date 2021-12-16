function varargout = APplottracAddFeat(varargin)
% APPLOTTRACADDFEAT MATLAB code for APplottracAddFeat.fig
%      APPLOTTRACADDFEAT, by itself, creates a new APPLOTTRACADDFEAT or raises the existing
%      singleton*.
%
%      H = APPLOTTRACADDFEAT returns the handle to a new APPLOTTRACADDFEAT or the handle to
%      the existing singleton*.
%
%      APPLOTTRACADDFEAT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPLOTTRACADDFEAT.M with the given input arguments.
%
%      APPLOTTRACADDFEAT('Property','Value',...) creates a new APPLOTTRACADDFEAT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APplottracAddFeat_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APplottracAddFeat_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APplottracAddFeat

% Last Modified by GUIDE v2.5 08-May-2017 11:44:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APplottracAddFeat_OpeningFcn, ...
                   'gui_OutputFcn',  @APplottracAddFeat_OutputFcn, ...
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


% --- Executes just before APplottracAddFeat is made visible.
function APplottracAddFeat_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APplottracAddFeat (see VARARGIN)

% Choose default command line output for APplottracAddFeat
handles.output = hObject;
set(handles.Channel_menu,'String',[{'Ch. 1'};{'Ch. 2'};{'Ch. 3'}])
handles.COLORS={'black';'blue';'green';'red';'cyan';'magenta';'yellow'};
set(handles.Color_menu,'String',handles.COLORS);
if nargin>3
    infeat=varargin{1};
    try
        set(handles.Xmin_edit,'String',num2str(infeat.Xmin));
    catch
        set(handles.Xmin_edit,'String',num2str(0));
    end
    try
        set(handles.Xmax_edit,'String',num2str(infeat.Xmax));
    catch
        set(handles.Xmax_edit,'String',num2str(30));
    end
    try
        set(handles.feat_name_edit,'String',infeat.Name);
    catch
        set(handles.feat_name_edit,'String','');
    end
    try
        set(handles.Channel_menu,'Value',infeat.Channel);
    catch
        set(handles.Channel_menu,'Value',1);
    end
    try
        set(handles.Color_menu,'Value',find(strcmp(infeat.Color,handles.COLORS),1,'first'));
    catch
        set(handles.Color_menu,'Value',2);
    end 
else
    set(handles.Xmin_edit,'String',num2str(0));
    set(handles.Xmax_edit,'String',num2str(30));
    set(handles.feat_name_edit,'String','');
    set(handles.Channel_menu,'Value',1);
    set(handles.Color_menu,'Value',2);   
end

handles.output=1;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APplottracAddFeat wait for user response (see UIRESUME)
 uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APplottracAddFeat_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
delete(gcf);
varargout{1} = handles.output;





function Xmin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Xmin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xmin_edit as text
%        str2double(get(hObject,'String')) returns contents of Xmin_edit as a double


% --- Executes during object creation, after setting all properties.
function Xmin_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xmin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Xmax_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Xmax_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xmax_edit as text
%        str2double(get(hObject,'String')) returns contents of Xmax_edit as a double


% --- Executes during object creation, after setting all properties.
function Xmax_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xmax_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function feat_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to feat_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of feat_name_edit as text
%        str2double(get(hObject,'String')) returns contents of feat_name_edit as a double


% --- Executes during object creation, after setting all properties.
function feat_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to feat_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Channel_menu.
function Channel_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Channel_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Channel_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Channel_menu


% --- Executes during object creation, after setting all properties.
function Channel_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Channel_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Color_menu.
function Color_menu_Callback(hObject, eventdata, handles)
% hObject    handle to Color_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Color_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Color_menu


% --- Executes during object creation, after setting all properties.
function Color_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Color_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Ok_btn.
function Ok_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Ok_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

feat.Xmin=str2num(handles.Xmin_edit.String);
feat.Xmax=str2num(handles.Xmax_edit.String);
feat.Name=handles.feat_name_edit.String;
feat.Channel=handles.Channel_menu.Value;
feat.Color=handles.COLORS{handles.Color_menu.Value};
handles.output=feat;
guidata(hObject,handles);
uiresume(gcf);



% --- Executes on button press in cancel_btn.
function cancel_btn_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output=0;
APplottracAddFeat_OutputFcn(hObject, eventdata, handles) 