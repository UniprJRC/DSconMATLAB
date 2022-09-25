%% Studio della densità della v.c. Chi2 al variare dei gradi di libertà
x=0:0.1:30;
for j=1:20
    subplot(4,5,j)
    denschi2=chi2pdf(x,j);
    plot(x,denschi2)
    title(['$\chi^2(' num2str(j) ')$'],'Interpreter','latex')
    xlim([0 30])
end

%% Funzione di densità ripartizione e quantili di una \chi^2

nu=12;
% Prob X^2<b
b=11.3;
probMinore11e3=chi2cdf(b,nu);
disp(['Pr (chi2(12) <' num2str(b) ') = ' num2str(probMinore11e3)])
% Prob (a< X^2<b)
a=10;
b=11;
disp(['Pr(' num2str(a)  '< chi2(12) <' num2str(b) ') = ' ...
    num2str(chi2cdf(b,nu)-chi2cdf(a,nu))])

% Prob X^2(12)>b
b=20;
disp(['Pr ( chi2(12) >' num2str(b) ') = ' num2str(1-chi2cdf(b,nu)) ])

% quantile 0.9
disp(['Quantile 0.9 in una chi2(12) =' num2str(chi2inv(0.9,nu))])

%% Estrazione numeri casuali da una chi^2 (nu)
% Fisso un seed per la replicatibilità dei risultati
rng(100)
n=1000000;
y=chi2rnd(12,n,1);
disp('---------------')
% Frequenza relativa empirica di valori inferiori a 11.3
freqrelMinore11e3=sum(y<11.3)/n;
disp(['Frequenza relativa empirica di valori inferiori a 11.3=' num2str(freqrelMinore11e3)])

% Frequenza relativa empirica di valori compresi tra 10 e 11
freqrel=length(y(y>10 & y<11))/n;
disp(['Frequenza relativa empirica di valori compresi tra 10 e 11=' num2str(freqrel)])

% Frequenza relativa empirica di valori superiori a 20
freqrel1=sum(y>20)/n;
disp(['Frequenza relativa empirica di valori superiori a 20=' num2str(freqrel1)])

% Calcolo del quantile empirico 0.9
quanrequested=prctile(y,90);
disp(['Quantile empirico 0.9 =' num2str(quanrequested)])

% print -depsc figs\chi2.eps;
