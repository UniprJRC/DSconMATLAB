% meshgrid(1:3) costruisce tutte le possibili combinazioni delle
% coppie di numeri 1:3 1:3
% ad esempio (1,1) (2,1) (3,1) (1,2) ... (3,3)
% 
% [x,y]=meshgrid(1:3)
% 
% x =
% 
%           1.00          2.00          3.00
%           1.00          2.00          3.00
%           1.00          2.00          3.00
% 
% 
% y =
% 
%           1.00          1.00          1.00
%           2.00          2.00          2.00
%           3.00          3.00          3.00


%% meshgrid costruisce il reticolato (griglia)
[x,y]=meshgrid(-2:0.1:2);
% Calcolo la funzione z
z=exp(-x.^2-y.^2);
% Rappresentazione della funzione z nel reticolato
mesh(x,y,z)
% print -depsc figs\bivnormKernel.eps;
