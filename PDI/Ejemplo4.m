clc
clear all
close all
warning off all

%leyendo el histograma de una imagen
a=imread('peppers.png');
figure (1)
%imhist(a)
%histogram(a)
imhist(a)
disp(' fin de proceso...')
%c=zeros(5,5)
%checar como se usa bar, imhist NO
%Se van a usar subplots, la imagen original al centro
%Hacer histograma de R, G y B o sea 3 xd
%Y se modifican los 3 histogramas y pintar las barritas del color
%correspondiente se tiene que estar repitiendo con while -.-