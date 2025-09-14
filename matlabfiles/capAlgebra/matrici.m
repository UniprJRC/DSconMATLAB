%% Moltiplicazioni tra matrici
A=[3 -3 9; 10 0 4; 0 2 -1];
B=[-1 5; 7 3; 0 6];
C=A*B;
disp(C)

%% Matrici diagonali
D=diag([2 5 7]);
disp(D)
%% Matrice sovradiagonale
E=diag([2 5 7],1);
disp(E)

%% Estrazione elementi sulla diagonale principale
rng(10);
A=randi(15,5);
a=diag(A);
disp(a)

%% Estrazione elementi due diag sotto la diag princ
b=diag(A,-2)

%% Matrice identità
I=eye(3)

%% Matrice rettangolare con 1 sulla diag princ
A=eye(4,6);

%% Matr id con doppio ciclo for
% Osservazione: nell'esercizio del libro la variabile k è denominata j
% Ovviamente (a meno che non sia espressamente specificato) posso scegliere
% qualsiasi nome per le variabili purché siano soddisfatte una serie di
% regole (ad esempio i nomi delle variabili non possono iniziare con un
% numero).
% Maggiori dettagli sono contenuti in
% https://www.geeksforgeeks.org/variable-names-in-matlab/
p=5;
id=zeros(p,p);
for i=1:p
    for k=1:p
        if i==k
            id(i,i)=1;
        end
    end
end
I=eye(p);

assert(isequal(I,id),"errore di programmazione nella " + ...
    "creazione della matrice identità tramite doppio ciclo for")

%% Matrice di 1
disp(ones(2,3))

%% Matrice di 0
disp(zeros(3,4))

%% Matrici con elementi uguali a 5
5*ones(3,4)

%% Matrice magica di dimensione kxk
k=3;
magic(k)

%% Matrici idempotenti
% Assegno ad n il valore 5.
n=5;
A= gallery('invol',n);
H=0.5*(eye(n)+A);
disp('Esempio di matrice idempotente')
disp(H)
H2=H*H;
disp('Verifica idempotenza di H')
maxdiff=max(abs(H-H2),[],"all")<1e-10;
assert(maxdiff,"Errore di programmazione nella verifica ..." + ...
    "dell'idempotenza di H")

%% Matrici ortogonali
n=5;
for k=1:6
    A = gallery('orthog',n,k);
    % Verifico l'ortogonalità di A per ogni valore di k
    maxdiff=max(abs(A'*A-eye(n)),[],'all');
    assert(maxdiff<1e-12,"Errore di programmazione nella verifica " + ...
        "dell'ortogonalità della matrice generata tramite gallery" + ...
        "o valore di k diverso da 1, 2, ..., 6")
    maxdiff=max(abs(A*A'-eye(n)),[],'all');
    assert(maxdiff<1e-12,"Errore di programmazione nella verifica " + ...
        "dell'ortogonalità della matrice generata tramite gallery" + ...
        "o valore di k diverso da 1, 2, ..., 6")
    detA=det(A);
    % Controllo che il determinante di A sia 1 oppure -1
    assert(min(abs(detA-[-1 1]))<1e-12,"Errore di programmazione " + ...
        "Il determinante di una matrice ortogonale è " + ...
        "uguale a 1 oppure uguale a -1")
end

%% Moltiplicazioni matrici trasposte
rng(12345);
% Estraggo numeri interi positivi nell'intervallo 1-9
m=randi(9,1);
% Alternativamente si poteva utilizzare l'istruzione m=randi(9);
n=randi(9,1);
o=randi(9,1);
p=randi(9,1);
% Creo le matrici richieste utilizzando distribuzioni a piacere
% A = mxn numeri generati dalla distribuzione N(0,1)
A=normrnd(0,1,m,n);
% B = nxo numeri generati dalla distribuzione U(1,3)
B=unifrnd(1,3,n,o);
% C= oxp numeri generati dalla distribuzione Chi2
% con 6 gradi di libertà
C=chi2rnd(6,o,p);
D=(A*B*C)';
Dchk=(C'*B'*A');
disp(' Verifica che (A*B*C)''-(C''*B''*A'')  = zeros(p,m)')
disp(D-Dchk)
maxdiff=max(abs(D-Dchk),[],"all")<1e-10;
assert(maxdiff,"Errore di programmazione nella verifica ..." + ...
    "della regola della moltiplicazione della matrice trasposta")

%% Moltiplicazioni di matrici inverse
n=8;
% Di seguito senza perdita di generalità si utilizzano
% numeri estratti da N(0,1)
A=randn(n,n);
B=randn(n,n);
C=randn(n,n);

invABC=inv(A*B*C);
invCBA=inv(C)*inv(B)*inv(A);
maxdiff=max(abs(invABC-invCBA),[],"all")<1e-10;
assert(maxdiff,"Errore di programmazione nella verifica " + ...
    "della regola della moltiplicazione di matrici inverse")

%% Trasposta dell'inversa
n=10;
A=randn(n,n);
Atraspinv=(A')^-1;
Ainvtrasp=(A^-1)';
maxdiff=max(abs(Atraspinv(:)-Ainvtrasp(:)));
assert(maxdiff<1e-12,"Errore di programmazione nella verifica " + ...
    "delle proprietà dell'inversa della trasposta")

%% Sistemi di equazioni lineari
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

%% La traccia
p=5;
X=randn(n,p);
Y=randn(n,p);
% i 5 elementi del vettore tracce contengono i diversi modi
% di implementazione della traccia del prodotto delle due matrici
tracce=zeros(5,1);
tracce(1)=trace(X'*Y);
tracce(2)=trace(X*Y');
tracce(3)=trace(Y'*X);
tracce(4)=trace(Y*X');
tracce(5)=sum(X.*Y,'all');

maxdiff=max(tracce)-min(tracce);
assert(maxdiff<1e-12,"Errore di programmazione nella verifica " + ...
    "delle proprietà della traccia")

%% Somma dei quadrati
rng(4567)
n=10;
p=3;
X=randn(n,p);
trXtraspostoX=trace(X'*X);
trXXtrasposto=trace(X*X');
sommaqua=sum(X.^2,"all");
maxdiff=max([abs(trXtraspostoX-trXXtrasposto),...
    abs(trXtraspostoX-sommaqua)])<1e-11;
nomitable=["tr(X'X)" "tr(XX')" "Somma calcolata direttamente"];
St=array2table([trXtraspostoX trXXtrasposto sommaqua],...
    'VariableNames',nomitable);

assert(maxdiff,"Errore di programmazione nella verifica " + ...
    "del calcolo della somma dei quadrati " + ...
    "tramite tr(X'X) oppure tr(X*X')")

%% Espansione implicita e matrice Z
n=20;
p=3;
rng(123)
X=10+3*randn(n,p);
% Un modo alternativo per generare i dati era
%X=normrnd(10,3,n,p);
% Contaminazione delle righe 5 e 8 con il valore 100
X([5 8],:)=100;
% Z = matrice degli scostamenti standardizzati utilizzando
% l'espansione implicita
Z=(X-mean(X))./std(X);
% Zchk = matrice degli scostamenti standardizzati utilizzando
% la funzione zscore
Zchk=zscore(X);
maxdiff=max(abs(Z-Zchk),[],"all");
assert(maxdiff<1e-12,"Errore di programmazione nella costruzione " + ...
    "della matrice degli scostamenti standardizzati")

bar(Z)
title(['Rappresentazione tramite barre ' ...
    'degli scostamenti standardizzati'])

% Zrob = matrice degli scostamenti standardizzati
% robusta utilizzando l'espansione implicita
Zrob=(X-median(X)) ./ (1.4826* mad(X,1));
% Zrobchk = matrice degli scostamenti standardizzati
% robusta utilizzando la funzione zscoreFS
Zrobchk=zscoreFS(X);
maxdiff=max(abs(Zrob-Zrobchk),[],"all");
assert(maxdiff<1e-4,"Errore di programmazione nella costruzione " + ...
    "della matrice degli scostamenti standardizzati robusti")
figure
bar(Zrob)
title(['Rappresentazione tramite barre ' ...
    'degli scostamenti standardizzati robusti'])

%% Matrice Xtilde e matrice Z
% Generazione di X da N(0,1)
n=10;
p=5;
X=randn(n,p);
uno=ones(n,1);
% H = centering matrix. Matrice idempotente e simmetrica che consente di
% passare dalla matrice originaria alla matrice degli scostamenti
% dalla media
H=eye(n)-uno*uno'/n;
% Xtilde = matrice degli scostamenti dalla media
Xtilde=H*X;

% Controllo tramite molt. matriciale che sum(Xtilde,1)=zeros(1,p)
assert(max(abs(uno'*Xtilde))<1e-15,"La somma degli elementi delle " + ...
    "colonne di Xtilde non è zero")

%% Matrice degli scostamenti standardizzati in maniera matriciale
sigmas=std(X);
D=diag(sigmas);
invD=D^-1;
Z=H*X*invD;

Zchk=zscore(X);
assert(max(abs(Z-Zchk),[],'all')<1e-13,"Le due implementazioni" + ...
    "differiscono")