%% esempio con gruppi ellittici e senza contaminazione

% Simuliamo due semplici gruppi ellittici in due variabili
n1=300;
n2=200;
v=2;

rng('default');
mu1    = [2 3];
Sigma1 = [1 1.5; 1.5 3];
%Sigma1 = [1 0; 0 1];
Y1     = mvnrnd(mu1,Sigma1,n1);

mu2    = [6 4];
Sigma2 = [1 1.5; 1.5 3];
%Sigma2 = [3 0; 0 3];
Y2     = mvnrnd(mu2,Sigma2,n2);

group = ones(n1+n2,1);
group(n1+1:n1+n2)  =2;

Y=[Y1;Y2];
gscatter(Y(:,1),Y(:,2),group);

% eseguiamo Kmeans e Tclust
% Eseguiamo le k-medie e Tclust
close all
alpha   = 0;		% percentuale di trimming
k       = 2;		% numero dei gruppi
c       = 10;		% restrizione per TCLUST
out_Kmeans = tkmeans(Y,k,alpha,'plots',1);
out_Tclust = tclust(Y,k,alpha,c,'plots',1);

%% esempio con gruppi sferici e con contaminazione

% Simuliamo due gruppi circolari in due variabili
rng('default');
n1=300;
n2=200;

mu1    = [2 3];
Sigma1 = [0.4 0; 0 0.4];
Y1     = mvnrnd(mu1,Sigma1,n1);

mu2    = [6 4];
Sigma2 = [0.6 0; 0 0.6];
Y2     = mvnrnd(mu2,Sigma2,n2);

% aggiungiamo contaminazione concentrata di 50 osservazioni
n3 = 50;
cont = [3 , 5] + 0.1.*randn(n3,2);

group = ones(n1+n2,1);
group(n1+1:n1+n2)  =2;
group(n1+n2+1 : n1+n2+n3)=0;

Y=[Y1;Y2;cont];
gscatter(Y(:,1),Y(:,2),group);

close all

% percentuale di contaminazione, un po' inflazionata (denominatore senza n3)
alphareal = n3/(n1+n2);

% k-medie classico su due gruppi
out_Kmeans=tkmeans(Y,2,0,'plots',1);
% k-medie con trimming, su due gruppi
out_TKmeans2=tkmeans(Y,2,alphareal,'plots',1);
% k-medie classico, ma su tre gruppi
out_TKmeans3=tkmeans(Y,3,0,'plots',1);

%% esempio di monitoraggio del livello di trimming

% Y generato come da esempio precedente

k       = 2;		
c       = 2;		
alpha_vec = 0.00:0.02:0.14;
tclusteda(Y,k,alpha_vec,c,'plots',1);

%% esempio di monitoraggio del fattore di restrizione e del numero di gruppi

% Y generato come da esempio precedente

cc=[1 2 4 8 16];
outIC=tclustIC(Y,'plots',1,'alpha',0.1,'cc',cc);

