%% X= mm di pioggia negli ultimi 21 anni 
load rain.mat
heatmap(colNam,rowNam,X)

% print -depsc heatmapMAT.eps;

%% Caricamento dei dati in memoria
clear % clear iniziale della memoria
load("Rend.mat") % caricamento del file Rend.mat.

%% 
clear % clear iniziale della memoria
load Rend.mat; % caricamento del file Rend.mat.
titsel=["ENI" "ASSICURAZIONIGENERALI" "FINECOBANKSPA"];
Rsel=Rt{:,titsel}; % Rsel=array di doubles 
[n,p]=size(Rsel);
% classi vettore da passare a discretize
classi=[-Inf, -0.05 -0.03:0.01:0.03 0.05 +Inf];
T = table('Size',size(Rsel),'VariableTypes',repelem("categorical",p),'VariableNames',titsel);
for j=1:p
    etibin=discretize(Rsel(:,j),classi,'categorical');
    T.(titsel(j))=etibin;
end

i=2; % Variabili da inserire nelle righe della heatmap
j=3; % Variabile da inserire nelle colonne della heatmap
heatmap(T,i,j)



% print -depsc heatmapTAB.eps;


