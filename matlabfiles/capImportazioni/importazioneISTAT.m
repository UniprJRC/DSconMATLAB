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