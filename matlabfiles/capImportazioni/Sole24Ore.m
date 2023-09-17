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
