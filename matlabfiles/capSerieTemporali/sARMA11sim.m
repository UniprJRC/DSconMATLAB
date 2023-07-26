m   = 2; phi = 0.5; theta = 0.9; sigma2 = 0.4;
Mdl = arima('Constant', m, 'AR', phi, 'MA', theta, 'Variance', sigma2);
n   = 500; N  = 1; rng(1);
y   = simulate(Mdl, n, 'NumPaths',N);
g=figure();
subplot(2, 1, 1); plot(y, LineWidth=2); title('Serie simulata', Interpreter='latex'); hold on;
line([1 n], [m/(1-phi)  m/(1-phi)],'Color','red','LineStyle','--')
set(gca,'TickLabelInterpreter','latex');
subplot(2, 2, 3); autocorr(y); title("FAC campionaria", Interpreter="latex"); ylabel(''); xlabel('');
set(gca,'TickLabelInterpreter','latex');
subplot(2, 2, 4); parcorr(y);  title("FACP campionaria", Interpreter="latex");ylabel(''); xlabel('');
set(gca,'TickLabelInterpreter','latex');
exportgraphics(g,'gARMA11.pdf')