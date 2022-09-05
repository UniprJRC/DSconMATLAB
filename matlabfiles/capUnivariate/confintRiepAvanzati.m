%% Intervalli di confidenza e riepiloghi avanzati
close all
miofile="Firm.xlsx";
X=readtable(miofile,"ReadRowNames",true);

%% Rappresentazione grafica intervalli di confidenza al 99 per cento 
% per ogni livello di Education
% conflevc = complemento ad uno del livello di confidenza
conflevc=0.01;

[mediej,sterrMediaj,nj,nomij]=grpstats(X.Wage,X.Education,conflevc);
% print -depsc confintABC.eps;

%% Calcolo statistiche di interesse
% groupstats = cell che contiene le variabili classificatorie
groupstats={'Gender', 'Education'};
% groupstats poteva essere definita anche come
% array of strings come segue
% groupstats=["Gender", "Education"];
% statDiInteresse sono le statistiche di interesse che devono essere
% calcolate
statDiInteresse=["mean" "std" "meanci"];
% vars = nomi delle variabili su cui devono essere calcolate
% le statistiche di interesse.
vars=["Wage" "Seniority"];
Xtab=grpstats(X,groupstats,statDiInteresse, ...
    "DataVars",vars,'Alpha',conflevc);

disp(Xtab(:,1:6))
% Grafico a barre
bar(categorical(Xtab.Properties.RowNames),Xtab.mean_Wage)
% print -depsc barreFMABC.eps;


%% Da Xtab ottengo la tabella che mi interessa

% Creazione tabella pivot tra Wage e Education
% all'interno di ogni cella il salario medio

% varDaEspandere è la variabile le cui modalità devono essere inserite
% nelle colonne della tabella
varDaEspandere='Education';
% varSulleRighe è la variabile di raggruppamento da inserire 
% nelle righe della tabella
varSulleRighe='Gender';
% varInternoTabella = i numeri che devono essere inseriti
% all'interno della tabella
varInternoTabella="mean_Wage";
tabPivot=unstack(Xtab,varInternoTabella,varDaEspandere, ...
    'GroupingVariables',varSulleRighe);
% disp(tabPivot)
tabPivot.Properties.RowNames=string(tabPivot{:,1});
tabPivot=tabPivot(:,2:end);
disp("Tabella pivot tra Sesso e Education")
disp("All'interno di ogni cella c'è la retr. media")
disp(tabPivot)

%% Modo alternativo per costruire la tabella pivot
% Con questo metodo si parte direttamente dalla table di
% partenza X
% Il secondo argomento di input do unstack è la variabile da 
% inserire dentro la tabella.
% funz = funzione da applicare alla variabile dentro la tabella
% se invece della media avessi voluto il coneggio funz=@numel;
% numel sta per number of elements
funz=@mean;
tabPivotCHK=unstack(X,'Wage',varDaEspandere, ...
    'AggregationFunction',funz,"GroupingVariables",varSulleRighe);
tabPivotCHK.Properties.RowNames=string(tabPivotCHK{:,1});
tabPivotCHK=tabPivotCHK(:,2:end);

%% Boxplot per sesso e titolo di studio
close all
% Calcolo del boxplot per ogni combinazione di sesso e titolo di studio
% Creo la nuova variabile che concatena per ogni unità statistica
% il sesso ed il titolo di studio
SesTit=string(X.Gender)+string(X.Education);
% L'istruzione che segue mi serve per inserire sull'asse x l'ordine delle
% modalità determinato da unique(SesTit) ossia le modalità in ordine
% alfabetico
SesTitc=categorical(SesTit,unique(SesTit));
boxplot(X.Wage,SesTitc);

% print -depsc boxplotFMABC.eps;
