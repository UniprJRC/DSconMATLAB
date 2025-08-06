XALLtable=readtable("Firm.xlsx","ReadRowNames",true);
varDaEstrarre=["Wage" "CommutingTime" "SmartWorkHours" "Seniority" ];
% Xd=array con solo le variabili quantitative
Xd=XALLtable{:,varDaEstrarre};
% Xt=table con solo le variabili quantitative
Xt=XALLtable(:,varDaEstrarre);

%% Diverse chiamate alla scatter plot matrix
gplotmatrix(Xd)

%% Chiamata a spmplot
overlay=struct;
overlay.type='ellipse';
spmplot(Xt,'dispopt','box','overlay',overlay)
% Altre opzioni di overlay.type sono
% 'contour', 'boxplotb' or 'contourf'

%% Chiamata a corrplot
[R,Pval]=corrplot(Xt,'TestR','on');
% 'corrplot' requires Econometrics Toolbox.

%% spmplot con variabile di raggruppamento

% edu = variabile di raggruppamento
edu=XALLtable.Education;
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
 
%% Nuovo 'Name',Value typespm dentro spmplot
% E' possibile specificare se la scatterplot matrix deve essere solo
% triangolare inferiore o superiore e quale tipo di diagramma.
% Il Name Value è "typespm",Tipospm
% Tipospm è una struct con i fields lower e upper per controllare il tipo
% di diagramma da inserire rispettavamente sotto o sopra la diagonale
% principale.
% Il tipo di diagramma è "scatter", "circle", "square" "number" and "none";
% Ad esempio con "circle" ("square") l'intensità della correlazione è
% proporzionale ad un cerchio ("quadrato"). Con number la correlazione
% viene rappresentata con un numero la cui altezza è proporzionale alla sua
% intensità. Nelle sections di seguito si mostrano alcuni esempi di
% utilizzo.

%% spm triangolare inferiore e numeri sopra la diagonale
typespm=struct;
typespm.upper="number";
spmplot(Xt,"typespm",typespm);

%% spm triangolare superiore e cerchi sotto la diagonale
typespm=struct;
typespm.lower="circle";
spmplot(Xt,"typespm",typespm);

%% spm senza diagrammi e quadrati sotto la diagonale
typespm=struct;
typespm.upper="none";
typespm.lower="square";
spmplot(Xt,"typespm",typespm);

%% spm con variabile di raggruppamento e opzione 
% triangolo inferiore con i cerchi triangolo superiore con gli scatter
tipoSPM=struct;
tipoSPM.lower="circle";
spmplot(Xt,'group',edu,'typespm',tipoSPM);

%% Con variabile di raggruppamento
load fisheriris;
% Definisco i nomi delle variabili e li inserisco nella struct plo
plo=struct;
plo.nameY={'SL','SW','PL','PW'};
% Al di sopra della diagonale principale vengono inseriti i numeri
% (associati alle correlazioni)
tipoSPM=struct;
tipoSPM.upper="number";

spmplot(meas,'group',species,'plo',plo,'typespm',tipoSPM);
