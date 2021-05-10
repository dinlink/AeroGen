function filltbl(eventdata, handles, val)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%___________rellenar tabla forma________

%tamaño de fila
tmfe = length(handles.perfiles(val).xe);
tmfi = length(handles.perfiles(val).xi);

%Prelocación de Matriz de data
tempM( 1 : tmfe+tmfi+3 , 1:2) = NaN;

%Rellenado en formato Lednicer
tempM(1,1) = tmfe;
tempM(1,2) = tmfi;

tempM( 3 : 2+tmfe ,1 ) = handles.perfiles(val).xe;

tempM( tmfe+4 : tmfe+3+tmfi ,1 ) = handles.perfiles(val).xi;

tempM( 3 : 2+tmfe ,2) = handles.perfiles(val).ye;

tempM( tmfe+4 : tmfe+3+tmfi ,2 ) = handles.perfiles(val).yi;

set(handles.Tab_Forma,'Data',tempM);

%_________rellenar tabla prestaciones___________
clearvars('tempM');
tempM(:,1) = handles.perfiles(val).alfa;
tempM(:,2) = handles.perfiles(val).Cl;
tempM(:,3) = handles.perfiles(val).Cd;

set(handles.Tab_Coef,'Data',tempM);

%Cambiar valor de rR
set(handles.Text_rR,'string',sprintf('r/R = %5.3f',handles.perfiles(val).rR));
end

