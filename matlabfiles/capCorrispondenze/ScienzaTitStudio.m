%% Atteggiamento verso la scienza e titolo di studio
X = readtable('scienza.xlsx','Sheet','dati');

% Etichette delle righe e delle colonne della tabella di contingenza
Lr={'1= per niente' '2= poco fav' '3= indiff' ...
'4= fav' '5= molto fav'};
Lc={'1= lic elem' '2= lic media' '3= diploma' ...
'4= laurea tri' '5= laurea spe' '6= dottorat'};
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

%% Per tracciare gli ellissi di confidenza
% Di seguito viene aggiunto l'ellisse di confidenza al punto riga "per
% niente" ed al punto colonna 
confellipse.selRows=1;
confellipse.selCols=1;
confellipse.method={'multinomial'};
CorAnaplot(out,'confellipse',confellipse)


