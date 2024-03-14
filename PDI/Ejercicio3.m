clc
clear all
close all
warning off all

c1=[0 1 1 1; 0 0 0 1; 0 0 1 0;];
c2=[0 0 0 1; 0 1 1 1; 1 0 1 1;];
x1 = [0 1];
y1 = [0 1];
z1 = [0 1];

inst1 = "Ingresa x: ";
x = input(inst1);
inst2 = "Ingresa y: ";
y = input(inst2);
inst3 = "Ingresa z: ";
z = input(inst3);

figure(2)

%plot3(desconocido(x,:),desconocido(y,:),desconocido(z,:), 'ro','MarkerSize',10,'MarkerFaceColor','r')
plot3(c1(1,:),c1(2,:),c1(3,:), 'ko','MarkerSize',10,'MarkerFaceColor','w')
grid on
hold on
plot3(c2(1,:),c2(2,:),c2(3,:), 'k*','MarkerSize',10,'MarkerFaceColor','k')
plot3(x1,y1,z1, 'k', 'LineWidth', 2);

legend('Clase 1','Clase 2','Punto medio')


desconocido = [x, y, z]

if (x > 1 || y > 1 || z > 1 || x < 0 || y < 0 || z < 0)
    disp('Vector invalido')
else
    media1=mean(c1,2)
    media2=mean(c2,2)

    dist1=norm(desconocido-media1)
    dist2=norm(desconocido-media2)

    dist_tot=[dist1 dist2]
    minimo=min(min(dist_tot))
    dato=find(dist_tot==minimo)

    fprintf('El valor desconocido pertenece a la clase %d\n',dato)
end