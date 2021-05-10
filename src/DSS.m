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
function  vRes = DSS( x, xmin, xmax, Ds )
%Double Smooth Step 
% DSS(x) =              1                if              x < xmin - Ds
%          1 - f((x - (xmin - Ds) )/Ds)  if xmin - Ds <= x < xmin
%                       0                if    xmin   <= x < xmax
%               f((x - xmax )/Ds)        if    xmax   <= x < xmax + Ds
%                       1                if xmax + Ds <= x
%
%where f(x) is a smooth step function
%Ds is the delta of transition for the step

%  Smooth step between 0 and 1
f = @(t) 6 * t.^5 - 15 * t .^4 +10*t .^3;

%  region x < xmin - Ds
part1 = ones(1, length( x( x < (xmin - Ds) ) ));

%  region xmin - Ds <= x < xmin 
t = x( xmin - Ds <= x);
t = t( t < xmin);
part2 = 1 - f((t - (xmin - Ds) )/Ds);

%  region xmin   <= x < xmax
t = x( xmin <= x );
t = t(t < xmax);
part3 = zeros( 1, length(t));

% region xmax   <= x < xmax + Ds
t = x(xmax   <= x);
t = t(t < xmax + Ds);
part4 = f((t - xmax )/Ds) ;

% region xmax + Ds <= x
part5 = ones(1, length( x( (xmax + Ds) <= x) ) );

% Result
vRes = [part1 part2 part3 part4 part5];


end

