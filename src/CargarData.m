function [DataV,colNames,tamStr] = CargarData( dirData )
%CargarData Carga y adecúa la data de viento
%   Detailed explanation goes here


    hwb = waitbar(0,'1','Name','Cargando');
    
    
    waitbar(0/3,hwb,'Leyendo tabla...')
    
    DataV = readtable(dirData, 'FileType', 'spreadsheet' );
    
    waitbar(1/3,hwb,'Limpiando tabla...')
    %Limpieza de tabla
    DataV = limpiar(DataV);
    
    waitbar(2/3,hwb,'Adecuando tabla...')
    
    %convertir la primera columna a vector de fechas
    DataV.(1) = datevec(DataV.(1),'dd/mm/yyyy HH:MM:ss');
    colNames = [{'Año','Mes','Día','Hora','Minuto','Segundo'} DataV.Properties.VariableNames(2:end)];
    
    %Captura de alturas de la tabla
    altVec=strncmp('V_',DataV.Properties.VariableNames,2);
    altStr=DataV.Properties.VariableNames(altVec);
    altStr=strrep(altStr,'V_','');
    
    %Convertir valores numéricos de string a double
    tamStr = length(altStr);
    
    for i = 2 : 2*tamStr + 1
        
        if iscell(DataV.(i))
            DataV.(i) = str2double(DataV.(i));
        end
        
    end
    
    %Pasar de coordenadas cardinales a coordenadas polares
    Aux=DataV{:,2+tamStr:1+2*tamStr};

    
    Aux(90-Aux>=0)=90-Aux(90-Aux>=0);
    Aux(90-Aux<0)=90-Aux(90-Aux<0)+360;
    Aux=Aux/180*pi;
    DataV{:,2+tamStr:1+2*tamStr}=Aux;
    
    waitbar(3/3,hwb,'Completado...')
    
    delete(hwb)
end

