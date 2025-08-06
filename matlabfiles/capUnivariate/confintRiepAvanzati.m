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

%% Questa section non è nel libro
% Costruzione tabella di contingenza tra Gender e Education
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
% Trasformo l'array Tabled in formato table
Ttable=array2table(Tabled,'Rownames',labels(1:r,1),'VariableNames',labels(1:c,2));
disp(Ttable)

%% Calcolo statistiche di interesse per l'intero campione

% In questa prima parte calcolo le statistiche di interesse
% (media, standard deviation e intervallo di confidenza)
% per l'intero campione (senza di distinzione di Gender oppure di
% Education)
% statDiInteresse sono le statistiche di interesse che devono essere
% calcolate
statDiInteresse=["mean" "std" "meanci"];

% varDiInteresse = nomi delle variabili su cui devono essere calcolate
% le statistiche di interesse (terzo argomento di input di grpstats).
varDiInteresse=["Wage" "Seniority"];

%% Questa section non è nel libro
% estraggo dentro Xsel le due variabili che mi interessano
Xsel=X(:,varDiInteresse);
grpstats(Xsel,[],statDiInteresse)

%% Parte di nuovo nel libro
XtabComplessiva=grpstats(X,[],statDiInteresse, ...
    "DataVars",varDiInteresse,'Alpha',conflevc);
disp(XtabComplessiva(:,1:7))


%% Calcolo statistiche di interesse per i sottogruppi richiesti
% groupingVARS = cell che contiene le variabili classificatorie
groupingVARS={'Gender', 'Education'};
% groupingVARS poteva essere definita anche come
% array of strings come segue
% groupingVARS=["Gender", "Education"];

Xtab=grpstats(X,groupingVARS,statDiInteresse, ...
    "DataVars",varDiInteresse,'Alpha',conflevc);
disp(Xtab(:,1:6))

%% Questa section non è nel libro
% Estraggo dentro Xsel1 le 4 variabili che mi interessano
% 2 sono le variabili per cui devo calcolare le statistiche
% 2 sono le variabili di raggruppamento
varDiInteresse1=[varDiInteresse "Gender" "Education"];
Xsel1=X(:,varDiInteresse1);
grpstats(Xsel1,groupingVARS,statDiInteresse)

%% Parte di nuovo nel libro
% Grafico a barre
bar(categorical(Xtab.Properties.RowNames),Xtab.mean_Wage)
% print -depsc barreFMABC.eps;
%% Da Xtab ottengo la tabella che mi interessa tramite pivot

pivot(Xtab,Rows="Gender",Columns="Education",DataVariable="mean_Wage", ...
    Method="none",RowLabelPlacement="rownames")


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
ylabel('Retribuzione')
% print -depsc boxplotFMABC.eps;

%% Boxplot per sesso e titolo di studio (tramite chiamata a boxchart)

boxchart(categorical(X.Gender),X.Wage,'GroupByColor',X.Education);
ylabel('Retribuzione')
% Aggiunta della legenda al grafico
legend
% print -depsc boxchartFMABC.eps;

%% violinplot per sesso e titolo di studio (tramite chiamata a violinplot)
    violinplot(categorical(X.Gender),X.Wage,'GroupByColor',X.Education);
    ylabel('Retribuzione')
    % Aggiunta della legenda al grafico
    legend(categories(categorical(X.Education)))
    % Si noti che solo l'istruzione legend senza specificare le categorie non
    % funziona

%% violinplot per sesso e titolo di studio e punti interni
    violinplot(categorical(X.Gender),X.Wage,'GroupByColor',X.Education);
    ylabel('Retribuzione')
    % Aggiunta della legenda al grafico
    legend(categories(categorical(X.Education)))
    % Si noti che solo l'istruzione legend senza specificare le categorie non
    % funziona
