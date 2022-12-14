%% N = tabella di contingenza di partenza
N= [87 188;
    42 406];
% n=numero di unità statistiche del campione.
n=sum(N,"all");

% sumc (1x2)= frequenze marginali di colonna
% sumc(1) = somma delle frequenze della prima colonna $n_{.1}$
% sumc(2) = somma delle frequenze della seconda colonna $n_{.2}$
sumc=sum(N,1);

% sumr (2x1)= frequenze marginali di riga
% sumr(1) = somma delle frequenze della prima riga $n_{1.}$
% sumr(2) = somma delle frequenze della seconda riga $n_{2.}$
sumr=sum(N,2);

%% Calcolo della tabella delle frequenze teoriche 
Ntheo=(sumr*sumc/n);
disp('Matrice delle frequenze teoriche tramite molt. matr.')
disp(Ntheo)

%% Calcolo delle frequenze teoriche tramite doppio ciclo for
[nr,nc]=size(N);
% Si initializa la matrice Ntheochk che contirrà le frequenze teoriche     
Ntheochk=zeros(nr,nc);
for i=1:nr
    for j=1:nc
        % frequenza teorica_ij = n_i.*n.j/n 
        Ntheochk(i,j)=sumr(i)*sumc(j)/n;
    end
end
disp('Matrice delle frequenze teoriche tramite doppio ciclo for')
disp(Ntheochk)