% meshgrid costruisce il reticolato (griglia)
[x,y]=meshgrid(-2:0.1:2);
% Calcolo la funzione z
z=exp(-x.^2-y.^2);
% Rappresentazione della funzione z nel reticolato
mesh(x,y,z)
% print -depsc figs\bivnormKernel.eps;
