%% Caricamento dati 
miofile="Firm.xlsx";
Xt=readtable(miofile,"ReadRowNames",true);
Xt.Gender = categorical(Xt.Gender);
Xt.Education=categorical(Xt.Education,{'A','B','C'},'Ordinal',true');

maschi=Xt.Gender=="M";
tiledlayout(1,2)
nexttile
donutchart(Xt(maschi,:),'Education')
title('Maschi')

nexttile
donutchart(Xt(~maschi,:),'Education')
title('Femmine')
colororder('meadow')
% print -depsc bomboloni.eps;