Xtable=readtable("Firm.xlsx","ReadRowNames",true);
nomiq=["Wage" "CommutingTime" "SmartWorkHours" "Seniority" ];
X=Xtable{:,nomiq};
% n= numerosità del campione
% p= numero di variabili
[n,p]=size(X);
% Matrice di correlazione e relativi p-values nel secondo argomento di
% output della funzione corr
[R,Pval]=corr(X);

% Di seguito calcolo manualmente la matrice dei p-values
% Calcolo del test di assenza di correlazione per ogni coppia di variabili
Testt=(R./sqrt(1-R.^2))*sqrt(n-2);

% Calcolo dei relativi p-values
Pval1=tcdf(abs(Testt),n-2,'upper')*2;
% Aggiungo i valori 1 sulla diagonale principale della matrice Pval1
Pvalchk=Pval1 +eye(p);

% Controllo che il massimo delle differenze in valore assoluto tra le due
% implementazioni sia pari ad un numero vicino a zero 
assert(max(abs(Pval-Pvalchk),[],"all")<1e-15,"Pval manuale incorretta")

Pvalt=array2table(Pval,"RowNames",nomiq,"VariableNames",nomiq);
disp("table dei pvalues")
disp(Pvalt)

