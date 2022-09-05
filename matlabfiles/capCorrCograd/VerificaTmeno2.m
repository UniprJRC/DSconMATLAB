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
 

