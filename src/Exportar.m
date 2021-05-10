function  Exportar( hObject, eventdata, hAxe )
%UNTITLED Exporta a una tabla excel la data contenida en "DATA"
%   Detailed explanation goes here

[fileName, pathName] = uiputfile({'*.xls, *.xlsx'},'Elegir dirección para guardar los datos','Data.xlsx');

dirData = [pathName, fileName];

if ischar(dirData)
    
    variableNames = { get(get(hAxe,'Xlabel'),'string'),...
        get(get(hAxe,'Ylabel'),'string') };
    
    %Convertir nombres en nombres válidos de variables eliminando simbolos
    %no alfanumericos
    variableNames = regexprep( genvarname(variableNames), '0x(\w{2})','_');
    
    dataAux = get(hAxe,'children');
    xData = get(dataAux(end), 'xData').';
    yData = get(dataAux(end), 'yData').';
    
    dataT = table(xData, yData, 'VariableNames', variableNames);
    
    writetable(dataT,dirData)
    
end

end

