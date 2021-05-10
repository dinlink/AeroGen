function varargout = ExtendAct(varargin)
% EXTENDACT MATLAB code for ExtendAct.fig
%      EXTENDACT, by itself, creates a new EXTENDACT or raises the existing
%      singleton*.
%
%      H = EXTENDACT returns the handle to a new EXTENDACT or the handle to
%      the existing singleton*.
%
%      EXTENDACT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTENDACT.M with the given input arguments.
%
%      EXTENDACT('Property','Value',...) creates a new EXTENDACT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ExtendAct_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ExtendAct_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ExtendAct

% Last Modified by GUIDE v2.5 13-Mar-2016 17:26:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ExtendAct_OpeningFcn, ...
                   'gui_OutputFcn',  @ExtendAct_OutputFcn, ...
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


% --- Executes just before ExtendAct is made visible.
function ExtendAct_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ExtendAct (see VARARGIN)

% Choose default command line output for ExtendAct
handles.output = hObject;

%Mover ventana al centro
movegui(hObject,'center');

%- Hacer la ventana modal -
%set(gcf,'windowstyle','modal')

%Recuperar de la figura 'PerfilesCargar' la información de los perfiles
hPerfilesC = guidata( findall(0,'tag','Fig_PerfilesCargar') );
handles.perfiles = hPerfilesC.perfiles;

%Número de perfil
handles.tam = length(handles.perfiles);
temp = cell(1,handles.tam);

for i = 1:handles.tam
 temp(i) = {num2str(i)};
 
end


%Escritura de número de perfiles
set(handles.Pop_Perf,'string',temp);


% Botones para mover y hacer zoom
hf = handles.Fig_ExtendAct;
set(hf, 'toolbar', 'figure')

% Ocultar botones sobrantes
hsp = findall(hf, 'ToolTipString','Show Plot Tools');
hhp = findall(hf, 'ToolTipString','Hide Plot Tools');
hpf = findall(hf, 'ToolTipString','Print Figure');
hsf = findall(hf, 'ToolTipString','Save Figure');
hof = findall(hf, 'ToolTipString','Open File');
hnf = findall(hf, 'ToolTipString','New Figure');
hil = findall(hf, 'ToolTipString','Insert Legend');
hic = findall(hf, 'ToolTipString','Insert Colorbar');
hr3d = findall(hf, 'ToolTipString','Rotate 3D');
hep = findall(hf, 'ToolTipString','Edit Plot');
hlp = findall(hf, 'ToolTipString','Link Plot');
hdf = findall(hf, 'ToolTipString','Show Plot Tools and Dock Figure');

hs = [hsp, hhp, hpf, hsf, hof, hnf, hil, hic, hr3d, hep, hlp, hdf];

set(hs, 'visible', 'off')
set(hs, 'separator', 'off')

%Graficar por primera vez
handles = Ajustar( get( handles.Pop_Ext, 'value'), handles );
graficar(handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ExtendAct wait for user response (see UIRESUME)
% uiwait(handles.Fig_ExtendAct);



% --- Outputs from this function are returned to the command line.
function varargout = ExtendAct_OutputFcn(hObject, eventdata, handles) 
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

graficar(handles)

guidata(hObject, handles)

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


% --- Executes on selection change in Pop_Perf.
function Pop_Perf_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Perf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

graficar(handles)

guidata(hObject, handles)

% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Perf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Perf


% --- Executes during object creation, after setting all properties.
function Pop_Perf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Perf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Pop_Ext.
function Pop_Ext_Callback(hObject, eventdata, handles)
% hObject    handle to Pop_Ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.Pop_Ext, 'value') == 1
    set(handles.Text_Manual,'visible','off')
    set(handles.Edit_Manual,'visible','off')
else
    set(handles.Text_Manual,'visible','on')
    set(handles.Edit_Manual,'visible','on')
end
% Hints: contents = cellstr(get(hObject,'String')) returns Pop_Ext contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Pop_Ext


% --- Executes during object creation, after setting all properties.
function Pop_Ext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edit_Manual_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Manual as text
%        str2double(get(hObject,'String')) returns contents of Edit_Manual as a double


% --- Executes during object creation, after setting all properties.
function Edit_Manual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_Continuar.
function Btn_Continuar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Continuar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Recuperar la estructura de la figura PerfilesCargar
hPC = findall(0,'tag','Fig_PerfilesCargar');
handlesPCargar = guidata(hPC);

%Guardar funciones de perfiles generadas
[ handlesPCargar.perfiles.alfa ] = handles.perfilesN.alfa;
[ handlesPCargar.perfiles.Cl ] = handles.perfilesN.Cl;
[ handlesPCargar.perfiles.Cd ] = handles.perfilesN.Cd;

guidata(hPC,handlesPCargar)


set(handlesPCargar.Btn_Continuar, 'enable', 'on')

close(handles.Fig_ExtendAct)


% Aplica el ajuste de extensión a los coeficientes
function handles = Ajustar(Ajuste, handles)

for i = 1:handles.tam
    
    
    if or( handles.perfiles(i).alfa < 50, handles.perfiles(i).alfa > -50)
        
        %________Inicialización de funciones y variables
        Clalfa = interp1( handles.perfiles(i).alfa(1:end-1), ...
            diff(handles.perfiles(i).Cl)./diff(handles.perfiles(i).alfa), 0,'pchip' );
        
        Cl0 = interp1( handles.perfiles(i).alfa,...
            handles.perfiles(i).Cl, 0, 'pchip');
        
        Cd90 = 1.25;
        
        %Funcion de sustentación de flujo potencial
        t = @(a) Clalfa * a + Cl0;
        
        alfa0 = fzero( ...
            @ (a) interp1( handles.perfiles(i).alfa, handles.perfiles(i).Cl, a, 'pchip')...
            , 0);
        
        %Funcion de sustentación de placa delgada
        s = @(a) (1 + Cl0/sin(pi/4) * sin(a * pi/180) ) .* ...
            Cd90 .* ...
            sin( (a - 57.6*0.08*sin(a*pi/180) - alfa0*cos(a*pi/180) )*pi/180 ) .* ...
            cos( (a - 57.6*0.08*sin(a*pi/180) - alfa0*cos(a*pi/180) )*pi/180 );
        
        %Función de arrastre placa delgada
        Cdthin = @(a) Cd90 * sin(a/180*pi).^2;
        
        %Arrastre por fricción viscosa
        Cf = interp1(handles.perfiles(i).alfa, handles.perfiles(i).Cd, 0, 'pchip');
        
        
        %Dominio lado positivo
        domp = handles.perfiles(i).alfa >= 0;
        alfap = linspace(0,90,500).';
        
        if handles.perfiles(i).alfa < 50
            
            
            %Ajuste de Montgomerie: Ajuste == 1
            if Ajuste == 1
                
                %verificación de pendiente negativa (máximo)
                if sum( diff(handles.perfiles(i).Cl(domp) )<0 )>0
                    
                    fun = @(a) interp1(handles.perfiles(i).alfa(domp)...
                        , - handles.perfiles(i).Cl(domp), a, 'pchip');
                    
                    %puntos para interpolación de Montgomerie
                    alfamaxp = fminbnd( fun, 0 ...
                        , handles.perfiles(i).alfa(end) );
                    Clmaxp = interp1( handles.perfiles(i).alfa, handles.perfiles(i).Cl,alfamaxp, 'pchip' );
                    
                else
                    
                    Clmaxp = handles.perfiles(i).Cl(end);
                    alfamaxp = (Clmaxp - Cl0) ./ Clalfa + 3;
                    
                end
                
                alfa2p = alfamaxp + 15;
                Cl2p = s(alfa2p) + 0.03;
                
                f1p = (Clmaxp - s(alfamaxp) )./(t(alfamaxp) - s(alfamaxp));
                f2p = (Cl2p - s(alfa2p) )./(t(alfa2p) - s(alfa2p));
                
                
                Gp = ( abs( (1./f1p -1)./(1./f2p -1) ) ).^0.25;
                
                alfaMp = (alfamaxp - Gp.*alfa2p) ./ (1 - Gp);
                
                kp = (1./f2p -1)./( alfa2p - alfaMp).^4;
                
                fp = @(a) 1./ (1 + kp .* ( alfaMp - a).^4);
                
                % Coeficientes extendidos
                Clp = t(alfap).*(alfap < alfaMp) + ...
                    (fp(alfap).*t(alfap) + (1 - fp(alfap)).*s(alfap)).*(alfap >= alfaMp);
                
                Cdep = @(a) Cf + 0.13 * ( t(a) - interp1(alfap,Clp,a,'pchip') );
                
                Cdp = Cf.*(alfap < alfaMp) + ...
                    (fp(alfap).*Cdep(alfap) + (1 - fp(alfap)).*Cdthin(alfap)).*(alfap >= alfaMp);
                
            elseif Ajuste == 2
                
                %Punto de desprendimient completo
                alfaStall = max( [ str2double(get(handles.Edit_Manual,'string')), ...
                    handles.perfiles(i).alfa(end) + 4 ] );
                
                %Función de mezclado (blending)
                alfaAux = handles.perfiles(i).alfa(domp);
                ClAux = handles.perfiles(i).Cl(domp);
                CdAux = handles.perfiles(i).Cd(domp);
                sAux = s(alfaAux);
                tAux = t(alfaAux);
                CdthinAux = (Cdthin(alfaAux));
                
                X = vertcat( alfaAux, alfaStall + [0; 1; 2; 3]);
                YCl = vertcat( (ClAux - sAux)./(tAux - sAux), [0;0;0;0]);
                YCd = vertcat( (CdAux - CdthinAux)./(Cf - CdthinAux), [0;0;0;0]);
                
                fClp = @(a) interp1( X,YCl, a, 'pchip');
                fCdp = @(a) interp1( X,YCd, a, 'pchip');
                
                %Coeficientes extendidos
                Clp = fClp(alfap) .* t(alfap) + (1 - fClp(alfap)) .* s(alfap);
                Cdp = fCdp(alfap) .*Cf + (1 - fCdp(alfap)) .* Cdthin(alfap);
                
            else
                %Punto de unión con la función de stall
                alfaStall = max( [ str2double(get(handles.Edit_Manual,'string')), ...
                    handles.perfiles(i).alfa(end) + 4 ] );
                
                %Dominio donde el perfil se encuentra completamente en
                %stall
                stallDom = linspace(alfaStall,90);
                
                %interpolacion cubica suavizada
                X = vertcat( handles.perfiles(i).alfa(domp), ...
                    stallDom.');
                YCl = vertcat( handles.perfiles(i).Cl(domp), ...
                    s(stallDom.'));
                YCd = vertcat( handles.perfiles(i).Cd(domp), ...
                    Cdthin(stallDom.'));
               
                Clp = csaps(X,YCl, 1 - 0.4, alfap);
                Cdp = csaps(X,YCd, 1 - 0.4, alfap);
                            
            end
        else
            alfap = handles.perfiles(i).alfa(domp);
            Clp = handles.perfiles(i).Cl(domp);
            Cdp = handles.perfiles(i).Cd(domp);
        end
        
        
        %Interpolación lado negativo
        domn = not(domp);
        alfan = linspace(-90,-0.001,500).';
        
        if handles.perfiles(i).alfa > -50
            
            if Ajuste == 1
                
                %verificación de pendiente negativa (mínimo)
                if sum( diff(handles.perfiles(i).Cl(domn) )<0 )>0
                    
                    fun = @(a) interp1(handles.perfiles(i).alfa(domn)...
                        , handles.perfiles(i).Cl(domn), a, 'pchip');
                    
                    %puntos para interpolación de Montgomerie
                    alfamin = fminbnd( fun, handles.perfiles(i).alfa(1) ...
                        , -0.001  );
                    Clmin = interp1( handles.perfiles(i).alfa, handles.perfiles(i).Cl,alfamin, 'pchip' );
                    
                else
                    
                    %Reconstrucción de Clmin a partir de Clmax
                    fun = @(a) interp1(alfap, - Clp, a, 'pchip');

                    alfamax = fminbnd( fun, 0, 90 );
                    Clmax = interp1( alfap , Clp ,alfamax , 'pchip' );
                    
                    Clmin = -(Clmax - Cl0);
                    alfamin = -Clmax ./ Clalfa - 3;
                    
                end
                
                alfa2n = alfamin - 15;
                Cl2n = s(alfa2n) - 0.03;
                
                f1n = (Clmin - s(alfamin) )./(t(alfamin) - s(alfamin));
                f2n = (Cl2n - s(alfa2n) )./(t(alfa2n) - s(alfa2n));
                
                
                Gn = ( abs( (1./f1n -1)./(1./f2n -1) ) ).^0.25;
                
                alfaMn = (alfamin - Gn.*alfa2n) ./ (1 - Gn);
                
                kn = (1./f2n -1)./( alfa2n - alfaMn).^4;
                
                fn = @(a) 1./ (1 + kn .* ( alfaMn - a).^4);
                
                % Coeficientes extendidos
                Cln = t(alfan).*(alfan > alfaMn) + ...
                    (fn(alfan).*t(alfan) + (1 - fn(alfan)).*s(alfan)).*(alfan <= alfaMn);
                
                Cden = @(a) Cf + 0.13 * ( t(a) - interp1(alfan,Cln,a,'pchip') );
                
                Cdn = Cf.*(alfan > alfaMn) + ...
                    (fn(alfan).*Cden(alfan) + (1 - fn(alfan)).*Cdthin(alfan)).*(alfan <= alfaMn);
                
              
                
            elseif Ajuste == 2
                
                %Punto de desprendimient completo
                alfaStall = min( [ - str2double(get(handles.Edit_Manual,'string')), ...
                    handles.perfiles(i).alfa(1) - 4 ] );
                
                %Función de mezclado (blending)
                alfaAux = handles.perfiles(i).alfa(domn);
                ClAux = handles.perfiles(i).Cl(domn);
                CdAux = handles.perfiles(i).Cd(domn);
                sAux = s(alfaAux);
                tAux = t(alfaAux);
                CdthinAux = (Cdthin(alfaAux));
                
                X = vertcat( alfaAux, alfaStall - [0; 1; 2; 3]);
                YCl = vertcat( (ClAux - sAux)./(tAux - sAux), [0;0;0;0]);
                YCd = vertcat( (CdAux - CdthinAux)./(Cf - CdthinAux), [0;0;0;0]);
                
                fCln = @(a) interp1( X,YCl, a, 'pchip');
                fCdn = @(a) interp1( X,YCd, a, 'pchip');
                
                %Coeficientes extendidos
                Cln = fCln(alfan) .* t(alfan) + (1 - fCln(alfan)) .* s(alfan);
                Cdn = fCdn(alfan) .*Cf + (1 - fCdn(alfan)) .* Cdthin(alfan);
                
                    
            else
                %Punto de unión con la función de stall
                alfaStall = min( [ - str2double(get(handles.Edit_Manual,'string')), ...
                    handles.perfiles(i).alfa(1) - 4 ] );
                
                %Dominio donde el perfil se encuentra completamente en
                %stall
                stallDom = linspace(alfaStall,-90);
                
                %interpolacion cubica suavizada
                X = vertcat( handles.perfiles(i).alfa(domn), ...
                    stallDom.');
                YCl = vertcat( handles.perfiles(i).Cl(domn), ...
                    s(stallDom.'));
                YCd = vertcat( handles.perfiles(i).Cd(domn), ...
                    Cdthin(stallDom.'));
               
                Cln = csaps(X,YCl, 1 - 0.4, alfan);
                Cdn = csaps(X,YCd, 1 - 0.4, alfan);
                            
            end
            
            
        else
            alfan = handles.perfiles(i).alfa(domn);
            Cln = handles.perfiles(i).Cl(domn);
            Cdn = handles.perfiles(i).Cd(domn);
        end
        
        %Concatenación de alfa y Cls
        handles.perfilesN(i).alfa = vertcat(alfan,alfap);
        handles.perfilesN(i).Cl = vertcat(Cln,Clp);
        handles.perfilesN(i).Cd = vertcat(Cdn,Cdp);
        

    else
        
        %Interpolación innecesaria
        handles.perfilesN(i) = handles.perfiles(i);
        
    end
    
    
end


% --- Executes on button press in Btn_Aplicar.
function Btn_Aplicar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Aplicar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = Ajustar( get( handles.Pop_Ext, 'value'), handles );

graficar(handles)

guidata(hObject, handles)


%Grafica los perfiles extendidos
function graficar(handles)

hAxe = handles.Axe_Extend;
perf = get(handles.Pop_Perf, 'value');
Coef = get(handles.Pop_Coef, 'value');

%Funciones extendidas o 'Nuevas'
grafsN = {handles.perfilesN(perf).Cl,handles.perfilesN(perf).Cd};
XN = handles.perfilesN(perf).alfa;
YN = grafsN{Coef};

%Funciones Originales
grafsO = {handles.perfiles(perf).Cl,handles.perfiles(perf).Cd};
XO = handles.perfiles(perf).alfa;
YO = grafsO{Coef};

plot(hAxe,XN,YN, XO,YO, '.')
xlabel(hAxe, 'Ángulo de ataque (°)')
legend(hAxe, 'Extendido', 'Original', 'Location', 'Best')
