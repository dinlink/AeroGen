function [ Bool ] = CheckAnaAdim( handles )



if    ~isnan(str2double(get(handles.Edit_rRhub,'string'))) &&...
      ~isnan(str2double(get(handles.Edit_Npalas,'string'))) &&...
      ~isempty(handles.p) && ~isempty(handles.cR_th{1,3}) &&...
      ~isempty(handles.cR_th{2,3})
    Bool = true;
else
    Bool = false;
end


end

