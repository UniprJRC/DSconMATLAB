%% Calcolo matrice indici di Gower
X =[1 1 1 1 1 5	169	450; 1 1 1 1 0 4 94	410; 0 1 0 1 0 4 48	330;
    1 1 0 1 0 4	66	330; 0 0 0 0 0 3 32	190; 0 0 0 1 0 3 33	165];
l=[2*ones(1,5) ones(1,3)];
rowlab=string(('A':'F')');
% La funzione GowerIndex accetta anche un input di tipo table
Xtable=array2table(X,"RowNames",rowlab);
[IndSimG, IndSimGtable]=GowerIndex(Xtable,'l',l);
disp(IndSimGtable)
