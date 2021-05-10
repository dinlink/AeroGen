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
function varargout = MostrarT(varargin)
% MOSTRART MATLAB code for MostrarT.fig
%      MOSTRART, by itself, creates a new MOSTRART or raises the existing
%      singleton*.
%
%      H = MOSTRART returns the handle to a new MOSTRART or the handle to
%      the existing singleton*.
%
%      MOSTRART('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOSTRART.M with the given input arguments.
%
%      MOSTRART('Property','Value',...) creates a new MOSTRART or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MostrarT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MostrarT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MostrarT

% Last Modified by GUIDE v2.5 23-Jun-2015 22:38:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MostrarT_OpeningFcn, ...
                   'gui_OutputFcn',  @MostrarT_OutputFcn, ...
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


% --- Executes just before MostrarT is made visible.
function MostrarT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MostrarT (see VARARGIN)

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(gcf,'windowstyle','modal')

%recuperar de la figura 'PerfilesCargar' los valores de la tabla a mostrar
hPerfilesC=guidata(findall(0,'tag','Fig_PerfilesCargar'));
handles.perfiles=hPerfilesC.perfiles;

%Número de perfiles
tam=length(handles.perfiles);
temp=cell(1,tam);

for i=1:tam
temp(i)={num2str(i)};
end

set(handles.Pop_Nperfil,'string',temp);
set(handles.Text_rR,'string',sprintf('r/R = %5.3f',handles.perfiles(1).rR));
filltbl(eventdata, handles, 1);


% Choose default command line output for MostrarT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MostrarT wait for user response (see UIRESUME)
% uiwait(handles.Fig_MostrarT);


% --- Outputs from this function are returned to the command line.
function varargout = MostrarT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Pop_Nperfil.
function Pop_Nperfil_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Nperfil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

val=get(hObject,'value');
filltbl(eventdata, handles, val);


% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Nperfil contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Nperfil


% --- Executes during object creation, after setting all properties.
function Pop_Nperfil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Nperfil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
