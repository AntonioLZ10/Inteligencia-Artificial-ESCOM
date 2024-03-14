clc
clear all
close all
warning off all

imagen_original = imread('peppers.png');
imagen_original = rgb2gray(imagen_original);

bits_error = input('Ingrese el número de bits para los errores (1-8): ');
num_muestras = input('Ingrese el número de muestras: ');

prediccion = medfilt2(imagen_original);

error = double(imagen_original) - double(prediccion);

rango = 2^(bits_error - 1);
error_redondeado = round(error * rango) / rango;

error_redondeado = error_redondeado * (2^(8 - bits_error));

error_codificado = rle(double(error_redondeado(:)));

error_decodificado = irle(error_codificado);

imagen_reconstruida = uint8(double(prediccion) + reshape(error_decodificado, size(prediccion)));

%relacion_compresion = numel(error_codificado) / (numel(imagen_original) * bits_error);
relacion_compresion = 10*log10((sum(imagen_original).^2)/((sum(imagen_original)-sum(imagen_reconstruida)).^2));
figure;

subplot(2, 2, 1);
imshow(imagen_original);
title('Imagen Original');

subplot(2, 2, 2);
imshow(prediccion, []);
title('Imagen Predicción');

subplot(2, 2, 3);
imshow(abs(error_redondeado), []);
title('Imagen Error');

subplot(2, 2, 4);
imshow(imagen_reconstruida, []);
title('Imagen Comprimida');

fprintf('Relación de compresión: %f\n', relacion_compresion);

function output = rle(input)
    input = input(:);
    output = [];
    count = 1;
    for i = 2:length(input)
        if input(i) == input(i - 1)
            count = count + 1;
        else
            output = [output; input(i - 1); count];
            count = 1;
        end
    end
    output = [output; input(end); count];
end

function output = irle(input)
    input = input(:);
    output = [];
    for i = 1:2:length(input)
        value = input(i);
        count = input(i + 1);
        output = [output; repmat(value, [count, 1])];
    end
end