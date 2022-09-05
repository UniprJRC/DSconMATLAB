
%% CARICAMENTO DATI
Xtable=readtable('lavatrici.xlsx','ReadRowNames',true,'Sheet','dati');
% X = matrice di double senza nomi delle righe e nomi delle colonne
X=table2array(Xtable);
[n,p]=size(X);

% Standardizzo i dati
Z=zscore(X);

[U,Gammastar,V]=svd(Z,'econ');
% Controllo sulla svd
maxdiff=max(abs(Z-U*Gammastar*V'),[],"all");
assert(maxdiff<1e-12,"Errore di programmmazione. " + ...
    "La matrice originaria non è stata ricostruita")
sqn1=sqrt(n-1);
Gamma=Gammastar/sqn1;

% Ricostruzione della matrice originaria 
% con una matrice di rango numcomp
numcomp=2;
U2=U(:,1:numcomp);
V2=V(:,1:numcomp);
Gamma2=Gamma(1:2,1:2);
Zhat=sqn1*U2*Gamma2*V2';


%% A. BIPLOT CON CP STANDARDIZZATE E CORRELAZIONI
% i punti riga sono rappresentati dalle componenti principali standardizzate 
% e i punti colonna tramite frecce la cui lunghezza rappresenta la correlazioni 
% tra le variabili originarie e le componenti principali;

close all
hold('on')
plot(sqn1*U(:,1),sqn1*U(:,2),'o')
text(sqn1*U(:,1),sqn1*U(:,2),Xtable.Properties.RowNames)

Vgam=V*Gamma;
zeroes = zeros(p,1); 
quiver(zeroes,zeroes,Vgam(:,1),Vgam(:,2))
varlabs=Xtable.Properties.VariableNames;
dx=0.02;
dy=0.03;
text(Vgam(:,1)+dx,Vgam(:,2)+dy,varlabs,'Color','b');

axislim=axis;
% Aggiungo l'asse x
line([axislim(1);axislim(2)], [0;0], 'Color','black');
% Aggiungo l'asse y
line([0;0],[axislim(3);axislim(4)], 'Color','black');
 % print -depsc figs\biplotA.eps;

%% B. BIPLOT CON CP NON STANDARDIZZATE E AUTOVETTORI
% i punti riga sono rappresentati dalle componenti principali non standardizzate 
% e i punti colonna tramite frecce la cui lunghezza rappresenta gli autovettori; 

close all
hold('on')
plot(sqn1*U(:,1)*Gamma(1,1),sqn1*U(:,2)*Gamma(2,2),'o')
text(sqn1*U(:,1)*Gamma(1,1),sqn1*U(:,2)*Gamma(2,2),Xtable.Properties.RowNames)

Vgam=V;
zeroes = zeros(p,1); 
quiver(zeroes,zeroes,Vgam(:,1),Vgam(:,2))
varlabs=Xtable.Properties.VariableNames;
dx=0.02;
dy=0.03;
text(Vgam(:,1)+dx,Vgam(:,2)+dy,varlabs,'Color','b');

axislim=axis;
% Aggiungo l'asse x
line([axislim(1);axislim(2)], [0;0], 'Color','black');
% Aggiungo l'asse y
line([0;0],[axislim(3);axislim(4)], 'Color','black');

 % print -depsc figs\biplotB.eps;

%% C. BIPLOT DINAMICO
% i punti riga sono rappresentati dalle coordinate della matrice nx2  $\sqrt(n-1)^\omega 
% *U_(2)*\Gamma_(2)^\alpha$ e i punti colonna tramite frecce le cui coordinate 
% sono date dalla matrice $\sqrt(n-1)^(1-\omega) *Gamma_(2)^(1-\alpha) *V_(2)^T$. 
% con $\omega$ scalare che può assumere valori, 0, 0.1, 0.2, ..., 1 e con $\alpha$ 
% scalare che può assumere valori, 0, 0.1, 0.2, ..., 1 

close all
hold('on')
omega = 0.6;
alpha= 0.3;

PuntiRiga=sqn1^omega*U(:,1:2)*Gamma(1:2,1:2)^alpha;
PuntiColonna=V(:,1:2)*(Gamma(1:2,1:2)^(1-alpha))*sqn1^(1-omega);

plot(PuntiRiga(:,1),PuntiRiga(:,2),'o')
text(PuntiRiga(:,1),PuntiRiga(:,2),Xtable.Properties.RowNames)
zeroes = zeros(p,1); 
quiver(zeroes,zeroes,PuntiColonna(:,1),PuntiColonna(:,2))
varlabs=Xtable.Properties.VariableNames;
dx=0.02;
dy=0.03;
text(PuntiColonna(:,1)+dx,PuntiColonna(:,2)+dy,varlabs,'Color','b');

axislim=axis;
% Aggiungo l'asse x
line([axislim(1);axislim(2)], [0;0], 'Color','black');
% Aggiungo l'asse y
line([0;0],[axislim(3);axislim(4)], 'Color','black');
 % print -depsc figs\biplotC.eps;

%% UTILIZZO FUNZIONE MATLAB PCA (non  utilizzata nel testo)

% Analisi in componenti principali tramite la funzione pca
% V=  è la matrice degli autovettori
% score = componenti principali non standardizzate
% latent = autovalori ordinati dal più grande al più piccolo
[V,score,latent]=pca(Z);