%% Dati di input
Chi2=57.607148359920558;
N= [87 188;
    42 406];

%% Indice \phi utilizzando il valore precalcolato di Chi2
sumc=sum(N,1);
sumr=sum(N,2);
n=sum(N,'all');

if det(N)>0
    phi=sqrt(Chi2/n);
else
    phi=-sqrt(Chi2/n);
end

%% Indice \phi tramite la formula
% $\phi=\frac{n_{11}  n<_{22} -n_{12}n_{21}}{\sqrt{n_{1.}n_{2.}n_{.1}n_{.2}}}$
phichk=(N(1,1)*N(2,2)-N(1,2)*N(2,1))/sqrt(prod(sumr)*prod(sumc));
disp(['Il valore dell''indice phi è ' num2str(phi)])