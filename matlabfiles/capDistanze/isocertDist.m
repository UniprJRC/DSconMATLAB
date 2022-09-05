%% X = numero di certificazioni ISO (5 paesi e 2 anni)
X = [1.2 2.1; 3.4 5.1; 1.9 2.2; 4.1 2.3; 4.2 2.9];
disp(pdist(X))

%% Calcolo della matrice delle distanze Euclidee
D=squareform(pdist(X));
% nomirighe = vettore colonne che contiene le
% etichette dei paesi in formato string.
% Avvertenza se non chiamiamo la funzione string
% quando si va a chiamare array2table otteniamo l'errore che segue
% The RowNames property must be a string array or a cell array,
% with each name containing one or more characters.
nomirighe=string(('A':'E')');
% L'array D viene trasformato in table
Dtable=array2table(D,"RowNames",nomirighe,"VariableNames",nomirighe);
disp(Dtable)

%% Calcolo della matrice delle distanze cityblock
D=squareform(pdist(X,"cityblock"));
% nomirighe = vettore colonne che contiene le
% etichette dei paesi in formato string.
% Avvertenza se non chiamiamo la funzione string
% quando si va a chiamare array2table otteniamo l'errore che segue
% The RowNames property must be a string array or a cell array,
% with each name containing one or more characters.
nomirighe=string(('A':'E')');
% L'array D viene trasformato in table
Dtable=array2table(D,"RowNames",nomirighe,"VariableNames",nomirighe);
disp(Dtable)

%% Calcolo della matrice delle distanze Minkowski con k=3
D=squareform(pdist(X,"minkowski",3));
% nomirighe = vettore colonne che contiene le
% etichette dei paesi in formato string.
% Avvertenza se non chiamiamo la funzione string
% quando si va a chiamare array2table otteniamo l'errore che segue
% The RowNames property must be a string array or a cell array,
% with each name containing one or more characters.
nomirighe=string(('A':'E')');
% L'array D viene trasformato in table
Dtable=array2table(D,"RowNames",nomirighe,"VariableNames",nomirighe);
disp(Dtable)



