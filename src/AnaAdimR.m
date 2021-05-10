function varargout = AnaAdimR(varargin)
% ANAADIMR MATLAB code for AnaAdimR.fig
%      ANAADIMR, by itself, creates a new ANAADIMR or raises the existing
%      singleton*.
%
%      H = ANAADIMR returns the handle to a new ANAADIMR or the handle to
%      the existing singleton*.
%
%      ANAADIMR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANAADIMR.M with the given input arguments.
%
%      ANAADIMR('Property','Value',...) creates a new ANAADIMR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnaAdimR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnaAdimR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnaAdimR

% Last Modified by GUIDE v2.5 18-Sep-2015 16:08:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnaAdimR_OpeningFcn, ...
                   'gui_OutputFcn',  @AnaAdimR_OutputFcn, ...
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
end

% --- Executes just before AnaAdimR is made visible.
function AnaAdimR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnaAdimR (see VARARGIN)

%___________Inicio___________

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
%set(handles.Fig_AnaAdimR,'windowstyle','modal')

%______Recuperación de valores de entrada_________

hAnaAdim = varargin{1};

%________ Parámetros invariantes__________
Z = hAnaAdim.Z;
rR = hAnaAdim.rR*0.99;
cR = hAnaAdim.cR_th{1,3}(rR);
th = hAnaAdim.cR_th{2,3}(rR);
rRl = length(rR);

%Reshaping
rR = reshape(rR,[1, 1, rRl]);
cR = reshape(cR,[1, 1, rRl]);
th = reshape(th,[1, 1, rRl]);


% alfa para Cl = 0
alf0 = hAnaAdim.p.a.a0(rR);


%solidez local
s = Z /(2*pi) * cR ./ rR;


%_________ Dominios __________
J = hAnaAdim.J;
Jl = length(J);


%___________ Opciones______________
Op_F = hAnaAdim.Op_F;
Op_Cd = hAnaAdim.Op_Cd;
Op_Cx = hAnaAdim.Op_Cx;
Op_Stall = hAnaAdim.Op_Stall;
Op_Cp = hAnaAdim.Op_Cp;

Op_Debug = hAnaAdim.Op_ChkDebug;

%________ Funciones de coeficientes de perfiles __________

Cl = hAnaAdim.p.Cl.Fun3D;

if Op_Cd == 1
    Cd = @(alf,rR) 0;
else
    Cd = hAnaAdim.p.Cd.Fun3D;
end

%Cd a alfa = 0
Cd0 = Cd(zeros(1,1,rRl), rR);


%_____________Definición de funciones según opciones___________

%  Pérdidas por cantidad finita de álabes

switch Op_F
    case 1
        F = @(fi, J) ones( 1, 1 , rRl );
    case 2
        F = @(fi, J) 2/pi * acos( exp( (-Z/2) * (1 - rR) ./ (rR .* sin(fi) ) ) );
    case 3
        F = @(fi, J) 2/pi * acos( exp( (-Z/2) * (1 - rR) .* sqrt( 1 + J^2 ) ) );
end

F1 = @(fi, J) ones( 1, 1 , rRl ) ;


%  Coeficientes con efecto post-stall

%Función de decaimiento de post-stall

Stp = @(x) (x > -90) .* (x < -30) .*( ( 1/(-30+90))*(x + 90) + 0) + (x >= -30).*(x <= 30) +...
           (x >  30) .* (x  < 90) .*( (-1/( 90-30))*(x - 30) + 1);

DCl = @(alf) ( 2*pi* (alf - alf0)/180*pi - Cl(alf, rR) ) .* Stp(alf);

DCd = @(alf) ( Cd(alf,rR) - Cd0 ) .* Stp(alf);

switch Op_Stall
    case 1
        
        Cl3D = @(alf, J) Cl(alf, rR);
        Cd3D = @(alf, J) Cd(alf, rR);
        
    case 2
        
        DgCl = 3 * (cR ./ rR) .^2;
        
        Cl3D = @(alf, J) Cl(alf,rR) + DgCl .* DCl(alf);
        
        Cd3D = @(alf, J) Cd(alf,rR);
        
    case 3
        
        Dg = 2.2 * (cR ./ rR) .* cos(th) .^4;
        
        Cl3D = @(alf, J) Cl(alf,rR) + Dg .* DCl(alf);
        
        Cd3D = @(alf, J) Cd(alf,rR) + Dg .* DCd(alf);
        
    case 4
        % 1/L  = L1
        L1 = @(J) sqrt(1 / J .^2  + 1);
        
        DgCl = @(J) 1/(2*pi) * ( (1.6 * cR ./ rR - (cR ./ rR) .^ (L1(J) ./ rR)) ./...
            (.1267 + (cR ./ rR) .^ (L1(J) ./ rR)) - 1);
        
        DgCd = @(J) 1/(2*pi) * ( (1.6 * cR ./ rR - (cR ./ rR) .^ (L1(J) ./ (2*rR) )) ./...
            (.1267 + (cR ./ rR) .^ (L1(J) ./ rR)) - 1);
        
        Cl3D = @(alf, J) Cl(alf,rR) + DgCl(J) .* DCl(alf);
        
        Cd3D = @(alf, J) Cd(alf,rR) - DgCd(J) .* DCd(alf);
        
end



%  Funciones de coeficientes de empuje
% d, dominio
% _m dominio a <= ac
% _M dominio a >  ac

        
switch Op_Cx
    case 1
        
        ac = 1/3;
        
        CxF = @(a, F) 4 * a .* (1 - 1/4 * (5 - 3*a) .* a) .* F;
        
        Cxm = CxF;
        CxM = CxF;
        
        Cy = @(a, ap, Ji, F) 4 * ap .* (1 - a) .* F .* rR*Ji;
        
    case 2
        ac = 0.2;
        
        Cxm = @(a, F) 4 * a .* (1 - a) .* F;

        CxM = @(a, F) 4 * ( ac^2 + (1 - 2*ac) * a) .* F;
           
        Cy = @(a, ap, Ji, F) 4 * ap .* (1 - a) .* F .* rR*Ji;
        
    case 3
        ac = 1/3;
        
        Cxm = @(a, F) 4 * a .* ( 1 - a .* F ) .* F;

        CxM = @(a, F) 4 * ( ac^2 .* F + (1 - 2*ac .* F ) .* a) .* F;
        
        F1 = @(fi, J) 2/pi * acos( exp( (-Z/2) .*...
        (exp( -0.125 * ( Z * J - 21 ) ) + 0.1) .*...
        (1 - rR) ./ (rR .* sin(fi) ) ) )  ;
    
        Cy = @(a, ap, Ji, F) 4 * ap .* (1 - a .* F) .* F .* rR*Ji ;

        
end


%_______Cálculo prestaciones del áero / Método de Newton Raphson_________



function fsR = fs(a0, ap0, Ji)

%Funcion de funciones a resolver

    % Prelocación de Cx y fs

    Cx0 = zeros(1,1,rRl);

    fsR = zeros (2,1,rRl);
    
    
    %Calculo del angulo de flujo
    fi0 =  atan2( (1 - a0) , ( (1 + ap0) .* rR*Ji ) ) ;
    %fi0 =  atan2( (1 - a0) , ( (1) .* rR*Ji ) ) ;
        
    %correccion
    fi0( fi0<0 ) = -fi0( fi0<0 )/2; 
    

    % Calculo de las F
    F0 =  F (fi0 , Ji);
    F10 = F1(fi0 , Ji);

    %Calculo de alfa

    alf = fi0 - th;

    %Calculo de Coeficientes de perfiles con efecto 3D

    Cl3D0 = Cl3D(alf /pi *180, Ji);
    Cd3D0 = Cd3D(alf /pi *180, Ji);

    Cn3D0 = Cl3D0 .* cos(fi0) + Cd3D0 .* sin(fi0);
    Ct3D0 = Cl3D0 .* sin(fi0) - Cd3D0 .* cos(fi0);

    % Evaluación de Cx de balance de momento axial
    %para a0 <= ac
    d = a0 <= ac;

    Cx0(d) = Cxm(a0(d), F0(d));

    %para a0 > ac
    d = a0 > ac;

    Cx0(d) = CxM(a0(d), F0(d));
    

    % Evaluación de Cy de balance de momento angular
    Cy0 = Cy(a0, ap0, Ji, F0);
    
        
    % Calculo de las funciones a resolver

    fsR(1, 1, :) =  (1 - a0).^2 ./ sin(fi0).^2 .* s .* Cn3D0 .* F10 -  Cx0  ;
    fsR(2, 1, :) =  (1 - a0).^2 ./ sin(fi0).^2 .* s .* Ct3D0 .* F10 -  Cy0  ;
end




% inicialización de matrices de almacenaje

%Configuración de la barra de espera
hwb = waitbar(0,'Inicializando', 'name', 'Analizando adimensionalmente la pala'...
    ,'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(hwb,'canceling',0);
Cancel = 0;

% Variables de almacenado de resultados
zr   = zeros(Jl,rRl);
aR   = zr;
apR  = zr;
fiR  = zr;
alfR = zr;
ClR  = zr;
CdR  = zr;
CxR  = zr;
CyR  = zr;


%tolerancia absoluta
tol = 0.001;

%paso de derivada por perturbación
h = 10^-10;

    
%Semillas
% x = [aS ; apS]
xS = ones(2, 1, rRl);
xS(1, 1, :) = zeros(1, 1, rRl);
xS(2, 1, :) = zeros(1, 1, rRl) ;

%Numero máximo de iteraciones
nmax = 40;

%Derivada parcial por perturbación centrada
dfs = @(a0, ap0, Ji, hv, h) (fs(a0 + hv(1), ap0 + hv(2), Ji) - ...
    fs(a0 - hv(1), ap0 - hv(2), Ji)) / (2*h);

% %Factor de relajación
% w = 0.8;

% Parametro para seguimiento de % completado en barra de espera
Jmax = J(Jl);

for i = 1:Jl
    
    Ji = J(i);
    n = 0;
    S = 1;
   
    while S > 0
        
        %Actualización de la iteración anterior
        x0 = xS;
        
        %Por facilidad de lectura, almacenado de variables a resolver
        
        a0 =  x0(1,1,:);
        ap0 = x0(2,1,:);

        % f(x0)
        fs0 = fs(a0, ap0, Ji);
        
        % Derivadas parciales con respecto a a0
        hv = [h 0];
        f1 = dfs(a0, ap0, Ji, hv, h);
        
        % Derivadas parciales con respecto a ap0
        hv = [0 h];
        f2 = dfs(a0, ap0, Ji, hv, h);
        
        %Jacobiano
        Jacob = [f1 f2];

        %Jacobiano^-1 * f(x0)
        xc = cell2mat(arrayfun( @(j) Jacob(:, :, j) \ fs0(:, :, j)  , reshape( 1:rRl, [1,1,rRl]) ,'UniformOutput',0 ));
        
        %Aplicación del método de Newton - Raphson
        xS = x0 - xc;
         
%         xS = fs0;                   %Método del punto fijo
%          
%         xS = xS * w + x0 * (1 - w); %Relajación del método

        %Correccion : corregir valores NAN, limitar 'a' y 'ap' 
        %dentro de valores físicamente posibles; reubicación en la media de
        %todos los puntos
        mna  = mean( xS( 1, ~isnan(xS(1,1,:)) ) );
        mnap = mean( xS( 2, ~isnan(xS(2,1,:)) ) );
        
        zr = zeros(1,1,rRl); 
        xS(1,1, isnan(xS(1,1,:)) ) = zr( isnan(xS(1,1,:)) ) + mna;
        xS(1,1,xS(1,1,:) >= 1) = zr(xS(1,1,:) >= 1)   + mna;
        xS(1,1,xS(1,1,:) <= -1) = zr(xS(1,1,:) <= -1) + mna; 

        xS(2,1, isnan(xS(2,1,:)) ) = zr(isnan(xS(2,1,:)))           + mnap ;
        xS(2,1,xS(2,1,:) <= -1) = zr(xS(2,1,:) <= -1) + mnap ;

        
        %Cantidad de puntos a y ap sin converger
        
        S = sum( abs( xS(:) - x0(:) ) > tol );
        
        % aumento de contador de iteración
        n = n + 1;  
        
        
        %Verificación de exceso de iteraciones
        if n > nmax
            break
        end
       
        %Ventana modo Debug
        if Op_Debug
            Cancel = AnaAdimDebug(Jmax,Ji,S,n,nmax,tol,x0,xS,fi0,th,Cl3D0,Cd3D0,Cn3D0,Ct3D0,rR);
        end
        
        % Check for Cancel button press in waitbar
        if getappdata(hwb,'canceling')
            Cancel = 1;
        end
        
        if Cancel
            break
        end
        
    end
    
     if Cancel
         break
     end
    
    %Almacenado de variables para graficación
    aR(i,:)   = xS(1, :) ;
    apR(i,:)  = xS(2, :) ;
    fiR(i,:)  = fi0(1,:)/pi*180 ;
    alfR(i,:) = alf(1,:)/pi*180;
    ClR(i,:)  = Cl3D0(1,:);
    CdR(i,:)  = Cd3D0(1,:);
    CxR(i,:)  = Cx0(1,:);
    CyR(i,:)  = Cy0(1,:);
    
    %Actualización de barra de espera
    waitbar(Ji/Jmax, hwb, strcat( 'Velocidad específica = ' , num2str(Ji) ) );
end


waitbar( 1, hwb, 'Completado' );

delete(hwb);

%______________Fin de cálculo de prestaciones de áero______________


%________Creación de funciones de interpolación para graficación_____

handles.aR.Fun3D = griddedInterpolant( { rR(1,:), J }, aR.', 'spline', 'linear') ;
handles.aR.title = 'Factor de inducción axial';
handles.aR.tag = 'a';

handles.apR.Fun3D = griddedInterpolant( { rR(1,:), J }, apR.', 'spline', 'linear') ;
handles.apR.title = 'Factor de inducción tangencial';
handles.apR.tag = 'a''';

handles.fiR.Fun3D = griddedInterpolant( { rR(1,:), J }, fiR.', 'spline', 'linear') ;
handles.fiR.title = 'Ángulo de flujo';
handles.fiR.tag = '\phi (°)';

handles.alfR.Fun3D = griddedInterpolant( { rR(1,:), J }, alfR.', 'spline', 'linear') ;
handles.alfR.title = 'Ángulo de ataque';
handles.alfR.tag = '\alpha (°)';

handles.ClR.Fun3D = griddedInterpolant( { rR(1,:), J }, ClR.', 'spline', 'linear') ;
handles.ClR.title = 'Coeficiente de sustentación';
handles.ClR.tag = 'Cl';

handles.CdR.Fun3D = griddedInterpolant( { rR(1,:), J }, CdR.', 'spline', 'linear') ;
handles.CdR.title = 'Coeficiente de arrastre';
handles.CdR.tag = 'Cd';

handles.CxR.Fun3D = griddedInterpolant( { rR(1,:), J }, CxR.', 'spline', 'linear') ;
handles.CxR.title = 'Coeficiente de fuerza axial';
handles.CxR.tag = 'Cx';

handles.CyR.Fun3D = griddedInterpolant( { rR(1,:), J }, CyR.', 'spline', 'linear') ;
handles.CyR.title = 'Coeficiente de fuerza tangencial';
handles.CyR.tag = 'Cy';

if Op_Cp == 2
    Mix = @(rR,J) ( 1 - ( handles.CdR.Fun3D( {rR,J} ) ./ handles.ClR.Fun3D( {rR,J} ) )...
        .*cot( handles.fiR.Fun3D( {rR,J} )/180*pi ) );
else
    Mix = @(rR,J) ones( length(rR) , length(J) );
end

dCpdrRR = 2 * repmat(J,rRl,1) .* handles.CyR.Fun3D( {rR(1,:), J} ) .* repmat(rR(1,:),Jl,1).' .^2 .* Mix(rR(1,:),J);

handles.dCpdrR.Fun3D = griddedInterpolant({ rR(1,:), J }, dCpdrRR, 'spline', 'linear' );

handles.dCpdrR.title = 'Aportes locales al coeficiente de potencia';
handles.dCpdrR.tag = 'dCp/d(r/R)';

handles.Fun = {handles.dCpdrR, handles.aR, handles.apR, handles.fiR,...
    handles.alfR, handles.ClR, handles.CdR, handles.CxR, handles.CyR};

%____________________Integración numérica de Cp______________________
Jmin = min(J);
Jint = linspace(Jmin,Jmax,200);
rRint = linspace(min(rR),1);

Cp = trapz(rRint, handles.dCpdrR.Fun3D( {rRint, Jint} ) );

X = horzcat( Jint( Cp>0 ), [100, 101, 102, 103] ); 
Y = horzcat( Cp( Cp>0 ), [0, 0, 0, 0]);

handles.Cp = griddedInterpolant(X, Y,'pchip');


%_____________________________Graficación____________________________

set(handles.Sli_Lambda, 'Min', Jmin, 'Max', Jmax);
set(handles.Sli_Lambda, 'value', Jmin);

handles.rRdom = rRint;
handles.Jdom = Jint;
handles.J = Jmin;

% Función de graficación genérica
handles.Graf = @(rR,J,Fun) plot(handles.Axe_dCp, rR, Fun({rR, J}).');

% Dominios de graficación
handles.J = get(handles.Sli_Lambda, 'value');
handles.val =  get(handles.Pop_Res,'value');
J = handles.J;
val = handles.val;

rR = handles.rRdom;
Jdom = handles.Jdom;
Jmax = max(Jdom);
Jmin = min(Jdom);


% Algoritmo de graficación para funciones resultado
handles.Graf(rR, handles.J, handles.Fun{val}.Fun3D )
title(handles.Axe_dCp, handles.Fun{val}.title)
ylabel(handles.Axe_dCp, handles.Fun{val}.tag)
xlabel(handles.Axe_dCp, 'r/R')

% Graficación de Cp

h = plot(handles.Axe_Cp, Jdom, handles.Cp(Jdom), [J J], [-0.6 0.6] );
set(h(2), 'linewidth',3)
title(handles.Axe_Cp, 'Coeficiente de potencia vs velocidades específicas')
ylabel(handles.Axe_Cp, 'Cp')
xlabel(handles.Axe_Cp, 'Velocidade específica de punta de pala')
axis(handles.Axe_Cp,[Jmin Jmax -0.2 0.6])

set(handles.Text_J, 'string' , sprintf('Velocidad específica = %0.3f',handles.J) );


% Busqueda de condiciones nominales

fun = @(x) -handles.Cp(x)./x.^3;

Jn = fminbnd( fun  , 1 , Jmax);

handles.Jn = Jn;


%Inicialización de texto de condiciones nominales

set(handles.Edit_Jn,'string',handles.Jn);
set(handles.Text_Cpn, 'string' , sprintf(...
    'Velocidad específica nominal:                         =>    Cp_n:  %0.2f', handles.Cp(handles.Jn)) )


% Configuración de menu contextual
c = uicontextmenu;
set(handles.Axe_Cp, 'UIContextMenu', c);

uimenu(c,'label','Importar data experimental','callback',{@Importa_Data,handles} ) 
uimenu(c,'label','Exportar','callback',{@Exportar,handles.Axe_Cp});

c2 = uicontextmenu;
set(handles.Axe_dCp, 'UIContextMenu', c2);

uimenu(c2,'label','Exportar','callback',{@Exportar,handles.Axe_dCp});


%Inicializar data importada
handles.Data = NaN;


% Choose default command line output for AnaAdimR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnaAdimR wait for user response (see UIRESUME)
% uiwait(handles.Fig_AnaAdimR);

if Cancel
    close(handles.Fig_AnaAdimR)
end

end

% --- Outputs from this function are returned to the command line.
function varargout = AnaAdimR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;

end

% --- Executes on slider movement.
function Sli_Lambda_Callback(hObject, eventdata, handles)
% hObject    handle to Sli_Lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.J = get(handles.Sli_Lambda, 'value');
J = handles.J;
val = handles.val;

rR = handles.rRdom;
Jdom = handles.Jdom;
Jmax = max(Jdom);
Jmin = min(Jdom);

%Algoritmo de graficación para funciones resultado
handles.Graf(rR, handles.J, handles.Fun{val}.Fun3D )
title(handles.Axe_dCp, handles.Fun{val}.title)
ylabel(handles.Axe_dCp, handles.Fun{val}.tag)
xlabel(handles.Axe_dCp, 'r/R')

%Graficación de Cp

h = plot(handles.Axe_Cp, Jdom, handles.Cp(Jdom), [J J], [-0.6 0.6] );
set(h(2), 'linewidth',3)
title(handles.Axe_Cp, 'Coeficiente de potencia vs velocidades específicas')
ylabel(handles.Axe_Cp, 'Cp')
xlabel(handles.Axe_Cp, 'Velocidade específica de punta de pala')
axis(handles.Axe_Cp,[Jmin Jmax -0.2 0.6])

set(handles.Text_J, 'string' , sprintf('Velocidad específica = %0.3f',handles.J) );

%Graficación de la data

if ~isnan(handles.Data)
    
    x = handles.Data(:,1);
    y = handles.Data(:,2);
    hold(handles.Axe_Cp,'on')
    plot(handles.Axe_Cp, x, y,'.','tag','Plot_Data')
    legend(findall(handles.Fig_AnaAdimR,'tag','Plot_Data'),'Data importada','location','northeast')
    hold(handles.Axe_Cp,'off')
    
end

guidata(hObject,handles)


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end

% --- Executes during object creation, after setting all properties.
function Sli_Lambda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sli_Lambda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

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
handlesPrin.Cp{1,1} = handles.Cp;
handlesPrin.Cp{2,1} = [handles.Jn handles.Cp(handles.Jn)];


% Activar resultados generados
set(handlesPrin.RadBtn_CpA,'value',1)
set(handlesPrin.Btn_Cp,'enable','off')

%Seleccionar funciones generadas
handlesPrin.Cp{1,3} = handlesPrin.Cp{1,1};
handlesPrin.Cp{2,3} = handlesPrin.Cp{2,1};

%Informar que las funciones fueron generadas
set(handlesPrin.Text_CpA,'string','Cp -OK-');
set(handlesPrin.Text_Cond_nA,'string','Cond_n -OK-');

%Verificar activación de botones
CheckFun(handlesPrin,handlesPrin.Btn_DisDim);
CheckFun(handlesPrin,handlesPrin.Btn_AnaDim);
CheckFun(handlesPrin,handlesPrin.Btn_Opt);

guidata(hPrin,handlesPrin)


%Recuperar referencia a ventana de opciones
hAnaAdim = findall(0,'tag','Fig_AnaAdim');
% 
% %Cerrar ventanas
close(hAnaAdim)
close(gcf)


end




        


% --- Executes on selection change in Pop_Res.
function Pop_Res_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.Pop_Res,'value');

handles.val = val;
rR = handles.rRdom;

%Algoritmo de graficación para funciones resultado
handles.Graf(rR, handles.J, handles.Fun{val}.Fun3D )
title(handles.Axe_dCp, handles.Fun{val}.title)
ylabel(handles.Axe_dCp, handles.Fun{val}.tag)
xlabel(handles.Axe_dCp, 'r/R')

guidata(hObject,handles)

% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Res contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Res
end

% --- Executes during object creation, after setting all properties.
function Pop_Res_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end






function Edit_Jn_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Jn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Jn = str2double(get(handles.Edit_Jn,'string'));
set(handles.Text_Cpn, 'string' , sprintf(...
    'Velocidad específica nominal:                         =>    Cp_n:  %0.2f', handles.Cp(handles.Jn)) )

guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of Edit_Jn as text
%        str2double(get(hObject,'String')) returns contents of Edit_Jn as a double
end

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

end

function Importa_Data(hObject, eventdata, handles) 

[fileName,pathName]=uigetfile({'*.xlsx';'*.xls'},'Seleccione matriz de datos a cargar');

dirData = [pathName fileName];

%Si se ha seleccionado efectivamente un fichero:
if ischar(dirData)
    
    Data = readtable(dirData,'readvariablename',0);
    
    handles.Data = [Data{2:end,1} , Data{2:end,2}];
    
    x = handles.Data(:,1);
    y = handles.Data(:,2);
    hold(handles.Axe_Cp,'on')
    plot(handles.Axe_Cp, x, y,'.','tag','Plot_Data')
    legend(findall(handles.Fig_AnaAdimR,'tag','Plot_Data'),'Data importada','location','northeast')
    hold(handles.Axe_Cp,'off')
    
    guidata(hObject,handles);

end

end
