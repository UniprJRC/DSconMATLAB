%% Generazione dei due gruppi
rng default
% Generazione dei dati
n1=10;
n2=20;
p=2;
X1=randn(n1,p);
dx=5;
X2=dx+randn(n2,p);
% Combinare i due gruppi in una matrice di dimensione (n1+n2)-by-p;
X=[X1; X2];
n=n1+n2;

%% Una sola iterazione del metodo delle k-medie
% index = vettore che contiene le unità da utilizzare come valori iniziali
% dei centroidi
index = [5 15 25];

% k viene fissato a priori
k=3;

% cini= matrice di dimensione 3xp che contiene
% i centroidi iniziali dei 3 gruppi
cini=X(index,:);

D=zeros(n,k);

for j=1:k
    D(:,j)=sum((X-cini(j,:)).^2,2);
end

[dist,ind]=min(D,[],2);

sumd=0;
for j=1:k
    Xj=X(ind==j,:);
    cini(j,:)=mean(Xj);
    sumd=sumd+sum(sum((Xj-cini(j,:)).^2,2));
end

disp('Valore della funzione obiettivo alla prima iterazione')
disp(sumd)

%% 10 iterazioni
% index = vettore che contiene gli indici da utilizzare come valori iniziali dei centroidi
index = [5 15 25];

k=length(index);
n=size(X,1);

cini=X(index,:);

D=zeros(n,k);

niter=10;
% Obj = vettore che contiene il valore della funzione obiettivo per ogni
% iterazione
Obj=zeros(niter,1);

for iter =1:niter

    for j=1:k
        D(:,j)=sum((X-cini(j,:)).^2,2);
    end

    [dist,ind]=min(D,[],2);

    % Ricalcolo dei nuovi centroidi e del nuovo valore della funzione obiettivo
    sumd=0;
    for j=1:k
        Xj=X(ind==j,:);
        cini(j,:)=mean(Xj);
        sumd=sumd+sum(sum((Xj-cini(j,:)).^2,2));
    end

    % Il valore della funzione obiettivo all'iterazione iter viene inserita
    % in posizione iter del vettore Obj
    Obj(iter)=sumd;

end

plot(Obj)
xlabel('Iterazioni')
ylabel('Valore della funzione obiettivo')
% print -depsc figs\kmeansINI.eps;


%% Utilizzo funzione kmeans
k=3;
[idx,cent,sumdj]=kmeans(X,k,"Replicates",100);
% Verifico che il secondo argomento di output della funzione kmeans
% contiene le medie aritmetiche dei 3 gruppi
Centroidi=grpstats(X,idx);
assert(max(abs(cent-Centroidi),[],"all")<1e-08,'Errore di programmazione')
sumd=sum(sumdj);
disp(['Il valore della funzione obiettivo minimizzata è=' num2str(sumd)])

disp("Centroidi dei gruppi")
disp(cent)

% Classificazione finale e centroidi
gscatter(X(:,1),X(:,2),idx,'brk','xos',15)
hold('on')
gscatter(Centroidi(:,1),Centroidi(:,2),1:k,'brk','p',15)
title('Classificazione finale e centroidi')
% print -depsc figs\kmeansINI1.eps;

%% Funzione evalclusters
eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',1:6);
figure
plot(eva);
% Recupero l'assegnazione delle unità ai diversi gruppi in corrispondenza
% del valore ottimale di k
idx=eva.OptimalY;
k=eva.OptimalK;
% Calcolo dei centroidi
Centroidi=grpstats(X,idx);
figure
% Classificazione finale e centroidi
gscatter(X(:,1),X(:,2),idx,'br','xo',15)
hold('on')
gscatter(Centroidi(:,1),Centroidi(:,2),1:k,'brk','p',15)
title('Classificazione finale con il valore di k ottimale e centroidi')
% print -depsc figs\kmeansINI3.eps;


%% Adjusted Rand Index
n1=10; n2=20;
% Vera partizione
idxtrue=[ones(n1,1);2*ones(n2,1)];
Radj=RandIndexFS(idx,idxtrue);
disp("Il valore dell'indice di Rand aggiustato è pari a: "+string(Radj))

