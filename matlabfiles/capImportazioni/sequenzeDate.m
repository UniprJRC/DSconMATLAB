%% Una data
datetime(2023,10,3)


%% Sequenza di anni
datetime(2015:2:2023,10,3)

%% Sequenza di giorni
datetime(2023,12,10):datetime(2024,1,5)

%% Sequenza di mesi
datetime(2023,8,3):calmonths:datetime(2023,12,3)

%% Parte non inserita nel testo
% L'input di datetime può essere una stringa che definisce una determinata
% data. Supponiamo che la data abbia il formato 
% '12//13---2023'
% Le prime due si riferiscono al mese
% Dopo il simbolo di // abbiamo il giorno
% Dopo il simbolo --- c'è l'anno.
% Il Name Value InputFormat consente di specificare questo

aa=datetime('12//13---2023','InputFormat','MM//dd---yyyy');
disp(aa)

% Come visualizzare le date con un determinato formato?
zz=datetime(2023,8,3):calmonths:datetime(2023,12,3);
% Supponiamo di voler visualizzare zz con solo il mese e poi l'anno ed il
% segno di separatore sia /
zz.Format='MM/yyyy';
disp(zz)



