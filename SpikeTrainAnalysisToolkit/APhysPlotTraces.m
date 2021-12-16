function varargout = APhysPlotTraces(varargin)
% APHYSPLOTTRACES MATLAB code for APhysPlotTraces.fig
%      APHYSPLOTTRACES, by itself, creates a new APHYSPLOTTRACES or raises the existing
%      singleton*.
%
%      H = APHYSPLOTTRACES returns the handle to a new APHYSPLOTTRACES or the handle to
%      the existing singleton*.
%
%      APHYSPLOTTRACES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APHYSPLOTTRACES.M with the given input arguments.
%
%      APHYSPLOTTRACES('Property','Value',...) creates a new APHYSPLOTTRACES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APhysPlotTraces_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APhysPlotTraces_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APhysPlotTraces

% Last Modified by GUIDE v2.5 28-Dec-2020 13:50:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APhysPlotTraces_OpeningFcn, ...
                   'gui_OutputFcn',  @APhysPlotTraces_OutputFcn, ...
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


% --- Executes just before APhysPlotTraces is made visible.
function APhysPlotTraces_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APhysPlotTraces (see VARARGIN)

% Choose default command line output for APhysPlotTraces
handles.output = hObject;
if nargin<4
    [FILES PATH IDX]=uigetfile('D:\*.txt','MultiSelect','on');
    if ~iscell(FILES)
        cFILES{1}=[PATH,FILES];
    else
        for i=1:numel(FILES)
            cFILES{i}=[PATH,FILES{i}];
        end
    end
    handles.FILES=cFILES;
else
    handles.FILES=varargin{1};
end
handles.FILES=handles.FILES';
set(handles.file_names_list,'String',handles.FILES);
set(handles.auto_scale_chk,'Value',1);
handles.xmin=0;
handles.xmax=60;
handles.ymin=-100;
handles.ymax=100;
set(handles.xmin_edit,'String',num2str(0));
set(handles.xmax_edit,'String',num2str(60));
set(handles.ymin_edit,'String',num2str(-100));
set(handles.ymax_edit,'String',num2str(100));
set(handles.gain_edit,'String',num2str(100));
set(handles.ch1_name_edit,'String','');
set(handles.ch2_name_edit,'String','');
set(handles.ch3_name_edit,'String','');
set(handles.trace_filename_txt,'String','');
set(handles.lst_sz_txt,'String',[num2str(size(handles.FILES,1)),' Files']);
handles.TRACE=struct('DATA',num2cell(nan(size(handles.FILES))));
handles.COLORS={'black';'blue';'green';'red';'cyan';'magenta';'yellow';'time encode JET'};
set(handles.ch1color_menu,'String',handles.COLORS);
set(handles.ch2color_menu,'String',handles.COLORS);
set(handles.ch3color_menu,'String',handles.COLORS);
set(handles.stimcolor_menu,'String',handles.COLORS);
set(handles.APcolor_menu,'String',handles.COLORS);
set(handles.LEDcolor_menu,'String',handles.COLORS);
set(handles.LEDcolor_menu,'Value',4);

handles.plotformat={'jpg';'tif';'png';'ps';'ill'};
handles.plotnames={'jpeg';'tiff';'png';'epsc2';'ill'};
set(handles.plot_type_menu,'String',handles.plotformat);
handles.FeatList=cell(0,1);
set(handles.Feature_List,'String',handles.FeatList)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APhysPlotTraces wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APhysPlotTraces_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in file_names_list.
function file_names_list_Callback(hObject, eventdata, handles)
% hObject    handle to file_names_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns file_names_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from file_names_list


% --- Executes during object creation, after setting all properties.
function file_names_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_names_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ana_sel_chk.
function ana_sel_chk_Callback(hObject, eventdata, handles)
% hObject    handle to ana_sel_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ana_sel_chk


% --- Executes on button press in Plot_btn.
function Plot_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PATHNAME=uigetdir;
wb=waitbar(0,['Processing ',num2str(0),' out of ', num2str(size(handles.FILES,1))]);
for k=1:size(handles.FILES,1)
     try
        waitbar(k/size(handles.FILES,1),wb,['Processing ',num2str(k),' out of ', num2str(size(handles.FILES,1))]);
%         if sum(sum(isnan(handles.TRACE(k).DATA)))
            waitbar(k/size(handles.FILES,1),wb,['Processing ',num2str(k),' out of ', num2str(size(handles.FILES,1)),': Loading FILE']);
            set(handles.ch1_chk,'Value',0);
            set(handles.ch2_chk,'Value',0);
            set(handles.ch3_chk,'Value',0);
            %h=msgbox(['importing: ',handles.FILES{k}]);
            handles.TRACE(k).DATA=APloaddatafile(handles.FILES{k});
            
            handles.TRACE(k).INFO=GetAPhysFileInfo(handles.FILES{k});
%         end
        chks=[0 0 0];
        try
            chname{1}=handles.TRACE(k).INFO.Ch1Name;
            if ~strcmp(chname{1},'None ')
                chks(1)=1;
            end
            chname{2}=handles.TRACE(k).INFO.Ch2Name;
            if ~strcmp(chname{2},'None ')
                chks(2)=1;
            end
            chname{3}=handles.TRACE(k).INFO.Ch3Name;
            if ~strcmp(chname{3},'None ')
                chks(3)=1;
            end
        catch
            chname{1}='Ch1';
            chks(1)=1;
            chname{2}='Ch2';
            chks(2)=1;
            chname{3}='Ch3';
            chks(3)=1;
        end
        colrs{1}=handles.COLORS{get(handles.ch1color_menu,'Value')};
        colrs{2}=handles.COLORS{get(handles.ch2color_menu,'Value')};
        colrs{3}=handles.COLORS{get(handles.ch3color_menu,'Value')};
        if get(handles.sav_ch_sep_chk,'Value')==1
            nplots=size(find(chks),2);
        end
        if get(handles.sav_ch_sep_chk,'Value')==0
            nplots=1;
        end
        usedchannels=find(chks);
        for j=1:nplots
            h=figure('Visible','off');
            [PATH, FNAME, EXTN]=fileparts(handles.FILES{k});
            STYPE=handles.plotformat{get(handles.plot_type_menu,'Value')};
            SUFFX=get(handles.suffix_edit,'String');
            CHN='';
            if get(handles.sav_ch_sep_chk,'Value')==1
                CHN=chname{usedchannels(j)};
            end
            
            SAVENAME=[PATHNAME,'\',FNAME,'_',CHN,'_',SUFFX,'.',STYPE];
            
            
            cla;
            if get(handles.sav_ch_sep_chk,'Value')==0
                hold all
                for i=1:3
                    if chks(i)==1
                        if strcmp(colrs{i},'time encode JET')==0
                            plot(handles.TRACE(k).DATA(:,1),handles.TRACE(k).DATA(:,i+1)/str2num(get(handles.gain_edit,'String'))*1000,colrs{i});
                        else
                            scatter(handles.TRACE(k).DATA(:,1),handles.TRACE(k).DATA(:,i+1)/str2num(get(handles.gain_edit,'String'))*1000,1,handles.TRACE(k).DATA(:,1),'filled')
                            caxis([0 120]);
                        end
                    end
                end
            end
            if get(handles.sav_ch_sep_chk,'Value')==1
                plot(handles.TRACE(k).DATA(:,1),handles.TRACE(k).DATA(:,usedchannels(j)+1)/str2num(get(handles.gain_edit,'String'))*1000,colrs{usedchannels(j)});
            end
            hold off
            title([FNAME,'_',CHN],'Interpreter','none');
            xlabel('Time (s)')
            ylabel('Amplitude (mV)')
            if get(handles.auto_scale_chk,'Value')==0
                xmin=str2num(get(handles.xmin_edit,'String'));
                xmax=str2num(get(handles.xmax_edit,'String'));
                ymin=str2num(get(handles.ymin_edit,'String'));
                ymax=str2num(get(handles.ymax_edit,'String'));
                axis([xmin,xmax,ymin,ymax])
            end
            
            set(h, 'PaperPositionMode', 'manual');
            set(h, 'PaperUnits', 'inches');
            set(h, 'PaperPosition', [0 0 4.5 1.5]);
            print(h,['-d',handles.plotnames{get(handles.plot_type_menu,'Value')}],SAVENAME,'-r600');
            
            close(h);
            
        end
        handles.TRACE=struct('DATA',num2cell(nan(size(handles.FILES))));
    catch
        msgbox(['Error with ',handles.FILES{k}]);
    end
end
close(wb)
guidata(hObject, handles);



function xmin_edit_Callback(hObject, eventdata, handles)
% hObject    handle to xmin_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmin_edit as text
%        str2double(get(hObject,'String')) returns contents of xmin_edit as a double
xmin=str2num(get(hObject,'String'));
if~isempty(xmin)
    if xmin<handles.xmax
        handles.xmin=xmin;
    end
end
set(hObject,'String',num2str(handles.xmin));
guidata(hObject,handles)

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
xmax=str2num(get(hObject,'String'));
if~isempty(xmax)
    if xmax>handles.xmin
        handles.xmax=xmax;
    end
end
set(hObject,'String',num2str(handles.xmax));
guidata(hObject,handles)
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
ymin=str2num(get(hObject,'String'));
if~isempty(ymin)
    if ymin<handles.ymax
        handles.ymin=ymin;
    end
end
set(hObject,'String',num2str(handles.ymin));
guidata(hObject,handles)

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
ymax=str2num(get(hObject,'String'));
if~isempty(ymax)
    if ymax>handles.ymin
        handles.ymax=ymax;
    end
end
set(hObject,'String',num2str(handles.ymax));
guidata(hObject,handles)

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


% --- Executes on button press in auto_scale_chk.
function auto_scale_chk_Callback(hObject, eventdata, handles)
% hObject    handle to auto_scale_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auto_scale_chk


% --- Executes on selection change in plot_type_menu.
function plot_type_menu_Callback(hObject, eventdata, handles)
% hObject    handle to plot_type_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plot_type_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot_type_menu


% --- Executes during object creation, after setting all properties.
function plot_type_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_type_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gain_edit_Callback(hObject, eventdata, handles)
% hObject    handle to gain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gain_edit as text
%        str2double(get(hObject,'String')) returns contents of gain_edit as a double


% --- Executes during object creation, after setting all properties.
function gain_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in prev_trac_btn.
function prev_trac_btn_Callback(hObject, eventdata, handles)
% hObject    handle to prev_trac_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.ctn=get(handles.file_names_list,'Value');
set(handles.trace_filename_txt,'String',handles.FILES{handles.ctn(1)})
if sum(sum(isnan(handles.TRACE(handles.ctn(1)).DATA)))
    set(handles.ch1_chk,'Value',0);
    set(handles.ch2_chk,'Value',0);
    set(handles.ch3_chk,'Value',0);
    h=msgbox(['importing: ',handles.FILES{handles.ctn(1)}]);
    handles.TRACE(handles.ctn(1)).DATA=APloaddatafile(handles.FILES{handles.ctn(1)});
    %try
    handles.TRACE(handles.ctn(1)).TEMP=filter(ones(1,15*250)/(15*250),1,handles.TRACE(handles.ctn(1)).DATA(:,5));
    handles.TRACE(handles.ctn(1)).TEMP(1:5000)=handles.TRACE(handles.ctn(1)).TEMP(5000)
    
   % end
    close(h)
    try
        handles.TRACE(handles.ctn(1)).INFO=GetAPhysFileInfo(handles.FILES{handles.ctn(1)});
        set(handles.ch1_name_edit,'String',handles.TRACE(handles.ctn(1)).INFO.Ch1Name);
        if ~strcmp(get(handles.ch1_name_edit,'String'),'None ')
            set(handles.ch1_chk,'Value',1);
        end
        set(handles.ch2_name_edit,'String',handles.TRACE(handles.ctn(1)).INFO.Ch2Name);
        if ~strcmp(get(handles.ch2_name_edit,'String'),'None ')
            set(handles.ch2_chk,'Value',1);
        end
        set(handles.ch3_name_edit,'String',handles.TRACE(handles.ctn(1)).INFO.Ch3Name);
        if ~strcmp(get(handles.ch3_name_edit,'String'),'None ')
            set(handles.ch3_chk,'Value',1);
        end
        
    catch
        
        handles.TRACE(handles.ctn(1)).INFO.Ch1Name='Ch1';
        set(handles.ch1_chk,'Value',1);
        handles.TRACE(handles.ctn(1)).INFO.Ch2Name='Ch2';
        set(handles.ch2_chk,'Value',1);
        handles.TRACE(handles.ctn(1)).INFO.Ch3Name='Ch3';
        set(handles.ch3_chk,'Value',1);
    end
    if strfind(handles.TRACE(handles.ctn(1)).INFO.EType,'Intracellular')
        set(handles.gain_edit,'String','10');
        set(handles.plottemp_chk,'Value',1);
        set(handles.ch1_chk,'Value',1);
        set(handles.ch2_chk,'Value',0);
        set(handles.ch3_chk,'Value',0);
        handles.isIC=1;
    else
        handles.isIC=0;
    end
    
    
end
set(handles.ch1_name_edit,'String',handles.TRACE(handles.ctn(1)).INFO.Ch1Name);
set(handles.ch2_name_edit,'String',handles.TRACE(handles.ctn(1)).INFO.Ch2Name);
set(handles.ch3_name_edit,'String',handles.TRACE(handles.ctn(1)).INFO.Ch3Name);
chks=[0 0 0]; 
chks(1)= get(handles.ch1_chk,'Value');
chks(2)= get(handles.ch2_chk,'Value');
chks(3)= get(handles.ch3_chk,'Value');
colrs{1}=handles.COLORS{get(handles.ch1color_menu,'Value')};
colrs{2}=handles.COLORS{get(handles.ch2color_menu,'Value')};
colrs{3}=handles.COLORS{get(handles.ch3color_menu,'Value')};
StimColor = handles.COLORS{get(handles.stimcolor_menu,'Value')};
APColor = handles.COLORS{get(handles.APcolor_menu,'Value')};  
LEDColor = handles.COLORS{get(handles.LEDcolor_menu,'Value')};   
axes(handles.axes1);

cla;
hold all

if handles.show_fig_chk.Value ==1
   h_new = figure;
   subplot(5,1,2:5);
   hold all
   
end

switch size(handles.TRACE(handles.ctn(1)).DATA,2)
    case 7
        handles.choffset=[1 1 3];
    case 6
        handles.choffset=[1 1 3];
    otherwise
        handles.choffset=[1 1 1];
end

    
    for i=1:3
        if chks(i)==1
            %         plot(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).DATA(:,i+1)/str2num(get(handles.gain_edit,'String'))*1000,colrs{i});
            if strcmp(colrs{i},'time encode JET')==0
                plot(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).DATA(:,i+handles.choffset(i))/str2num(get(handles.gain_edit,'String'))*1000,colrs{i});
            else
                scatter(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).DATA(:,i+handles.choffset(i))/str2num(get(handles.gain_edit,'String'))*1000,1,handles.TRACE(handles.ctn(1)).DATA(:,1),'filled')
                caxis([0 120]);
            end
        end
        
    end
    if get(handles.plottemp_chk,'Value')
        axes(handles.axes1);
        %yyaxis right
        plot(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).TEMP,'r');
        
        %yyaxis left
        axes(handles.axes1);
    end
    hold off
    if get(handles.auto_scale_chk,'Value')==0
        if handles.show_fig_chk.Value ==1
            axes(gca);
        else
             axes(handles.axes1);
        end
        xmin=str2num(get(handles.xmin_edit,'String'));
        xmax=str2num(get(handles.xmax_edit,'String'));
        ymin=str2num(get(handles.ymin_edit,'String'));
        ymax=str2num(get(handles.ymax_edit,'String'));
        axis([xmin,xmax,ymin,ymax])
        if get(handles.plottemp_chk,'Value')
            axes(handles.axes2);
            axis([xmin,xmax,0,50])
            medtemp=median(handles.TRACE(handles.ctn(1)).DATA(intersect(find(handles.TRACE(handles.ctn(1)).DATA(:,1)<xmax),find(handles.TRACE(handles.ctn(1)).DATA(:,1)>xmin)),5));
            set(handles.cur_temp_text,'String',num2str(medtemp));
            
        end
    end
    
    
    if handles.show_fig_chk.Value ==1
        figure(h_new)
        subplot(5,1,1);
        
        
    else
    
    axes(handles.axes2)
    cla;
    end
    if handles.LED_chk.Value ==1
        LEDCh = str2double(handles.LEDCh_edit.String);
        Time = handles.TRACE(handles.ctn(1)).DATA(:,1);
        LED = handles.TRACE(handles.ctn(1)).DATA(:,LEDCh);
        hLED=area(Time,LED,'LineWidth',2);
        hLED.FaceColor = LEDColor;
        hLED.EdgeColor = LEDColor
        ax = axis;
        xmin=ax(1);
        xmax = ax(2);
        ymin = -0.5;
        ymax = 10.5;
        if get(handles.auto_scale_chk,'Value')==0
            xmin=str2num(get(handles.xmin_edit,'String'));
            xmax=str2num(get(handles.xmax_edit,'String'));
        end
        axis([xmin,xmax,ymin,ymax])
    end
    
    
    if handles.AP_chk.Value ==1
        APCh = str2double(handles.APCh_edit.String);
        Time = handles.TRACE(handles.ctn(1)).DATA(:,1);
        AP = handles.TRACE(handles.ctn(1)).DATA(:,APCh);
        hold all;
        hAP=area(Time,AP,'LineWidth',2);
        hAP.FaceColor = APColor;
        hAP.EdgeColor = APColor;
        ax = axis;
        xmin=ax(1);
        xmax = ax(2);
        ymin = -0.5;
        ymax = 5.5;
        if get(handles.auto_scale_chk,'Value')==0
            xmin=str2num(get(handles.xmin_edit,'String'));
            xmax=str2num(get(handles.xmax_edit,'String'));
        end
        axis([xmin,xmax,ymin,ymax])
    end
    
      if handles.Stim_Chk.Value ==1
        StimCh = str2double(handles.StimCh_edit.String);
        Time = handles.TRACE(handles.ctn(1)).DATA(:,1);
        Stim = handles.TRACE(handles.ctn(1)).DATA(:,StimCh);
        hold all;
        hAP=area(Time,Stim,'LineWidth',2);
        hAP.FaceColor = StimColor;
        hAP.EdgeColor = StimColor;
        ax = axis;
        xmin=ax(1);
        xmax = ax(2);
        ymin = -0.5;
        ymax = 5.5;
        if get(handles.auto_scale_chk,'Value')==0
            xmin=str2num(get(handles.xmin_edit,'String'));
            xmax=str2num(get(handles.xmax_edit,'String'));
        end
        axis([xmin,xmax,ymin,ymax])
    end
    
    guidata(hObject,handles);


% --- Executes on button press in ch1_chk.
function ch1_chk_Callback(hObject, eventdata, handles)
% hObject    handle to ch1_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch1_chk


% --- Executes on button press in ch2_chk.
function ch2_chk_Callback(hObject, eventdata, handles)
% hObject    handle to ch2_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch2_chk


% --- Executes on button press in ch3_chk.
function ch3_chk_Callback(hObject, eventdata, handles)
% hObject    handle to ch3_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch3_chk


% --- Executes on button press in expt_cur_trac_btn.
function expt_cur_trac_btn_Callback(hObject, eventdata, handles)
% hObject    handle to expt_cur_trac_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
chks=[0 0 0];
chks(1)= get(handles.ch1_chk,'Value');
chname{1}=get(handles.ch1_name_edit,'String');
chks(2)= get(handles.ch2_chk,'Value');
chname{2}=get(handles.ch2_name_edit,'String');
chks(3)= get(handles.ch3_chk,'Value');
chname{3}=get(handles.ch3_name_edit,'String');
colrs{1}=handles.COLORS{get(handles.ch1color_menu,'Value')};
colrs{2}=handles.COLORS{get(handles.ch2color_menu,'Value')};
colrs{3}=handles.COLORS{get(handles.ch3color_menu,'Value')};

if get(handles.sav_ch_sep_chk,'Value')==1
    nplots=size(find(chks),2);
end
if get(handles.sav_ch_sep_chk,'Value')==0
    nplots=1;
end
usedchannels=find(chks);

for j=1:nplots
    
    [PATH, FNAME, EXTN]=fileparts(handles.FILES{handles.ctn(1)});
    STYPE=handles.plotformat{get(handles.plot_type_menu,'Value')};
    SUFFX=get(handles.suffix_edit,'String');
    CHN='';
    if get(handles.sav_ch_sep_chk,'Value')==1
        CHN=chname{usedchannels(j)};
    end
    
    SAVENAME=[FNAME,'_',CHN,'_',SUFFX,'.',STYPE];
    
    
    %cla;
    %     if get(handles.sav_ch_sep_chk,'Value')==0
    %         hold all
    %         for i=1:3
    %             if chks(i)==1
    %                 if strcmp(colrs{i},'time encode JET')==0
    %                     plot(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).DATA(:,i+handles.choffset)/str2num(get(handles.gain_edit,'String'))*1000,colrs{i});
    %                 else
    %                     scatter(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).DATA(:,i+handles.choffset)/str2num(get(handles.gain_edit,'String'))*1000,1,handles.TRACE(handles.ctn(1)).DATA(:,1),'filled')
    %                     caxis([0 120]);
    %                 end
    %             end
    %         end
    %         if get(handles.plottemp_chk,'Value')
    %             plot(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).TEMP,'r');
    %         end
    %     end
    %     if get(handles.sav_ch_sep_chk,'Value')==1
    %         if strcmp(colrs{i},'time encode JET')==0
    %             plot(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).DATA(:,i+1)/str2num(get(handles.gain_edit,'String'))*1000,colrs{i});
    %         else
    %             scatter(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).DATA(:,i+1)/str2num(get(handles.gain_edit,'String'))*1000,1,handles.TRACE(handles.ctn(1)).DATA(:,1),'filled')
    %             caxis([0 120]);
    %         end
    %         if get(handles.plottemp_chk,'Value')
    %             plot(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).TEMP,'r');
    %         end
    %     end
    %     hold off
    h=figure('Visible','off');
    copyobj(handles.axes1,h)
    
    ct=get(handles.cur_temp_text,'String');
    title([FNAME,'_',CHN,' :: ',ct,'C'],'Interpreter','none');
    xlabel('Time (s)')
    ylabel('Amplitude (mV)')
    %     if get(handles.auto_scale_chk,'Value')==0
    %         xmin=str2num(get(handles.xmin_edit,'String'));
    %         xmax=str2num(get(handles.xmax_edit,'String'));
    %         ymin=str2num(get(handles.ymin_edit,'String'));
    %         ymax=str2num(get(handles.ymax_edit,'String'));
    %         axis([xmin,xmax,ymin,ymax])
    %     end
    [SAVENAME,PATHNAME]=uiputfile(SAVENAME,'Select File Location');
    SAVENAME=[PATHNAME,SAVENAME];
    set(h, 'PaperPositionMode', 'manual');
    set(h, 'PaperUnits', 'inches');
    set(h, 'PaperPosition', [0 0 4.5 1.5]);
    axn=h.Children;
    axn.Units='normalized';
    axn.Position=[0.1300 0.1100 0.7750 0.8150];
    axn.OuterPosition=[0 0 1 1];
    
    print(h,['-d',handles.plotnames{get(handles.plot_type_menu,'Value')}],SAVENAME,'-r600');
    if get(handles.show_fig_chk,'Value')==0
        close(h);
    end
    if get(handles.show_fig_chk,'Value')==1
        set(h,'Visible','on');
    end
end



function ch1_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ch1_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1_name_edit as text
%        str2double(get(hObject,'String')) returns contents of ch1_name_edit as a double
handles.TRACE(handles.ctn(1)).INFO.Ch1Name=get(hObject,'String');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ch1_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ch2_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2_name_edit as text
%        str2double(get(hObject,'String')) returns contents of ch2_name_edit as a double
handles.TRACE(handles.ctn(1)).INFO.Ch2Name=get(hObject,'String');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ch2_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ch3_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3_name_edit as text
%        str2double(get(hObject,'String')) returns contents of ch3_name_edit as a double
handles.TRACE(handles.ctn(1)).INFO.Ch3Name=get(hObject,'String');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function ch3_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch1color_menu.
function ch1color_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ch1color_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ch1color_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ch1color_menu


% --- Executes during object creation, after setting all properties.
function ch1color_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1color_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch2color_menu.
function ch2color_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ch2color_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ch2color_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ch2color_menu


% --- Executes during object creation, after setting all properties.
function ch2color_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2color_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch3color_menu.
function ch3color_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ch3color_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ch3color_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ch3color_menu


% --- Executes during object creation, after setting all properties.
function ch3color_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3color_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_fig_chk.
function show_fig_chk_Callback(hObject, eventdata, handles)
% hObject    handle to show_fig_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of show_fig_chk


% --- Executes on button press in next_trace_prev_btn.
function next_trace_prev_btn_Callback(hObject, eventdata, handles)
% hObject    handle to next_trace_prev_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.file_names_list,'Value');
mv=size(get(handles.file_names_list,'String'),1);
if value<mv
    set(handles.file_names_list,'Value',value+1)
end
guidata(hObject,handles)

% --- Executes on button press in prev_trace_prev_btn.
function prev_trace_prev_btn_Callback(hObject, eventdata, handles)
% hObject    handle to prev_trace_prev_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(handles.file_names_list,'Value');
mv=size(get(handles.file_names_list,'String'),1);
if value>1
    set(handles.file_names_list,'Value',value-1)
end
guidata(hObject,handles)


% --- Executes on button press in sav_ch_sep_chk.
function sav_ch_sep_chk_Callback(hObject, eventdata, handles)
% hObject    handle to sav_ch_sep_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sav_ch_sep_chk


% --- Executes on button press in spec_filename_chk.
function spec_filename_chk_Callback(hObject, eventdata, handles)
% hObject    handle to spec_filename_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spec_filename_chk



function suffix_edit_Callback(hObject, eventdata, handles)
% hObject    handle to suffix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of suffix_edit as text
%        str2double(get(hObject,'String')) returns contents of suffix_edit as a double


% --- Executes during object creation, after setting all properties.
function suffix_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to suffix_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plottemp_chk.
function plottemp_chk_Callback(hObject, eventdata, handles)
% hObject    handle to plottemp_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plottemp_chk


% --- Executes on button press in back_btn.
function back_btn_Callback(hObject, eventdata, handles)
% hObject    handle to back_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xmin=str2num(get(handles.xmin_edit,'String'));
xmax=str2num(get(handles.xmax_edit,'String'));
dx=xmax-xmin;
xmax=xmax-0.5*dx;
xmin=xmin-0.5*dx;
set(handles.xmin_edit,'String',num2str(xmin))
set(handles.xmax_edit,'String',num2str(xmax))
prev_trac_btn_Callback(hObject,eventdata,handles)

% --- Executes on button press in Forward_btn.
function Forward_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Forward_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

xmin=str2num(get(handles.xmin_edit,'String'));
xmax=str2num(get(handles.xmax_edit,'String'));
dx=xmax-xmin;
xmax=xmax+0.5*dx;
xmin=xmin+0.5*dx;
set(handles.xmin_edit,'String',num2str(xmin))
set(handles.xmax_edit,'String',num2str(xmax))
prev_trac_btn_Callback(hObject,eventdata,handles)


% --- Executes on button press in ZIn_btn.
function ZIn_btn_Callback(hObject, eventdata, handles)
% hObject    handle to ZIn_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xmin=str2num(get(handles.xmin_edit,'String'));
xmax=str2num(get(handles.xmax_edit,'String'));
dx=xmax-xmin;
xmax=xmax-0.25*dx;
xmin=xmin+0.25*dx;
set(handles.xmin_edit,'String',num2str(xmin))
set(handles.xmax_edit,'String',num2str(xmax))
prev_trac_btn_Callback(hObject,eventdata,handles)

% --- Executes on button press in ZOut_btn.
function ZOut_btn_Callback(hObject, eventdata, handles)
% hObject    handle to ZOut_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xmin=str2num(get(handles.xmin_edit,'String'));
xmax=str2num(get(handles.xmax_edit,'String'));
dx=xmax-xmin;
xmax=xmax+0.5*dx;
xmin=xmin-0.5*dx;
set(handles.xmin_edit,'String',num2str(xmin))
set(handles.xmax_edit,'String',num2str(xmax))
prev_trac_btn_Callback(hObject,eventdata,handles)


% --- Executes on button press in FindICStim_btn.
function FindICStim_btn_Callback(hObject, eventdata, handles)
% hObject    handle to FindICStim_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=handles.TRACE(handles.ctn(1)).DATA(:,1);
V=handles.TRACE(handles.ctn(1)).DATA(:,2);
gain=str2num(get(handles.gain_edit,'String'));
ST=ICfindStimfromRec(T,V,gain,0.02,1)
hold all
plot(ST(:,1),ST(:,2)*1000,'rx')
hold off


% --- Executes on button press in StimLocPlot_btn.
function StimLocPlot_btn_Callback(hObject, eventdata, handles)
% hObject    handle to StimLocPlot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUID

chks=[0 0 0];
chks(1)= get(handles.ch1_chk,'Value');
chname{1}=get(handles.ch1_name_edit,'String');
chks(2)= get(handles.ch2_chk,'Value');
chname{2}=get(handles.ch2_name_edit,'String');
chks(3)= get(handles.ch3_chk,'Value');
if sum(chks)>1
    sel=listdlg('SelectionMode','single','ListString',[{'1'};{'2'};{'3'}]);
    
else
    sel=find(chks);
    
end

T=handles.TRACE(handles.ctn(1)).DATA(:,1);
V=handles.TRACE(handles.ctn(1)).DATA(:,sel+1);
TEMP=handles.TRACE(handles.ctn(1)).TEMP;
gain=str2num(get(handles.gain_edit,'String'));
ST=ICfindStimfromRec(T,V,gain,0.02,1);
%cmap=jet(size(ST,1));
ICanalyzestimresp(V,T,ST,TEMP,get(handles.trace_filename_txt,'String'));

guidata(hObject,handles);


% --- Executes on button press in exportws_btn.
function exportws_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exportws_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T=handles.TRACE(handles.ctn).DATA((handles.TRACE(handles.ctn).DATA(:,1)>=handles.xmin&handles.TRACE(handles.ctn).DATA(:,1)<handles.xmax),1);
CH1=handles.TRACE(handles.ctn).DATA((handles.TRACE(handles.ctn).DATA(:,1)>=handles.xmin&handles.TRACE(handles.ctn).DATA(:,1)<handles.xmax),2);
CH2=handles.TRACE(handles.ctn).DATA((handles.TRACE(handles.ctn).DATA(:,1)>=handles.xmin&handles.TRACE(handles.ctn).DATA(:,1)<handles.xmax),3);
CH3=handles.TRACE(handles.ctn).DATA((handles.TRACE(handles.ctn).DATA(:,1)>=handles.xmin&handles.TRACE(handles.ctn).DATA(:,1)<handles.xmax),4);
CH4=handles.TRACE(handles.ctn).DATA((handles.TRACE(handles.ctn).DATA(:,1)>=handles.xmin&handles.TRACE(handles.ctn).DATA(:,1)<handles.xmax),5);
CH5=handles.TRACE(handles.ctn).DATA((handles.TRACE(handles.ctn).DATA(:,1)>=handles.xmin&handles.TRACE(handles.ctn).DATA(:,1)<handles.xmax),6);

export2wsdlg([{'Time'},{'Channel 1'},{'Channel 2'},{'Channel 3'},{'Channel 4'},{'Channel 5'}],[{'T'},{'CH1'},{'CH2'},{'CH3'},{'CH4'},{'CH5'}],[{T}, {CH1}, {CH2}, {CH3}, {CH4}, {CH5}]);


% --- Executes on button press in Create_Vid_btn.
function Create_Vid_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Create_Vid_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[PATH, FNAME, EXTN]=fileparts(handles.FILES{handles.ctn(1)});
STYPE='mp4';
SUFFX='TraceMOVIE';
CHN='';
if get(handles.sav_ch_sep_chk,'Value')==1
    CHN=chname{usedchannels(j)};
end

SAVENAME=[FNAME,'_',CHN,'_',SUFFX,'.',STYPE];

[SAVENAME,PATHNAME]=uiputfile(SAVENAME,'Select File Location');
    SAVENAME=[PATHNAME,SAVENAME];

%h=figure('Visible','off');
h = figure;
set(h,'Position',[100 100 1440 480]);
set(h,'Color',[0 0 0]);


chks=[0 0 0];
chks(1)= get(handles.ch1_chk,'Value');
chname{1}=get(handles.ch1_name_edit,'String');
chks(2)= get(handles.ch2_chk,'Value');
chname{2}=get(handles.ch2_name_edit,'String');
chks(3)= get(handles.ch3_chk,'Value');
chname{3}=get(handles.ch3_name_edit,'String');
colrs{1}=handles.COLORS{get(handles.ch1color_menu,'Value')};
colrs{2}=handles.COLORS{get(handles.ch2color_menu,'Value')};
colrs{3}=handles.COLORS{get(handles.ch3color_menu,'Value')};

if get(handles.sav_ch_sep_chk,'Value')==1
    nplots=size(find(chks),2);
end
if get(handles.sav_ch_sep_chk,'Value')==0
    nplots=1;
end
usedchannels=find(chks);

fs=200000;

hold all
for i=1:3
    if chks(i)==1
         if strcmp(colrs{i},'time encode JET')==0
            plot(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).DATA(:,i+handles.choffset)/str2num(get(handles.gain_edit,'String'))*1000,colrs{i},'LineWidth',2);
        
         else
            scatter(handles.TRACE(handles.ctn(1)).DATA(:,1),handles.TRACE(handles.ctn(1)).DATA(:,i+handles.choffset)/str2num(get(handles.gain_edit,'String'))*1000,1,handles.TRACE(handles.ctn(1)).DATA(:,1),'filled')
            caxis([0 120]);
        end
    end
end
hold off

maxt=max(handles.TRACE(handles.ctn(1)).DATA(:,1));
nl=size(handles.TRACE(handles.ctn(1)).DATA(:,1),1);
cax=axis;
cax(1)=-2.5;
cax(2)=2.5;
axis(cax);
caxs=gca;
set(caxs, 'XColor', [1 1 1]);
set(caxs, 'YColor', [1 1 1]);
set(caxs,'Color',[.1 .1 .1]);
set(caxs,'FontSize',18);

xlabel('Time (s)','Color','green','FontSize',22);
ylabel('V_m (mV)','Color','green','FontSize',22)
dt=.05;
%  SAVENAME='test25.mp4'
% % 
%  maxt=5;
cx=gca;

if get(handles.auto_scale_chk,'Value')==0
   cax(3)=str2num(get(handles.ymin_edit,'String'));
   cax(4)=str2num(get(handles.ymax_edit,'String'));
end

cx.Units='pixels';
pos=cx.Position;
ti=cx.TightInset;
v=VideoWriter(SAVENAME,'MPEG-4');
v.FrameRate=20;
open(v)


try
minT=str2num(handles.VidMinT.String);
catch
    minT=0
end
    
try
    maxT=str2num(handles.VidMaxT.String);
    if isempty(maxT)
        maxT=floor(maxt);
    end
catch
    maxT=floor(maxt);
end

% profile on
hh=waitbar(0,'initializing');
for ii=minT*v.FrameRate:maxT*v.FrameRate
    axis(caxs,cax+[ii*dt, ii*dt, 0 0]);
    frame=getframe(h);
    writeVideo(v,frame)
    if (ii-minT*v.FrameRate)./(((maxT-minT)*v.FrameRate))==round((ii-minT*v.FrameRate)./(((maxT-minT)*v.FrameRate))*20)/20;
        waitbar((ii-minT*v.FrameRate)./((floor(maxT)-minT)*v.FrameRate),hh,[num2str((ii-minT*v.FrameRate)./((floor(maxT)-minT)*v.FrameRate)*100),'%'])
    end
end
% profile viewer
% profile off
delete(hh)

% for ii=1:floor(maxt)*20
%     hold all
%     for i=1:3
%         if chks(i)==1
%             if strcmp(colrs{i},'time encode JET')==0
%                 plot(handles.TRACE(handles.ctn(1)).DATA([(max(1,(ii-1)*1000-50000)):(min(nl,(ii-1)*1000+50000))],1),handles.TRACE(handles.ctn(1)).DATA([(max(1,(ii-1)*1000-50000)):(min(nl,(ii-1)*1000+50000))],i+handles.choffset)/str2num(get(handles.gain_edit,'String'))*1000,colrs{i});
%                 
%             else
%                 scatter(handles.TRACE(handles.ctn(1)).DATA([(max(1,(ii-1)*1000-50000)):(min(nl,(ii-1)*1000+50000))],1),handles.TRACE(handles.ctn(1)).DATA([(max(1,(ii-1)*1000-50000)):(min(nl,(ii-1)*1000+50000))],i+handles.choffset)/str2num(get(handles.gain_edit,'String'))*1000,1,handles.TRACE(handles.ctn(1)).DATA(:,1),'filled')
%                 caxis([0 120]);
%             end
%         end
%     end
%     hold off
%     
%     axis(cax+[ii*dt, ii*dt, 0 0]);
%     frame=getframe(h);
%     writeVideo(v,frame);
% end

close(v);
delete(h);


% --- Executes on selection change in Feature_List.
function Feature_List_Callback(hObject, eventdata, handles)
% hObject    handle to Feature_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Feature_List contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Feature_List


% --- Executes during object creation, after setting all properties.
function Feature_List_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Feature_List (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AddFeature_btn.
function AddFeature_btn_Callback(hObject, eventdata, handles)
% hObject    handle to AddFeature_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
feat=APplottracAddFeat;
if ~isnumeric(feat)
    handles.FeatList(end+1)={feat.Name};
    set(handles.Feature_List,'String',handles.FeatList)
    set(handles.Feature_List,'Value',numel(handles.FeatList))
    Xv=handles.TRACE(handles.ctn(1)).DATA(:,1);
    Yv=handles.TRACE(handles.ctn(1)).DATA(:,1+feat.Channel)/str2num(get(handles.gain_edit,'String'))*1000;
    idx=Xv>feat.Xmin&Xv<feat.Xmax;
    %figure
    axis(handles.axes1)
    hold all
    plot(Xv(idx),Yv(idx),'color',feat.Color);
    hold off
    
    guidata(hObject,handles);
end




% --- Executes on button press in RemoveFeature_Btn.
function RemoveFeature_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveFeature_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in EditFeature_btn.
function EditFeature_btn_Callback(hObject, eventdata, handles)
% hObject    handle to EditFeature_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function VidMinT_Callback(hObject, eventdata, handles)
% hObject    handle to VidMinT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VidMinT as text
%        str2double(get(hObject,'String')) returns contents of VidMinT as a double


% --- Executes during object creation, after setting all properties.
function VidMinT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VidMinT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VidMaxT_Callback(hObject, eventdata, handles)
% hObject    handle to VidMaxT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VidMaxT as text
%        str2double(get(hObject,'String')) returns contents of VidMaxT as a double
if isempty(str2num(get(hObject,'String')))
    set(hObject,'String','end')
end


% --- Executes during object creation, after setting all properties.
function VidMaxT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VidMaxT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Stim_Chk.
function Stim_Chk_Callback(hObject, eventdata, handles)
% hObject    handle to Stim_Chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Stim_Chk


% --- Executes on button press in AP_chk.
function AP_chk_Callback(hObject, eventdata, handles)
% hObject    handle to AP_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AP_chk


% --- Executes on button press in LED_chk.
function LED_chk_Callback(hObject, eventdata, handles)
% hObject    handle to LED_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LED_chk



function stim_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stim_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_name_edit as text
%        str2double(get(hObject,'String')) returns contents of stim_name_edit as a double


% --- Executes during object creation, after setting all properties.
function stim_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AP_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to AP_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AP_name_edit as text
%        str2double(get(hObject,'String')) returns contents of AP_name_edit as a double


% --- Executes during object creation, after setting all properties.
function AP_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AP_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LED_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LED_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LED_name_edit as text
%        str2double(get(hObject,'String')) returns contents of LED_name_edit as a double


% --- Executes during object creation, after setting all properties.
function LED_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LED_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stimcolor_menu.
function stimcolor_menu_Callback(hObject, eventdata, handles)
% hObject    handle to stimcolor_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns stimcolor_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stimcolor_menu


% --- Executes during object creation, after setting all properties.
function stimcolor_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimcolor_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in APcolor_menu.
function APcolor_menu_Callback(hObject, eventdata, handles)
% hObject    handle to APcolor_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns APcolor_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from APcolor_menu


% --- Executes during object creation, after setting all properties.
function APcolor_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to APcolor_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LEDcolor_menu.
function LEDcolor_menu_Callback(hObject, eventdata, handles)
% hObject    handle to LEDcolor_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LEDcolor_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LEDcolor_menu


% --- Executes during object creation, after setting all properties.
function LEDcolor_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LEDcolor_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function StimCh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to StimCh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StimCh_edit as text
%        str2double(get(hObject,'String')) returns contents of StimCh_edit as a double


% --- Executes during object creation, after setting all properties.
function StimCh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StimCh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function APCh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to APCh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of APCh_edit as text
%        str2double(get(hObject,'String')) returns contents of APCh_edit as a double


% --- Executes during object creation, after setting all properties.
function APCh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to APCh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LEDCh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LEDCh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LEDCh_edit as text
%        str2double(get(hObject,'String')) returns contents of LEDCh_edit as a double


% --- Executes during object creation, after setting all properties.
function LEDCh_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LEDCh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
