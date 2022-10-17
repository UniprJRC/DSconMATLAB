%% Intervalli di confidenza e riepiloghi avanzati
close all
miofile="Firm.xlsx";
X=readtable(miofile,"ReadRowNames",true);

%% Rappresentazione grafica intervalli di confidenza al 99 per cento 
% per ogni livello di Education
% conflevc = complemento ad uno del livello di confidenza
conflevc=0.01;

[mediej,sterrMediaj,nj,nomij]=grpstats(X.Wage,X.Education,conflevc);
% mediej = vettore che contiene le medie aritmetiche di Wage per ogni
% livello di Education 
% sterrMediaj = vettore che contiene gli standard
% error delle medie aritmetiche per ogni gruppo (livello di Education) 
% nj = vettore che contiene le frequenze di ogni gruppo 
% nomij = cell che contiene le etichette dei livelli di Education

% print -depsc confintABC.eps;

%% Costruzione tabella di contingenza tra Gender e Education 
% Questa section non è stata inserita nel libro
% All'interno della tabella di contingenza ci sono le frequenze
% Gli argomenti 2 e 3 dell'output di crosstab non mi interessano, di
% conseguenza con il simbolo ~ non li faccio restituire (per risparmiare
% spazio su disco)
% Il quarto argomento di output di crosstab è una cell che contiene un
% numero di righe pari al massimo tra le modalità delle due variabili
% categoriche e due colonne. In questo caso, X.Gender presenta due sole
% modalità, X.Education 3 modalità, di conseguenza il quarto argomento di
% output (che di seguito viene chiamato labels) ha dimensione 3x2
[Tabled,~,~,labels] = crosstab(X.Gender,X.Education);
[r,c]=size(Tabled);
% Trasformo l'array Tabled in fornato table
Ttable=array2table(Tabled,'Rownames',labels(1:r,1),'VariableNames',labels(1:c,2));
disp(Ttable)

%% Calcolo statistiche di interesse
% groupstats = cell che contiene le variabili classificatorie
groupstats={'Gender', 'Education'}; % groupvars
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

% Creazione tabella pivot tra Wage e Education,
% all'interno di ogni cella il salario medio

% varDaEspandere è la variabile le cui modalità devono essere inserite
% nelle colonne della tabella
varDaEspandere='Education'; % terzo argomento di input di unstack
% varSulleRighe è la variabile di raggruppamento da inserire 
% nelle righe della tabella
varSulleRighe='Gender';
% varInternoTabella = i numeri che devono essere inseriti
% all'interno della tabella
varInternoTabella="mean_Wage"; % secondo argomento di input di unstack
tabPivot=unstack(Xtab,varInternoTabella,varDaEspandere, ...
    'GroupingVariables',varSulleRighe);
% disp(tabPivot)
tabPivot.Properties.RowNames=string(tabPivot{:,1}); %% Oss. istruzione string non necessaria
tabPivot=tabPivot(:,2:end);
disp("Tabella pivot tra Sesso e Education")
disp("All'interno di ogni cella c'è la retr. media")
disp(tabPivot)

%% Modo alternativo per costruire la tabella pivot
% Con questo metodo si parte direttamente dalla table di
% partenza X
% Il secondo argomento di input di unstack è la variabile da 
% inserire dentro la tabella.
% funz = funzione da applicare alla variabile dentro la tabella
% se invece della media avessi voluto il conteggio funz=@numel;
% numel sta per number of elements
funz=@mean; 
tabPivotCHK=unstack(X,'Wage',varDaEspandere, ...
    'AggregationFunction',funz,"GroupingVariables",varSulleRighe);
% Osservazione: nel testo c'è l'istruzione string(tabPivot{:,1}), tuttavia
% la funzione string non è necessaria in quanto tabPivotCHK{:,1} contiene
% un cell array of characters
tabPivotCHK.Properties.RowNames=tabPivotCHK{:,1};
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

%% Parte non inserita nel libro
% Obiettivo: modo alternativo tramite la chiamata a boxchart per costruire
% il boxplot distinto per maschi e femmine per ogni livello di titolo di
% studio.
% Il primo argomento di boxchart deve essere una variabile categorica
% Con l'istruzione categorical(X.Gender) andiamo a specificare che vogliamo
% il boxplot per ogni modalità della variabile X.Gender
% Con l'opzione GroupByColor andiamo a specificare che per ogni modalità di
% X.gender dobbiamo costruire un boxplot separato per ogni livello di
% Education. Da notare che X.Education non necessariamente deve essere
% definita come categorica
boxchart(categorical(X.Gender),X.Wage,'GroupByColor',X.Education);
% Aggiunta della legenda al grafico
legend

