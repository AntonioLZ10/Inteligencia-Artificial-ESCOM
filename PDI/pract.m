clc
clear all
close all
warning off all

[filename, filepath]=uigetfile({'*.jpg; *.png; *.bmp','Imagen(*.jpg,*.png, *.bmp)'},'Seleccione una imagen');
if isequal(filename,0)
    disp('Ninguna imagen seleccionada.');
    return;
end
a=imread(fullfile(filepath, filename));

%binaryImage = imbinarize(rgb2gray(a));
binaryImage = imbinarize(a);
opcion = input('Presiona A para apertura o C para cierre: ', 's');
if opcion == 'A'
    resultado = apertura(binaryImage);
    operacion = 'Apertura';
elseif opcion == 'C'
    resultado = cierre(binaryImage);
    operacion = 'Cierre';
else
    disp('Inutil');
    return;
end

figure;
subplot(1, 2, 1);
imshow(binaryImage);
title('Imagen Original');

subplot(1, 2, 2);
imshow(resultado);
title(['Imagen después de ', operacion]);

function result = apertura(image)
    tam = input('¿Qué valor n de n*n desea para la estructura?: ');
    eroded = erosion(image, tam);
    opened = dilatacion(eroded, tam);
    result = opened;
end

function result = cierre(image)
    tam = input('¿Qué valor n de n*n desea para la cosa?: ');
    dilated = dilatacion(image, tam);
    closed = erosion(dilated, tam);
    result = closed;
end

function result = erosion(image, tam)
    [m, n] = size(image);
    result = zeros(m, n);

    for i = 1:m
        for j = 1:n  
            inicio_fila = max(1, i - tam);
            fin_fila = min(m, i + tam);
            inicio_col = max(1, j - tam);
            fin_col = min(n, j + tam);
        
            vecindad = image(inicio_fila:fin_fila, inicio_col:fin_col);
        
            if all(vecindad(:) == 1)
                result(i, j) = image(i, j);
            else
                result(i, j) = 0;
            end
        end
    end
end

function result = dilatacion(image, tam)
    [m, n] = size(image);
    result = zeros(m, n);

    for i = 1:m
        for j = 1:n  
            inicio_fila = max(1, i - tam);
            fin_fila = min(m, i + tam);
            inicio_col = max(1, j - tam);
            fin_col = min(n, j + tam);
        
            vecindad = image(inicio_fila:fin_fila, inicio_col:fin_col);
        
            if any(vecindad(:) == 1)
                result(i, j) = 1;
            else
                result(i, j) = 0;
            end
        end
    end
end