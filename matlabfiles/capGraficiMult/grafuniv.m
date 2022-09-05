
%% Importazione dati 
X = readtable("grafuniv.xlsx",'ReadRowNames',true);
rownam=X.Properties.RowNames;
% Xd = array che contiene i 12 numeri
Xd=X{:,:};
n=size(X,1);

%% Creazione dei grafici
subplot(2,2,1)  % inserisce il primo grafico nel pannello in alto a sx
% La funzione bar crea il grafico a barre
% L'opzione 'BaseValue',mean(Xd) specifica
% dove l'asse x interseca l'asse y
mx=mean(Xd);
bar(Xd,'BaseValue',mx)
% la funzione MATLAB gca (get current axes) consente di avere un handle 
% alle diverse proprietà del grafico
% Ad esempio la funzione
% get(gca,'xticklabel') consente di recuperare le etichette delle barre
% sull'asse delle ascisse
% L'istruzione che segue specifica che le etichette delle barre devono
% essere i nomi delle righe della table X
set(gca,'xticklabel',rownam)
title('Grafico a barre verticali')

% un modo alternativo per inserire i nomi delle righe come intestazione
% delle barre è quello di attribuire la proprietà categorical al vettore
% che contiene i nomi delle righe della table
% bar(categorical(X.Properties.RowNames),X{:,1})

subplot(2,2,2) % inserisce il secondo grafico nel pannello in alto a dx
% La funzione barh crea il grafico a barre orizzontale
barh(Xd,'BaseValue',mx)
% Nel grafico a barre orizzontale andiamo a inserire i nomi della table
% nelle etichette dell'asse y
set(gca,'yticklabel',rownam)
title('Grafico a barre orizzontali')

subplot(2,2,3) % inserisce il terzo grafico nel pannello in basso a sx
% La funzione plot crea il grafico a linee
plot(Xd)
% Vado ad inserire i nomi della table
% nelle etichette dell'asse x.
% La proprietà 'xtick',1:n consente di specificare che ci devono essere n
% etichette. La proprietà 'xticklabel' consente di specificare quali devono
% essere queste n etichette. In questo caso le n etichette corrispondono
% alle n righe della table originaria
set(gca,'xtick',1:n,'xticklabel',rownam)
title('Grafico a linee')

subplot(2,2,4) % inserisce il grafico nel pannello in basso a dx
% La funzione area crea il grafico ad area
area(Xd)
set(gca,'xtick',1:n,'xticklabel',rownam)
title('Grafico ad area')

% print -depsc grafuniv.eps;



