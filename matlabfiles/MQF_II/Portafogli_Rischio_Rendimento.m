%% Genera portafogli aleatori composti da 2 titoli e fa il grafico nello spazio rischio-rendimento.


% Input necessari per il modello media-varianza
mu_A		= 0.02;% rendimento atteso del titolo A
mu_B		= 0.01;% rendimento atteso del titolo B
sigma_A	= 0.03;% deviazione standard del titolo A
sigma_B	= 0.01;% deviazione standard del titolo B
corAB   = 0;% correlazione tra i due titoli

%% calcolo del rendimento atteso e deviazione standard del rendimento di un portafogli specifico utilizzando la forma non-matriciale
X = [ 0.2 ; 0.8 ];% pesi del portafogli 
% calcolo del rendimento atteso del portafogli X
mu_p=X(1)*mu_A+X(2)*mu_B;
% calcolo della deviazione standard del rendimento del portafogli X
std_p=sqrt(X(1)^2*sigma_A^2+X(2)^2*sigma_B^2+2*X(1)*X(2)*sigma_A*sigma_B*corAB);


%% calcolo del rendimento atteso e deviazione standard del rendimento di un portafogli specifico utilizzando la forma matriciale


V =  [ sigma_A^2 corAB*sigma_A*sigma_B ; corAB*sigma_A*sigma_B sigma_B^2 ];% matrice di varianza-covarianza
R = [mu_A ; mu_B ];% vettore dei rendimenti attesi

% calcolo del rendimento atteso e della deviazione standard del rendimento del portafogli X
ERP      = X'*R;
sigmaP  = sqrt(X'*V*X);

%% genera 1000 portafogli aleatori
n_portfolio = 1000;% il numero dei portafogli da generare
r_p 		= zeros(n_portfolio,1);% prealloca il rendimento atteso dei portafogli 
var_p 	= zeros(n_portfolio,1);% prealloca la varianze dei rendimenti dei portafogli 
Xp	 		= zeros(2,n_portfolio);% prealloca le quote dei due titoli per ciascun portafogli 

% genera e calcola il valore attesso e la varianza di 1000 portafogli con
% pesi generati da una uniforme con parametri 0 e 1
for i = 1:n_portfolio
	x1 		= rand(); % peso del primo titolo generato da una uniforme [0,1]
	Xp(:,i) = [ x1 ; 1-x1 ];% vettore dei pesi con il  vincolo di budget soddisfatto
	r_p(i)      = Xp(:,i)'*R;% rendimento atteso del rendimento di ciascun portafogli 
	var_p(i)  = Xp(:,i)'*V*Xp(:,i);% varianza del rendimento di ciascun portafogli 
end
sig_p=sqrt(var_p);% deviazionne standard del rendimento di ciascun portafogli 

% fai il plotting della deviazione standard e rendimento atteso dei
% portafogli generati
scatter(sig_p,r_p, 'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5);% grafico a dispersione
xlabel('Rischio (std)');% titolo dell'asse x
ylabel('Valore atteso');% titolo dell'asse y
title('Rischio-Rendimento');% titolo del nostro grafico