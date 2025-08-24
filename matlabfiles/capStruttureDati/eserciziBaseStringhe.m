%% Operazioni preliminari
Firm = readtable('Firm.xlsx','Sheet','data','Range','A1:J108', 'ReadRowNames', 1);
Sur=Firm.Surname;
Nam=Firm.Name;

%% Primo criterio
boo=startsWith(Sur,"CAS"); % boo è vettore Booleano
disp(Firm(boo,:))

%% Secondo criterio
boo=endsWith(Nam,"LA");
disp(Firm(boo,:))

%% Terzo criterio 
% wildcardPattern significa qualsiasi combinazione di caratteri
pat="R" + wildcardPattern + ("O");
boo=matches(Nam,pat);
Terzo=Firm(boo,:);
disp(Terzo)

%% Terzo criterio  (svolgimento alternativo)
miocriterio=startsWith(Nam,"R") & endsWith(Nam,"O");
TerzoBIS=Firm(miocriterio,:);
disp(TerzoBIS)
assert(isequal(Terzo,TerzoBIS),"I due modi di risolvere il terzo quesito sono diversi")

%% Quarto criterio
pat="R" + wildcardPattern + ("O"|"A");
boo=matches(Nam,pat);
disp(Firm(boo,:))

%% Quinto criterio
% wildcardPattern(1,5) significa un minimo di un carattere ed un massimo di
% 5 caratteri qualsiasi
pat="R" + wildcardPattern(1,5) + ("O"|"A");
boo=matches(Sur,pat);
disp(Firm(boo,:))
