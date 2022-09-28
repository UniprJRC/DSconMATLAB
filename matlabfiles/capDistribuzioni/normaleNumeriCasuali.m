% Estrazione di n numeri da N(6,100)
% Fisso un determinato seed di numeri casuali. 
seed=12345; 
rng(seed)
n=10000;
p=1;
sigma=10;
mu=6;
X=sigma*randn(n,p)+mu;
% reinizializzo il generatore di numeri casuali
rng(seed)
X1=normrnd(mu,sigma,n,p);
assert(isequal(X,X1),"I numeri casuali sono diversi")
histogram(X)
title(['Generazione di ' num2str(n) ' numeri da N(' ...
    num2str(mu) ',' num2str(sigma^2) ')'])

% print -depsc figs\normrand.eps;
