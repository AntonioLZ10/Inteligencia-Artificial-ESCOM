clc
clear all
close all
warning off all

a = imread('peppers.png');
a = rgb2gray(a);

figure(1)
subplot(1, 4, 1)
imshow(a)
title('Original')

bits_error = input('Ingrese el número de bits para la compresión (1-8): ');
bits_error=bits_error*2;
b = dct2(a);

max_value = max(abs(b(:)));
quantization_step = (2 * max_value) / (2^bits_error);
b_quantized = round(b / quantization_step);

b_dequantized = b_quantized * quantization_step;

[nrows, ncols] = size(a);
prediccion = zeros(nrows, ncols);

for i = 2:nrows
    for j = 2:ncols
        prediccion(i, j) = a(i - 1, j);
    end
end

subplot(1, 4, 2)
imshow(b_dequantized)
title('Imagen prediccion')

d = idct2(b_dequantized);

subplot(1, 4, 3)
imshow(uint8(b_quantized))
title('Imagen error')

subplot(1, 4, 4)
imshow(uint8(d))
title('Imagen comprimida')

mse = mean((sum(a) - sum(d)).^2);  % Corregir la variable 'd' en lugar de 'prediccion'
snr = 10 * log10((sum(a).^2) / mse);
disp(['Relación de compresión: ' num2str(snr)]);

disp('Fin del proceso')