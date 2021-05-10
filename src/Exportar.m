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
function  Exportar( hObject, eventdata, hAxe )
%UNTITLED Exporta a una tabla excel la data contenida en "DATA"
%   Detailed explanation goes here

[fileName, pathName] = uiputfile({'*.xls, *.xlsx'},'Elegir dirección para guardar los datos','Data.xlsx');

dirData = [pathName, fileName];

if ischar(dirData)
    
    variableNames = { get(get(hAxe,'Xlabel'),'string'),...
        get(get(hAxe,'Ylabel'),'string') };
    
    %Convertir nombres en nombres válidos de variables eliminando simbolos
    %no alfanumericos
    variableNames = regexprep( genvarname(variableNames), '0x(\w{2})','_');
    
    dataAux = get(hAxe,'children');
    xData = get(dataAux(end), 'xData').';
    yData = get(dataAux(end), 'yData').';
    
    dataT = table(xData, yData, 'VariableNames', variableNames);
    
    writetable(dataT,dirData)
    
end

end

