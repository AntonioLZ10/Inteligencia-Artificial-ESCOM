clc
clear all
close all
warning off all

% Señal 7: Sonido - Intensidad, tiempo (tono, timbre)
% Generar datos de ejemplo
tiempo = 0:0.01:5; % Ejemplo de tiempo
intensidad = sin(2*pi*1*tiempo) .* exp(-0.5*tiempo); % Ejemplo de intensidad

% Señal 9: Calidad de aire - Densidad de contaminantes y aire - Flujo
% Generar datos de ejemplo
densidad_contaminantes = randn(size(tiempo)); % Ejemplo de densidad de contaminantes
flujo_aire = 0.5*tiempo.^2; % Ejemplo de flujo de aire

% Señal 10: Sobrepoblación - Densidad de población y disminución de calidad de vida
% Generar datos de ejemplo
densidad_poblacion = 1000./(1 + exp(-0.5*(tiempo-2))); % Ejemplo de densidad de población
calidad_vida = 1./(1 + exp(-0.3*(tiempo-2))); % Ejemplo de calidad de vida

% Plotear las señales en una figura con subplot
figure;

% Subplot 1: Sonido - Intensidad vs Tiempo
subplot(3,1,1);
plot(tiempo, intensidad, 'b');
title('Sonido - Intensidad vs Tiempo');
xlabel('Tiempo');
ylabel('Intensidad');

% Subplot 2: Calidad de aire - Densidad de contaminantes vs Flujo de aire
subplot(3,1,2);
plot(tiempo, densidad_contaminantes, 'r', tiempo, flujo_aire, 'g');
title('Calidad de aire');
xlabel('Tiempo');
ylabel('Densidad/Flujo');

legend('Densidad de contaminantes', 'Flujo de aire');

% Subplot 3: Sobrepoblación - Densidad de población vs Calidad de vida
subplot(3,1,3);
plot(tiempo, densidad_poblacion, 'm', tiempo, calidad_vida, 'c');
title('Sobrepoblación');
xlabel('Tiempo');
ylabel('Densidad/Calidad de vida');

legend('Densidad de población', 'Calidad de vida');
