% x = coordinate del vettore (punto) da proiettare su v
x=[1; 1; 0];
% La direzione del vettore v è
v=[1; -1; 0];
%t = x'*v/(v'v) 
t =x'*v/(v'*v);
% In questo esempio i vettori x e v sono ortogonali  (il loro prodotto
% scalare è 0) di conseguenza t=0
r_0=[0; 0; 0];
% Il vettore hatx è semplicemente il punto di coordinate 0 0 0
hatx= r_0+t*v;
% dist= || x- hatx||
dist=norm(x-hatx);
disp(['La distanza è uguale a: ' num2str(dist)]) 
% La distanza non è altro che la norma del vettore x (dato che hatx=0)
% In altri termini, in questo esempio la distanza è la radice quadrata di 2
% ossia la norma del vettore x

% Rappresentazione grafica (non nel libro)
close all
fs=14;
quiver3(0,0,0,x(1),x(2),x(3),0)
hold("on")
xstri=string(x);
testox="x=(" + xstri(1) + "," + xstri(2) + "," + xstri(3) + ")"; 
vstri=string(v);
testov="v=(" + vstri(1) + "," + vstri(2) + "," + vstri(3) + ")"; 
dx=0.01;
text(x(1)+dx,x(2)+dx,x(3)+dx,testox,"FontSize",fs);
quiver3(0,0,0,v(1),v(2),v(3),0)
text(v(1),v(2),v(3),testov,"FontSize",fs);

quiver3(0,0,0,t*v(1),t*v(2),t*v(3),0)
text(t*v(1),t*v(2),t*v(3),['tv=' num2str(t) '*v'],"FontSize",fs,'HorizontalAlignment','right');

axis equal
xlabel('Prima coordinata')
ylabel('Seconda coordinata')
zlabel('Terza coordinadata')
title('Proiezione del vettore x sul vettore v')
%% Nuovo esempio (non presente nel libro)
% x = coordinate del vettore (punto) da proiettare su v
x=[1; 2; 3];
% non è necessaria alcuna traslazione
r0=[0; 0; 0];

% La direzione del vettore v è
v=[2; 2.4; 3.5];
%t = x'*v/(v'v) 
t =x'*v/(v'*v);
% Calcolo del vettore  hatx 
hatx= r0+t*v;
% dist= || x- hatx|| = lunghezza della proiezione ortogonale
dist=norm(x-hatx);
disp(['La distanza è uguale a: ' num2str(dist)]) 
% Il grafico viene creato in una nuova figura
figure
fs=14;
quiver3(0,0,0,x(1),x(2),x(3),0)
hold("on")
text(x(1),x(2),x(3),"x","FontSize",fs);
quiver3(0,0,0,v(1),v(2),v(3),0)
text(v(1),v(2),v(3),"v","FontSize",fs);
quiver3(0,0,0,t*v(1),t*v(2),t*v(3),0)
text(t*v(1),t*v(2),t*v(3),['tv=' num2str(t) '*v'],"FontSize",fs);

xminushatx=x-hatx;
% vettore che parte da x e arriva fino a hatx
quiver3(x(1),x(2),x(3),-xminushatx(1),-xminushatx(2),-xminushatx(3),0)

% oppure se faccio partire il vettore da hatx=tv
% quiver3(hatx(1),hatx(2),hatx(3),xminushatx(1),xminushatx(2),xminushatx(3),0)

xlabel('Prima coordinata')
ylabel('Seconda coordinata')
zlabel('Terza coordinadata')

axis equal

% i vettori v e hatx sono ortogonali
disp('Verifica dell''ortogonalità tra v e (x-hatx)')
disp(['Prodotto interno v''(x-hatx)=' num2str(v'*(x-hatx))])
title('Proiezione ortogonale del vettore x sul vettore v')

