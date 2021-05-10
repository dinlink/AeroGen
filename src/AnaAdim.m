function varargout = AnaAdim(varargin)
% ANAADIM MATLAB code for AnaAdim.fig
%      ANAADIM, by itself, creates a new ANAADIM or raises the existing
%      singleton*.
%
%      H = ANAADIM returns the handle to a new ANAADIM or the handle to
%      the existing singleton*.
%
%      ANAADIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANAADIM.M with the given input arguments.
%
%      ANAADIM('Property','Value',...) creates a new ANAADIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaAdim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaAdim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaAdim

% Last Modified by GUIDE v2.5 17-Sep-2015 23:02:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaAdim_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaAdim_OutputFcn, ...
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


% --- Executes just before AnaAdim is made visible.
function AnaAdim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaAdim (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
%set(handles.Fig_DisAdim,'windowstyle','modal')

%___________Recuperar información de la figura principal___________
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

handles.p = handlesPrin.p;
handles.cR_th = handlesPrin.cR_th;
handles.rRhub = str2double(get(handlesPrin.Edit_rRhub,'string'));
handles.Z = str2double(get(handlesPrin.Edit_Npalas,'string'));


%inicialización de opciones
handles.Jmin = 0.05;
handles.Jmax = 15;

handles.Op_F = 1;
handles.Op_Cd = 2;
handles.Op_Cx = 1;
handles.Op_Stall = 1;
handles.Op_Cp = 1;
handles.Op_ChkDebug = 0;
handles.rR = linspace(0,1,200)*(1 - handles.rRhub) + handles.rRhub;
handles.J = (logspace(0,4,200)-1)/9999*(handles.Jmax - handles.Jmin) + handles.Jmin;

%___Antiguo ajuste de extensión de perfiles
% % Calcular extensión de data2D de perfiles
% amin = handles.p.a.min;
% amax = handles.p.a.max;
% Ds = 6;
% rR = handles.rR;
% a = linspace(-90,90);
% 
% handles.p.Cl.plate = @(a) 2 * sin( a / 180*pi) .* cos( a / 180*pi);
% Coef = handles.p.Cl;
% handles.p.Cl.x90 = griddedInterpolant({a,rR},AplicExt(a,rR,amin,amax,Ds,Coef).','spline','linear');
% 
% handles.p.Cd.plate = @(a) 2 * sin( a / 180*pi ) .^ 2;
% Coef = handles.p.Cd;
% handles.p.Cd.x90 = griddedInterpolant({a,rR},AplicExt(a,rR,amin,amax,Ds,Coef).','spline','linear');


% Choose default command line output for AnaAdim
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaAdim wait for user response (see UIRESUME)
% uiwait(handles.Fig_AnaAdim);


% --- Outputs from this function are returned to the command line.
function varargout = AnaAdim_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_Disc_rR.
function Btn_Disc_rR_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Disc_rR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.rR = VentDisc(200);
handles.rR = handles.rR * (1 - handles.rRhub) + handles.rRhub;

guidata(hObject,handles);

% --- Executes on button press in Btn_Disc_Lambda.
function Btn_Disc_Lambda_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Disc_Lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.J = VentDisc(200,2);
handles.J = handles.J * (handles.Jmax - handles.Jmin) + handles.Jmin;

guidata(hObject,handles);

% --- Executes on button press in Btn_Ext2D.
function Btn_Ext2D_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Ext2D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AnaAdim_Cext(handles)


% --- Executes on button press in Btn_OpExt.
function Btn_OpExt_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_OpExt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.Op_F, handles.Op_Cd, handles.Op_Cx, handles.Op_Stall, handles.Op_Cp] = ...
    AnaAdim_Op(handles);

guidata(hObject,handles)

% --- Executes on button press in Btn_OpCp.
function Btn_OpCp_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_OpCp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Btn_Continuar.
function Btn_Continuar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Continuar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AnaAdimR(handles)


function Res = AplicExt(a,rR,amin,amax,Ds,Coef)

f = DSS(a,amin,amax,Ds);
f = f(ones(1, length(rR)), : );

plate = Coef.plate(a);
plate = plate(ones(1, length(rR)), : );

Res = Coef.Fun3D({a,rR}).' .* (1 - f)+ plate .* f;


% --- Executes on button press in Chk_Debug.
function Chk_Debug_Callback(hObject, eventdata, handles)
% hObject    handle to Chk_Debug (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Op_ChkDebug = get(hObject,'value');

guidata(hObject,handles)
% Hint: get(hObject,'Value') returns toggle state of Chk_Debug
