function varargout = AnaDimV(varargin)
% ANADIMV MATLAB code for AnaDimV.fig
%      ANADIMV, by itself, creates a new ANADIMV or raises the existing
%      singleton*.
%
%      H = ANADIMV returns the handle to a new ANADIMV or the handle to
%      the existing singleton*.
%
%      ANADIMV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANADIMV.M with the given input arguments.
%
%      ANADIMV('Property','Value',...) creates a new ANADIMV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaDimV_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaDimV_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaDimV

% Last Modified by GUIDE v2.5 21-Sep-2015 00:16:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaDimV_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaDimV_OutputFcn, ...
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


% --- Executes just before AnaDimV is made visible.
function AnaDimV_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaDimV (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
%set(hObject,'windowstyle','modal')

%_____Recuperación de valores de ventana principal_____
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

handles.Cp = handlesPrin.Cp{1,3};
handles.c = handlesPrin.ckF0(1,3);
handles.k = handlesPrin.ckF0(2,3);
handles.F0 = handlesPrin.ckF0(3,3);
handles.R = handlesPrin.Rw(1,3);
Jn = handlesPrin.Cp{2,3}(1);
Cpn = handlesPrin.Cp{2,3}(2);
handles.Pn = handlesPrin.Pn(3);



% Configuración de variables
Jmin = 1.5;
Jmax = 15;
handles.Jd = fminbnd( @(x) -handles.Cp(x), Jmin, Jmax );

wn = ( handles.Pn * 1000 / (1/2 * 1.225 * Cpn * (handles.R / Jn)^3 * pi * handles.R^2 ) )^(1/3);

handles.wi = 0.7 * wn *60 /(2*pi);
handles.wa = 1.3 * wn *60 /(2*pi);


% Velocidad de arranque y parada
% handles.Vin = wn * handles.R / Jmax;
% handles.Vout = wn * handles.R / Jmin;
handles.Vin = handles.c * ( - log( 0.9 ) ).^(1/handles.k);
handles.Vout = handles.c * ( - log( .000000001 ) ).^(1/handles.k);

%Graficación y calculo de EAR
PV_Cp_EAR(handles)


%Configuración de text edit

set(handles.Edit_R, 'string', num2str( handles.R ) );
set(handles.Edit_Pn, 'string', num2str( handles.Pn ) );
set(handles.Edit_wmin, 'string', num2str( handles.wi ) );
set(handles.Edit_wmax, 'string', num2str( handles.wa ) );
set(handles.Edit_Jn, 'string', num2str( handles.Jd ) );

set(handles.Edit_Vin, 'string', num2str( handles.Vin) );
set(handles.Edit_Vout, 'string', num2str( handles.Vout) );




% Choose default command line output for AnaDimV
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaDimV wait for user response (see UIRESUME)
% uiwait(handles.Fig_AnaDimV);


% --- Outputs from this function are returned to the command line.
function varargout = AnaDimV_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Edit_R_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.R = str2double( get(handles.Edit_R, 'string') );

%Graficación y calculo 
PV_Cp_EAR(handles)

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



function Edit_Pn_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Pn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Pn = str2double( get(handles.Edit_Pn, 'string') );

%Graficación y calculo 
PV_Cp_EAR(handles)

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



function Edit_wmin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_wmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.wi = str2double( get(handles.Edit_wmin, 'string') );

%Graficación y calculo 
PV_Cp_EAR(handles)

guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of Edit_wmin as text
%        str2double(get(hObject,'String')) returns contents of Edit_wmin as a double


% --- Executes during object creation, after setting all properties.
function Edit_wmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_wmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_wmax_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_wmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.wa = str2double( get(handles.Edit_wmax, 'string') );

%Graficación y calculo 
PV_Cp_EAR(handles)

guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of Edit_wmax as text
%        str2double(get(hObject,'String')) returns contents of Edit_wmax as a double


% --- Executes during object creation, after setting all properties.
function Edit_wmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_wmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Jn_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Jn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Jd = str2double( get(handles.Edit_Jn, 'string') );

%Graficación y calculo 
PV_Cp_EAR(handles)

guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of Edit_Jn as text
%        str2double(get(hObject,'String')) returns contents of Edit_Jn as a double


% --- Executes during object creation, after setting all properties.
function Edit_Jn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Jn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Vin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Vin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Vin = str2double( get(handles.Edit_Vin, 'string') );

%Graficación y calculo 
PV_Cp_EAR(handles)

guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of Edit_Vin as text
%        str2double(get(hObject,'String')) returns contents of Edit_Vin as a double


% --- Executes during object creation, after setting all properties.
function Edit_Vin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Vin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Vout_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Vout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Vout = str2double( get(handles.Edit_Vout, 'string') );

%Graficación y calculo 
PV_Cp_EAR(handles)

guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of Edit_Vout as text
%        str2double(get(hObject,'String')) returns contents of Edit_Vout as a double


% --- Executes during object creation, after setting all properties.
function Edit_Vout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Vout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function PV_Cp_EAR(handles)

c = handles.c;
k = handles.k;
F0 = handles.F0;
Cp = handles.Cp;
Jd = handles.Jd;
R = handles.R;
Pn = handles.Pn * 1000;
Vin = handles.Vin;
Vout = handles.Vout;
wi = handles.wi *2*pi/60;
wa = handles.wa *2*pi/60;

%________Función de Cp(V)________

Cpd = Cp(Jd);

% Parámetro crítico

Vt = ( Pn / ( 1/2 * 1.225 * Cpd * pi * R^2) )^(1/3);

Va = wa * R / Jd ;
Vi = wi * R / Jd ;

Cpr = @(V) Pn ./ ( 1/2 * 1.225 * V.^3 * pi * R^2) ;

Vn = fzero(@(V) (Pn ./ ( 1/2 * 1.225 * Cp( wa * R /V ) * pi * R^2 )).^(1/3) - V , Vt);

if Va < Vt
    CpV = @(V) Cp(wi * R ./ V) .* (V < Vi) + Cpd * (V >= Vi) .* (V < Va) +...
        Cp(wa * R ./ V) .* (V >= Va) .* (V < Vn) + Cpr(V) .* (V >= Vn) ;
else
    CpV = @(V) Cp(wi * R ./ V) .* (V < Vi) + Cpd * (V >= Vi) .* (V < Vt) + ...
        Cpr(V) .* (V >= Vt) ;
    Va = Vt;
end



% calculo de vectores para P vs V
Vdom = linspace(Vin,Vout);

% Vector de Cp
Cpvg = CpV(Vdom);

Pvg = Cpvg .* Vdom .^3 * 1/2 * 1.225 * pi * R^2 / 1000;

P = griddedInterpolant( Vdom, Pvg, 'pchip');
Cp2 =  griddedInterpolant( Vdom, Cpvg, 'pchip');

%Dibujo de gráfica
hAxe = handles.Axe_PV;

plot(hAxe, Vdom, P(Vdom))
hold(hAxe, 'on')

plot(hAxe, Vin, P(Vin), 'bo','MarkerFaceColor',[0 0 1])
plot(hAxe, Vout, P(Vout), 'ro', 'MarkerFaceColor',[1 0 0])
plot(hAxe, Vi, P(Vi), 'go', 'MarkerFaceColor',[0.2 1 0.4])
plot(hAxe, Va, P(Va), 'mo', 'MarkerFaceColor',[1 0.2 0.8])
ylabel(hAxe, 'Potencia (kW)')
xlabel(hAxe, 'Velocidad (m/s)')
title(hAxe,'Curva potencia vs velocidad')
hold(hAxe, 'off')


%Dominio temporal de la integral de EAR
Dt = 365*24*60*60;
tmin = (1 - F0) * Dt * exp( -(Vout / c) ^ k ) + 1;
tmax = (1 - F0) * Dt * exp( -( Vin / c) ^ k ) - 1;
tdom1 = (logspace(0,4,300)-1) / 9999 * (tmax - tmin) + tmin;
tdom2 = sort((10^4 - logspace(0,4,300)) / 9999) * (tmax - tmin) + tmin;
tdom = [tdom1(tdom1 < tmax/2) , tdom2(tdom2 >= tmax/2)];

% dominio de velocidad para cálculo de EAR
Pi = tdom./Dt /(1 - F0);
Pi(Pi>1) = 1;
VEARdom = c * ( - log( Pi ) ).^(1/k);

% Integración de EAR
EAR = trapz( tdom, P(VEARdom) ) /3600 /10^3;

% EAR calculado
set(handles.Text_EAR,'string',sprintf('Energía anual recuperada (MWh): %0.2f',EAR))

% Cp nominal

set(handles.Text_Cpn, 'string', sprintf('Coeficiente de potencia de diseño: %0.2f',Cpd))

% Grafica de Cp
hAxe = handles.Axe_Cp;

plot(hAxe, Vdom, Cpvg)
hold(hAxe, 'on')

plot(hAxe, Vin, Cp2(Vin), 'bo','MarkerFaceColor',[0 0 1])
plot(hAxe, Vout, Cp2(Vout), 'ro', 'MarkerFaceColor',[1 0 0])
plot(hAxe, Vi, Cp2(Vi), 'go', 'MarkerFaceColor',[0.2 1 0.4])
plot(hAxe, Va, Cp2(Va), 'mo', 'MarkerFaceColor',[1 0.2 0.8])
ylabel(hAxe, 'Cp')
xlabel(hAxe, 'Velocidad (m/s)')
title(hAxe,'Coeficiente de potencia vs velocidad')
hold(hAxe, 'off')
