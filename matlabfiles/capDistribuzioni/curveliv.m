close all
mu = [1 2];
Sigma = [0.8 0.7;0.7 1.3];
% Precalcolo l'inversa
SigmaInv = inv(Sigma);

seqx = -15:.05:15;
seqy = -13:.05:18;
lx=length(seqx);
ly=length(seqy);
% Si inizializza la matrice Q che conterrà
% il valore della funzione in corrispondenza di ogni
% combinazione di x1 e x2
Q=zeros(lx,ly);
for i=1:lx
    for j=1:ly
        x=[seqx(i) seqy(j)]-mu;
        Q(i,j)=x*SigmaInv*x';
    end
end
contour(seqx,seqy,Q',0:20:200,'ShowText','on')
xlabel('x_1')
ylabel('x2')
% Aggiunta della barra di colore
colorbar


%%
[X,Y]=meshgrid(seqx,seqy);
% print -depsc figs\curveliv.eps;

% Si calcola la densità per ogni punto della griglia
xtilde = [X(:)-mu(1) Y(:)-mu(2)];
pdfVector =diag(xtilde*(Sigma\(xtilde')));
pdf = reshape(pdfVector,size(X));
