function varargout = AnaAdim_Cext(varargin)
% ANAADIM_CEXT MATLAB code for AnaAdim_Cext.fig
%      ANAADIM_CEXT, by itself, creates a new ANAADIM_CEXT or raises the existing
%      singleton*.
%
%      H = ANAADIM_CEXT returns the handle to a new ANAADIM_CEXT or the handle to
%      the existing singleton*.
%
%      ANAADIM_CEXT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANAADIM_CEXT.M with the given input arguments.
%
%      ANAADIM_CEXT('Property','Value',...) creates a new ANAADIM_CEXT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaAdim_Cext_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaAdim_Cext_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaAdim_Cext

% Last Modified by GUIDE v2.5 13-Sep-2015 20:25:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaAdim_Cext_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaAdim_Cext_OutputFcn, ...
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


% --- Executes just before AnaAdim_Cext is made visible.
function AnaAdim_Cext_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaAdim_Cext (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(handles.Fig_AnaDim_Cext,'windowstyle','modal')

%Recuperación de valores de entrada
handlesAna = varargin{1};
handles.rR = handlesAna.rR;
handles.Cl = handlesAna.p.Cl.Fun3D;
handles.Cd = handlesAna.p.Cd.Fun3D;


%____inicialización_____
handles.a = linspace(-90,90);

hAxe = handles.Axe_Coef;
surf(hAxe,handles.a,handles.rR,handles.Cl({handles.a,handles.rR}).')
xlabel(hAxe,'Ángulo de ataque (°)')
ylabel(hAxe,'Radio adimensional r/R')
zlabel(hAxe,'Coeficiente extendido')
rotate3d(hAxe,'on');
shading(hAxe,'interp')

% Choose default command line output for AnaAdim_Cext
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaAdim_Cext wait for user response (see UIRESUME)
% uiwait(handles.Fig_AnaDim_Cext);


% --- Outputs from this function are returned to the command line.
function varargout = AnaAdim_Cext_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Pop_Coef.
function Pop_Coef_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Coef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.Pop_Coef,'value');

hAxe = handles.Axe_Coef;
if val == 1
    surf(hAxe,handles.a,handles.rR,handles.Cl({handles.a,handles.rR}).')
else
    surf(hAxe,handles.a,handles.rR,handles.Cd({handles.a,handles.rR}).')
end
xlabel(hAxe,'Ángulo de ataque (°)')
ylabel(hAxe,'Radio adimensional r/R')
zlabel(hAxe,'Coeficiente extendido')
rotate3d(hAxe,'on');
shading(hAxe,'interp')


% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Coef contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Coef


% --- Executes during object creation, after setting all properties.
function Pop_Coef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Coef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
