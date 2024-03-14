clc
clear all
close all

Arreglo = [1,0,1,0,1,0,1,0,0,0];

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
        nuevoArreglo(i) = Arreglo(indice);
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

disp('Seleccione el bit para colocar el error:');
disp('Ingrese un número entre 1 y el tamaño del arreglo.');

prompt = 'Ingrese el número del bit: ';
posicion_cambio = input(prompt);

Arreglo_con_error = Arreglo; 
Arreglo_con_error(posicion_cambio) = ~Arreglo(posicion_cambio);

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
        nuevoArreglo(i) = Arreglo_con_error(indice); 
        indice = indice + 1;
    end
end

error = 0;
pos = 1;
while pos <= length(Arreglo)
    if Arreglo(pos) ~= Arreglo_con_error(pos)
        disp(['Elemento diferente encontrado en el bit: ', num2str(pos)]);
        disp(['Arreglo tiene ', num2str(Arreglo(pos)), ' y Arreglo_con_error tiene ', num2str(Arreglo_con_error(pos))]);
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
