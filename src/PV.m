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
function varargout = PV(varargin)
% PV MATLAB code for PV.fig
%      PV, by itself, creates a new PV or raises the existing
%      singleton*.
%
%      H = PV returns the handle to a new PV or the handle to
%      the existing singleton*.
%
%      PV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PV.M with the given input arguments.
%
%      PV('Property','Value',...) creates a new PV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PV_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PV_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PV

% Last Modified by GUIDE v2.5 22-Jun-2015 17:03:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PV_OpeningFcn, ...
                   'gui_OutputFcn',  @PV_OutputFcn, ...
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


% --- Executes just before PV is made visible.
function PV_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PV (see VARARGIN)

% Choose default command line output for PV
handles.output = hObject;

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(gcf,'windowstyle','modal')

%Recuperar la información de la ventana principal
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

handles.hPrin = hPrin;
handles.handlesPrin = handlesPrin;

%Mostrar Tabla
set(handles.Tab_PV,'Data',handlesPrin.DataPV{:,:})
set(handles.Tab_PV,'ColumnName',{'V (m/s)','P (kW)'})

%Crear función de interpolación PV
x_dat = handlesPrin.DataPV.(1);
y_dat = handlesPrin.DataPV.(2);
handles.handlesPrin.CurvaPV = pchip(x_dat,y_dat);

%Graficación
axes(handles.Axe_PV);

x_max = max(x_dat);
handles.handlesPrin.PV_x_max = x_max;
x_val = 0:0.1:x_max;
y_val = ppval(handles.handlesPrin.CurvaPV,x_val);

plot(x_dat,y_dat,'o',x_val,y_val)
xlabel('Velocidad del viento (m/s)')
ylabel('Potencia del Aerogenerador (kW)')
legend('Data ajustada','Función de interpolación','location','best');
title('Potencia vs Velocidad de viento','fontweight','bold')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PV wait for user response (see UIRESUME)
% uiwait(handles.Fig_PV);


% --- Outputs from this function are returned to the command line.
function varargout = PV_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_CargarPV.
function Btn_CargarPV_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_CargarPV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

if ischar(dirData)
    
    handles.handlesPrin.DataPV = readtable(dirData);
    
    %Mostrar Tabla
    set(handles.Tab_PV,'Data',handles.handlesPrin.DataPV{:,:})
    
    %Crear función de interpolación PV
    x_dat = handles.handlesPrin.DataPV.(1);
    y_dat = handles.handlesPrin.DataPV.(2);
    handles.handlesPrin.CurvaPV = pchip(x_dat,y_dat);
    
    %Graficación
    axes(handles.Axe_PV);
    
    x_max = max(x_dat);
    x_val = 0:0.1:x_max;
    y_val = ppval(handles.handlesPrin.CurvaPV,x_val);
    
    plot(x_dat,y_dat,'o',x_val,y_val)
    xlabel('Velocidad del viento (m/s)')
    ylabel('Potencia del Aerogenerador (kW)')
    legend('Data ajustada','Función de interpolación','location','best')
    title('Potencia vs Velocidad de viento','fontweight','bold')
    

    guidata(hObject,handles);
    guidata(handles.hPrin,handles.handlesPrin)
end

% --- Executes on button press in Btn_OkPV.
function Btn_OkPV_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_OkPV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(gcf)


% --- Executes when user attempts to close Fig_PV.
function Fig_PV_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Fig_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Verificar si se puede activar el botón de estimación de potencia nominal
CheckFun(handles.handlesPrin, handles.handlesPrin.Btn_Pn);

%Guardar data cargada hasta el momento
guidata(handles.hPrin,handles.handlesPrin)

% Hint: delete(hObject) closes the figure
delete(hObject);
