%% Il grafico della funzione di ripartizione (cumulativa) della variabile aleatoria X (investimento) 

% I valori assunti da questa variabile sono due: 0 e 100.
clear all;
clc;

X=[0 100];%i valori della mia variabile aleatoria (vettore riga)
p=[0.95 0.05];%le probabilità dei singoli valori  (vettore riga)
F_CDF=cumsum(p);%la somma cumulativa; nel nostro caso le probabilità che X 
%sia minore o uguale a 0 o minore o uguale a 100
stairs(X,F_CDF, 'LineWidth',2,'color', 'k','LineStyle','--');%il plot 
%della funzione cumulativa utilizzando la funzione a scalini/gradini
title('Funzione di Ripartizione')
xlabel('x')
ylabel('F_X(x)')

%%%%%%%Ulteriori modifiche all'aspetto della funzione di ripartizione
hold on%consente di aggiungere grafici al grafico già esistente
A1=[0 0];%le coordinate di due punti specifici
B1=[0 0.95];%le ordinate di due punti specifici
%i punti sono (0,0) e (0,0.95)
line(A1,B1,'LineWidth',2, 'LineStyle','--', 'color','k');%traccia una linea 
%che mi collega i due punti precedenti
%le comande successive ripetono la stessa operazione per altri due punti 
hold on
A2=[0 -10];
B2=[0 0];
line(A2,B2,'LineWidth',2, 'LineStyle','--', 'color','k');
hold on
A3=[100 110];
B3=[1 1];
line(A3,B3,'LineWidth',2, 'LineStyle','--', 'color','k');
xlim([-10 110])%determina i limiti dell'asse (minimo -10 e massimo 110)
