function varargout = DataViento(varargin)
% DATAVIENTO MATLAB code for DataViento.fig
%      DATAVIENTO, by itself, creates a new DATAVIENTO or raises the existing
%      singleton*.
%
%      H = DATAVIENTO returns the handle to a new DATAVIENTO or the handle to
%      the existing singleton*.
%
%      DATAVIENTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATAVIENTO.M with the given input arguments.
%
%      DATAVIENTO('Property','Value',...) creates a new DATAVIENTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DataViento_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DataViento_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DataViento

% Last Modified by GUIDE v2.5 23-May-2016 19:19:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DataViento_OpeningFcn, ...
                   'gui_OutputFcn',  @DataViento_OutputFcn, ...
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


% --- Executes just before DataViento is made visible.
function DataViento_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DataViento (see VARARGIN)

% Choose default command line output for DataViento
handles.output = hObject;

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(gcf,'windowstyle','modal')

%Recuperar la información de la ventana principal
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

handles.hPrin=hPrin;
handles.handlesPrin=handlesPrin;

%Mostrar Tabla
set(handles.Tab_DataViento,'Data',handlesPrin.DataV{:,:})
set(handles.Tab_DataViento,'ColumnName',handlesPrin.colNames)

%Tabla a editar
handles.DataV = handlesPrin.DataV;
handles.tamStr = handlesPrin.tamStr;
handles.colNames = handlesPrin.colNames;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DataViento wait for user response (see UIRESUME)
% uiwait(handles.Fig_DataViento);


% --- Outputs from this function are returned to the command line.
function varargout = DataViento_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_Ok.
function Btn_Ok_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(get(hObject,'parent'))

% --- Executes on button press in Btn_Cargar.
function Btn_Cargar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Cargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

if ischar(dirData)
    [handles.DataV, handles.colNames, handles.tamStr] = ...
        CargarData(dirData) ;
    
    %Mostrar Tabla
    set(handles.Tab_DataViento,'Data',handles.DataV{:,:})
    set(handles.Tab_DataViento,'ColumnName',handles.colNames)

    guidata(hObject,handles);
end


% --- Executes when user attempts to close Fig_DataViento.
function Fig_DataViento_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Fig_DataViento (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.handlesPrin.DataV = handles.DataV;
handles.handlesPrin.colNames = handles.colNames;
handles.handlesPrin.tamStr = handles.tamStr;

guidata(handles.hPrin,handles.handlesPrin)

% Hint: delete(hObject) closes the figure
delete(hObject);



function Edit_Time_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Time as text
%        str2double(get(hObject,'String')) returns contents of Edit_Time as a double


% --- Executes during object creation, after setting all properties.
function Edit_Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Pop_Time.
function Pop_Time_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Time contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Time


% --- Executes during object creation, after setting all properties.
function Pop_Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_Aplicar.
function Btn_Aplicar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Aplicar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%captura de características de promediado
cada = str2double(get(handles.Edit_Time,'string'));
unit = 7 - get(handles.Pop_Time,'value');

%Barra de espera
hwb = waitbar(0,'1','Name','Promediando');
waitbar(0,hwb,sprintf('%d%%  Completado',0))

%Inicialización
[m n] = size(handles.DataV{:,:});
cont = 0;
DataVN = handles.DataV(1,:);
i0 = 1;
N = 1;

for i = 1 : m - 1
    
    cont = cont + abs(handles.DataV{ i+1, 1}(unit) - handles.DataV{ i, 1}(unit));
    
    if cont >= cada
        
        DataVN{N,:} = [ handles.DataV{i0,1}, mean( handles.DataV{ i0:i, 2:end}, 1 ) ];
        N = N + 1;
        i0 = i + 1;
        cont = 0;
    end
    waitbar(i/m, hwb, sprintf('%0.1f%%  Completado', 100*i/m ) )
end

handles.DataV = DataVN;
waitbar(1, hwb, 'Terminado' )

%Mostrar Tabla
set(handles.Tab_DataViento,'Data',handles.DataV{:,:})

delete(hwb)

guidata(hObject, handles)



function Edit_Extrap_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Extrap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Extrap as text
%        str2double(get(hObject,'String')) returns contents of Edit_Extrap as a double


% --- Executes during object creation, after setting all properties.
function Edit_Extrap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Extrap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_Extrap.
function Btn_Extrap_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Extrap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Número de puntos para la inter/extrapolación
idx = handles.tamStr;

%Puntos de alturas
Ptos = cellfun(@(str) str2double(str(3:4)),...
    handles.DataV.Properties.VariableNames(end - idx + 1 : end) );

%Altura de data a calcular
z3 = str2double( get(handles.Edit_Extrap,'string'));


if any( Ptos == z3)
    
    %Error en caso se repita altura
    errordlg('La altura especificada ya existe','Altura existente!')
    
else
    
    if idx ~= 1
        %Calcular con  2 puntos
        z1 = Ptos(end-1);
        z2 = Ptos(end);
        u1 = handles.DataV{:,end - idx - 1};
        u2 = handles.DataV{:,end - idx};
        
        z0 = exp( ( u1 ./ u2 .* log(z2) - log(z1) ) ./ ( u1 ./ u2 - 1) );
        u = 0.4 * u1 ./ log(z1 ./ z0);
        
    else
        %Calcular con 1 punto
        
        %Capturar z0
        prompt = {' Data insuficiente, introduzca la rugosidad del terreno z0: '};
        dlg_title = 'Completando data necesaria';
        num_lines = 1;
        defaultans = {'0.03'};
        z0 = str2double( inputdlg( prompt, dlg_title, num_lines, defaultans ) );
        
        
        z2 = Ptos(end);
        u2 = handles.DataV{:,end - idx};
        
        u = 0.4 * u2 ./ log(z2 ./ z0);
        
    end
    
    %Calculo del nuevo punto
    u3 = u./0.4 .* log(z3./z0);
    d3 = mean(handles.DataV{:,end - idx + 1 : end },2);
    
    %Construcción de la nueva tabla
    ValNames = {sprintf('V_%dm',z3),sprintf('D_%dm',z3)};
    Taux = table(u3,d3,'VariableNames',ValNames);
    
    handles.DataV = [handles.DataV(:,1) Taux(:,1) ...
        handles.DataV(:, 2:end - idx ) Taux(:,2) handles.DataV(:,end - idx +1 :end)];
    
    handles.colNames = [{'Año','Mes','Día','Hora','Minuto','Segundo'} handles.DataV.Properties.VariableNames(2:end)];
    handles.tamStr = handles.tamStr + 1;
    
    %Mostrar Tabla
    set(handles.Tab_DataViento,'Data',handles.DataV{:,:})
    set(handles.Tab_DataViento,'ColumnName',handles.colNames)
    
    guidata(hObject, handles)
    
end




