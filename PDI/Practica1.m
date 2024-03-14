clc
close all
clear all
warning off all

a=imread('flowers.jpeg');
%imshow(a)

[r c d]= size(a);

grises=rgb2gray(a);
b_negro=im2bw(a);

roja=a;
roja(:,:,1);
roja(:,:,2)=0;
roja(:,:,3)=0;

verde=a;
verde(:,:,1)=0;
verde(:,:,2);
verde(:,:,3)=0;

azul=a;
azul(:,:,1)=0;
azul(:,:,2)=0;
azul(:,:,3);


p1=a(:,1:(c/3),:);
p2=a(:,(c/3):2*(c/3),:);
p3=a(:,(2*(c/3)):c,:);

roja2=p1;
roja2(:,:,1);
roja2(:,:,2)=0;
roja2(:,:,3)=0;

verde2=p2;
verde2(:,:,1)=0;
verde2(:,:,2);
verde2(:,:,3)=0;

azul2=p3;
azul2(:,:,1)=0;
azul2(:,:,2)=0;
azul2(:,:,3);


f1=a(1:(r/3),:,:);
f2=a((r/3):2*(r/3),:,:);
f3=a((2*(r/3)):r,:,:);

roja3=f1;
roja3(:,:,1);
roja3(:,:,2)=0;
roja3(:,:,3)=0;

verde3=f2;
verde3(:,:,1)=0;
verde3(:,:,2);
verde3(:,:,3)=0;

azul3=f3;
azul3(:,:,1)=0;
azul3(:,:,2)=0;
azul3(:,:,3);

figure(1)
arreglo1=[a roja; verde azul];
imshow(arreglo1)

figure(2);
arreglo2=[roja2 verde2 azul2];
imshow(arreglo2);

figure(3);
arreglo3=[roja3;verde3;azul3];
imshow(arreglo3);

%%%%
num_filas = 4;
num_columnas = 8;

ancho_cuadro = size(a, 2) / num_columnas;
alto_cuadro = size(a, 1) / num_filas;

cuadros = cell(num_filas, num_columnas);

for fila = 1:num_filas
    for columna = 1:num_columnas
        x_inicio = round((columna - 1) * ancho_cuadro) + 1;
        x_fin = round(columna * ancho_cuadro);
        y_inicio = round((fila - 1) * alto_cuadro) + 1;
        y_fin = round(fila * alto_cuadro);

        cuadro = a(y_inicio:y_fin, x_inicio:x_fin, :);
        
        % Modificar los colores de los cuadros
        if any(fila == [1, 2, 3, 4]) && any(columna == [1, 2])
            cuadro(:,:,2) = 0; % Establecer el canal verde a cero
            cuadro(:,:,3) = 0; % Establecer el canal azul a cero
        elseif any(fila == [1, 2, 3, 4]) && any(columna == [7, 8])
            cuadro(:,:,1) = 0; % Establecer el canal rojo a cero
            cuadro(:,:,3) = 0; % Establecer el canal azul a cero
        elseif any(fila == [1, 3]) && any(columna == [3, 4, 5, 6])
            cuadro(:,:,1) = 0; % Establecer el canal rojo a cero
            cuadro(:,:,2) = 0; % Establecer el canal verde a cero
        elseif any(fila == [2, 4]) && any(columna == [3, 6])
            cuadro(:,:,1) = 0; % Establecer el canal rojo a cero
            cuadro(:,:,2) = 0; % Establecer el canal verde a cero
        elseif any(fila == [2, 4]) && any(columna == [4, 5])
            cuadro(:,:,1) = 0; % Establecer el canal rojo a cero
            cuadro(:,:,2) = 0; % Establecer el canal verde a cero
            cuadro(:,:,3) = 0; % Establecer el canal azul a cero
        end
        
        cuadros{fila, columna} = cuadro;
    end
end

% Concatenar todos los cuadros horizontalmente en cada fila
fila1 = cat(2, cuadros{1, :});
fila2 = cat(2, cuadros{2, :});
fila3 = cat(2, cuadros{3, :});
fila4 = cat(2, cuadros{4, :});

% Concatenar todas las filas verticalmente
arreglo4 = cat(1, fila1, fila2, fila3, fila4);

% Mostrar la imagen completa
figure(4);
imshow(arreglo4);


