n=100;
rng(1234)
x=unifrnd(3,30,[n 1]);

[~,pvaldef,valtest]=jbtest(x);

pvalchi2=chi2cdf(valtest,2,"upper");
disp(['p-value basato sulla distr asintotica chi2=' num2str(pvalchi2)])

disp(['p-value di default=' num2str(pvaldef)])
mctol=1e-03;
[~,pval]=jbtest(x,0.05,mctol);
disp(['p-value dopo aver definito mctol=' num2str(pval)])
