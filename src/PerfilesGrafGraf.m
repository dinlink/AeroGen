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
function  PerfilesGrafGraf( handles, Fun )
%UNTITLED Summary of this function goes here
%   Esta función realiza gráficas para la figura PerfilesGraf

%____________Captura de dominio____________

rRvg = handles.rRvg;
Avg  = handles.Avg;
Xvg  = handles.Xvg;
rR   = handles.Val_rR;

%______________ Graficación _______________

if ~strcmp(handles.y.tag,Fun.tag)
    
    %_______Gráfica3D________
       
    
    axes(handles.Axe_Perfiles3D)
    
    surfc(Avg,rRvg,Fun.Fun3D({Avg,rRvg}).','linestyle','none')
    title([Fun.title ' vs alfa-r/R'],'fontweight','bold')
    xlabel('Ángulo de ataque (°)')
    ylabel('r/R')
    zlabel(Fun.tag)
    
    hold on
    
    %Parámetros de plano de corte en rR
    Amin = min(Avg);
    Amax = max(Avg);
    Funmax = max(Fun.Fun3D({Avg,rRvg}));
    Funmin = min(Fun.Fun3D({Avg,rRvg}));
    X = [Amin; Amax; Amax; Amin];
    Y = [rR; rR; rR; rR];
    Z = [Funmin; Funmin; Funmax; Funmax];
    
    %Plano de corte
    fill3(X,Y,Z,'b','linestyle','none','FaceAlpha',0.01)
      
    hold off
    
    %_______Gráfica 2D_______
    
    axes(handles.Axe_Perfiles2D)
    
    plot(Avg,Fun.Fun3D({Avg,rR}).')
    title('Plano de corte','fontweight','bold')
    xlabel('Ángulo de ataque (°)')
    ylabel(Fun.tag)
    
else
    
    %_______Gráfica3D________
       
    
    axes(handles.Axe_Perfiles3D)
    
    surf(Xvg,rRvg,Fun.e.Fun3D({Xvg,rRvg}).','linestyle','none')
    hold on
    surf(Xvg,rRvg,Fun.i.Fun3D({Xvg,rRvg}).','linestyle','none')
    
    title([Fun.title ' a lo largo de r/R'],'fontweight','bold')
    xlabel('x')
    ylabel('r/R')
    zlabel('y')
    
    
    
    %Parámetros de plano de corte en rR
    Xmin = min(Xvg);
    Xmax = max(Xvg);
    Funmax = max(Fun.e.Fun3D({Xvg,rRvg}));
    Funmin = min(Fun.i.Fun3D({Xvg,rRvg}));
    X = [Xmin; Xmax; Xmax; Xmin];
    Y = [rR; rR; rR; rR];
    Z = [Funmin; Funmin; Funmax; Funmax];
    
    %Plano de corte
    fill3(X,Y,Z,'b','linestyle','none','FaceAlpha',0.01)
      
    hold off
    
    %_______Gráfica 2D_______
    
    axes(handles.Axe_Perfiles2D)
    
    plot(Xvg,Fun.e.Fun3D({Xvg,rR}).')
    hold on
    plot(Xvg,Fun.i.Fun3D({Xvg,rR}).')
    
    title('Plano de corte','fontweight','bold')
    xlabel('x')
    ylabel('y')
    
    hold off
end

end

