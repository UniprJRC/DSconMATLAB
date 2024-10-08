%% Esercizio distribuzioni di frequenza

% viene fissato a 100 il seed dei numeri casuali
rng(100)
% n = numero di numeri casuali che vengono generati
n=1000;
x=randn(n,1);
% classi = vettore che contiene gli estremi superiori
% delle classi
classi=[-2; 0; 1.5; Inf];

% Inizializzazione della matrice Freq
% Freq nella prima colonna contiene gli estremi superiori delle classi,
% nella seconda colonna conterrà le frequenze
Freq=[classi zeros(length(classi),1)];

% Calcolo delle frequenze utilizzando il ciclo for ed inserimento delle
% stesse nella seconda colonna della matrice Freq
for i=1:n
    if  x(i) <= -2
        % se x(i) è minore o uguale a -2 incrementa la cella Freq(1,2)
        % di un'unità
        Freq(1,2)= Freq(1,2)+1;

    elseif x(i)> -2 && x(i) <=0
        % se x(i) è compreso tra -2 e 0 incrementa la cella Freq(2,2)
        % di un'unità
        Freq(2,2)= Freq(2,2)+1;

    elseif x(i) >0 && x(i) <=1.5
        Freq(3,2)= Freq(3,2)+1;

    elseif x(i)> 1.5
        Freq(4,2)= Freq(4,2)+1;
    else
    end
end

% Frequenze utilizzando il ciclo for
disp('Matrice contenente la distribuzione di frequenza')
disp('La prima colonna contiene gli estremi sup. delle classi')
disp(Freq)


%% Frequenze tramite la funzione histogram
h=histogram(x,[-Inf; classi]);
assert(isequal(h.Values(:),Freq(:,2)),"frequenze tramite ciclo for diverse" + ...
    "dalle frequenze ottenute tramite histogram");

%% Frequenze tramite la funzione histcounts
freqConHistCounts=histcounts(x,[-Inf; classi]);
assert(isequal(freqConHistCounts(:),Freq(:,2)),"frequenze tramite ciclo for diverse" + ...
    "dalle frequenze ottenute tramite histcounts");



%% Creazione della table con le etichette di riga richieste
%rownam = nomi delle righe della table
rownam={'<=-2' '(- 2  0]' '(0  1.5]' '>1.5'};

Freqtable=array2table(Freq(:,2),'VariableNames',{'Distr_frequenze'}, ...
    'RowNames',rownam);
disp(Freqtable)

%% Creazione della distribuzione di frequenze tramite doppio ciclo for
% Questa volta classi contiene anche l'estremo inferiore
% della prima classe
classi=[-Inf;-2; 0; 1.5; Inf];

% Inizializzazione della matrice FreqCHK
FreqCHK=[classi(2:end) zeros(length(classi)-1,1)];

% Calcolo delle frequenze utilizzando doppio ciclo for
for i=1:n % ciclo che scorre sugli elementi di x
    for j=1:length(classi)-1 % ciclo che scorre sugli elementi del vettore classi
        if x(i)> classi(j) && x(i) <= classi(j+1)
            % La seconda colonna della matrice FreqCHK viene aumentata di uno
            % se x(i) è compreso tra classi(j) e classi(j+1)
            FreqCHK(j,2)= FreqCHK(j,2)+1;
            % L'istruzione break serve per terminare il loop su j
            % e continuare con il loop su i.
            % Dato che è stato trovato che classi(j) < x(i) <=classi(j+1)
            % e dato che x(i) appartiene ad una sola classe
            % non è necessario continuare il loop (ciclo for) su j e si può
            % passare direttamente all'elemento x(i+1)
            break
        else
        end
    end
end

assert(isequal(Freq,FreqCHK),"frequenze tramite ciclo for diverse" + ...
    "dalle frequenze ottenute tramite doppio ciclo for");

%% Risoluzione dell'esercizio in maniera vettoriale

% Questa volta classi contiene anche l'estremo inferiore
% della prima classe
classi=[-Inf;-2; 0; 1.5; Inf];

% Inizializzazione della matrice FreqCHK1
FreqCHK1=[classi(2:end) zeros(length(classi)-1,1)];
for j=1:length(classi)-1  % ciclo che scorre sugli elementi del vettore classi
    % Inserisco in posizione j,2 gli elementi di x che sono compresi tra
    % classi(j) e classi(j+1)
    FreqCHK1(j,2)=sum( x> classi(j) & x <= classi(j+1));
end

assert(isequal(Freq,FreqCHK1),"frequenze tramite ciclo for diverse" + ...
    "dalle frequenze ottenute tramite doppio ciclo for");
%% Parte non nel libro: soluzione tramite chiamata a discretize con terzo argomento categorical
% 3 argomenti in input nella funzione discretize
clc
classi=[-Inf;-2; 0; 1.5; Inf];
[classe_appartenza]=discretize(x,classi,'categorical');
fprintf(['Etichetta della classe di appartenenza ' ...
    'delle \n prime cinque modalità del vettore x \n']);
disp(classe_appartenza(1:5))
tabulate(classe_appartenza);

%% Soluzione tramite chiamata alla funzione discretize
% quattro argomenti di input di discretize
clc
rownam={'<=-2' '(- 2  0]' '(0  1.5]' '>1.5'};
classi=[-Inf;-2; 0; 1.5; Inf];
[classe_appartenza]=discretize(x,classi,'categorical',rownam);
stringa=sprintf(['Etichetta della classe di appartenenza ' ...
    'delle \n prime cinque modalità del vettore x']);
disp(stringa)
disp(classe_appartenza(1:5))
% viene creata la distribuzione di frequenza richiesta
disp('Distribuzione di frequenza assoluta e percentuale')
tabulate(classe_appartenza);
