% Fisso il seed per la replicabilità dei risultati
rng(100)
disp("Matrice 4x4 di numeri casuali interi dall'insieme (1, 2, ..., 8)")
disp(randi(8,4))


%% Numeri casuali uniformi dall'insieme 11, 12, ..., 20
imin=11;
imax=20;
n=10000;
x=randi([imin,imax],[n,1]);
% la funzione tabulateFS di FSDA toolbox 
% crea la distribuzione di frequenze delle modalità 
% del vettore numerico x
TB=tabulateFS(x);
bar(TB(:,1),TB(:,2))
i1=num2str(imin);
i2=num2str(imin+1);
in=num2str(imax);
titolo=['Grafico a barre di ' num2str(n) ' numeri casuali '];
sottotitolo=['generati da una distribuzione uniforme discreta definita nell''insieme (' i1 ',' i2 ', ...,' in ')'];
title(titolo,sottotitolo)
% print -depsc figs\uniformeDisc.eps;

%% Distribuzione di frequenze tramite la funzione pivot
% pivot(array2table(x),'Rows','x','RowsBinMethod',imin:(imax+1))