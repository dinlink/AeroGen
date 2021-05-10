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
function varargout = Opt_R(varargin)
% OPT MATLAB code for Opt_R.fig
%      OPT, by itself, creates a new OPT or raises the existing
%      singleton*.
%
%      H = OPT returns the handle to a new OPT or the handle to
%      the existing singleton*.
%
%      OPT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPT.M with the given input arguments.
%
%      OPT('Property','Value',...) creates a new OPT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Opt_R_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Opt_R_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Opt_R

% Last Modified by GUIDE v2.5 25-Oct-2015 23:48:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Opt_R_OpeningFcn, ...
                   'gui_OutputFcn',  @Opt_R_OutputFcn, ...
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


% --- Executes just before Opt_R is made visible.
function Opt_R_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Opt_R (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
%set(hObject,'windowstyle','modal')

%_____Recuperación de valores de ventana principal_____
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

handles.Cp = handlesPrin.Cp{1,3};
handles.c = handlesPrin.ckF0(1,3);
handles.k = handlesPrin.ckF0(2,3);
handles.F0 = handlesPrin.ckF0(3,3);
handles.Jn = handlesPrin.Cp{2,3}(1);
handles.param = varargin{1};
handles.paramID = varargin{2};

if handles.paramID == 'P'
    handles.factor = 1000;
else
    handles.factor = 1;
end

handles.param = handles.param * handles.factor;

handles.Kvdom = linspace(0.1,5,100);

c = handles.c;
k = handles.k;

%Función de velocidad
aux1 = (logspace(0,4,300)-0.9999) / 9999;
aux2 = sort((10^4 - logspace(0,4,300)) / 9999); 
dom = [aux1(aux1 < 0.5) , aux2(aux2 >= 0.5)];

% Función de velocidad en función del tiempo (porcentaje anual)
handles.V = griddedInterpolant( [dom, 1.1, 1.2, 1.3], [c * ( - log( dom ) ).^(1/k), 0, 0, 0], 'pchip') ;

% Configuración de variables
handles.Vin = c * ( - log( 0.9 ) ).^(1/k);
handles.Vout = c * ( - log( .000000001 ) ).^(1/k);


%Configuración de text edit

set(handles.Edit_Vin, 'string', num2str( handles.Vin) );
set(handles.Edit_Vout, 'string', num2str( handles.Vout) );
set(handles.Edit_Param, 'string', num2str( handles.param / handles.factor ) );



% Configuración de texto

if handles.paramID == 'P'
    set(handles.Text_Param, 'string', 'Potencia nominal deseada (kW)' );
else
    set(handles.Text_Param, 'string', '  Radio nominal deseado (m)' );
end


% Configuración de menu contextual
c1 = uicontextmenu;
set(handles.Axe_PV, 'UIContextMenu', c1);

uimenu(c1,'label','Exportar','callback',{@Exportar,handles.Axe_PV});

c2 = uicontextmenu;
set(handles.Axe_Kv, 'UIContextMenu', c2);

uimenu(c2,'label','Exportar','callback',{@Exportar,handles.Axe_Kv});


% Choose default command line output for Opt_R
handles.output = hObject;

%Graficación y calculo de EAR
handles = Optimo(handles);

% Update handles structure
guidata(hObject, handles)


% UIWAIT makes Opt_R wait for user response (see UIRESUME)
% uiwait(handles.Fig_Opt_R);


% --- Outputs from this function are returned to the command line.
function varargout = Opt_R_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Edit_Vin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Vin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Velocidad de arranque
handles.Vin = str2double( get(handles.Edit_Vin, 'string') );

%Graficación y calculo de EAR
handles = Optimo(handles);

guidata(hObject, handles)




% Hints: get(hObject,'String') returns contents of Edit_Vin as text
%        str2double(get(hObject,'String')) returns contents of Edit_Vin as a double


% --- Executes during object creation, after setting all properties.
function Edit_Vin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Vin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Vout_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Vout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Velocidad de parada
handles.Vout = str2double( get(handles.Edit_Vout, 'string') );

%Graficación y calculo de EAR
handles = Optimo(handles);

guidata(hObject,handles);


% Hints: get(hObject,'String') returns contents of Edit_Vout as text
%        str2double(get(hObject,'String')) returns contents of Edit_Vout as a double


% --- Executes during object creation, after setting all properties.
function Edit_Vout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Vout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Param_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Param as text
%        str2double(get(hObject,'String')) returns contents of Edit_Param as a double

% Velocidad de arranque
handles.param = str2double( get(handles.Edit_Param, 'string') ) * handles.factor;

%Gráfica P_V
Grafica_PV(handles)


guidata(handles.Fig_Opt_R,handles)



% --- Executes during object creation, after setting all properties.
function Edit_Param_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function handles = Optimo(handles)

Cp = handles.Cp;
c = handles.c;
k = handles.k;
F0 = handles.F0;
Jn = handles.Jn;
Vin = handles.Vin;
Vout = handles.Vout;
V = handles.V;


% Dominio de variable a optimizar
Kv = handles.Kvdom;
Kvl = length(Kv);

%Varaibles pertinentes para el cálculo de EAR
U = Jn * Kv * c;

%Dominio temporal de la integral de EAR
Dt = 365*24*60*60;
tmin = (1 - F0) * Dt * exp( -(Vout / c) .^ k ) ;
tmax = (1 - F0) * Dt * exp( -( Vin / c) .^ k ) ;

aux1 = (logspace(0,4,300)-1) / 9999;
aux2 = sort((10^4 - logspace(0,4,300)) / 9999); 
aux3 = [aux1(aux1 < 0.5) , aux2(aux2 >= 0.5)].';
al = length(aux3);

tdom = aux3( :, ones(1,Kvl)) * (tmax - tmin) + tmin;

% dominio de velocidad para cálculo de EAR
Vdom = reshape( V(tdom(:) / Dt /(1 - F0) ), [al, Kvl]);

%Calculo de Cp para la matriz de evaluación
U = U(ones(1,al), :);
J = U ./ Vdom;

%Vector Cp
Cpvg = reshape( Cp(J(:) ) , [al, Kvl]);

% Integrando de EAR real : Cp * V^3
IntR = Cpvg .* Vdom.^3;

% Integrando de EAR ideal : CpI * V^3
IntI = 16/27 * Vdom.^3;

% Integración de EAR
C_EAR = trapz(tdom(:,1), IntR )./ trapz(tdom(:,1), IntI ) ;

% Función de interpolación
handles.C_EAR = griddedInterpolant(Kv, C_EAR, 'pchip');

%Cálculo de Kv óptimo
Kvval = fminbnd( @(x) - handles.C_EAR(x), Kv(1), Kv(end) );
handles.Kv = Kvval;


% GRAFICACION

%Gráfica V(t)
Grafica_Vt(handles)

%Gráfica EAR(Kv)
Grafica_EAR(handles)

%Gráfica P_V
Grafica_PV(handles)





function Grafica_Vt(handles)

%Función
V = handles.V;

%Puntos importantes
c = handles.c;
k = handles.k;

Vin = handles.Vin;
Vout = handles.Vout;
Pin = exp( - (Vin/c)^k);
Pout = exp( - (Vout/c)^k);


% Rango
aux1 = (logspace(0,4,100)-1) / 9999;
aux2 = sort((10^4 - logspace(0,4,100)) / 9999); 
Pr = [aux1(aux1 < 0.5) , aux2(aux2 >= 0.5)];

%Graficación
hAxe = handles.Axe_Vt;

plot(hAxe, V(Pr), Pr * 100)

hold(hAxe, 'on')

plot(hAxe, Vin, Pin * 100, 'bo','MarkerFaceColor',[0 0 1])
plot(hAxe, Vout, Pout * 100, 'ro', 'MarkerFaceColor',[1 0 0])
ylabel(hAxe, 'Probabilidad de velocidad mayores a Vx (%)')
xlabel(hAxe, 'Vx (m/s)')
title(hAxe,'Probabilidad en función de la velocidad')
hold(hAxe, 'off')

axis(hAxe, [0 25 0 101])

function Grafica_EAR(handles)

%Función
C_EAR = handles.C_EAR;

%Puntos importantes
Kvval = handles.Kv;
C_EARval = C_EAR(Kvval);



% Dominio
Kvdom = handles.Kvdom;

%Graficación

hAxe = handles.Axe_Kv;
line = plot(hAxe, Kvdom, C_EAR(Kvdom));

hold(hAxe, 'on')

plot(hAxe, Kvval, C_EARval , 'go','MarkerFaceColor',[0 1 0])
t = text(Kvval, C_EARval - 0.1, sprintf('(%0.2f, %0.2f)',Kvval, C_EARval ));
set(t, 'HorizontalAlignment', 'center');
set(t, 'Parent', hAxe);


ylabel(hAxe, 'Coeficiente de EAR = EAR_R / EAR_I')
xlabel(hAxe, 'Coeficiente de velocidad nominal Kv')
title(hAxe,'Coeficiente de energía anual recuperada')
hold(hAxe, 'off')

%Crear movimiento de punto optimo
set(line ,'buttondownfcn',@Mover_punto)



function Grafica_PV(handles)

%Función
Cp = handles.Cp;

%Otros parámetros
param = handles.param ;
Jn = handles.Jn;
Cpn = Cp(Jn);

Vn = handles.Kv * handles.c;

if handles.paramID == 'R'
    Rn = param;
    Pn = Cpn * 1/2 *1.225 * Vn^3 * pi * Rn^2;
else
    Rn = sqrt( param / ( Cpn * 1/2 *1.225 * Vn^3 * pi) );
    Pn = param;
end

wn = Jn * Vn / Rn;

%Puntos importantes
Vin = handles.Vin;
Vout = handles.Vout;

% Dominio
Vdom = linspace(0,25,200);

% Función Final

P = @(V) Cp(Jn * Vn ./ V) .*  V .^3 * 1/2 * 1.225 * pi * Rn^2 / 1000;

% axes handle
hAxe = handles.Axe_PV;

%Graficación
plot(hAxe, Vdom, P(Vdom))

hold(hAxe, 'on')

plot(hAxe, Vin, P(Vin), 'bo','MarkerFaceColor',[0 0 1])
plot(hAxe, Vout, P(Vout), 'ro', 'MarkerFaceColor',[1 0 0])
plot(hAxe, Vn, P(Vn), 'mo', 'MarkerFaceColor',[1 0.2 0.8], 'tag', 'PtoNominal')

ylabel(hAxe, 'Potencia (kW)')
xlabel(hAxe, 'Velocidad (m/s)')
title(hAxe,'Potencia vs velocidad')
legend(findall(handles.Fig_Opt_R,'tag','PtoNominal'), 'Punto Nominal', 'Location', 'northwest')
hold(hAxe, 'off')

%Escritura de valores calculados

%EAR
CpI = 16/27;
c = handles.c;
k = handles.k;
F0 = handles.F0;

%Dominio temporal de la integral de EAR
Dt = 365*24*60*60;
tmin = (1 - F0) * Dt * exp( -(Vout / c) .^ k ) ;
tmax = (1 - F0) * Dt * exp( -( Vin / c) .^ k ) ;

aux1 = (logspace(0,4,300)-1) / 9999;
aux2 = sort((10^4 - logspace(0,4,300)) / 9999); 
aux3 = [aux1(aux1 < 0.5) , aux2(aux2 >= 0.5)];
tdom = aux3 * (tmax - tmin) + tmin;

V = handles.V;
C_EAR = handles.C_EAR;
Kv = handles.Kv;

EAR = CpI * 1/2 * 1.225 * pi * Rn^2 * trapz(tdom, V(tdom/Dt /(1 - F0)).^3) * C_EAR(Kv) /3600 / 10^6;

set(handles.Text_EAR,'string',sprintf('Energía anual recuperada (MWh): %0.2f',EAR))

% Dimensiones Óptimas

if handles.paramID == 'R'
    set(handles.Text_Rw,'string',sprintf('Potencia nominal (kW): %0.2f        Velocidad angular óptima (rpm): %0.0f '...
    ,Pn/1000, wn * 60 /(2*pi) ))
else
    set(handles.Text_Rw,'string',sprintf('Radio óptimo (m): %0.2f        Velocidad angular óptima (rpm): %0.0f '...
    ,Rn, wn * 60 /(2*pi) ))
end

function Mover_punto(hObject, event)
hOpt = findall(0,'tag','Fig_Opt_R');
handles = guidata(hOpt);

Point = get(handles.Axe_Kv,'CurrentPoint');

handles.Kv = Point(1,1);

%Gráfica EAR(Kv)
Grafica_EAR(handles)

%Gráfica P_V
Grafica_PV(handles)




guidata(hOpt,handles)
