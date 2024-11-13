%% Preparazione input
% Vettore che contiene gli elementi sopra la diagonale principale della
% matrice delle distanze (v. slides)
distanze=[13.123 2.506 17.060 15.628 4.391 19.542];
labels={'1:A', '2:B', '3:C', '4:D'};

%% Clustering con il metodo del legame singolo e dendrogramma
out=linkage(distanze,'single');
% dendrogram(out);

dendrogram(out,'Labels',labels)
title('Dendrogramma basato sul metodo del legame singolo')
ylabel('Livelli di distanza con cui avviene l''aggregazione')


%% Clustering con il metodo del legame completo e dendrogramma
out=linkage(distanze,'complete');
% dendrogram(out);
 dendrogram(out,'labels',labels);
title('Dendrogramma basato sul metodo del legame completo')
ylabel('Livelli di distanza con cui avviene l''aggregazione')

%% Clustering con il metodo del legame medio e dendrogramma
out=linkage(distanze,'average');
dendrogram(out);
title('Dendrogramma basato sul metodo del legame medio')
ylabel('Livelli di distanza con cui avviene l''aggregazione')



%% Esempio 5 modelli di auto
% Vettore che contiene gli elementi sopra la diagonale principale della
% matrice delle distanze (v. slides)
distanze=[10.842 3.384 2.888 9.146 13.777 12.646 6.356 2.137 12.081 10.950];
labels={'1:PUNTO', '2:BRAVO', '3:FIESTA', '4:CORSA', '5:GOLF'};
%% Clustering con il metodo del legame singolo e dendrogramma
out=linkage(distanze,'single');
dendrogram(out,'labels',labels);
title('Dendrogramma basato sul metodo del legame singolo')

%% Clustering con il metodo del legame completo e dendrogramma
out=linkage(distanze,'complete');
dendrogram(out,'labels',labels);
title('Dendrogramma basato sul metodo del legame completo')


%% taglio del dendrogramma
cutoff=8;
% per costruire un dendrogramma personalizzati con colori diversi a seconda
% della soglia
dendrogram(out,'ColorThreshold',cutoff,'Orientation','left');
ylabel('Taglio del dendrogramma alla soglia di distanza 8')
% taglio del dendrogramma e allocazione delle unità ai diversi gruppi
idx=cluster(out,'cutoff',cutoff,'Criterion','distance');

disp(idx)
% Commento le unità 1 3 e 4 (Punto, Fiesta e Corsa) formano un gruppo. Le
% altre due unità 2 e 5 (Bravo e Golf) formano un altro gruppo.

% Visualizzazione labels delle unità e gruppo di appartenenza
disp(strcat(num2str(idx),'--',labels'))

%% Nuove opzione MATLAB 2024b
% ShowCut (true/false)
% 
cutoff=4;
dendrogram(out,'labels',labels,'ColorThreshold',cutoff, ...
    'ShowCut',true);

%% Nuove opzioni MATLAB 2024b 
% ShowMarkers',true,'ClusterIndices',idx
% Le unità appaiono con un simbolo e un colore diverso a seconda del gruppo
% di appartenenza
idx=cluster(out,'cutoff',cutoff,'Criterion','distance');
dendrogram(out,'labels',labels,'ColorThreshold',cutoff, ...
    'ShowCut',true,'ShowMarkers',true,'ClusterIndices',idx);

