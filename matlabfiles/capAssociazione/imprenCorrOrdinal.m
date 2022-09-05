%% Caricamento dati
N=[28	1	0
17	26	10
0	5	13];

% L'opzoine conflev consente di specificare il livello
% di confidenza
out=corrOrdinal(N,'conflev',0.99);

