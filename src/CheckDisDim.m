function [ Bool ] = CheckDisDim( handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


if ~isnan(str2double(get(handles.Edit_cttVn,'string'))) &&...
        ~isnan(handles.Pn(3)) && ~isnan(handles.ckF0(1,3))&&...
        ~isempty(handles.Cp{2,3})
        
    Bool = true;
else
    Bool = false;
end


end

