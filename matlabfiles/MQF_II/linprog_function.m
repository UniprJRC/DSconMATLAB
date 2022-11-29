%% ESEMPIO DI PROBLEMA DI PROGRAMMAZIONE LINEARE
clear; clc;
f = [-2, -3, -7];       % coefficienti della funzione obiettivo
A = [2, -1, 1;
     4,  2, 3;
     5,  2, 1];         % matrice dei coefficienti dei vincoli  di disuguaglianza
                        % A*x<=b
b = [20, 65, 32];
l_b = zeros(length(f),1); % vincoli di non negatività
[x_asterisco,f_valore] = linprog(f,A,b,[],[],l_b,[]);
f_x_asterisco=f*x_asterisco;% effettua la prova
