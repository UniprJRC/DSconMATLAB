
%% Scostamenti standardizzati robusti e non robusti
n=20;
p=3;
rng(123)
X=10+3*randn(n,p);
% Un modo alternativo per generare i dati era
%X=normrnd(3,10,n,p);
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
% print -depsc figs\scoststand1.eps;

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
% print -depsc figs\scoststand2.eps;


%% Parte non inserita nel libro 
% (v. materiale aggiuntivo nel sito di Giappichelli)
Zchk1=normalize(X);
maxdiff=max(abs(Z-Zchk1),[],"all");
assert(maxdiff<1e-12,"Errore di programmazione nella costruzione " + ...
    "della matrice degli scostamenti standardizzati")


%% Esempio di utilizzo di normalize con una table
% Viene caricata in memoria la table delle 
load citiesItaly.mat
ZItaly=normalize(citiesItaly);

%% Standardizzazione robusta
ZItalyROB=zscoreFS(citiesItaly);

