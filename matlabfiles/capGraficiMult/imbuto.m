%% Costruzione grafico ad imbuto
X = readtable("grafuniv2serie.xlsx",'Sheet','dati','ReadRowNames',true);
funnelchart(X);
% print -depsc imbuto.eps;