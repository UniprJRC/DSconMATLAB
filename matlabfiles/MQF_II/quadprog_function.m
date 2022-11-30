%% ESEMPIO DI PROBLEMA DI PROGRAMMAZIONE QUADRATICA
clear; clc;
Q = [ 1, -.5;
    -.5,   1];      % parte quadratica della funzione obiettivo
H=2*Q; % moltiplichiamo per due
f = [-2; -6];        % parte lineare della funzione obiettivo
A = [ 1, 1;
     -1, 2;
      2, 1];
b = [2; 2; 3];
l_b = zeros(length(f),1);
[x_asterisco,f_value] = quadprog(H,f,A,b,[],[],l_b,[]);
f_x_asterisco=x_asterisco'*Q*x_asterisco+f'*x_asterisco; % minimo della 
%funzione obiettivo