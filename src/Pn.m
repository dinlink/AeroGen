function varargout = Pn(varargin)
% PN MATLAB code for Pn.fig
%      PN, by itself, creates a new PN or raises the existing
%      singleton*.
%
%      H = PN returns the handle to a new PN or the handle to
%      the existing singleton*.
%
%      PN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PN.M with the given input arguments.
%
%      PN('Property','Value',...) creates a new PN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pn

% Last Modified by GUIDE v2.5 22-Jun-2015 19:18:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pn_OpeningFcn, ...
                   'gui_OutputFcn',  @Pn_OutputFcn, ...
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


% --- Executes just before Pn is made visible.
function Pn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pn (see VARARGIN)

% Choose default command line output for Pn
handles.output = hObject;

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(gcf,'windowstyle','modal')

%Captura de c, k, F0 y determinación de intervalo de tiempo de mediciones
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

c = handlesPrin.ckF0(1,3);
k = handlesPrin.ckF0(2,3);
F0 = handlesPrin.ckF0(3,3);


if get(handlesPrin.RadBtn_ckA,'value') == 1
    
    Dt = etime(handlesPrin.DataV{end,1},handlesPrin.DataV{1,1});
else

    Dt = 8760*60*60.0;
end

%Paso de intervalo de tiempo Dt a horas
Dt = Dt/3600;

% Captura de Curva PV, EDN y Pn de curva

CurvaPV = handlesPrin.CurvaPV;
Edn = str2double(get(handlesPrin.Edit_Edn,'string'));
Pnc = str2double(get(handlesPrin.Edit_Pnc,'string'));


%Graficación de P vs V
axes(handles.Axe_PV);

x_max = handlesPrin.PV_x_max;
x_val = 0:0.1:x_max;
y_val = ppval(CurvaPV,x_val);

plot(x_val,y_val)
set(gca,'xgrid','on')
set(gca,'ygrid','on')

hx = xlabel('V (m/s)');
set(hx,'units','normalized');
set(hx,'position',[-0.08 -0.08 0]);

hy = ylabel('P(kW)');
set(hy,'units','normalized');
set(hy,'rotation',0);
set(hy,'position',[1.1 1.1 0]);

title('Potencia vs Velocidad de viento','fontweight','bold')
set(gca,'YAxisLocation','right')

%Recuperar escalas X e Y de gráfica PV
YlimPV = get(handles.Axe_PV,'Ylim');


%Graficación de t vs V
axes(handles.Axe_tV);

y_val =Dt*( 1 - ( F0 + (1-F0) * ( 1-exp(-(x_val./c).^k) ) ) );

plot(x_val,y_val)
set(gca,'YAxisLocation','right')
set(gca,'Xticklabel',{})
set(gca,'xgrid','on')
set(gca,'ygrid','on')

ylabel('tiempo (horas)')

ht = title('Tiempo de duración vs velocidad','fontweight','bold');
set(ht,'units','normalized')
set(ht,'position',[0.5 -0.1 0])

%Recuperar escala Y de gráfica tV
YlimtV = get(handles.Axe_tV,'Ylim');

%Graficación P vs t
axes(handles.Axe_Pt);

Dt_val = diff(YlimtV)/201;
t_val = Dt_val:Dt_val:YlimtV(2);
Pi_val = t_val./Dt;
Pi_val(Pi_val>1) = 1;

x_val = c*(-log( (Pi_val+F0-1)/(1-F0) + 1 )).^(1/k);
y_val = ppval(CurvaPV,x_val);

plot(t_val,y_val)

set(gca,'Ylim',YlimPV)
set(gca,'Yticklabel',{})

xlabel('tiempo (horas)')

title('Potencia vs tiempo','fontweight','bold');
set(gca,'xgrid','on')
set(gca,'ygrid','on')


%Cálculo de horas equivalentes
Energia_diaria = trapz(t_val , y_val) *(24/Dt);
Heqd = Energia_diaria/Pnc;

set(handles.Text_Heqd,'string',...
    sprintf('Horas equivalentes diarias = %2.1f',Heqd));

Heqa = Heqd*365;

set(handles.Text_Heqa,'string',...
    sprintf('Horas equivalentes anuales = %4.0f',Heqa));

%Cálculo de Potencia nominal
Pn = Edn/Heqd;
set(handles.Text_Pn,'string',...
    sprintf('Potencia nominal necesaria estimada = %8.3f kW',Pn));

handles.Pn = Pn;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pn wait for user response (see UIRESUME)
% uiwait(handles.Fig_Pn);


% --- Outputs from this function are returned to the command line.
function varargout = Pn_OutputFcn(hObject, eventdata, handles) 
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
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

set(handlesPrin.Text_PnA,'string',sprintf('Pn (kW): %1.2E',handles.Pn))


% Activar opcion generada
set(handlesPrin.RadBtn_PnA,'value',1)
set(handlesPrin.Edit_Pn,'enable','off')

%recuperacion de data
handlesPrin.Pn(1) = handles.Pn;
%selección de data
handlesPrin.Pn(3) = handlesPrin.Pn(1);

%Verificacion
CheckFun(handlesPrin,handlesPrin.Btn_DisDim);
CheckFun(handlesPrin,handlesPrin.Btn_AnaDim);
CheckFun(handlesPrin,handlesPrin.Btn_Opt);

guidata(hPrin,handlesPrin)

close(gcf)
% Hint: get(hObject,'Value') returns toggle state of Btn_Ok
