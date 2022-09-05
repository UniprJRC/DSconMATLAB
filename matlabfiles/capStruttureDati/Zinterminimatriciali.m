% Generazione di X da N(0,1)
n=10;
p=5;
X=randn(n,p);
uno=ones(n,1);
% H = centering matrix. Matrice idempotente e simmetrica che consente di
% passare dalla matrice originaria alla matrice degli scostamenti
% dalla media
H=eye(n)-uno*uno'/n;
% Xtilde = matrice degli scostamenti dalla media
Xtilde=H*X;

%% Controllo tramite molt. matriciale che sum(Xtilde,1)=zeros(1,p)
assert(max(abs(uno'*Xtilde))<1e-15,"La somma degli elementi delle " + ...
    "colonne di Xtilde non è zero")

%% Matrice degli scostamenti standardizzati in maniera matriciale
sigmas=std(X);
D=diag(sigmas);
invD=D^-1;
Z=H*X*invD;

Zchk=zscore(X);
assert(max(abs(Z-Zchk),[],'all')<1e-13,"Le due implementazioni" + ...
    "differiscono")
