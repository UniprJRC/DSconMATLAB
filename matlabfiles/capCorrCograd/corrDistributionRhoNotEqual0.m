%% Input data
x=-1:0.01:1;
%% Input data
rho=[0:0.2:0.8 0.9]';
n=12;
rhos=num2str(rho);
ns=num2str(n);

%% Creazione grafico pannelli multipli
close all
for i=1:length(rho)
    nexttile
    dens=corrpdf(x,rho(i),n);
    plot(x,dens)
    title(['$f(r|n=' ns ', \rho=' rhos(i,:) ')$'],'Interpreter','latex')
    xlabel("$r$",'Interpreter','latex')
end

sgtitle('Densità del coefficiente di correlazione campionario per diversi valori di \rho')