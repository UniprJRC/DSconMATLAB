%% Caricamento dati
X = readtable("grafuniv2serie.xlsx",'Sheet','dati','ReadRowNames',true);
Xd=X{:,1:2};

% L'istruzione
% B = categorical(A,valueset)
% crea una categoria (modalità) per ogni valore dentro valueset
% Questo per forzare Matlab ad utilizzare l'ordine presente dentro
% X.Properties.RowNames
mesi=categorical(X.Properties.RowNames,X.Properties.RowNames);
% Provate a vedere cosa succede se l'istruzione categorical si elimina
% e si utilizza semplicemente l'istruzione
% mesi=categorical(X.Properties.RowNames)
nr=2; % nr= numeri di righe nella finestra grafica
nc=3; % nc = numero di colonne nella finestra grafica
subplot(nr,nc,1)
% La funzione bar crea il grafico a barre verticali
bar(mesi,Xd)
title('Grafico a barre verticali')
% Osservazione: nella versioni di MATLAB  a partire dalla 2023b 
% funziona anche l'istruzione
% bar(X.Properties.RowNames,Xd)


subplot(nr,nc,2)
% La funzione barh crea il grafico a barre orizzontali
barh(mesi, Xd)
title('Grafico a barre orizzontali')
% Osservazione: nella versioni di MATLAB  a partire dalla 2023b 
% funziona anche l'istruzione
% barh(X.Properties.RowNames,Xd)

subplot(nr,nc,3)
% colonne in pila
bar(mesi,Xd,'stacked')
title('Colonne in pila')


subplot(nr,nc,4)
% colonne in pila al 100%
% Ogni valore di ogni riga viene diviso per il totale di riga
bar(mesi,100*Xd./sum(Xd,2),'stacked')
title('Colonne in pila al 100%')


subplot(nr,nc,5)
% area in pila al 100%
area(mesi,100*Xd./sum(Xd,2),2)
title('Area in pila al 100%')

% Si noti che l'istruzione di seguito non funziona
% area(X.Properties.RowNames,100*Xd./sum(Xd,2),2)

subplot(nr,nc,6)
% barre 3D
bar3(mesi, Xd)
title('Barre 3D')

% Si noti che l'istruzione di seguito non funziona
% bar3(X.Properties.RowNames,Xd)


% print -depsc grafuniv2serie.eps;



