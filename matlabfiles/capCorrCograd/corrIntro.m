
%% Caricamento dati
X=readtable("Firm.xlsx","ReadRowNames",true);


%% Scatter con primo argomento il nome della table e poi i nomi dei campi
% in questo caso le etichette sugli assi sono automaticamente inserite
scatter(X,"Seniority","Wage")
% print -depsc figs\scatterSenWag.eps;

%% Scatter con i nomi delle due variabili
scatter(X.Seniority,X.Wage)
xlabel("Seniority")
ylabel("Wage")


%% Scatter con graffe e nomi delle due variabili
% in questo caso le etichette sugli assi sono automaticamente inserite
scatter(X{:,"Seniority"},X{:,"Wage"})
xlabel("Seniority")
ylabel("Wage")
%% Scatter con graffe e numeri di colonna
scatter(X{:,9},X{:,6})
xlabel("Seniority")
ylabel("Wage")


%% Scatter con assi cartesiani che passano per i punti medi
% Questa sezione non è stata inserita nel libro
scatter(X{:,9},X{:,6})
medie=mean(X{:,[9 6]});
xline(medie(1))
yline(medie(2))

xlabel("Seniority")
ylabel("Wage")

%% Calcolo correlazione
rxy=corr(X.Seniority,X.Wage);
disp(rxy)

% la funzione cov ritorna la matrice di covarianze di dimensione 2x2
covMatrix=cov(X.Seniority,X.Wage);
% L'elemento 1,2 nella matrice di covarianze di dimensione 2x2 
% è la covarianza
rxychk=covMatrix(1,2)/sqrt(var(X.Seniority)*var(X.Wage));

