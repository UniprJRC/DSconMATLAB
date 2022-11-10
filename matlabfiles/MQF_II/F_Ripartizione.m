function [x_ord, F_CDF,p_ord]=F_Ripartizione(x,p)
%Funzione di Ripartizione di una variabile aleatoria X
%INPUTS: x= i valori della mia variabile aleatoria
%        p= le probabilità dei singoli valori
%OUTPUTS: x_ord = i valori ordinati della mia variabile aleatoria X
%         F_CDF = le probabilità cumulative dei singoli valori

[x_ord, Ind_ord] =sort(x);
p_ord=p(Ind_ord);
F_CDF=cumsum(p_ord);
stairs(x_ord, F_CDF, 'LineWidth', 2, 'Color', 'k', 'LineStyle','--')
title('Funzione di Ripartizione')
xlabel('x')
ylabel('F_X(x)')
end