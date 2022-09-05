% Genero una matrice simmetrica
p=7;
A=randn(p,p);
A=A+A';

%{
    % Esempio di generazione di una matrice A simmetrica definita positiva
    n=100; 
    p=7;
    X=randn(n,p);
    A=X'*X;
%}

%{
    % Esempio di generazione di una matrice A simmetrica definita negativa
    n=100; 
    p=7;
    X=randn(n,p);
    A=-cov(X);
%}

%{
    % Esempio di generazione di una matrice A semidefinita positiva
    n=100; 
    p=7;
    X=[randn(n,p) zeros(n,1) randn(n,2)];
    A=cov(X);
%}



% Osservazione: se avessi desiderato scrivere un programma in cui si chiede
% all'utente di fornire direttamente una matrice in input avrei scritto:
%{
    A=input("Prego inserire la matrice che deve essere testata");
%}


% p = numero di righe o colonne della matrice di input
p=size(A,2);
% Inizializzo il vettore riga che conterrà i minori principali
MinoriPrincipali=zeros(1,p);
% Trovo tutti i minori principali
seqp=1:p;
for i=seqp
    MinoriPrincipali(i)=det(A(1:i,1:i));
end

if all(MinoriPrincipali>0)
   disp("La matrice è definita positiva")
elseif  all(MinoriPrincipali>=0)
    disp("La matrice è semidefinita positiva")
elseif all((-1).^seqp.*MinoriPrincipali>0)
    disp('La matrice è definita negativa')
elseif all((-1).^seqp.*MinoriPrincipali>=0)
    disp('La matrice è semidefinita negativa')
else
    disp('La matrice è indefinita')
end