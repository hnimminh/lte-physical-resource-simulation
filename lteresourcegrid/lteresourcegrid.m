%% DEVELOPER: NGUYEN HOANG MINH 
% LTEPHYSYSICAL RESOURCE GRID

function varargout = lteresourcegrid(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lteresourcegrid_OpeningFcn, ...
                   'gui_OutputFcn',  @lteresourcegrid_OutputFcn, ...
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
%% End initialization code - DO NOT EDIT

function lteresourcegrid_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
addpath('Library');
%=========================================================================
%set(handles.allchk,'value',1);
pos=get(handles.prb14box,'position');
set(handles.prb3box,'position',pos);
set(handles.prb5box,'position',pos);
set(handles.prb10box,'position',pos);
set(handles.prb15box,'position',pos);
set(handles.prb20box,'position',pos);
%% ========================================================================

function varargout = lteresourcegrid_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to hFigcmd
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;


function bwbox_Callback(hObject, eventdata, handles)

CPmodebox_Callback(hObject, eventdata, handles)

 switch get(handles.bwbox,'value')
     case 1
        vib14='on';vib3='off';vib5='off';vib10='off';vib15='off';vib20='off';
     case 2
        vib14='off';vib3='on';vib5='off';vib10='off';vib15='off';vib20='off';
     case 3
         vib14='off';vib3='off';vib5='on';vib10='off';vib15='off';vib20='off';
     case 4
         vib14='off';vib3='off';vib5='off';vib10='on';vib15='off';vib20='off';
     case 5
         vib14='off';vib3='off';vib5='off';vib10='off';vib15='on';vib20='off';
     case 6
         vib14='off';vib3='off';vib5='off';vib10='off';vib15='off';vib20='on';
 end
         set(handles.prb14box,'visible',vib14);
         set(handles.prb3box,'visible',vib3);
         set(handles.prb5box,'visible',vib5);
         set(handles.prb10box,'visible',vib10);
         set(handles.prb15box,'visible',vib15);
         set(handles.prb20box,'visible',vib20);
function bwbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function CPmodebox_Callback(hObject, eventdata, handles)
% =========================================================================
% LAY & CHUYEN DOI CAC GIA TRI SONG SONG VOI KIEM SOAT 'VISIBLE' CUA OBJECT
% =========================================================================
bandwidth=[1.4 3 5 10 15 20];bw=bandwidth(get(handles.bwbox,'value'));
cp=get(handles.CPmodebox,'value');
[ubw,prb,sc,sps,fs,fft,Lcp]=lteparameter(bw,cp);

set(handles.retxt,'string',num2str(12*sps*20*prb));
ubw=num2str(ubw);set(handles.ubwtxt,'string',ubw);
prb=num2str(prb);set(handles.prbtxt,'string',prb);
sc=num2str(sc);set(handles.sctxt,'string',sc);
sps=num2str(sps);set(handles.spstxt,'string',sps);
fs=num2str(fs);set(handles.fstxt,'string',fs);
fft=num2str(fft);set(handles.ffttxt,'string',fft);

%================= CP length ==================
if Lcp(1)==5.2
    set(handles.text32,'visible','off');
    set(handles.text33,'visible','on');
    set(handles.text34,'visible','on');
    set(handles.Lcpntxt,'visible','on');
else
    set(handles.text32,'visible','on');
    set(handles.text33,'visible','off');
    set(handles.text34,'visible','off');
    set(handles.Lcpntxt,'visible','off');
end
Lcpe=num2str(Lcp(1));set(handles.Lcpetxt,'string',Lcpe);
Lcpn=num2str(Lcp(2));set(handles.Lcpntxt,'string',Lcpn);
function CPmodebox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function typebox_Callback(hObject, eventdata, handles)

switch get(handles.typebox,'value')
    case 1
        set(handles.linkpanel,'visible','on');
        set(handles.modepanel,'visible','off');
        set(handles.pfipanel,'visible','off');
    case 2
        set(handles.linkpanel,'visible','off');
        set(handles.modepanel,'visible','on');
        set(handles.modepanel,'position',get(handles.linkpanel,'position'));
        set(handles.pfipanel,'visible','on');
end
function typebox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function CFIbox_Callback(hObject, eventdata, handles)
function CFIbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function antenbox_Callback(hObject, eventdata, handles)
function antenbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function allchk_Callback(hObject, eventdata, handles)

function tddmodebox_Callback(hObject, eventdata, handles)
function tddmodebox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function hFigcmd_Callback(hObject, eventdata, handles)
%% LAY & QUY DOI CAC GIA TRI THAM CHIEU

    bandwidth=[1.4 3 5 10 15 20];BW=bandwidth(get(handles.bwbox,'value'));
    Ncp=8-get(handles.CPmodebox,'value');
    ant=[1 2 4];Nant=ant(get(handles.antenbox,'value'));
    Tlink=get(handles.downlink,'value');
    Tframe=get(handles.typebox,'value');
    CFI=get(handles.CFIbox,'value');
    apfi=[0 1 3 4 5];Mpfi=apfi(get(handles.pfibox,'value')); %PUCCH Format indicator
    Mode=get(handles.tddmodebox,'value')-1;

%% TINH TOAN 'MAP' TAO MATRAN MAU THICH HOP, TUONG TAC VOI "minhcolor(map)"

    if Tframe==1                        % FFD FRAMESTRUSTURE
        if Tlink==0                     % UPLINK
            if BW<5, map=5;
            else map=6;end
        elseif Tlink==1                 % DOWNLINK
            switch Nant
            case 1,map=7;
            case 2,map=8;
            case 4,map=10;
            end
        end
    elseif Tframe==2                    % TDD FRAMESTRUSTURE
        if BW<5
            switch Nant
            case 1,map=14;
            case 2,map=15.1;
            case 4,map=17;
            end        
        else
             switch Nant
             case 1,map=15.2;
             case 2,map=16;
             case 4,map=18;
             end
        end
    end
%% KIEM SOAT DIEU KIEN, VE LUOI TAI NGUYEN LTE

    if Tframe==1                                            % FFD FRAMESTRUSTURE
        if Tlink==0                                         % UPLINK
            matrix=lteprgfdduplink(BW,Ncp,Mpfi);
        elseif Tlink==1                                     % DOWNLINK
            matrix = lteprgfdddownlink(BW,Ncp,CFI,Nant);
        end
    elseif Tframe==2                                        % TDD FRAMESTRUSTURE
        matrix=lteprgtdd(BW,Ncp,CFI,Nant,Mpfi,Mode);
    end
   
    newfiguregrid(matrix,[.8 .8 .8],map,1);

%%

function figure_ResizeFcn(hObject, eventdata, handles)

function sfbox_Callback(hObject, eventdata, handles)
function sfbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prb14box_Callback(hObject, eventdata, handles)
v=get(handles.prb14box,'value');
set(handles.Vprb,'string',num2str(v));
function prb14box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prb3box_Callback(hObject, eventdata, handles)
v=get(handles.prb3box,'value');
set(handles.Vprb,'string',num2str(v));
function prb3box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prb5box_Callback(hObject, eventdata, handles)
v=get(handles.prb5box,'value');
set(handles.Vprb,'string',num2str(v));
function prb5box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prb10box_Callback(hObject, eventdata, handles)
v=get(handles.prb10box,'value');
set(handles.Vprb,'string',num2str(v));
function prb10box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prb15box_Callback(hObject, eventdata, handles)
v=get(handles.prb15box,'value');
set(handles.Vprb,'string',num2str(v));
function prb15box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prb20box_Callback(hObject, eventdata, handles)
v=get(handles.prb20box,'value');
set(handles.Vprb,'string',num2str(v));
function prb20box_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Vprb_Callback(hObject, eventdata, handles)
function Vprb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function resourcegridupt_ClickedCallback(hObject, eventdata, handles)

cla(handles.gridaxes,'reset');
set(handles.piepanel,'visible','off');

%% HIEU UNG STATUSBAR

    P=get(handles.runbar,'position');Q=P;
        for i=1:10
        pause(.01);
        P(3)=P(3)-4.9;
        P(1)=P(1)+4.9;
        set(handles.runbar,'position',P);
        end
        pause(.01);
    set(handles.runbar,'position',Q);

    
%% LAY & QUY DOI CAC GIA TRI THAM CHIEU

    bandwidth=[1.4 3 5 10 15 20];BW=bandwidth(get(handles.bwbox,'value'));
    Ncp=8-get(handles.CPmodebox,'value');
    ant=[1 2 4];Nant=ant(get(handles.antenbox,'value'));
    Tlink=get(handles.downlink,'value');
    Tframe=get(handles.typebox,'value');
    CFI=get(handles.CFIbox,'value');
    apfi=[0 1 3 4 5];Mpfi=apfi(get(handles.pfibox,'value')); %PUCCH Format indicator
    Mode=get(handles.tddmodebox,'value')-1;

%% TINH TOAN 'MAP' TAO MATRAN MAU THICH HOP, TUONG TAC VOI "minhcolor(map)"

    if Tframe==1                        % FFD FRAMESTRUSTURE
        PF=10;
        if Tlink==0                     % UPLINK
            if BW<5, map=5;
            else map=6;end
        elseif Tlink==1                 % DOWNLINK
            switch Nant
            case 1,map=7;
            case 2,map=8;
            case 4,map=10;
            end
        end
    elseif Tframe==2                    % TDD FRAMESTRUSTURE
        if BW<5
            switch Nant
            case 1,PF=7;map=14;
            case 2,PF=8;map=15.1;
            case 4,PF=10;map=17;
            end        
        else
             switch Nant
             case 1,PF=7;map=15.2;
             case 2,PF=8;map=16;
             case 4,PF=10;map=18;
             end
        end
    end
%% KIEM SOAT DIEU KIEN, VE LUOI TAI NGUYEN LTE

    if Tframe==1                                            % FFD FRAMESTRUSTURE
        if Tlink==0                                         % UPLINK
            matrix=lteprgfdduplink(BW,Ncp,Mpfi);
            Name=('FDD-Uplink');%matrix=matrix+10;
        elseif Tlink==1                                     % DOWNLINK
            matrix = lteprgfdddownlink(BW,Ncp,CFI,Nant);
            Name=('FDD-Downlink');
        end
    elseif Tframe==2                                        % TDD FRAMESTRUSTURE
        matrix=lteprgtdd(BW,Ncp,CFI,Nant,Mpfi,Mode);
        Name=('TDD');
    end

%% HIEN THI MA TRAN [THEO DIEU KIEN HIEN THI]

        switch get(handles.allchk,'value')
            case 0        
                opengrid(matrix,[.8 .8 .8],map,1,['LTE Resource Grid, ' Name]);
            case 1
                sf=get(handles.sfbox,'value')-1;
                prb=str2double(get(handles.Vprb,'string'))-1;
                s=size(matrix);         %s(1)=hang  s(2) cot
                k=s(2)/10;              %k = so cot trong 1PRB; so hang cua 1 PRB = 12
                h=s(1)/12;              %h = so PRB trong 1 slot
                ia=(h-prb-1)*12+1;      %vi tri hang cat dau      +1 de bat dau tu 1
                iz=ia+12-1;             %vi tri hang cat cuoi     -1 de ket thuc 1 prb
                ja=sf*k+1;              % vi tri cot cat dau
                jz=ja+k-1;              % vi tri cot cat cuoi
                matrix=filtermatrix(matrix,ia,iz,ja,jz);
                opengrid(matrix,[.8 .8 .8],map,1,['Physical Resource Block, ' Name]);
        end

%% THONG KE SO LIEU FFD FRAME STRUSTURE

     if Tframe==1                                                          % FFD FRAMESTRUSTURE
        if Tlink==0,                                                       % UPLINK
            set(handles.iduppanel,'visible','on');
            set(handles.iddownpanel,'visible','off');
            set(handles.idptspanel,'visible','off');
            matrix=matrix+PF;
        else                                                               % DOWNLINK
            set(handles.iduppanel,'visible','off');
            set(handles.iddownpanel,'visible','on');
            set(handles.idptspanel,'visible','off');
        end
    elseif Tframe==2                                                       % TDD FRAMESTRUSTURE
            set(handles.iduppanel,'visible','on');
            set(handles.iddownpanel,'visible','on');
            set(handles.idptspanel,'visible','on');
        sz=size(matrix);
        for i=1:sz(1)
            for j=1:sz(2)
            if (matrix(i,j)>PF),matrix(i,j)=matrix(i,j)+(10-PF);end
            if BW<5
                if matrix(i,j)== 17, matrix(i,j)=18;end
                if matrix(i,j)== 16, matrix(i,j)=17;end
            end         
            end
        end
    end          

%==========================================================================
             
                R=zeros(1,18);
            for i=1:length(R),R(i)=strematrix(matrix,i);end   
                
                S=sum(sum(R));
            for i=1:length(R),R(i)=100*R(i)/S;end
            
                set(handles.pdu1txt,'string',data2string(R(1)));
                set(handles.pdu2txt,'string',data2string(R(2)));
                set(handles.pdu3txt,'string',data2string(R(3)));
                set(handles.pdu4txt,'string',data2string(R(4)));
                set(handles.pdu5txt,'string',data2string(R(5)));
                set(handles.pdu6txt,'string',data2string(R(6)));
                set(handles.pdu7txt,'string',data2string(R(7)));
                set(handles.pdu8txt,'string',data2string(R(8)));
                set(handles.pdu9txt,'string',data2string(R(9)));
                set(handles.pdu10txt,'string',data2string(R(10)));
                set(handles.pdu11txt,'string',data2string(R(11)));
                set(handles.pdu12txt,'string',data2string(R(12)));
                set(handles.pdu13txt,'string',data2string(R(13)));
                set(handles.pdu14txt,'string',data2string(R(14)));
                set(handles.pdu15txt,'string',data2string(R(15)));
                set(handles.pdu16txt,'string',data2string(R(16)));
                set(handles.pdu17txt,'string',data2string(R(17)));
                set(handles.pdu18txt,'string',data2string(R(18)));
 
     

%% LAP BIEU DO HINH DIA

        P=delarray(R,0);
        if get(handles.allchk,'value')==0 
            L=ones(1,length(P));
            istr={''};strlg={''};for i=1:length(P)-1, strlg=[strlg istr];end
            set(handles.piepanel,'visible','on');
            pie(handles.pieaxes,P,L,strlg);
        end
   
function ltefaceupt_ClickedCallback(hObject, eventdata, handles)
lteface

function pfibox_Callback(hObject, eventdata, handles)
function pfibox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function linkpanel_SelectionChangeFcn(hObject, eventdata, handles)
switch get(eventdata.NewValue,'Tag') 
    case 'downlink'
        set(handles.pfipanel,'visible','off');
    case 'uplink'
        set(handles.pfipanel,'visible','on');
end

function figure_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);
