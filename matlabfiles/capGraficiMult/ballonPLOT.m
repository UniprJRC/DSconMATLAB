load housetasks.mat
balloonplot(housetasks);

% print -depsc balloonPLOT.eps;

%% Secondo esempio di balloonplot (non nel libro)
X = readtable("grafuniv2serie.xlsx",'Sheet','dati','ReadRowNames',true);
Xd=X{:,1:2};

figure
balloonplot(X);
title('Balloonplot')

