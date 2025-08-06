% Componenti principali come rotazione degli assi cartesiani

%% Diagramma di dispersione, ellisse di confidenza e assi dell'ellisse
close all
clear
% Dati caricati in formato table
Xtable=readtable("SpesaFatt.xlsx");
% X matrice dei dati
X=Xtable{:,:};
n=size(X,1);
X1=X(:,1);
X2=X(:,2);
% Vettore riga delle medie aritmetiche
meaX=mean(X);
% Matrice degli scostamenti dalla media
Xtilde=X-meaX;
% S = matrice di covarianze
S=Xtilde'*Xtilde/(n-1);


% Analisi in componenti principali

% Autovalori ed autovettori di S
[Vini,Lambdaini]=eig(S);

[~,ord]=sort(diag(Lambdaini),'descend');
% Lambda contiene sulla diagonale, gli
% autovalori ordinati in senso decrescente
Lambda=Lambdaini(ord,ord);
% V contiene i corrispondenti autovettori
V=Vini(:,ord);
% pendenza ed intercetta della retta principale
bprinc=-V(1,2)/V(2,2);
aprinc=meaX(2)-bprinc*meaX(1);

% Punti originari ed ellisse
plot(X1,X2,'o')
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')
hold('on')
axis equal
Ell= ellipse(meaX,S,1);
% print -depsc figs\rotazione1.eps;

%% Clear della memoria
% Tutte le variabili generate dal codice di cui sopra
% sono presenti nel file mat denominato
% workspacePreliminareEllisse.mat
clear


%% Calcolo in maniera numerica lunghezza semiasse

% Carico workspace con le variabili necessarie
load workspacePreliminareEllisse

% Trasformo le coordinate dell'ellisse in un poligono
ellp=polyshape(Ell);


% Coordinate x e y della retta principale
xcoo=(min(X1):0.01:max(X1))';
ycoo=aprinc+bprinc*xcoo;
% Trovo l'intersezione tra la retta principale e l'ellisse
[in,out]=intersect(ellp,[xcoo ycoo]);
disp("Lunghezza del semiasse principale dell'ellisse")
disp("ottenuta in maniera numerica")
% in(end,:) contiene le coordinate dell'ultimo punto della retta
% che si trova dentro l'ellisse
% lunSemiAxis contiene la lunghezza del semiasse
lunSemiAxis=norm(in(end,:)-meaX);
% La norma poteva anche esser calcolata come segue
% sqrt(sum((in(end,:)-meaX).^2))
disp(lunSemiAxis)

%% Lunghezza semiasse ellisse e primo autovalore
% La lunghezza del semiasse maggiore dell'ellisse ottenuto in maniera
% numerica non è altro che la radice quadrata del primo autovalore

% gamma1 = lunghezza asse maggiore ellisse
gamma1=sqrt(Lambda(1,1));

disp("Lunghezza del semiasse principale dell'ellisse")
disp("come radice del primo autovalore")
disp(gamma1)

% gamma2= lunghezza asse minore ellisse
gamma2=sqrt(Lambda(2,2));

%% Area e perimetro dell'ellisse (in maniera numerica)
disp(['Area dell''ellisse: ' num2str(area(ellp))])
disp(['Perimetro dell''ellisse: ' num2str(perimeter(ellp))])


%% Area e perimeto ellisse tramite formule esplicite
disp("Area dell'ellisse (valore esatto): pi*gamma1*gamma2")
disp(pi*gamma1*gamma2);

disp('Perimetro dell''ellisse tramite formula di Ramanujan')
disp(pi*(3*(gamma1+gamma2)-sqrt((3*gamma1+gamma2)*(gamma1+3*gamma2))))

%% Rappresentazione dei punti nella base canonica e_1 e e_2 (non presente nel libro)

plot(X1,X2,'o')
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')
hold('on')

Ell= ellipse(meaX,S,1);
axis equal
[in]=inpolygon(X1,X2,Ell(:,1),Ell(:,2));
seq=1:n;
textOut=string(seq(~in));
text(X(~in,1),X(~in,2),textOut)

%% Rappresentazione dei punti in termini di scostamenti dalla media
% Punti nella base canonica e_1 e e_2
figure
Xtilde1=Xtilde(:,1);
Xtilde2=Xtilde(:,2);

plot(Xtilde1,Xtilde2,'o')
xlabel('$\tilde X_1= X_1-\overline x_1$','Interpreter','latex')
ylabel('$\tilde X_2=X_2-\overline x_2$','Interpreter','latex')
hold('on')
Ell= ellipse(0,S,1);
axis equal
[in]=inpolygon(Xtilde1,Xtilde2,Ell(:,1),Ell(:,2));
seq=1:n;
textOut=string(seq(~in));
text(Xtilde1(~in),Xtilde2(~in),textOut)
% print -depsc figs\rotazione2.eps;

%% Rappresentazione dei punti nel nuovo sistema di assi cartesiani (PC)
figure
Y=Xtilde*V;
plot(Y(:,1),Y(:,2),'o')
hold('on')
Ellr= ellipse(0,Lambda,1);
xlabel('$Y_1$=Prima componente principale','Interpreter','latex')
ylabel('$Y_2$=Seconda componente principale','Interpreter','latex')

[in]=inpolygon(Y(:,1),Y(:,2),Ellr(:,1),Ellr(:,2));
seq=(1:size(X,1))';
textOut=string(seq(~in));
text(Y(~in,1),Y(~in,2),textOut)
axis equal
% print -depsc figs\rotazione3.eps;
%% Rappresentazione dei punti nello spazio delle PC standardizzate
figure
Yst=zscore(Y);
plot(Yst(:,1),Yst(:,2),'o')
hold('on')
Ellr= ellipse(0,eye(2),1);
xlabel(['$Y_1\sqrt \lambda_1 $=Prima componente principale ' ...
    'standardizzata'],'Interpreter','latex')
ylabel(['$Y_2 \sqrt \lambda_2$=Seconda componente principale' ...
    ' standardizzata'],'Interpreter','latex')

[in]=inpolygon(Yst(:,1),Yst(:,2),Ellr(:,1),Ellr(:,2));
textOut=string(seq(~in));
text(Yst(~in,1),Yst(~in,2),textOut)
axis equal
% print -depsc figs\rotazione4.eps;


