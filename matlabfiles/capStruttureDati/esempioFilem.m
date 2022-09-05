% Disegnare una v.a. normale con i seguenti parametri.

%% Parametri della v.a.
mu = 0; 
sigma = 1;

%% dominio della v.a.
x = -4:0.1:4; 

% trova le Y della funzione di densità
Y = normpdf(x,mu,sigma); 

%% grafico
plot(x, Y,'LineWidth',2);