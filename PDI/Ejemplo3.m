clc 
clear all
close all
warning off all

figure(1)
a=imread('peppers.png');
imshow(a)

figure(2)
clases=impixel(a)
clase1=clases(1:3,:)
clase2=clases(4:6,:)
clase3=clases(7:9,:)
desconocido=clases(10, :)

media1=mean(clase1,1)
media2=mean(clase2,2)
media3=mean(clase3,3)
distancia1=norm(desconocido-media1)
distancia2=norm(desconocido-media2)
distancia3=norm(desconocido-media3)
disp('fin')