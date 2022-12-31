
%% Generazione della matrice 300x2 dalla distr. normale biv
rng(1)
n=300;
mu=[2;3];
covarianza=0.93;
R= [1.2 covarianza;covarianza 0.95];
% Genero i dati utilizzando la distribuzione normale bivariata
% con i valori di mu e Sigma specificati 
X = mvnrnd(mu,R,n);

%% Calcolo della distanza Euclidea e di Mahalanobis dal centroide
% Calcolo del centroide
cent=mean(X);

% d2_Euclidean =vettore nx1 che contiene la distanza Euclidea al quadrato
% di ogni riga dal centroide
d2_Euclidean = sum((X-cent).^2,2);

% d2_mahal =  =vettore nx1 che contiene la distanza di Mahalanobis  al
% quadrato di ogni riga dal centroide
d2_mahal = mahal(X,X).^2;

% Implementazione utilizzando la funzione mahalFS dell'FSDA toolbox
S=cov(X);
ds_mahalFSDA=(mahalFS(X,cent,S)).^2;

%% Diagramma di dispersione con colore che dipende da dist Eucl

% Il quarto argomento di scatter è il colore. In questo caso il colore
% dipende dal valore della corrispondente distanza
scatter(X(:,1),X(:,2),50,d2_Euclidean,'o','filled')
hb = colorbar;
ylabel(hb,'Distanza Euclidea')
colormap jet
% Le osservazioni che presentano la più grande distanza Euclidea sono
% quelle in basso a sinistra e quelle in alto a destra.
% print -depsc figs\EuclidMala1.eps;

%% Grafico con contorni di equiprobabilità
figure
scatter(X(:,1),X(:,2),50,d2_Euclidean,'o','filled')
hb = colorbar;
ylabel(hb,'Distanza Euclidea')
colormap jet
prob=[0.50 0.75 0.95];
hold('on')
for j=1:3
    ellipse(cent,eye(2),prob(j))
end
axis equal
% print -depsc figs\EuclidMala2.eps;

%% Costruire un diagramma di dispersione delle due variabili presenti dentro
figure
scatter(X(:,1),X(:,2),50,d2_mahal,'o','filled')
hb = colorbar;
ylabel(hb,'Distanza di Mahalanobis')
colormap jet
% print -depsc figs\EuclidMala3.eps;
%% Confronto tra distanza Euclidea e distanza di Mahalanobis
figure
scatter(X(:,1),X(:,2),50,d2_mahal,'o','filled')
hb = colorbar;
ylabel(hb,'Distanza di Mahalanobis')
colormap jet

hold('on')
for j=1:3
    ellipse(cent,S,prob(j))
end
axis equal

% print -depsc figs\EuclidMala4.eps;

%% Correlazione tra le graduatorie delle distanze
corr([d2_Euclidean d2_mahal],'type','Spearman')