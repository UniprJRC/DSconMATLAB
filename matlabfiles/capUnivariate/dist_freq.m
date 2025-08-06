%% Esercizio distribuzioni di frequenza
rng(100)
% n = numero di numeri casuali che vengono generati
n=1000;
x=randn(n,1);
% classi = vettore che contiene gli estremi delle classi
classi=[-Inf; -2; 0; 1.5; Inf];

%% Frequenze tramite la funzione histogram
h=histogram(x,classi);

%% Frequenze tramite la funzione histcounts
freqConHistCounts=histcounts(x,classi);
assert(isequal(freqConHistCounts,h.Values),"frequenze tramite histogram diverse" + ...
    "dalle frequenze ottenute tramite histcounts");

%% Creazione della table con le etichette di riga richieste
%rownam = nomi delle righe della table
rownam={'<=-2' '(- 2  0]' '(0  1.5]' '>1.5'};

Freqtable=array2table(h.Values','VariableNames',{'Distr_frequenze'}, ...
    'RowNames',rownam);
disp(Freqtable)

%% discretize con 2 argomenti di input
[classe_appartenza]=discretize(x,classi);
disp("Primi 5 elementi di classe_appartenza (2 arg. di input)") 
disp(classe_appartenza(1:5))
disp('Distribuzione di frequenza assoluta e percentuale')
tabulate(classe_appartenza);

%% discretize con 3 argomenti di input
[classe_appartenza]=discretize(x,classi,'categorical');
disp("Primi 5 elementi di classe_appartenza (3 arg. di input)") 
disp(classe_appartenza(1:5))
disp('Distribuzione di frequenza assoluta e percentuale')
tabulate(classe_appartenza);

%% discretize con 4 argomenti di input
rownam={'Minore di -2' 'Tra -2 e 0' 'Tra 0 e 1.5' 'Maggiore di 1.5'};
[classe_appartenza]=discretize(x,classi,'categorical',rownam);
disp("Primi 5 elementi di classe_appartenza (4 arg. di input)") 
disp(classe_appartenza(1:5))
% viene creata la distribuzione di frequenza richiesta
disp('discretize con 4 argomenti di input: etichette personalizzate')
disp('Distribuzione di frequenza assoluta e percentuale')
tabulate(classe_appartenza);
