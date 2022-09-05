% x = coordinate del vettore (punto) da proiettare su v
x=[1; 1; 0];
% La direzione del vettore v è
v=[1; -1; 0];
%t = x'*v/(v'v) 
t =x'*v/(v'*v);
r_0=[0; 0; 0];
hatx= r_0+t*v;
% dist= || x- hatx||
dist=norm(x-hatx);
disp(['La distanza è uguale a: ' num2str(dist)]) 