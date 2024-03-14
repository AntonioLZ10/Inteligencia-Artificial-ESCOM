clc
clear all
close all
warning off all

figure(1)
%h=imread('obj1_2-213.jpg');
h=imread('peppers.png');
[m,n]=size(h);
imshow(h)

figure(2)
dato=imref2d(size(h))% imref2d cambia cood del plano a coord de imagen
imshow(h,dato)

%% seleccionando las clases presentes en la imagen

c1x=randi([1,502],1,100);
c1y=randi([1,110],1,100);
c1=[c1x;c1y];

c2x=randi([1,502],1,100);
c2y=randi([115,160],1,100);
c2=[c2x;c2y];

c3x=randi([250,450],1,100);
c3y=randi([160,310],1,100);
c3=[c3x;c3y];

px=input('dame la coord del punto en x= ')
py=input('dame la coord del punto en y= ')

punto=[px;py];



%graficando sobre el plano de la imagen en coord pixelares
z1=impixel(h,c1x(1,:),c1y(1,:))
z2=impixel(h,c2x(1,:),c2y(1,:))
z3=impixel(h,c3x(1,:),c3y(1,:))
p1=impixel(h, px(1,:),py(1,:))



grid on
hold on
plot(c1x(1,:),c1y(1,:),'ro','MarkerSize',10,'MarkerFaceColor','r')
plot(c2x(1,:),c2y(1,:),'go','MarkerSize',10,'MarkerFaceColor','g')
plot(c3x(1,:),c3y(1,:),'yo','MarkerSize',10,'MarkerFaceColor','y')
plot(punto(1,:),punto(2,:),'mo','MarkerSize',10,'MarkerFaceColor','m')



legend('cielo','agua','roca', 'punto')

media1=mean(c1,2)
media2=mean(c2,2)
media3=mean(c3,2)

dist1=norm(c1-punto)
dist2=norm(c2-punto)
dist3=norm(c3-punto)

dist_total=[dist1 dist2 dist3]
minimo=min(min(dist_total))
dato=find(dist_total==minimo)
fprintf('el vector desconocido pertenece a la clase %d\n',dato)
disp(' fin de proceso..')