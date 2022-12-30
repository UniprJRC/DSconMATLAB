
nu=20;
% la probabilità di ottenere un valore in modulo superiore a 2.7
disp('--------------')
disp('P(|T(20)|>2.7)')
disp(2*tcdf(2.7,nu,'upper'))


% quantile 0.95 in una T(20)
disp('Quantile 0.95 in T(20)')
disp(tinv(0.95,nu))

%% Confronto tra le densità
x=-3:0.001:3;
N01=normpdf(x);
nu=3;
T3=tpdf(x,nu);
nu=10;
T10=tpdf(x,nu);

plot(x,N01,'b-',x,T3,'r-.',x,T10,'k--','LineWidth',2)
legend(["N(0,1)"  "T(3)" "T(10)"])

% print -depsc figs\t.eps;
