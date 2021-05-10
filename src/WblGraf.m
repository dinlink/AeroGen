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
function WblGraf(eventdata,hObject, handles, val_Altura, val_Calculo )
%UNTITLED Grafica weibull pdf
%   Detailed explanation goes here

%Determinación frecuencia de calmas F0
Data = handles.DataV.(1+val_Altura);
count = sum(Data == 0);
F0 = count/length(Data);

%Eliminación de calmas de la data
D = Data(Data~=0);

%Numero de intervalos (+1 porque el ultimo intervalo va a infinito)
b = handles.binsW+1;

%Determinación de cuenta y centro de intervalos
[n,cent] = hist(D,b);

%Determinación de frecuencias (Probabilidad)
frec = n/length(D);

%Determinación de extremo derecho de intervalos (r)
Dmax = max(D);
Dmin = min(D);
db = (Dmax-Dmin)/b;
r = cent+db/2;

%Verficiación de método de cálculo de c y k

if(val_Calculo == 1)

    %Cumulativo de frecuencias afrec (no se toma el ultimo elemento
    %porque afrec(end)=1 y Y(afrec(end))=Inf
    afrec = cumsum(frec(1:end-1));

    %Determinación de vectores X e Y a ajustar
    x = log(r(1:end-1));
    y = log(-log(1-afrec));

    %Determinación del ajuste lineal
    p = polyfit(x,y,1);

    %Determinación de c y k
    k = p(1);
    c = exp(-p(2)/p(1));

    
    %Graficación de Ajuste Lineal

    axes(handles.Axe_GraficaWL);

    plot(x,p(1)*x+p(2));
    hold on;
    plot(x,y,'o');
    title('Ajuste lineal de la función de distribución de probabilidad de Weibull','fontweight','bold');
    xlabel('log(Vi) (log(m/s))')
    ylabel('log(-log(1-Pi))')
    legend('Ajuste lineal','Data ajustada','location','best');
    hold off;
    grid on;

else
    
    %Ajuste y extracción de parámetros
    Pd = fitdist(D,'Weibull');
    c = Pd.A;
    k = Pd.B;
    
    axes(handles.Axe_GraficaWL);
    wblplot(D);
    
    set(get(gca,'xlabel'),'string','Datos');
    set(get(gca,'ylabel'),'string','Probabilidad');
    set(get(gca,'title'),'string','Gráfica de probabilidad de Weibull');
    set(get(gca,'title'),'fontweight','bold');

end

%Determinación de función de densidad de probabilidad con calmas
pdfWC = @(V) (1-F0) * ( (k/c) *(V/c).^(k-1) .*exp(-(V/c).^k) ) ;

%Determinación de función de distribución de probabilidad con calmas
cdfWC = @(Vx) F0+(1-F0).*(1-exp(-(Vx/c).^k));

%Rango de graficación
minV = Dmin;
maxV = Dmax;
stepV = (maxV-minV)/200;
x_values = minV:stepV:maxV;


%Graficación de función de densidad de probabilidad

axes(handles.Axe_Weibull);

plot(x_values,pdfWC(x_values));
hold on;

bar(cent(1:end-1),(1-F0)*frec(1:end-1),1);

xlabel('V (m/s)');
hxlabel=get(gca,'xlabel');
set(hxlabel,'units','normalized')
set(hxlabel,'position',[1.12 -0.02 0])

ylabel('Probabilidad')
plot(0,F0,'o','tag','axeCalmas');

legend(findall(gcf,'tag','axeCalmas'),'Calmas','location','NorthWest');
hold off;


text(0.8,0.9,[sprintf('c = %5.2f',c),sprintf(', k = %5.2f',k)],...
    'HorizontalAlignment','center','units','normalized');


%Graficación de Curva de vientos clasificados

axes(handles.Axe_Vientos);
plot(x_values,1-cdfWC(x_values));

title('Probabilidad de obtener V > Vx','fontweight','bold');
ylabel('Probabilidad')
xlabel('Vx (m/s)');
grid on;

handles.c = c;
handles.k = k;
handles.F0 = F0;

guidata(hObject,handles)
end

