
%% 1) Costruire il diagramma di dispersione (utilizzando il comando plot)
% tra le due variabili inserendo la performance sull'asse delle ascisse ed
% utilizzando come simboli per i punti quadrati ('Marker','s')
% con bordo rosso ('MarkerEdgeColor','r') riempiti di colore nero
% (MarkerFaceColor','k') di altezza pari a 12 ('MarkerSize',12)
load stars.mat
X=stars{:,:};
plot(X(:,1),X(:,2),'o','Marker','p','MarkerEdgeColor','r', ...
    'MarkerFaceColor','k','MarkerSize',12)
% Per invertire la direzione dell'asse x
set(gca,'XDir','reverse')
xlabel('Temperatura della superficie')
ylabel('Intensità della luce')
title('Diagramma Hertzsprung-Russell')

% print -depsc diagrammaHR.eps;



%% scatter con boxplot ai margini
close all
load stars.mat
X=stars{:,:};
scatterboxplot(X(:,1),X(:,2));
boxplotb(X)
xlabel('Temperatura della superficie')
ylabel('Intensità della luce')

% print -depsc starsscatterboxplotb.eps;


%% Analisi univariate e bivariate in presenza di più gruppi
close all
load fisheriris
labels = {'Lunghezza sepali','Ampiezza dei sepali',...
    'Lunghezza dei petali','Ampiezza dei sepali'};
i=2;
j=3;
scatterhistogram(meas(:,i),meas(:,j),'GroupData',species,'LineWidth',1.2)
xlabel(labels(i))
ylabel(labels(j))
title('Scatter e istogrammi distinti per i 3 gruppi')
% print -depsc irisscatterhist.eps;

%% scatterboxplot con variabile di raggruppamento
figure
scatterboxplot(meas(:,i),meas(:,j),'Group',species)
xlabel(labels(i))
ylabel(labels(j))
title('Scatter e boxplot distinti per i 3 gruppi')

% print -depsc irisscatterboxplot.eps;

