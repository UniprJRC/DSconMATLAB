%% Diagramma di dispersione con ellissi di confidenza
Xtable=readtable("SpesaFatt.xlsx");
% X matrice dei dati
X=Xtable{:,:};
n=size(X,1); X1=X(:,1); X2=X(:,2);
% Vettore riga delle medie aritmetiche
meaX=mean(X);
% Matrice degli scostamenti dalla media
Xtilde=X-meaX;
% S = matrice di covarianze
S=Xtilde'*Xtilde/(n-1);

plot(X1,X2,'o','LineWidth',3)
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')
hold('on')
confLevEllipses=[0.5 0.75 0.90 0.99];
for i=1:length(confLevEllipses)
    ellipse(meaX,S,confLevEllipses(i));
end
axis equal

%% Autovalori ed autovettori di S
[Vini,Lambdaini]=eig(S);
[~,ord]=sort(diag(Lambdaini),'descend');
% Lambda contiene sulla diagonale, gli
% autovalori ordinati in senso decrescente
Lambda=Lambdaini(ord,ord);
% V contiene i corrispondenti autovettori
V=Vini(:,ord);

%% Diagramma di dispersione e retta principale
figure
plot(X1,X2,'o')
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')
bprinc=-V(1,2)/V(2,2);
aprinc=meaX(2)-bprinc*meaX(1);
% Viene aggiunta la retta principale
refline(bprinc,aprinc);
axis equal
title(['Retta principale: X2='  num2str(aprinc) '+' num2str(bprinc) 'X1'])

%% Aggiunta dei segmenti delle proiezioni ortogonali
hold('on')
% y1 coordinate dei punti nello spazio della prima PC
% y1 è ad una sola dimensione
v1=V(:,1);
y1=Xtilde*v1;

% I punti sono proiettati nello spazio originario a due dimensioni.  
% Xtildehat sono le coordinate delle proiezioni ortogonali lungo la retta
% principale che passa per l'origine (punti in termini di scostamenti dalla
% media).
Xtildehat=y1.*v1';
% Le coordinate di Xtildehat vanno traslate tramite il vettore delle medie
% aritmetiche in modo tale da proiettare i punti lungo la retta principale
% che passa per il centroide (ossia il vettore delle medie aritmetiche)
Xhat=Xtildehat+meaX;

% Vengono aggiunte le linee che si riferiscono alle proiezioni
% ortogonali dei punti lungo la retta principale.
plot([Xhat(:,1) X1]',[Xhat(:,2) X2]','k')

axis equal
title({'Diagramma di dispersione,' ...
    'retta principale e proiezione dei punti'...
    'lungo la retta principale'})


%% PARTE NON PRESENTE NEL LIBRO
% X1 X2 = punti originari
figure
plot(X1,X2,'x')
hold('on')
plot(Xhat(:,1),Xhat(:,2),'x')

% Xhat(:,1) Xhat(:,2) coordinate dei punti proiettati lunga la retta
% principale
axis equal

% Nel grafico precedente siamo andati a disegnare le rette associate alle
% proiezioni ortogonali lungo la retta principale

%% Xhat matrice che contiene le coordinate delle proiezioni 
% dei punti sulla retta principale
Residuals=X-Xhat;
disp('Somma dei quadrati dei residui')
disp(sum(Residuals.^2,'all')/(n-1));

%% Controllo che Residuals è uguale all'output della chiamata alla funzione
[ResidualsCHK,XhatCHK]=pcares(X,1);
maxdiffRES=max(abs(Residuals-ResidualsCHK),[],'all')<1e-12;
assert(maxdiffRES,"Errore di programmazione nei residui")
maxdiffX=max(abs(Xhat-XhatCHK),[],'all')<1e-12;
assert(maxdiffX,"Errore di programmazione nella " + ...
    "ricostruzione di X")

%% Retta di regressione
% Si cerca la retta che minimizza la somma dei quadrati dei residui tra i
% valori osservati della variabile dipendente (y_i) ed i valori adattati
% yhat_i=a+bx_i, con i=1, 2, ..., n
figure
% X2= Fatturato= variabile dipendente 
% X1= Spesa pubblicitaria = variabile esplicativa 
% fitlm è la routine MATLAB per calcolare tutte le statistiche relative al
% modello di regressione
out=fitlm(X1,X2);
% Dalla struct out vengono estratti i parametri a
% e b della retta di regressione ed i valori adatatti (yhat)
areg=out.Coefficients.Estimate(1);
breg=out.Coefficients.Estimate(2);
% yhat = valori adattati
yhat=out.Fitted;
% scatter dei valori originari
plot(X1,X2,'o')
hold('on')

% il comando lsline aggiunge la retta di regressione
% al diagramma di dispersione
hOLS=lsline;
% Colore rosso per la retta di regressione
hOLS.Color='r';
% Vengono aggiunte le distanze verticali dei punti dalla retta
plot([X1 X1]',[yhat X2]','k')
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')
title(['Retta di regressione: X2='  num2str(areg) '+' num2str(breg) 'X1'])
axis equal

% print -depsc figs\proiez4.eps;
