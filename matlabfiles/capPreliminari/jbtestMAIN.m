n=100;
x=rand(n,1);
% Calcolo manuale JBSTAT
z = zscore(x,1); 

% Osservazione: (non inserita nel libro di testo) la chiamata a zscore è
% con il secondo argomento settato a 1, cioè la standard deviation che
% viene utilizzata per calcolare lo scostamento standardizzato ha come
% denominatore n anziché n-1 (v. la definizione di z_i a p. 219 sotto
% l'equazione (6.1)

AS = sum(z.^3)/n;
KU = sum(z.^4)/n - 3;
jbstatM = n*(AS^2/6 + KU^2/24);
% Calcolo del 
pvalAS=chi2cdf(jbstatM,2,"upper");
% Calcolo tramite chiamata alla funzione jbtest
[~,~,jbstat]=jbtest(x);
% Verifica uguaglianza del test 
dif=max([abs(jbstatM-jbstat)]);
assert(dif<1e-15,"Implentazione manuale del test incorretta")
