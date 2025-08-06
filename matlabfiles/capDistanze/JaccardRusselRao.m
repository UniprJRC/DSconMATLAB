%% Matrice di partenza
X=[1 1 1 1 1;    1 1 1 1 0;     0 1 0 1 0;
    1 1 0 1 0;     0 0 0 0 0;     0 0 0 1 0];
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
SRR=zeros(n,n);
for i=1:n
    SRR(i,:)=sum(X(i,:)==1 & X==1,2)/p;
end

% Inserisco i valori 1 nella diagonale principale.
SRR(logical(eye(n)))=1;

disp('Matrice di similarità di Russel e Rao')
SRRtable=array2table(SRR,"RowNames",rowlab,'VariableNames',rowlab);
disp(SRRtable)


%% pdist con funzione personalizzata
SRRini=pdist(X,@simfun);
SRRchk=squareform(SRRini);
SRRchk(logical(eye(n)))=1;

function RR = simfun(x1,X)
    p=size(x1,2);
    % RR = vettore colonna di lunghezza n, che contiene la similarità tra
    % il vettore x1 e le n righe della matrice X
    RR=sum(x1==1 & X==1,2)/p;
end