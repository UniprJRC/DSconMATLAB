%% Esercizi sugli autovalori
% Data la matrice A [2 2; 1 3]; 
% 1) Calcolare i coefficienti del  polinomio caratteristico Trovare le
% radici del polinomio caratteristico  (ossia i valori i valori \lambda
% tali per cui |A-\lambda I|=0  tramite la funzione roots. 
% Osservazione: radici del polinomio caratteristico = autovalori della
% matrice A. 
% Calcolare gli autovalori e gli autovettori di A direttamente
% tramite la funzione eig. Ordinare gli autovalori in senso non crescente.
% Mostrare nella command window le matrici degli autovalori ed autovettori prima
% dell'ordinamento e dopo l'ordinamento.
%
% Calcolare gli autovettori e gli autovettori di A attraverso il calcolo
% simbolico.
%
% 2) Calcolare gli  autovalori ed autovettori in maniera simbolica
% della matrice A definita come segue
% [          1/3, (2*5^(1/2))/3]
% [(2*5^(1/2))/3,           2/3]
% Ordinare gli autovalori dal più grande al più piccolo e la corrispondenza
% matrice degli autovettori (prima colonna di V autovettore associato al
% più grande autovalore, seconda colonna di V autovettore associatio al
% secondo autovalore più grande).
% Verificare che la matrice degli autovettori (essendo la matrice A
% simmetrica) è ortogonale (V'V=I)

%% Polinomio caratteristico e sue radici
% Calcolo autovalori
A=[2 2; 1 3];
disp('Coefficienti del polinomio caratteristico')
polinomio_caratteristico=poly(A);
disp('Il polinomio caratteristico è dato da:')
    
% Se il coefficiente del termine di primo grado è positivo è necessario
% inserire nel disp la stringa '+'
if polinomio_caratteristico(2)>0
    coeffx=['+' num2str(polinomio_caratteristico(2))];
else
    coeffx=num2str(polinomio_caratteristico(2));
end
% Se il termine noto è positivo è necessario
% inserire nel disp la stringa '+'
if polinomio_caratteristico(3)>0
    terminenoto=['+' num2str(polinomio_caratteristico(3))];
else
    terminenoto=num2str(polinomio_caratteristico(3));
end

disp([' x^2 ' coeffx 'x ' terminenoto])

disp('Le radici del polinomio caratteristico (autovalori) sono:')
disp(roots(polinomio_caratteristico))

%% Autovalori e autovettori tramite la funzione eig
% Se eig viene chiamata con un solo argomento di output allora vengono
% riportati gli autovalori in un vettore colonna
autovalori=eig(A);

%% Calcolo autovalori e autovettori
% se eig viene chiamata con due argomenti di output,  
% il primo argomento di output è la matrice degli autovettori ed il secondo
% la matrice diagonale degli autovalori
[V,Lambda]=eig(A);

disp('Matrice degli autovalori (ordinati dal più piccolo al più grande')
disp(Lambda)
disp('Matrice degli autovettori associata')
disp(V)

% Ordinamento degli autovalori
d=diag(Lambda);
[~,permutation]=sort(d,"descend");

% Lambda(1,1) autovalore più grande
% Lambda(2,2) secondo autovalore più grande
Lambda=diag(d(permutation));
% Prima colonna di V = primo autovettore associato all'autovalore più
% grande
% Seconda colonna di V = secondo autovettore associato al secondo autovalore più
% grande
V=V(:,permutation);
disp('Matrice degli autovalori (ordinati dal più grande al più piccolo')
disp(Lambda)
disp('Matrice degli autovettori associata')
disp(V)


%% Autovalori e autovettori tramite il calcolo simbolico
% Nel calcolo simbolico si definisce inizialmente la matrice di partenza A
% come simbolica. Tutte le altre istruzioni sono uguali. I calcoli però
% sono effettuati in maniera simbolica.
A=sym([2 2; 1 3]);

[V,Lambda]=eig(A);

% Ordinare gli autovalori dal più grande al più piccolo e la corrispondenza
% matrice degli autovettori (prima colonna di V autovettore associato al
% più grande autovalore, seconda colonna di V autovettore associatio al
% secondo autovalore più grande).
% Verificare che la matrice degli autovettori (essendo la matrice A
% simmetrica) è ortogonale (V'V=I)
d=diag(Lambda);
[~,permutation]=sort(d,"descend");

% Lambda(1,1) autovalore più grande
% Lambda(2,2) secondo autovalore più grande
Lambda=diag(d(permutation));
% Prima colonna di V = primo autovettore associato all'autovalore più
% grande
% Seconda colonna di V = secondo autovettore associato al secondo autovalore più
% grande
V=V(:,permutation);
% Osservazione: gli autovettori ottenuti con il calcolo simbolo non sono
% normalizzati ad 1, di conseguenza è necessario dividere ogni colonna per
% la radice quadrata della somma dei quadrati di ogni colonna.
V1=V./sqrt(sum(V.^2,1));
disp("Matrice degli autovalori ordinati (in senso non crescente)")
disp(Lambda)
disp("Matrice degli autovettori normalizzati (corrispondenti agli autovalori ordinati)")
disp(V1)


%% Altro esempio di scomposizione spettrale
% Calcolare gli  autovalori ed autovettori in maniera simbolica
% della matrice A definita come segue
% [          1/3, (2*5^(1/2))/3]
% [(2*5^(1/2))/3,           2/3]
% Ordinare gli autovalori dal più grande al più piccolo e la corrispondenza
% matrice degli autovettori (prima colonna di V autovettore associato al
% più grande autovalore, seconda colonna di V autovettore associatio al
% secondo autovalore più grande).
% Verificare che la matrice degli autovettori (essendo la matrice A
% simmetrica) è ortogonale (V'V=I)

A=sym([1/3 sqrt(20)/3; sqrt(20)/3 2/3]);

[V,Lambda]=eig(A);
d=diag(Lambda);
[~,permutation]=sort(d,"descend");

%Lambda(1,1) autovalore più grande
% Lambda(2,2) secondo autovalore più grande
Lambda1=diag(d(permutation));
% Prima colonna di V = primo autovettore associato all'autovalore più
% grande
% Seconda colonna di V = secondo autovettore associato al secondo autovalore più
% grande
V=V(:,permutation);
V1=V./sqrt(sum(V.^2,1));

disp("Matrice degli autovalori ordinati (in senso non crescente)")
disp(Lambda1)
disp("Matrice degli autovettori (corrispondenti agli autovalori ordinati)")
disp(V1)


% La matrice V1 in questo caso è ortogonale poiché la matrice di partenza è
% simmetrica
disp('Verifico l''ortogonalità della matrice V1')
disp(V1'*V1)

disp('Verifico la ricostruzione della matrice di partenza')
disp(V1*Lambda1*V1')






