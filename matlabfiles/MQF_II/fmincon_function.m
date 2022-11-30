%% ESEMPIO DI PROBLEMA DI PROGRAMMAZIONE QUADRATICA CON fmincon
Q = [ 1, -.5;
    -.5,   1];      % parte quadratica della funzione obiettivo

c = [-2,-6];        % parte lineare della funzione obiettivo

fun = @(x) x'*Q*x+c*x; % funzione da minimizzare

A = [ 1, 1;
     -1, 2;
      2, 1];
b = [2; 2; 3];
l_b = zeros(length(c),1);


[x_asterisco, f_value] = fmincon(fun,[.5 .5]',A,b,[],[],l_b,[]); 
f_x_asterisco=x_asterisco'*Q*x_asterisco+c*x_asterisco; % minimo della 
%funzione obiettivo