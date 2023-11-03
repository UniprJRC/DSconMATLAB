%% Calcolo indice Beta per tutte le serie del FTSEMib
%
% Parte I Caricamento dati.
% Caricare in memoria in una table denominata Y le serie storiche presenti
% nel file "FTSeMibTitoli.xlsx". Caricare tutte le variabili come numeriche
% in formato double.
%
% PARTE II Operazioni preliminari
% Creare una variabile denominata Ysel contenente tutte le colonne che
% hanno una denominazione che termina con _ALT_EXCH_PRICE. Creare la timetable
% associata (denominata Yt) contenente i 40 titoli presenti nel file originario.
% Nei nomi delle variabili cancellare la stringa _ALT_EXCH_PRICE
%
% PARTE III Analisi dei missing values tramite la funzione mdpattern
% Ordinare le serie in base al numero di outliers inferiori e superiori
% (suggerimento: utilizzare il secondo output della funzione mdpatter)
% Mostrare i primi 5 titoli in base al numero di outliers superiori e
% inferiori.
%
% PARTE IV Caricare in memoria i dati relativi al FTSEMib dal file
% FTSEMib.xlsx. Omogeneizzare le date del FTSEMib con quelle dei titoli
% precedentemente caricati. Tramite la funzione assert assicurarsi che le
% serie del FTSEMib e quelle dei 40 titoli abbiano le stesse date.
%
% PARTE V Creare un'unica timetable con 41 colonne contenente nell'ultima
% colonna la serie del FTSEMib. Rinominare la 41-esima colonna 'FTSEMib'
%
% PARTE VI Creare la timetable dei rendimenti logaritmici con il nome Rt.
% Confrontare tramite lo stacked plot i rendimenti del titolo ATLANTIA con
% quello del FTSEMib
%
% PARTE VII Calcolo Indici Beta, Alpha e R2
% Calcolare l'indice Beta per il titolo ATLANTIA
% Calcolare Beta, Alpha e R2 per tutti i 40 titoli.
% Creare una table denominata Xtable che contiene
% nei RowNames i nomi dei 40 titoli
% nella prima colonna il valore dell'intercetta stimata
% nella seconda colonna il valore di  b (indice Beta)
% nella terza colonna il valore di R2
%
% Parte VIII Rapresentazione grafica di a, b e R2
% Tramite un ciclo for creare:
% 1) il grafico a barre dei 40 titoli ordinati in senso non decrescente in
% base al valore di a.
% 2) il grafico a barre dei 40 titoli ordinati in senso non decrescente in
% base al valore di b (indice Beta).
% 3) il grafico a barre dei 40 titoli ordinati in senso non decrescente in
% base al valore di R2 (Indice di bontà di adattamento).
% Inserire titoli degli assi appropriati
%
% PARTE IX Salvataggio di una o più variabili dell'workspace in un file
% .mat.
% Salvare la timetable Rt in un file .mat denominato Rend.mat

%% Parte I: Caricamento dati
clear
filename="FTSeMibTitoli.xlsx";
Y = readtable(filename,"ReadRowNames",true);
head(Y)
% Le 5 colonne riferite al titolo NEXI (132:135) non sono state caricate come
% numeriche.
% Con l'istruzione che segue vado a contare il numero di variabili
% caricate come numeriche
disp("Numero di variabili caricate come numeriche")
size(Y(:,vartype('numeric')),2)

%% Obiettivo fare in modo che tutte le variabili siano caricate come numeriche
% Fase iniziale tramite detectImportOptions vado a vedere come vengono caricate le colonne del file di
% Excel
opts = detectImportOptions(filename);

% Dall'istruzione tabulate(distribuzione di frequenza di
% opts.VariableTypes)
disp("Distribuzione di frequenza del caricamento dati delle variabili di default")
disp(tabulate(opts.VariableTypes))
% mi accorgo che ci sono 5 colonne che vengono caricate come char
% (variabili non numeriche). E' necessario fare in modo che tutte le
% variabili siano caricate come numeriche
% Con l'istruzione che segue impongo che tutte le variabili utilizzate
% (ad eccezione della prima che ha un formato datetime)
% siano trattate come double (numeriche)
opts.VariableTypes(2:end)={'double'};
% Vado a fare la nuova distribuzione di frequenza di opts.VariableTypes
disp("Distribuzione di frequenza di come saranno caricate le variabili (tutte numeriche)")
disp(tabulate(opts.VariableTypes))

% Tramite l'opzione opts di readtable, impongo che tutte le variabili (ad
% eccezione della prima) siano caricate come numeriche.
% Ricarico i dati con l'opzione opts.
Y = readtable(filename,opts,"ReadRowNames",true);
% Verifico che tutte le variabili siano state caricate come numeriche
% double (ad eccezione delle prima colonna)
disp("Numero di variabili caricate come numeriche")
disp(size(Y(:,vartype('numeric')),2))

% Fine section relativa al caricamento dati

%% PARTE II Operazioni preliminari
times=Y.Properties.RowNames;
% Il formato delle date Italiano è convertito nel formato Americano
tim=datetime(times,'Locale','system');
% Creazione della timetable
% Selezione le colonne che si riferiscono ai prezzi medi giornalieri
sel=4:5:200;
Ysel=Y(:,sel);
Yt=table2timetable(Ysel,"RowTimes",tim);
Yt=Yt(:,2:end);
% Rimpiazzo la stringa "_ALT_EXCH_PRICE" con ""
varNames=Yt.Properties.VariableNames;
varNames=strrep(varNames,"_ALT_EXCH_PRICE","");
Yt.Properties.VariableNames=varNames;


%% PARTE III Analisi dei missing values
[AnalisiMis,AnalisiOut]=mdpattern(Yt);
% I missing sono relativi ai titoli Pirelli e Nexi
% 8 righe in cui sono entrambi missing i due titoli
% 387 righe in cui è missing solo Nexi
%{
% Cambio la fontsize del grafico per leggere meglio le ultime due etichette
set(gca,'FontSize',6)
 xlim([35 42.01])
%}

%% Ordinamento in base a OutSup e outInf
% Ordinare le serie in base al numero di outliers inferiori e superiori
% (suggerimento: utilizzare il secondo output della funzione mdpatter)
% Mostrare i primi 5 titoli in base al numero di outliers superiori e
% inferiori.

AnalisiOutOrdoutSup=sortrows(AnalisiOut,{'outSup'},{'descend'});
% Osservazione: nel testo dell'esercizio non viene specificato quali
% colonne mostrare, di conseguenza la scelta di seguito di mostrare le
% colonne 6:8 è puramente soggettiva.
% Mostrare i primi titoli ordinati in base alla colonna outSup
disp(AnalisiOutOrdoutSup(1:5,6:8))

AnalisiOutOrdoutInf=sortrows(AnalisiOut,{'outInf'},{'descend'});
% Mostrare i primi titoli ordinati in base alla colonna outInf
disp(AnalisiOutOrdoutInf(1:5,6:8))

%% PARTE IV CARICAMENTO FTSEMib e omogeneizzazione delle date
% PARTE IV Caricare in memoria i dati relativi al FTSEMib dal file
% FTSEMib.xlsx. Omogeneizzare le date del FTSEMib con quelle dei titoli
% precedentemente caricati. Tramite la funzione assert assicurarsi che le
% serie del FTSEMib e quelle dei 40 titoli abbiano le stesse date.
%
% Carico la serie del FTSEMib
Ym = readtable("FTSEMib.xlsx","Range","C1:H1050","ReadRowNames",true);
times=Ym.Properties.RowNames;
% Il formato delle date Italiano è convertito nel formato Americano
tim=datetime(times,'Locale','system');
% Creazione della timetable
Ymt=table2timetable(Ym(:,"Chiusura"),"RowTimes",tim);
Ymt=Ymt(:,2);

%% Omogeneizzare le date
% La serie storica del FTSEMib (Ymt) parte dal 03-agosto-2017
% La serie storica multipla dei titoli componenti il FTSEMib (Yt) parte dal
% 22-settembre-2017
seltime=Ymt.Time>=datetime(2017,9,22);
Ymt=Ymt(seltime,:);
% Controllo che Ymt e Yt si riferiscano alle stesse date ed
% abbiano lo stesso numero di righe
assert(isequal(Yt.Time,Ymt.Time),"Attenzione le serie del FTSEMib ed il FTSEMib hanno un numero diverso di osservazioni")




%% PARTE V Creo un'unica Timetable
%  Creare un'unica timetable denominata Prezzi con 41 colonne contenente nell'ultima
% colonna la serie del FTSEMib.
Prezzi=[Yt Ymt];

%% PARTE VI Creare la timetable dei rendimenti logaritmici
% Creo la timetable dei rendimenti logaritmici
[Rt] = tick2ret(Prezzi,'Method','Continuous');
%
Rt.Properties.VariableNames(end)={'FTSEMib'};

%% Confrontare tramite lo stacked plot i rendimenti del titolo ATLANTIA con quello del FTSEMib
figure
stackedplot(Rt(:,["ATLANTIA" "FTSEMib"]))
% Osservazione: si osservi il rendimento anomalo in corrispondenza della
% caduta del ponte Morandi (14 agosto del 2018)

%% PARTE VII Calcolo Indici Beta, Alpha e R2
% Calcolare l'indice Beta per il titolo ATLANTIA
% Calcolo dell'indice Beta per ATLANTIA
outATLA=fitlm(Rt{:,"FTSEMib"},Rt{:,"ATLANTIA"});
disp(outATLA)


%% Calcolo dell'indice Beta per ciascuna serie storica dei rendimenti
p=size(Rt,2);
Betaall=zeros(p-1,1);
R2all=Betaall;
Alphaall=Betaall;

for j=1:p-1
    % La variabile esplicativa è sempre la serie dei rendimenti del MIB30
    % La variabile dipendente è la colonna j della timetable Rt
    % Osservazione: inserisco le parentesi graffe per estrarre il contenuto
    % delle colonne interessate (valori numerici)
    outj=fitlm(Rt{:,"FTSEMib"},Rt{:,j});
    % Storing delle stime di a,b e R2
    Alphaall(j)=outj.Coefficients.Estimate(1);
    Betaall(j)=outj.Coefficients.Estimate(2);
    R2all(j)=outj.Rsquared.Ordinary;
end

%% Creazione table Xtable
% Creare una table denominata Xtable che contiene
% nei RowNames i nomi dei 40 titoli
% nella prima colonna il valore dell'intercetta stimata
% nella seconda colonna il valore di  b (indice Beta)
% nella terza colonna il valore di R2
X=[Alphaall Betaall R2all];
varn=["a"  "b" "R2"];
nameTitoli=Rt.Properties.VariableNames(1:end-1);
Xtable=array2table(X,"RowNames",nameTitoli,...
    'VariableNames',varn);

%% Parte VIII Rapresentazione grafica di a, b e R2
% Tramite un ciclo for creare:
% 1) il grafico a barre dei 40 titoli ordinati in senso non decrescente in
% base al valore di a.
% 2) il grafico a barre dei 40 titoli ordinati in senso non decrescente in
% base al valore di b (indice Beta).
% 3) il grafico a barre dei 40 titoli ordinati in senso non decrescente in
% base al valore di R2 (Indice di bontà di adattamento).
% Inserire titoli degli assi appropriati
for j=1:3
    Sortj=sortrows(Xtable,j,'descend');
    figure
    nameTitoliordj=Sortj.Properties.RowNames;
    nameTitoliordjC=categorical(nameTitoliordj,nameTitoliordj);
    bar(nameTitoliordjC,Sortj{:,j})
    title(['Ordinamento dei titoli in base ai valori di ' varn{j}])
    ylabel(['Valore stimato di ' varn{j}])
    if j==2
        % Nel caso di beta stimato si aggiunge un linea orizzontale con
        % altezza 1 al grafico a barre
       line([0 p+1],[1 1],'Color','r')
    end
end

%% PARTE IX Salvataggio delle variabili che interessano dentro un file mat
% Salvare la timetable Rt in un file .mat denominato Rend.mat
save('Rend.mat','Rt')
