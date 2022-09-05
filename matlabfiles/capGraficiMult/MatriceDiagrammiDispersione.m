%% Caricamento dati
% XALLtable = table con tutte le variabili
XALLtable=readtable("Firm.xlsx","ReadRowNames",true);
varDaEstrarre=["Wage" "CommutingTime" "SmartWorkHours" "Seniority" ];
% Xd=array con solo le variabili quantitative
Xd=XALLtable{:,varDaEstrarre};
% Xt=table con solo le variabili quantitative
Xt=XALLtable(:,varDaEstrarre);


%% Diverse chiamate alla scatter plot matrix

gplotmatrix(Xd)
% print -depsc gplotmatrix.eps;

%% Chiamata a spmplot
overlay=struct;
overlay.type='ellipse';
overlay.type='boxplotb';
overlay.type='contourf';

spmplot(Xt,'dispopt','box','overlay',overlay)
% Altre opzioni di overlay.type sono
% 'contour', 'boxplotb' or 'contourf'

% print -depsc spmplot.eps;

%% Chiamata a corrplot
[R,Pval]=corrplot(Xt,'TestR','on');
% 'corrplot' requires Econometrics Toolbox.

% print -depsc corrplot.eps;


%% spmplot con variabile di raggruppamento

% edu = variabile di raggruppamento
edu=XALLtable.Education;

% chiamata a gplotmatrix
gplotmatrix(Xd,[],edu)

%% chiamata a spmplot
overlay=struct;
overlay.type='ellipse';
spmplot(Xt,'dispopt','box','overlay',overlay,'group',edu)

% print -depsc spmplotG.eps;



%% fisheriris con variabile di raggruppamento
load fisheriris;
% Definisco i nomi delle variabili e li inserisco nella struct plo
plo=struct;
plo.nameY={'SL','SW','PL','PW'};
overlay=struct;
overlay.type='contour';
% Questa volta a spmplot viene passato un'array e non una table di
% conseguenza è necessario dentro plo specificare i nomi delle variabili
spmplot(meas,'group',species,'overlay',overlay,'plo',plo)
% print -depsc spmplotIRIS.eps;

% Osservazione: i gruppi possono essere nascosti/mostrati facendo click
% sulla legenda

%  spmplot(meas,species,plo,'hist');