%% caricamento dati
load loyalty.mat
loyalty.family(loyalty.family>5)=5;
nr=2;   nc=1;
subplot(nr,nc,1)
scatter(loyalty,'family','amount_spent')
title('Grafico a dispersione')
xlim([0.5 5.5])
subplot(nr,nc,2)
swarmchart(loyalty,'family','amount_spent')
title('Grafico a sciame')
% print -depsc figs\swarmchart.eps;


%% Visualizzazione tramite violinplot
figure
violinplot(loyalty,'family','amount_spent')
title('Grafico a violino')

%% Visualizzazione tramite boxchart
figure
boxchart(loyalty,'family','amount_spent','Orientation','vertical')
title('Boxplot')

%% Visualizzazione tramite raincloudplot (solo 2026a)
figure
raincloudplot(loyalty,'family','amount_spent','Orientation','vertical')
title('Rain cloud plot')
