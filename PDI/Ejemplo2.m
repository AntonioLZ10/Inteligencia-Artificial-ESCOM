clc
close all
clear all
warning off all

a=imread('peppers.png');
roja=a;
roja(:,:,1);
subplot(1,3,1)
imshow(roja(:,:,1))
title('grises canalrojo')

verde=a;
verde(:,:,1)=0;
verde(:,:,2);
verde(:,:,3);
subplot(1,3,2)
imshow(verde(:,:,2))
title('grises canalverde')

azul=a;
azul(:,:,1)=0;
azul(:,:,2)=0;
azul(:,:,3);
subplot(1,3,3)
imshow(azul(:,:,3))
title('grises canalverde')

subplot(2,3,5)
grises=rgb2gray(a)
imshow(grises)
title('Grises(promedio)')
disp('fin de proceso...')
