function varargout = DisAdimOp_cR(varargin)
% DISADIMOP_CR MATLAB code for DisAdimOp_cR.fig
%      DISADIMOP_CR, by itself, creates a new DISADIMOP_CR or raises the existing
%      singleton*.
%
%      H = DISADIMOP_CR returns the handle to a new DISADIMOP_CR or the handle to
%      the existing singleton*.
%
%      DISADIMOP_CR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISADIMOP_CR.M with the given input arguments.
%
%      DISADIMOP_CR('Property','Value',...) creates a new DISADIMOP_CR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DisAdimOp_cR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DisAdimOp_cR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DisAdimOp_cR

% Last Modified by GUIDE v2.5 11-Sep-2015 21:12:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DisAdimOp_cR_OpeningFcn, ...
                   'gui_OutputFcn',  @DisAdimOp_cR_OutputFcn, ...
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


% --- Executes just before DisAdimOp_cR is made visible.
function DisAdimOp_cR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DisAdimOp_cR (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(handles.Fig_DisAdimOp_cR,'windowstyle','modal')


%_____ fijar las opciones previamente establecidas____
handles.Op_F = varargin{1};
set(handles.Pop_F,'value',handles.Op_F);

handles.Op_Cd = varargin{2};
set(handles.Pop_Cd,'value',handles.Op_Cd);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DisAdimOp_cR wait for user response (see UIRESUME)
uiwait(handles.Fig_DisAdimOp_cR);


% --- Outputs from this function are returned to the command line.
function varargout = DisAdimOp_cR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.Op_F;
varargout{2} = handles.Op_Cd;

%La figura puede ser borrada ahora
delete(handles.Fig_DisAdimOp_cR);


% --- Executes on selection change in Pop_F.
function Pop_F_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Op_F = get(handles.Pop_F,'value');

guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns Pop_F contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_F


% --- Executes during object creation, after setting all properties.
function Pop_F_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Pop_Cd.
function Pop_Cd_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Cd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Op_Cd = get(handles.Pop_Cd,'value');

guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Cd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Cd


% --- Executes during object creation, after setting all properties.
function Pop_Cd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Cd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close Fig_DisAdimOp_cR.
function Fig_DisAdimOp_cR_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Fig_DisAdimOp_cR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end
