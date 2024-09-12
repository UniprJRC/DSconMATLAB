% N= matrice di dimensione 2x2 che contiene le 4 frequenze associate alla
% tabella (X=Ricordo della pubblicità \ Y=acquisto del prodotto)
N= [87 188;
    42 406];
% n11 = frequenza effettiva di unità statistiche associate alla coppia 
% di modalità si/si
n11=N(1,1);

% Calcolo della frequenza teorica in corrispondenza della coppia 
% di modalità si/si  n.1 x n1./n
n11star=sum(N(:,1))*sum(N(1,:))/sum(N,"all");

% diff = differenza tra la frequenza effettiva e quella teorica 
% (formato double)
diff=n11-n11star;
% diffstring = differenza tra la frequenza effettiva e quella teorica
% (formato character vettore 1x7)
diffstring=num2str(diff);

if diff>0
    disp('Associazione positiva')
    disp(['La differenza tra n11 e n11* è =' diffstring])
else
    disp('Associazione negativa')
    disp(['La differenza tra n11 e n11* =' diffstring])
end
