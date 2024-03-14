clc
clear all
close all
warning off all

a = imread('cameraman.tif');
figure(1)
subplot(1,3,1)
imshow(a)
title('Original')

b=dct2(a);
c=b-128;
subplot(1,3,2)
imshow(b)
title('Transformada')

d=idct2(b);
di=d-128;
subplot(1,3,3)
imshow(di)
title('Transformada inversa')

disp('Fin del proceso')