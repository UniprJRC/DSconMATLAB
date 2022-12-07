%% ESAME PARZIALE METODI QUANTITATIVI PER I MERCATI FINANZIARI (2 MODULO)

%%%DURATA: 1 ora e 30 minuti
%%%Il file Matlab (script) va salvato con il vostro nome e cognome e va caricato su
%%%ELLY alla fine dell'esame. 
%%%La votazione finale terrà conto della qualità del codice e della sua chiara presentazione.
%% ESERCIZIO 1 (5 punti)

%Sia dato il seguente codice
%[X, fval] = fmincon(@(x) sqrt(x'*V*x), ... 
%ones(n,1)/n, ...
%[], [], ... 
%[ones(1,n) ; mean(R)], ... 
%[ 1 ; ER ], ... 
%zeros(n, 1), ones(n, 1),... 
%[]) ;

%%%1. (1 punto) A che cosa corrisponde il termine sqrt(x'*V*x)? E l'output X?

%%%2. (1 punto) Che cosa rappresentano i termini [ones(1, n); mean(R)] e [1; ER]?

%%%3. (1.5 punti) Supponete adesso il seguente codice:
%n=2;
%v_1=[-2;0];
%v_2=[2; 2];
%[X, fval] = fmincon(@(x) sqrt(x'*V*x), ... 
%ones(n,1)/n, ...
%[], [], ... 
%[ones(1,n) ; mean(R)], ... 
%[ 1 ; ER ], ... 
%v_1, v_2,... 
%[]) ;
%% Che cosa rappresentano i termini v_1 e v_2?

%%%4. (1.5 punti) Si supponga che il codice cambi di nuovo come segue:
%n=2;
%[X, fval] = fmincon(@(x) sqrt(x'*V*x), ... 
%ones(n,1)/n, ...
%[2 -1], 0, ... 
%[ mean(R)], ... 
%[ ER ], ... 
%[], [],... 
%[]) ;
%% Che cosa rappresentano i termini [2 -1] e 0?
%% ESERCIZIO 2 (14 punti)

%Caricare i file Excel "^IXIC.csv" e "^N225.csv" in Matlab.
%Ciascun file contiene 7 colonne. La sesta colonna di ciascun file contiene l'adjusted
%closed price (prezzo di chiusura rettificato) del titolo "IXIC" e "N225". 

%%%1. (1 punto) Calcolare i rendimenti di entrambi i titoli memorizzandoli nelle variabili "IXIC_rend" e "N225_rend". 

%%%2. (1 punto) Calcolare la covarianza tra i rendimenti dei due titoli e i loro rendimenti attesi, questa sara' da memorizzare 
% nella variabile "covIXICN225" e i loro rendimenti attesi  nelle variabili "mediaIXICN" e "mediaN225".

%%%3. (4 punti) Stimare la funzione di densità dei rendimenti standardizzati "(rendimenti - media)/dev.std(rendimenti)" del titolo "IXIC" e fai il confronto con la funzione di densità di una normale con parametri 0 e 1. 
% Supponi che la dimensione del passo sia uguale a 0.1. Plotta sullo stesso grafico l'istogramma, la funzione di densità stimata e la vera funzione di densità della variabile normale con parametri 0 e 1.
% Si commentino i risultati ottenuti.

%%%4. (1 punto) Create un vettore di pesi x della forma x = [0, 0.01, 0.02, ..., 0.99, 1]. Questo vettore rappresenta 
% i pesi dell'asset "IXIC", quindi il peso dell'altro asset è 1−x.

%%%5. (4 punti) Crea un ciclo "loop" che calcola la deviazione standard e il rendimento del portafogli per ogni possibile peso contenuto in x. 
%I vettori "sd_R" e "R_media" conterranno il risultato. 

%%%6. (3 punti) Supponete che il risk-free rate sia uguale rf=0.0001. Calcolate il rapporto di Sharpe per i portafogli precedenti senza fare il looping. 
% Memorizza il risultato nella variabile "sharpe". Commentate i risultati.
%% ESERCIZIO 3 (11 punti)

%In un mercato sono presenti due soli titoli aleatori caratterizzati dai seguenti
%rendimenti medi e dalla seguente matrice delle varianze-covarianze:
%mu=[0.25; 0.1]; e V=[0.0064 0.002; 0.002 0.0025];

%%%1. (3 punti) Si calcoli il rendimento atteso, la varianza e le quote del portafogli efficiente di minima varianza
% supponendo l'esistenza del vincolo di no "short selling", di budget e del vincolo "x_1+x_2=>1"
%, dove x_1 e x_2 danno rispettivamente il peso del titolo 1 e 2.;

%%%2. (5 punti) Si calcoli e si plotti la frontiera efficiente utilizzando la
%funzione "fmincon" supponendo gli stessi vincoli di prima.

%%%3. (3 punti) Si calcoli la quota da investire nel primo titolo per avere un
%portafogli di rendimento atteso uguale a 0.2 supponendo gli stessi vincoli di prima.
%Si commentino i risultati.