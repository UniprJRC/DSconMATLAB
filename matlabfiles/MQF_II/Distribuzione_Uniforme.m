%% Approssimazione della funzione di densità di probabilità di una variabile aleatoria uniforme

% 1. Generare 10.000 numeri casuali da una distribuzione uniforme tra 4 e 8
% 2. Calcolare media, varianza e deviazione standard 
% 3. Plottare l'istogramma approssimando la funzione di densità di probabilità

close all
clear all
clc

number=10000;
rstat=4+(8-4)*rand(number,1);% genera "number" numeri da una distribuzione 
% uniforme can parametri 4 e 8
disp(mean(rstat));% visualizza la media di "rstat"
disp(std(rstat));% visualizza la deviazione standard di "rstat"
disp(var(rstat));% visualizza la varianza di "rstat"
step=0.1;% 
x_step=2:step:10;% ci restituisce i valori da utilizzare come posizione 
% centrale di ciascuna colonna dell'istogramma 
[a,b]=hist(rstat, x_step);% visualizza il numero degli elementi e la posizione 
% centrale (sull'asse x) di ciascuna colonna
pdf_e=a./sum(a)./step;% approssimazione della funzione di densità di probabilità
% della variabile aleatoria uniforme con parameteri a e b
figure; plot(b,pdf_e, 'r--'); % ci plotta l'approssimazione della 
% funzione di densità di probabilità

%confronta l'approssimazione con la vera funzione di densità di probabilità
% di una uniforme con parametri 4 e 8
hold on% aggiungi grafici al grafico esistente
pd_unif=makedist('Uniform', 'lower', 4, 'upper',8);% crea un oggetto in Matlab.
%L'oggetto in questo caso è la distribuzione uniforme con parametri 4 e 8
x=2:0.01:10;% genera valori equidistanti tra 2 e  10
pdf_u=pdf(pd_unif,x);% calcola la densità per ciascuno dei valori generati
% precedentemente
plot(x,pdf_u,'k','LineWidth',2);% aggiungi ora il grafico della funzione di
%densità vera
title('Approssimazione della funzione di densità di probabilità di una v.a. uniforme')
xlabel('Osservazioni')
ylabel('Funzione di densità di probabilità')