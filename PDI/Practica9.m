clc
clear all
close all
warning off all

[archivo, ruta] = uigetfile('*.*', 'Select the file');
if isequal(archivo, 0)
    disp('No se seleccionó ninguna imagen.');
end

fid = fopen(fullfile(ruta, archivo));
ftell(fid);
tline1 = fgetl(fid);

% Calcular las probabilidades de aparición de símbolos en el archivo
sym_dict = unique(tline1);
In_s = sym_dict;
for k1 = 1:length(sym_dict)
    prob(k1) = (sum(tline1 == sym_dict(k1))) / length(tline1);
end

[z, i] = sort(prob, 'ascend');
sort_u = cell(length(sym_dict), 1);
In_p = z;
org_len = length(In_p);
ind = 1;
len_tr = org_len;
pos_tr = 0;
total_array(ind, :) = In_p;
append1 = [];
lp_j = 1;

operationFile = fopen('operaciones.txt', 'w');

% Realizar el proceso de construcción del árbol de Huffman
while (ind < org_len - 1)
    firstsum = In_p(lp_j) + In_p(lp_j + 1);

    fprintf(operationFile, 'Operación %d:\n', ind);
    fprintf(operationFile, '%f\n', firstsum);
    fprintf(operationFile, '%s\n', mat2str(In_p));

    append1 = [append1, firstsum];
    In_p = [In_p((lp_j + 2):length(In_p)), firstsum];
    In_p = sort(In_p);
    ind = ind + 1;
    total_array(ind, :) = [In_p, zeros(1, org_len - length(In_p))];
    len_tr = [len_tr, length(In_p)];

    for j = 1:length(In_p)
        if (In_p(j) == firstsum)
            pos = j;
        end
    end
    pos_tr = [pos, pos_tr];

end

% Crear una matriz de códigos de Huffman
main_arr = total_array';

code = cell(org_len, org_len - 1);
col = org_len - 1;
row = 1;

% Asignar códigos iniciales
code{row, col} = '0';
code{row + 1, col} = '1';

% Generar códigos de Huffman
while col ~= 1
    i = 1;
    x = 1;
    z = 0;

    if (main_arr(row, col - 1) + main_arr(row + 1, col - 1)) == main_arr(row, col)
        code{row, col - 1} = [code{row, col}, '0'];
        code{row + 1, col - 1} = [code{row, col}, '1'];

        while ~isempty(code{row + i, col})
            code{row + 1 + i, col - 1} = code{row + i, col};
            i = i + 1;
        end
    else
        code{row, col - 1} = [code{row + 1, col}, '0'];
        code{row + 1, col - 1} = [code{row + 1, col}, '1'];

        while ~isempty(code{row + x, col})
            code{row + 1 + x, col - 1} = code{row + z, col};
            x = x + 1;
            z = z + 2;
        end
    end

    col = col - 1;
end

codigosFile = fopen('codigos_huffman.txt', 'w');

% Guardar los códigos de Huffman en el archivo
fprintf(codigosFile, 'Códigos de Huffman:\n');
for k = 1:org_len
    fprintf(codigosFile, '%s:\n', sort_u{k});
    
    col = org_len - 1;
    while col >= 1
        fprintf(codigosFile, '%s ', code{k, col});
        col = col - 1;
    end
    
    fprintf(codigosFile, '\n');
end

fclose(codigosFile);
fclose(operationFile);

longitud_original = length(tline1);

longitud_media = 0;
for k = 1:org_len
    longitud_media = longitud_media + prob(k) * length(code{k, org_len - 1});
end

original_data_bits = 8 * longitud_original;  % Assuming 8 bits per character
compressed_data_bits = 8 * longitud_media;
efficiency = (1 - (compressed_data_bits / original_data_bits)) * 100;

fprintf('Original Length: %d bits\n', original_data_bits);
fprintf('Compressed Length: %d bits\n', compressed_data_bits);
fprintf('Efficiency: %.2f%%\n', efficiency);