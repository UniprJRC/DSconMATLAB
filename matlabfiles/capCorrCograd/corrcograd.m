
% Generiamo 6 punti in base ad una retta con coefficiente angolare positivo.
x=(1:6)';
y=2+3*x;
% Modifichiamo la coordinata di un punto in modo da distruggere
% la relazione lineare ma mantenere la pefetta cograduazione.
y(1)=1;
scatter(x,y)
xlabel('asse x')
ylabel('asse y')
% Coefficiente di cograduazione
disp('Coefficiente di cograduazione')
disp(corr(x,y,'Type','Spearman'))

% Coefficiente di correlazione
disp('Coefficiente di correlazione')
disp(corr(x,y))
% print -depsc figs\corrcograd.eps;
