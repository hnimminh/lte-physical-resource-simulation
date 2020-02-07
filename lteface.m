% DEVERLOPER: NGUYEN HOANG MINH
% LTE-FACE Mainform of LTE Project
function varargout = lteface(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lteface_OpeningFcn, ...
                   'gui_OutputFcn',  @lteface_OutputFcn, ...
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
end
% End initialization code - DO NOT EDIT

function lteface_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
%==========================================================================
h=imread('.\Design\ltelogo.bmp');imshow(h);
hgrid=imread('.\Design\block.bmp');set(handles.gridcmd,'cdata',hgrid);
hlink=imread('.\Design\graph.bmp');set(handles.linkcmd,'cdata',hlink);
hrate=imread('.\Design\rate.bmp');set(handles.dataratecmd,'cdata',hrate);
habout=imread('.\Design\about.bmp');set(handles.aboutcmd,'cdata',habout);
%==========================================================================
end
function varargout = lteface_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
%==========================================================================
p=get(handles.cover,'position');q=p;
    for n=1:1:50
        pause(.05);
        p(2)=p(2)-0.2;
        set(handles.cover,'position',p);
    end
    set(handles.cover,'position',q);
    for n=1:11
        if mod(n,2)==0,v='on';else v='off';end
        set(handles.cover,'visible',v);pause(.1);
    end
end

function gridcmd_ButtonDownFcn(hObject, eventdata, handles),end
function gridcmd_CreateFcn(hObject, eventdata, handles)
end
function gridcmd_Callback(hObject, eventdata, handles)
set(handles.figure,'visible','off');
addpath('.\lteresourcegrid');lteresourcegrid;
end

function linkcmd_Callback(hObject, eventdata, handles)
set(handles.figure,'visible','off');
addpath('.\ltelink');ltelink;
end


function dataratecmd_Callback(hObject, eventdata, handles)
set(handles.figure,'visible','off');
addpath('.\ltedatarate');ltedatarate;
end

function aboutcmd_Callback(hObject, eventdata, handles)
    haxes=imread('.\Design\inform.bmp');set(handles.axescmd,'cdata',haxes);
    if strcmp(get(handles.axescmd,'visible'),'off')==1
        set(handles.axescmd,'visible','on');set(handles.axescmd,'position',[32 7 127 30.77]);
        set(handles.cover,'visible','on');set(handles.cover,'position',[102 1 70 10]);
        set(handles.grouppanel,'visible','off');
    else
        set(handles.axescmd,'visible','off');
        set(handles.grouppanel,'visible','on');
        set(handles.cover,'visible','off');
    end
end

function axescmd_Callback(hObject, eventdata, handles)
end
