%% Caricamento dati
miofile="Firm.xlsx";
Xt=readtable(miofile,"ReadRowNames",true);
 
%% Impostazione tipologia delle varibili

% Definisco la variabile Gender come qualitativa nominale (categorical senza ordine tra le modalità)
Xt.Gender = categorical(Xt.Gender);

% Definisco la variabile Education qualitativa ordinale (categorical senza ordine tra le modalità)
Xt.Education=categorical(Xt.Education,'Ordinal',true);
summary(Xt(:,1:6))

%% Distribuzioni di frequenze (variabili categoriche)
disp('Distribuzione di frequenze variabile Education')
tabulate(Xt.Education)

disp('Distribuzione di frequenze variabile Gender')
tabulate(Xt.Gender)

%% Moda per le variabili qualitative nominali
disp('Valore modale della variabile Gender')
mode(Xt.Gender)

%% Mediana per le variabili qualitative ordinali
disp('Mediana variabile Education')
median(Xt.Education)

%% GUI che mostra il calcolo del quantile 0.7 in una variabile ordinale
GUIquantile(Xt.Education,0.7)
% print -depsc GUIquantile.eps;

%% Materiale extra non incluso nel libro

% Funzione groupcounts
% Se il primo argomento di groupcounts è una table
% allora il secondo argomento contiene il nome (i nomi) delle variabili su
% cui occorre calcolare la distribuzione di frequenze
% Ad esempio
Xt1=groupcounts(Xt,"Education");
% consente di avere in output una table con i livelli di Education
% Se l'input è un vettore matrice o cell array allora 
[freq,modalita,freqperc]=groupcounts(Xt.Education);
% consente di avere dentro freq le frequenze, dentro modalità le modalità e
% dentro freqperc i vettore delle frequenze percentuali

%% Grafico a torta  per la variabile Education
pie(Xt.Education)

%% Torta con la modalità C della torta esplosa.
close all
% Il secondo argomento della funzione pie contiene informazione sulla
% fetta della torta da esplodere. Il vettore [0 0 1] significa: "esplodi la
% terza modalità"
pie(Xt.Education,[0 0 1])

%% Torta con la modalità C della torta esplosa.
close all
% In questo caso la modalità da esplodere
% è specificata come cell array invece che vettore booleano
% e etichette personalizzate per le 3 modalità
modalDaEsplodere={'C'};
pie(Xt.Education,modalDaEsplodere)

%% Torta con le modalità B e C della torta esplosa
% In questo caso le modalità da esplodere sono definite tramite 
% uno string array
close all
modalDaEsplodere=["B" "C"];
pie(Xt.Education,modalDaEsplodere)


%% Torta con etichette personalizzate
close all
modalDaEsplodere={'B'};
% Il terzo argomento di input di pie specifiche le etichette personalizzate
% che si vogliono utilizzare per le 3 modalità
et=["A=scuola dell'obbligo" "B=Diploma" "C=Laurea"];
pie(Xt.Education,modalDaEsplodere,et)

%% Torta con legenda e posizionamento personalizzato
close all
modalDaEsplodere={'B'};
pie(Xt.Education,modalDaEsplodere)
et=["A=scuola dell'obbglico" "B=Diploma" "C=Laurea"];
legend(et,'Location','southoutside')


