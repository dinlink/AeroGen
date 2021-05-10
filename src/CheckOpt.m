function [ Bool ] = CheckOpt( handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


if ~isnan(handles.Pn(3)) && ~isnan(handles.ckF0(1,3))&&...
        ~isnan(handles.ckF0(2,3)) && ~isnan(handles.ckF0(3,3))&&...
        ~isempty(handles.Cp{1,3}) && ~isempty(handles.Cp{2,3})
        
    Bool = true;
else
    Bool = false;
end


end

