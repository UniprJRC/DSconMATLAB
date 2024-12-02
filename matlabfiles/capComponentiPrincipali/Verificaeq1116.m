%% Verifica equazione 11.16
rng(10)
n=50;
% Genero una matrice di rango 4
X=[randn(n,3) ones(n,7)];
p=size(X,2);
r=rank(X);
disp(['Dimensioni X: ' num2str(n) 'x' num2str(p)])
disp(['Rango della matrice X=' num2str(r)])
% w = vettore dei pesi
w=rand(n,1);
% meX = vettore 1xp che contiene le medie pesate
meX=sum(X.*w);
% Dr = matrice diag con pesi delle righe sulla
% diagonale
Dr=diag(w);
% Xtilde = matrice degli scostamenti dalla media
Xtilde=X-meX;
% S = matrice di covarianze
S=Xtilde'*Dr*Xtilde/sum(w);
% Dc = matrice diagonale con Var(X_j) sulla diagonale
Dc=diag(diag(S));
% Dcminus1 inversa di Dc
Dcminus1=Dc^-(1);
totsum=0;
for i=1:n
    xitilde=Xtilde(i,:)';
    totsum=totsum+w(i)*xitilde'*Dcminus1*xitilde;
end
disp(['\sum Dist Mahalanobis^2 w_i=' num2str(totsum)])
% Z = matrice degli scostamenti standardizzati ponderati
Z=Dr^(1/2)*Xtilde*Dc^(-1/2);
disp(['tr(Z''Z)=' num2str(trace(Z'*Z))]);
disp(['sum_ij z_ij^2='  num2str(sum(Z.^2,'all'))])
% svd di Z
[U,Gamma,V]=svd(Z,'econ');
% Somma dei quadrati dei valori singolari
% La matrice Gamma ha solo 4 valori singolari diversi da 0
sumgamsquared=sum(diag(Gamma(1:r,1:r)^2));
disp(['sum_l gamma_l^2=' num2str(sumgamsquared)])
disp(['p*sum(w)=' num2str(p*sum(w))])
