rng(25)
n=100000;
p=3;
X=chi2rnd(5,n,p);
medie=mean(X);
varianze=var(X);
sigma=std(X);
% Osservazione: dato che la v.c. Chi2 con g gradi di libertà ha una
% expectation pari a g e una varianza pari a 2g ci attendiamo che le medie
% campionarie siano vicine a 5 e che le varianze campionarie siano vicine a
% 10.
disp("Medie campionarie di variabili generate da Chi2(5)")
disp(medie)
disp("Varianze campionarie di variabili generate da Chi2(5)")
disp(varianze)

Xtilde=X-medie;
Z=zscore(X);
%% Calcolo varianze e sigma tramite le norme
for j=1:p
    Xtildej=Xtilde(:,j);
    normXtildej=sqrt(sum(Xtildej.^2));
    % Di seguito chiamiamo direttamente la funzione norm
    normXtildejCHK=norm(Xtildej);
    diff=abs(normXtildej-normXtildejCHK);
    assert(diff<1e-12,"Errore di programmazione " + ...
        "nell'implementazione della norma euclidea")
    % Verifica uguaglianza varianze
    diff1=abs(normXtildej^2/(n-1)-varianze(j));
    assert(diff1<1e-12,"Errore di programmazione " + ...
        "nell'implementazione della varianza tramite la norma")
    Zj=Z(:,j);
    normZj=sqrt(sum(Zj.^2));
    % Di seguito chiamiamo direttamente la funzione norm
    normZjCHK=norm(Zj);
    diff2=abs(normZj-normZjCHK);
    assert(diff2<1e-12,"Errore di programmazione " + ...
        "nell'implementazione della norma euclidea")
    diff3=abs(normZj/sqrt(n-1)-1);
    assert(diff3<1e-12,"Errore di programmazione " + ...
        "nell'implementazione di sigma tramite la norma")
end


