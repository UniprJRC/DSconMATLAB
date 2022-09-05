%% Matrice di partenza
X=[1 1 1 1 1;
    1 1 1 1 0;
    0 1 0 1 0;
    1 1 0 1 0;
    0 0 0 0 0;
    0 0 0 1 0];
[n,p]=size(X);
% rowlab = string array che contiene i nomi delle righe di X
rowlab=string(('A':'F')');

disp('Matrice di similarità di Jaccard')
SJ=1-squareform(pdist(X,"jaccard"));
StableJ=array2table(SJ,"RowNames",rowlab,'VariableNames',rowlab);
disp(StableJ)

disp('Matrice di similarità di Sokal Michener (Hamming)')
SSM=1-squareform(pdist(X,"hamming"));
SSMtable=array2table(SSM,"RowNames",rowlab,'VariableNames',rowlab);
disp(SSMtable)


%% Indici di similarità di Russel Rao
% SRR = matrice degli indici di similarità di Russel Rao
% Viene inizializzata come una matrice di zeri di dimensione nxn
SRR=zeros(n,n);
for i=1:n
    % si confronta la riga i-esima della matrice X
    % con tutte le altre righe e si vanno a contare le coppie di 1
    % X(i,:) è un vettore riga di lunghezza p
    % X è una matrice di dimensione nxp
    % Tramite espansione implicita il vettore X(i,:) viene replicato
    % n volte per renderlo conformabile con X
    SRR(i,:)=sum(X(i,:)==1 & X==1,2)/p;
end
% Inserisco i valori 1 nella diagonale principale.
SRR(logical(eye(n)))=1;

disp('Matrice di similarità di Russel e Rao')
SRRtable=array2table(SRR,"RowNames",rowlab,'VariableNames',rowlab);
disp(SRRtable)


%% pdist con funzione personalizzata
% simfun = funzione personalizzata che calcola l'indice di similarità tra
% il vettore riga x1 e la matrice X
SRR1=pdist(X,@simfun);
sqSRR1=squareform(SRR1);
sqSRR1(logical(eye(n)))=1;
disp(sqSRR1)

function RR = simfun(x1,X)
% x1 è un vettore riga di lunghezza p
% X è una matrice di dimensione nxp
p=size(x1,2);
% RR = vettore colonna di lunghezza n, che contiene la similarità tra
% il vettore x1 e le n righe della matrice X
RR=sum(x1==1 & X==1,2)/p;
end