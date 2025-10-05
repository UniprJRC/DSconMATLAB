%% Comparison empirical and theoretical distribution
rho=0.4; n=7; nsimul=10000;

%% Distribuzione empirica (Monte Carlo) di r
Rall=zeros(nsimul,1);
mu=[0;0]; Sigma=[1 rho; rho 1]; 
for i=1:nsimul
    X=mvnrnd(mu,Sigma,n);
    Rall(i)=corr(X(:,1),X(:,2));
end
% Confronto tra le due distribuzioni
rseq=-1:0.01:1;
densrho=corrpdf(rseq,rho,n); % densità teorica
histogram(Rall,'Normalization','pdf') % densità empirica
hold("on")
plot(rseq,densrho,'LineWidth',2)
ylab=['$f(r,|\rho=$' num2str(rho), ', $n=$' num2str(n) ')'];
xlabel('$r$','Interpreter','latex'); ylabel(ylab,'Interpreter','latex')
title('Confronto tra la distribuzione empirica e teorica di r')

%% Probabilità richiesta
r=0.7; 
probTheo=corrcdf(r,rho,n,'upper');
pr=[' Pr(r>' num2str(r) '|rho='  num2str(rho) ', n=' num2str(n) ')='];
disp(['Calcolo tramite integrale' pr num2str(probTheo)])
ProbEmpirica=sum(Rall>r)/nsimul;
disp(['Calcolo empirico' pr num2str(ProbEmpirica)])
