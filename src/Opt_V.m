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
function varargout = Opt_V(varargin)
% OPT_V MATLAB code for Opt_V.fig
%      OPT_V, by itself, creates a new OPT_V or raises the existing
%      singleton*.
%
%      H = OPT_V returns the handle to a new OPT_V or the handle to
%      the existing singleton*.
%
%      OPT_V('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPT_V.M with the given input arguments.
%
%      OPT_V('Property','Value',...) creates a new OPT_V or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Opt_V_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Opt_V_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Opt_V

% Last Modified by GUIDE v2.5 11-Jun-2018 10:52:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Opt_V_OpeningFcn, ...
                   'gui_OutputFcn',  @Opt_V_OutputFcn, ...
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


% --- Executes just before Opt_V is made visible.
function Opt_V_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Opt_V (see VARARGIN)

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
handles.Jn = handlesPrin.Cp{2,3}(1);
handles.param = varargin{1};
handles.paramID = varargin{2};


% _________________Inicialización______________

c = handles.c;
k = handles.k;

handles.Vin = c * ( - log( 0.999 ) ).^(1/k);
handles.Vout = c * ( - log( .001 ) ).^(1/k);

handles.Vin_betz = c * ( - log( 0.999 ) ).^(1/k);
handles.Vout_betz = c * ( - log( 0.001 ) ).^(1/k);

handles.Vn = 11;
handles.Umax = handles.Vn * handles.Jn;
handles.Umin = 0.1 * 300;

Jmin = handles.Jn;
Jmax = 12;
handles.Jd = fminbnd( @(x) - handles.Cp(x), Jmin, Jmax );


% _________Calculo concernientes al parámetro fijado____________
if handles.paramID == 'P'
       
    handles.Pn = @(Umax,Vn) handles.param * 1000;
    handles.R  = @(Umax,Vn) ( handles.Pn(Umax,Vn) / (1/2 * 1.225 * handles.Cp(Umax/Vn) * (Vn) .^3 * pi ) ) ^ 0.5;
    
else
    
    handles.R  = @(Umax,Vn) handles.param;
    handles.Pn = @(Umax,Vn) 1/2 * 1.225 * handles.Cp(Umax/Vn) * (Vn) .^3 * pi * handles.R(Umax,Vn)^2 ;
end


handles.wi = handles.Umin / handles.R(handles.Umax,handles.Vn);
handles.wa = handles.Umax / handles.R(handles.Umax,handles.Vn);

%Inicialización cuadros de texto editables
set(handles.Edit_Vin, 'string', sprintf('%0.1f', handles.Vin ) );
set(handles.Edit_Vout, 'string', sprintf('%0.1f', handles.Vout ) );
set(handles.Edit_Umin, 'string', num2str( handles.Umin) );
set(handles.Edit_Umax, 'string', num2str( handles.Umax) );
set(handles.Edit_Wmin, 'string', sprintf('%0.0f',handles.wi*60/2/pi) );
set(handles.Edit_Wmax, 'string', sprintf('%0.0f',handles.wa*60/2/pi) );


%Para acelerar el proceso de actualización de la grafica, se decide esbozar
%el gráfico primero, con dummy data y luego dentro de la función calcular
%solo actualizar las propiedades XData y YData

%___Dummy Plot

hAxe = handles.Axe_Graf;

VnX = [20 20];
VnY = [0 1];

p = plot(hAxe                                     ,...
    VnX,   VnY           ,  '-b'                  ,...
    VnX,   VnY           , ':g'                   ,...
    VnX,   VnY           , '--r'                  ,...
    VnX,   VnY           , 'bo'                   ,...
    VnX,   VnY           , 'co'                   ,...
    VnX,   VnY           , 'mo'                   ,...
    VnX,   VnY           , 'ro'                   ,...
    VnX,   VnY           , '-.k'                   ,...
    'LineWidth',2        );

set(p(4), 'MarkerFaceColor',[0 0 1])
set(p(5), 'MarkerFaceColor',[0 1 1])
set(p(6), 'MarkerFaceColor',[1 0 1])
set(p(7), 'MarkerFaceColor',[1 0 0])

xlabel(hAxe, 'Velocidad del viento (m/s)' )
ylabel(hAxe, 'Potencia normalizada, tiempo normalizado, Cp')
title(hAxe,sprintf('Características para turbina de radio %0.2f m',1))

legend(hAxe,  'P/Pn', 't/Dt', 'Cp', 'Vin', 'P(V@Wmin)', 'P(V@Wmax)', 'Vout', 'Vn', 'location', 'EastOutside')
 
%speedUp
set(hAxe,'DrawMode','fast')
% Static legend
set(hAxe,'LegendColorbarListeners',[]); 
setappdata(hAxe,'LegendColorbarManualSpace',1);
setappdata(hAxe,'LegendColorbarReclaimSpace',1);
axis(hAxe, [ 0, 25, 0, 1.05])


Calcular(handles);

%Inicialización de función de arrastre
% Drag and drop explicación:
% Primero se activa la función down, para que entre al presionar el bontón
% derecho del raton
% En la función Down se activa la función WindowsUP y WindowsMotion
% En Windows Motion de hace lo que se quiere arrastrar (mover un punto)
% En WindowsUP se finaliza!: se asigna nada a WindwsMotion y WindowsUP y se
% re-asigna ButtonDownFcn que habrá desaparecido durante WindowsMotion.
% Hay que re-asignar ButtonDownFcn en todas las llamadas a la graficación
% que puedan sobreeescribirla y perder la entrada inicial al bucle

hLine = get(handles.Axe_Graf,'children');
set(hLine(1),'ButtonDownFcn',{@down,handles})


%Menú contextual

cm = uicontextmenu;
uimenu(cm,'label','Exportar','callback',{@Exportar,handles.Axe_Graf});
set(handles.Axe_Graf,'uicontextmenu',cm)

% Choose default command line output for Opt_V
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Opt_V wait for user response (see UIRESUME)
% uiwait(handles.Fig_OptV);


% --- Outputs from this function are returned to the command line.
function varargout = Opt_V_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Edit_Vin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Vin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Vin = str2double( get( handles.Edit_Vin, 'string'));
Calcular(handles)

hLine = get(handles.Axe_Graf,'children');
set(hLine(1),'ButtonDownFcn',{@down,handles})

guidata(hObject, handles);

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

handles.Vout = str2double( get( handles.Edit_Vout, 'string'));
Calcular(handles)

hLine = get(handles.Axe_Graf,'children');
set(hLine(1),'ButtonDownFcn',{@down,handles})

guidata(hObject, handles);


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



function Edit_Umin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Umin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Umin = str2double( get( handles.Edit_Umin, 'string'));
handles.wi = handles.Umin / handles.R(handles.Umax,handles.Vn);
set(handles.Edit_Wmin, 'string', sprintf('%0.0f',handles.wi*60/2/pi) );

Calcular(handles)

hLine = get(handles.Axe_Graf,'children');
set(hLine(1),'ButtonDownFcn',{@down,handles})

guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of Edit_Umin as text
%        str2double(get(hObject,'String')) returns contents of Edit_Umin as a double


% --- Executes during object creation, after setting all properties.
function Edit_Umin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Umin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Umax_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Umax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Umax = str2double( get( handles.Edit_Umax, 'string'));
handles.wa = handles.Umax/handles.R(handles.Umax,handles.Vn);
set(handles.Edit_Wmax, 'string', sprintf('%0.0f',handles.wa*60/2/pi) );

Calcular(handles)

hLine = get(handles.Axe_Graf,'children');
set(hLine(1),'ButtonDownFcn',{@down,handles})

guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of Edit_Umax as text
%        str2double(get(hObject,'String')) returns contents of Edit_Umax as a double


% --- Executes during object creation, after setting all properties.
function Edit_Umax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Umax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function Calcular(handles)

%Captura de variables de entrada necesarias
c = handles.c;
k = handles.k;
F0 = handles.F0;
Cp = handles.Cp;
Jd = handles.Jd;
Vin = handles.Vin;
Vin_betz = handles.Vin_betz;
Vout = handles.Vout;
Vout_betz = handles.Vout_betz;
Umin = handles.Umin;
Umax = handles.Umax;
Vn = handles.Vn;

Pn = handles.Pn(Umax,Vn);
R = handles.R(Umax,Vn);



Tn = Pn/Umax * R ;

%________Función de Cp(V,Umin,Umax)________

CpPctte = @(V) Pn ./ ( 1/2 * 1.225 * V.^3 * pi * R^2) ;


Va = Umax / Jd ;
Vi = Umin / Jd ;

CpV = @(V) ...
    Cp(Umin ./ V)            .* (V < Vi)                         +   ...
    Cp(Jd)                   .* (V >= Vi) .* (V < Va )           +   ...
    Cp(Umax ./ V)            .* (V >= Va) .* (V < Vn )           +   ...
    CpPctte(V)               .* (V >= Vn)  ;

    



%__________Función de P(V,Umin,Umax), P_betz(V) y  t(V) ___________

P =      @(V) 1/2 .* 1.225 .* CpV(V) .* V.^3.* pi .* R^2;
P_betz = @(V) 1/2 .* 1.225 .* 16/27 .* V.^3.* pi .* R^2;

Dt = 365*24*60*60;
t = @(V) Dt .* (1 - F0) .* exp( -( V ./ c ) .^ k );


%___________ Cálculo de valores numéricos_________

V        = linspace(Vin,Vout,500) ;

V_betz =  linspace(Vin_betz,Vout_betz,500) ;

EAR      = abs(trapz( t(V), P(V) ) ) /3600 /10^6;

EAR_betz = abs(trapz( t(V_betz), P_betz(V_betz) ) ) /3600 /10^6 ;

C_EAR    = EAR/EAR_betz;



% Pérdidas lado de baja y alta velocidad

%Guardar variables modificadas


%__________ Modificación de textos________________
set(handles.Text_CEAR, 'string', sprintf('Coeficiente de energía anual recuperada: %0.2f ',C_EAR))
set(handles.Text_EAR, 'string', sprintf('Energía anual recuperada: %0.2f MWh',EAR))

%set(handles.Text_Perdminmax, 'string', sprintf('Pérdidas lado de velocidad baja: %0.1f %%',PerdB))



%____________Graficación_______________

hAxe = handles.Axe_Graf;
Vdom = linspace( 0, 25 , 500);

VnX = [Vn Vn];
VnY = [0 1];

Lines = get(hAxe,'children');

set(Lines(1),'XData',VnX,'YData',VnY)                     %VnX,   VnY   
set(Lines(2),'XData',Vout,'YData',P( Vout ) /Pn)          %Vout, P( Vout ) /Pn
set(Lines(3),'XData',Va,'YData',P( Va ) /Pn)              %Va,   P( Va ) /Pn 
set(Lines(4),'XData',Vi,'YData',P( Vi  ) /Pn)             %Vi,   P( Vi  ) /Pn
set(Lines(5),'XData',Vin,'YData',P( Vin ) /Pn)            %Vin,  P( Vin ) /Pn
set(Lines(6),'XData',Vdom,'YData',CpV(Vdom ))             %Vdom, CpV(Vdom ) 
set(Lines(7),'XData',Vdom,'YData',t(Vdom) /Dt)            %Vdom, t(Vdom) /Dt
set(Lines(8),'XData',Vdom,'YData',P( Vdom ) /Pn)          %Vdom, P( Vdom ) /Pn

% p = plot(hAxe                                             ,...
%     Vdom, P( Vdom ) /Pn          ,  '-b'                  ,...
%     Vdom, t(Vdom) /Dt            , ':g'                   ,...
%     Vdom, CpV(Vdom )             , '--r'                  ,...
%     Vin,  P( Vin ) /Pn           , 'bo'                   ,...
%     Vi,   P( Vi  ) /Pn           , 'co'                   ,...
%     Va,   P( Va ) /Pn            , 'mo'                   ,...
%     Vout, P( Vout ) /Pn          , 'ro'                   ,...
%     VnX,   VnY                   , '-.k'                   ,...
%     'LineWidth',2        );
% 

title(hAxe,sprintf('R = %0.2fm; Pn = %0.1fkW, \\tau = %0.2fkN m',R, Pn/1000, Tn/1000))





function Edit_Wmin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Wmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.wi = str2double( get( handles.Edit_Wmin, 'string'));
handles.Umin = handles.wi / 60 * 2*pi * handles.R(handles.Umax,handles.Vn);
handles.R(handles.Umax,handles.Vn)
set(handles.Edit_Umin, 'string', sprintf('%0.1f',handles.Umin) );

Calcular(handles)

hLine = get(handles.Axe_Graf,'children');
set(hLine(1),'ButtonDownFcn',{@down,handles})

guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of Edit_Wmin as text
%        str2double(get(hObject,'String')) returns contents of Edit_Wmin as a double


% --- Executes during object creation, after setting all properties.
function Edit_Wmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Wmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Wmax_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Wmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.wa = str2double( get( handles.Edit_Wmax, 'string'));
handles.Umax = handles.wa/60*2*pi * handles.R(handles.Umax,handles.Vn);

set(handles.Edit_Umax, 'string', sprintf('%0.1f',handles.Umax) );

Calcular(handles)

hLine = get(handles.Axe_Graf,'children');
set(hLine(1),'ButtonDownFcn',{@down,handles})

guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of Edit_Wmax as text
%        str2double(get(hObject,'String')) returns contents of Edit_Wmax as a double


% --- Executes during object creation, after setting all properties.
function Edit_Wmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Wmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function down(hObject,event,handles)
disp('down')
set(handles.Fig_OptV,'WindowButtonUpfcn',{@up,handles})
set(handles.Fig_OptV,'WindowButtonMotionfcn',{@moving,handles})

function moving(hObject,event,handles)
pt = get(handles.Axe_Graf,'CurrentPoint');
handles.Vn = pt(1,1);
Calcular(handles)
guidata(handles.Fig_OptV,handles)

function up(hObject,event,handles)

disp('up')
set(handles.Fig_OptV,'WindowButtonMotionfcn','')
set(handles.Fig_OptV,'WindowButtonUpfcn','')
hLine = get(handles.Axe_Graf,'children');
set(hLine(1),'ButtonDownFcn',{@down,handles})
