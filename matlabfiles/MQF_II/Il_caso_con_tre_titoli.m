%% Genera portafogli aleatori composti da 3 titoli e fa il grafico nello spazio rischio-rendimento.

% Input necessari per il modello media-varianza
mu_A		= 0.02;
mu_B		= 0.01;
mu_C		= 0.04;
sigma_A	= 0.08;
sigma_B	= 0.01;
sigma_C	= 0.09;
corAB  = -0.2;
corAC=0.2;
corBC=-0.1;

%% calcolo del rendimento atteso e deviazione standard del rendimento di un portafogli specifico utilizzando la forma matriciale
V =  [	sigma_A^2 					corAB*sigma_A*sigma_B 		corAC*sigma_A*sigma_C ;
		corAB*sigma_A*sigma_B 		sigma_B^2 					corBC*sigma_C*sigma_B; 
		corAC*sigma_A*sigma_C 		corBC*sigma_C*sigma_B		sigma_C^2];
R = [mu_A ; mu_B ; mu_C ];

% un portafogli aleatorio
X = [ 0.3 ; 0.4 ; 0.3 ];
ERP      = X'*R;
sigmaP  = sqrt(X'*V*X);


n_portfolio = 1000;% il numero dei portafogli da generare
r_p 		= zeros(n_portfolio,1);% prealloca il rendimento atteso dei portafogli 
var_p 	= zeros(n_portfolio,1);% prealloca la varianze dei rendimenti dei portafogli 
Xp	 		= zeros(3,n_portfolio);% prealloca le quote dei due titoli per ciascun portafogli 

%% genera 1000 portafogli aleatori e calcola i loro valore attesi e deviazione standard
for i = 1:n_portfolio
	X 			= rand(3,1);% genera tre numeri casuali da una uniforme [0,1]
	Xp(:,i) 			= X/sum(X);% vettore dei pesi con il  vincolo di budget soddisfatto
	r_p(i)   	= Xp(:,i)'*R;% rendimento atteso del rendimento di ciascun portafogli 
	var_p(i)  = Xp(:,i)'*V*Xp(:,i);% varianza del rendimento di ciascun portafogli
end
sig_p=sqrt(var_p);% deviazionne standard del rendimento di ciascun portafogli 

%% fai il plotting della deviazione standard e rendimento atteso dei portafogli generati
scatter(sig_p,r_p, 'MarkerEdgeColor',[0 .5 .5],...
              'MarkerFaceColor',[0 .7 .7],...
              'LineWidth',1.5);% grafico a dispersione
xlabel('Rischio (std)');% titolo dell'asse x
ylabel('Valore atteso');% titolo dell'asse y
title('Rischio-Rendimento');% titolo del nostro grafico

%% calcola il portafogli di minima varianza
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   R uguale al vettore dei rendimenti attesi
%   V uguale alla matrice di varianza-covarianza
%   n ci dà il numero dei titoli del nostro portafogli 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n		= 3;								
[Xmin, fvalmin] = fmincon(@(x) sqrt(x'*V*x), ... % la funzione da minimizzare
                ones(n,1)/n, ...                 % imposta i valori di ipotesi/partenza
                [], [], ...                      % nessun vincolo di disuguaglianza
                ones(1,n), ...     	             % termine Aeq -> vincolo di uguaglianza Aeq*x=beq
                1, ...                           % termine beq -> vincolo di uguaglianza Aeq*x=beq
				...							     % vincolo : somma(pesi) = 1
                zeros(n, 1), []);                % limite inferiore sui pesi x               
%calcola il rendimento atteso del portafogli di minima varianza
mu_min=Xmin'*R;

%% calcola la frontiera efficiente

numberp    = 40;                                    % numero di punti della frontiera efficiente
mu_i    = linspace(mu_min,max(R),numberp); 			% il valore atteso desiderato
sigma_i = zeros(numberp,1);                         % prealloca la deviazione standard dei portafogli 
for i=1:numberp
    %%% per ciascun valore atteso calcola
    %%% la deviazione standard del portafogli utilizzando la funzione fmincon
    [X, fval] = fmincon(@(x) sqrt(x'*V*x), ... % la funzione da minimizzare
                ones(n,1)/n, ...               % imposta i valori di ipotesi/partenza
                [], [], ...                    % nessun vincolo di disuguaglianza
                [ones(1,n) ; R'], ...     	   % termine Aeq -> vincolo di uguaglianza Aeqx=beq
                [ 1 ; mu_i(i) ], ...           % termine beq -> vincolo di uguaglianza Aeqx=beq
				...							   % primo vincolo : somma(pesi) = 1
				...							   % secondo vincolo : valore atteso portafogli = mu_i
                zeros(n, 1), []);              % limite inferiore sui pesi x              
    sigma_i(i) = fval;                         % memorizza la deviazione standard corrispondente
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  fa il plot del rendimento atteso e la deviazione standard dei portafogli calcolati precedentemente
figure
scatter(sig_p,r_p); % grafico a dispersione
xlabel('Rischio (std)');% titolo dell'asse x
ylabel('Valore atteso');% titolo dell'asse y
hold on;% aggiungi grafici al grafico esistente
plot(sigma_i,mu_i,'r'); % plotta il rendimento atteso e la deviazione standard dei portafogli
%calcolati precedentemente
hold on; % aggiungi grafici al grafico esistente
%plotta il portafogli di minima varianza
scatter(fvalmin,mu_min,50, 'k', 'filled');
legend('Portafogli Aleatori','Portafogli Efficienti', 'Portafogli di Minima Varianza', 'Location','northwest');% aggiungi legenda
hold off;% interrompe la sovrapposizione di grafici
