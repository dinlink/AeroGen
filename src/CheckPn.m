function [ Bool ] = CheckPn( handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%condiciones que se repiten
Cond_EntrPV = ~isnan(str2double(get(handles.Edit_Edn,'string'))) &&...
            ~isnan(str2double(get(handles.Edit_Pnc,'string'))) &&...
            ~isempty(handles.CurvaPV);

if ~isnan(handles.ckF0(1,3)) && ~isnan(handles.ckF0(2,3)) &&...
        ~isnan(handles.ckF0(3,3)) && Cond_EntrPV 
    
    Bool = true;
else
    Bool = false;
end


end

