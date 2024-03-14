clc
clear all
close all
warning off all

disp("Selecciona una imagen para trabajar con ella:")
[archivo, ruta] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.tif;*.ico', 'Archivos de imagen (*.jpg, *.jpeg, *.png, *.bmp, *.tif, *ico)'}, 'Seleccionar una imagen');

if archivo == 0
    disp('No se seleccionó ninguna imagen.');
end

imagen = fullfile(ruta, archivo);

imagen = imread(imagen);

if size(imagen, 3) == 3
    a = rgb2gray(imagen);
else
    a = imagen;
end

[filas, columnas] = size(a);
imshow(a);
figure(1);

matriz2 = uint8(zeros(filas + 1, columnas + 1));
for i = 2: filas + 1
    for j = 2: columnas + 1
        matriz2(i, j) = uint8(a(i - 1, j - 1));
    end
end

inst1 = "Ingresa el porcentaje de ruido a agregar a la imagen: ";
r = input(inst1) / 100;
a_ruido = imnoise(matriz2, "salt & pepper", r);

subplot(1,3,1)
imshow(a);
title('Original')
subplot(1,3,2)
imshow(a_ruido);
title('Con Ruido')

while true    
    inst2 = "Escoga un metodo para eliminar el ruido:\n1) Mediana\n2) Moda\n3) Sal\n4) Pimienta\n5) max y min\n6) Todos\n7) Salir\n";
    sp = input(inst2);
    switch sp
        case 1
            imagen_sin_ruido = eliminarRuidoMediana(a_ruido);
            figure(1);
            subplot(1,3,3)
            imshow(imagen_sin_ruido);
            title('Sin Ruido Mediana')        
        case 2
            imagen_sin_ruido = eliminarRuidoModa(a_ruido);
            figure(1);
            subplot(1,3,3)
            imshow(imagen_sin_ruido);
            title('Sin Ruido Moda')
        case 3
            imagen_sin_ruido = eliminarRuidoSal(a_ruido);
            figure(1);
            subplot(1,3,3)
            imshow(imagen_sin_ruido);
            title('Sin Ruido Sal')
        case 4
            imagen_sin_ruido = eliminarRuidoPimienta(a_ruido);
            figure(1);
            subplot(1,3,3)            
            imshow(imagen_sin_ruido);
            title('Sin Ruido Pimienta')
        case 5
            imagen_sin_ruido = eliminarRuidoMaxMin(a_ruido, 255);
            figure(1);
            subplot(1,3,3)            
            imshow(imagen_sin_ruido);
            title('Sin Ruido Maximos y minimos')
        case 6
            figure(1);
            
            subplot(2,3,1)
            imshow(a_ruido);
            title('Con Ruido')

            imagen_sin_ruido_mediana = eliminarRuidoMediana(a_ruido);
            subplot(2, 3, 2)
            imshow(imagen_sin_ruido_mediana);
            title('Sin Ruido Mediana');
        
            imagen_sin_ruido_moda = eliminarRuidoModa(a_ruido);
            subplot(2, 3, 3)
            imshow(imagen_sin_ruido_moda);
            title('Sin Ruido Moda');
        
            imagen_sin_ruido_sal = eliminarRuidoSal(a_ruido);
            subplot(2, 3, 4)
            imshow(imagen_sin_ruido_sal);
            title('Sin Ruido Sal');

            imagen_sin_ruido_pimienta = eliminarRuidoPimienta(a_ruido);
            subplot(2, 3, 5)
            imshow(imagen_sin_ruido_pimienta);
            title('Sin Ruido Pimienta');
        
            imagen_sin_ruido_maxmin = eliminarRuidoMaxMin(a_ruido, 255);
            subplot(2, 3, 6)
            imshow(imagen_sin_ruido_maxmin);
            title('Sin Ruido Maximos y minimos');
            
            figure(2)
            imshow(a);
        case 7    
            break;
        otherwise
            disp('Opción no válida. Inténtalo de nuevo.');
    end
end

function imagen_sin_ruido = eliminarRuidoMediana(a_ruido)
    [filas, columnas] = size(a_ruido);
    imagen_sin_ruido = a_ruido;
    ventana = 5;  % Tamaño de la ventana
    mitad_ventana = floor(ventana / 2);

    for i = 1 + mitad_ventana : filas - mitad_ventana
        for j = 1 + mitad_ventana : columnas - mitad_ventana
            % Extraer la ventana de 5x5 alrededor del píxel actual
            ventana_pixel = a_ruido(i - mitad_ventana : i + mitad_ventana, j - mitad_ventana : j + mitad_ventana);

            % Ordenar los valores de píxeles en la ventana
            ventana_ordenada = sort(ventana_pixel(:));

            % Encontrar el valor del medio
            mediana = ventana_ordenada(floor(ventana^2 / 2) + 1);

            % Asignar la mediana como el nuevo valor del píxel en la imagen sin ruido
            imagen_sin_ruido(i, j) = mediana;
        end
    end
end


function imagen_sin_ruido = eliminarRuidoModa(a_ruido)
    [filas, columnas] = size(a_ruido);
    ventana = 3;
    mitad_ventana = floor(ventana / 2);
    imagen_sin_ruido = a_ruido;

    for i = 1 + mitad_ventana : filas - mitad_ventana
        for j = 1 + mitad_ventana : columnas - mitad_ventana
            % Obtener la ventana de píxeles alrededor del píxel actual
            ventana_pixel = a_ruido(i - mitad_ventana : i + mitad_ventana, j - mitad_ventana : j + mitad_ventana);
            
            % Calcular la moda de los píxeles en la ventana
            moda = calcularModa(ventana_pixel(:));
            
            % Asignar la moda al píxel actual en la imagen sin ruido
            imagen_sin_ruido(i, j) = moda;
        end
    end
end

function moda = calcularModa(vector)
    % Calcular la moda de un vector
    valores_unicos = unique(vector);
    repeticiones = histc(vector, valores_unicos);
    [~, indice] = max(repeticiones);
    moda = valores_unicos(indice);
end


function imagen_sin_ruido = eliminarRuidoSal(a_ruido)
    [filas, columnas] = size(a_ruido);
    imagen_sin_ruido = a_ruido;
    for i = 1:filas
        for j = 1:columnas
            if a_ruido(i, j) == 255
                imagen_sin_ruido(i, j) = 0;  % Eliminar el píxel de "sal" (cambiar a 0)
            end
        end
    end
end

function imagen_sin_ruido = eliminarRuidoPimienta(a_ruido)
    [filas, columnas] = size(a_ruido);
    imagen_sin_ruido = a_ruido;
    for i = 1:filas
        for j = 1:columnas
            if a_ruido(i, j) == 0
                imagen_sin_ruido(i, j) = 255;  % Eliminar el píxel de "pimienta" (cambiar a 255, blanco)
            end
        end
    end
end


function imagen_sin_ruido = eliminarRuidoMaxMin(a_ruido, valor_ruido)
    % Convertir la imagen a una imagen binaria donde el ruido es 1 y el resto es 0
    imagen_binaria = (a_ruido == valor_ruido);

    % Crear un elemento estructurante de 3x3 (se podría ajustar el tamaño)
    se = strel('square', 5);

    % Aplicar la erosión (mínimos locales)
    imagen_erosionada = imerode(imagen_binaria, se);

    % Crear una máscara que identifica los píxeles de ruido basados en la erosión
    mascara_ruido = imagen_binaria & ~imagen_erosionada;

    % Crear una copia de la imagen original
    imagen_sin_ruido = a_ruido;

    % Establecer a 0 los píxeles identificados como ruido en la imagen sin ruido
    imagen_sin_ruido(mascara_ruido) = 0;
end
