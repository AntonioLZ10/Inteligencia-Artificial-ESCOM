clc
clear all
close all
warning off all

% Leyendo el histograma de una imagen
a = imread('peppers.png');
[alto, ancho, ~] = size(a);

nc = input('Ingresa la cantidad de clases: ');
ne = input('Ingresa la cantidad de elementos: ');

colores = {'r', 'g', 'b', 'c', 'm', 'y', 'k'};

figure(1)
imshow(a);
grid on
hold on

clasex = zeros(nc, ne);
clasey = zeros(nc, ne);
coordenadas_x = cell(1, nc);
coordenadas_y = cell(1, nc);
leyendas = cell(1, nc);  % Matriz para almacenar nombres de clases y colores
puntos = zeros(nc, 2);  % Store all the points
sigma = zeros(nc);
p=pi;

for i = 1:nc
    if i <= length(colores)
        color = colores{i};
    else
        color = rand(1, 3);  % Color aleatorio si se agotan los colores predefinidos
    end
    
    % Permite al usuario hacer clic en la imagen para seleccionar el punto
    fprintf('Haz clic en un punto dentro de la Clase %d\n', i);
    puntos = ginput(1);

    cx = (randn(1, ne) * 20 + puntos(1));
    cy = (randn(1, ne) * 20 + puntos(2));

    coordenadas_x{i} = puntos(1);
    coordenadas_y{i} = puntos(2);
    
    clasex(i, :) = puntos(1);
    clasey(i, :) = puntos(2);
    clases{i} = [clasex(i, :); clasey(i, :)];

    plot(cx, cy, 'Marker', 'o', 'LineStyle', 'none', 'MarkerEdgeColor', color, 'MarkerSize', 10);
    leyendas{i} = ['Clase ' num2str(i)];  % Almacena los nombres de las clases y colores
end

% Crea la leyenda después de haber dibujado todos los puntos
legend(leyendas);

promedios_x = mean(clasex, 2);
promedios_y = mean(clasey, 2);

continuar = true;

while continuar
    desconocido = ginput(1);
    desconocidox = desconocido(1);
    desconocidoy = desconocido(2);    
    
    plot(desconocido(1), desconocido(2), 'k*', 'MarkerEdgeColor', 'k', 'MarkerSize', 10);

    dist = zeros(1, nc);

    opcion = input("¿Cómo deseas calcular su distancia?\n1) Distancia de Mahalanobis\n2) Distancia Euclidiana\n3) Maxima Probabilidad\n4) KNN\n");
    
    if (opcion == 1)
        min_distance = Inf;
        min_index = 0;
        
        for k = 1:nc
            x_values = cell2mat(coordenadas_x);
            y_values = cell2mat(coordenadas_y);            
            % Calculate Mahalanobis distance
            delta = [desconocidox - coordenadas_x{k}; desconocidoy - coordenadas_y{k}];
            sigma_inv = inv(cov([x_values; y_values]'));
            current_distance = sqrt(delta' * sigma_inv * delta);
            
            % Check if the current distance is smaller than the minimum
            if current_distance < min_distance
                min_distance = current_distance;
                min_index = k;
            end
        end
        fprintf('\nEl punto desconocido pertenece a la clase %d.\n', min_index);
        fprintf('La distancia entre ambos es %.2f.\n', min_distance);
    end
    if (opcion == 2)
        % Obtener los valores RGB de la clase actual
        color_clase = double(a(round(coordenadas_y{i}), round(coordenadas_x{i}), :));
        
        % Obtener los valores RGB del punto desconocido
        color_desconocido = double(a(round(desconocido(2)), round(desconocido(1)), :));
        
        % Calcular la distancia euclidiana en el espacio RGB
        dist(i) = sqrt(sum((color_clase - color_desconocido).^2));
        
        fprintf('Distancia entre el punto desconocido y la Clase %d: %.2f\n', i, dist(i));
        [~, clase_pertenece] = min(dist);
        fprintf('\nEl punto desconocido pertenece a la Clase %d\n', clase_pertenece);
    end
    if (opcion == 3)
        % Maximum Probability calculation
        max_prob = 0;
        max_class = 0;
        x_values = cell2mat(coordenadas_x);
        y_values = cell2mat(coordenadas_y);
        probas=zeros(nc);
        color_desconocido = double(a(round(desconocido(2)), round(desconocido(1)), :));
        
        for k = 1:nc
            % Get RGB values for the current class
            color_clase = double(a(round(coordenadas_y{k}), round(coordenadas_x{k}), :));
            r_values = color_clase(1);
            g_values = color_clase(2);
            b_values = color_clase(3);
            % Calculate Euclidean distance in RGB space
            distance = sqrt(sum((color_desconocido - color_clase).^2));
        
            % Calculate probability using Gaussian distribution
            probas(k) = exp(-0.5 * distance) / sqrt((2 * pi)^3);
        
        
            % Update max probability and class
            if probas(k) > max_prob
                max_prob = probas(k);
                max_class = k;
            end
        end
        probas_normalized = probas / sum(probas)*100;
        max_prob=max(probas_normalized);
        % Display results
        fprintf('\nEl punto desconocido pertenece a la clase %d.\n', max_class);
        fprintf('La probabilidad es %4f.%\n', max_prob);
    end
if (opcion == 4)
    k = input('Introduce el valor de k para KNN: ');
    distances = zeros(nc, 1);
    desconocido_rgb = double(a(round(desconocidoy), round(desconocidox), :));
    for j = 1:nc
        % Obtener los valores RGB de la clase actual
        color_clase = double(a(round(coordenadas_y{j}), round(coordenadas_x{j}), :));
        
        % Calcular la diferencia en cada componente de color entre el punto desconocido y la clase actual
        delta_R = desconocido_rgb(:,:,1) - color_clase(:,:,1);
        delta_G = desconocido_rgb(:,:,2) - color_clase(:,:,2);
        delta_B = desconocido_rgb(:,:,3) - color_clase(:,:,3);
        
        % Calcular la distancia euclidiana en el espacio RGB para cada clase
        distances(j) = sqrt(delta_R.^2 + delta_G.^2 + delta_B.^2);
    end
    [~, indices] = sort(distances);
    nearest_classes = indices(1:k);
    fprintf('Las clases más cercanas al punto desconocido son: %s\n', num2str(nearest_classes));
end




    inst3 = "¿Quiere seleccionar un nuevo pixel de la imagen?\n1) Sí\n2) No\n";
    op = input(inst3, 's'); % 's' para leer la entrada como una cadena

    if op == '2'
        close;
        continuar = false; % Si el usuario ingresa '2', detén el bucle
    elseif op == '1'
        % Permite al usuario seleccionar un nuevo pixel de la imagen
        % Muestra la imagen y espera a que el usuario haga clic en un pixel
        figure(1); % Asegúrate de mostrar la imagen original
        continue; % Continúa el bucle para que el usuario pueda seleccionar otro píxel
    end
end