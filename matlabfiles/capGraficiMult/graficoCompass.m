X = readtable("grafuniv2serie.xlsx",'Sheet','dati','ReadRowNames',true);
Xd=X{:,1:2};
% sequanza di passo 30 gradi
% 0, 30, ..., 330 gradi
% rad2deg(theta)
theta=linspace(0,2*pi-pi/6,12);
compassplot(theta,Xd)
set(gca,'ThetaTickLabel',X.Properties.RowNames)
legend(X.Properties.VariableNames,'Location','best')

