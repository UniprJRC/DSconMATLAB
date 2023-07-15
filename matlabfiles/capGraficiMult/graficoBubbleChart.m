%% bubblechart con 3 variabili (senza colorbar)
X=readtable("regioni.xlsx",'ReadRowNames',true);
% Grafico a bolle 
bubblechart(X,"TassoPassaggio","TassoIscrizione","Residenti")
nomi=X.Properties.RowNames;
% L'istruzione text aggiunge le etichette ai punti
text(X.TassoPassaggio,X.TassoIscrizione,nomi)

%% bubblechart con 4 vaiabili (con colorbar) 
iscrFR="IscrittiFuoriRegione";
% bubblechart viene chiamato con 4 argomenti di input
bubblechart(X,"TassoPassaggio","TassoIscrizione","Residenti",iscrFR)
% Con l'istruzione colorbar viene aggiunta la barra di colore
c=colorbar;
% Con l'istruzione che segue si aggiunge il nome alla colorbar
c.Label.String = iscrFR;
text(X.TassoPassaggio,X.TassoIscrizione,X.Properties.RowNames)