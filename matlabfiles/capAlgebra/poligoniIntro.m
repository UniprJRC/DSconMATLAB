%% Diagramma di dispersione ed ellisse di confidenza
close all
clear
Xtable=readtable("SpesaFatt.xlsx");
X=Xtable{:,:};
meaX=mean(X);
% S = matrice di covarianze
S=cov(X);

% Diagramma di dispersione
plot(X(:,1),X(:,2),'o','LineWidth',3)
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')

hold('on')
% L'ellisse di confidenza viene aggiunto chiamando la funzione ellipse
% specificando il vettore delle medie e la matrice di covarianze
Ell= ellipse(meaX,S,0.95);
axis equal

legend("Diagramma di dispersione",...
    "Coordinate ellisse di confidenza al 95%",...
    'Location','southeast')

%% Area e perimetro dell'ellisse
% Trasformo le coordinate dell'ellisse in un poligono
% La funzione polyshape crea un poligono con determinate proprietà (ad
% esempio elimina vertici duplicati), dato un insieme di coordinate x e y
ellp=polyshape(Ell);

% All'output restituito dalla funzione polyshape posso applicare una serie
% di funzioni 
% disp("Area dell'ellisse (in maniera numerica)")
AreaEll=area(ellp);
% disp("Perimetro dell'ellisse (in maniera numerica)")
PerimetroEll=perimeter(ellp);
disp("Centroide dell'ellisse (in maniera numerica)")
[meaX1,meaX2]=centroid(ellp);
disp([meaX1, meaX2])

disp("Centroide (medie aritmetiche) della matrice X")
disp(meaX)

% print -depsc figs\intPoly1.eps;


%% Punti dentro e fuori dall'ellisse con colore diverso

% La funzione inpolygon restituisce un vettore booleano di lunghezza n
% contenente true per i punti che sono dentro l'ellisse
insideBoo = inpolygon(X(:,1),X(:,2),Ell(:,1),Ell(:,2));

figure
hold('on')
plot(X(insideBoo,1),X(insideBoo,2),'bo','LineWidth',3)
plot(X(~insideBoo,1),X(~insideBoo,2),'rx','LineWidth',3)
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')
% Aggiunta dell'ellisse di confidenza
plot(Ell(:,1),Ell(:,2))
axis equal

% Aggiunta retta
% Viene aggiunta la retta con intercetta e pendenza richiesti
a=52.7355;
b= 1.4594;
refline(b,a)
legend("Punti dentro l'ellisse di confidenza", ...
    "Punti fuori dall'ellisse di confidenza",...
    "Ellisse di confidenza","Retta che passa per l'asse maggiore dell'ellisse",...
   'Location','southeast')

%   print -depsc figs\intPoly2.eps;

%% Intersezione tra i poligoni

% Creazione delle coordinate x e y dei punti che stanno sulla retta
xcoo=[min(X(:,1))-20; max(X(:,1))+20];
ycoo=a+b*xcoo;
% La funzione intersect effettua l'intersezione tra due poligoni
% Il secondo argomento di input di intersect è una matrice a due
% colonne che definisce le coordinate  della retta (bastano due righe)
[Pointsin,Pointsout]=intersect(ellp,[xcoo ycoo]);

% Creazione figura finale
% Diagramma di dispersione con punti dentro e fuori dall'ellisse di
% confidenza con simboli e colore diverso
figure
hold('on')
plot(X(insideBoo,1),X(insideBoo,2),'bo')
plot(X(~insideBoo,1),X(~insideBoo,2),'rx')
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')

% Viene aggiunto al grafico l'ellisse di confidenza
plot(ellp)
% Punti della retta dentro e fuori l'ellisse di confidenza
plot(Pointsin(:,1),Pointsin(:,2),'b-.',Pointsout(:,1),Pointsout(:,2),'r')
% Aggiunta della legenda
legend("Punti dentro l'ellisse di confidenza", ...
    "Punti fuori dall'ellisse di confidenza",...
    "Ellisse di confidenza","Punti della retta dentro l'ellisse",...
    "Punti della retta fuori dall'ellisse",'Location','southeast')
axis equal

%    print -depsc figs\intPoly3.eps;
