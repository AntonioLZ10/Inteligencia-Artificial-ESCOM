clc
close all
clear all
warning off all

inst1 = "Indique el número de clases a crear: ";
c = input(inst1); % c = Cantidad de clases

inst2 = "Indique la cantidad de representantes por clase: ";
r = input(inst2); % r = Cantidad de representantes

fin = (r * c) + 1; % fin nos indica a partir de donde existe el pixel desconocido

a = imread('peppers.png');
%figure(1)
imshow(a)

%figure(2)
clases = impixel(a);

clase = cell(1, c);

clase{1} = clases(1:r, :);
disp('Clase 1')
disp(clase{1});

for n = 2:c
    clase{n} = clases(((r * (n - 1)) + 1):(r * n), :);
    clase{n} = clase{n}';
    fprintf('Clase %d\n', n);
    disp(clase{n});
end

% Determina el "desconocido" inicial
desconocido = clases(fin, :);
desconocido = desconocido';

continuar = true; % Variable que controla si se debe continuar generando desconocidos

while continuar
    media = cell(1, c);

    for x = 1:c
        media{x} = mean(clase{x}, 2);
        fprintf('Media de Clase %d\n', x);
        disp(media{x});
    end

    dist = cell(1, c);

    for y = 1:c
        a=(double(desconocido));
    dist{y} = norm((a) - media{y});  % Convierte desconocido a tipo double antes de la resta
    fprintf('Distancia entre desconocido y media de Clase %d\n', y);
    disp(dist{y});
    end

    valores_minimos = cellfun(@min, dist);

    valor_minimo_total = min(valores_minimos);

    % Busca la ubicación del valor mínimo en dist
    ubicacion_minimo = find(cell2mat(dist) == valor_minimo_total);

    % Imprime el valor mínimo total
    %disp(['El valor mínimo en todos los arreglos dentro de dist es: ' num2str(valor_minimo_total)]);

    % Imprime la ubicación del valor mínimo en dist
    fprintf('El valor desconocido pertenece a la clase %d\n', ubicacion_minimo);

    % Pregunta al usuario si quiere seleccionar un nuevo pixel de la imagen
    inst3 = "¿Quiere seleccionar un nuevo pixel de la imagen?\n1) Sí\n2) No\n";
    op = input(inst3, 's'); % 's' para leer la entrada como una cadena

    if op == '2'
        continuar = false; % Si el usuario ingresa '2', detén el bucle
    elseif op == '1'
        % Permite al usuario seleccionar un nuevo pixel de la imagen
        % Muestra la imagen y espera a que el usuario haga clic en un pixel
        figure;
        imshow(a);
        [x, y] = ginput(1); % Espera a que el usuario haga clic en un pixel
        x = round(x);
        y = round(y);
        
        % Obtiene el valor del pixel seleccionado y lo asigna como el nuevo desconocido
        desconocido = squeeze(a(y, x, :))'; % Obtiene el valor RGB del pixel
        
        fprintf('Nuevo valor para desconocido: [%d %d %d]\n', desconocido(1), desconocido(2), desconocido(3));
    end

 figure(3)
plot3(clase{1}(1,:),clase{1}(2,:), clase{1}(3,:), 'ro','MarkerEdgeColor','r','Markersize',10)%Grafica en 3D
grid on
hold on%%Mantener el valor
plot3(clase{2}(1,:),clase{2}(2,:), clase{2}(3,:), 'go','MarkerEdgeColor','g','Markersize',10)
plot3(clase{3}(1,:),clase{3}(2,:), clase{3}(3,:), 'bo','MarkerEdgeColor','b','Markersize',10)
plot3(desconocido(1,:),desconocido(2,:), desconocido(3,:), 'k*','MarkerEdgeColor','k','Markersize',10)
legend('clase1', 'clase2', 'clase3', 'desconocido')
end