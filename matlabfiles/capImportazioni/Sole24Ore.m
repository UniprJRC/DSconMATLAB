!git clone https://github.com/IlSole24ORE/QDV2022.git

nomeCartella='QDV2022';
nomeFile='20221213_QDV2022_001.csv';
X=readtable([nomeCartella filesep nomeFile]);
Xsel=X(:,["DENOMINAZIONECORRENTE" "VALORE","INDICATORE"]);
X1=unstack(Xsel,"VALORE","INDICATORE");
