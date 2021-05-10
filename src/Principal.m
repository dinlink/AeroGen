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
function varargout = Principal(varargin)
% FIG_PRINCIPAL MATLAB code for Fig_Principal.fig
%      FIG_PRINCIPAL, by itself, creates a new FIG_PRINCIPAL or raises the existing
%      singleton*.
%
%      H = FIG_PRINCIPAL returns the handle to a new FIG_PRINCIPAL or the handle to
%      the existing singleton*.
%
%      FIG_PRINCIPAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIG_PRINCIPAL.M with the given input arguments.
%
%      FIG_PRINCIPAL('Property','Value',...) creates a new FIG_PRINCIPAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Principal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Principal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fig_Principal

% Last Modified by GUIDE v2.5 20-Sep-2015 12:35:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Principal_OpeningFcn, ...
                   'gui_OutputFcn',  @Principal_OutputFcn, ...
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


% --- Executes just before Fig_Principal is made visible.
function Principal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fig_Principal (see VARARGIN)

% Choose default command line output for Fig_Principal
handles.output = hObject;

%Centrar ventana
movegui(hObject,'center');


%___________Configuración de flechas____________

%_____________Análisis de recursos______________

%Flecha Datos de Viento -> Análisis de Datos de viento
handles.Anno_DatV_AnV = annotation(handles.Fig_Principal,'arrow',[0.2,0.2],[0.9,0.8]);
set(handles.Anno_DatV_AnV,'Units','normalized');
set(handles.Anno_DatV_AnV,'X',[0.33,0.33]+[0.004 0.004]);
set(handles.Anno_DatV_AnV,'Y',[0.898983, 0.831104]-[0.015 0.015]);

%Líneas de salida de Análisis de Datos de viento
handles.Anno_AnV_=annotation(handles.Fig_Principal,'Line',[0.1,0.1],[0.9,0.8]);
set(handles.Anno_AnV_,'Units','normalized');
set(handles.Anno_AnV_,'X',[0.24,0.334]);
set(handles.Anno_AnV_,'Y',[0.52, 0.52]);

handles.Anno_AnV_2=annotation(handles.Fig_Principal,'Line',[0.1,0.1],[0.9,0.8]);
set(handles.Anno_AnV_2,'Units','normalized');
set(handles.Anno_AnV_2,'X',[0.24, 0.24]);
set(handles.Anno_AnV_2,'Y',[0.647,0.52]);

%Flechas de saldia de Análisis de datos de viento
handles.Anno_AnV_Pn=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.9,0.8]);
set(handles.Anno_AnV_Pn,'Units','normalized');
set(handles.Anno_AnV_Pn,'X',[0.24,0.22]);
set(handles.Anno_AnV_Pn,'Y',[0.647,0.647]);

handles.Anno_AnV_AnDim=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.9,0.8]);
set(handles.Anno_AnV_AnDim,'Units','normalized');
set(handles.Anno_AnV_AnDim,'X',[0.33,0.33]+[0.004 0.004]);
set(handles.Anno_AnV_AnDim,'Y',[0.78,0.3333]);

%Flecha de salida de estimación de potencia nominal
handles.Anno_Pn_AnDim=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.9,0.8]);
set(handles.Anno_Pn_AnDim,'Units','normalized');
set(handles.Anno_Pn_AnDim,'X',[0.168,0.168]);
set(handles.Anno_Pn_AnDim,'Y',[0.63,0.33333]);

%Flecha de Curva P_V
handles.Anno_PV_Pn=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.9,0.8]);
set(handles.Anno_PV_Pn,'Units','normalized');
set(handles.Anno_PV_Pn,'X',[0.0935551+0.003, 0.115]);
set(handles.Anno_PV_Pn,'Y',[0.647,0.647]);

%______________Diseño y análisis adimensional_______________

%Flecha de velocidad específica
handles.Anno_Ve_DisA=annotation(handles.Fig_Principal,'Arrow',[0.6,0.6],[0.9,0.8]);
set(handles.Anno_Ve_DisA,'Units','normalized');
set(handles.Anno_Ve_DisA,'X',[0.830042,0.830042]);
set(handles.Anno_Ve_DisA,'Y',[0.898983, 0.831104]-[0.015 0.015]);

%Flecha de diseño adimensional
handles.Anno_DisA_AnA=annotation(handles.Fig_Principal,'Arrow',[0.6,0.6],[0.9,0.8]);
set(handles.Anno_DisA_AnA,'Units','normalized');
set(handles.Anno_DisA_AnA,'X',[0.830042,0.830042]);
set(handles.Anno_DisA_AnA,'Y',[ 0.831104,0.559591]-[0.005 0.005]);

%Flecha de Análisis adimensional
handles.Anno_AnA_AnD=annotation(handles.Fig_Principal,'Arrow',[0.6,0.6],[0.9,0.8]);
set(handles.Anno_AnA_AnD,'Units','normalized');
set(handles.Anno_AnA_AnD,'X',[0.830042,0.830042]);
set(handles.Anno_AnA_AnD,'Y',[0.514339,0.3333]);

%Líneas de salida de Perfiles
handles.Anno_Per_=annotation(handles.Fig_Principal,'Line',[0.6,0.6],[0.9,0.8]);
set(handles.Anno_Per_,'Units','normalized');
set(handles.Anno_Per_,'X',[0.6613 0.6995]);
set(handles.Anno_Per_,'Y',[0.672722,0.672722]-[0.008 0.008]);

handles.Anno_Per_2=annotation(handles.Fig_Principal,'Line',[0.6,0.6],[0.9,0.8]);
set(handles.Anno_Per_2,'Units','normalized');
set(handles.Anno_Per_2,'X',[0.6995 0.6995]);
set(handles.Anno_Per_2,'Y',[0.7925 0.5320]);

%Flechas de salida de Perfiles
handles.Anno_Per_DisA=annotation(handles.Fig_Principal,'Arrow',[0.6,0.6],[0.9,0.8]);
set(handles.Anno_Per_DisA,'Units','normalized');
set(handles.Anno_Per_DisA,'X',[0.6995 0.7633]);
set(handles.Anno_Per_DisA,'Y',[0.808478,0.808478]-[0.016 0.016]);

handles.Anno_Per_AnA=annotation(handles.Fig_Principal,'Arrow',[0.6,0.6],[0.9,0.8]);
set(handles.Anno_Per_AnA,'Units','normalized');
set(handles.Anno_Per_AnA,'X',[0.6995 0.7633]);
set(handles.Anno_Per_AnA,'Y',[0.536965,0.536965]-[0.005 0.005]);

%Flechas de Análisis dimensional y optimización

%Análisis dimensional
handles.Anno_Entr_DisDim=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.2,0.1]);
set(handles.Anno_Entr_DisDim,'Units','normalized');
set(handles.Anno_Entr_DisDim,'X',[0.144778 0.16546]);
set(handles.Anno_Entr_DisDim,'Y',[0.165739 0.165739]-[0.01 .01]);

handles.Anno_DisDim_AnDim=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.2,0.1]);
set(handles.Anno_DisDim_AnDim,'Units','normalized');
set(handles.Anno_DisDim_AnDim,'X',[0.2956 0.5403]);
set(handles.Anno_DisDim_AnDim,'Y',[0.165739 0.165739]-[0.01 .01]);

handles.Anno_Entr_AnDim=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.2,0.1]);
set(handles.Anno_Entr_AnDim,'Units','normalized');
set(handles.Anno_Entr_AnDim,'X',[0.607549,0.607549]);
set(handles.Anno_Entr_AnDim,'Y',[0.2395 0.1753]+[0.005 0.005]);

% handles.Anno_AnDim_=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.2,0.1]);
% set(handles.Anno_AnDim_,'Units','normalized');
% set(handles.Anno_AnDim_,'X',[0.607549,0.607549]);
% set(handles.Anno_AnDim_,'Y',[0.1326 0.0577]);

%Optimización

handles.Anno_Entr_Opt=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.2,0.1]);
set(handles.Anno_Entr_Opt,'Units','normalized');
set(handles.Anno_Entr_Opt,'X',[0.840228,0.840228]);
set(handles.Anno_Entr_Opt,'Y',[0.2395 0.1753]+[0.005 0.005]);

% handles.Anno_Opt=annotation(handles.Fig_Principal,'Arrow',[0.1,0.1],[0.2,0.1]);
% set(handles.Anno_Opt,'Units','normalized');
% set(handles.Anno_Opt,'X',[0.840228,0.840228]);
% set(handles.Anno_Opt,'Y',[0.1326 0.0791]);

%________Crear variables iniciales________
handles.CurvaPV = [];
handles.p = [];

%_____ variables que dependen de los botones radiales var(1) = generada;
%var(2) = manual; var(3) seleccionada

% filas : c, k, f0; columnas: generada, manual, seleccionada
handles.ckF0 = NaN * ones(3);

% filas : Pn; columnas: generada, manual, seleccionada
handles.Pn = [NaN NaN NaN];

% filas : c/R, th ; columnas: generada, manual, seleccionada
handles.cR_th{2,3} =[];

%filas: Cp, Cond_n ; columnas: generada, manual, seleccionada
handles.Cp{2,3} =[];

%filas: R, w ; columnas: generada, manual, seleccionada
handles.Rw = NaN * ones(2,3);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fig_Principal wait for user response (see UIRESUME)
% uiwait(handles.Fig_Principal);


% --- Outputs from this function are returned to the command line.
function varargout = Principal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_DataViento.
function Btn_DataViento_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_DataViento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Seleccion de fichero
[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

%Si se ha seleccionado efectivamente un fichero:
if ischar(dirData)
    
    [handles.DataV, handles.colNames, handles.tamStr] = ...
        CargarData(dirData) ;
    guidata(hObject,handles);
    
    DataViento
    
    set(handles.Btn_AnaViento,'enable','on');

   
end

% --- Executes on button press in Btn_AnaViento.
function Btn_AnaViento_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_AnaViento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AnaViento

% --- Executes on button press in Btn_Pn.
function Btn_Pn_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Pn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Pn

% --- Executes on button press in Btn_PV.
function Btn_PV_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Seleccion de fichero
[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

%Si se ha seleccionado efectivamente un fichero:
if ischar(dirData)
    
    handles.DataPV = readtable(dirData);
    
    guidata(handles.Fig_Principal,handles);
    
    PV 
end

% --- Executes on button press in Btn_Perfiles.
function Btn_Perfiles_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Perfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PerfilesCargar


function Edit_Npalas_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Npalas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CheckFun(handles,handles.Btn_DisAdim)
CheckFun(handles,handles.Btn_AnaAdim)
% Hints: get(hObject,'String') returns contents of Edit_Npalas as text
%        str2double(get(hObject,'String')) returns contents of Edit_Npalas as a double


% --- Executes during object creation, after setting all properties.
function Edit_Npalas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Npalas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_rRhub_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_rRhub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Verificación de activación de botones
CheckFun(handles,handles.Btn_DisAdim)
CheckFun(handles,handles.Btn_AnaAdim)


% Hints: get(hObject,'String') returns contents of Edit_rRhub as text
%        str2double(get(hObject,'String')) returns contents of Edit_rRhub as a double


% --- Executes during object creation, after setting all properties.
function Edit_rRhub_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_rRhub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Lambdad_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Lambdad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CheckFun(handles,handles.Btn_DisAdim)
% Hints: get(hObject,'String') returns contents of Edit_Lambdad as text
%        str2double(get(hObject,'String')) returns contents of Edit_Lambdad as a double


% --- Executes during object creation, after setting all properties.
function Edit_Lambdad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Lambdad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_DisAdim.
function Btn_DisAdim_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_DisAdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DisAdim()

% --- Executes on button press in Btn_AnaAdim.
function Btn_AnaAdim_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_AnaAdim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AnaAdim()


function Edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%recupero valor
handles.ckF0(1,2) = str2double(get(handles.Edit_c,'string'));
%lo selecciono
handles.ckF0(1,3) = handles.ckF0(1,2);

CheckFun(handles, handles.Btn_Pn);
CheckFun(handles,handles.Btn_DisDim);
CheckFun(handles,handles.Btn_AnaDim);
CheckFun(handles,handles.Btn_Opt);


guidata(hObject,handles)


% Hints: get(hObject,'String') returns contents of Edit_c as text
%        str2double(get(hObject,'String')) returns contents of Edit_c as a double


% --- Executes during object creation, after setting all properties.
function Edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_k_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%recupero valor
handles.ckF0(2,2) = str2double(get(handles.Edit_k,'string'));
%lo selecciono
handles.ckF0(2,3) = handles.ckF0(2,2);

CheckFun(handles, handles.Btn_Pn);
CheckFun(handles,handles.Btn_AnaDim);
CheckFun(handles,handles.Btn_Opt);

guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of Edit_k as text
%        str2double(get(hObject,'String')) returns contents of Edit_k as a double


% --- Executes during object creation, after setting all properties.
function Edit_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Pn_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Pn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%recupero valor
handles.Pn(2) = str2double(get(handles.Edit_Pn,'string'));
%lo selecciono
handles.Pn(3) = handles.Pn(2);

CheckFun(handles,handles.Btn_DisDim);
CheckFun(handles,handles.Btn_AnaDim);
CheckFun(handles,handles.Btn_Opt);

guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of Edit_Pn as text
%        str2double(get(hObject,'String')) returns contents of Edit_Pn as a double


% --- Executes during object creation, after setting all properties.
function Edit_Pn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Pn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in Btn_cR.
function Btn_cR_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_cR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

%Si se ha seleccionado efectivamente un fichero:
if ischar(dirData)
    
    cR = readtable(dirData,'readvariablename',0);
    
    % Asignación funcion manual
    handles.cR_th{1,2} = griddedInterpolant(cR{:,1}.',cR{:,2}.','pchip') ;
    
    % Asignación de selección
    handles.cR_th{1,3} = handles.cR_th{1,2};
    
    %Verificación de botón
    CheckFun(handles,handles.Btn_AnaAdim);
    
    
    guidata(handles.Fig_Principal,handles);

end

% --- Executes on button press in Btn_Tor.
function Btn_Tor_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Tor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

%Si se ha seleccionado efectivamente un fichero:
if ischar(dirData)
    
    th = readtable(dirData,'readvariablename',0);
    
    % Asignación funcion manual
    handles.cR_th{2,2} = griddedInterpolant(th{:,1}.',th{:,2}.'/180*pi,'pchip') ;
    
    % Asignación de selección
    handles.cR_th{2,3} = handles.cR_th{2,2};
    
    %Verificación de botón
    CheckFun(handles,handles.Btn_AnaAdim);
    
    
    guidata(handles.Fig_Principal,handles);

end

% --- Executes on button press in Btn_Cp.
function Btn_Cp_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

%Si se ha seleccionado efectivamente un fichero:
if ischar(dirData)
    
    Cp = readtable(dirData,'readvariablename',0);
    Cpg = Cp{2:end,:};
    
    Jmin = 0;
    Jmax = max( [ Cpg(:,1).' + 1, 20 ] );
    CpmM= 0;
    
    % Asignación funcion manual
    handles.Cp{1,2} = griddedInterpolant([ Jmin, Cpg(:,1).', Jmax, Jmax + 1], [CpmM, Cpg(:,2).', CpmM, CpmM],'pchip') ;
    handles.Cp{2,2} = [Cp{1,1}, Cp{1,2}];
    
    % Asignación de selección
    handles.Cp{1,3} = handles.Cp{1,2};
    handles.Cp{2,3} = handles.Cp{2,2};
    
    % Informar de cargado de condiciones nominales
    set(handles.Text_Cond_nM,'string','Cond_n -OK-');
    
    %Verificación de botón
    CheckFun(handles,handles.Btn_DisDim);
    CheckFun(handles,handles.Btn_AnaDim);
    CheckFun(handles,handles.Btn_Opt);
    
    
    guidata(handles.Fig_Principal,handles);

end


function Edit_cttVn_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_cttVn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CheckFun(handles,handles.Btn_DisDim);

% Hints: get(hObject,'String') returns contents of Edit_cttVn as text
%        str2double(get(hObject,'String')) returns contents of Edit_cttVn as a double


% --- Executes during object creation, after setting all properties.
function Edit_cttVn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_cttVn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_DisDim.
function Btn_DisDim_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_DisDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Variables de entrada
cttVn = str2double(get(handles.Edit_cttVn,'string'));
c = handles.ckF0(1,3);
Vn = cttVn * c;
Pn = handles.Pn(3)*1000;
Cpn = handles.Cp{2,3}(2);
Jn = handles.Cp{2,3}(1);

%Cálculo

R = sqrt( 2*Pn / (1.225 * Vn^3 * pi *Cpn) );
w = Jn * Vn / R * 60 / (2*pi);

%Guardar valores generados
handles.Rw(1,1) = R;
handles.Rw(2,1) = w;

% Activar resultados generados
set(handles.RadBtn_RwA,'value',1)
set(handles.Edit_R,'enable','off')
set(handles.Edit_w,'enable','off')

%Seleccionar valores generados
handles.Rw(1,3) = R;
handles.Rw(2,3) = w;

%Escrbir valores generados
set(handles.Text_RA,'string',sprintf('R:  %0.2f',R));
set(handles.Text_wA,'string',sprintf('w:  %0.0f',w));

%Verificación de botones
CheckFun(handles,handles.Btn_AnaDim);

guidata(hObject,handles)

% --- Executes on button press in Btn_AnaDim.
function Btn_AnaDim_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_AnaDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AnaDim


function Edit_R_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%recupero valor
handles.Rw(1,2) = str2double(get(handles.Edit_R,'string'));

%lo selecciono
handles.Rw(1,3) = handles.Rw(1,2);

CheckFun(handles,handles.Btn_AnaDim);

guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of Edit_R as text
%        str2double(get(hObject,'String')) returns contents of Edit_R as a double


% --- Executes during object creation, after setting all properties.
function Edit_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_w_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%recupero valor
handles.Rw(2,2) = str2double(get(handles.Edit_w,'string'));

%lo selecciono
handles.Rw(2,3) = handles.Rw(2,2);

CheckFun(handles,handles.Btn_AnaDim);

guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of Edit_w as text
%        str2double(get(hObject,'String')) returns contents of Edit_w as a double


% --- Executes during object creation, after setting all properties.
function Edit_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_Opt.
function Btn_Opt_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Opt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Opt


function Edit_Edn_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Edn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CheckFun(handles,handles.Btn_Pn)
% Hints: get(hObject,'String') returns contents of Edit_Edn as text
%        str2double(get(hObject,'String')) returns contents of Edit_Edn as a double


% --- Executes during object creation, after setting all properties.
function Edit_Edn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Edn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Pnc_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Pnc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CheckFun(handles,handles.Btn_Pn)

% Hints: get(hObject,'String') returns contents of Edit_Pnc as text
%        str2double(get(hObject,'String')) returns contents of Edit_Pnc as a double


% --- Executes during object creation, after setting all properties.
function Edit_Pnc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Pnc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_F0_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_F0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%recupero valor
handles.ckF0(3,2) = str2double(get(handles.Edit_F0,'string'));
%lo selecciono
handles.ckF0(3,3) = handles.ckF0(3,2);

CheckFun(handles, handles.Btn_Pn);
CheckFun(handles,handles.Btn_AnaDim);
CheckFun(handles,handles.Btn_Opt);

guidata(hObject,handles)
% Hints: get(hObject,'String') returns contents of Edit_F0 as text
%        str2double(get(hObject,'String')) returns contents of Edit_F0 as a double


% --- Executes during object creation, after setting all properties.
function Edit_F0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_F0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in Panel_ck.
function Panel_ck_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Panel_ck 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if eventdata.NewValue == handles.RadBtn_ckA
    set(handles.Edit_c,'enable','off')
    set(handles.Edit_k,'enable','off')
    set(handles.Edit_F0,'enable','off')
    handles.ckF0(:,3) = handles.ckF0(:,1);
    
else
    set(handles.Edit_c,'enable','on')
    set(handles.Edit_k,'enable','on')
    set(handles.Edit_F0,'enable','on')
    handles.ckF0(:,3) = handles.ckF0(:,2);
end

CheckFun(handles, handles.Btn_Pn);
CheckFun(handles,handles.Btn_DisDim);
CheckFun(handles,handles.Btn_AnaDim);
CheckFun(handles,handles.Btn_Opt);

guidata(hObject,handles)


% --- Executes when selected object is changed in Panel_Pn.
function Panel_Pn_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Panel_Pn 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if eventdata.NewValue == handles.RadBtn_PnA
    set(handles.Edit_Pn,'enable','off')
    handles.Pn(3) = handles.Pn(1);
    
else
    set(handles.Edit_Pn,'enable','on')
    handles.Pn(3) = handles.Pn(2);
end

CheckFun(handles, handles.Btn_DisDim);
CheckFun(handles,handles.Btn_AnaDim);
CheckFun(handles,handles.Btn_Opt);

guidata(hObject,handles)


% --- Executes when selected object is changed in Panel_cRTor.
function Panel_cRTor_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Panel_cRTor 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if eventdata.NewValue == handles.RadBtn_cRTorA
    set(handles.Btn_cR,'enable','off')
    set(handles.Btn_Tor,'enable','off')
    handles.cR_th{1,3} = handles.cR_th{1,1};
    handles.cR_th{2,3} = handles.cR_th{2,1};
else
    set(handles.Btn_cR,'enable','on')
    set(handles.Btn_Tor,'enable','on')
    handles.cR_th{1,3} = handles.cR_th{1,2};
    handles.cR_th{2,3} = handles.cR_th{2,2};
end

CheckFun(handles,handles.Btn_AnaAdim);

guidata(hObject,handles)


% --- Executes when selected object is changed in Panel_Cp.
function Panel_Cp_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Panel_Cp 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if eventdata.NewValue == handles.RadBtn_CpA
    set(handles.Btn_Cp,'enable','off')
    handles.Cp{1,3} = handles.Cp{1,1};
    handles.Cp{2,3} = handles.Cp{2,1};
else
    set(handles.Btn_Cp,'enable','on')
    handles.Cp{1,3} = handles.Cp{1,2};
    handles.Cp{2,3} = handles.Cp{2,2};
end

CheckFun(handles,handles.Btn_DisDim);
CheckFun(handles,handles.Btn_AnaDim);
CheckFun(handles,handles.Btn_Opt);

guidata(hObject,handles)


% --- Executes when selected object is changed in Panel_Rw.
function Panel_Rw_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Panel_Rw 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if eventdata.NewValue == handles.RadBtn_RwA
    set(handles.Edit_R,'enable','off')
    set(handles.Edit_w,'enable','off')
    handles.Rw(1,3) = handles.Rw(1,1);
    handles.Rw(2,3) = handles.Rw(2,1);
else
    set(handles.Edit_R,'enable','on')
    set(handles.Edit_w,'enable','on')
    handles.Rw(1,3) = handles.Rw(1,2);
    handles.Rw(2,3) = handles.Rw(2,2);
end

CheckFun(handles,handles.Btn_AnaDim);

guidata(hObject,handles)
