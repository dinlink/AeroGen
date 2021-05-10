function CheckFun( handles, Btn )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
switch Btn
    
    case handles.Btn_Pn
        
        if CheckPn(handles)
            set(handles.Btn_Pn,'enable','on')
        else
            set(handles.Btn_Pn,'enable','off')
        end
        
    case handles.Btn_DisAdim
        
        if CheckDisAdim(handles)
            set(handles.Btn_DisAdim,'enable','on')
        else
            set(handles.Btn_DisAdim,'enable','off')
        end
        
    case handles.Btn_AnaAdim
        
        if CheckAnaAdim(handles)
            set(handles.Btn_AnaAdim,'enable','on')
        else
            set(handles.Btn_AnaAdim,'enable','off')
        end
        
    case handles.Btn_DisDim
        
        if CheckDisDim(handles)
            set(handles.Btn_DisDim,'enable','on')
        else
            set(handles.Btn_DisDim,'enable','off')
        end
        
    case handles.Btn_AnaDim
        
        if CheckAnaDim(handles)
            set(handles.Btn_AnaDim,'enable','on')
        else
            set(handles.Btn_AnaDim,'enable','off')
        end
        
    case handles.Btn_Opt
        
        if CheckOpt(handles)
            set(handles.Btn_Opt,'enable','on')
        else
            set(handles.Btn_Opt,'enable','off')
        end
        
end

end

