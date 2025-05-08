%% Cartella clonata
% La cartella viene clonata nella sottocartella QDV2022 della cartella
% corrente
!git clone https://github.com/IlSole24ORE/QDV2022.git

%% Caricamento dataset in MATLAB
nomeCartella='QDV2022';
nomeFile='20221213_QDV2022_001.csv';
X=readtable([nomeCartella filesep nomeFile]);

%% Creazione della table contenente la matrice dei dati province x variabili 
Xsel=X(:,["DENOMINAZIONECORRENTE" "VALORE","INDICATORE"]);
X1=unstack(Xsel,"VALORE","INDICATORE");

%% Parte non nel libro: scaricamento dati 2023
!git clone https://github.com/IlSole24ORE/QDV2023.git

%% Caricamento dataset 2023 in MATLAB
nomeCartella='QDV2023';
nomeFile='20231204_QDV2023_001.csv';
X=readtable([nomeCartella filesep nomeFile]);

%% Creazione della table contenente la matrice dei dati province x variabili 
Xsel=X(:,["DENOMINAZIONECORRENTE" "VALORE","INDICATORE"]);
X1=unstack(Xsel,"VALORE","INDICATORE");

% La prima colonna di X1 deve diventare i nomi delle righe
X1.Properties.RowNames=X1{:,1};
X1=X1(:,2:end);


%% Parte non nel libro: scaricamento dati 2024
!git clone https://github.com/IlSole24ORE/QDV2024.git

%% Caricamento dataset 2024 in MATLAB
nomeCartella='QDV2024';
nomeFile='20241216_QDV2024_001.csv';
X=readtable([nomeCartella filesep nomeFile]);

%% Creazione della table contenente la matrice dei dati province x variabili 
Xsel=X(:,["DENOMINAZIONECORRENTE" "VALORE","INDICATORE"]);
X1=unstack(Xsel,"VALORE","INDICATORE");

% La prima colonna di X1 deve diventare i nomi delle righe
X1.Properties.RowNames=X1{:,1};
X1=X1(:,2:end);
