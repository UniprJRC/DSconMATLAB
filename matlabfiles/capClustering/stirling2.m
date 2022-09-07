function [Sn,S] = stirling2(n,k)
% n:  numero di elementi da partizionare.
% k:  numero di partizioni.
% S:  triangolo di Stirling. E' una matrice triangolare inferiore il cui
% elemento (i,j) contiene il numero di Stirling S(i,j), ossia il numero di
% j-partizioni di un insieme di i elementi. L'unico modo per trovare
% l'elemento S(i,j), e' costruire tutti gli elementi con gli indici i e j
% precedenti. In questo c'e' analogia con la costruzione del triangolo
% di Tartaglia/Pascal.
%Sn: numero di Stirling di classe k, ossia l'elemento S(n,k).
S=zeros(n); S(:,1)=1;  
for i=2:n
    for j=2:i
        S(i,j)=S(i-1,j-1)+j*S(i-1,j); % relazione di ricorrenza
    end
end
Sn = S(end,k);  
