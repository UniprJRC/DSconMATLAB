%% TESTO


% Tabella relativa all'uso della marca di dentrifricio in 4 regioni
N=[49	111	13	49
16	551	241	7
34	358	30	117];
% I = numero di righe della tabella di contingenza
% J = numero di colonne della tabella di contingenza
[I,J]=size(N);


%% P = matrice delle corrispondenze 
% P contiene le frequenze relative.

% n= numero di unità del campione
n=sum(N,'all');

% P = (matrice di corrispondenza =correspondence matrix) contiene le
% frequenze relative f_ij
P = (1/n) * N;

% Verifico tramite moltiplicazione matriciale che la somma degli elrmenti
% di P è pari 1.
onesI1=ones(I,1);
onesJ1=ones(J,1);
sumelP=onesI1'*P*onesJ1;
assert(abs(sumelP-1)<1e-12,"La somma degli elementi di P non è 1")

%%  Calcolo delle matrici dei profili riga e colonna 

% ProfilesRows = matrice che contiene i profili riga
% Si divide ogni riga per il suo totale
% ProfileRows ha dimensione IxJ
ProfilesRows = N./sum(N,2);

% ProfilesCols = matrice trasposta dei profili colonna 
% Si divide ogni colonna per il suo totale e si fa la trasposta
% La matrice dei profili colonna ha dimensione JxI
% ProfileCols ha dimensione IxJ
ProfilesCols = (N./sum(N,1));


%% Calcolo vettori r e c 
% r= vettore che contiene le masse di righe 
%  = centroidi dei profili colonna
r=sum(N,2)/n;

% c= vettore che contiene le masse di colonna 
%  = centroidi dei profili di riga
c=(sum(N,1)/n)';

%% Costruzione matrici Dr e Dc
% Queste matrici diagonali contengono rispettivamente i profili
% medi di colonna e riga sulla diagonale principale.
Dr = diag(r);
Dc = diag(c);

%% Verifica r e c (come medie aritmetiche ponderate)

% Verifico che le masse di  colonna non sono altro che i
% profili medi di riga e che le masse di riga non sono altro che i profili
% medi di colonna.
cchk=(ProfilesRows')*r;
rchk=ProfilesCols*c;
assert(max(abs(r-rchk))<1e-12,"Errore nel calcolo delle masse di riga")
assert(max(abs(c-cchk))<1e-12,"Errore nel calcolo delle masse di colonna")

%% Calcolo delle distanza (al quadrato) di ogni profilo dal profilo medio
% Distanza al quadrato dei profili riga dal profilo medio
% distI = vettore che contiene nell'elemento i-esimo la distanza (al
% quadrato) del profilo riga i-esimo dal profilo medio
distI=mahalFS(ProfilesRows,c',Dc);
% Distanza al quadrato dei profili colonna dal profilo medio
distJ=mahalFS(ProfilesCols',r',Dr);

% calcolo manuale di distI senza chiamare la funzione mahalFS
distIchk=zeros(I,1);
for i=1:I
    distIchk(i)=sum(  (ProfilesRows(i,:)-c').^2./(c')  );
end
assert(max(abs(distI-distIchk))<1e-12,"Errore di programmazione: le due " + ...
    "inerzie non coincidono")



% inI = inerzia totale dei punti riga
inI=sum(distI.*r);
% inJ = inerzia totale dei punti colonna
inJ=sum(distJ.*c);
assert(abs(inI-inJ)<1e-12,"Errore di programmazione: le due inerzie non coincidono")

%% Costruzione la matrice Z (scostamenti standardizzati)

% Diversi modi di calcolo di Z
% zij = sqrt( (p_{ij} - r_ic_j)^2 /r_ic_j ) =(p_{ij} - r_ic_j)/sqrt(r_ic_j)
Z     =  Dr^(-1/2) * (P - r * c') * Dc^(-1/2);
Zchk   = Dr^(1/2) * (ProfilesRows - onesI1 * c') * Dc^(-1/2); 

assert(max(abs(Z-Zchk),[],'all')<1e-12,"Errore di programmazione nel calcolo di Z")

% Inerzia totale calcolata come somma dei quadrati degli elementi della
% matrice Z
intot=sum(Z.^2,'all');


%% SVD of Z
[U,Gam,V] = svd(Z,'econ');

% k = numero massimo di dimensioni latenti
k = min(I-1,J-1);

Gam = Gam(1:k,1:k);
U   = U(:,1:k);
V   = V(:,1:k);


%% Inerzia totale come somma dei quadrati valori singolari

% Gam2= matrice diagonale che contiene sulla diagonale principale i
% quadrati dei valori singolari
Gam2 = Gam.^2;

TotalInertia     =  trace(Gam2);
assert(abs(TotalInertia-inI)<1e-12,"Errore di programmazione calcolo inerzia")

% % TotalInertia = sum_i sum_j (pij - ricj)^2 / ricj = X^2/n
% Chi2stat     = n*TotalInertia;
% 
% % V di Cramer
% CramerV = sqrt(Chi2stat/(n*(min(I,J)-1)));

%% Analisi dell'inerzia spiegata dalle prime k dimensioni latenti
% cumsumTotalInertia = cumulative proportion of explained inertia
cumsumTotalInertia = cumsum(diag(Gam2))/TotalInertia;

% InertiaExplained è una matrice con quattro colonne. La prima colonna
% contiene i valori singolari (la somma dei quadrati dei valori singolari
% è l'inerzia totale = varianza totale della tabella di contingenza). La
% seconda colonna contiene gli autovalori (ossia i quadrati dei valori
% singolari). La somma degli autovalori è l'inerzia totale. La terza
% colonna contiene la varianza spiegata da ciascuna dimensione latente. La
% quarta colonna contiene la varianza cumulata spiegata da ciascuna
% dimensione
InertiaExplained=[diag(Gam) diag(Gam2) diag(Gam2 / TotalInertia) cumsumTotalInertia];
ColNamesSummary={'Valori_singolari' 'Autovalori' 'Var_spiegata' 'Cum_Var_spiegata'};
RowNamesSummary=strcat(cellstr(repmat('dim_',k,1)), cellstr(num2str((1:k)')));
RowNamesSummary=regexprep(RowNamesSummary,' ','');

InertiaExplainedtable=array2table(InertiaExplained,'VariableNames',ColNamesSummary, ...);
    'RowNames',RowNamesSummary);
disp(InertiaExplainedtable)



%% Score di riga e di colonna delle prime 2 dimensioni latenti.
% e contributi di ogni punto (riga o colonna) all'inerzia 

% Coordinate principali dei punti riga
RowsPri     = Dr^(-1/2) * U*Gam;

% Coordinate principali dei punti colonna
ColsPri     = Dc^(-1/2) * V*Gam;
% Osservazione ColsPri'*Dc*ColsPri = matrice degli autovalori = quadrati
% dei valori singolari sulla diagonale principale

%% Grafico di analisi delle corrispondenze
close all
titl={'Grafico di analisi delle corrispondenze.' , ...
    'Plot of $X=D_r^{-1/2}U \Gamma$ and $Y= D_c^{-1/2} V \Gamma$'};
symbolrows='o';
symbolcols='^';
% Color for symbols and text for rows points
colorrows='b';
% Color for symbols and text for  column rows
colorcols='r';
MarkerSize=14;
hold('on')
plot(RowsPri(:,1),RowsPri(:,2),'LineStyle','none','Marker',symbolrows,'Color', colorrows,'MarkerSize',MarkerSize)
plot(ColsPri(:,1),ColsPri(:,2),'LineStyle','none','Marker',symbolcols,'Color', colorcols,'MarkerSize',MarkerSize)
Lr=["A=Marca commerciale" "B=Marca industriale" "C=indifferente"];
Lc=["Liguria" "Lombardia" "Piemonte" "Veneto"];
dx=0.05;
text(RowsPri(:,1),RowsPri(:,2)+dx,Lr)
text(ColsPri(:,1),ColsPri(:,2)+dx,Lc)

FontName='Times';
FontSizeAxisLabels=12;
title(titl,'Interpreter','Latex');

% Inserisco nelle etichette degli assi la varianza spiegata
% L'istruzione sprintf('%5.1f,....) significa che il numero deve essere
% mostrato con una sola cifra decimale
xlabel(['Dimensione 1 (',sprintf('%5.1f',InertiaExplained(1,3)*100),'%)'],'FontName', FontName, 'FontSize', FontSizeAxisLabels);
ylabel(['Dimension 2 (',sprintf('%5.1f',InertiaExplained(2,3)*100),'%)'],'FontName', FontName, 'FontSize', FontSizeAxisLabels);
axis(gca,'equal')
xline(0);
yline(0)
 % print -depsc figs\dentifricio.eps;



%% Analisi dei contributi
% Osservazione RowsPri'*Dr*RowsPri = matrice degli autovalori = quadrati
% dei valori singolari sulla diagonale principale
% Contributi delle diverse righe alla determinazione del primo autovalore
disp("Contributi delle diverse righe alla spiegazione del primo autov.")
disp(RowsPri(:,1).^2.*r/(Gam(1,1)^2))

% Osservazione: la quantità
% sum(RowsPri(:,1).^2.*r) è la varianza ponderata della
%  prima dimensione (primo autovalore =Gam(1,1)^2)

disp("Contributi delle diverse righe alla spiegazione del secondo autov.")
disp(RowsPri(:,2).^2.*r/(Gam(2,2)^2))
% Osservazione: la quantità
% sum(RowsPri(:,2).^2.*r) è la varianza ponderata della
% seconda dimensione (secondo autovalore =Gam(2,2)^2)


% Contributi delle diverse colonne alla determinazione del primo autovalore
disp("Contributi delle diverse colonne alla spiegazione del primo autov.")
disp(ColsPri(:,1).^2.*c/(Gam(1,1)^2))
% Osservazione: la quantità
% sum(ColsPri(:,1).^2.*c) è la varianza ponderata della 
% prima dimensione (primo autovalore =Gam(1,1)^2)

% Contributi delle diverse colonne alla determinazione del secondo
% autovalore
disp("Contributi delle diverse righe alla spiegazione del secondo autov.")
disp(ColsPri(:,2).^2.*c/(Gam(2,2)^2))
% Osservazione: la quantità
% sum(ColsPri(:,2).^2.*c)
% è la varianza ponderata della seconda
% dimensione (secondo autovalore =Gam(2,2)^2)

% Contributi della dimensione all'inerzia dei punti
% Osservazione: il vettore distI.^2  contiene la distanza al quadrato di
% ogni profilo riga dal profilo medio (inerzia di ogni punto)
% Contributi delle due dimensioni alla spiegazione dell'in. di ogni punto
disp("Contributi relativi delle due dimensioni alla " + ...
    "spiegazione dell'inerzia di ogni punto riga")
ContrassolutiR=RowsPri.^2./distI.^2;
ContrrelativiR=ContrassolutiR./sum(ContrassolutiR,2);
disp(ContrrelativiR)
disp("Contributi relativi delle due dimensioni alla " + ...
    "spiegazione dell'inerzia di ogni punto colonna")
ContrassolutiC=ColsPri.^2./distJ.^2;
ContrrelativiC=ContrassolutiC./sum(ContrassolutiC,2);
disp(ContrrelativiC)

%% Chiamata a CorAna (sezione non presente nel testo)

Lr=["A=Marca commerciale" "B=Marca industriale" "C=indifferente"];
Lc=["Liguria" "Lombardia" "Piemonte" "Veneto"];

Ntable=array2table(N,"RowNames",Lr,"VariableNames",Lc);
out=CorAna(Ntable);

CorAnaplot(out)

% Chiamata a moonplot
moonplot(out)