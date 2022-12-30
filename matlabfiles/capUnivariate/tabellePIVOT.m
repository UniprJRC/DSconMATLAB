%% Costruzione tablle pivot tramite la funzion pivot (SOLO MATLAB 2023A)

% Variabile Gender sulle righe (nessuna variabile sulle colonne)
pivot(X,'Rows','Gender')

% Variabile Gender sulle righe, Variabile Education sulle colonne
% All'interno le frequenze
pivot(X,'Rows','Gender','Columns','Education')


% Come la precedente ma con l'aggiunta della riga dei totali per righe
% e colonne
pivot(X,'Rows','Gender','Columns','Education','IncludeTotals',true)

% Variabile Gender sulle righe, Variabile Education sulle colonne
% All'interno la media della retribuzione
pivot(X,'Rows','Gender','Columns','Education', ...
    'DataVariable','Wage','Method','mean')

% Come la precendente, ma con l'aggiunta delle medie complessive
pivot(X,'Rows','Gender','Columns','Education', ...
    'DataVariable','Wage','Method','mean','IncludeTotals',true)

% Variabile Gender sulle righe, Variabile Education sulle colonne
% All'interno sia il minimo sia il massimo  della retribuzione
method=@(x)[min(x) max(x)];
pv3=pivot(X,'Rows','Gender','Columns','Education', ...
    'DataVariable','Wage','Method',method)

% Variabile retribuzione sulle righe. Variabile Education sulle colonne
% La variabile sulle righe viene suddivisa in 5 classi
pivot(X,'Rows','Wage','Columns','Education','RowsBinMethod',5)

%% Inizio soluzione esercizio sulle tabelle pivot

X1=X; 
X1.Wage(1)=2000;

% Per specificare le classi con gli estremi richiesti sulle righe occorre
% che 'RowsBinMethod' contenga gli estremi delle classi
disp('Tabella pivot punto 1)')
pv1=pivot(X1,'Rows','Wage','Columns','Education', ...
    'RowsBinMethod',1500:500:4500);
disp(pv1)

% Per definire classi chiuse a destra utilizzare 'IncludedEdge'
disp('Tabella pivot punto 2)')
pv2=pivot(X1,'Rows','Wage','Columns','Education', ...
    'RowsBinMethod',1500:500:4500,'IncludedEdge','right');
disp(pv2)


% Per definire più di una variabile sulle righe o sulle colonne
% inserire i nomi delle variabili in un cell array
disp('Tabella pivot punto 3)')
pv3=pivot(X1,'Rows',{'Gender' 'Education'},'Columns','Seniority', ...
    'ColumnsBinMethod',0:15:45);
disp(pv3)


% Per definire due criteri di raggruppamento occorre inserirle in un cell
% array
disp('Tabella pivot punto 4)')
pv4=pivot(X1,'Rows',{'Wage' 'Seniority'},'Columns','Education', ...
    'RowsBinMethod',{1500:1000:4500 0:15:45});
disp(pv4)

% Se una variabile è già qualitativa e non deve essere raggruppata in
% classi utilizzare 'none'
disp('Tabella pivot punto 5)')
pv5=pivot(X1,'Rows',{'Gender' 'Seniority'},'Columns','Education', ...
    'RowsBinMethod',{'none' [0 20 30 45]}, ...
    'DataVariable','Wage','Method','median');
disp(pv5)

% Se c'è più di una variabile sulle colonne, MATLAB crea tabelle nested
% una dentro l'altra 
disp('Tabella pivot pv6')
pv6=pivot(X1,'Columns',{'Gender' 'Seniority'},'Rows','Education', ...
    'ColumnsBinMethod',{'none' [0 20 45]}, ...
    'DataVariable','Wage','Method','min');
disp(pv6)
disp('Nomi delle variabili di pv6')
disp(pv6.Properties.VariableNames)

disp('Tabella pivot pv7')
% Per evitare di creare tabelle nested e concatenare i nomi delle modalità
% delle due variabili inserite nelle colonne, occorre specificare 
% 'OutputFormat','flat'
pv7=pivot(X1,'Columns',{'Gender' 'Seniority'},'Rows','Education', ...
    'ColumnsBinMethod',{'none' [0 20 45]}, ...
    'DataVariable','Wage','Method','min','OutputFormat','flat');
disp(pv7)
disp('Nomi delle variabili di pv7')
disp(pv7.Properties.VariableNames)


% pivot(X,'Rows','Gender','Columns','Education','OutputFormat','flat')

