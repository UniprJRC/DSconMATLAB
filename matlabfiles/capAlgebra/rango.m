%% Esercizi sul rango
n=7;
x1=randn(n,1);
x2=randn(n,1);
x3=randn(n,1);
x4=randn(n,1);
% rango della matrice A =x1 x1'
A=x1*x1';
rankA=rank(A);
assert(rankA==1,"Errore di programmazione rango A=x1*x1' è 1")
% rango della matrice A =x1 x2'
B=x1*x2';
rankB=rank(B);
assert(rankB==1,"Errore di programmazione rango B=x1*x2' è 1")
% rango della matrice C =x1 x1'+ x2 x2'
C=x1*x1'+x2*x2';
rankC=rank(C);
assert(rankC==2,"Errore di programmazione rango x1 x1'+ x2 x2' è 2")
% rango della matrice D =x1*x1'+x2*x2'+x3*x3'+x4*x4'
D=x1*x1'+x2*x2'+x3*x3'+x4*x4';
rankD=rank(D);
assert(rankD==4,"Errore di programmazione rango x1 x1'+" + ...
    " x2 x2' +x3*x3'+x4*x4' è 4")
% il rango della matrice $E =\sum_{i=1}^4 x_3 x_3'$ è uno
E=4*(x3*x3');
rankE=rank(E);
assert(rankE==1,"Errore di programmazione rango x3 x3'+" + ...
    " x3 x3' +x3*x3'+x3*x3' è 1")
