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
function PerfilesGrafFun(hObject, handles )
%UNTITLED Summary of this function goes here
%   Esta función determina las funciones de interpolación

%_________Inicializacion de variables___________

%tam: numero de perfiles
tam = length(handles.perfiles);

%amin, amax: alfa mínimo y maximp
amin = min(vertcat(handles.perfiles(:).alfa));
amax = max(vertcat(handles.perfiles(:).alfa));

%Resolución de discretización de alfa (Da) y vector de malla Avg
Da = (amax-amin)/400;
Avg = amin:Da:amax;


%rRv: vector r/R
rRv = [handles.perfiles(:).rR];

%Ordenar perfiles según r/R ascendente y obtener el vector de mallado
[rRvg indx] = sort(rRv);


%determinación de vector de malla para dibujo de perfiles
Xvg = (logspace(0,4,400)-1)/9999 ;

% %generacion de dominio X-Y (Alfa-r/R y x-r/R) para funciones 3D
% [Adom,rRAdom] = meshgrid(Avg,rRvg);
% [xdom,rRxdom] = meshgrid(Xvg,rRvg);

%Funciones 2D y Matriz de valores Z para funciones 3D

for i = 1:tam
    
    %___________Funciones2D_________
    
    x = handles.perfiles(i).alfa;

    
    y = handles.perfiles(i).Cl;
    [cs,p] = csaps( x, y );
    Cl2D = @(xq) fnval(fnxtr(csaps( x, y, p*(1-0.15) )), xq);
    
    y = handles.perfiles(i).Cd;
    [cs,p] = csaps( x, y );
    Cd2D = @(xq) fnval(fnxtr(csaps( x, y, p*(1-0.15) )), xq);
    
    y = handles.perfiles(i).Cl./handles.perfiles(i).Cd;
    [cs,p] = csaps( x, y );
    ClCd2D = @(xq) fnval(fnxtr(csaps( x, y, p*(1-0.15) )), xq);
    
    x = handles.perfiles(i).xe;
    y = handles.perfiles(i).ye;
    ye2D = @(xq) pchip(x,y,xq);
    
    x = handles.perfiles(i).xi;
    y = handles.perfiles(i).yi;
    yi2D = @(xq) pchip(x,y,xq);

    
    %________Matrices Z (para funciones 3D)______
    
    Z_Cl(i,:)   = Cl2D(Avg); 
    
    Z_Cd(i,:)   = Cd2D(Avg);
    
    Z_ClCd(i,:) = ClCd2D(Avg);
    
    Z_ye(i,:)   = ye2D(Xvg);
    
    Z_yi(i,:)   = yi2D(Xvg);
 
end

% Reordenar Z según orden ascendente de r/R
% Y adecuar tipo nGrid para interpolacion 3D

Z_Cl   = Z_Cl(indx,:).';
Z_Cd   = Z_Cd(indx,:).';
Z_ClCd = Z_ClCd(indx,:).';
Z_ye   = Z_ye(indx,:).';
Z_yi   = Z_yi(indx,:).';

%_______________________ Funciones 3D ___________________

handles.Cl.Fun3D = griddedInterpolant({Avg,rRvg},Z_Cl,'spline','linear');
handles.Cl.tag   = 'Cl';
handles.Cl.title = 'Coeficiente de sustentación';

handles.Cd.Fun3D = griddedInterpolant({Avg,rRvg},Z_Cd,'spline','linear');
handles.Cd.tag   = 'Cd';
handles.Cd.title = 'Coeficiente de arrastre';

handles.ClCd.Fun3D = griddedInterpolant({Avg,rRvg},Z_ClCd,'spline','linear');
handles.ClCd.tag   = 'Cl/Cd';
handles.ClCd.title = 'Relación Cl/Cd';

handles.y.e.Fun3D = griddedInterpolant({Xvg,rRvg},Z_ye,'spline','linear');
handles.y.i.Fun3D = griddedInterpolant({Xvg,rRvg},Z_yi,'spline','linear');
handles.y.tag = 'Perfil';
handles.y.title = 'Forma de perfil';

%__________________ Vector de mallado de rR ___________________
rRmax = 1;
rRmin = min([0.2 rRvg]);
DrR=(rRmax - rRmin)/100;
rRvg = rRmin:DrR:rRmax;

%__________Almacenaje de dominios de graficación en handles________
handles.rRvg = rRvg;
handles.Avg  = Avg;
handles.Xvg  = Xvg;

%__________Almacenaje de límites superior e inferior de dominio ______
handles.a.min = amin;
handles.a.max = amax;

%___________Calculo y almacenaje de alfa cuando Cl = 0_________
alfarRA0 = arrayfun( @(y) fzero( @(x) handles.Cl.Fun3D(x,y), 0 ), rRvg);

%Interpolación cúbica suavizada
[cs,p]=csaps(rRvg, alfarRA0);
handles.a.a0 = @(x) fnval(fnxtr(csaps(rRvg , alfarRA0 ,p * (1 - 5 * 10 ^-4))) ,x);


guidata(hObject,handles)

end

