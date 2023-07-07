n=100;
x=rand(n,1);
% Calcolo manuale JBSTAT
z = zscore(x,1); 
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
