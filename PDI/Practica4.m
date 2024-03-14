clc
clear all
close all
warning off all

a = imread("peppers.png");

figure(1)
imshow(a);

Histograma_rojo = zeros(1, 256); 
Histograma_verde = zeros(1, 256);
Histograma_azul = zeros(1, 256); 

% Obtén las dimensiones de la imagen
[filas, columnas, ~] = size(a);

for fila = 1:filas
    for columna = 1:columnas
        pixel = a(fila, columna, :);
        Histograma_rojo(pixel(1) + 1) = Histograma_rojo(pixel(1) + 1) + 1;
        Histograma_verde(pixel(2) + 1) = Histograma_verde(pixel(2) + 1) + 1;
        Histograma_azul(pixel(3) + 1) = Histograma_azul(pixel(3) + 1) + 1;
    end
end

subplot(3,1,1)
bar(0:255, Histograma_rojo)

subplot(3,1,2)
bar(0:255, Histograma_verde)

subplot(3,1,3)
bar(0:255, Histograma_azul)