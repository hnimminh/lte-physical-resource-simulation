%% DEVELOPER: NGUYEN HOANG MINH
%% LTE LINK, LTE PROJECT
function varargout = ltelink(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ltelink_OpeningFcn, ...
                   'gui_OutputFcn',  @ltelink_OutputFcn, ...
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
end

function ltelink_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
addpath('.\Library');
end

function varargout = ltelink_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
end


function modulationbox_Callback(hObject, eventdata, handles),end
function modulationbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function databsizebox_Callback(hObject, eventdata, handles),end
function databsizebox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function pulseshapebox_Callback(hObject, eventdata, handles),end
function pulseshapebox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function fftsizebox_Callback(hObject, eventdata, handles),end
function fftsizebox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function rollofftxt_Callback(hObject, eventdata, handles),end
function rollofftxt_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function holdonchk_Callback(hObject, eventdata, handles),end

function fdmatypebox_Callback(hObject, eventdata, handles)

switch get(handles.fdmatypebox,'value')
    case 1
        fdmatype='OFDMA';color=[0 1 0];%green
    case 2
        fdmatype='LFDMA';color=[1 0 0];%red
%     case 3
%         fdmatype='DFDMA';color=[1 0 1];%magenta
%     case 4
%         fdmatype='IFDMA';color=[1 .7 0];%orange
end
set(handles.fdmatypetxt,'string',num2str(fdmatype));
set(handles.colortxt,'string',color);
end
function fdmatypebox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function fdmatypetxt_Callback(hObject, eventdata, handles),end
function fdmatypetxt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function colortxt_Callback(hObject, eventdata, handles),end
function colortxt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function paprupt_ClickedCallback(hObject, eventdata, handles)
set(handles.modcmd,'visible','off');
set(handles.status,'string','Loading...');pause(.1);
if get(handles.holdonchk,'value')==0,cla(handles.axes,'reset');end
%==========================================================================
switch get(handles.pulseshapebox,'value')
    case 1,PulseShapingFilter='rc';
    case 2,PulseShapingFilter='rrc';
    case 3,PulseShapingFilter='none';
end

switch get(handles.modulationbox,'value')
    case 1, Modulation='QPSK';
    case 2, Modulation='16QAM';
    case 3, Modulation='64QAM';
end

datasize=[16 32 64 128 256 512 1024 1536 2048];
Nsymbol=datasize(get(handles.databsizebox,'value'));

FFTsize=[128 256 512 1024 1536 2048];
Nsubcarrier=FFTsize(get(handles.fftsizebox,'value'));

RolloffFactor=str2double(get(handles.rollofftxt,'string'));
SubcarrierMapping=get(handles.fdmatypetxt,'string');
color=str2num(get(handles.colortxt,'string'));

if strcmp(SubcarrierMapping,'OFDMA')==1
        [M,X]=paprofdma(Modulation,Nsubcarrier,Nsymbol);
else
        [M,X]=paprscfdma(Modulation,Nsubcarrier,Nsymbol,SubcarrierMapping,PulseShapingFilter,RolloffFactor);
end
semilogy(X,M,'color',color,'linewidth',2);hold on;grid on;
title('PAPR OFDMA vs SC-FDMA');xlabel('PAPRo [dB]');ylabel('Probability(PAPR > PAPRo)');
%==========================================================================
set(handles.status,'string','Done!');pause(.4);
set(handles.status,'string','Ready');
end

function waveupt_ClickedCallback(hObject, eventdata, handles)
set(handles.modcmd,'visible','off');
set(handles.status,'string','Loading...');pause(0.1);
cla(handles.axes,'reset');
%==========================================================================
switch get(handles.pulseshapebox,'value')
    case 1,PulseShapingFilter='rc';
    case 2,PulseShapingFilter='rrc';
    case 3,PulseShapingFilter='none';
end
switch get(handles.modulationbox,'value')
    case 1, Modulation='QPSK';
    case 2, Modulation='16QAM';
    case 3, Modulation='64QAM';
end

FFTsize=[128 256 512 1024 1536 2048];
Nsubcarrier=FFTsize(get(handles.fftsizebox,'value'));

datasize=[16 32 64 128 256 512 1024 1536 2048];
Nsymbol=datasize(get(handles.databsizebox,'value'));

RolloffFactor=str2double(get(handles.rollofftxt,'string'));
SubcarrierMapping=get(handles.fdmatypetxt,'string');

color=str2num(get(handles.colortxt,'string'));

if strcmp(SubcarrierMapping,'OFDMA')==1
        [x,y]=ofdmsig(Modulation,Nsubcarrier,Nsymbol);
        name='OFDM Signal Wave Form ';
else
        [x,y]=scfdmsig(Modulation,Nsubcarrier,Nsymbol,SubcarrierMapping,PulseShapingFilter,RolloffFactor);
        name='SC-FDMA Signal Wave Form';
end

 plot(x,y,'color',color);grid on;axis off;
 title(name);xlabel('Times (s)');ylabel('Amplitude (V)');


% chanel=inputdlg({'Enter signal noise ratio (SNR): ','Enter Doppler shift frequency for Rayleigh Fading(Hz): '},'Chanel Input');
% doppler=str2num(chanel{1});snr=str2num(chanel{2});
% noise=awgn(y,snr,'measured');
% Fs=[1.4e6 3e6 5e6 10e6 15e6 20e6];Ts=1/Fs(get(handles.fftsizebox,'value'));
% fading=rayleighchan(Ts,doppler);rayleigh=filter(fading,y);
% figure('name','Signal Wave Form, Deverloper: Nguyen Hoang Minh');
% subplot(3,1,1);plot(t,y,'color','g');grid on;xlabel('Times (s)');ylabel('Amplitude (V)');title('Original');
% subplot(3,1,2);plot(t,noise,'color','r');grid on;xlabel('Times (s)');ylabel('Amplitude (V)');title('Add white Gauss Noise');
% subplot(3,1,3);plot(t,rayleigh,'color','m');grid on;xlabel('Times (s)');ylabel('Amplitude (V)');title('Rayleigh Fading Chanel');
%==========================================================================
set(handles.status,'string','Done!');
pause(1);set(handles.status,'string','Ready');
end

function modcmd_Callback(hObject, eventdata, handles)
    
prompt={'Enter binary data :','Frequency :','SNR :'};
answer = inputdlg(prompt,'Data Input');
bin=str2num(answer{1});f=str2num(answer{2});snr=str2num(answer{3});

switch get(handles.modulationbox,'value')
    case 1
        [mbit,qpsk,Vn,mdeb,Hx,Hy,k,L]= qpsksys(bin,f,snr);
        figure('name','Modulation Signal, Deverloper: Nguyen Hoang Minh');
        subplot(4,1,1);plot(mbit,'r','linewidth',2);axis([0  k*L -0.5 1.5]);legend('Data in');grid on;
        subplot(4,1,2);plot(qpsk,'m','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('QPSK mod ');grid on;
        subplot(4,1,3);plot(Vn,'g','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('QPSK mod & AWGN');grid on;
        subplot(4,1,4);plot(mdeb,'k','linewidth',1.5);axis([0  k*L -0.5 1.5]);legend('QPSK demod');grid on;
    case 2
        [mbit,qam,Vn,mdeb,Hx,Hy,k,L]= qam16sys(bin,f,snr);
        h=figure(1);set(h,'name','Modulation Signal, Deverloper: Nguyen Hoang Minh');
        subplot(4,1,1);plot(mbit,'r','linewidth',2);axis([0  k*L -0.5 1.5]);legend('Data in');grid on;
        subplot(4,1,2);plot(qam,'m','linewidth',1.5);axis([0  k*L -5 5]);legend('QAM mod ');grid on;
        subplot(4,1,3);plot(Vn,'g','linewidth',1.5);axis([0  k*L -5 5]);legend('QAM mod & AWGN');grid on;
        subplot(4,1,4);plot(mdeb,'k','linewidth',1.5);axis([0  k*L -0.5 1.5]);legend('QAM demod');grid on;
    case 3, msgbox('Modulated format 64QAM not support! Thank, Minh.');
end
fig=figure(2);set(fig,'name','Modulation Signal, Deverloper: Nguyen Hoang Minh');
subplot(2,1,1);plot(Hx,'g','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('Horizontal Synchronous Xcos Wave');grid on;
subplot(2,1,2);plot(Hy,'m','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('Vertical Synchronus Ycos Wave');grid on;   
end

function modupt_ClickedCallback(hObject, eventdata, handles)
set(handles.status,'string','Loading...');pause(0.1);
set(handles.modcmd,'visible','on');
cla(handles.axes,'reset');
%==========================================================================
switch get(handles.modulationbox,'value')
    case 1
        x=[-1 -1 1 1];
        y=[-1 1 -1 1];
        decac=[-2 2 -2 2];
    case 2 
        x=[-3 -1 1 3 -3 -1 1 3 -3 -1 1 3 -3 -1 1 3];
        y=[3 3 3 3 1 1 1 1 -1 -1 -1 -1 -3 -3 -3 -3];
        decac=[-4 4 -4 4];
    case 3
        xi=[-7 -5 -3 -1 1 3 5 7];x=[xi xi xi xi xi xi xi xi];
        yi=[-7 -7 -7 -7 -7 -7 -7 -7];y=[yi yi+2 yi+4 yi+6 yi+8 yi+10 yi+12 yi+14];
        decac=[-8 8 -8 8];
end
scatter(x,y,300,'sr');axis(decac);grid on;hold on;title('Constellation Diagram Modulation');xlabel('In-Phase');ylabel('Quadrature');
line([-8 8],[0 0],'LineStyle','--','color','m','linewidth',2);line([0 0],[-8 8],'LineStyle','--','color','m','linewidth',2);
%==========================================================================
set(handles.status,'string','Done!');pause(.4);
set(handles.status,'string','Ready');
end

function ltefaceupt_ClickedCallback(hObject, eventdata, handles)
lteface
end

function pulseshapingupt_ClickedCallback(hObject, eventdata, handles)
set(handles.modcmd,'visible','off');
set(handles.status,'string','Loading...');pause(0.1);
cla(handles.axes,'reset');
%==========================================================================
Nos = 4;
datasize=[16 32 64 128 256 512 1024 1536 2048];
Nsymbol=datasize(get(handles.databsizebox,'value'));
RolloffFactor=str2double(get(handles.rollofftxt,'string'));

switch get(handles.pulseshapebox,'value')
    case 1,h  = fdesign.pulseshaping(Nos,'Raised Cosine','Nsym,Beta',Nsymbol,RolloffFactor);
           Hd = design(h);fvtool(Hd, 'impulse');
    case 2,h  = fdesign.pulseshaping(Nos,'Square Root Raised Cosine','Nsym,Beta',Nsymbol,RolloffFactor);
           Hd = design(h);fvtool(Hd, 'impulse');
    case 3,msgbox('Not used Pulse Shape Filter');
end
  
%==========================================================================
set(handles.status,'string','Done!');pause(.4);
set(handles.status,'string','Ready');
end
