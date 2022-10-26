%% ESERCIZIO I
% Importare le serie dei rendimenti presenti nel file missing.xlsx.
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
% Calcolare sulle serie mensli, la serie delle medie mobili con il
% metodo del livellamento esponenziale con la funzione movavg utilizzando
% come finestra temporale 10 e 20 termini.
% Suddividere la finestra grafica in tre pannelli
% Rappresentare, per tutti e tre i titoli tramite la
% funzione plot, le serie mensili dei prezzi e le due serie
% delle medie mobili calcolate in precedenza.
% Aggiungere al grafico la
% legenda. Discutere il momento in cui si è verificato un segnale
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
% X e Z di discreta entità (ossia intorno a -0.5 --- -0.6).
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
close all
clear
Y=readtable("missing2022.xlsx");
out=mdpattern(Y);
% La distribuzione dei missing values è completamente non casuale.
% Le 2 variabili che presentano un numero di missing pari a 11 e 33 sono
% titolo7 e titolo3.

% boo è una matrice booleana che ha la stessa dimensione della matrice Y
% che contiene vero in corrispondenza dell'elemento i,j se l'elemento i,j è
% mancante.
boo=ismissing(Y);
% Vado a contare il numero dei missing per ogni colonna.
% nummissing è un vettore riga che in corrispondenza dell'elemento j
% contiene il numero di valori mancanti della variabile j
nummissing=sum(boo,1);

% sel è un vettore booleano che contiene true (1) quando numissing è 11
% oppure nummissing è 33
sel=nummissing==11 | nummissing==33;
% Ysel è la table che contiene le due variabili che hanno un numero di
% valori mancanti pari a 11 e 33.
Ysel=Y(:,sel);
% Verifico che effettivamente Ysel contenga le variabili titolo3 e titolo7
head(Ysel)

% In alternativa sel poteva essere trovato facendo riferimento all'output
% di mdpattern
% Vado ad escludere la prima colonna e l'ultima colonna di out
nummissingCHK=out{'totPatOrMis',2:end-1};
selout=nummissingCHK==11 | nummissingCHK==33;
Yselchk=Y(:,out.Properties.VariableNames([false selout false]));
maxdiff=max(abs(Yselchk{:,[2 1]}-Ysel{:,:}),[],'all');
assert(maxdiff<1e-15,"Le due implementazioni per trovare Ysel non coincidono")

% Calcolare la matrice di correlazione tra queste due serie di
% rendimenti utilizzando solo le righe che presentano valori non mancanti.
% Commentare il pvalue del test di assenza di correlazione.
[cor,pval]=corr(Ysel{:,:},'Rows','Complete');
disp('pvalue del test di assenza di correlazione')
disp(pval)
% Il pvalue del test di assenza di correlazione tra le due variabili è
% elevato. Accetto l'ipotesi nulla di incorrelazione tra le due variabili.
% Osservazione: se la distribuzione delle due variabili è normale,
% l'incorrelazione equivale all'indipendenza.


%% ESERCIZIO II
% Obiettivo fare in modo che tutte le variabili siano caricate come
% numeriche. Fase iniziale: tramite detectImportOptions vado a vedere come
% vengono caricate le colonne del file di Excel
filename='Mib40.xlsx';
opts = detectImportOptions(filename);
% Dall'istruzione tabulate(distribuzione di frequenza di
% opts.VariableTypes)
disp("Distribuzione di frequenza del caricamento dati delle variabili di default")
disp(tabulate(opts.VariableTypes))
% mi accorgo che la prima colonna viene carircata come datetime,
% poi ci sono 204 colonne che vengono caricate come char
% (variabili non numeriche) e 36 come numeriche.
% E' necessario fare in modo che tutte le
% variabili siano caricate come numeriche
% Con l'istruzione che segue impongo che tutte le variabili utilizzate
% (ad eccezione della prima che ha un formato datetime)
% siano trattate come double (numeriche)
opts.VariableTypes(2:end)={'double'};
% Vado a fare la nuova distribuzione di frequenza di opts.VariableTypes
disp("Distribuzione di frequenza di come saranno caricate le variabili (tutte numeriche)")
disp(tabulate(opts.VariableTypes))
% Faccio il preview per capire come vengono caricate le variabili
preview(filename,opts)
% I valori mancanti sono inseriti come NaN (not a number) e
% tutte le variabili sono caricate come numeriche.
% Carico il contenuto di del file denominato filename utilizzando le
% opzioni definite nella struct opts nella timetable denominata Yt
Yt=readtimetable(filename,opts);
%  Estrazione delle osservazioni a partire dal 2 gennaio 2015
boo=Yt.Properties.RowTimes>datetime('01-JAN-2015');
Yt1=Yt(boo,:);


%% Soluzione alternativa da pivelli
% In questa soluzione si carica prima il range richiesto
% Osservazione: nella riga di seguito l'istruzione
% 'ReadVariableNames',false non era necessaria
Y=readtable(filename,'Range','A6047:IG8068','ReadVariableNames',false);
% La seconda chiamata a readtable mi serve per caricare i nomi delle
% variabili
Ynomi=readtable(filename,'Range','A1:IG2');
nomi=Ynomi.Properties.VariableNames;
Y.Properties.VariableNames=nomi;
% Trasformo in timetable Y
Yt1CHK=table2timetable(Y,"RowTimes","Name");
disp('Confronto i due modi di caricamento dati')
head(Yt1(:,1:3))
head(Yt1CHK(:,1:3))

% Avete caricato i dati in maniera alternativa e più efficiente?
% Per favore fatemi sapere le soluzioni alternative che proponete.


%% Estrazione delle colonne richieste
% vado a selezionare le colonne che contengono ALT_EXCH_PRICE
% Si noti che l'end nella riga di seguito si riferisce alle colonna di Yt1
Yt2=Yt1(:,4:6:end);
% Un'istruzione alternativa era
% Yt2=Yt1(:,4:6:size(Yt1,2));

% Vado a prendere le colonne richieste da Yt2
Yt3=Yt2(:,["BPERBANCA_ALT_EXCH_PRICE" "BUZZIUNICEM_ALT_EXCH_PRICE" ...
    "DAVIDECAMPARIMILANO_ALT_EXCH_PRICE"]);
% Osservazione: naturalmente avrei potuto estrarre le colonne 
% ["BPERBANCA_ALT_EXCH_PRICE" "BUZZIUNICEM_ALT_EXCH_PRICE" ...
%     "DAVIDECAMPARIMILANO_ALT_EXCH_PRICE"] 
% direttamente da Yt1 come segue
%Yt3=Yt1(:,["BPERBANCA_ALT_EXCH_PRICE" "BUZZIUNICEM_ALT_EXCH_PRICE" ...
%    "DAVIDECAMPARIMILANO_ALT_EXCH_PRICE"]);

% Rimpiazzo la stringa "_ALT_EXCH_PRICE" con ""
% Questa istruzione non è strettamente necessaria
varNames=Yt3.Properties.VariableNames;
varNames=strrep(varNames,"_ALT_EXCH_PRICE","");
Yt3.Properties.VariableNames=varNames;
% Rinomino la colonna che contiene il tempo Time
% Istruzione non necessaria ma mi dava fastidio il nome Name
Yt3.Properties.DimensionNames{1}='Time';

%% Conversione dalla frequenza giornaliera alla frequenza mensile
Ytmon=retime(Yt3,'monthly','mean');

%% Media mobile esponenziale
% Calcolare la serie delle medie mobili con il metodo del livellamento
% esponenziale con la funzione movavg a 10 e 20 termini.
k=10;
mme10= movavg(Ytmon,'exponential',k);
k=20;
mme20= movavg(Ytmon,'exponential',k);
tim=Ytmon.Time;

%% Rappresentazione tramite la funzione plot

figure
for j=1:3
    subplot(1,3,j)
    plot(tim,Ytmon{:,j},'b',tim,mme10{:,j},'r--',tim,mme20{:,j},'k')
    legend({'Prezzo del titolo' 'mm esponenziali di 10 termini' 'mm esponenziali di 20 termini'},'Location','best')
    xlabel('Time')
    title(Ytmon.Properties.VariableNames{j})
end

% Inizio 2016 forte segnale ribassista per BPER
% La media di breve (10 termini) taglia dall'alto verso il  basso
% la media di medio-lungo (20 termini)


%% Passare dalla serie originaria alla serie dei rendimenti logaritmici
Rt = tick2ret(Ytmon,'Method','Continuous');
figure
stackedplot(Rt)
sgtitle('Analisi dei rendimenti')

%% Analisi della funzione di autocorrelazione sui rendimenti
figure
for j=1:3
    subplot(3,1,j)
    % Calcolo funzione di autocorrelazione per ciascuno dei 3 titoli
    autocorr(Rt(:,j))
    title(Rt.Properties.VariableNames{j})
end
sgtitle('Autocorrelazioni tra i rendimenti')

%% Analisi della funzione di autocorrelazione sui rendimenti al quadrato
figure
for j=1:3
    subplot(3,1,j)
    % Calcolo funzione di autocorrelazione per ciascuno dei 3 titoli
    autocorr(Rt{:,j}.^2)
    title(Rt.Properties.VariableNames{j})
end
sgtitle('Autocorrelazioni tra i rendimenti al quadrato')

% Per questi 3 titoli non ci sono autocorrelazioni significative nei
% rendimenti e/o nei rendimenti al quadrato


%% ESERCIZIO III
% Generare una matrice di dati di dimensione 100x3 (3 variabili X, Y e Z)
% con le seguenti caratteristiche.
% Correlazione tra X ed Y diretta e molto elevata. Correlazione inversa tra
% X e Z di discreta entità (ossia intorno a -.5 --- -0.6).
% Un valore anomalo, eccezionalmente grande, per Z.
close all
rng(100)
% per replicabilità dei risultati (qualsiasi altro seed sarebbe andato
% bene)
n=100;
% Correlazione diretta molto elevata tra x e y
% Genero x in base ad una sequenza anche se potevo generarlo tramite rand
% oppure randn.
x=(1:n)';
% Tanto più aumento coef1 tanto più l'importanza della componente casuale
% aumenta e tanto più la correlazione tra x e y diminuisce
coef1=10;
y=2+3*x+coef1*randn(n,1);
% Correlazione inversa tra X e Z di discreta entità
% Tanto più aumento coef2 tanto più la correlazione tra X e Z diminuisce
% (in valore assoluto)
coef2=200;
z=2-5*x+coef2*randn(n,1);
% Un valore anomalo (eccezionalmente grande) per Z
% Contamino un'unità a caso (in questo caso l'elemento 3 di z).
z(3)=max(z)+300;
X=[x y z];
% Tramite la funzione corrplot calcolare la matrice di correlazione
% e fare il grafico della matrice dei diagrammi di dispersione
% evidenziando in rosso le correlazioni significative (al livello di
% significatività dell'uno per mille) nei diversi diagrammi di dispersione.
Rgen=corrplot(X,'testR','on','alpha',0.001);
disp(Rgen)


%% ESERCIZIO IV.
% Calcolare la probabiltà teorica in un campione bivariato
% formato da 12 osservazioni estratte da una distribuzione normale bivariata
% di osservare un valore del coefficiente di
% correlazione campionario compreso nell'intervallo [-0.3 0.3] quando
% a) il vero coefficiente di correlazione nell'universo è pari a 0
% b) il vero coefficiente di correlazione nell'universo è pari a 0.5.

% L'espressione contentuta nell'equazione (6.10) del testo si distribuisce
% come una v.c. T di Student con n-2 gradi di libertà quando rho (il vero
% valore del coefficiente di correlazione lineare nell'universo) è zero.
r=0.3;
n=12;
tr=sqrt(n-2)*r/sqrt(1-r^2);
% La probabilità di trovare in una T di Student con (n-2) gradi di libertà
% un valore compreso tra -tr e tr è la probabilità che il coefficiente di
% correlazione lineare assuma valori nell'intervallo [-0.3 0.3];
probrho0=tcdf(tr,n-2)-tcdf(-tr,n-2);

% Un modo alternativo è quello di fare riferimento alla funzione corrcdf di
% FSDA toolbox
% specificando come argomenti di input
% r= coefficiente di correlazione campionario
% rho = vero valore della correlazione nella popolazione
% n = numerosità campionaria
rho=0;
probrho0CHK=corrcdf(r,rho,n)-corrcdf(-r,rho,n);
% Confronto le due probabilità
rchar=num2str(r);
nchar=num2str(n);
rown=string(['Pr(-' rchar '<r<' rchar '|rho=' num2str(rho) ', n=' nchar ')']);
prob=[probrho0 probrho0CHK];
probT=array2table(prob,"RowNames",rown,"VariableNames", ...
    ["Prob. tramite T(n-2)" "Prob. tramite corrcdf"]);
disp(probT)

% Se il vero valore di rho è diverso da zero, l'unico modo per trovare la
% probabilità richiesta è quello di fare riferimento alla funzione corrcdf
rho=0.5;
probrho05=corrcdf(r,rho,n)-corrcdf(-r,rho,n);
rown=string(['Pr(-' rchar '<r<' rchar '|rho=' num2str(rho) ', n=' nchar ')']);
probTrho05=array2table(probrho05,"RowNames",rown,"VariableNames","Prob tramite corrcdf");
disp(probTrho05)

% Ovviamente probrho0> probrho05
% Se il vero valore della correlazione è 0.5, il coefficiente di
% correlazione campionario avrà una distribuzione centrata attorno a 0.5.

% Osservazione: corrcdf contiene un integrale numerico e la densità è
% approssimata di conseguenza probrho05 può avere un minimo margine di
% errore dell'ordine di 10^-4

