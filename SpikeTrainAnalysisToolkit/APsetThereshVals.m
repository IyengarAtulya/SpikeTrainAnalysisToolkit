function varargout = APsetThereshVals(varargin)
% APSETTHERESHVALS MATLAB code for APsetThereshVals.fig
%      APSETTHERESHVALS, by itself, creates a new APSETTHERESHVALS or raises the existing
%      singleton*.
%
%      H = APSETTHERESHVALS returns the handle to a new APSETTHERESHVALS or the handle to
%      the existing singleton*.
%
%      APSETTHERESHVALS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APSETTHERESHVALS.M with the given input arguments.
%
%      APSETTHERESHVALS('Property','Value',...) creates a new APSETTHERESHVALS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APsetThereshVals_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APsetThereshVals_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APsetThereshVals

% Last Modified by GUIDE v2.5 27-Jul-2011 14:30:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APsetThereshVals_OpeningFcn, ...
                   'gui_OutputFcn',  @APsetThereshVals_OutputFcn, ...
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


% --- Executes just before APsetThereshVals is made visible.
function APsetThereshVals_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APsetThereshVals (see VARARGIN)

% Choose default command line output for APsetThereshVals
handles.output = hObject;
handles.rec=varargin{1};
handles.channels=varargin{2};
handles.ampthresh=varargin{3};
handles.origamp=handles.ampthresh;
handles.STthresh=varargin{4};
handles.origSTthresh=handles.STthresh;
set(handles.ST_thresh_edit,'String',num2str(handles.STthresh));
set(handles.amp_thresh_edit,'String',num2str(handles.ampthresh));
handles.xmin=0;
set(handles.xmin_edit,'String',num2str(handles.xmin));
handles.xmax=max(handles.rec(:,1));
set(handles.xmax_edit,'String',num2str(handles.xmax));
handles.ymin=min(handles.rec(:,2));
set(handles.ymin_edit,'String',num2str(handles.ymin));
handles.ymax=max(handles.rec(:,2));
set(handles.ymax_edit,'String',num2str(handles.ymax));
handles.time=handles.rec(:,1);
handles.ch1=handles.rec(:,2);
handles.ch2=handles.rec(:,3);
handles.ch3=handles.rec(:,4);
set(handles.ch1_chk,'Value',handles.channels(1));
set(handles.ch2_chk,'Value',handles.channels(2));
set(handles.ch3_chk,'Value',handles.channels(3));
for i=1:3
    if i==1
        COLOR='b';
        MARKER='c+';
    end
    if i==2
        COLOR='g';
        MARKER='k*';
    end
    if i==3
        COLOR='r';
        MARKER='mx';
    end 
    if handles.channels(i)==1
        plot(handles.rec(:,1),handles.rec(:,i+1),COLOR)
        a=APspkfltr(handles.time,handles.rec(:,i+1),handles.ampthresh);
        b=APspkfindr2(handles.time,a,handles.STthresh);
        hold all
        plot(b(:,1),b(:,2),MARKER)
        axis([handles.xmin,handles.xmax,handles.ymin,handles.ymax]);
    end
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APsetThereshVals wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APsetThereshVals_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
delete(gcf)
varargout{1} = handles.output;



function amp_thresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to amp_thresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp_thresh_edit as text
%        str2double(get(hObject,'String')) returns contents of amp_thresh_edit as a double
amp=str2num(get(hObject,'String'));
if~isempty(amp)
    if amp>0
        handles.ampthresh=amp;
    end
end
set(hObject,'String',num2str(handles.ampthresh));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function amp_thresh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amp_thresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ST_thresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ST_thresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ST_thresh_edit as text
%        str2double(get(hObject,'String')) returns contents of ST_thresh_edit as a double
ST=str2num(get(hObject,'String'));
if~isempty(ST)
    if ST>0
        handles.STthresh=ST;
    end
end
set(hObject,'String',num2str(handles.STthresh));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ST_thresh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ST_thresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmin_edit as text
%        str2double(get(hObject,'String')) returns contents of xmin_edit as a double
min=str2num(get(hObject,'String'));
if ~isempty(min)
    if min<handles.xmax
        handles.xmin=min;
    end
end
set(hObject,'String',num2str(handles.xmin));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function xmin_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmax_edit_Callback(hObject, eventdata, handles)
% hObject    handle to xmax_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmax_edit as text
%        str2double(get(hObject,'String')) returns contents of xmax_edit as a double
max=str2num(get(hObject,'String'));
if ~isempty(max)
    if max>handles.xmin
        handles.xmax=max;
    end
end
set(hObject,'String',num2str(handles.xmax));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function xmax_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xmax_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymin_edit as text
%        str2double(get(hObject,'String')) returns contents of ymin_edit as a double
min=str2num(get(hObject,'String'));
if ~isempty(min)
    if min<handles.ymax
        handles.ymin=min;
    end
end
set(hObject,'String',num2str(handles.ymin));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ymin_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymax_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ymax_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymax_edit as text
%        str2double(get(hObject,'String')) returns contents of ymax_edit as a double
max=str2num(get(hObject,'String'));
if ~isempty(max)
    if max>handles.ymin
        handles.ymax=max;
    end
end
set(hObject,'String',num2str(handles.ymax));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ymax_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ymax_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Plot_btn.
function Plot_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla
for i=1:3
    if i==1
        COLOR='b';
        MARKER='c+';
    end
    if i==2
        COLOR='g';
        MARKER='k*';
    end
    if i==3
        COLOR='r';
        MARKER='mx';
    end 
    if handles.channels(i)==1
        plot(handles.rec(:,1),handles.rec(:,i+1),COLOR)
        a=APspkfltr(handles.time,handles.rec(:,i+1),handles.ampthresh);
        b=APspkfindr2(handles.time,a,handles.STthresh);
        hold all
        plot(b(:,1),b(:,2),MARKER)
        axis([handles.xmin,handles.xmax,handles.ymin,handles.ymax]);
    end
end

% --- Executes on button press in ch1_chk.
function ch1_chk_Callback(hObject, eventdata, handles)
% hObject    handle to ch1_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch1_chk
handles.channels(1)=get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in ch2_chk.
function ch2_chk_Callback(hObject, eventdata, handles)
% hObject    handle to ch2_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch2_chk
handles.channels(2)=get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in ch3_chk.
function ch3_chk_Callback(hObject, eventdata, handles)
% hObject    handle to ch3_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch3_chk
handles.channels(3)=get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in keep_done_btn.
function keep_done_btn_Callback(hObject, eventdata, handles)
% hObject    handle to keep_done_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output=[handles.ampthresh, handles.STthresh];
guidata(hObject,handles);
uiresume;

% --- Executes on button press in discard_done_btn.
function discard_done_btn_Callback(hObject, eventdata, handles)
% hObject    handle to discard_done_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output=[0 0];
guidata(hObject,handles);
uiresume