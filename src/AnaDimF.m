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

function varargout = AnaDimF(varargin)
% ANADIMF MATLAB code for AnaDimF.fig
%      ANADIMF, by itself, creates a new ANADIMF or raises the existing
%      singleton*.
%
%      H = ANADIMF returns the handle to a new ANADIMF or the handle to
%      the existing singleton*.
%
%      ANADIMF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANADIMF.M with the given input arguments.
%
%      ANADIMF('Property','Value',...) creates a new ANADIMF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaDimF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaDimF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaDimF

% Last Modified by GUIDE v2.5 20-Sep-2015 19:04:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaDimF_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaDimF_OutputFcn, ...
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


% --- Executes just before AnaDimF is made visible.
function AnaDimF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaDimF (see VARARGIN)

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
handles.R = handlesPrin.Rw(1,3);
w = handlesPrin.Rw(2,3) *2*pi/60;

handles.Data = NaN;

% Configuración de variables

handles.U = w * handles.R;
% Jmin = 1.5;
% Jmax = 15;


% Velocidad de arranque y parada
handles.Vin = handles.c * ( - log( 0.9 ) ).^(1/handles.k);
handles.Vout = handles.c * ( - log( .000000001 ) ).^(1/handles.k);

%Graficación y calculo de EAR
PV_EAR(handles, handles.Vin, handles.Vout)


%Configuración de text edit

set(handles.Edit_Vin, 'string', num2str( handles.Vin) );
set(handles.Edit_Vout, 'string', num2str( handles.Vout) );

% Configuración de menu contextual
c = uicontextmenu;
set(handles.Axe_PV, 'UIContextMenu', c);

uimenu(c,'label','Importar data experimental','callback',{@Importa_Data,handles} ) 
uimenu(c,'label','Exportar','callback',{@Exportar,handles.Axe_PV});




% Choose default command line output for AnaDimF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaDimF wait for user response (see UIRESUME)
% uiwait(handles.Fig_AnaDimF);


% --- Outputs from this function are returned to the command line.
function varargout = AnaDimF_OutputFcn(hObject, eventdata, handles) 
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
Vin = str2double( get(handles.Edit_Vin, 'string') );
Vout = handles.Vout;

%Graficación y calculo de EAR
PV_EAR(handles,Vin,Vout)

handles.Vin = Vin;

guidata(hObject,handles)


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

% Velocidad de arranque
Vin = handles.Vin;
Vout = str2double( get(handles.Edit_Vout, 'string') );

%Graficación y calculo de EAR
PV_EAR(handles,Vin,Vout)

handles.Vout = Vout;

guidata(hObject,handles)

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

function PV_EAR(handles,Vin,Vout)

c = handles.c;
k = handles.k;
F0 = handles.F0;
Cp = handles.Cp;
U = handles.U;
R = handles.R;

% calculo de vectores para P vs V
Vdom = linspace(Vin,Vout);
Pvg = Cp(U ./ Vdom) .* Vdom .^3 * 1/2 * 1.225 * pi * R^2 / 1000;

P = griddedInterpolant( Vdom, Pvg, 'pchip');

%Dibujo de gráfica
hAxe = handles.Axe_PV;

plot(hAxe, Vdom, P(Vdom))
hold(hAxe, 'on')

plot(hAxe, Vin, P(Vin), 'bo','MarkerFaceColor',[0 0 1])
plot(hAxe, Vout, P(Vout), 'ro', 'MarkerFaceColor',[1 0 0])
ylabel(hAxe, 'Potencia (kW)')
xlabel(hAxe, 'Velocidad (m/s)')
title(hAxe,'Curva potencia vs velocidad')
hold(hAxe, 'off')

if ~isnan(handles.Data)
    x = handles.Data(:,1);
    y = handles.Data(:,2);
    hold(handles.Axe_PV,'on')
    plot(handles.Axe_PV, x, y,'ko','MarkerFaceColor','k','tag','Plot_Data')
    legend(findall(handles.Fig_AnaDimF,'tag','Plot_Data'),'Data importada','location','northeast')
    hold(handles.Axe_PV,'off')
end

%Dominio temporal de la integral de EAR
Dt = 365*24*60*60;
tmin = (1 - F0) * Dt * exp( -(Vout / c) ^ k ) + 1;
tmax = (1 - F0) * Dt * exp( -( Vin / c) ^ k ) - 1;
tdom1 = (logspace(0,4,300)-1) / 9999 * (tmax - tmin) + tmin;
tdom2 = sort((10^4 - logspace(0,4,300)) / 9999) * (tmax - tmin) + tmin;
tdom = [tdom1(tdom1 < tmax/2) , tdom2(tdom2 >= tmax/2)];

% dominio de velocidad para cálculo de EAR
VEARdom = c * ( - log( tdom./Dt /(1 - F0) ) ).^(1/k);

% Integración de EAR
EAR = trapz( tdom, P(VEARdom) ) /3600 /10^3;

% EAR calculado
set(handles.Text_EAR,'string',sprintf('Energía anual recuperada (MWh): %0.2f',EAR))



function Importa_Data(hObject, eventdata, handles) 

[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

%Si se ha seleccionado efectivamente un fichero:
if ischar(dirData)
    
    Data = readtable(dirData,'readvariablename',0);
    
    handles.Data = [Data{:,1} , Data{:,2}];
    
    x = handles.Data(:,1);
    y = handles.Data(:,2);
    hold(handles.Axe_PV,'on')
    plot(handles.Axe_PV, x, y,'ko','MarkerFaceColor','k','tag','Plot_Data')
    legend(findall(handles.Fig_AnaDimF,'tag','Plot_Data'),'Data importada','location','northeast')
    hold(handles.Axe_PV,'off')
    
    guidata(hObject,handles);

end
