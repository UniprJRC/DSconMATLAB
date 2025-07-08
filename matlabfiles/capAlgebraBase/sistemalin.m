% A =matrice dei coefficienti
A=[ 3 5 4; 2 10 1; 2 2 9];
% b = vettore contenente i termini noti del sistema
b=[25; 25; 33];
% Verifica del rango
assert(rank(A)==3,['La matrice non è di rango pieno' ...
    'Il sistema ammette infinite soluzioni'])
% risoluzione del sistema
x=inv(A)*b;
format long
disp("Soluzione del sistema di equazioni lineari " + ...
    "tramite istruzione inv(A)*b")
disp(x)
% Osservazione: computazionalmente il modo più efficiente per risolvere il
% sistema equazioni lineari è tramite l'operatore \
x=A\b;
disp("Soluzione del sistema di equazioni lineari " + ...
    "tramite istruzione A\b")
disp(x)
