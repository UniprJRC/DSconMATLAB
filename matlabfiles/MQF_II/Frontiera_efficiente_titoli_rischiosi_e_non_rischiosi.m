%% FRONTIERA EFFICIENTE - CASO TITOLO NON RISCHIOSO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% GENERA LA FRONTIERA EFFICIENTE NEL CASO DI DI DUE TITOLI
%%% RISCHIOSI E UNO NON RISCHIOSO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Input necessari per il modello media-varianza
mu_A		= 0.08;
mu_B		= 0.13;
sigma_A	= 0.12;
sigma_B	= 0.20;
corAB   = 0;
% Aggiungiamo il titolo risk-free con rendimento uguale a 0.05
rf=0.05;

%% la matrice varianze-covarianze e il vettore dei rendimenti attesi
V =  [ sigma_A^2 corAB*sigma_A*sigma_B ; corAB*sigma_A*sigma_B sigma_B^2 ];
R = [mu_A ; mu_B ];


%% calcola la frontiera efficiente con il titolo non rischioso incluso
n=2;% numero dei titoli rischiosi
mu_n    = 50;% numero di punti della frontiera efficiente
ER_i    = linspace(min(R),max(R),mu_n);% i rendimenti attesi desiderati

sigma_i = ones(mu_n,1);% prealloca la deviazione standard dei portafogli     
valore_iniziale = ones(n,1)/n;% la nostra guess
for i=1:mu_n
    %%% per ciascun rendimento atteso ER_i calcola
    %%% la deviazione standard del portafogli utilizzando la funzione fmincon
    [~, fval] = fmincon(@(x) sqrt(x'*V*x), ...     % la funzione da minimizzare
                valore_iniziale, ...               % imposta i valori di ipotesi/partenza
                [], [], ...                        % nessun vincolo di disuguaglianza
                R'-rf*ones(1,n), ...               % termine Aeq -> vincolo di uguaglianza Aeq*x=beq
                ER_i(i)-rf, ...                    % termine beq -> vincolo di uguaglianza Aeq*x=beq
                []);                               % non abbiamo altri vincoli
    sigma_i(i) = fval;                             % memorizza la deviazione standard corrispondente
end

%% calcola la frontiera dei portafogli con solo titoli rischiosi 

sigma2_i = ones(mu_n,1);% prealloca la deviazione standard dei portafogli         
for i=1:mu_n
      %%% per ciascun rendimento atteso ER_i calcola
      %%% la deviazione standard del portafogli utilizzando la funzione fmincon
          [~, fval] = fmincon(@(x) sqrt(x'*V*x), ... % la funzione da minimizzare
                    valore_iniziale, ...             % imposta i valori di ipotesi/partenza
                    [], [], ...                      % nessun vincolo di disuguaglianza
                    [ones(1,n) ; R'], ...            % termine Aeq -> vincolo di uguaglianza Aeq*x=beq
                    [ 1 ; ER_i(i) ], ...             % termine beq -> vincolo di uguaglianza Aeq*x=beq       
                    []);                             % non abbiamo altri vincoli
           sigma2_i(i) = fval;                       % memorizza la deviazione standard corrispondente
           
end


%% calcola il portafogli di tangenza
sharpe_ratio = @(x) -(R'*x-rf)/(sqrt(x'*V*x));% l'opposto dell'indice di Sharpe
[X_tangency, fval] = fmincon(sharpe_ratio, ...       % la funzione da minimizzare
                    valore_iniziale, ...             % imposta i valori di ipotesi/partenza
                    [], [], ...                      % nessun vincolo di disuguaglianza
                    ones(1,n) , ...                  % termine Aeq -> vincolo di uguaglianza Aeq*x=beq
                     1 , ...                         % termine beq -> vincolo di uguaglianza Aeq*x=beq   
                    []);                             % non abbiamo altri vincoli

% calcola il rendimento atteso e la deviazione standard del portafogli di tangenza
mu_tangency=R'*X_tangency;% il rendimento atteso
fval_tangency=sqrt(X_tangency'*V*X_tangency);% la deviazione standard

%%  fa il plot del rendimento atteso e la deviazione standard dei portafogli calcolati precedentemente
figure
sigma_inew=[0;sigma_i];% il vettore delle deviazioni standard includendo anche la deviazione standard del titolo non rischioso
ER_inew=[rf;ER_i'];% il vettore dei rendimenti attesi
plot(sigma_inew,ER_inew);% plotta il rendimento atteso e la deviazione standard dei portafogli con entrambi i titolo rischiosi
% e quello non rischioso
xlabel('Rischio (std)');% titolo dell'asse x
ylabel('Valore atteso');% titolo dell'asse y
hold on;% aggiungi grafici al grafico esistente
plot(sigma2_i,ER_i,'r');% plotta il rendimento atteso e la deviazione standard dei portafogli con solo titoli rischiosi
hold on;% aggiungi grafici al grafico esistente
scatter(fval_tangency,mu_tangency,50, 'k', 'filled')% plotta il portafogli di tangenza
legend('Portafogli Aleatori con titoli rischiosi e il titolo risk-free','Portafogli Aleatori con solo titoli rischiosi', 'Portafogli di Tangenza', 'Location','northwest')
% aggiungi legenda
hold off;% interrompe la sovrapposizione di grafici


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Nota che per plottare la frontiera efficiente con i titoli rischiosi e quello 
%%%%% non rischioso si potrebbe alternativamente utilizzare l'equazione di
%%%%% una retta. 
%%%%% Esempio: 
%%%%% dev_new=linspace(0,fval_tangency+0.1, 50);
%%%%% line_n=rf-fval*(dev_new);
%%%%% plot(dev_new,line_n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
