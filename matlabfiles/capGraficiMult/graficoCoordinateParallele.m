rng(10)
n=100;
p=9;
X=zeros(n,p);
% Prima variabile generata in maniera casuale
X(:,1)=randn(n,1);
% Valore piccolo di sigma per avere una correlazione elevata
sigma=0.2;
% Le prime 5 variabili devono essere correlate in maniera crescente
for j=2:5
    X(:,j)=2+5*X(:,1)+sigma*randn(n,1);
end
% Le variabili 6:9 devono essere correlate in maniera forte e
% diretta ma in maniera inversa con le prime 5
for j=6:9
    X(:,j)=2-5*X(:,1)+sigma*randn(n,1);
end

%%Grafico in coordinate parallele
parallelplot(X)

%% Grafico in coordinate parallele (input una table)
parallelplot(array2table(X))


% print -depsc coordinatepar.eps;
% parallelcoords(zscore(X))
%%  Dataset Firm.xlsx grafico in coord parallele con var raggruppamento
Xt=readtable("Firm.xlsx","ReadRowNames",true);
parallelplot(Xt,'CoordinateVariables',["Education" "Wage" ...
    "Seniority" "CommutingTime" "SmartWorkHours"], ...
    "GroupVariable","Education")

% print -depsc coordinateparFirm.eps;

%% Dataset fisheriris grafico in coord parallele con var raggruppamento
load fisheriris.mat
nr=2; nc=1;
subplot(nr,nc,1)
labels = {'Sepal Length','Sepal Width','Petal Length','Petal Width'};
parallelcoords(meas,'Group',species,'Labels',labels)

subplot(nr,nc,2)
parallelcoords(meas,'Group',species,'Labels',labels, ...
    'quantile',.05,'LineWidth',2)

% print -depsc coordinateparIris.eps;