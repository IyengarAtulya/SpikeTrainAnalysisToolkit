function varargout = APhysSpkDet(varargin)
% APHYSSPKDET MATLAB code for APhysSpkDet.fig
%      APHYSSPKDET, by itself, creates a new APHYSSPKDET or raises the existing
%      singleton*.
%
%      H = APHYSSPKDET returns the handle to a new APHYSSPKDET or the handle to
%      the existing singleton*.
%
%      APHYSSPKDET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APHYSSPKDET.M with the given input arguments.
%
%      APHYSSPKDET('Property','Value',...) creates a new APHYSSPKDET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APhysSpkDet_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APhysSpkDet_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APhysSpkDet

% Last Modified by GUIDE v2.5 17-Oct-2013 13:47:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @APhysSpkDet_OpeningFcn, ...
    'gui_OutputFcn',  @APhysSpkDet_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    warning('off','all');
    gui_State.gui_Callback = str2func(varargin{1});
    warning('on','all');
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before APhysSpkDet is made visible.
function APhysSpkDet_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APhysSpkDet (see VARARGIN)

% Choose default command line output for APhysSpkDet
handles.output = hObject;
nargin;
if nargin>3
    handles.FILENAME=varargin{1}{1};
    handles.fn=varargin{2};
    
else
    [n p e]=uigetfile('D:\Recordings Hold\*.txt','select file')
    handles.FILENAME=[p,n]
    handles.fn=1
end

% if nargin>2
%     handles.isIC=varargin{3}
% end

% handles.FILENAME='C:\Users\wulab\Documents\Recordings Hold\11jun8_10.txt';
% handles.fn=1;
[handles.FILEPATH handles.NAME handles.EXTN]=fileparts(handles.FILENAME);
handles.RAWDATPATH='D:\Recordings Hold';
handles.SPKTIMEPATH='D:\Spike Time Data';
% handles.TABLEPATH='\\biodata1\Wu Lab\Lab\Atulya\Physiology Summary and Organization';
handles.TABLEPATH='R:\BioDataLab\Atulya\Physiology Summary and Organization';
% handles.RECTABLENAME='\\biodata1\Wu Lab\Lab\Atulya\Physiology Summary and Organization\Recording Table.xlsx';
handles.RECTABLENAME='R:\BioDataLab\Atulya\Physiology Summary and Organization\Recording Table.xlsx';
FILEinfo=dir(handles.FILENAME);
FSIZE=FILEinfo.bytes;
if (FSIZE/1000000)>400
    szresp=questdlg(['Warning: Large recording ', num2str(round(FSIZE/1000000)), ' Mb, loading can take several minutes. Do you want to continue?']);
    if ~strcmp(szresp,'Yes')
        error('User Aborted Load');
    end
end


h=msgbox({['Loading: ',handles.FILENAME];['Total size is ',num2str(round(FSIZE/1000000)),' Mb']},['Loading #',num2str(handles.fn)]);
tic
handles.Data=APloaddatafile(handles.FILENAME);
toc
set(handles.FILENAME_edit,'String',handles.FILENAME);
handles.isIC=0;
try
    
    handles.fileinfo=GetAPhysFileInfo(handles.FILENAME);
    if strfind(handles.fileinfo.EType,'Intracellular')
        set(handles.IC_Notify,'Visible','on')
        handles.isIC=1;
        set(handles.ICFilterChk,'Value',1);
        set(handles.LP_CO_edit,'String','10');
        set(handles.HP_CO_edit,'String','8000');
        set(handles.LP_Order_edit,'String','8');
        set(handles.refilter_btn,'Visible','on');
        handles.SPKTIMEPATH='D:\Intracellular Spike Time Data';
        handles.Fparam=fdesign.bandpass('N,F3db1,F3db2',8,str2num(get(handles.LP_CO_edit,'String'))/15000,str2num(get(handles.HP_CO_edit,'String'))/15000);
        handles.FHsos=design(handles.Fparam);
        handles.FV=filtfilt(handles.FHsos.sosMatrix,handles.FHsos.ScaleValues,handles.Data(:,2));
    end
    if sum(handles.Data(:,5)<-1)>0
        handles.LEDstim=1;
    else
        handles.LEDstim=0;
    end
    
    if sum(handles.Data(:,5)>1)>0
        handles.ELECstim=1;
    else
        handles.ELECstim=0;
    end
    
    
    set(handles.operator_txt,'String',handles.fileinfo.Operator);
    set(handles.date_txt,'String',handles.fileinfo.Date);
    set(handles.time_txt,'String',handles.fileinfo.Time);
    set(handles.genotype_txt,'String',handles.fileinfo.Genotype);
    set(handles.age_txt,'String',num2str(handles.fileinfo.Age));
    set(handles.sex_txt,'String',handles.fileinfo.Sex);
    set(handles.burstfreq_txt,'String',num2str(handles.fileinfo.BurstFrequency));
    set(handles.burstdur_txt,'String',num2str(handles.fileinfo.BurstDuration));
    set(handles.tpfreq_txt,'String',num2str(handles.fileinfo.TestPulseFrequency));
    set(handles.tpdur_txt,'String',num2str(handles.fileinfo.TestPulseDuration));
    set(handles.pulseamplitude_txt,'String',num2str(handles.fileinfo.PulseAmplitude));
    set(handles.comments_txt,'String',handles.fileinfo.Comments);
catch
    warndlg('File info not loaded')
end
% handles.buttercut=0.01;
% set(handles.LP_CO_edit,'String',num2str(handles.buttercut));
% set(handles.ICFilterChk,'Value',1);
try
    set(handles.ch1name_edit,'String',handles.fileinfo.Ch1Name);
    if ~strcmp(handles.fileinfo.Ch1Name,'None ')
        set(handles.Ch1chk,'Value',1);
        if strcmp(handles.fileinfo.Ch1Name,' ')
            set(handles.ch1name_edit,'String','R_DLM#1');
        end
    end
    set(handles.ch2name_edit,'String',handles.fileinfo.Ch2Name);
    if ~strcmp(handles.fileinfo.Ch2Name,'None ')
        set(handles.Ch2chk,'Value',1);
    end
    set(handles.ch3name_edit,'String',handles.fileinfo.Ch3Name);
    if ~strcmp(handles.fileinfo.Ch3Name,'None ')
        set(handles.Ch3chk,'Value',1);
    end
    
catch
end
if handles.isIC==1
    set(handles.Ch1chk,'Value',1);
    set(handles.Ch2chk,'Value',0);
    set(handles.Ch3chk,'Value',0);
end
set(handles.air_puff_ch_menu,'String',[{'1'};{'2'};{'3'}]);
set(handles.air_puff_ch_menu,'Value',3);

if handles.isIC==0
    axes(handles.axes1);
    if size(handles.Data,2)>5
        plot(handles.Data(:,1),handles.Data(:,2),'b');
        axes(handles.axes2);
        plot(handles.Data(:,1),handles.Data(:,3),'r');
        axes(handles.axes3);
        plot(handles.Data(:,1),handles.Data(:,6),'g');
        axes(handles.axes4);
        plot(handles.Data(:,1),handles.Data(:,5),'k');
        hold all
        plot(handles.Data(:,1),handles.Data(:,4),'c');
        
    else
        
        plot(handles.Data(:,1),handles.Data(:,2),'b');
        axes(handles.axes2);
        plot(handles.Data(:,1),handles.Data(:,3),'r');
        axes(handles.axes3);
        plot(handles.Data(:,1),handles.Data(:,4),'g');
        axes(handles.axes4);
        plot(handles.Data(:,1),handles.Data(:,5),'k');
    end
end
if handles.isIC==1
axes(handles.axes1);
plot(handles.Data(:,1),handles.Data(:,2),'b');
axes(handles.axes2);
plot(handles.Data(:,1),handles.FV,'r')
axes(handles.axes3);
plot(handles.Data(:,1),handles.Data(:,4),'g');
axes(handles.axes4);
plot(handles.Data(:,1),handles.Data(:,5),'k');
v=axis;
v(4)=45;
axis(v);
end

abc=importdata('R:\BioDataLab\Atulya\Physiology Summary and Organization\paradigm_list.txt');
set(handles.ETYPE_menu,'String',abc);
handles.AMP_thresh=2;
set(handles.amp_thresh_edit,'String',num2str(handles.AMP_thresh));
handles.ST_thresh=2;
set(handles.ST_thresh_edit,'String',num2str(handles.ST_thresh));
close(h);
handles.ostruct=struct('succ',1,'createdSTfiles',cell(0,1));
handles.ostruct(1).succ=1;
handles.output=handles.ostruct;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APhysSpkDet wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APhysSpkDet_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)
% Get default command line output from handles structure
handles.output=handles.ostruct;
varargout{1} = handles.output;



% --- Executes on button press in Ch1chk.
function Ch1chk_Callback(hObject, eventdata, handles)
% hObject    handle to Ch1chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Ch1chk


% --- Executes on button press in Ch2chk.
function Ch2chk_Callback(hObject, eventdata, handles)
% hObject    handle to Ch2chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Ch2chk


% --- Executes on button press in Ch3chk.
function Ch3chk_Callback(hObject, eventdata, handles)
% hObject    handle to Ch3chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Ch3chk



function ch1name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ch1name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch1name_edit as text
%        str2double(get(hObject,'String')) returns contents of ch1name_edit as a double


% --- Executes during object creation, after setting all properties.
function ch1name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch2name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ch2name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch2name_edit as text
%        str2double(get(hObject,'String')) returns contents of ch2name_edit as a double


% --- Executes during object creation, after setting all properties.
function ch2name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ch3name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to ch3name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ch3name_edit as text
%        str2double(get(hObject,'String')) returns contents of ch3name_edit as a double


% --- Executes during object creation, after setting all properties.
function ch3name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch3name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ETYPE_menu.
function ETYPE_menu_Callback(hObject, eventdata, handles)
% hObject    handle to ETYPE_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ETYPE_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ETYPE_menu


% --- Executes during object creation, after setting all properties.
function ETYPE_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ETYPE_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FILENAME_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FILENAME_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FILENAME_edit as text
%        str2double(get(hObject,'String')) returns contents of FILENAME_edit as a double


% --- Executes during object creation, after setting all properties.
function FILENAME_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FILENAME_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in done_btn.
function done_btn_Callback(hObject, eventdata, handles)
% hObject    handle to done_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(gcf)

% --- Executes on button press in addexpt_btn.
function addexpt_btn_Callback(hObject, eventdata, handles)
% hObject    handle to addexpt_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
paraname=inputdlg('Enter Paradigm Name','Add Paradigm');
if isempty(paraname)==0
    fid=fopen([handles.TABLEPATH,'\paradigm_list.txt'],'a');
    fprintf(fid,'\n%s',paraname{1});
    fclose(fid);
    abc=importdata([handles.TABLEPATH,'\paradigm_list.txt']);
    set(handles.ETYPE_menu, 'String',abc);
end


% --- Executes on button press in analyze_btn.
function analyze_btn_Callback(hObject, eventdata, handles)
% hObject    handle to analyze_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ampthresh=str2num(get(handles.amp_thresh_edit,'String'));
stthresh=str2num(get(handles.ST_thresh_edit,'String'));
anach=[0 0 0];
anach(1)=get(handles.Ch1chk,'Value');
anach(2)=get(handles.Ch2chk,'Value');
anach(3)=get(handles.Ch3chk,'Value');
chname{1}=get(handles.ch1name_edit,'String');
chname{2}=get(handles.ch2name_edit,'String');
chname{3}=get(handles.ch3name_edit,'String');
chtoa=find(anach);

etypes=get(handles.ETYPE_menu,'String');
etypev=get(handles.ETYPE_menu,'Value');
etype=etypes{etypev};
% if SL analysis mechanism, 
slanamech=0;
if strcmp(etype,'Threshold Determination')==1
    slanamech=1;
end
if strcmp(etype,'Following Frequency')==1
   slanamech=2;
end
if strcmp(etype,'Electroconvulsive Resp + TP')
    slanamech=3;
end
if strcmp(etype,'Stim Disrupt Flight')
    slanamech=4;
end
if strcmp(etype,'GF Test Pulses')
    slanamech=5;
end

%is airpuff?
airpuffed=0;
if strcmp(etype,'Air Puff Trig Activity')==1
    airpuffed=1;
end
if handles.isIC~=1
    
    if ~isempty(chtoa)
        time=handles.Data(:,1);
        stim=handles.Data(:,5);
        Fs=mean(diff(time));
        %determine airpuff data
        if airpuffed>0
            airpuffch=get(handles.air_puff_ch_menu,'Value');
            ispuffing=zeros(size(handles.Data(:,airpuffch+1)));
            time=handles.Data(:,1);
            ispuffing(find(handles.Data(:,airpuffch+1)>4))=1;
            puffontimes=time(find(diff(ispuffing)==1));
            puffofftimes=time(find(diff(ispuffing)==-1));
            puffdurations=puffofftimes-puffontimes;
        end
        for i=1:size(chtoa,2)
            ch=handles.Data(:,chtoa(i)+1);
            % SL analysis, recreate-ch for 'supernumary/extra' spikes
            if slanamech>0
                if slanamech==1
                    SLdata=APshortlatencyanalysis(handles.Data,chtoa(i)+1,10);
                end
                if slanamech==2
                    SLdata=APshortlatencyanalysis(handles.Data,chtoa(i)+1,5);
                end
                dstim=diff(stim);
                st=find(dstim>3.5);
                if slanamech==3
                    ecst=handles.fileinfo.BurstFrequency*handles.fileinfo.BurstDuration;
                    hD=handles.Data(st(ecst)+1:end,:);
                    SLdata=APshortlatencyanalysis(hD,chtoa(i)+1,5);
                    
                end
                if slanamech==4
                    SLdata=APshortlatencyanalysis(handles.Data,chtoa(i)+1,5);
                end
                
                if slanamech==5
                    SLdata=APshortlatencyanalysis(handles.Data,chtoa(i)+1,10);
                end
                
                %remove 5 ms (10 ms for ll) around stim
                
                for j=1:numel(st)
                    if slanamech==1
                        ch(st(j):st(j)+(10/(Fs*1000)))=nan;
                    end
                    if slanamech==2
                        ch(st(j):st(j)+(5/(Fs*1000)))=nan;
                    end
                    if slanamech==3
                       if(st(j)>ecst)
                          ch(st(j):st(j)+(5/(Fs*1000)))=nan;
                       end
                    end
                     if slanamech==4
                        ch(st(j):st(j)+(5/(Fs*1000)))=nan;
                    end
                     if slanamech==5
                        ch(st(j):st(j)+(10/(Fs*1000)))=nan;
                    end
                end
                
                
            end
            
            a=APspkfltr(time,ch,ampthresh);
            b=APspkfindr2(time,a,stthresh);
            h=figure;
            maxt=max(time);
            mint=min(time);
            maxv=max(a);
            minv=min(a);
            maxt=maxt+.2*(maxt-mint);
            mint=mint-.2*(maxt-mint);
            maxv=maxv+.2*(maxv-minv);
            minv=minv-.2*(maxv-minv);
            plot(b(:,1),b(:,2),'b+')
            title({['Select Spikes:'];[handles.NAME,' channel: ',num2str(chtoa(i))];[chname{chtoa(i)}]},'Interpreter','none')
            iax=[mint maxt minv maxv];
            axis(iax);
            iaxlim={[num2str(mint),',',num2str(maxt),',',num2str( minv),',',num2str( maxv)]};
            alimits=inputdlg('Enter Axes Limits','Axis Limits',1,iaxlim);
            if ~isempty(str2num(alimits{1}))
                if size(str2num(alimits{1}),2)==4
                    iax=str2num(alimits{1});
                end
            end
            axis(iax);
            [ps xs ys]=selectdata;
            EtypeV=get(handles.ETYPE_menu,'Value');
            EtypeN=get(handles.ETYPE_menu,'String');
            Etype=[EtypeN{EtypeV}];
            demographics=cell(3,9);
            demographics{1,1}=Etype;
            demographics{1,2}=date;
            demographics{1,3}='End Time';
            demographics{1,4}=num2str(max(time));
            demographics{2,1}=handles.NAME;
            demographics{2,2}=handles.fileinfo.Genotype;
            demographics{2,3}='';
            demographics{2,4}=handles.fileinfo.Sex;
            demographics{2,5}=handles.fileinfo.Age;
            demographics{3,1}='Spike Time';
            demographics{3,2}='Spike Amplitude';
            demographics{3,3}='Stim Times';
            demographics{3,4}='Stim Amplitude';
            if slanamech>0
                demographics{3,5}='Resp';
                demographics{3,6}='Resp Latency';
                demographics{3,7}='Resp Amplitude';
            end
            if airpuffed>0
                demographics{3,8}='AP Onset';
                demographics{3,9}='AP Duration';
            end
            if handles.LEDstim==1
                demographics{2,10}='LED Stim ON';
               demographics{3,10}='Flash Onset';
               demographics{3,11}='Flash Dur (s)';
               demographics{3,12}='DC';
            end
            
            savexlinfo=1;
            xlstat='';
            XLFILENAME=[handles.SPKTIMEPATH,'\',handles.NAME,'_',chname{chtoa(i)},'SpkTimes.xlsx'];
            try
                xlstat=xlsfinfo(XLFILENAME);
            catch
            end
            if~isempty(xlstat)
                a=questdlg([XLFILENAME,' Already Exists. Do you want to continue'],'Warning');
                savexlinfo=strcmp(a,'Yes');
            end
            if savexlinfo==1
                xlswrite(XLFILENAME,demographics,'Sheet1','A1');
                try
                    xlswrite(XLFILENAME,[xs ys],'Sheet1','A4');
                catch
                    warndlg('Warning: No Spikes Detected or Selected');
                end
                STIMTIMES=APfindstimtimes(handles.Data);
                if handles.LEDstim==1
                    LEDstimtimes=APLEDstimProps(handles.Data(:,5),handles.Data(:,1),20000);
                    xlswrite(XLFILENAME,LEDstimtimes,'Sheet1','J4');
                end
                    
                if ~isempty(STIMTIMES);
                    xlswrite(XLFILENAME,APfindstimtimes(handles.Data),'Sheet1','C4');
                    
                end
                if slanamech>0
                    Spstring='E4';
                    if slanamech==3
                        Spstring=['E',num2str(handles.fileinfo.BurstFrequency*handles.fileinfo.BurstDuration+4)];
                    end
                    xlswrite(XLFILENAME,SLdata,'Sheet1',Spstring);
                end
                if airpuffed>0
                    xlswrite(XLFILENAME,[puffontimes puffdurations],'Sheet1','H4');
                end
            end
            close(h)
            XLF{i}=XLFILENAME;
            handles.output.createdSTfiles{i}=XLFILENAME;
        end
        CHLDISC=cell(1,11);
        CHLDISC{1}=handles.NAME;
        CHLDISC{2}= handles.FILENAME;
        for i=1:size(chtoa,2)
            CHLDISC{chtoa(i)*3}=chname{chtoa(i)};
            CHLDISC{chtoa(i)*3+1}=XLF{i};
            CHLDISC{chtoa(i)*3+2}=date;
        end
        APaddtospktmtable(CHLDISC);
        APaddtoetypetable(handles.FILENAME,Etype);
        
    end
end
if handles.isIC==1
    i=1;
    time=handles.Data(:,1);
    stim=handles.Data(:,5);
    temp=handles.Data(:,5);
    ch=handles.Data(:,2);
    ch=handles.FV;
    Fs=mean(diff(time));
    % SL analysis, recreate-ch for 'supernumary/extra' spikes
    if slanamech>0
        if slanamech==1
            SLdata=APshortlatencyanalysis(handles.Data,chtoa(i)+1,10,0,1,ch);
        end
        if slanamech==2
            SLdata=APshortlatencyanalysis(handles.Data,chtoa(i)+1,5,0,1,ch);
        end
        dstim=diff(stim);
        st=find(dstim>3.5);
        if slanamech==3
            ecst=handles.fileinfo.BurstFrequency*handles.fileinfo.BurstDuration;
            hD=handles.Data(st(ecst)+1:end,:);
            chD=ch(st(ecst)+1:end,:);
            SLdata=APshortlatencyanalysis(hD,chtoa(i)+1,5,0,1,chD);
            
        end
        %remove 5 ms (10 ms for ll) around stim
        
        for j=1:numel(st)
            if slanamech==1
                ch(st(j):st(j)+(10/(Fs*1000)))=nan;
            end
            if slanamech==2
                ch(st(j):st(j)+(5/(Fs*1000)))=nan;
            end
            if slanamech==3
                if(st(j)>ecst)
                    ch(st(j):st(j)+(5/(Fs*1000)))=nan;
                end
            end
        end
        
        
    end
    
    
    a=APspkfltr(time,ch,ampthresh);
    b=APspkfindr2(time,a,stthresh);
    h=figure;
    maxt=max(time);
    mint=min(time);
    maxv=max(a);
    minv=min(a);
    maxt=maxt+.2*(maxt-mint);
    mint=mint-.2*(maxt-mint);
    maxv=maxv+.2*(maxv-minv);
    minv=minv-.2*(maxv-minv);
    if maxv>1
        maxv=1;
    end
    if minv<-0.5
       minv=-0.5; 
    end
    plot(b(:,1),b(:,2),'b+')
    title({['Select Spikes:'];[handles.NAME,' channel: ',num2str(chtoa(i))];[chname{chtoa(i)}]},'Interpreter','none')
    iax=[mint maxt minv maxv];
    axis(iax);
    iaxlim={[num2str(mint),',',num2str(maxt),',',num2str( minv),',',num2str( maxv)]};
    alimits=inputdlg('Enter Axes Limits','Axis Limits',1,iaxlim);
    if ~isempty(str2num(alimits{1}))
        if size(str2num(alimits{1}),2)==4
            iax=str2num(alimits{1});
        end
    end
    axis(iax);
    [ps xs ys]=selectdata;
    EtypeV=get(handles.ETYPE_menu,'Value');
    EtypeN=get(handles.ETYPE_menu,'String');
    Etype=['Intracellular ', EtypeN{EtypeV}];
    demographics=cell(3,9);
    demographics{1,1}=Etype;
    demographics{1,2}=date;
    demographics{1,3}='End Time';
    demographics{1,4}=num2str(max(time));
    demographics{2,1}=handles.NAME;
    demographics{2,2}=handles.fileinfo.Genotype;
    demographics{2,3}='';
    demographics{2,4}=handles.fileinfo.Sex;
    demographics{2,5}=handles.fileinfo.Age;
    demographics{3,1}='Spike Time';
    demographics{3,2}='Spike Amplitude';
    demographics{3,3}='Stim Times';
    demographics{3,4}='Stim Amplitude';
    demographics{3,8}='Temp Time';
    demographics{3,9}='Temp (C)';
    if slanamech>0
        demographics{3,5}='Resp';
        demographics{3,6}='Resp Latency';
        demographics{3,7}='Resp Amplitude';
    end
    savexlinfo=1;
    xlstat='';
    XLFILENAME=[handles.SPKTIMEPATH,'\',handles.NAME,'_',chname{chtoa(i)},'SpkTimes.xlsx'];
    try
        xlstat=xlsfinfo(XLFILENAME);
    catch
    end
    if~isempty(xlstat)
        a=questdlg([XLFILENAME,' Already Exists. Do you want to continue'],'Warning');
        savexlinfo=strcmp(a,'Yes');
    end
    if savexlinfo==1
        xlswrite(XLFILENAME,demographics,'Sheet1','A1');
        try
            xlswrite(XLFILENAME,[xs ys],'Sheet1','A4');
        catch
            warndlg('Warning: No Spikes Detected or Selected');
        end
        
        try
            Ftemp=filtfilt(ones(1,1500)/1500,1,temp);
            Dtemp=downsample(Ftemp,1500);
            Ttemp=downsample(time,1500);
            xlswrite(XLFILENAME,[Ttemp,Dtemp],'Sheet1','H4')
        catch
            warndlg('Error Writing Temperature Info');
        end
        %         STIMTIMES=APfindstimtimes(handles.Data);
        %         if ~isempty(STIMTIMES);
        %             xlswrite(XLFILENAME,APfindstimtimes(handles.Data),'Sheet1','C4');
        %
        %         end
        % if slanamech>0
        %     xlswrite(XLFILENAME,SLdata,'Sheet1','E4');
        % end
        
    end
    close(h)
    XLF{i}=XLFILENAME;
    handles.ostruct.createdSTfiles{i}=XLFILENAME;
    APaddtoetypetable(handles.FILENAME,Etype);
    CHLDISC=cell(1,11);
    CHLDISC{1}=handles.NAME;
    CHLDISC{2}= handles.FILENAME;
    for i=1:size(chtoa,2)
        CHLDISC{chtoa(i)*3}=chname{chtoa(i)};
        CHLDISC{chtoa(i)*3+1}=XLF{i};
        CHLDISC{chtoa(i)*3+2}=date;
    end
    APaddtoICspktmtable(CHLDISC);
end
guidata(hObject,handles);
uiresume(gcf)


% --- Executes on button press in output_chk.
function output_chk_Callback(hObject, eventdata, handles)
% hObject    handle to output_chk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of output_chk
handles.output.succ=~get(hObject,'Value');
guidata(hObject,handles);


% --- Executes on button press in ICFilterChk.
function ICFilterChk_Callback(hObject, eventdata, handles)
% hObject    handle to ICFilterChk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ICFilterChk



function LP_CO_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LP_CO_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LP_CO_edit as text
%        str2double(get(hObject,'String')) returns contents of LP_CO_edit as a double


% --- Executes during object creation, after setting all properties.
function LP_CO_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP_CO_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function amp_thresh_edit_Callback(hObject, eventdata, handles)
% hObject    handle to amp_thresh_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amp_thresh_edit as text
%        str2double(get(hObject,'String')) returns contents of amp_thresh_edit as a double
amp=str2num(get(hObject,'String'));
if~isempty(amp)
    if amp>0
        handles.AMP_thresh=amp;
    end
end
set(hObject,'String',num2str(handles.AMP_thresh));
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
        handles.ST_thresh=ST;
    end
end
set(hObject,'String',num2str(handles.ST_thresh));
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


% --- Executes on button press in chk_thresh_btn.
function chk_thresh_btn_Callback(hObject, eventdata, handles)
% hObject    handle to chk_thresh_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.isIC~=1
a=APsetThereshVals(handles.Data,[get(handles.Ch1chk,'Value'),get(handles.Ch2chk,'Value'),get(handles.Ch3chk,'Value')],handles.AMP_thresh,handles.ST_thresh);
end
if handles.isIC==1
    handles.Data(:,2)=handles.FV;
    a=APsetThereshVals(handles.Data,[get(handles.Ch1chk,'Value'),get(handles.Ch2chk,'Value'),get(handles.Ch3chk,'Value')],handles.AMP_thresh,handles.ST_thresh);
end
if sum(a)>0
    handles.AMP_thresh=a(1);
    set(handles.amp_thresh_edit,'String',num2str(handles.AMP_thresh));
    handles.ST_thresh=a(2);
    set(handles.ST_thresh_edit,'String',num2str(handles.ST_thresh));
end
guidata(hObject,handles);


% --- Executes on selection change in air_puff_ch_menu.
function air_puff_ch_menu_Callback(hObject, eventdata, handles)
% hObject    handle to air_puff_ch_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns air_puff_ch_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from air_puff_ch_menu


% --- Executes during object creation, after setting all properties.
function air_puff_ch_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air_puff_ch_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LP_Order_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LP_Order_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LP_Order_edit as text
%        str2double(get(hObject,'String')) returns contents of LP_Order_edit as a double


% --- Executes during object creation, after setting all properties.
function LP_Order_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LP_Order_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HP_CO_edit_Callback(hObject, eventdata, handles)
% hObject    handle to HP_CO_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HP_CO_edit as text
%        str2double(get(hObject,'String')) returns contents of HP_CO_edit as a double


% --- Executes during object creation, after setting all properties.
function HP_CO_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HP_CO_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function HP_order_edit_Callback(hObject, eventdata, handles)
% hObject    handle to HP_order_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HP_order_edit as text
%        str2double(get(hObject,'String')) returns contents of HP_order_edit as a double


% --- Executes during object creation, after setting all properties.
function HP_order_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HP_order_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in refilter_btn.
function refilter_btn_Callback(hObject, eventdata, handles)
% hObject    handle to refilter_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
handles.Fparam=fdesign.bandpass('N,F3db1,F3db2',8,str2num(get(handles.LP_CO_edit,'String'))/15000,str2num(get(handles.HP_CO_edit,'String'))/15000);
handles.FHsos=design(handles.Fparam);
handles.FV=filtfilt(handles.FHsos.sosMatrix,handles.FHsos.ScaleValues,handles.Data(:,2));
axes(handles.axes2);
plot(handles.Data(:,1),handles.FV,'r')
guidata(hObject,handles);
catch
    warndlg('Invalid Parameters')
end

