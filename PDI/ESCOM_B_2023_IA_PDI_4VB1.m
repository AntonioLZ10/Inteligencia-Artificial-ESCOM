clc %limpia pantalla
close all %cierra todo
clear all %limpia todo
warning off all %evita las advertencias

%%%%%
%LEYENDO MI PRIMER IMAGEN

%%
a=imread('peppers.png'); %imread es para leer imagen
figure(1)
%imshow(a)%imshow es para desplegar en pantalla dicha imagen

% figure(2)
% grises=rgb2gray(a);
% imshow(grises)
% 
% figure(3)
% b_negro=im2bw(a);
% imshow(b_n )

subplot(2,3,1)
imshow(a)
title('original')
subplot(2,3,2)
grises=rgb2gray(a);
imshow(grises)
title('GRISES')
subplot(2,3,3)
b_negro=im2bw(grises);
imshow(b_negro)
title('binaria')

roja=a;
subplot(2,3,4)
roja(:,:,1);
roja(:,:,2)=0;
roja(:,:,3)=0;
imshow(roja)
title('ROJA')

verde=a;
subplot(2,3,5)
verde(:,:,1)=0;
verde(:,:,2);
verde(:,:,3)=0;
imshow(verde)
title('VERDE')

AZUL=a;
subplot(2,3,6)
AZUL(:,:,1)=0;
AZUL(:,:,2)=0;
AZUL(:,:,3);
imshow(AZUL)
title('AZUL')


figure(2)
arreglo=[a roja;verde AZUL];
imshow(arreglo)



disp('fin de programa')