%%%%%%%%%SOLUZIONE%%%%%%%%%%%%%%%%%
%% ESERCIZIO 1 (5 punti)

%%%1. (1 punto) Il primo termine corrisponde alla deviazione standard del portafogli e il secondo ai
%pesi ottimali del portafogli con un rendimento desiderato ER, dove il vincolo di budget è soddisfato e i pesi sono
%non-negativi e minori o uguali a uno.

%%%2. (1 punto) I due termini rappresentano i due vincoli di uguaglianza lineare. Il primo il
%vincolo di budget, somma dei pesi deve essere uguale a uno, e il secondo
%è alla base del principio media-varianza, il rendimento atteso del portafogli 
%deve essere uguale ad un rendimento desiderato ER.

%%%3. (1.5 punti) I termini v_1 e v_2 danno il limite inferiore e superiore del vettore
%x. Ci dicono che il vettore x deve soddisfare v_1<= x <= v_2, quindi il peso
%del primo titolo deve essere compreso tra -2 e 2 e quello del secondo
%titolo tra 0 e 2.

%%%3. (1.5 punti) [2 -1] e 0 rappresentano il seguente vincolo 2*x_1 - x_2 <= 0 o
%anche 2*x_1  <= x_2
%% ESERCIZIO 2 (14 punti)

%%%1. (1 punto) 

IXIC=readtable('^IXIC.csv', 'ReadVariableNames',false);
N225=readtable('^N225.csv', 'ReadVariableNames',false);
P_IXIC=IXIC.Var6;
P_N225=N225.Var6;
P_IXIC=log(P_IXIC);
P_N225=log(P_N225);
IXIC_rend=diff(P_IXIC);
N225_rend=diff(P_N225);

%%%2. (1 punto) 
covIXICN225=cov(IXIC_rend,N225_rend);
mediaIXICN=mean(IXIC_rend);
mediaN225=mean(N225_rend);

%%%3. (4 punti) 
IXIC_rend_stand=(IXIC_rend-mediaIXICN)/sqrt(covIXICN225(1));
step=0.1;
x_step=min(IXIC_rend_stand):step:max(IXIC_rend_stand);
[a,b]=hist(IXIC_rend_stand, x_step);
bar(b, a/sum(a)./step);
hold on
pdf_e=a./sum(a)./step;
plot(b,pdf_e, 'g--','LineWidth',3); 
hold on
pd_unif=makedist('Normal', 'mu', 0, 'sigma',1);
x=min(IXIC_rend_stand):0.01:max(IXIC_rend_stand);
pdf_u=pdf(pd_unif,x);
plot(x,pdf_u,'k','LineWidth',2);
title('Approssimazione della funzione di densità di probabilità di una serie di dati')
xlabel('Osservazioni')
ylabel('Funzione di densità di probabilità')

% I dati standardizzati molto probabilmente non derivano da una distribuzione normale 0 e
% 1.

%%%4. (1 punti) 
x=0:0.01:1;

%%%5. (4 punti)
sd_R=zeros(1,length(x));
R_media=zeros(1,length(x));
for i =1:length(x)
sd_R(i)=sqrt(x(i)^2*covIXICN225(1,1)+(1-x(i))^2*(covIXICN225(2,2))+2*x(i)*(1-x(i))*covIXICN225(1,2));
R_media(i)=x(i)*mediaIXICN+(1-x(i))*mediaN225;
end

%%%6. (3 punti)

rf=0.0001;
sharpe=(R_media-rf)./sd_R;
%L'indice di Sharpe è negativo per tutti i portafogli, mostrando che l'investimento 
% in titoli rischiosi è peggiore del tasso privo di rischio e potrebbe
% essere meglio non effettuare affatto quell'investimento!!
%% ESERCIZIO 3 (11 punti)

%%%1. (3 punti)
mu=[0.25; 0.1]; 
V=[0.0064 0.002; 0.002 0.0025];
%1. portafogli di minima varianza
n=2;
[Xmin, fvalmin] = fmincon(@(x) sqrt(x'*V*x), ... % fissa l'obiettivo
                ones(n,1)/n, ...                 % imposta i valori di ipotesi/partenza
                [-1 -1], -1, ...                 % vincolo di disuguaglianza
                ones(1,n), ...     	             % termine Aeq-> vincolo di uguaglianza Aeq*x=beq
                1, zeros(n, 1), []);             % no short selling
mu_min=Xmin'*mu;%rendimento atteso
fvalmin; %deviazione standard
Xmin; %quote di portafogli

%%%2. (5 punti) 

numberp    = 40;                                       % numero di punti della frontiera efficiente
mu_i    = linspace(mu_min,max(mu),numberp); 		   % il valore atteso desiderato
sigma_i = zeros(numberp,1);

for i=1:numberp
%% per ciascun valore atteso calcola
%% la funzione di covarianza utilizzando fmincon

    [X, fval] = fmincon(@(x) sqrt(x'*V*x), ... % fissa l'obiettivo
                ones(n,1)/n, ...               % imposta i valori di ipotesi/partenza
                [-1 -1], -1, ...               % vincolo di disuguaglianza
[ones(1,n); mu'],....                          % primo vincolo di eguaglianza: somma(pesi) = 1                    
[1 ; mu_i(i) ], ...                            % secondo vincolo di eguaglianza: valore atteso portafogli = mu_i           						  
zeros(n, 1), []);                              % no short selling
sigma_i(i) = fval;                             % memorizzare la devizione standard
end

%fai il plotting
plot(sigma_i,mu_i,'r')
xlabel('Rischio (std)');
ylabel('Valore atteso');
legend('Frontiera Efficiente', 'Location', 'NorthWest')


%%%3. (3 punti) 
[Xnew, fvalnew]=fmincon(@(x) sqrt(x'*V*x), ... % fissa l'obiettivo
ones(n,1)/n, ...                               % imposta i valori di ipotesi/partenza
[-1 -1], -1,  ...                              % vincolo di disuguaglianza
[ones(1,n) ; mu'],....                         % primo vincolo di eguaglianza: somma(pesi) = 1 
[ 1 ; 0.2 ], ...                               % secondo vincolo di eguaglianza: valore atteso portafogli = 0.2 
zeros(n, 1), []);                              % no short selling
Xnew(1);                                       % è la quota da investire nel primo titolo