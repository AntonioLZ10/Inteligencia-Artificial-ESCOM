clc
clear all
close all
warning off all

figure(1)
a=imread('peppers.png');
imshow(a)

figure(2)
clases=impixel(a)
 clase1=clases(1:3,:);
 clase1=clase1'

 clase2=clases(4:6,:);
 clase2=clase2'

 clase3=clases(7:9,:);
 clase3=clase3'

 desconocido=clases(10,:);
 desconocido=desconocido'

 media1=mean(clase1,2);
 media2=mean(clase2,2);
 media3=mean(clase3,2);

 dist1=norm(desconocido-media1)
 dist2=norm(desconocido-media2)
 dist3=norm(desconocido-media3)

 dist_tot=[dist1 dist2 dist3]
 minimo=min(min(dist_tot))
 dato=find(dist_tot==minimo)
fprintf(' el valor desconocido pertenece a la clase%d\n',dato)

%%Graficcando los puntos extraidos de la imagen
figure(3)
plot3(clase1(1,:),clase1(2,:), clase1(3,:), 'ro','MarkerEdgeColor','r','Markersize',10)%Grafica en 3D
grid on
hold on%%Mantener el valor
plot3(clase2(1,:),clase2(2,:), clase2(3,:), 'go','MarkerEdgeColor','g','Markersize',10)
plot3(clase3(1,:),clase3(2,:), clase3(3,:), 'bo','MarkerEdgeColor','b','Markersize',10)
plot3(desconocido(1,:),desconocido(2,:), desconocido(3,:), 'k*','MarkerEdgeColor','k','Markersize',10)
legend('clase1', 'clase2', 'clase3', 'desconocido')

disp('fin')
