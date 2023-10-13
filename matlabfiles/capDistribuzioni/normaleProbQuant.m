%% Calcolo probabilità in una N(\mu \sigma)
media=3;
varianza=4;

sigma=sqrt(varianza);

% la probabilità di ottenere un valore minore di 1.2
disp('--------------')
disp('P(X<1.2) in N(3,4)')
disp(normcdf(1.2,media,sigma))

% la probabilità di ottenere un valore compreso tra 5 e 6 in N(3,4)
disp('--------------')
disp('P(5<X<6) in N(3,4)')
prob56=normcdf(6,media,sigma)-normcdf(5,media,sigma);
disp(prob56)

%%  Rappresentazione grafica Pr 5<X<6 tramite normspec
% QUESTA SECTION  NON E' NEL LIBRO
normspec([5 6],media,sigma,'inside')
title(['Funzione di densità: N('  num2str(media) ',' num2str(varianza) ')'])
ylabel(['Pr(5<X<6)=' num2str(prob56)])


%%  Rappresentazione grafica Pr 5<X<6
% Calcolo della densità tramite la funzione normpdf
x=(-9:0.0001:9)';
ypdf=normpdf(x,media,sigma);
plot(x,ypdf);
title(['Funzione di densità: N('  num2str(media) ',' num2str(varianza) ')'])

% Istruzione hold('on') per sovrapporre il grafico che segue al grafico
% precedente
hold('on')

% a = posizione dell'ultimo valore del vettore x <=5
a=find(x<=5,1,'last');
% b= posizione del primo valore del vettore x >=6
b=find(x>=6,1);
% Utilizza la funzione fill nell'intervallo x(a:b)
fill(x(a:b),[0;ypdf(a+1:b-1);0],'g')
ylabel(['Pr(5<X<6)=' num2str(prob56)])
% print -depsc figs\normfill.eps;

%% Quantili

% quantile 0.975 (valore che lascia alla sua destra una prob. di 2.5 per
% cento) in N(3,4)
disp('Quantile 0.975 in N(3,4)')
disp(norminv(0.975,media,sigma))

% quant = vettore che contiene le probabilità associate ai quantili richiesti
quant=[0.005, 0.025, 0.975 0.995];
nomiquant="z"+quant;
xz=norminv(quant);
xzt=array2table(xz,"VariableNames",nomiquant);
disp("Quantili in una N(0,1)")
disp(xzt)


