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

function varargout = AnaAdimDebug(varargin)
% ANAADIMDEBUG MATLAB code for AnaAdimDebug.fig
%      ANAADIMDEBUG, by itself, creates a new ANAADIMDEBUG or raises the existing
%      singleton*.
%
%      H = ANAADIMDEBUG returns the handle to a new ANAADIMDEBUG or the handle to
%      the existing singleton*.
%
%      ANAADIMDEBUG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANAADIMDEBUG.M with the given input arguments.
%
%      ANAADIMDEBUG('Property','Value',...) creates a new ANAADIMDEBUG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaAdimDebug_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaAdimDebug_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaAdimDebug

% Last Modified by GUIDE v2.5 17-Sep-2015 19:20:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaAdimDebug_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaAdimDebug_OutputFcn, ...
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


% --- Executes just before AnaAdimDebug is made visible.
function AnaAdimDebug_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaAdimDebug (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
%set(handles.Fig_AnaAdimDebug,'windowstyle','modal')

% Recuperación de data
Jmax = varargin{1};
Ji = varargin{2};
S = varargin{3};
n = varargin{4};
nmax = varargin{5};
tol = varargin{6};
a0 = varargin{7}(1,:);
ap0 = varargin{7}(2,:);
aS = varargin{8}(1,:);
apS = varargin{8}(2,:);
fi0 = varargin{9}(1,:);
th = varargin{10}(1,:);
Cl3D0 = varargin{11}(1,:);
Cd3D0 = varargin{12}(1,:);
Cn3D0 = varargin{13}(1,:);
Ct3D0 = varargin{14}(1,:);
rR = varargin{15}(1,:);

Axe_a = handles.Axe_a;
Axe_ap = handles.Axe_ap;
Axe_fi = handles.Axe_fi;
Axe_Cl = handles.Axe_Cl;
Axe_Cd = handles.Axe_Cd;
Axe_CnCt = handles.Axe_CnCt;

%Graficación


plot(Axe_a, rR, a0,'.', rR, aS, '.');
title(Axe_a,'Factor de inducción axial')
legend(Axe_a,'Iteración anterior','Iteración siguiente','location','best');


plot(Axe_ap, rR, ap0,'.', rR, apS, '.');
title(Axe_ap,'Factor de inducción tangencial')
legend(Axe_ap,'Iteración anterior','Iteración siguiente','location','northeast');

plot(Axe_fi, rR, fi0 *180/pi,'.', rR, (fi0 - th) *180/pi, '.');
title(Axe_fi,'Ángulos de flujo y ataque')
legend(Axe_fi,'Ángulo de flujo','Ángulo de ataque','location','northeast');

plot(Axe_Cl, rR, Cl3D0,'.');
title(Axe_Cl,'Coeficiente de sustentación')

plot(Axe_Cd, rR, Cd3D0,'.');
title(Axe_Cd,'Coeficiente de arrastre')

plot(Axe_CnCt, rR, Cn3D0,'.',rR, Ct3D0,'.');
title(Axe_CnCt,'Coeficientes de empuje axial y tangencial del perfil')
legend(Axe_CnCt,'Axial','Tangencial','location','northeast');

%Texto
str = sprintf('nmax = %d;   tol_abs = %0.0e;   Puntos sin converger = %d;   iteración = %d;   velocidad específica = %0.3f',nmax,tol,S,n,Ji);

%Fin de iteraciones, continuar
handles.Continuar = 0;

handles.Ji = Ji;
handles.Jmax = Jmax;
handles.n = n;
handles.nmax = nmax;
handles.S = S;

set(handles.Text_Status,'string',str);
% Choose default command line output for AnaAdimDebug
handles.output = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaAdimDebug wait for user response (see UIRESUME)
uiwait(handles.Fig_AnaAdimDebug);


% --- Outputs from this function are returned to the command line.
function varargout = AnaAdimDebug_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

if or( handles.output, handles.Continuar)
    delete(hObject)
end


% --- Executes on button press in Btn_Sig_it.
function Btn_Sig_it_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Sig_it (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if and( and( or( handles.S == 0, handles.n == handles.nmax), handles.Ji == handles.Jmax ) , ~handles.Continuar  )
    handles.Continuar = 1;
    set(handles.Btn_Sig_it, 'string', 'Continuar');
    set(handles.Btn_Cancelar, 'enable','off');
    guidata(hObject,handles)
else
    uiresume(handles.Fig_AnaAdimDebug);
end

% --- Executes on button press in Btn_Cancelar.
function Btn_Cancelar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Cancelar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = 1;

guidata(hObject,handles);

uiresume(handles.Fig_AnaAdimDebug);


% --- Executes when user attempts to close Fig_AnaAdimDebug.
function Fig_AnaAdimDebug_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Fig_AnaAdimDebug (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end
