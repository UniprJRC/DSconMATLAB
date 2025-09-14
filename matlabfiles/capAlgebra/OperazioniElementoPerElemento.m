xi=(1:6)';
ni=[25; 38; 106; 52; 15; 3];
n=sum(ni);
M=sum(xi.*ni)/n;
disp("Media aritmetica")
disp(M)
disp("Scostamento quadratico medio ponderato (implementazione manuale)")
s=sqrt(sum((xi-M).^2.*ni)/n);
disp(s)

%% Calcolo scostamento quadratico medio tramite std

schk=std(xi,ni);

assert(isequal(s,schk),"Implementazione errata di s")