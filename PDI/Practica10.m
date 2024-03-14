clc
clear all
close all
%Comentar la linea 76 para dejar de generar error random en el arreglo xd
[file, path] = uigetfile('*.txt', 'Seleccione un archivo de texto');

if isequal(file, 0)
    disp('No se seleccionó ningún archivo.');
else
    fullpath = fullfile(path, file);
    fileID = fopen(fullpath, 'r');
    
    fileContent = fscanf(fileID, '%s');
    
    fclose(fileID);
    
    Arreglo = char(fileContent);
end

longitud_arreglo = length(Arreglo);

R = 0;
while 2^R < R + longitud_arreglo + 1
    R = R + 1;
end
arreglo = double(Arreglo);

N = length(arreglo) + R;

nuevoArreglo = zeros(1, N);

for i = 0:(R-1)
    nuevoArreglo(2^i) = -1;
end

indice = 1;
for i = 1:length(nuevoArreglo)
    if nuevoArreglo(i) == -1
        continue;
    else
        nuevoArreglo(i) = Arreglo(indice) - 48;
        indice = indice + 1;
    end
end

error = 0;
for i = 0:(R-1)
    mask = 2^i;
    count = 0;
    if ~ismember(mask, 2.^(0:(R-1)))
        for j = mask:N
            if bitand(j, mask)
                if nuevoArreglo(j) == 1
                    count = count + 1;
                end
            end
        end
        if mod(count, 2) == 0
            nuevoArreglo(mask) = 0;
        else
            nuevoArreglo(mask) = 1;
        end
        
        if mod(count, 2) ~= nuevoArreglo(mask)
            error = error + mask;
        end
    end
end

disp('Arreglo original:');
disp(Arreglo);

posicion_cambio = randi(length(Arreglo));

Arreglo_con_error = Arreglo; 
Arreglo_con_error(posicion_cambio) = num2str(~str2num(Arreglo(posicion_cambio)));

disp('Arreglo con error introducido:');
disp(Arreglo_con_error);

nuevoArreglo = zeros(1, N);

for i = 0:(R-1)
    nuevoArreglo(2^i) = -1;
end

indice = 1;
for i = 1:length(nuevoArreglo)
    if nuevoArreglo(i) == -1
        continue;
    else
        nuevoArreglo(i) = Arreglo_con_error(indice) - 48; 
        indice = indice + 1;
    end
end
error = 0;
pos = 1;
while pos <= length(Arreglo)
    if Arreglo(pos) ~= Arreglo_con_error(pos)
        disp(['Elemento diferente encontrado en el bit: ', num2str(pos)]);
        disp(['Arreglo tiene ', Arreglo(pos), ' y Arreglo_con_error tiene ', Arreglo_con_error(pos)]);
        error=error+1;
        break;
    end
    pos = pos + 1;
end


for i = 0:(R-1)
    mask = 2^i;
    count = 0;
    if ~ismember(mask, 2.^(0:(R-1)))
        for j = mask:N
            if bitand(j, mask)
                if nuevoArreglo(j) == 1
                    count = count + 1;
                end
            end
        end
        if mod(count, 2) == 0
            nuevoArreglo(mask) = 0;
        else
            nuevoArreglo(mask) = 1;
        end
        if mod(count, 2) ~= nuevoArreglo(mask)
            disp(['Error detectado en el bit de paridad ', num2str(i), ' en la posición ', num2str(mask)]);
            error = error + mask;
        end
    end
end

if error == 0
    disp('No se detectaron errores en el arreglo.');
end