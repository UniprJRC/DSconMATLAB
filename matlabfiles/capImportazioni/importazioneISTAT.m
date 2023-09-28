% Importazione di dati scaricati dal sito web dell'ISTAT
X=readtable('PILeCOMP.xlsx','ReadRowNames',true);
% La table viene trasposta tramite la funzione rows2vars
X1=rows2vars(X);
% Vengono rimosse le colonne con dati mancanti
X2=rmmissing(X1,2);

% Viene creata la sequenza  di date (trimestri)
Time=datetime(2020,12,31):calquarters:datetime(2023,3,31);

% la table X2 viene trasformata in timetable specificando i RowTimes
TT=table2timetable(X2(:,2:end),'RowTimes',Time);
disp(TT(:,1:3))

%% Modo alternativo non presente nel libro di creare TT partendo da X2
% Invece di creare la sequenza temporale, di inizio e fine la ricavo dalla
% prima colonna di X2
% La sintassi "'x'yyyy_QQQ" significa:
% il primo carattere è pari a x,
% dopo ci sono gli anni a 4 cifre,
% dopo ci sono i trimestri in formato abbreviato Q1, Q2, ..., Q4
% Si veda la sezione Format dell'help di datetime
% https://it.mathworks.com/help/matlab/ref/datetime.html#buhzxmk-1-Format
% QQQ	Quarter, abbreviated	Q2

times=datetime(X2{:,1},'InputFormat',"'x'yyyy_QQQ");

TTchk=table2timetable(X2(:,2:end), 'RowTimes',times);
disp(TTchk(:,1:3))

%% Analisi delle differenze tra TT e TTchk
% Osservazione: la table TT contiene per ogni riga l'ultimo giorno del
% trimestre
% Per controllare la data che deve essere visualizzata in corrispondenza di
% ogni periodo (ad esempio il trimestre) si può utilizzare dateshift
TTchk.Properties.RowTimes=dateshift(TTchk.Properties.RowTimes,"end",'quarter');
