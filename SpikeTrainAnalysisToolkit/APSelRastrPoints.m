function varargout = APSelRastrPoints(varargin)
% APSELRASTRPOINTS MATLAB code for APSelRastrPoints.fig
%      APSELRASTRPOINTS, by itself, creates a new APSELRASTRPOINTS or raises the existing
%      singleton*.
%
%      H = APSELRASTRPOINTS returns the handle to a new APSELRASTRPOINTS or the handle to
%      the existing singleton*.
%
%      APSELRASTRPOINTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APSELRASTRPOINTS.M with the given input arguments.
%
%      APSELRASTRPOINTS('Property','Value',...) creates a new APSELRASTRPOINTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APSelRastrPoints_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APSelRastrPoints_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APSelRastrPoints

% Last Modified by GUIDE v2.5 26-Sep-2011 10:21:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APSelRastrPoints_OpeningFcn, ...
                   'gui_OutputFcn',  @APSelRastrPoints_OutputFcn, ...
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


% --- Executes just before APSelRastrPoints is made visible.
function APSelRastrPoints_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APSelRastrPoints (see VARARGIN)

% Choose default command line output for APSelRastrPoints
handles.output = hObject;
handles.FILEPOOL=varargin{1};
ntraces=size(handles.FILEPOOL,1);
axes(handles.axes1);
hold all
mxt=0;
for i=1:ntraces
    try
       
        [a b c]=xlsread(handles.FILEPOOL{i});
        ST=a(3:end,1);
        if mxt<max(ST)
            mxt=nanmax(ST);
        end
        plot(ST,i*ones(1,size(ST,1)),'k.');
    catch
        ['error to: ',num2str(i)];
    end
end
axis([-.1*mxt, 1.1*mxt, 0, ntraces+2]);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APSelRastrPoints wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APSelRastrPoints_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output=handles.datasel;
% Get default command line output from handles structure
varargout{1} = handles.output;
close gcf


% --- Executes on button press in select_points_btn.
function select_points_btn_Callback(hObject, eventdata, handles)
% hObject    handle to select_points_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pl xs ys]=selectdata('SelectionMode','Rect');
for i=1:size(ys,1)
    yv(i)=mean(ys{i});
end
handles.datasel=yv(~isnan(yv));
guidata(hObject,handles);
