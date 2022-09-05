% Sezione: generazione di numeri casuali

rng(234)
n=1000;
mu=[2 5];
sigma12=1.6;
Sigma=[ 3,sigma12; sigma12 , 1.5]; 
X=mvnrnd(mu,Sigma,n);
scatterboxplot(X(:,1),X(:,2))
title('1000 realizzazioni da una distrib. normale bivariata')

 % print -depsc figs\normbiv.eps;