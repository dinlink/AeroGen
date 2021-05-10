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

function varargout = AnaAdim_Op(varargin)
% ANAADIM_OP MATLAB code for AnaAdim_Op.fig
%      ANAADIM_OP, by itself, creates a new ANAADIM_OP or raises the existing
%      singleton*.
%
%      H = ANAADIM_OP returns the handle to a new ANAADIM_OP or the handle to
%      the existing singleton*.
%
%      ANAADIM_OP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANAADIM_OP.M with the given input arguments.
%
%      ANAADIM_OP('Property','Value',...) creates a new ANAADIM_OP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaAdim_Op_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaAdim_Op_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaAdim_Op

% Last Modified by GUIDE v2.5 18-Sep-2015 00:37:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaAdim_Op_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaAdim_Op_OutputFcn, ...
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


% --- Executes just before AnaAdim_Op is made visible.
function AnaAdim_Op_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaAdim_Op (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(handles.Fig_AnaAdim_Op,'windowstyle','modal')

handlesAd = varargin{1};

handles.Op_F = handlesAd.Op_F;
set(handles.Pop_F,'value',handles.Op_F);

handles.Op_Cd = handlesAd.Op_Cd;
set(handles.Pop_Cd,'value',handles.Op_Cd);

handles.Op_Cx = handlesAd.Op_Cx;
set(handles.Pop_Cx,'value',handles.Op_Cx);

handles.Op_Stall = handlesAd.Op_Stall;
set(handles.Pop_Stall,'value',handles.Op_Stall);

handles.Op_Cp = handlesAd.Op_Cp;
set(handles.Pop_Cp,'value',handles.Op_Cp);




% Choose default command line output for AnaAdim_Op
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaAdim_Op wait for user response (see UIRESUME)
  uiwait(handles.Fig_AnaAdim_Op);


% --- Outputs from this function are returned to the command line.
function varargout = AnaAdim_Op_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.Op_F;
varargout{2} = handles.Op_Cd;
varargout{3} = handles.Op_Cx;
varargout{4} = handles.Op_Stall;
varargout{5} = handles.Op_Cp;

%La figura puede ser borrada ahora
delete(handles.Fig_AnaAdim_Op);


% --- Executes on selection change in Pop_F.
function Pop_F_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Op_F = get(handles.Pop_F,'value');

guidata(hObject,handles)
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

guidata(hObject,handles)
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


% --- Executes on selection change in Pop_Cx.
function Pop_Cx_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Cx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Op_Cx = get(handles.Pop_Cx,'value');

guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Cx contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Cx


% --- Executes during object creation, after setting all properties.
function Pop_Cx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Cx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Pop_Stall.
function Pop_Stall_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Stall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Op_Stall = get(handles.Pop_Stall,'value');

guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Stall contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Stall


% --- Executes during object creation, after setting all properties.
function Pop_Stall_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Stall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Pop_Cp.
function Pop_Cp_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Op_Cp = get(handles.Pop_Cp,'value');

guidata(hObject,handles)
% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Cp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Cp


% --- Executes during object creation, after setting all properties.
function Pop_Cp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close Fig_AnaAdim_Op.
function Fig_AnaAdim_Op_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to Fig_AnaAdim_Op (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end
