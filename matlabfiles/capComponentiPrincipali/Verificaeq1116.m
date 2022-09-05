%% Verifica equazione 11.16
% Per replicabilità dei risultati utilizzare rng(10).
rng(10)
n=50;
p1=3;
X=[randn(n,p1) ones(n,5)];
p=size(X,2);
r=rank(X);
disp(["Dimensioni X" string(n) "x" string(p)])
disp(["Rango della matrice X=" string(r)])
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
% Dcminus1 inverda di Dc
Dcminus1=Dc^-(1);
totsum=0;
for i=1:n
    xitilde=Xtilde(i,:)';
    totsum=totsum+w(i)*xitilde'*Dcminus1*xitilde;
end
% Z = matrice degli scostamenti standardizzati ponderati
Z=Dr^(1/2)*Xtilde*Dc^(-1/2);
disp(["tr(Z'Z)=" string(trace(Z'*Z))]);
disp(["sum z_ij^2 "  string(sum(Z.^2,'all'))])
% svd di Z
[U,Gamma,V]=svd(Z,'econ');
% somma dei qudarati dei valori singolari
% La matrice Gamma ha 4 valori singolari uguali a 0
sumgamsquared=sum(Gamma.^2,'all');
disp(["sum \gam_i^2=" sumgamsquared])
disp(["r*sum(w)=" string(p*sum(w))])
