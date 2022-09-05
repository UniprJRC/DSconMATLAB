close all
mu = [2 3];
Sigma=[0.25 0.3; 0.3 1];
% Precalcolo l'inversa
SigmaInv = inv(Sigma);

x1 = -15:.05:15;
x2 = -13:.05:18;
l1=length(x1);
l2=length(x2);
% Si inizializza la matrice Q che conterrà
% il valore della funzione in corrispondenza di ogni
% combinazione di x1 e x2
Q=zeros(l1,l2);
for i=1:l1
    for j=1:l2
        x=[x1(i) x2(j)]-mu;
        Q(i,j)=x*SigmaInv*x';
    end
end
contour(x1,x2,Q',0:20:200,'ShowText','on')
xlabel('x1')
ylabel('x2')
% Aggiunta della barra di colore
colorbar

% print -depsc figs\curveliv.eps;
