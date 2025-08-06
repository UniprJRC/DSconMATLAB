% d =vettore che contiene la parte triangolare superiore della matrice D
d=[0.31 0.23 0.32 0.26 0.25 0.34 0.21 0.36 ...
    0.28 0.31 0.04 0.07 0.31 0.28 0.09];
D=squareform(d);
n=size(D,1);
names=string((1:n)');
Dt=array2table(D,"RowNames",names,"VariableNames",names);
% Inserisco i valori NaN sulla diagonale principale in quanto devo cercare
% il minimo tra i valori della matrice D escludendo gli zeri sulla
% diagonale principale. Boo è una matrice booleana che contiene true per i
% valori che si collocano sulla diagonale principale;
Boo=logical(eye(size(D)));
D(Boo)=NaN;
% Si trova il valore più piccolo della matrice D
minimo = min(D,[],'all');
% indi e indj contengono gli indici di riga e colonna della matrice delle
% distanze in corrispondenza dei quali si ha il valore più piccolo di D
[indi,indj]=find(D==minimo);
unitCheSiAggregano=[indi(1) indj(1)];

disp('Al primo step si aggrega l''unità')
disp(Dt.Properties.RowNames(unitCheSiAggregano(1)))
disp('con l''unità')
disp(Dt.Properties.RowNames(unitCheSiAggregano(2)))
disp(['al livello di distanza ' num2str(minimo)])

% uniNonAggre è il vettore che contiene le unità che non si sono aggregate
seq=1:size(D,1);
uniNonAggre=setdiff(seq,unitCheSiAggregano);

% D1t = table di dimensione (n-1)x(n-1) che conterrà le distanze dopo
% la prima aggregazione
D1t=Dt;
D1t(unitCheSiAggregano(1),:)=[];
D1t(:,unitCheSiAggregano(1))=[];
unitCheSiAggreganoLab=string(unitCheSiAggregano(2))+...
            ","+string(unitCheSiAggregano(1));
D1t.Properties.RowNames(unitCheSiAggregano(2))=unitCheSiAggreganoLab;
D1t.Properties.VariableNames(unitCheSiAggregano(2))=unitCheSiAggreganoLab;
D1t{unitCheSiAggregano(2),:}=0;
D1t{:,unitCheSiAggregano(2)}=0;

for i=1:length(uniNonAggre)
    % Prendo il massimo delle distanze tra l'unità i-esima 
    % non ancora aggregata e la coppia che si è aggregata
    maxdist=max(D(uniNonAggre(i),unitCheSiAggregano));
    % maxdist viene inserito dentro Dtable
    if i<unitCheSiAggregano(2)
        D1t{unitCheSiAggregano(2),i}=maxdist;
    else
        D1t{unitCheSiAggregano(2),i+1}=maxdist;
    end
end
D1t{:,unitCheSiAggregano(2)}=D1t{unitCheSiAggregano(2),:}';
disp('Matrice di distanze di dimensione 5x5 dopo la prima aggregazione')
disp(D1t)

D3=D1t{:,:};
D3(Boo(1:end-1,1:end-1))=NaN;
minimo = min(D3,[],'all');
[indi,indj]=find(D3==minimo);
unitCheSiAggregano=[indi(1) indj(1)];
disp('Al secondo step si aggregano le unità')
disp(D1t.Properties.RowNames(unitCheSiAggregano(1)))
disp('con le unità')
disp(D1t.Properties.RowNames(unitCheSiAggregano(2)))
disp(['al livello di distanza ' num2str(minimo)])

%% Metodo del legame completo (tutto automatizzato)
d=[0.31 0.23 0.32 0.26 0.25 0.34 0.21 0.36 0.28 0.31 0.04 0.07 0.31 0.28 0.09];
names=["1=San Pellegrino" "2=Panna" "3=Rocchetta" "4=Vera"  "5=Levissima" 
    "6=Fiuggi"];
out=linkage(d,'complete');
dendrogram(out,'Labels',names);
%     print -depsc figs\dendroINI.eps;

%% Metodo del legame medio (tutto automatizzato) (Es. 14.2)
d=[0.31 0.23 0.32 0.26 0.25 0.34 0.21 0.36 0.28 0.31 0.04 0.07 0.31 0.28 0.09];
names=["1=San Pellegrino" "2=Panna" "3=Rocchetta" "4=Vera"  "5=Levissima" "6=Fiuggi"];
out=linkage(d,'average');
dendrogram(out,'Labels',names,'Orientation','left');
%     print -depsc figs\dendroINI1.eps;

