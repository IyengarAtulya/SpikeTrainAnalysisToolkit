function varargout = APshortlatencyanalysis(varargin)
% APSHORTLATENCYANALYSIS MATLAB code for APshortlatencyanalysis.fig
%      APSHORTLATENCYANALYSIS, by itself, creates a new APSHORTLATENCYANALYSIS or raises the existing
%      singleton*.
%
%      H = APSHORTLATENCYANALYSIS returns the handle to a new APSHORTLATENCYANALYSIS or the handle to
%      the existing singleton*.
%
%      APSHORTLATENCYANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APSHORTLATENCYANALYSIS.M with the given input arguments.
%
%      APSHORTLATENCYANALYSIS('Property','Value',...) creates a new APSHORTLATENCYANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APshortlatencyanalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APshortlatencyanalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APshortlatencyanalysis

% Last Modified by GUIDE v2.5 09-Feb-2013 16:13:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APshortlatencyanalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @APshortlatencyanalysis_OutputFcn, ...
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


% --- Executes just before APshortlatencyanalysis is made visible.
function APshortlatencyanalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APshortlatencyanalysis (see VARARGIN)

% Choose default command line output for APshortlatencyanalysis
handles.output = hObject;
handles.DATA=varargin{1};
handles.ch=varargin{2};
handles.dur=varargin{3};
if nargin>6
   handles.exfreq=varargin{4};
else
    handles.exfreq=0;
end
if nargin>7
   handles.isIC=varargin{5};
  handles.fDAT=varargin{6};
else
    handles.isIC=0;
end
dstim=diff(handles.DATA(:,5));
if handles.isIC>0
    dstim=diff(handles.DATA(:,5));
end
handles.st=find(dstim>3.5);
handles.Fs=mean(diff(handles.DATA(:,1)));
if handles.isIC>0
    
    handles.DATA(:,handles.ch)=handles.fDAT;
    
end
handles.stimtimes=handles.DATA(handles.st);
handles.npts=round(1/(handles.Fs*1000));
handles.Vt=zeros(numel(handles.st),(handles.dur-0.5)*handles.npts);
handles.offset=0.5;

set(handles.slider1,'Max',handles.dur);
set(handles.max_range_edit,'String',num2str(handles.dur));
set(handles.slider1,'Min',0)
set(handles.slider1,'Value',handles.offset);
set(handles.offset_edit,'String',num2str(handles.offset));
handles.plott=handles.offset+handles.Fs*1000:handles.Fs*1000:handles.dur;
for i=1:numel(handles.st)
    if handles.isIC>0
        handles.Vt(i,:)=handles.DATA(handles.st(i)+round(handles.npts*handles.offset)+1:handles.st(i)+handles.dur*handles.npts,handles.ch)';
    else
        
        handles.Vt(i,:)=handles.DATA(handles.st(i)+round(handles.npts*handles.offset)+1:handles.st(i)+handles.dur*handles.npts,handles.ch)';
    end
end

[handles.maxval,handles.idx]=max(handles.Vt');
axes(handles.axes1);
cmp=colormap(jet(numel(handles.stimtimes)));
set(gcf,'DefaultAxesColorOrder',cmp);
plot(handles.plott,handles.Vt');
hold all
handles.maxvplot=plot(handles.plott(handles.idx),handles.maxval,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',5);
colorbar;
handles.cax=axis;
handles.cax(1)=0;
axis(handles.cax);
handles.defax=axis;
handles.offsetline=line([handles.offset handles.offset],[handles.cax(3),handles.cax(4)],'LineStyle','--');
hold off

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APshortlatencyanalysis wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APshortlatencyanalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)
% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in explore_btn.
function explore_btn_Callback(hObject, eventdata, handles)
% hObject    handle to explore_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[sx sy]=ginput(1);
xvs=handles.plott(handles.idx);
yvs=handles.maxval;
dv=sqrt((xvs-sx).^2+(yvs-sy).^2);
[c ix]=min(dv);

trace_num=ix;
h=figure;
plot(handles.plott,handles.Vt(trace_num,:)','k');
hold all
plot(handles.plott(handles.idx(trace_num)),handles.maxval(trace_num),'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',5);
axis(handles.defax);

figure(handles.figure1);



% --- Executes on button press in selectdata_btn.
function selectdata_btn_Callback(hObject, eventdata, handles)
% hObject    handle to selectdata_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[p x y]=selectdata;
handles.output=zeros(numel(handles.st),3);
selpts=p{2};
latency=x{2};
amp=y{2};
handles.output(selpts)=1;
for i=1:numel(selpts)
    handles.output(selpts(i),2)=latency(i);
    handles.output(selpts(i),3)=amp(i);
end

% FF(1:10)=20;
% FF(11:20)=40;
% FF(21:30)=60;
% FF(31:40)=80;
% FF(41:50)=100;
% FF(51:60)=120;
% FF(61:70)=140;
% FF(71:80)=160;
% FF(81:90)=180;
% FF(91:100)=200;
% FF(101:110)=200;
% FF(111:120)=160;
% FF(121:130)=120;
% FF(131:140)=80;
% FF(141:150)=40;
% GG(1:10)=1;
% GG(11:20)=2;
% GG(21:30)=3;
% GG(31:40)=4;
% GG(41:50)=5;
% GG(51:60)=6;
% GG(61:70)=7;
% GG(71:80)=8;
% GG(81:90)=9;
% GG(91:100)=10;
% GG(101:110)=10;
% GG(111:120)=11;
% GG(121:130)=12;
% GG(131:140)=13;
% GG(141:150)=14;
% FFgrps=[20 40 60 80 100 120 140 160 180 200];
% GGrps=[20 40 60 80 100 120 140 160 180 200 160 120 80 40];
% gs=grpstats(handles.output,FF);
% gs2=grpstats(handles.output,GG);
% figure
% plot(FFgrps,gs,'k*-');
% figure
% plot(GGrps,gs2,'k*-');
guidata(hObject,handles);
% uiresume(gcf);


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.offset=get(hObject,'Value');
if handles.offset<0.55
    handles.offset=0.55;
end

    
set(handles.offset_edit,'String',num2str(handles.offset));
delete(handles.offsetline);
delete(handles.maxvplot);
clear handles.offsetline;
oid=round(handles.offset*20);
if oid>size(handles.Vt,2)
    oid=size(handles.Vt,2);
end
axes(handles.axes1);
hold all
[handles.maxval,handles.idx]=max(handles.Vt(:,oid-10:end)');
handles.maxvplot=plot(handles.plott(handles.idx+oid-11),handles.maxval,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',5);
handles.offsetline=line([handles.offset handles.offset],[handles.cax(3),handles.cax(4)],'LineStyle','--');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function offset_edit_Callback(hObject, eventdata, handles)
% hObject    handle to offset_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of offset_edit as text
%        str2double(get(hObject,'String')) returns contents of offset_edit as a double
offset=str2num(get(hObject,'String'));
if ~isempty(offset)
    if offset>=1
        if offset<=handles.dur
            handles.offset=offset;
            set(handles.slider1,'Value',handles.offset);
            delete(handles.offsetline);
            delete(handles.maxvplot);
            clear handles.offsetline;
            axes(handles.axes1);
            oid=round(handles.offset*20-19);
            if oid>size(handles.Vt,1)
                oid=size(handles.Vt,1);
            end
            axes(handles.axes1);
            hold all
            [handles.maxval,handles.idx]=max(handles.Vt(:,oid:end)');
            handles.maxvplot=plot(handles.plott(handles.idx+oid-1),handles.maxval,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',5);
            handles.offsetline=line([handles.offset handles.offset],[handles.cax(3),handles.cax(4)],'LineStyle','--');
        end
    end
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function offset_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to offset_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function min_range_edit_Callback(hObject, eventdata, handles)
% hObject    handle to min_range_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_range_edit as text
%        str2double(get(hObject,'String')) returns contents of min_range_edit as a double


% --- Executes during object creation, after setting all properties.
function min_range_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_range_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_range_edit_Callback(hObject, eventdata, handles)
% hObject    handle to max_range_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_range_edit as text
%        str2double(get(hObject,'String')) returns contents of max_range_edit as a double
nmx=str2num(get(hObject,'String'));
if ~isempty(nmx)
    if nmx>0
        handles.dur=nmx;
    end
end
set(handles.slider1,'Max',handles.dur);
set(hObject,'String',num2str(handles.dur));
handles.plott=handles.offset+handles.Fs*1000:handles.Fs*1000:handles.dur;
clear handles.Vt
for i=1:numel(handles.st)
    Vt(i,:)=handles.DATA(handles.st(i)+handles.npts+1:handles.st(i)+handles.dur*handles.npts,handles.ch)';
end
handles.Vt=Vt;
[handles.maxval,handles.idx]=max(handles.Vt');
axes(handles.axes1);
cmp=colormap(jet(numel(handles.stimtimes)));
set(gcf,'DefaultAxesColorOrder',cmp);
plot(handles.plott,handles.Vt');
hold all
handles.maxvplot=plot(handles.plott(handles.idx),handles.maxval,'o','MarkerFaceColor','k','MarkerEdgeColor','k','MarkerSize',5);
colorbar;
handles.cax=axis;
handles.cax(1)=1;
axis(handles.cax);
handles.defax=axis;
handles.offsetline=line([handles.offset handles.offset],[handles.cax(3),handles.cax(4)],'LineStyle','--');
hold off
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function max_range_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_range_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
