function [r_p , sig_p]=random_portfolios_general(ER, V, n_portfolio)
           
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  La funzione calcola il rendimento e la deviazione standard di "n_portfolio" portafogli 
%%%%%%%%  con pesi generati da una variabile uniforme con parametri 0 e 1. 
%INPUTS:  ER = il vettore dei rendimenti attesi; VETTORE COLONNA
%%%%%%%   V = la matrice di varianze-covarianze
%%%%%%%   n_portfolio = numero di portafogli da generare
%OUTPUTS: r_p = il vettore dei rendimenti attesi del tasso di rendimento dei portafogli
%%%%%%%%  sig_p = il vettore delle deviazioni standard del tasso di rendimento dei portafogli

% sigma_A, sigma_B = la deviazione standard del tasso di rendimento del titolo A e B

%se la dimensione è un vettore riga, allora trasponi il vettore
if size(ER,1) == 1
    ER=ER';
end

n=length(ER);% lunghezza di ER
r_p 		= zeros(n_portfolio,1);% prealloca il rendimento atteso dei portafogli 
var_p 	= zeros(n_portfolio,1);% prealloca la varianze dei rendimenti dei portafogli 
Xp	 		= zeros(n,n_portfolio);% prealloca le quote dei due titoli per ciascun portafogli 


%% genera 1000 portafogli aleatori e calcola i loro valore attesi e deviazione standard
for i = 1:n_portfolio
	x1 		= rand(n-1,1);% genera n-1 numeri casuali da una uniforme [0,1]
	Xp(:,i) = [ x1 ; 1-sum(x1) ];% vettore dei pesi con il  vincolo di budget soddisfatto
	r_p(i)      = Xp(:,i)'*ER;% rendimento atteso del rendimento di ciascun portafogli 
	var_p(i)  = Xp(:,i)'*V*Xp(:,i);% varianza del rendimento di ciascun portafogli
end
sig_p=sqrt(var_p);% deviazionne standard del rendimento di ciascun portafogli 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Applicazione%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[r_p , sig_p]=random_portfolios_general(ER, V, n_portfolio);
%scatter(sig_p,r_p)
