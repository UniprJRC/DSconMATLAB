
%% Diagramma di dispersione personalizzato
load stars.mat
X=stars{:,:};
plot(X(:,1),X(:,2),'o','Marker','p','MarkerEdgeColor','r', ...
    'MarkerFaceColor','k','MarkerSize',12)
set(gca,"XDir","reverse")


%% Aggiunta delle regioni verticali 
% xregion([3.45; 4.6],[3.6; 4.7])
% oppure
xregion([3.45 4.6; 3.6 4.7])


% print -depsc diagrammaHRxregion.eps;
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
    'Lunghezza dei petali','Ampiezza dei petali'};
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

