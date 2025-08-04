%% Dati di input
n=10; nsimul=100000; quant=[0.001 0.01	0.05:0.05:0.95	0.99 0.999]'; rng(20)
%% Studio di simulazione
Testall=zeros(nsimul,1); Rall=zeros(nsimul,1);
for i=1:nsimul
    x=randn(n,1);     y=randn(n,1);
    r=corr(x,y);
    Testall(i)=(r/sqrt(1-r^2))*sqrt(n-2);    Rall(i)=r;
end

%% Calcolo quantili empirici e teorici
Empirici=quantile(Testall,quant); % quantili empirici
TeoriciT=tinv(quant,n-2); % quantili teorici della T di student con (n-2) gdl
TeoriciN=norminv(quant);  % quantili teorici della N(0,1)

% Confronto tra quantili empirici e quantili teorici in maniera grafica
subplot(1,2,1)
plot(Empirici,TeoriciT)
xlabel('Quantili empirici'); ylabel('Quantili teorici della T(n-2)')

subplot(1,2,2)
plot(Empirici,TeoriciN)
xlabel('Quantili empirici'); ylabel('Quantili teorici N(0,1)')

%% P-values empirici e teorici
disp('H_1: rho <> 0. p-value teorico  ed empirico')
pvalEmpiricoH1bil=sum(abs(Testall)>2.6)/nsimul;
pvalTeoricoH1bil=tcdf(abs(-2.6),n-2,'upper')*2;
disp([pvalTeoricoH1bil pvalEmpiricoH1bil])

disp('H_1: rho > 0. p-value teorico  ed empirico')
pvalEmpiricoH1dx=sum(Testall>-2.6)/nsimul;
pvalTeoricoH1dx=tcdf(-2.6,n-2,'upper');
disp([pvalTeoricoH1dx pvalEmpiricoH1dx])

disp('H_1: rho < 0. p-value teorico  ed empirico')
pvalEmpiricoH1sx=sum(Testall<-2.6)/nsimul;
pvalTeoricoH1sx=tcdf(-2.6,n-2);
disp([pvalTeoricoH1sx pvalEmpiricoH1sx])

% print -depsc figs\quantEmpTheoTestRho.eps;
 

%% Questa sezione non è nel libro
subplot(1,2,1)
% La funzione histfit, chiamata con un solo argomento di input
% sovraimpone al grafico ad istogramma la distribuzione
% normale.
histfit(Testall)
% In questo caso si può notare che la distribuzione empirica 
% è molto diversa dalla distribuzione normale
subplot(1,2,2)
% La funzione histfit chiamata con 3 argomenti di input nel terzo argomento
% di input si può specificare quale distribuzione si vuole sovraimporrre.
% Dall'help della funzione histfit si legge che per specificare di
% sovraimporre la distribuzione T di Student occorre inserire la parola
% 'tclocationscale'
histfit(Testall,[],'tlocationscale')

% La funzione fitdist fornisce una stima dei gradi di libertà della
% distribuzione dei valori contenuti dentro il vettore Test
pd=fitdist(Testall,'tlocationscale')
% L'output di seguito che il valore stimato del parametro di location della
% T di Student è 0.0030691. L'intervallo di confidenza contiene il valore 0.
% Il valore stimato del parametro di scala
% (dispersione) è 1.00075. L'intervallo di confidenza contiene il valore 1.
% I gradi di libertà stimati sono molto vicini ad 8. L'unico valore intero
% contenuto nell'intervallo di confidenza di nu è 8.
%  t Location-Scale distribution
%        mu = 0.0030691   [-0.00378487, 0.00992307]
%     sigma =   1.00075   [0.993558, 1.00799]
%        nu =   8.05123   [7.69018, 8.42923]
% I valori che trovata ovviamente saranno leggermente diversi da quelli
% sopra anche se molto vicini
%
% Morale della storia: i numeri contenuti nel vettore Test sono stati
% generati da una distribuzione T di Student con n-2 gradi di libertà!

