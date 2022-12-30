Xtable=readtable('tagliatelle.xlsx','Sheet','Dati','Range','A1:C41');
X=Xtable{:,:};
% Criterio listwise
[~,pvalRhoList]=corr(X,'type','Spearman','rows','complete');
% Criterio pairwise
[~,pvalRhoPair]=corr(X,'type','Spearman','rows','pairwise');
nomi=Xtable.Properties.VariableNames;
pvalRhoListT=array2table(pvalRhoList,'RowNames',nomi,'VariableNames',nomi);
pvalRhoPairT=array2table(pvalRhoPair,'RowNames',nomi,'VariableNames',nomi);

disp('Matrice dei p-values dei coeff. di cograduazione (criterio listwise)')
disp(pvalRhoListT)
disp('Matrice dei p-values dei coeff. di cograduazione  (criterio pairwise)')
disp(pvalRhoPairT)