%% Atteggiamento verso la scienza e titolo di studio
X = readtable('scienza.xlsx','Sheet','dati');

% Etichette delle righe e delle colonne della tabella di contingenza
% Lr={'1= per niente' '2= poco fav' '3= indiff' ...
% '4= fav' '5= molto fav'};
% Lc={'1= lic elem' '2= lic media' '3= diploma' ...
% '4= laurea tri' '5= laurea spe' '6= dottorat'};

Lr={'1PerNiente' '2PocoFav' '3Indiff' ...
'4Fav' '5MoltoFav'};
Lc={'1LicElem' '2LicMedia' '3Diploma' ...
'4LaureaTri' '5LaureaSpe' '6Dottorato'};

% il name,value 'datamatrix',true consente di specificare
% che l'input è una matrice dei dati e di conseguenza la routine deve
% calcolare internamente la tabella di contingenza
format bank
out=CorAna(X(:,1:2),'datamatrix',true,'Lr',Lr,'Lc',Lc)

% print -depsc scienzaedu.eps;


%% In alternativa per leggere i dati si poteva utilizzare
% Da notare che in questo caso Xchk un array e non una table 
Xchk=xlsread('scienza.xlsx','dati','A2:B872','basic');

% Dato che Xchk è un array 
outchk=CorAna(Xchk,'datamatrix',true,'Lr',Lr,'Lc',Lc);

%% Contribution biplot
plots=struct;
plots.alpha='rowgreen';
CorAnaplot(out,'plots',plots)

%% Etichette con colore che dipende dal contributo dei punti alla spiegazione dell'inerzia
plots=struct;
plots.ColorMapLabelCols='CntrbPnt2In'; 
CorAnaplot(out,'plots',plots)
% print -depsc figs/scienzaeduCMAP.eps;


%% Per tracciare gli ellissi di confidenza
% Di seguito viene aggiunto l'ellisse di confidenza al punto riga "per
% niente" ed al punto colonna 
confellipse=struct;
confellipse.selRows=[1:3 5];
confellipse.selCols=[];
confellipse.conflev=0.91;
CorAnaplot(out,'confellipse',confellipse)
% print -depsc figs/scienzaeduCE.eps;

%% Moonplot
moonplot(out)
% print -depsc scienzaeduMP.eps;
