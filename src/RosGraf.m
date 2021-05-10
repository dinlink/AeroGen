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

