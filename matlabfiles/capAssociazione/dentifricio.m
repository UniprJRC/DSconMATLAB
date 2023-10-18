%% Caricamento dati
X=readtable("dentifricio.xlsx","Range","A1:B1577","Sheet","dati");

% Chiamata alla funzione crosstab con 4 argomenti di output
[N, chi2, pval, labels]=crosstab(X{:,1},X{:,2});
disp(['Test chi2 calcolato da crosstab ' num2str(chi2)])
disp(['pvalue del test chi2 calcolato da crosstab ' num2str(pval)])


% Trova le dimensioni della tabella di contingenza e n
[I,J]=size(N);
n=sum(N,"all");

% Tabella di contingenza in formato table
Ntable=array2table(N,"RowNames",labels(1:I,1),"VariableNames",labels(1:J,2));
disp(Ntable)

%% Parte non nel libro
% Costruzione di Ntable tramite chiamata a pivot
NtableCHK=pivot(X,"Rows","Dentifricio","Columns","Regione",'RowLabelPlacement','rownames');

%% Parte di nuovo nel libro
% Calcolo manuale del test chi2
Ntheo=sum(N,2)*sum(N,1)/n;
chi2chk=sum(((N-Ntheo).^2)./Ntheo,'all');

% Calcolo manuale del p-value
pvalchk=chi2cdf(chi2chk,(I-1)*(J-1),'upper');

% Controllo l'uguaglianza delle implementazioni
assert(isequal(chi2,chi2chk),"L'implementazione di chi2 è diversa")
assert(isequal(pval,pvalchk),"L'implementazione del pvalue di chi2 è diversa")

% Indice Phi
Phi=sqrt(chi2/n);

% Calcolo indice di Cramer
V=Phi/sqrt(min([I-1 J-1]));
disp(['Indice di Cramer: ' num2str(V)])
