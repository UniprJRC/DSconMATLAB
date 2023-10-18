% Caricamento dati
load('multiple_regression.txt');
y=multiple_regression(:,4);
X=multiple_regression(:,1:3);
%% yXplot
yXplot(y,X);
% print -depsc MULTREGyXplot.eps;

%% Fit tradizionale e residui
out=fitlm(X,y)
resindexplot(out.Residuals{:,3})
% print -depsc MULTREGres.eps;

disp(out.Residuals)


%% Rotate manually
scatter3(X(:,1),X(:,2),y)
xlabel('X1')
ylabel('X2')
zlabel('y')
hold('on');
sel=[9 30 31 38 47 21];
scatter3(X(sel,1),X(sel,2),y(sel),'r','MarkerFaceColor','r')
sel1=43;
scatter3(X(sel1,1),X(sel1,2),y(sel1),'k','MarkerFaceColor','k')
text(X(sel1,1),X(sel1,2),y(sel1),'43')

%% Regressione escludendo gli outliers
out=fitlm(X,y,'Exclude',sel)
