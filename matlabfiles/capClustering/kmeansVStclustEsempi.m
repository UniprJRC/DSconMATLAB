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
close all

out_Kmeans=tkmeans(Y,2,0,'plots',1);
out_Tclust=tclust(Y,2,0,10,'plots',1);

%% esempio con gruppi sferici e con contaminazione

% Simuliamo due gruppi circolari in due variabili
rng('default');
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

