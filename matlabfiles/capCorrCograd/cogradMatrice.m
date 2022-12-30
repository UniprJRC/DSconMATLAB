% Caricamento dati
Xtable=readtable("Firm.xlsx","ReadRowNames",true);
nomiq=["Wage" "CommutingTime" "SmartWorkHours" "Seniority" ];
X=Xtable{:,nomiq};

% Matrice di cograduazione di Spearman e relativi p-values nel secondo
% argomento di output della funzione corr
[Rho,Pvalrho]=corr(X,'type','Spearman');
Rhot=array2table(Rho,"RowNames",nomiq,"VariableNames",nomiq);

Pvalrhot=array2table(Pvalrho,"RowNames",nomiq,"VariableNames",nomiq);
disp('Matrice di cograduazione di Spearman ')
disp(Rhot)
disp("table dei pvalues")
disp(Pvalrhot)
