%% Caricamento dati
X = readtable('Spumanti.xlsx', 'Sheet','Dati','range','A1:R107','ReadRowNames',true);

% Creo la tabella di contingenza tra le variabili gusto e abbinamento
[N,chi2,p,labels] =crosstab(X.GUSTO,X.ABBINAMENTO);
[r,c]=size(N);

% Visualizzo la tabella di contingenza in formato table
Ntable=array2table(N,'RowNames',labels(1:r,1),'VariableNames',labels(1:c,2));

disp('Tabella di contingenza originale')
disp(Ntable)
% calcolo di tutti gli indici e del relativo intervallo di confidenza
out=corrNominal(Ntable);

%% corrNominal con 'name',value ,'datamatrix',true
% Calcolo di tutti gli indici tramite la funzione corrNominal dell'FSDA
% toolbox partendo dalla matrice dei dati (senza passare attraverso il
% calcolo della tabella di contingenza)
 out=corrNominal([X.GUSTO X.ABBINAMENTO],'datamatrix',true);
