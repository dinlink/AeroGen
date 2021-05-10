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
function varargout = VentDisc(varargin)
% VENTDISC MATLAB code for VentDisc.fig
%      VENTDISC, by itself, creates a new VENTDISC or raises the existing
%      singleton*.
%
%      H = VENTDISC returns the handle to a new VENTDISC or the handle to
%      the existing singleton*.
%
%      VENTDISC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VENTDISC.M with the given input arguments.
%
%      VENTDISC('Property','Value',...) creates a new VENTDISC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VentDisc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VentDisc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VentDisc

% Last Modified by GUIDE v2.5 11-Sep-2015 17:06:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VentDisc_OpeningFcn, ...
                   'gui_OutputFcn',  @VentDisc_OutputFcn, ...
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


% --- Executes just before VentDisc is made visible.
function VentDisc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VentDisc (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(handles.Fig_VentDisc,'windowstyle','modal')

%Verificar parametro de entrada
if nargin == 4
    set(handles.Edit_NroPtos,'string',num2str(varargin{1}));
elseif nargin == 5
    set(handles.Edit_NroPtos,'string',num2str(varargin{1}));
    set(handles.Pop_TipoDisc,'value',varargin{2});
end

% Choose default command line output for VentDisc
handles.output = PlotDisc(handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VentDisc wait for user response (see UIRESUME)
uiwait(handles.Fig_VentDisc);


% --- Outputs from this function are returned to the command line.
function varargout = VentDisc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%La figura puede ser borrada ahora
delete(handles.Fig_VentDisc);



function Edit_NroPtos_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_NroPtos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = PlotDisc(handles);

guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of Edit_NroPtos as text
%        str2double(get(hObject,'String')) returns contents of Edit_NroPtos as a double


% --- Executes during object creation, after setting all properties.
function Edit_NroPtos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_NroPtos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Pop_TipoDisc.
function Pop_TipoDisc_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_TipoDisc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = PlotDisc(handles);

guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns Pop_TipoDisc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_TipoDisc


% --- Executes during object creation, after setting all properties.
function Pop_TipoDisc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_TipoDisc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_Continuar.
function Btn_Continuar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Continuar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Para actualizar el output y cerrar la ventana
uiresume(handles.Fig_VentDisc);


function Vector = AplicDisc(Tipo,NroPtos)
% Aplica una discretización a un rango de 0 a 1 según la variable Tipo
%donde Tipo indica el tipo de discretización (lineal o logarítmica)
% y NroPtos el número total de puntos de la discretización
    switch Tipo
        case 1
            Vector = linspace(0,1,NroPtos);
        case 2
            Vector = (logspace(0,4,NroPtos)-1)/9999;
        case 3
            Vector = flip(1-(logspace(0,4,NroPtos)-1)/9999);
    end
    
function Disc = PlotDisc(handles)
    %Grafica la discretización y devuelve el vector de discretización Disc

    Tipo = get(handles.Pop_TipoDisc,'value');
    NroPtos = str2double(get(handles.Edit_NroPtos,'string'));

    Disc = AplicDisc(Tipo,NroPtos);

    plot(handles.Axe_Disc,Disc,0,'.')
        


% --- Executes when user attempts to close Fig_VentDisc.
function Fig_VentDisc_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Fig_VentDisc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end
