% Esempi di clustering gerarchico con dataset simulato

rng default
% Definisco il numero di unità in ciascun gruppo e la dimensione p
n1=10;
n2=20;
p=2;
X1=randn(n1,p);
dx=5;
X2=dx+randn(n2,p);
% I due gruppi vengono combinati in una matrice di dimensione (n1+n2)-by-p;
X=[X1; X2];

subplot(2,2,1)
% Diagramma di dispersione con simboli diversi per i due gruppi
hold('on')
plot(X1(:,1),X1(:,2),'bx','MarkerFaceColor','b')
plot(X2(:,1),X2(:,2),'rs','MarkerFaceColor','r')

subplot(2,2,2)
% Grafico a dispersione delle due colonne della matrice X con
% l'aggiunta del numero di ogni unità
lab=num2str((1:n1+n2)');
plot(X(:,1),X(:,2),'o')
text(X(:,1),X(:,2),lab)

% print -depsc figs\cluster.eps;

%% Cluster gerarchico utilizzando il metodo di Ward (Es. 14.4)
% Si noti che questa volta l'input di linkage è la matrice dei dati
% Il terzo argomento euclidean poteva essere omesso
tree = linkage(X,'ward','euclidean');
% cutoff è la variabile che specifica dove tagliare il dendrogramma
cutoff=7;
dendrogram(tree,0,'ColorThreshold',cutoff)
id=cluster(tree,"criterion","distance","cutoff",cutoff);
% Viene mostrata la distribuzione di frequenza delle assegnazioni delle
% unità ai diversi gruppi
disp(['Gruppi'   '        n_i'     '       100*f_i'])
disp(tabulate(id))
% Viene mostrata la matrice dei diagrammi di dispersione con l'indicazione
% del gruppo di appartenenza per ogni unità
figure
spmplot(X,id)
%print -depsc figs\cluster1.eps;
%print -depsc figs\cluster2.eps;

%% Cluster analysis gerarchica (PARTE NON INSERITA NEL LIBRO)
% Applicare la metodologia del clustering gerarchico (utilizzando il
% metodo del legame medio e la metrica della distanza euclidea). Costruire
% il relativo dendrogramma, mostrando tutti i passi della procedura di
% agglomerazione.
% Personalizzare l'orientamento del dendrogramma  e/o la 'ColorThres
% Metodo gerarchico del legame medio.
close all

% Es. metodo del legame medio ('average')
% Metrica utilizzata: distanza euclidea
tree = linkage(X,'average');

% Creazione del dendrogramma
% Il secondo argomento pari a 0
% specifica di mostrare tutti i nodi
dendrogram(tree,0)
% dendrogram(tree,0,'ColorThreshold',3.5)

% Taglio del dendrogramma  alla soglia di distanza 3.5
group = cluster(tree,'cutoff',3.5,'Criterion','distance');

% spmplot di FSDA per visualizzare i gruppi ottenuti
spmplot(X,group);

%% Dendrogrammi personalizzati
% Personalizzare l'orientamento del dendrogramma  e/o la 'ColorThreshold'.
tree = linkage(X,'average');
H = dendrogram(tree,'Orientation','left','ColorThreshold','default');
% Impostazione della linewidth del dendrogramma
set(H,'LineWidth',2)

