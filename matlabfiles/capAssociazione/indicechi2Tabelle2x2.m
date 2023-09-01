%% N = tabella di contingenza di partenza
N= [87 188; 42 406];
n=sum(N,'all');

%% Calcolo indice Chi2 senza cicli for
Ntheo=sum(N,2)*sum(N,1)/n;
Chi2=sum(((N-Ntheo).^2)./Ntheo,'all');

%% Implementazione dell'indice Chi2 tramite doppio ciclo for
Chi2chk=0;
for i=1:2
    for j=1:2
        nijstar=sum(N(i,:))*sum(N(:,j))/n;
        Chi2chk=Chi2chk+(N(i,j)-nijstar)^2/nijstar;
    end
end

%% Calcolo p-value della statistica di Pearson
% La statistica di Pearson si distribuisce come una v.c. Chi2 con
% (I-1)(J-1) gradi di libertà. In questo esempio dato che I = J = 2,
% i gradi di libertà sono uguali ad uno.
gdl=1;
pval=1-chi2cdf(Chi2,gdl);
disp(['Il pvalue del test è: ' num2str(pval)])
% Si fissa l'errore di prima specie
alpha=0.001;
% valorecritico = quantile che lascia alla sua destra una prob di 0.001 in
% una v.c. chi2 con 1 grado di libertà
valorecritico= chi2inv(1-alpha,gdl);

if Chi2>valorecritico
    disp('Ipotesi nulla di assenza di relazione tra X e Y è rifiutata')
else
    disp('Ipotesi nulla di assenza di relazione tra X e Y è accettata')
end
