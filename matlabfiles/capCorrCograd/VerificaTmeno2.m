%% Dati di input
n=10;
nsimul=100000;
quant=[0.001 0.01	0.05:0.05:0.95	0.99 0.999]';

%% Calcoli richiesti
% Test = vettore di dimensione 100000-by-1 che conterrà in posizione i il test
% sul coefficiente di correlazione basato sulla simulazione i
Test=zeros(nsimul,1);
% Rall= vettore di dimensione nsimul-by-1 che contiene in posizione i il
% valore del coefficiente di correlazione per la simulazione i-esima
Rall=zeros(nsimul,1);
for i=1:nsimul
    % Per ogni simulazione vengono generate due variabili indipendenti di
    % dimensione nx1 da una distribuzione normale standardizzata
    x=randn(n,1);
    y=randn(n,1);
    % Per ogni simulazione si calcola il coefficiente di correlazione
    % lineare
    r=corr(x,y);

    % Inserisco il valore del test per la simulazione i nella riga i del
    % vettore Test
    Test(i)=(r/sqrt(1-r^2))*sqrt(n-2);
    % Inserisco il valore del coefficiente di correlazione per la
    % simulazione i nella riga i del vettore Rall
    Rall(i)=r;
end
% Testsor = valori ordinati dei coefficienti di correlazione campionari
Testsor=sort(Test);


%% Questa sezione non è nel libro
% La funzione histfit, chiamata con un solo argomento di input
% sovraimpone al grafico ad istogramma la distribuzione
% normale.
histfit(Test)
% In questo caso si può notare che la distribuzione empirica 
% è molto diversa dalla distribuzione normale

% La funzione histfit chiamata con 3 argomenti di input nel terzo argomento
% di input si può specificare quale distribuzione si vuole sovraimporrre.
% Dall'help della funzione histfit si legge che per specificare di
% sovraimporre la distribuzione T di Student occorre inserire la parola
% 'tclocationscale'
histfit(Test,[],'tlocationscale')

% La funzione fitdist fornisce una stima dei gradi di libertà della
% distribuzione dei valori contenuti dentro il vettore Test
pd=fitdist(Test,'tlocationscale')
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


%% Confronto dei quantili empirici con quelli teorici

% Empirici = calcolo dei quantili empirici
Empirici=Testsor(round(nsimul*quant));
% Calcolo dei quantili teorici utilizzando la T di student con (n-2) gradi
% di libertà
TeoriciT=tinv(quant,n-2);
% disp('Confronto tra quantili empirici e quantili teorici')
% disp([quant Empirici TeoriciT]);

subplot(1,2,1)
% Confronto tra quantili empirici e quantili teorici in maniera grafica
plot(Empirici,TeoriciT)
xlabel('Quantili empirici')
ylabel('Quantili teorici della T(n-2)')


% Confronto dei quantili empirici con quelli teorici della N(0,1)
subplot(1,2,2)
TeoriciN=norminv(quant);
% Confronto tra quantili empirici e quantili teorici in maniera grafica
plot(Empirici,TeoriciN)
xlabel('Quantili empirici')
ylabel('Quantili teorici N(0,1)')

%% P values empirici e teorici
% 1) ipotesi alternativa bilaterale H_1: rho <> 0 (rho diverso da zero)
pvalEmpiricoH1bil=sum(abs(Test)>2.6)/nsimul;
pvalTeoricoH1bil=tcdf(abs(-2.6),n-2,'upper')*2;
disp(['p-value teorico calcolato tramite la distribuzione T(n-2) ' ...
    'H_1: rho <> 0 ed empirico'])
disp([pvalTeoricoH1bil pvalEmpiricoH1bil])

% 2) ipotesi alternativa unilaterale destra H_1: rho > 0
pvalEmpiricoH1dx=sum(Test>-2.6)/nsimul;
pvalTeoricoH1dx=tcdf(-2.6,n-2,'upper');
disp(['p-value teorico calcolato tramite la distribuzione T(n-2) ' ...
    'H_1: rho > 0 ed empirico'])
disp([pvalTeoricoH1dx pvalEmpiricoH1dx])

% 3) ipotesi alternativa unilaterale sinistra. H_1: rho < 0
pvalEmpiricoH1sx=sum(Test<-2.6)/nsimul;
pvalTeoricoH1sx=tcdf(-2.6,n-2);
disp(['p-value teorico calcolato tramite la distribuzione T(n-2) ' ...
    'H_1: rho < 0 ed empirico'])
disp([pvalTeoricoH1sx pvalEmpiricoH1sx])

% print -depsc figs\quantEmpTheoTestRho.eps;
 

