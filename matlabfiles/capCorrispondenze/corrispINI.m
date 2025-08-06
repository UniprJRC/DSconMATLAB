% Tabella di contingenza di partenza
N=[49	111	13	49; 16	551	241	7; 34	358	30	117];    [I,J]=size(N);

%% Calcolo matrice P
% n= numero di unità del campione
n=sum(N,'all');
P = (1/n) * N;

% Verifico tramite moltiplicazione matriciale che la somma degli elementi
% di P è pari 1.
onesI1=ones(I,1); onesJ1=ones(J,1); sumelP=onesI1'*P*onesJ1;
assert(abs(sumelP-1)<1e-12,"La somma degli elementi di P non è 1")

%%  Calcolo delle matrici dei profili riga e colonna 
ProfilesRows = N./sum(N,2);
ProfilesCols = N./sum(N,1);

%% Calcolo vettori r e c 
r=sum(N,2)/n;
c=(sum(N,1)/n)';

%% Costruzione matrici Dr e Dc
Dr = diag(r);
Dc = diag(c);

%% Verifica r e c (come medie aritmetiche ponderate)
cchk=(ProfilesRows')*r;
rchk=ProfilesCols*c;
assert(max(abs(r-rchk))<1e-12,"Errore nel calcolo delle masse di riga")
assert(max(abs(c-cchk))<1e-12,"Errore nel calcolo delle masse di colonna")

%% Calcolo delle distanza (al quadrato) di ogni profilo dal profilo medio
distI=mahalFS(ProfilesRows,c',Dc);
distJ=mahalFS(ProfilesCols',r',Dr);

% calcolo manuale di distI senza chiamare la funzione mahalFS
distIchk=zeros(I,1);
for i=1:I
    distIchk(i)=sum(  (ProfilesRows(i,:)-c').^2./(c')  );
end
assert(max(abs(distI-distIchk))<1e-12,"Errore di programmazione: le due " + ...
    "inerzie non coincidono")

%% Calcolo inerzia totale
inI=sum(distI.*r);
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
assert(abs(intot-inJ)<1e-12,"Errore di programmazione: le due inerzie non coincidono")

%% SVD of Z
[U,Gam,V] = svd(Z,'econ');

% k = numero massimo di dimensioni latenti
k = min(I-1,J-1);

Gam = Gam(1:k,1:k);
U   = U(:,1:k);
V   = V(:,1:k);


%% Inerzia totale come somma dei quadrati dei valori singolari
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

InertiaExplained=[diag(Gam) diag(Gam2) diag(Gam2 / TotalInertia) cumsumTotalInertia];
ColNamesSummary={'Valori_singolari' 'Autovalori' 'Var_spiegata' 'Cum_Var_spiegata'};
RowNamesSummary="dim_"+(1:k)';
InertiaExplainedtable=array2table(InertiaExplained,'VariableNames', ...
    ColNamesSummary, 'RowNames',RowNamesSummary);
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
% Simboli e colori
symbolrows='o'; colorrows='b';
symbolcols='^'; colorcols='r';
MarkerSize=14; hold('on')
plot(RowsPri(:,1),RowsPri(:,2),'LineStyle','none','Marker',symbolrows,'Color', colorrows,'MarkerSize',MarkerSize)
plot(ColsPri(:,1),ColsPri(:,2),'LineStyle','none','Marker',symbolcols,'Color', colorcols,'MarkerSize',MarkerSize)
Lr=["A=Marca commerciale" "B=Marca industriale" "C=indifferente"];
Lc=["Liguria" "Lombardia" "Piemonte" "Veneto"];
dx=0.05;
text(RowsPri(:,1),RowsPri(:,2)+dx,Lr)
text(ColsPri(:,1),ColsPri(:,2)+dx,Lc)

title(titl,'Interpreter','Latex');

% Inserisco nelle etichette degli assi la varianza spiegata
% L'istruzione sprintf('%5.1f,....) significa che il numero deve essere
% mostrato con una sola cifra decimale
s1=sprintf('%5.1f',InertiaExplained(1,3)*100);
s2=sprintf('%5.1f',InertiaExplained(2,3)*100);

FontName='Times';
fsal=12; % Font Size Axes Labels
xlabel(['Dimensione 1 (' s1 '%)'],'FontName', FontName, 'FontSize', fsal);
ylabel(['Dimensione 2 (' s2 '%)'],'FontName', FontName, 'FontSize', fsal);
axis(gca,'equal')
xline(0); yline(0)
 % print -depsc figs\dentifricio.eps;

%% Analisi dei contributi
disp("Contributi delle diverse righe alla spiegazione del primo autov.")
disp(RowsPri(:,1).^2.*r/(Gam(1,1)^2))

disp("Contributi delle diverse righe alla spiegazione del secondo autov.")
disp(RowsPri(:,2).^2.*r/(Gam(2,2)^2))

disp("Contributi delle diverse colonne alla spiegazione del primo autov.")
disp(ColsPri(:,1).^2.*c/(Gam(1,1)^2))

disp("Contributi delle diverse colonne alla spiegazione del secondo autov.")
disp(ColsPri(:,2).^2.*c/(Gam(2,2)^2))

disp("Contributi relativi delle due dimensioni alla spiegazione dell'inerzia di ogni punto riga")
disp(RowsPri.^2./distI)
disp("Contributi relativi delle due dimensioni alla spiegazione dell'inerzia di ogni punto colonna")
disp(ColsPri.^2./distJ)

%% Chiamata a CorAna (sezione non presente nel testo)

% Tabella relativa all'uso della marca di dentifricio in 4 regioni
N=[49	111	13	49
16	551	241	7
34	358	30	117];
[I,J]=size(N);

Lr=["A=Marca commerciale" "B=Marca industriale" "C=indifferente"];
Lc=["Liguria" "Lombardia" "Piemonte" "Veneto"];

Ntable=array2table(N,"RowNames",Lr,"VariableNames",Lc);
out=CorAna(Ntable);

CorAnaplot(out)

%% Chiamata a moonplot
moonplot(out)

%% Analisi partendo direttamente dal file di Excel
X=readtable('dentifricio.xlsx','Range','A1:B1177','Sheet','dati');
CorAna(X,'datamatrix',true)