% Creazioni vettori chiavi valori
n = 1000000;
chiavi = "ID" + string(1:n)';    valori = randn(n,1); 
% nkey = numero di chiavi da cercare
nkey=1000;
% Si estraggono a caso nkey elementi da chiavi
chiaviDaCercare = randsample(chiavi,nkey); 

%% Tempo creazione dictionary e tempo per cercare nel dizionario
tic; dict = dictionary(chiavi, valori); tempoPerCreareDizionario=toc;

tic; outputDictionary=dict(chiaviDaCercare); tempoPerCercareNelDizionario=toc;

%% Tempo creazione table con due cols e tempo per cercare nella table 
tic; T2cols = table(chiavi, valori); tempoPerCreareTable2cols=toc;

tic
% preallocazione vettore di output
outputTable2Cols = zeros(nkey,1);
% loop di ricerca chiave - valore
for i = 1:nkey
    % Vado a vedere in quale posizione è chiaviDaCercare(i) dentro 
    % T2cols.Chiavi i=1, 2, ..., nkey
    idx = strcmp(T2cols.chiavi, chiaviDaCercare(i));
    outputTable2Cols(i) = T2cols.valori(idx);
end
tempoPerCercareNellaTable2cols = toc;

%% Tempo creazione table con una col e tempo per cercare nella table 
tic; T1col = table(valori, 'RowNames', chiavi); tempoPerCreareTable1col=toc;

tic; outputTable1Col=T1col{chiaviDaCercare,1}; tempoPerCercareNellaTable1col = toc;
%% Controllo uguaglianza delle diverse implementazioni
assert(max(abs(outputDictionary-outputTable2Cols))<eps,"Output non uguale")
assert(max(abs(outputTable2Cols-outputTable1Col))<eps,"Output non uguale")


%% risultati delle tempistiche
disp(['Creazione oggetto Dictionary: ' num2str(tempoPerCreareDizionario) ' secondi']);
disp(['Tempo ricerca oggetto Dictionary: ' num2str(tempoPerCercareNelDizionario) ' secondi']);
disp('--------------------------------------------------------------')
disp(['Creazione table con 2 cols: ' num2str(tempoPerCreareTable2cols) ' secondi']);
disp(['Tempo ricerca table con 2 cols: ' num2str(tempoPerCercareNellaTable2cols) ' secondi']);
disp('--------------------------------------------------------------')
disp(['Creazione table con 1 col e RowNames: ' num2str(tempoPerCreareTable1col) ' secondi']);
disp(['Tempo ricerca table con 1 col e RowNames: ' num2str(tempoPerCercareNellaTable1col) ' secondi']);


% %% Cambiamento delle Chiavi
% % Assign the value to the new key
% oldkey="ID3";
% dict("oldKey")=20;
% % Remove the old key
% dict(oldkey) = []; % Now "Bicycle" is removed