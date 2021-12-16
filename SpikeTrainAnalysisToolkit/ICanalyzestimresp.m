function varargout = ICanalyzestimresp(varargin)
% ICANALYZESTIMRESP MATLAB code for ICanalyzestimresp.fig
%      ICANALYZESTIMRESP, by itself, creates a new ICANALYZESTIMRESP or raises the existing
%      singleton*.
%
%      H = ICANALYZESTIMRESP returns the handle to a new ICANALYZESTIMRESP or the handle to
%      the existing singleton*.
%
%      ICANALYZESTIMRESP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICANALYZESTIMRESP.M with the given input arguments.
%
%      ICANALYZESTIMRESP('Property','Value',...) creates a new ICANALYZESTIMRESP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ICanalyzestimresp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ICanalyzestimresp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ICanalyzestimresp

% Last Modified by GUIDE v2.5 26-Jan-2015 16:21:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ICanalyzestimresp_OpeningFcn, ...
                   'gui_OutputFcn',  @ICanalyzestimresp_OutputFcn, ...
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


% --- Executes just before ICanalyzestimresp is made visible.
function ICanalyzestimresp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ICanalyzestimresp (see VARARGIN)

% Choose default command line output for ICanalyzestimresp
handles.output = hObject;
handles.V=varargin{1};
handles.T=varargin{2};
handles.ST=varargin{3};
handles.TEMP=varargin{4};
handles.FILENAME=varargin{5};
set(handles.filename_txt,'String',handles.FILENAME);
handles.dST=[0;diff(handles.ST(:,1))];
handles.STEMP=handles.TEMP(handles.ST(:,3));
set(handles.xmin_edit,'String','-1')
set(handles.xmax_edit,'String','10')
set(handles.ymin_edit,'String','-100')
set(handles.ymax_edit,'String','20');
set(handles.AlignPreStimVal_chk,'Value',0);
set(handles.AutoY_Chk,'Value',0);
set(handles.clearax_chk,'Value',1);
handles.staticcolor=[0 0 0];
set(handles.ColorSelector_Btn,'ForegroundColor',handles.staticcolor);
CMapModes={'Static','Time','Stim No.','Temp','Stim Order'};
set(handles.ColorSelector_menu,'String',CMapModes);
handles.AvailCmaps={'jet','hsv','hot','cool','spring','summer','autumn','winter','gray','bone','copper','pink','lines','custom'};
set(handles.colormaps_menu,'String',handles.AvailCmaps);
handles.cmap='jet';


handles.gain=100;
for i=1:size(handles.ST,1)
    Sdisc{i}=sprintf('%g     %g     %g',handles.ST(i,1),handles.dST(i),handles.TEMP(handles.ST(i,3)));
end

set(handles.listbox2,'String',Sdisc);  %,handles.dST,handles.STEMP]))
set(handles.listbox2,'Value',[1:numel(Sdisc)]);
handles.fs=1/(handles.T(2)-handles.T(1));


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ICanalyzestimresp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ICanalyzestimresp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in SelectAll_btn.
function SelectAll_btn_Callback(hObject, eventdata, handles)
% hObject    handle to SelectAll_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.listbox2,'Value',[1:numel(get(handles.listbox2,'String'))]);
guidata(hObject,handles);


% --- Executes on button press in AlignPreStimVal_chk.
function AlignPreStimVal_chk_Callback(hObject, eventdata, handles)
% hObject    handle to AlignPreStimVal_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AlignPreStimVal_chk



function xmin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmin_edit as text
%        str2double(get(hObject,'String')) returns contents of xmin_edit as a double


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


% --- Executes on button press in Select_Traces_btn.
function Select_Traces_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Traces_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
[xs ys pl]=selectdata;
xs=flipud(xs);
ys=flipud(ys);
pl=flipud(pl);
sel=get(handles.listbox2,'Value');
for i=1:numel(sel)
    if ~isempty(pl{i})
        rsel(i)=1;
    else
        rsel(i)=0;
    end
end
nsel=sel(find(rsel));
set(handles.listbox2,'Value',nsel);
msgbox('Subset of traces selected');

guidata(hObject,handles);

% --- Executes on button press in ColorSelector_Btn.
function ColorSelector_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to ColorSelector_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.staticcolor=uisetcolor;
set(handles.ColorSelector_Btn,'ForegroundColor',handles.staticcolor);
guidata(hObject,handles);




function ymin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ymin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymin_edit as text
%        str2double(get(hObject,'String')) returns contents of ymin_edit as a double
set(handles.AutoY_Chk,'Value',0);
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
set(handles.AutoY_Chk,'Value',0);
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


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
handles.idx=eventdata.Indices(:,1);
guidata(hobject,handles);


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Plot_btn.
function Plot_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idx=get(handles.listbox2,'Value');
x=[str2num(get(handles.xmin_edit,'String')):(handles.T(2)-handles.T(1))*1000:str2num(get(handles.xmax_edit,'String'))];
if get(handles.Sep_Fig_Chk,'Value')
    handles.cf=figure;
end
if get(handles.clearax_chk,'Value')
    cla(gca);
end
hold all

for i=1:numel(idx)
    Vmin=handles.ST(idx(i),3)+(handles.fs/1000*str2num(get(handles.xmin_edit,'String')));
    Vmax=handles.ST(idx(i),3)+(handles.fs/1000*str2num(get(handles.xmax_edit,'String')));
    v(:,i)=handles.V(Vmin:Vmax)*handles.gain;
    
    if get(handles.AlignPreStimVal_chk,'Value')
        ost=mean(v(1:10,i));
        v(:,i)=v(:,i)-ost;
    end
    Temp(i)=handles.TEMP(handles.ST(idx(i),3));
    colormap(handles.cmap);
    plotcol='flat';
   switch get(handles.ColorSelector_menu,'Value');
        case 1
            plotcol=handles.staticcolor;
            Ci=1;
        case 2
            
            
            Ci=handles.ST(idx(i),1);
            caxis([0 round(max(handles.ST(:,1)/10))*10]);
            
            
        case 3
            
           
            Ci=idx(i);
            caxis([0 round(size(handles.ST,1)/10)*10]);
           
       case 4
        
            Ci=handles.TEMP(handles.ST(idx(i),3));
            caxis([0 50]);
            
       case 5
           
            Ci=i;
            caxis([0 numel(idx)]);
            
            
        otherwise
            plotcol=handles.staticcolor;
    end
    
    
    patch([x,nan],[v(:,i);nan],Ci*ones(1,size(v,1)+1),'EdgeColor',plotcol)
end
hold off
if get(handles.ColorSelector_menu,'Value')>1
    colorbar
end
if get(handles.AutoY_Chk,'Value')
    
    rx=round(x);
    vmx=max(v',[],1);
    vmn=min(v',[],1);
    amax=round(.12*max(vmx(find(x>0.6))))*10;
    amin=round(.12*min(vmn(find(x>0.6))))*10;
    if get(handles.AlignPreStimVal_chk,'Value')==1
        amin=-20;
    end
    set(handles.ymin_edit,'String',num2str(amin));
    set(handles.ymax_edit,'String',num2str(amax));
    
end
axis([str2num(get(handles.xmin_edit,'String')),str2num(get(handles.xmax_edit,'String')),str2num(get(handles.ymin_edit,'String')),str2num(get(handles.ymax_edit,'String'))]);
handles.vtrac=v;
handles.tracT=x;
guidata(hObject,handles);





% --- Executes on button press in AutoY_Chk.
function AutoY_Chk_Callback(hObject, eventdata, handles)
% hObject    handle to AutoY_Chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AutoY_Chk


% --- Executes on button press in Sep_Fig_Chk.
function Sep_Fig_Chk_Callback(hObject, eventdata, handles)
% hObject    handle to Sep_Fig_Chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Sep_Fig_Chk


% --- Executes on selection change in ColorSelector_menu.
function ColorSelector_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ColorSelector_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ColorSelector_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ColorSelector_menu


% --- Executes during object creation, after setting all properties.
function ColorSelector_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ColorSelector_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clearax_chk.
function clearax_chk_Callback(hObject, eventdata, handles)
% hObject    handle to clearax_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of clearax_chk


% --- Executes on selection change in colormaps_menu.
function colormaps_menu_Callback(hObject, eventdata, handles)
% hObject    handle to colormaps_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns colormaps_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from colormaps_menu
handles.cmap=handles.AvailCmaps{get(hObject,'Value')};
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function colormaps_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colormaps_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Sel_Inv_btn.
function Sel_Inv_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Sel_Inv_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sel_interval_btn.
function sel_interval_btn_Callback(hObject, eventdata, handles)
% hObject    handle to sel_interval_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function interval_edit_Callback(hObject, eventdata, handles)
% hObject    handle to interval_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interval_edit as text
%        str2double(get(hObject,'String')) returns contents of interval_edit as a double


% --- Executes during object creation, after setting all properties.
function interval_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interval_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Analyze_Spks_Btn.
function Analyze_Spks_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Analyze_Spks_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CoT=.6
CoMT=6
for i=1:size(handles.vtrac,2)
    trac=handles.vtrac(:,i);
    rp(i)=mean(trac(1:5));
    trac(find(handles.tracT<CoT))=nan;
    trac(find(handles.tracT>CoMT))=nan;
    [v(i) idx(i)]=nanmax(trac-rp(i));
    [mv(i) midx(i)]=nanmin(trac(1:idx(i)));
    pk(i)=nanmax(trac)
%     v25(i)=0.25*v(i)+rp(i);
%     v50(i)=0.5*v(i)+rp(i);
%     v75(i)=0.75*v(i)+rp(i);
     v25(i)=0.25*(pk(i)-mv(i))+mv(i);
    v50(i)=0.5*(pk(i)-mv(i))+mv(i);
    v75(i)=0.75*(pk(i)-mv(i))+mv(i);
    Tmax(i)=handles.tracT(idx(i))
    Tmin(i)=handles.tracT(midx(i))
    if Tmax(i)==Tmin(i)
        try
            [pk(i) idx(i)]=findpeaks(trac,'MinPeakDistance',5,'MinPeakProminence',1);
            [mv(i) midx(i)]=nanmin(trac(1:idx(i)));
            Tmax(i)=handles.tracT(idx(i));
            Tmin(i)=handles.tracT(midx(i));
            v25(i)=0.25*(pk(i)-mv(i))+mv(i);
            v50(i)=0.5*(pk(i)-mv(i))+mv(i);
            v75(i)=0.75*(pk(i)-mv(i))+mv(i);
        catch
            handles
            
        end
       
    end
    xx=handles.tracT(find(handles.tracT>=CoT));
    yy=trac(find(handles.tracT>=CoT));
    ax=xx(find(Tmin(i)<xx&xx<=Tmax(i)));
    ay=yy(find(Tmin(i)<xx&xx<=Tmax(i)));

   
    try
        t25(i)=interp1(ay,ax,v25(i));
        t50(i)=interp1(ay,ax,v50(i));
        t75(i)=interp1(ay,ax,v75(i));
    catch
        try
        [a b]=nanmin(abs(ay-v25(i)));
        t25(i)=ax(b);
        [a b]=nanmin(abs(ay-v50(i)));
        t50(i)=ax(b);
        [a b]=nanmin(abs(ay-v75(i)));
        t75(i)=ax(b);
        catch
            
            t50(i)=nan; 
            t25(i)=nan; 
            t75(i)=nan;
        end
    end
   hold all
    plot(t25(i),v25(i),'gx');
    plot(t50(i),v50(i),'rx');
    
   
    
    
    
end
dat.v=[v+rp(i);v25;v50;v75];
dat.t=[Tmax;t25;t50;t75];
dat.rp=rp;
dat.temp=[handles.TEMP(handles.ST(get(handles.listbox2,'Value'),3))]';
dat.isi=handles.dST';
hold all
    plot(t25,v25,'go');
    plot(t50,v50,'ro');
dat;
figure; scatter(handles.TEMP(handles.ST(get(handles.listbox2,'Value'),3)),v,10,[1:numel(v)])
%axis([0 50 0 80]);
xlabel('Temp C'); ylabel('AP/EJP amplitude (mV)');
title(['TEMP vs AMP: ',handles.FILENAME])
colorbar
figure; scatter(handles.TEMP(handles.ST(get(handles.listbox2,'Value'),3)),t25,10,[1:numel(v)])
axis([0 50 0 5]);
xlabel('Temp C'); ylabel('T_{25} (ms)');
title(['TEMP vs T_{25}: ',handles.FILENAME])
colorbar
export2wsdlg({'LatDat'},{'LatDat'},{dat});





