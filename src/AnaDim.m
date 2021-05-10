function varargout = AnaDim(varargin)
% ANADIM MATLAB code for AnaDim.fig
%      ANADIM, by itself, creates a new ANADIM or raises the existing
%      singleton*.
%
%      H = ANADIM returns the handle to a new ANADIM or the handle to
%      the existing singleton*.
%
%      ANADIM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANADIM.M with the given input arguments.
%
%      ANADIM('Property','Value',...) creates a new ANADIM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaDim_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaDim_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaDim

% Last Modified by GUIDE v2.5 20-Sep-2015 12:09:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaDim_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaDim_OutputFcn, ...
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


% --- Executes just before AnaDim is made visible.
function AnaDim_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaDim (see VARARGIN)


%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
%set(hObject,'windowstyle','modal')

% Choose default command line output for AnaDim
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaDim wait for user response (see UIRESUME)
% uiwait(handles.Fig_AnaDim);


% --- Outputs from this function are returned to the command line.
function varargout = AnaDim_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Btn_AnaDimF.
function Btn_AnaDimF_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_AnaDimF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AnaDimF

% --- Executes on button press in Btn_AnaDimV.
function Btn_AnaDimV_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_AnaDimV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AnaDimV
