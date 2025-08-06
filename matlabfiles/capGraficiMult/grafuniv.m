%% Importazione dati 
X = readtable("grafuniv.xlsx",'ReadRowNames',true);
rownam=X.Properties.RowNames;
% Xd = array che contiene i 12 numeri
Xd=X{:,1};
rownam=categorical(rownam,rownam);

%% Creazione dei grafici
subplot(2,3,1)  % inserisce il primo grafico nel pannello in alto a sx
% La funzione bar crea il grafico a barre verticali
mx=mean(Xd);
bar(rownam,Xd,'BaseValue',mx)
title('Grafico a barre verticali')

subplot(2,3,2) 
barh(rownam,Xd,'BaseValue',mx) % grafico a barre orizzontali
title('Grafico a barre orizzontali')

subplot(2,3,3) 
plot(rownam,Xd) % grafico a linee
title('Grafico a linee')

subplot(2,3,4) 
% La funzione area crea il grafico ad area
area(rownam,Xd) % grafico ad area
title('Grafico ad area')

subplot(2,3,5)
stairs(rownam,Xd) % grafico a gradini
title('Grafico a gradini')

subplot(2,3,6)
stem(rownam,Xd)
title('Grafico a steli')

%% 
% subplot(2,3,6)
% % Creazione della sequenza di valori theta da 0 a 2pi
% % (in radianti), ossia la sequenza
% % 0, 30, 60, ..., 360 in gradi
% theta=linspace(0,2*pi,13);
% % Considero solo i primi 12 valori di theta (in quanto i valori 0 e 360
% % gradi corrispondono alla stessa direzione).
% compassplot(theta(1:12),Xd)
% % Si aggiungono le etichette
% set(gca,'ThetaTickLabel',rownam)
% 
% print -depsc grafuniv.eps;



