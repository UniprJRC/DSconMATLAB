
%% Caricamento dati
Xtable=readtable("Firm.xlsx","ReadRowNames",true);
nomiq=["Wage" "CommutingTime" "SmartWorkHours" "Seniority" ];
X=Xtable{:,nomiq};
% Xtilde = matrice degli scostamenti dalla media
Xtilde=X-mean(X);
% Z= matrice degli scostamenti standardizzati
Z=Xtilde./std(X);

% n= numerosità del campione
n=size(X,1);
%% Matrice di varianze e covarianze S
% S calcolata tramite la funzione cov
S=cov(X);

% S calcolata tramite moltiplicazione matriciale
Schk=Xtilde'*Xtilde/(n-1);

% Controllo che le due implementazioni siano uguali
assert(max(abs(S-Schk),[],"all")<1e-15,"Le due " + ...
    "implementazioni di S differiscono")

% S in formato table
Stable=array2table(S,"RowNames",nomiq,"VariableNames",nomiq);
disp('Matrice di covarianze in formato table')
disp(Stable)


%% Matrice di correlazione R
% R calcolata tramite la funzione corr
R=corr(X);

% R calcolata tramite moltiplicazione matriciale
Rchk=Z'*Z/(n-1);

% Controllo che le due implementazioni siano uguali
assert(max(abs(R-Rchk),[],"all")<1e-15,"Le due " + ...
    "implementazioni di R differiscono")

% R in formato table
Rtable=array2table(R,"RowNames",nomiq,"VariableNames",nomiq);
disp('Matrice di correlazione in formato table')
disp(Rtable)

%% Calcolo della matrice di correlazione partendo da S

% Implementazione tramite doppio ciclo for                 
p=size(X,2);
Rchk1=zeros(p,p);
for i=1:p
    for j=1:p
        Rchk1(i,j)=S(i,j)/sqrt(S(i,i)*S(j,j));
    end
end

% Implementazione matriciale
sigmas=sqrt(diag(S));
D=diag(sigmas);
% invD = matrice diagonale che contiene sulla diagonale principale
% i reciproci delle standard deviation delle variabili
invD=D^-1;
Rchk2=invD*S*invD;

% Controllo che le due implementazioni siano uguali
assert(max(abs(R-Rchk1),[],"all")<1e-15,"Le due " + ...
    "implementazioni di R differiscono")

% Controllo che le due implementazioni siano uguali
assert(max(abs(R-Rchk2),[],"all")<1e-15,"Le due " + ...
    "implementazioni di R differiscono")

