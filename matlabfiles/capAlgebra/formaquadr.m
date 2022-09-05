n=100;
p=3;
X=randn(n,p);
S=cov(X);
% nsimul = numero di simulazioni (ripetizioni dell'esperimento)
nsimul=10000;
% inizializzo il vettore formaquad che conterrà in
% posizione i il risultato di x'Sx per la simulazione i
formaquad=zeros(nsimul,1);
for i=1:nsimul
    x=randn(p,1);
    formaquad(i)=x'*S*x;
    assert(formaquad(i)>0,"Errore di programmazione la forma " + ...
        "quadratica x'Sx è definita positiva")
end
% Calcolo e mostro il minimo di formaquad
minfq=min(formaquad);
disp("Valore più piccolo di x'Sx in nsimul simulazioni")
disp(minfq)