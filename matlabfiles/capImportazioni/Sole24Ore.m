%% Cartella clonata
% La cartella viene clonata nella sottocartella QDV2022 della cartella
% corrente
!git clone https://github.com/IlSole24ORE/QDV2022.git

%% Caricamento dataset 2022
nomeCartella='QDV2022';
nomeFile='20221213_QDV2022_001.csv';
X22=readtable([nomeCartella filesep nomeFile]);

%% Creazione della table contenente la matrice dei dati province x variabili 
Y2=pivot(X22(1:end-1,:),"Rows","DENOMINAZIONECORRENTE","Columns","INDICATORE", ...
    'DataVariable','VALORE','Method','none','RowLabelPlacement','rownames');

%% Scaricamento dati 2023
!git clone https://github.com/IlSole24ORE/QDV2023.git

%% Caricamento dataset 2023 
nomeCartella='QDV2023';
nomeFile='20231204_QDV2023_001.csv';
X23=readtable([nomeCartella filesep nomeFile]);

%% Creazione della table contenente la matrice dei dati province x variabili 
Y3=pivot(X23,"Rows","DENOMINAZIONECORRENTE","Columns","INDICATORE", ...
    'DataVariable','VALORE','Method','none','RowLabelPlacement','rownames');

%% Scaricamento dati 2024
!git clone https://github.com/IlSole24ORE/QDV2024.git

%% Caricamento dataset 2024 
nomeCartella='QDV2024';
nomeFile='20241216_QDV2024_001.csv';
X24ini=readtable([nomeCartella filesep nomeFile]);
X24=unique(X24ini,"rows");

%% Creazione della table contenente la matrice dei dati province x variabili 
Y4=pivot(X24,"Rows","DENOMINAZIONECORRENTE","Columns","INDICATORE", ...
    "DataVariable","VALORE",'Method','none','RowLabelPlacement','rownames');

%%
[~, idx] = unique(X24ini, 'rows', 'stable'); % Get unique rows and their indices
duplicatedRows = setdiff(1:height(X24ini), idx); % Find indices of duplicated rows

% Extract duplicated rows
duplicatedTable = X24ini(duplicatedRows, :);