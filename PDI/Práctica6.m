clc
clear all
close all
warning off all

a = imread('peppers.png');
b = rgb2gray(a);

bits_error = input('Ingrese el número de bits para los errores: ');

num_muestras = input('Ingrese el número de muestras: ');

prediccion_R = medfilt2(a(:,:,1)); 
prediccion_G = medfilt2(a(:,:,2)); 
prediccion_B = medfilt2(a(:,:,3)); 

error_R = double(a(:,:,1)) - double(prediccion_R);
error_G = double(a(:,:,2)) - double(prediccion_G);
error_B = double(a(:,:,3)) - double(prediccion_B);

rango = 2^(bits_error - 1);
%rango=(bits_error+128)
error_redondeado_R = round(error_R * rango) / rango;
error_redondeado_G = round(error_G * rango) / rango;
error_redondeado_B = round(error_B * rango) / rango;

error_codificado_R = rle(double(error_redondeado_R(:)));
error_codificado_G = rle(double(error_redondeado_G(:)));
error_codificado_B = rle(double(error_redondeado_B(:)));

error_decodificado_R = irle(error_codificado_R);
error_decodificado_G = irle(error_codificado_G);
error_decodificado_B = irle(error_codificado_B);

imagen_reconstruida_R = uint8(double(prediccion_R) + reshape(error_decodificado_R, size(prediccion_R)));
imagen_reconstruida_G = uint8(double(prediccion_G) + reshape(error_decodificado_G, size(prediccion_G)));
imagen_reconstruida_B = uint8(double(prediccion_B) + reshape(error_decodificado_B, size(prediccion_B)));

imagen_prediccion = cat(3, prediccion_R, prediccion_G, prediccion_B);

imagen_reconstruida = cat(3, imagen_reconstruida_R, imagen_reconstruida_G, imagen_reconstruida_B);

relacion_compresion = numel(error_codificado_R) / numel(a(:,:,1));

imagen_error=cat(3,error_redondeado_R, error_redondeado_G, error_redondeado_B);
figure;

subplot(1, 4, 1);
imshow(a);
title('Imagen Original');

subplot(1, 4, 2);
imshow(imagen_prediccion);
title('Imagen Predicción');

subplot(1, 4, 3);
imshow(imagen_error);
title('Imagen Error');

subplot(1, 4, 4);
imshow(imagen_reconstruida);
title('Imagen Comprimida');
disp('aqui vamos...')

c=rgb2gray(imagen_reconstruida);

relacion_compresion_R = 10 * log10((sum(double(b).^2) / (sum(double(b) - sum(double(c)))).^2));

fprintf('Relación de compresión: %f\n', relacion_compresion_R);





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
