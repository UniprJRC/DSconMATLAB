% Inserimento dei dati 
X=[3 20;10 42;8 30; 2 12];

% Calcolo della matrice dei quadrati delle
% distanze Euclidee.
D=squareform(pdist(X,'squaredeuclidean'));
disp(D)


%% Spazio metrico ponderato
% Inserimento dei dati 
X=[3 20;10 42;8 30; 2 12];
% Calcolo della matrice delle distanze euclidee sugli 
% scostamenti standardizzati
% Utilizzo l'opzione seuclidean
dist=pdist(X,'seuclidean');
% Standardizzo preliminarmente le variabili
distchk=pdist(zscore(X));
assert(max(abs(dist-distchk))<1e-12,"Errore di programmazione")
D=squareform(dist);
disp(D)

%% Distanza euclidea sui dati standardizzati in maniera robusta
% MADS stime robuste di sigma
% norminv(0.75) è il valore esatto per il fattore di correzione 1.4826
MADs=mad(X,1)/norminv(0.75);
% Se il secondo argomento di input è seuclidean è possibile specificare
% come devono essere standardizzate le variabili
dist=pdist(X,'seuclidean',MADs);
% Nell'istruzione segue lavoro direttamente sugli scostamenti 
% standardizzati robusti
distchk=pdist(zscoreFS(X));
assert(max(abs(dist-distchk))<1e-12,"Errore di programmazione nel " + ...
    "calcolo delle distanze Euclidee sulla matrice degli " + ...
    "scostamenti standardizzati robusti")


