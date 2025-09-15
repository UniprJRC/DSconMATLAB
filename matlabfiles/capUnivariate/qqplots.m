% Parte preliminare di caricamento dati
miofile="Firm.xlsx"; % Caricamento file Firm.xlsx dentro MATLAB 
X=readtable(miofile,"ReadRowNames",true);

%% Confronto quantili empirici con quelli della N(0,1)
n=10000;
% xnorm= dati generati da un N con media 5678
% e sigma 1234
xnorm=randn(n,1)*1234+5678;
% nu = gradi di libertà
nu=5;
% xstudentt dati generati da T(5)
xstudentt=trnd(nu,n,1);
subplot(2,2,1)
qqplot(xnorm);
title('qqplot con numeri casuali da N(\mu,\sigma)')
subplot(2,2,2)
qqplot(xstudentt);
title('qqplot con numeri casuali da T(5)')
subplot(2,2,3:4)
qqplot(X.Wage);
title('qqplot della variabile Wage')
% print -depsc qqplot.eps;

%% Messaggio per i "newcomers"
disp('Welcome to the third edition of the book') 
disp('CONGRATULATIONS AND ENJOY!')
