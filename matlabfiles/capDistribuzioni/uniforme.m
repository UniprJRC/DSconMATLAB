
%% Calcolo probabilità in una U(3, 8)
a=3;
b=8;

% la probabilità di ottenere un valore compreso tra 5 e 6 in U(3,8)
disp('--------------')
disp('P(5<X<6) in U(3, 8)')
prob56=unifcdf(6,a,b)-unifcdf(5,a,b);
disp(prob56)

%% Visualizzazione grafica della prob. calcolata

% Calcolo della densità tramite la funzione unifpdf
% Per rappresentare la densità scelgo in maniera soggettiva un intervallo x
% che parte da a-1 e arriva fino a b+1. Similmente, anche il passo della
% sequenza utilizzato (in questo caso 0.0001) è soggettivo.
x=(a-1:0.0001:b+1)';
ypdf=unifpdf(x,a,b);
plot(x,ypdf,'LineWidth',2);
ylim([0 0.25])
title(['Funzione di densità: U('  num2str(a) ',' num2str(b) ')'])

% Istruzione hold('on') per sovrapporre il grafico che segue al grafico
% precedente
hold('on')

% a = posizione dell'ultimo valore del vettore x <=5
aa=find(x<=5,1,'last');
% b= posizione del primo valore del vettore x >=6
bb=find(x>=6,1);
% Utilizza la funzione fill nell'intervallo x(a:b)
fill(x(aa:bb),[0;ypdf(aa+1:bb-1);0],'g')
ylabel(['Pr(5<X<6)=' num2str(prob56)])
% print -depsc figs\uniffill.eps;

%% Visualizzazione grafica tramite la chiamata a distribspec
pd=makedist('Uniform','Lower',a,'Upper',b);
distribspec(pd, [5 6], 'inside');
% print -depsc figs\uniffill1.eps;

%% Quantili

% quantili u0.80 e u0.90 (valori che lasciano alla destra
% una prob. di 0.20 e 0.10) in U(3, 8)
quant=[0.80 0.90];
disp('Quantili 0.8 e 0.9 in una U(3, 8)')
disp(unifinv(quant,a,b))


%% Estrazione di n numeri da U(3, 8)
% Fisso un determinato seed di numeri casuali
seed=123;
rng(seed)
n=10000;
p=1;
% rand genera valori da U(0, 1).
% Trasformo i valori generati dall'intevallo [0 1]
% all'intervallo [a b]
X=rand(n,p)*(b-a)+a;
% reinizializzo il generatore di numeri casuali
rng(seed)
X1=unifrnd(a,b,n,p);
assert(max(abs(X-X1))<1e-15,"I numeri casuali sono diversi")
figure
histogram(X,'Normalization','pdf')
title(['Generazione di ' num2str(n) ' numeri da U(' ...
    num2str(a) ',' num2str(b) ')'])

% print -depsc figs\unifrand.eps;