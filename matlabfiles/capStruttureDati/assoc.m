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

n11=N(1,1);
% Calcolo della frequenza teorica
Ntheo11=sum(N(:,1))*sum(N(1,:))/sum(N,"all");

diff=N(1,1)-Ntheo11;
diffstring=num2str(diff);
if N(1,1)-Ntheo11>0
    disp('Associazione positiva')
    disp(['La differenza tra n11 e n11* è =' diffstring])
else
    disp('Associazione negativa')
    disp(['La differenza tra n11 e n11* =' diffstring])
end