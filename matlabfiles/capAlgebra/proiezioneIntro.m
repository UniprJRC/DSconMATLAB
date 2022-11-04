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
