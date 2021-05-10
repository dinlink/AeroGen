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
function tablaR = limpiar( tablaIn )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%comparacion entre los nombres de cabecera y 'Var', si cabecera=Var* -> 1
lhead = strncmp( 'Var', tablaIn.Properties.VariableNames, 3 );

%eliminacion de cabeceras  'basura' (que comienzan por 'Var')
tablaIn( :, lhead ) = [];

%identificación de cabaceras diferentes de 'V_' y 'D_'
lhead = not( or( strncmp('V', tablaIn.Properties.VariableNames, 1 ), ...
    strncmp('D', tablaIn.Properties.VariableNames, 1 ) ) );
%excluir la columna de Fechas
lhead(1) = 0;

%eliminacion de cabeceras  'extra' (que no comienzan por 'V' o 'D')
tablaIn( :, lhead ) = [];

%eliminación de filas con fechas sin formato adecuado:
logicF = cellfun( @(x) (length(x) == 19) && (~isempty( regexp(x,...
    '[0-3]\d/[0-1]\d/\d\d\d\d [0-2]\d:[0-5]\d:[0-5]\d', 'once' ) ) ), tablaIn{:,1} );
tablaIn = tablaIn(logicF,:);

%eliminacion de filas basura (que contienen vacios o NaN)
tablaR = tablaIn( ~any( ismissing( tablaIn, {'', NaN} ) ,2) ,: );

end

