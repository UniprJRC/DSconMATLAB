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

%% 
% Lr={'1= per niente favorevole' ...
% '2= poco favorevole' ...
% '3= indifferente' ...
% '4= favorevole' ...
% '5= molto favorevole'};
% Lc={'1= licenza elementare' ...
% '2= licenza media' ...
% '3= diploma di scuola media superiore' ...
% '4= laurea triennale' ...
% '5= laurea specialistica' ...
% '6= dottorato di ricerca'};


%% In alternativa per legger i dati si poteva utilizzare
% Da notare che in questo caso Xchk un array e non una table 
Xchk=xlsread('TURNO1soluzione.xlsx','dati','B2:E872');
% Nelle release 2018 di MATLAB si possono utilizzare anche i simboli " "
% invece dei simboli ' '
% Xchk=xlsread("TURNO1soluzione.xlsx","dati","B2:E872");

% Dato che Xchk è au array 
outchk=CorAna(Xchk(:,2:3),'datamatrix',true,'Lr',Lr,'Lc',Lc);

% Per tracciare gli ellissi di confidenza

confellipse.selRows=1;
confellipse.selCols=2;
confellipse.method={'multinomial'};
CorAnaplot(outchk,'confellipse',confellipse)

%% Calcolo indice gamma (C-D)/(C+D)
corrOrdinal(Xchk(:,2:3),'datamatrix',true)

% Commento: concordanza di andamento tra "posizione verso la scienza" e
% "titolo di studio".  Chi presenta un titolo di studio più alto tende ad
% avere una posizione molto favorevole verso la scienza e viceversa
