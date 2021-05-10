% AeroGen - Design and analysis of horizontal axis wind turbines
% Copyright (C) 2016  Abraham Vivas
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.
function varargout = DisAdim(varargin)
% DISADIM MATLAB code for DisAdim.fig
%      DISADIM, by itself, creates a new DISADIM or raises the existing
%      singleton*.
%
%      H = DISADIM returns the handle to a new DISADIM or the handle to
%      the existing singleton*.
%
%      DISADIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISADIM.M with the given input arguments.
%
%      DISADIM('Property','Value',...) creates a new DISADIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DisAdim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DisAdim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DisAdim

% Last Modified by GUIDE v2.5 12-Sep-2015 03:20:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DisAdim_OpeningFcn, ...
                   'gui_OutputFcn',  @DisAdim_OutputFcn, ...
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


% --- Executes just before DisAdim is made visible.
function DisAdim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DisAdim (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(handles.Fig_DisAdim,'windowstyle','modal')

%___________Recuperar información de la figura principal___________
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

handles.p = handlesPrin.p;
handles.rRhub = str2double(get(handlesPrin.Edit_rRhub,'string'));
handles.Z = str2double(get(handlesPrin.Edit_Npalas,'string'));
handles.J = str2double(get(handlesPrin.Edit_Lambdad,'string'));

%inicialización de opciones
handles.Op_F = 1;
handles.Op_Cd = 1;
handles.rR = linspace(0,1,50)*(1 - handles.rRhub) + handles.rRhub;
set(handles.Btn_ClCdOpt,'ForegroundColor','red');

% Choose default command line output for DisAdim
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DisAdim wait for user response (see UIRESUME)
% uiwait(handles.Fig_DisAdim);


% --- Outputs from this function are returned to the command line.
function varargout = DisAdim_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_Disc.
function Btn_Disc_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Disc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.rR = VentDisc();
handles.rR = handles.rR*(1 - handles.rRhub) + handles.rRhub;

guidata(hObject,handles);

% --- Executes on button press in Btn_ClCdOpt.
function Btn_ClCdOpt_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_ClCdOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% _________ Cálculo de alfa óptimo a lo largo de r/R_________

%límites de dominio
amin = handles.p.a.min;
amax = handles.p.a.max;

%Arreglo de puntos de trayectoria óptima entre -2 y 20 grados de ángulos de
%ataque
alfarRA = arrayfun(@(y) fminbnd(@(x) -handles.p.ClCd.Fun3D([x,y])...
    ,-2,amax),handles.rR);

%Interpolación cúbica suavizada
[cs,p]=csaps(handles.rR,alfarRA);
handles.p.a.Fun2D = @(x) fnval(fnxtr(csaps(handles.rR,alfarRA,p*(1-5*10^-4))),x);

%identificador descriptivo de "a" (alfa(r/R))
handles.p.a.tag = 'alfa(r/R)';
handles.p.a.title = 'Ángulo de ataque óptimo';

%___________ Ventana de presentación de resultados ____________

%Creación de la figura
figure('menubar','none','Name','Resultados de cálculo de Clopt y alfaop',...
    'position',[100,100,647.2135,400],'resize','off','tag','Fig_ClCdOpt',...
    'toolbar','figure','visible','off','numbertitle','off');
hClCdOpt = findall(0,'tag','Fig_ClCdOpt');
movegui(hClCdOpt,'center');
set(hClCdOpt,'windowstyle','modal')
set(hClCdOpt,'visible','on');

%Inicialización de variables de gráfica 3D
Da = (amax - amin) / 100;
Alfa = amin:Da:amax;
DrR = (1 - handles.rRhub) / 100;
rR = handles.rRhub:DrR:1;

ClCd = handles.p.ClCd.Fun3D({Alfa,rR}).';

%Gráfica 3D de Cl/Cd con paso óptimo
subplot('position',[0.1 0.275 0.4 0.45]);
surfc(Alfa,rR,ClCd,'linestyle','none');
title('Cl/Cd vs alfa-r/R','fontweight','bold');
xlabel('alfa (°)');
ylabel('r/R');
zlabel('Cl/Cd');
hold on;
plot3(handles.p.a.Fun2D(rR),rR,handles.p.ClCd.Fun3D(handles.p.a.Fun2D(rR),rR),'o');
zl=zlim;
plot3(handles.p.a.Fun2D(rR),rR,zl(1)*ones(length(rR),1),'o','tag','Plot_OptClCd');
legend(findall(hClCdOpt,'tag','Plot_OptClCd'),'Ópt. suavizado','location','best');
rotate3d('on');

%Gráfica 2D de alfaopt vs r/R
subplot('position',[0.6 0.58 0.34 0.34]);
plot(rR,handles.p.a.Fun2D(rR));
title('Ángulo de ataque óptimo vs r/R','fontweight','bold');
ylabel('alfa (°)');
xlabel('r/R');

%Gráfica 2D de Clopt vs r/R
subplot('position',[0.6 0.09 0.34 0.34]);
plot(rR,handles.p.Cl.Fun3D(handles.p.a.Fun2D(rR),rR));
title('Coeficiente de sustentación óptimo vs r/R','fontweight','bold');
ylabel('Cl');
xlabel('r/R');

guidata(hObject,handles);

set(handles.Btn_ClCdOpt,'ForegroundColor','black');
set(handles.Btn_Continuar,'enable','on');

% --- Executes on button press in Btn_CritOpt.
function Btn_CritOpt_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_CritOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Creación de la figura
figure('menubar','none','Name','Criterio óptimo',...
    'position',[100,100,323.606,200],'resize','off','tag','Fig_CritOpt',...
    'toolbar','none','visible','off','numbertitle','off');
hCritOpt = findall(0,'tag','Fig_CritOpt');
movegui(hCritOpt,'center');
set(hCritOpt,'windowstyle','modal')
set(hCritOpt,'visible','on');

str = '$$\frac{dC_p}{da} = 0 ; F=1 ; Cd=0$$';
text(-0.05,0.5,str,'Interpreter','latex','FontSize',20,'FontWeight','bold','units','normalized');
axis off


% --- Executes on button press in Btn_Op_cR.
function Btn_Op_cR_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Op_cR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.Op_F, handles.Op_Cd] = DisAdimOp_cR(handles.Op_F,handles.Op_Cd);
guidata(hObject,handles);

% --- Executes on button press in Btn_Continuar.
function Btn_Continuar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Continuar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DisAdimR(handles.p,handles.Z,handles.J,handles.rR,handles.Op_F,handles.Op_Cd)
