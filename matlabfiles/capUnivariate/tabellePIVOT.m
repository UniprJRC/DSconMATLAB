%% Caricamento dati
miofile="Firm.xlsx"; % Caricamento file Firm.xlsx dentro MATLAB 
X=readtable(miofile,"ReadRowNames",true);

%% Costruzione tablle pivot tramite la funzion pivot (da MATLAB 2023A)

% Variabile Gender sulle righe (nessuna variabile sulle colonne)
pivot(X,'Rows','Gender')

% Le modalità della variabile sulle righe sono inseriti come RowNames
pivot(X,'Rows','Gender','RowLabelPlacement','rownames')

% Variabile Gender sulle righe, Variabile Education sulle colonne, all'interno le frequenze
pivot(X,'Rows','Gender','Columns','Education')

% Come la precedente ma con l'aggiunta della riga dei totali per righe e colonne
pivot(X,'Rows','Gender','Columns','Education','IncludeTotals',true)

% Come la precedente ma ora le modalità della variabile
% sulle righe sono inserite come RowNames
pivot(X,'Rows','Gender','Columns','Education','IncludeTotals',true, ...
    'RowLabelPlacement','rownames')

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
    'DataVariable','Wage','Method',method);
disp(pv3)

% Variabile retribuzione sulle righe. Variabile Education sulle colonne
% La variabile sulle righe viene suddivisa in 5 classi
pivot(X,'Rows','Wage','Columns','Education','RowsBinMethod',5)

%% Inizio soluzione esercizio 3.12

X1=X; 
X1.Wage(1)=2000;

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

%% Parte non presente nel libro
% In alternativa ad un cell array i due criteri di raggruppamento possono
% essere inseriti in uno string array
pv4chk=pivot(X1,'Rows',["Wage" "Seniority"],'Columns','Education', ...
    'RowsBinMethod',{1500:1000:4500 0:15:45});
assert(isequal(pv4,pv4chk),"Cell arrary o array di stringhe non corretti")

%% Parte non inserita nel libro 
% Se c'è più più di un criterio di raggruppamento per riga
% "RowLabelPlacement","rownames" crea nomi righe che combinano i due
% criteri di raggruppamento
pv4ConNomiRighe=pivot(X1,'Rows',{'Gender' 'Education'},'Columns','Seniority', ...
    'ColumnsBinMethod',0:15:45,"RowLabelPlacement","rownames");
disp(pv4ConNomiRighe)

%% Parte inserita nel libro
% Se una variabile è già qualitativa e non deve essere raggruppata in
% classi utilizzare 'none'
disp('Tabella pivot punto 5)')
pv5=pivot(X1,'Rows',{'Gender' 'Seniority'},'Columns','Education', ...
    'RowsBinMethod',{'none' [0 20 30 45]}, ...
    'DataVariable','Wage','Method','median');
disp(pv5)


%% Inizio Esercizio 3.10

% Se c'è più di una variabile sulle colonne, MATLAB crea tabelle nested
% una dentro l'altra 
disp('Tabella pivot pv6')
pv6=pivot(X1,'Columns',{'Gender' 'Seniority'},'Rows','Education', ...
    'ColumnsBinMethod',{'none' [0 20 45]}, ...
    'DataVariable','Wage','Method','min');
disp(pv6)
disp('Nomi delle variabili di pv6')
disp(pv6.Properties.VariableNames)

% Per evitare di creare tabelle nested e concatenare i nomi delle modalità
% delle due variabili inserite nelle colonne, occorre specificare 
% 'OutputFormat','flat'
disp('Tabella pivot pv7')
pv7=pivot(X1,'Columns',{'Gender' 'Seniority'},'Rows','Education', ...
    'ColumnsBinMethod',{'none' [0 20 45]}, ...
    'DataVariable','Wage','Method','min','OutputFormat','flat');
disp(pv7)
disp('Nomi delle variabili di pv7')
disp(pv7.Properties.VariableNames)


%% Parte non inserita nel libro 
% Aggiunta opzione 'RowLabelPlacement','rownames'
pv8=pivot(X1,'Columns',{'Gender' 'Seniority'},'Rows','Education', ...
    'ColumnsBinMethod',{'none' [0 20 45]}, ...
    'DataVariable','Wage','Method','min','OutputFormat','flat', ...
    'RowLabelPlacement','rownames');
disp(pv8)


