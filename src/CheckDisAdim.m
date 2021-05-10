function [ Bool ] = CheckDisAdim( handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


if ~isnan(str2double(get(handles.Edit_Lambdad,'string'))) &&...
      ~isnan(str2double(get(handles.Edit_rRhub,'string'))) &&...
      ~isnan(str2double(get(handles.Edit_Npalas,'string'))) &&...
      ~isempty(handles.p)
    Bool = true;
else
    Bool = false;
end


end

