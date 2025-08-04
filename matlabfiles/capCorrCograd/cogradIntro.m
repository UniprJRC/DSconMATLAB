%% Caricamento dati
Xtable=readtable('cograd.xlsx','Range','B1:D9','ReadRowNames',true);

% Datirank = matrice che conterrà i ranghi
Datirank=zeros(size(Xtable));
for j=1:2
    Datirank(:,j)=tiedrank(Xtable{:,j});
end
disp('Matrice dei gradi o posti d''ordine')
disp(Datirank)

%% Calcolo indice rho di Spearman
rhochk=corr(Datirank(:,1), Datirank(:,2));
disp(['Indice rho di Spearman calcolato su Datirank: ' num2str(rhochk)])

rho=corr(Xtable{:,"MOVIMENTI"},Xtable{:,"PASSEGGERI"},'Type','Spearman');
disp(['Indice rho di Spearman chiamando corr con Type: ' num2str(rho)])

