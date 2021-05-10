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
function RosGraf(hObject, handles, val_Altura )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

D = handles.DataV{:,1 + handles.tamStr + val_Altura};

D = D(D~=0);

[Ang,Cant] = rose( handles.Axe_Rosa, D, handles.binsR);

Freq = Cant/length(D);

polar(handles.Axe_Rosa,Ang,Freq);

hn = findall(handles.Axe_Rosa,'type','text');

hs=get(hn,'string');

hs([4 15 13 11 9 7 5 14 12 10 8 6])={'E','NEE','NNE','N','NNW','NWW','W','SWW','SSW','S','SSE','SEE'};

set(hn,{'string'},hs);

set(hn,'fontsize',8);

end

