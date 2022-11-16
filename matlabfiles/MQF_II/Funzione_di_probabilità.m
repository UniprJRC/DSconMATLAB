%% Il grafico della funzione di probabilità di una determinata variabile aleatoria X  

%X = la variabile aleatoria
%nbins = numero delle colonne
%xx = la posizione del centro (sull'asse x) di ciascuna colonna
%N = numero degli elementi appartenenti a ciascuna colonna

clear all;
close all;
clc;

nbins=10;%numero delle colonne
X_min=min(X); %minimo della variabile aleatoria X
X_max=max(X); %massimo della variabile aleatoria X
binc=linspace(X_min,X_max,nbins);%genera "nbins" numeri con valori equidistanti
[N,xx]=hist(X,binc);%visualizza il numero degli elementi e la posizione 
%del centro di ciascuna colonna
bar(xx,N);%il grafico a colonne utilizzando le frequenze assolute
bar(xx,N/sum(N));%il grafico a colonne utilizzando le frequenze relative

%% Un esempio
X=binornd(10,1/2, 1000,1);%simula 1000 valori da una variabile aleatoria 
% binomiale con parametri 10 e 1/2
X_min=min(X);%minimo della variabile aleatoria X
X_max=max(X);%massimo della variabile aleatoria X
binc=linspace(X_min,X_max,10);
[N,xx]=hist(X,binc);
bar(xx,N,'edgecolor', [.25 .25 .25],'facecolor',[.25 .25 .25]);%il grafico a colonne utilizzando le frequenze assolute
bar(xx,N/sum(N),'edgecolor', [.25 .25 .25],'facecolor',[1, 0, 0]);%il grafico a colonne utilizzando le frequenze relative
xlabel('x', 'FontWeight','bold', 'FontSize',12);
title('Funzione di Probabilità', 'FontWeight','bold', 'FontSize',12);
grid on;
binopdf(1,10,1/2);%fai il confronto tra la probabilità vera e quella trovata
%con l'aiuto del grafico a colonne
binopdf(5,10,1/2);%fai il confronto tra la probabilità vera e quella trovata
