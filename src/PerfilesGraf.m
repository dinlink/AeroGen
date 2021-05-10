function varargout = PerfilesGraf(varargin)
% PERFILESGRAF MATLAB code for PerfilesGraf.fig
%      PERFILESGRAF, by itself, creates a new PERFILESGRAF or raises the existing
%      singleton*.
%
%      H = PERFILESGRAF returns the handle to a new PERFILESGRAF or the handle to
%      the existing singleton*.
%
%      PERFILESGRAF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PERFILESGRAF.M with the given input arguments.
%
%      PERFILESGRAF('Property','Value',...) creates a new PERFILESGRAF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PerfilesGraf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PerfilesGraf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PerfilesGraf

% Last Modified by GUIDE v2.5 24-Jun-2015 13:31:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PerfilesGraf_OpeningFcn, ...
                   'gui_OutputFcn',  @PerfilesGraf_OutputFcn, ...
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


% --- Executes just before PerfilesGraf is made visible.
function PerfilesGraf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PerfilesGraf (see VARARGIN)

% Choose default command line output for PerfilesGraf
handles.output = hObject;

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(gcf,'windowstyle','modal')


%_____________Recuperar tablas de perfiles cargados____________

hPerCarg = findall(0,'tag','Fig_PerfilesCargar');
handlesPerfilesC = guidata(hPerCarg);

handles.perfiles = handlesPerfilesC.perfiles;

%______________Determinación de funciones de interpolación_______
PerfilesGrafFun(hObject, handles)
handles = guidata(hObject);


%_____________ Inicialización controles _________________

%Popup menu
set(handles.Pop_Perfiles,'string',{'Coeficiente de sustentación - Cl',...
    'Coeficiente de arrastre - Cd', 'Ration de coeficientes - Cl/Cd',...
    'Perfiles'});
set(handles.Pop_Perfiles,'value',1);

%Slider
rRmax = 1;
handles.rRmin = min([0.2 handles.perfiles(:).rR]); 
handles.DrR   =(rRmax - handles.rRmin);
set(handles.Sli_Perfiles,'value', (handles.perfiles(1).rR-handles.rRmin)/handles.DrR)

%Texto
handles.Val_rR = get(handles.Sli_Perfiles,'value')*(handles.DrR)+handles.rRmin;
set(handles.Text_PerfilesrR,'string',sprintf('r/R = %5.3f',handles.Val_rR))

%______Graficación______

handles.Funciones = {handles.Cl, handles.Cd, handles.ClCd, handles.y};
Fun = handles.Funciones{ get(handles.Pop_Perfiles,'value') };
PerfilesGrafGraf(handles,Fun)




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PerfilesGraf wait for user response (see UIRESUME)
% uiwait(handles.Fig_PerfilesGraf);


% --- Outputs from this function are returned to the command line.
function varargout = PerfilesGraf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% PerfilesGrafFun(handles);
varargout{1} = handles.output;


% --- Executes on selection change in Pop_Perfiles.
function Pop_Perfiles_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Perfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Fun = handles.Funciones{ get(handles.Pop_Perfiles,'value') };
PerfilesGrafGraf(handles,Fun)

% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Perfiles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Perfiles


% --- Executes during object creation, after setting all properties.
function Pop_Perfiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Perfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Sli_Perfiles_Callback(hObject, eventdata, handles)
% hObject    handle to Sli_Perfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Recuperación de valor de slider y escritura de texto r/R
handles.Val_rR = get(handles.Sli_Perfiles,'value')*(handles.DrR)+handles.rRmin;
set(handles.Text_PerfilesrR,'string',sprintf('r/R = %5.3f',handles.Val_rR))

%Graficación
Fun = handles.Funciones{ get(handles.Pop_Perfiles,'value') };
PerfilesGrafGraf(handles,Fun)

guidata(hObject,handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Sli_Perfiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sli_Perfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Btn_Ok.
function Btn_Ok_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Recuperar la estructura de la figura principal
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

%Guardar funciones de perfiles generadas
handlesPrin.p.Cl = handles.Cl;
handlesPrin.p.Cd = handles.Cd;
handlesPrin.p.ClCd = handles.ClCd;
handlesPrin.p.y = handles.y;
handlesPrin.p.a = handles.a;

%Verificar activación de botones
CheckFun(handlesPrin,handlesPrin.Btn_DisAdim);
CheckFun(handlesPrin,handlesPrin.Btn_AnaAdim);
guidata(hPrin,handlesPrin)

%Recuperar referencia a ventana de carga de perfiles
hPerfilesCrg = findall(0,'tag','Fig_PerfilesCargar');
% 
% %Cerrar ventanas
close(hPerfilesCrg)
close(gcf)
