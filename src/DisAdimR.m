function varargout = DisAdimR(varargin)
% DISADIMR MATLAB code for DisAdimR.fig
%      DISADIMR, by itself, creates a new DISADIMR or raises the existing
%      singleton*.
%
%      H = DISADIMR returns the handle to a new DISADIMR or the handle to
%      the existing singleton*.
%
%      DISADIMR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISADIMR.M with the given input arguments.
%
%      DISADIMR('Property','Value',...) creates a new DISADIMR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DisAdimR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DisAdimR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DisAdimR

% Last Modified by GUIDE v2.5 12-Sep-2015 17:29:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DisAdimR_OpeningFcn, ...
                   'gui_OutputFcn',  @DisAdimR_OutputFcn, ...
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


% --- Executes just before DisAdimR is made visible.
function DisAdimR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DisAdimR (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
set(handles.Fig_DisAdimR,'windowstyle','modal')

%______Recuperación de valores de entrada_________
p = varargin{1};
Z = varargin{2};
J = varargin{3};
rR = varargin{4};
Op_F = varargin{5};
Op_Cd = varargin{6};

%_______Cálculo de perfil óptimo_________

j = rR .* J;
a = 1/4 * (2 + sqrt(1 + j.^2) .* (sqrt(3)*sin(atan(j)/3) - cos(atan(j)/3)));
ap = (1 - 3*a)./(4*a - 1);
fi = atan( (1 - a) ./ ( (1 + ap) .* j) );

Cl = p.Cl.Fun3D(p.a.Fun2D(rR),rR);

if Op_Cd == 1
    Cd = 0;
else
    Cd = p.Cd.Fun3D(p.a.Fun2D(rR),rR);
end

Cn = Cl .* cos(fi) + Cd .* sin(fi);

switch Op_F
    case 1
        F = 1;
    case 2
        F = 2/pi * acos( exp( -Z/2 .* (1 - rR) ./ (rR .* sin(fi)) ) );
    case 3 
        F = 2/pi * acos( exp( -Z/2 .* (1 - rR) .* sqrt(1 + J.^2) ) );
end

cR = 8*pi*a .* rR .* F .* sin(fi) .^2 ./ ( Z * (1 - a) .* Cn);

th = fi - p.a.Fun2D(rR)/180*pi;

%____Guardar la data a graficar_____

handles.p = p;
handles.rR.Data = rR;
handles.rR.Qry = linspace(min(rR),1,200);
handles.a.Data = a;
handles.a.Fun2D = griddedInterpolant(rR,a,'pchip');
handles.ap.Data = ap;
handles.ap.Fun2D = griddedInterpolant(rR,ap,'pchip');
handles.fi.Data = fi;
handles.fi.Fun2D = griddedInterpolant(rR,fi,'pchip');
handles.cR.Data = cR;
handles.cR.Fun2D = griddedInterpolant(rR,cR,'pchip');
handles.th.Data = th;
handles.th.Fun2D = griddedInterpolant(rR,th,'pchip');

handles.rRmin = min(rR);

% linspace(min(rR),1,20)*2.05
% handles.cR.Fun2D(linspace(min(rR),1,20))*2.05
% handles.th.Fun2D(linspace(min(rR),1,20))*180/pi

%Inicialización de slider
handles.rRq = handles.rRmin;

%Graficación inicial

Graficar(1,0,handles)

Graficar(2,0,handles)

Graficar(3,1,handles)



%Menú contextual

cm = uicontextmenu;
uimenu(cm,'label','Exportar','callback',{@Exportar,handles.Axe_Caract});
set(handles.Axe_Caract,'uicontextmenu',cm)


% Choose default command line output for DisAdimR
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);


% UIWAIT makes DisAdimR wait for user response (see UIRESUME)
% uiwait(handles.Fig_DisAdimR);


% --- Outputs from this function are returned to the command line.
function varargout = DisAdimR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function Sli_Secciones_Callback(hObject, eventdata, handles)
% hObject    handle to Sli_Secciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.rRq = get(handles.Sli_Secciones,'value')*(1 - handles.rRmin) + handles.rRmin;

Graficar(2,0,handles)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function Sli_Secciones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sli_Secciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in Pop_Caract.
function Pop_Caract_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Caract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Tipo = get(handles.Pop_Caract,'value');
Graficar(3,Tipo,handles);

% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Caract contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Caract


% --- Executes during object creation, after setting all properties.
function Pop_Caract_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Caract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_Continuar.
function Btn_Continuar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Continuar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Recuperar la estructura de la figura principal
hPrin = findall(0,'tag','Fig_Principal');
handlesPrin = guidata(hPrin);

%Guardar funciones generadas
handlesPrin.cR_th{1,1} = handles.cR.Fun2D;
handlesPrin.cR_th{2,1} = handles.th.Fun2D;


% Activar resultados generados
set(handlesPrin.RadBtn_cRTorA,'value',1)
set(handlesPrin.Btn_cR,'enable','off')
set(handlesPrin.Btn_Tor,'enable','off')

%Seleccionar funciones generadas
handlesPrin.cR_th{1,3} = handles.cR.Fun2D;
handlesPrin.cR_th{2,3} = handles.th.Fun2D;

%Informar que las funciones fueron generadas
set(handlesPrin.Text_cRA,'string','c/R -OK-');
set(handlesPrin.Text_TorA,'string','Torsión -OK-');

%Verificar si se puede activar el botón de diseño adimensional
CheckFun(handlesPrin,handlesPrin.Btn_AnaAdim);

guidata(hPrin,handlesPrin)


%Recuperar referencia a ventana de opciones
hDisAdim = findall(0,'tag','Fig_DisAdim');
% 
% %Cerrar ventanas
close(hDisAdim)
close(gcf)


function Graficar(Opcion, tipo, handles)
switch Opcion
    case 1
        %Parametric Plot3D
        
        %Configuración base para gráficas:
        
        %Funciones de interpolación de theta(rR), cR(rR) y perfil
        th = handles.th.Fun2D;
        cR = handles.cR.Fun2D;
        e = handles.p.y.e.Fun3D;
        i = handles.p.y.i.Fun3D;
        
        %Dominio de los parámetros
        x =(logspace(0,4,400)-1)/9999 ;
        rR = handles.rR.Qry;
        
        %Centro aerodinámico (centro de rotación del perfil
        %punto donde los momentos ~ independientes de alfa)
        c = 0.25;
        
        %Mallado
        [xmesh,rRmesh]=meshgrid(x,rR);
        
        %Coordenadas X e Y del Extradós
        XE = reshape( cR(rRmesh(:)) .* (cos( th(rRmesh(:)) ) .* (xmesh(:) - c)...
            -(e(xmesh(:),rRmesh(:)) ) .* sin( th(rRmesh(:))) ) ,size(rRmesh));
        
        YE = reshape( cR(rRmesh(:)) .* (sin( th(rRmesh(:)) ) .* (xmesh(:) - c)...
            +(e(xmesh(:),rRmesh(:)) ) .* cos( th(rRmesh(:))) ) ,size(rRmesh));
        
        %Coordenadas X e Y del Intradós
        XI = reshape( cR(rRmesh(:)) .* (cos( th(rRmesh(:)) ) .* (xmesh(:) - c)...
            -(i(xmesh(:),rRmesh(:)) ) .* sin( th(rRmesh(:))) ) ,size(rRmesh));
        
        YI = reshape( cR(rRmesh(:)) .* (sin( th(rRmesh(:)) ) .* (xmesh(:) - c)...
            +(i(xmesh(:),rRmesh(:)) ) .* cos( th(rRmesh(:))) ) ,size(rRmesh));
        
        % Coordenada Z
        Zv = rRmesh;
        
        %Graficación
        hAxe = handles.Axe_P3D;
        surf(hAxe,XE,YE,Zv);hold on;
        surf(hAxe,XI,YI,Zv);
        axis(hAxe,'equal');
        shading(hAxe,'interp');
        
        
        %Punto de vista
        az = -37;
        el = 34;
        view(hAxe,az,el);
        rotate3d(hAxe,'on')
        uiMode = getuimode(handles.Fig_DisAdimR,'Exploration.Rotate3d');
        uiMode.ButtonDownFilter = @StopRotate;
        
    case 2
        
        
        %handle de la gráfica
        hAxe = handles.Axe_Secciones;
        
        %Relación de aspecto = 1
        axis(hAxe,'equal');
        
        %Dominio de los perfiles
        x =(logspace(0,4,400)-1)/9999 ;
        rRmin = handles.rRmin;
        
        %Dimension del dominio
        dimDom=ones(1,length(x));
        
        %Centro aerodinámico (centro de rotación del perfil
        %punto donde los momentos ~ independientes de alfa)
        c = 0.25;
        
        %Funciones de interpolación de theta(rR), cR(rR) y perfil
        th = handles.th.Fun2D;
        cR = handles.cR.Fun2D;
        e = handles.p.y.e.Fun3D;
        i = handles.p.y.i.Fun3D;
        
        %Plot de los perfiles
        for j = 1:21
            
            %r/R de perfil temporal a graficar y color
            if j == 21
                rRt = handles.rRq * dimDom;
                color = [0 0 0];
                htxt = text(.4,0,sprintf('r/R = %0.2f',handles.rRq),...
                    'FontSize',12,'FontWeight','bold','units','normalized');
                set(htxt,'parent',hAxe);
            else
                rRt=( (j - 1) * (1 - rRmin) / 19 + rRmin ) * dimDom;
                color = [.91 .91 .91];
            end
            
            %Coordenadas X e Y para el extradós
            XE = cR(rRt) .* ( cos( th(rRt) ) .* (x - c)...
                -( e(x,rRt) ) .* sin( th(rRt) ) );
            
            YE = cR(rRt) .* ( sin( th(rRt) ) .* (x - c)...
                +( e(x,rRt) ) .* cos( th(rRt) ) );
            
            %Coordenadas X e Y para el intradós
            XI = cR(rRt) .* ( cos( th(rRt) ) .* (x - c)...
                -( i(x,rRt) ) .* sin( th(rRt) ) );
            
            YI = cR(rRt) .* ( sin( th(rRt) ) .* (x - c)...
                +( i(x,rRt) ) .* cos( th(rRt) ) );
            
            
            %Plot de el primer perfil
            plot(hAxe,XE,YE,'color',color,'LineWidth',2);
            
            if j == 1
                hold(hAxe,'on');
                axis(hAxe,'off');
            end
            
            plot(hAxe,XI,YI,'color',color,'LineWidth',2);
            
            
        end
        
        %liberar la gráfica
        hold(hAxe,'off');
        
        %ejes iguales
        axis(hAxe,'equal');
        
    case 3
        
        hAxe = handles.Axe_Caract;
        x = handles.rR.Qry;
        xData = handles.rR.Data;
        
        switch tipo
            
            case 1
                
                y = handles.a.Fun2D(x);
                yData = handles.a.Data;
                yStr = 'Factor de inducción axial - a';
                
            case 2
                
                y = handles.ap.Fun2D(x);
                yData = handles.ap.Data;
                yStr = 'Factor de inducción tangencial - a''';
                
            case 3
                
                y = handles.fi.Fun2D(x)./pi*180;
                yData = handles.fi.Data/pi*180;
                yStr = 'Ángulo de flujo - \Phi';
                
            case 4
                
                y = handles.th.Fun2D(x)./pi*180;
                yData = handles.th.Data/pi*180;
                yStr = 'Ángulo de torsión - \theta';
                
            case 5
                
                y = handles.cR.Fun2D(x);
                yData = handles.cR.Data;
                yStr = 'Cuerda adimensional - c/R';
                
        end
        
        plot(hAxe, x, y,'-');
        hold(hAxe,'on');
        plot(hAxe,xData,yData,'.','tag','Plot_Data');
        legend(findall(hAxe,'tag','Plot_Data'),'Puntos de discretización','location','best');
        hold(hAxe,'off');
        
        ylabel(hAxe,yStr);
        xlabel(hAxe,'r/R');
        
        %Identificar cada vez que se haga una nueva gráfica
        set(hAxe,'tag','DoNotIgnore')
end

function [flag] = StopRotate(obj,event_obj)
% If the tag of the object is 'DoNotIgnore', then return true
objTag = obj.Tag;
if strcmpi(objTag,'DoNotIgnore')
    flag = true;
else
    flag = false;
end
