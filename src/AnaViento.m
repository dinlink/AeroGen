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

function varargout = AnaViento(varargin)
% ANAVIENTO MATLAB code for AnaViento.fig
%      ANAVIENTO, by itself, creates a new ANAVIENTO or raises the existing
%      singleton*.
%
%      H = ANAVIENTO returns the handle to a new ANAVIENTO or the handle to
%      the existing singleton*.
%
%      ANAVIENTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANAVIENTO.M with the given input arguments.
%
%      ANAVIENTO('Property','Value',...) creates a new ANAVIENTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaViento_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaViento_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaViento

% Last Modified by GUIDE v2.5 21-Jun-2015 18:06:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaViento_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaViento_OutputFcn, ...
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


% --- Executes just before AnaViento is made visible.
function AnaViento_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaViento (see VARARGIN)

% Choose default command line output for AnaViento
handles.output = hObject;

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(gcf,'windowstyle','modal')

%Configuracion de los sliders
maxbars = 30;
handles.minbars = 5;
handles.Dbars = maxbars-handles.minbars;

handles.binsR=get(handles.Sli_Rosa,'value')*(handles.Dbars)+handles.minbars;
handles.binsW=round(get(handles.Sli_Weibull,'value')*(handles.Dbars)+handles.minbars);

%Recuperación de data de interés de figura principal
handles.hPrin = findall(0,'tag','Fig_Principal');
hT = guidata(handles.hPrin);

handles.DataV = hT.DataV;
handles.tamStr = hT.tamStr;

%Captura de alturas de la tabla
    altVec=strncmp('V_',handles.DataV.Properties.VariableNames,2);
    altStr=handles.DataV.Properties.VariableNames(altVec);
    altStr=strrep(altStr,'V_','');
    
%Inicialización de Popupmenus
    set(handles.Pop_AlturaR,'String',altStr);
    set(handles.Pop_AlturaR,'value',1);
    
    set(handles.Pop_AlturaW,'String',altStr);
    set(handles.Pop_AlturaW,'value',1);
    
    set(handles.Pop_CalculoW,'value',1);

%Primera graficación de la rosa
RosGraf(hObject,handles,get(handles.Pop_AlturaR,'value'));

%Primera graficación del ajuste de Weibull
WblGraf(eventdata , hObject , handles , get(handles.Pop_AlturaW,'value'),...
    get(handles.Pop_CalculoW,'value'));
handles = guidata(hObject);
guidata(hObject,handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaViento wait for user response (see UIRESUME)
% uiwait(handles.Fig_AnaViento);


% --- Outputs from this function are returned to the command line.
function varargout = AnaViento_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Pop_AlturaR.
function Pop_AlturaR_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_AlturaR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

RosGraf(hObject,handles,get(handles.Pop_AlturaR,'value'));

% Hints: contents = cellstr(get(hObject,'String')) returns Pop_AlturaR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_AlturaR


% --- Executes during object creation, after setting all properties.
function Pop_AlturaR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_AlturaR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Pop_TipoR.
function Pop_TipoR_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_TipoR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Pop_TipoR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_TipoR


% --- Executes during object creation, after setting all properties.
function Pop_TipoR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_TipoR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Sli_Rosa_Callback(hObject, eventdata, handles)
% hObject    handle to Sli_Rosa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.binsR=get(handles.Sli_Rosa,'value')*(handles.Dbars)+handles.minbars;

RosGraf(hObject,handles,get(handles.Pop_AlturaR,'value'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Sli_Rosa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sli_Rosa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject,'value',3/5);


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in Pop_AlturaW.
function Pop_AlturaW_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_AlturaW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

WblGraf(eventdata , hObject , handles , get(handles.Pop_AlturaW,'value'),...
    get(handles.Pop_CalculoW,'value'));
handles = guidata(hObject);
guidata(hObject,handles);



% Hints: contents = cellstr(get(hObject,'String')) returns Pop_AlturaW contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_AlturaW


% --- Executes during object creation, after setting all properties.
function Pop_AlturaW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_AlturaW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Pop_CalculoW.
function Pop_CalculoW_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_CalculoW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

WblGraf(eventdata , hObject , handles , get(handles.Pop_AlturaW,'value'),...
    get(handles.Pop_CalculoW,'value'));
handles = guidata(hObject);
guidata(hObject,handles);

% Hints: contents = cellstr(get(hObject,'String')) returns Pop_CalculoW contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_CalculoW


% --- Executes during object creation, after setting all properties.
function Pop_CalculoW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_CalculoW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Sli_Weibull_Callback(hObject, eventdata, handles)
% hObject    handle to Sli_Weibull (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.binsW=round(get(handles.Sli_Weibull,'value')*(handles.Dbars)+handles.minbars);

WblGraf(eventdata , hObject , handles , get(handles.Pop_AlturaW,'value'),...
    get(handles.Pop_CalculoW,'value'));
handles = guidata(hObject);
guidata(hObject,handles);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Sli_Weibull_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sli_Weibull (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

set(hObject,'value',1/5);

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when user attempts to close Fig_AnaViento.
function Fig_AnaViento_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Fig_AnaViento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%dibuja el parametro c en la ventana principal

hPrincipal=findall(0,'tag','Fig_Principal');

dataT=guidata(hPrincipal);

set(dataT.Text_cA,'string',sprintf('c: %5.3f',handles.c));
set(dataT.Text_kA,'string',sprintf('k: %5.3f',handles.k));
set(dataT.Text_F0A,'string',sprintf('F0: %5.3f',handles.F0));

set(dataT.RadBtn_ckA,'value',1)
set(dataT.Edit_c,'enable','off')
set(dataT.Edit_k,'enable','off')
set(dataT.Edit_F0,'enable','off')

dataT.ckF0(:,1) = [handles.c handles.k handles.F0];
dataT.ckF0(:,3) = [handles.c handles.k handles.F0];


CheckFun(dataT, dataT.Btn_Pn);
CheckFun(dataT, dataT.Btn_DisDim);
CheckFun(dataT, dataT.Btn_AnaDim);
CheckFun(dataT, dataT.Btn_Opt);

guidata(hPrincipal,dataT)

% Hint: delete(hObject) closes the figure
delete(hObject);
