%% rho=1 e r<1
x=(1:6)'; y=2+3*x;
y(4)=12;
scatter(x,y,'red','filled')
xlabel('Coordinate x'); ylabel('Coordinate y')

disp('Coefficiente di cograduazione')
disp(corr(x,y,'Type','Spearman'))
disp('Coefficiente di correlazione')
disp(corr(x,y))
% print -depsc figs\corrcograd.eps;
