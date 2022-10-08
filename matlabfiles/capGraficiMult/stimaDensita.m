%% Stima densità (metodi parametrici)
load head.mat
% p=numero di colonne del dataset
p=size(head,2);

close all
for i=1:p
    % L'istruzione nexttile aggiunge un subplot a quelli già
    % esistenti. Di conseguenza se p=4 alla fine del ciclo la finestra
    % grafica viene suddivisa in 4 pannelli, se p=20 viene creata una
    % finestra grafica 5x4 con 20 pannelli.
    nexttile
    histfit(head{:,i})
    % L'opzione 'Interpreter','none' assicura che il carattere _
    % non venga interpretato come segnaposto per inserire un pedice
    title(head.Properties.VariableNames{i},'Interpreter','none')
end
% print -depsc histdens.eps;
pd = fitdist(head{:,1},'Normal')


%% Stima densità metodi kernel (non parametrici)
Xt=readtable("Firm.xlsx","ReadRowNames",true);
nomiq=["Wage" "CommutingTime" "SmartWorkHours" "Seniority" ];
Xt=Xt(:,nomiq);
% p=numero di colonne del dataset
p=size(Xt,2);
close all
for i=1:p
    nexttile
    histfit(Xt{:,i},[],'Kernel')
    title(Xt.Properties.VariableNames{i},'Interpreter','none')
end

% print -depsc histdensNONPAR.eps;