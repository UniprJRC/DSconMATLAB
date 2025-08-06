
%% CARICAMENTO DATI
Xtable=readtable('lavatrici.xlsx','ReadRowNames',true,'Sheet','dati');
% X = matrice di double senza nomi delle righe e nomi delle colonne
X=table2array(Xtable);
varlabs=Xtable.Properties.VariableNames;
rowlabs=Xtable.Properties.RowNames;
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
% I punti riga (G) sono rappresentati dalle componenti principali
% standardizzate e i punti colonna (H) tramite frecce le cui lunghezze
% rappresentano la correlazioni tra le variabili originarie e le componenti
% principali
figure; hold('on')
G=sqn1*U;
plot(G(:,1),G(:,2),'o')
text(G(:,1),G(:,2),rowlabs)

H=V*Gamma;
zeroes = zeros(p,1); 
quiver(zeroes,zeroes,H(:,1),H(:,2))
dx=0.02; dy=0.03;
text(H(:,1)+dx,H(:,2)+dy,varlabs,'Color','b');

% Vengono aggiunti gli assi cartesiani
xline(0); yline(0)
title("Rappresentazione A.")

%% B. BIPLOT CON CP NON STANDARDIZZATE E AUTOVETTORI
% I punti riga (G) sono rappresentati dalle componenti principali non
% standardizzate e i punti colonna (H) tramite frecce la cui lunghezze
% rappresentano gli autovettori

figure; hold('on')
G=sqn1*U*Gamma;
plot(G(:,1),G(:,2),'o')
text(G(:,1),G(:,2),rowlabs)

H=V;
zeroes = zeros(p,1); 
quiver(zeroes,zeroes,H(:,1),H(:,2))
text(H(:,1)+dx,H(:,2)+dy,varlabs,'Color','b');

% Vengono aggiunti gli assi cartesiani
xline(0); yline(0)
title("Rappresentazione B.")


%% C. BIPLOT DINAMICO
% v. libro di testo

figure; hold('on')
omega = 0.6; alpha= 0.3;

G=sqn1^omega*U(:,1:2)*Gamma(1:2,1:2)^alpha;
H=V(:,1:2)*(Gamma(1:2,1:2)^(1-alpha))*sqn1^(1-omega);

plot(G(:,1),G(:,2),'o')
text(G(:,1),G(:,2),Xtable.Properties.RowNames)
zeroes = zeros(p,1); 
quiver(zeroes,zeroes,H(:,1),H(:,2))
varlabs=Xtable.Properties.VariableNames;
text(H(:,1)+dx,H(:,2)+dy,varlabs,'Color','b');

% Vengono aggiunti gli assi cartesiani
xline(0); yline(0)
title("Rappresentazione dinamica")

%% UTILIZZO FUNZIONE MATLAB PCA (non  utilizzata nel testo)

% Analisi in componenti principali tramite la funzione pca
% V=  è la matrice degli autovettori
% score = componenti principali non standardizzate
% latent = autovalori ordinati dal più grande al più piccolo
[V,score,latent]=pca(Z);

%% UTILIZZO FUNZIONE pcaFS
clear
Xtable=readtable('lavatrici.xlsx','ReadRowNames',true,'Sheet','dati');
pcaFS(Xtable)