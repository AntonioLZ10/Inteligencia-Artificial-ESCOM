clc
clear all
close all
warning off all

while true
    Histograma = zeros(5, 5);

    Histograma(1, :) = [0, 0, 2, 2, 9];
    Histograma(2, :) = [2, 5, 5, 2, 5];
    Histograma(3, :) = [3, 3, 6, 5, 5];
    Histograma(4, :) = [3, 6, 8, 5, 5];
    Histograma(5, :) = [2, 8, 8, 6, 8];

    % Convertir la matriz en un vector unidimensional
    datos = Histograma(:);

    % Crear un vector de valores únicos (0, 1, 2, ...)
    valores_unicos = unique(datos);

    % Contar cuántas veces aparece cada valor único
    frecuencias = hist(datos, valores_unicos);

    % Mostrar el histograma de frecuencias utilizando la función bar
    figure;
    bar(valores_unicos, frecuencias);

    rango_minimo = input('Introduce el valor mínimo: ');
    rango_maximo = input('Introduce el valor máximo: ');

    % Crear una nueva matriz basada en el rango definido por el usuario
    nueva_matriz = Histograma;
    nueva_matriz(nueva_matriz < rango_minimo) = rango_minimo;
    nueva_matriz(nueva_matriz > rango_maximo) = rango_maximo;

    % Mostrar el histograma de la nueva matriz utilizando la función bar
    nuevos_datos = nueva_matriz(:);
    nuevos_valores_unicos = unique(nuevos_datos);
    nuevas_frecuencias = hist(nuevos_datos, nuevos_valores_unicos);

    figure;
    bar(nuevos_valores_unicos, nuevas_frecuencias);

    repetir = input('¿Desea repetir el proceso? (1 para repetir, 0 para salir): ');
    if repetir == 0
        break;
    end
end
