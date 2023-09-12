inp=webread('http://oeis.org/A013929/b013929.txt');
% Dato che l'output di urlread è in formato char occorre applicare
% la funzione str2num per convertire l'output in formato numerico.
X=str2num(inp);
% La funzione head mostra il preview delle prime 8 righe
head(X)