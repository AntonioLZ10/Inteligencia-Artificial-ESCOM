clc
clear all
close all
warning off all

a = imread("peppers.png");


grises=rgb2gray(a);
grises2=cat(3, grises, grises, grises);

verde=a;
verde(:,:,1)=0;
verde(:,:,2);
verde(:,:,3)=0;

roja=a;
roja(:,:,1);
roja(:,:,2)=0;
roja(:,:,3)=0;

magenta=a;
magenta(:,:,1);
magenta(:,:,2)=0;
magenta(:,:,3);

figure;
imagenes=[grises2 roja; verde magenta]
imshow(imagenes)


