%% Caricamento dati 
miofile="Firm.xlsx";
Xt=readtable(miofile,"ReadRowNames",true);
Xt.Gender = categorical(Xt.Gender);
Xt.Education=categorical(Xt.Education,{'A','B','C'},'Ordinal',true');

% Estrazione delle variabili quantitative nell'array Xd e nella table Xtq
% Osservazione: Xd contiene solo i numeri (matrice 107x4 di doubles)
% Xtq è la table (107x4) riferita solo alle variabile quantitative
nomiq=["Wage" "CommutingTime" "SmartWorkHours" "Seniority" ];
Xdq=Xt{:,nomiq};
Xtq=Xt(:,nomiq);

% Formattazione della visualizzazione dei numeri
% con solo due cifre decimali
format bank

%% Calcolo delle medie campionarie (convertendo in array)
disp('Medie campionarie (convertendo prima in array)')
medie=mean(Xdq);
medieT=array2table(medie,"VariableNames",nomiq);
disp(medieT)

%% Calcolo delle medie campionarie (applicando mean alla table)
medieCHK=mean(Xtq);
disp('Medie campionarie (funzione mean applicata alla table Xt)')
disp(medieCHK)

%% Calcolo delle mediane campionarie
disp('Mediane campionarie (median applicata direttamente alla table)')
mediane=median(Xtq);
disp(mediane)


%% Calcolo degli scostamenti quadratici medi corretti
% scorr= standard deviations in formato table
scorr=std(Xtq);

% n= numerosità del campione
n=size(Xdq,1);

% Implementazione manuale di scorr (scorrCHK è un array di dati numerici)
scorrCHK=sqrt(sum((Xdq-medie).^2)/(n-1));

tol=1e-12;
assert(max(abs(scorr{:,:}-scorrCHK)<tol),"Implementazione" + ...
    "errata di scorr ")

disp('Coefficienti di variazione (CV)')
cvt=scorr./abs(medie);
disp(cvt)


%% Indici di asimmetria e curtosi

% Calcolo degli indici di asimmetria
disp('Indici di asimmetria (calcolati tramite la formula skewness)')
% Il secondo argomento di skewness consente di specificare che
% vogliamo la versione corretta (non distorta) dell'indice
sk=skewness(Xdq,0);
skT=array2table(sk,"VariableNames",nomiq);
disp(skT)

% Indici di skewness calcolati manualmente
Z=zscore(Xdq); % Z = matrice degli scostamenti standardizzati
skCHK=(n/((n-1)*(n-2)))*sum(Z.^3,1);
assert(max(abs(sk-skCHK)<tol),"Implementazione" + ...
    "errata degli indici di asimmetria ")

% Calcolo degli indici di curtosi
disp('Indici di curtosi (calcolati tramite la funzione kurtosis)')
% Il secondo argomento di kurtosis consente di specificare che
% vogliamo la versione corretta (non distorta) dell'indice
kur=kurtosis(Xdq,0);
kurT=array2table(kur,"VariableNames",nomiq);
disp(kurT)

% Indici di curtosi calcolati manualmente
kurCHK=((n+1)*n)/((n-1)*(n-2)*(n-3))*sum(Z.^4,1) ...
    -3*(n-1)^2/((n-2)*(n-3))+3;
assert(max(abs(kur-kurCHK)<tol),"Implementazione" + ...
    "errata degli indici di curtosi ")

%% Grafico a istogramma variabile quantitativa
% Di seguito vengono elencati svariati modi in cui può essere chiamata la
% funzione histogram in presenza di una variabile quantitativa

close all
histogram(Xt.Wage)

histogram(Xt.Wage,10)

histogram(Xt.Wage,2000:500:4500)

histogram('BinEdges',2000:500:3500,'BinCounts',[20 10 12])

%% Grafico a istogramma variabile categorica
% Di seguito vengono elencati svariati modi in cui può essere chiamata la
% funzione histogram in presenza di una variabile categorica

histogram(Xt.Education)

histogram(Xt.Education,'Categories',{'B','C'})

histogram('Categories',{'Si','No','Forse'},'BinCounts',[22 18 3])

% histogram con 'Name',Value
histogram(Xt.Education,'BarWidth',0.99)

% histogram con sintassi Name=Value
histogram(Xt.Education,BarWidth=0.99)

% Creazione oggetto di tipo histogram nella 
% variabile denominata NomeaCaso
NomeaCaso=histogram(Xt.Education,'BarWidth',0.5);

% Cambio il colore delle barre
NomeaCaso.FaceColor='r';

