%% ESERCIZIO I
% Importare le serie dei rendimenti presenti nel file missing2022.xlsx.
% Tramite la funzione mdpattern analizzare l'eventuale presenza di missing
% values nel file. Discutere se la distribuzione dei missing può essere
% considerata puramente casuale.
% Selezionare le due serie che presentano un numero di valori mancanti pari
% a 11 e 33. Calcolare la matrice di correlazione tra queste due serie di
% rendimenti utilizzando solo le righe che presentano valori non mancanti.
% Commentare il pvalue del test di assenza di correlazione.


%% ESERCIZIO II 
% Importare la serie dei prezzi dei prezzi di chiusura (ALT. EXCH. PRICE) dei titoli
% BPER BANCA,  BUZZI UNICEM DAVIDE CAMPARI contenuti nel file Mib40.xlsx
%
% Estrarre i dati a partire dal due di gennaio 2015.
% 
% Convertire la serie dei prezzi dalla frequenza giornaliera alla frequenza
% mensile utilizzando come funzione di aggregazione la media.
% Calcolare sulle serie mensili, la serie delle medie mobili con il
% metodo del livellamento esponenziale con la funzione movavg utilizzando
% come finestra temporale 10 e 20 termini. 
% Suddividere la finestra grafica in tre pannelli
% Rappresentare, per tutti e tre i titoli, tramite la
% funzione plot, le serie mensili dei prezzi e le due serie
% delle medie mobili calcolate in precedenza. 
% Aggiungere ad ogni pannello la
% legenda ed il nome del titolo. 
% Discutere il momento in cui si è verificato un segnale
% rialzista/ribassista per almeno una delle tre serie
%
% Calcolare la serie dei rendimenti mensili e mostrare l'andamento dei
% rendimenti tramite stackedplot.
% Calcolare le autocorrelazioni sulle serie storiche dei rendimenti e dei
% rendimenti al quadrato e commentare i relativi grafici

% ESERCIZIO III
% Generare una matrice di dati di dimensione 100x3 (3 variabili X, Y e Z)
% con le seguenti caratteristiche 
% Correlazione tra X ed Y diretta e molto elevata. Correlazione inversa tra
% X e Z di discreta entità (ossia intorno a -.5 --- -0.6). 
% Un valore anomalo, eccezionalmente grande, per Z. 
%
% Tramite la funzione corrplot calcolare la matrice di correlazione e fare
% il grafico della matrice dei diagrammi di dispersione evidenziando in
% rosso le correlazioni significative (al livello di significatività
% dell'uno per mille) nei diversi diagrammi di dispersione. 
%
% ESERCIZIO IV. Calcolare la probabiltà teorica in un campione bivariato
% formato da 12 osservazioni estratte da una distribuzione normale bivariata
% di osservare un valore del coefficiente di
% correlazione campionario compreso nell'intervallo [-0.3 0.3] quando 
% a) il vero coefficiente di correlazione nell'universo è pari a 0
% b) il vero coefficiente di correlazione nell'universo è pari a 0.5.


%% Soluzione




