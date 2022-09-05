% Dati di input
alpha=0.01; % livello di significatività del test
r=0.54; % valore campionario del coefficiente di correlazione
n=12;

%% Calcoli richiesti

% Calcolo del test tr
tr=(r./sqrt(1-r.^2))*sqrt(n-2);

% Quantile che lascia alla sua destra una probabilità pari ad alpha/2
tsup=tinv(1-alpha/2,n-2);
tinf=-tsup;

disp(['Al livello di significatività alpha=' num2str(alpha) ','])
if abs(tr) > tsup
    disp('rifiuto l''ipotesi nulla di assenza di correlazione')
else
    disp('accetto l''ipotesi nulla di assenza di correlazione')
end

% Calcolo del p-value del test
% Moltiplico l'area della coda di destra per 2 poiché l'ipotesi alternativa
% è bilaterale
pval=tcdf(abs(tr),n-2,'upper')*2;
disp(['Il p-value del test è: ' num2str(pval)])

disp(['Questa conclusione è corretta se le ' num2str(n)])
disp('osservazioni costituiscono un campione casuale da un')
disp('universo con una distribuzione normale bivariata')