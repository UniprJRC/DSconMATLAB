% Tabella di contingenza di partenza 
%
% X= ricordo della pubblicità
% Y= acquisto del prodotto 
% 
% X\Y sì no
% 
% sì 87 188 
% no 42 406
% 


% N = tabella di contingenza di partenza
N= [87 188;
    42 406];

% Osservazione: l'istruzione non è necessaria in quanto n11 non viene
% richiamata di seguito. Notate che MATLAB nella parte destra dell'editor
% inserisce un segno rosso. Quando si passa con il mouse sul segno rosso appare
% la frase "Value assigned to variable might be unused".  
n11=N(1,1); 

% Calcolo della frequenza teorica
Ntheo11=sum(N(:,1))*sum(N(1,:))/sum(N,"all");

diff=N(1,1)-Ntheo11;
diffstring=num2str(diff);
if N(1,1)-Ntheo11>0
    disp('Associazione positiva')
    disp(['La differenza tra n11 n e n11* è =' diffstring])
else
    disp('Associazione negativa')
    disp(['La differenza tra n11 n e n11* =' diffstring])
end


%% IMPLEMENTAZIONE ALTERNATIVA (non nel libro)

% clear cancella tutto quello che è presente in memoria
clear

% N= matrice di dimensione 2x2 che contiene le 4 frequenze associate alla
% tabella X=Ricordo della pubblicità \ Y=acquisto del prodotto)
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
