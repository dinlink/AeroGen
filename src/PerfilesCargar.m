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
function varargout = PerfilesCargar(varargin)
% PERFILESCARGAR MATLAB code for PerfilesCargar.fig
%      PERFILESCARGAR, by itself, creates a new PERFILESCARGAR or raises the existing
%      singleton*.
%
%      H = PERFILESCARGAR returns the handle to a new PERFILESCARGAR or the handle to
%      the existing singleton*.
%
%      PERFILESCARGAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PERFILESCARGAR.M with the given input arguments.
%
%      PERFILESCARGAR('Property','Value',...) creates a new PERFILESCARGAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PerfilesCargar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PerfilesCargar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PerfilesCargar

% Last Modified by GUIDE v2.5 09-Mar-2016 15:38:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PerfilesCargar_OpeningFcn, ...
                   'gui_OutputFcn',  @PerfilesCargar_OutputFcn, ...
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


% --- Executes just before PerfilesCargar is made visible.
function PerfilesCargar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PerfilesCargar (see VARARGIN)

% Choose default command line output for PerfilesCargar
handles.output = hObject;

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
%set(gcf,'windowstyle','modal')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PerfilesCargar wait for user response (see UIRESUME)
% uiwait(handles.Fig_PerfilesCargar);


% --- Outputs from this function are returned to the command line.
function varargout = PerfilesCargar_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_Forma.
function Btn_Forma_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Forma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

if ischar(dirData)
    
    Aux = readtable(dirData);
    
    tam = size(Aux);
    
    for i=1:tam(2)/2
        
       %leer cantidad de puntos extrados e intrados
        tame=Aux{1,2*i-1};
        tami=Aux{1,2*i};
        
        %Leer coordenadas de extrados e intrados
        handles.perfiles(i).xe = Aux{3:2+tame,2*i-1};
        handles.perfiles(i).ye = Aux{3:2+tame,2*i};
        handles.perfiles(i).xi = Aux{tame+4:tame+3+tami,2*i-1};
        handles.perfiles(i).yi = Aux{tame+4:tame+3+tami,2*i};

    end 
    
    %Verificación de carga de data completa
    sz = length(fieldnames(handles.perfiles));
    
    if sz == 8
        set(handles.Btn_MostrarT,'enable','on')
        set(handles.Btn_Extension,'enable','on')
    end
    
    guidata(hObject,handles);
end

% --- Executes on button press in Btn_Coef.
function Btn_Coef_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Coef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

if ischar(dirData)
    Aux = readtable(dirData);
    
    tam = size(Aux);
    
    for i=1:tam(2)/3
        
        handles.perfiles(i).alfa = Aux{~isnan(Aux{:,3*i-2}),3*i-2};
        handles.perfiles(i).Cl = Aux{~isnan(Aux{:,3*i-1}),3*i-1};
        handles.perfiles(i).Cd = Aux{~isnan(Aux{:,3*i}),3*i};

    end 
    
    %Verificación de carga de data completa
    sz = length(fieldnames(handles.perfiles));
    
    if sz == 8
        set(handles.Btn_MostrarT,'enable','on')
        set(handles.Btn_Extension,'enable','on')
    end
    
    guidata(hObject,handles);
end

% --- Executes on button press in Btn_MostrarT.
function Btn_MostrarT_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_MostrarT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MostrarT

% --- Executes on button press in Btn_Continuar.
function Btn_Continuar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Continuar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PerfilesGraf

% --- Executes on button press in Btn_rR.
function Btn_rR_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_rR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName]=uigetfile({'*.txt','*.dat'},...
    'Seleccione el archivo de texto con las posiciones relativas de los perfiles');

dirData = [pathName fileName];

if ischar(dirData)
    
    Aux = readtable(dirData,'ReadVariableNames',false);
    Aux = Aux.(1);
    tam = length(Aux);

    for i=1:tam
        handles.perfiles(i).rR = Aux(i);
    end  
    
    %verificación de exceso de elementos y corrección
    if length(handles.perfiles) > tam
        handles.perfiles = handles.perfiles(1:tam);
    end
    
    set(handles.Btn_Forma,'enable','on');
    set(handles.Btn_Coef,'enable','on');
    
    guidata(hObject,handles);
end


% --- Executes on button press in Btn_Extension.
function Btn_Extension_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Extension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ExtendAct