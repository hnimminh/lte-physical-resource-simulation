% DEVELOPER: NGUYEN HOANG MINH
% LTE LINK, LTE PROJECT
function varargout = ltedatarate(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ltedatarate_OpeningFcn, ...
                   'gui_OutputFcn',  @ltedatarate_OutputFcn, ...
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
 
function ltedatarate_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
addpath('.\Library');
 end

function varargout = ltedatarate_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
end

function holdchk_Callback(hObject, eventdata, handles)
end

function styletxt_Callback(hObject, eventdata, handles)
end
function styletxt_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function bandwidthbox_Callback(hObject, eventdata, handles)
prb=[6 15 25 50 75 100];Vprb=prb(get(handles.bandwidthbox,'value'));
nsymb=[7 6];Vnsymb=nsymb(get(handles.cyclicprefixbox,'value'));
bit=[2 4 6];Vbit=bit(get(handles.modulationbox,'value'));
Vre=12*Vprb*20*Vnsymb;

set(handles.prbtxt,'string',num2str(Vprb));
set(handles.nsymbtxt,'string',num2str(Vnsymb));
set(handles.bittxt,'string',num2str(Vbit));
set(handles.retxt,'string',num2str(Vre));
end
function bandwidthbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function modulationbox_Callback(hObject, eventdata, handles)
bandwidthbox_Callback(hObject, eventdata, handles)
end
function modulationbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function cyclicprefixbox_Callback(hObject, eventdata, handles)
bandwidthbox_Callback(hObject, eventdata, handles)
end
function cyclicprefixbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function upantenabox_Callback(hObject, eventdata, handles)
end
function upantenabox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function downoption_Callback(hObject, eventdata, handles),end

function upoption_Callback(hObject, eventdata, handles),end


function rateupt_ClickedCallback(hObject, eventdata, handles)
set(handles.status,'string','Loading...');pause(0.1);
set(handles.hfigcmd,'visible','off');set(handles.modcmd,'visible','off');
%==========================================================================
style='null b-*  g-o  r-s  c-d  m-v  y-p  k-h';
temp=str2double(get(handles.styletxt,'string'))+1;
if temp<=6, set(handles.styletxt,'string',num2str(temp));
else set(handles.styletxt,'string','0');end
%==========================================================================
if get(handles.holdchk,'value')==0,cla(handles.axes,'reset');end
%==========================================================================
abw=[1.4 3 5 10 15 20];
acode=[1/3 1/2 2/3 3/4 4/5];
if get(handles.downoption,'value')==1,Link='downlink';
elseif get(handles.downoption,'value')==0,Link='uplink';
end

if strcmp(Link,'downlink')==1
    atx=[2 2 4 4];Ntx=atx(get(handles.downantenabox,'value'));
    arx=[2 4 2 4];Nrx=arx(get(handles.downantenabox,'value'));
    dulr=2/13;
elseif strcmp(Link,'uplink')==1
    atx=[1 1 2 2];Ntx=atx(get(handles.upantenabox,'value'));
    arx=[2 4 2 4];Nrx=arx(get(handles.upantenabox,'value'));
    dulr=1/17;
end
acode=acode*dulr;
switch get(handles.modulationbox,'value')
    case 1, Modulation='QPSK';
    case 2, Modulation='16QAM';
    case 3, Modulation='64QAM';
end
switch get(handles.cyclicprefixbox,'value')
    case 1, CyclicPrefix='normal';
    case 2, CyclicPrefix='extended';
end

Bandwidth=abw(get(handles.bandwidthbox,'value'));
coding=acode(get(handles.codingbox,'value'));
[SNRdB,DRM]=ltecapacity(Bandwidth,Modulation,CyclicPrefix,Ntx,Nrx);

DR=DRM*coding;

plot(SNRdB,DR,style(temp*5+1:temp*5+3),'linewidth',2);grid on;hold on;
title('LTE DATA RATE');xlabel('SNR');ylabel('DATA RATE [Mbit/s]');
%==========================================================================
set(handles.status,'string','Done!');
pause(1);set(handles.status,'string','Ready');
end

function codingbox_Callback(hObject, eventdata, handles),end
function codingbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function downantenabox_Callback(hObject, eventdata, handles),end
function downantenabox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function linkpanel_SelectionChangeFcn(hObject, eventdata, handles)
switch get(eventdata.NewValue,'Tag')
    case 'downoption'
        set(handles.downantenabox,'visible','on');
        set(handles.upantenabox,'visible','off');
    case 'upoption'
        set(handles.downantenabox,'visible','off');
        set(handles.upantenabox,'visible','on');
end
end

function resourcegridupt_ClickedCallback(hObject, eventdata, handles)
set(handles.status,'string','Loading...');pause(0.1);
cla(handles.axes,'reset');
set(handles.hfigcmd,'visible','on');set(handles.modcmd,'visible','off');
%==========================================================================
abw=[1.4 3 5 10 15 20];BW=abw(get(handles.bandwidthbox,'value'));
Ncp=8-get(handles.cyclicprefixbox,'value');
if get(handles.downoption,'value')==1,Link='downlink';
elseif get(handles.downoption,'value')==0,Link='uplink';
end

    if strcmp(Link,'downlink')==1

    %     answer=inputdlg('Enter Control Format Indicator, CFI={1 2 3}: ','Enter CFI');
    %     CFI=str2num(answer{1});set(handles.cfitxt,'string',answer{1});
    
        atx=[2 2 4 4];Ntx=atx(get(handles.downantenabox,'value'));
        CFI=2;map=10;
        matrix = lteprgfdddownlink(BW,Ncp,CFI,Ntx);
        Name=('LTE Resource Grid FDD-Uplink');
    elseif strcmp(Link,'uplink')==1
        Mpfi=1;map=6;
        matrix=lteprgfdduplink(BW,Ncp,Mpfi);
        Name=('LTE Resource Grid FDD-Downlink');
    end
    
    opengrid(matrix,[.8 .8 .8],map,1,Name);
    
%==========================================================================
set(handles.status,'string','Done!');pause(1);set(handles.status,'string','Ready');
end


function hfigcmd_Callback(hObject, eventdata, handles)
abw=[1.4 3 5 10 15 20];BW=abw(get(handles.bandwidthbox,'value'));
Ncp=8-get(handles.cyclicprefixbox,'value');
if get(handles.downoption,'value')==1,Link='downlink';
elseif get(handles.downoption,'value')==0,Link='uplink';
end

    if strcmp(Link,'downlink')==1
        atx=[2 2 4 4];Ntx=atx(get(handles.downantenabox,'value'));
        CFI=2;map=10;
        matrix = lteprgfdddownlink(BW,Ncp,CFI,Ntx);
    elseif strcmp(Link,'uplink')==1
        Mpfi=1;map=6;
        matrix=lteprgfdduplink(BW,Ncp,Mpfi);
    end
    
    newfiguregrid(matrix,[.8 .8 .8],map,1);

end

function cfitxt_Callback(hObject, eventdata, handles)
end
function cfitxt_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function ltefaceupt_ClickedCallback(hObject, eventdata, handles)
lteface
end



function modupt_ClickedCallback(hObject, eventdata, handles)
set(handles.status,'string','Loading...');pause(0.1);
set(handles.hfigcmd,'visible','off');set(handles.modcmd,'visible','on');
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
set(handles.status,'string','Done!');pause(.4);set(handles.status,'string','Ready');
end


% --- Executes on button press in modcmd.
function modcmd_Callback(hObject, eventdata, handles)
prompt={'Enter binary data :','Frequency :','SNR :'};
answer = inputdlg(prompt,'Data Input');
bin=str2num(answer{1});f=str2num(answer{2});snr=str2num(answer{2});

switch get(handles.modulationbox,'value')
    case 1
        [mbit,qpsk,Vn,mdeb,Hx,Hy,k,L]= qpsksys(bin,f,snr);
        figure('name','Modulation Signal');
        subplot(4,1,1);plot(mbit,'r','linewidth',2);axis([0  k*L -0.5 1.5]);legend('Data in');grid on;
        subplot(4,1,2);plot(qpsk,'m','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('QPSK mod ');grid on;
        subplot(4,1,3);plot(Vn,'g','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('QPSK mod & AWGN');grid on;
        subplot(4,1,4);plot(mdeb,'k','linewidth',1.5);axis([0  k*L -0.5 1.5]);legend('QPSK demod');grid on;
    case 2
        [mbit,qam,Vn,mdeb,Hx,Hy,k,L]= qam16sys(bin,f,snr);
        figure('name','Modulation Signal');
        subplot(4,1,1);plot(mbit,'r','linewidth',2);axis([0  k*L -0.5 1.5]);legend('Data in');grid on;
        subplot(4,1,2);plot(qam,'m','linewidth',1.5);axis([0  k*L -5 5]);legend('QAM mod ');grid on;
        subplot(4,1,3);plot(Vn,'g','linewidth',1.5);axis([0  k*L -5 5]);legend('QAM mod & AWGN');grid on;
        subplot(4,1,4);plot(mdeb,'k','linewidth',1.5);axis([0  k*L -0.5 1.5]);legend('QAM demod');grid on;
    case 3, msgbox('Modulated format 64QAM not support! Thank, Minh.');
end
figure('name','Synchronous Signal');
subplot(2,1,1);plot(Hx,'g','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('Horizontal Synchronous Xcos Wave');grid on;
subplot(2,1,2);plot(Hy,'m','linewidth',1.5);axis([0  k*L -2.5 2.5]);legend('Vertical Synchronus Ycos Wave');grid on;   
end


% --------------------------------------------------------------------
function waveupt_ClickedCallback(hObject, eventdata, handles)
set(handles.status,'string','Loading...');pause(0.1);
set(handles.hfigcmd,'visible','off');set(handles.modcmd,'visible','off');
cla(handles.axes,'reset');
%==========================================================================
if get(handles.downoption,'value')==1,Link='downlink';
elseif get(handles.downoption,'value')==0,Link='uplink';
end
switch get(handles.modulationbox,'value')
    case 1, Modulation='QPSK';
    case 2, Modulation='16QAM';
    case 3, Modulation='64QAM';
end

FFTsize=[128 256 512 1024 1536 2048];
Nsubcarrier=FFTsize(get(handles.bandwidthbox,'value'));
Nsymbol=Nsubcarrier/2;


if strcmp(Link,'downlink')==1
        [x,y]=ofdmsig(Modulation,Nsubcarrier,Nsymbol);
        name='OFDM Signal Wave Form ';color=[0 1 0];
elseif strcmp(Link,'uplink')==1
        [x,y]=scfdmsig(Modulation,Nsubcarrier,Nsymbol,'LFDMA','rc',0.22);
        name='SC-FDMA Signal Wave Form';color=[1 0 0];
end

 plot(x,y,'color',color);grid on;hold on;axis off;
 title(name);xlabel('Times (s)');ylabel('Amplitude (V)');

%==========================================================================
set(handles.status,'string','Done!');pause(1);set(handles.status,'string','Ready');
end
