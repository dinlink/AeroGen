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
function varargout = Opt(varargin)
% OPT MATLAB code for Opt.fig
%      OPT, by itself, creates a new OPT or raises the existing
%      singleton*.
%
%      H = OPT returns the handle to a new OPT or the handle to
%      the existing singleton*.
%
%      OPT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPT.M with the given input arguments.
%
%      OPT('Property','Value',...) creates a new OPT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Opt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Opt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Opt

% Last Modified by GUIDE v2.5 25-Oct-2015 23:31:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Opt_OpeningFcn, ...
                   'gui_OutputFcn',  @Opt_OutputFcn, ...
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


% --- Executes just before Opt is made visible.
function Opt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Opt (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
%set(hObject,'windowstyle','modal')

%______________Inicializacion de variables___________________

handles.Op_param = str2double(get(handles.Edit_R,'string'));
handles.Op_paramID = 'R';
handles.Op_cntrl = 'S';



% Choose default command line output for Opt
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Opt wait for user response (see UIRESUME)
% uiwait(handles.Fig_Opt);


% --- Outputs from this function are returned to the command line.
function varargout = Opt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_Continuar.
function Btn_Continuar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Continuar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.Op_cntrl == 'S'
    Opt_R(handles.Op_param, handles.Op_paramID)
else
    Opt_V(handles.Op_param, handles.Op_paramID)
end



function Edit_Pn_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Pn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Op_param = str2double(get(handles.Edit_Pn,'string'));

if ~isnan(handles.Op_param)
   set(handles.Btn_Continuar,'enable','on')
else
   set(handles.Btn_Continuar,'enable','off')
end

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



function Edit_R_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Op_param = str2double(get(handles.Edit_R,'string'));

if ~isnan(handles.Op_param)
   set(handles.Btn_Continuar,'enable','on')
else
   set(handles.Btn_Continuar,'enable','off')
end

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


% --- Executes when selected object is changed in Panel_Param.
function Panel_Param_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Panel_Param 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if eventdata.NewValue == handles.RadBtn_Pn
    
    handles.Op_param = str2double(get(handles.Edit_Pn,'string'));
    handles.Op_paramID = 'P';
    set(handles.Edit_Pn,'enable','on')
    set(handles.Edit_R,'enable','off')
    
    if ~isnan(handles.Op_param)
       set(handles.Btn_Continuar,'enable','on')
    else
       set(handles.Btn_Continuar,'enable','off')
    end
    
else
    
    handles.Op_param = str2double(get(handles.Edit_R,'string'));
    handles.Op_paramID = 'R';
    set(handles.Edit_Pn,'enable','off')
    set(handles.Edit_R,'enable','on')
    
    if ~isnan(handles.Op_param)
       set(handles.Btn_Continuar,'enable','on')
    else
       set(handles.Btn_Continuar,'enable','off')
    end
    
end

guidata(hObject,handles)


% --- Executes when selected object is changed in Panel_Control.
function Panel_Control_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Panel_Control 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

if eventdata.NewValue == handles.RadBtn_Stall
    handles.Op_cntrl = 'S';
else
    handles.Op_cntrl = 'P';
end

guidata(hObject,handles)
