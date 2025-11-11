Xtable=readtable("SpesaFatt.xlsx");
X=Xtable{:,:};
% Calcolo del vettore riga contenente le medie aritmetiche delle
% due variabili (il cosiddetto centroide)
meaX=mean(X);
% S = matrice di covarianze
S=cov(X);

% Diagramma di dispersione
plot(X(:,1),X(:,2),'o','LineWidth',3)
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')
hold('on')
Ell= ellipse(meaX,S,0.95);
axis equal
%Aggiunta della legenda
legend("Diagramma di dispersione",...
    "Coordinate ellisse di confidenza al 95%",'Location','southeast')
%% Area e perimetro dell'ellisse
% Trasformo le coordinate dell'ellisse in un poligono
ellp=polyshape(Ell);
% disp("Area dell'ellisse (in maniera numerica)")
AreaEll=area(ellp);
% disp("Perimetro dell'ellisse (in maniera numerica)")
PerimetroEll=perimeter(ellp);
disp("Centroide dell'ellisse (in maniera numerica)")
[meaX1,meaX2]=centroid(ellp);
disp([meaX1, meaX2])

disp("Centroide (medie aritmetiche) della matrice X")
disp(meaX)

%% Punti dentro e fuori dall'ellisse con colore diverso
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
% Viene aggiunta la retta con intercetta e pendenza richiesti
a=52.7355; b= 1.4594;
refline(b,a)
legend("Punti dentro l'ellisse di confidenza", ...
    "Punti fuori dall'ellisse di confidenza","Ellisse di confidenza", ...
    "Retta che passa per l'asse maggiore dell'ellisse",'Location','southeast')

%% Intersezione tra i poligoni
xcoo=[min(X(:,1))-20; max(X(:,1))+20];
ycoo=a+b*xcoo;
[Pointsin,Pointsout]=intersect(ellp,[xcoo ycoo]);

figure
hold('on')
plot(X(insideBoo,1),X(insideBoo,2),'bo')
plot(X(~insideBoo,1),X(~insideBoo,2),'rx')
xlabel('X1=Spesa pubblicitaria (mln €)')
ylabel('X2=Fatturato (mln €)')

plot(ellp)
plot(Pointsin(:,1),Pointsin(:,2),'b-.',Pointsout(:,1),Pointsout(:,2),'r')
legend("Punti dentro l'ellisse di confidenza", ...
    "Punti fuori dall'ellisse di confidenza",...
    "Ellisse di confidenza","Punti della retta dentro l'ellisse",...
    "Punti della retta fuori dall'ellisse",'Location','southeast')
axis equal

%    print -depsc figs\intPoly3.eps;
