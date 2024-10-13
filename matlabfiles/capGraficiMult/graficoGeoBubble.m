% creazione grafico geobubble
COO=readtable("CoordGeogProvince.xlsx",'ReadRowNames',true);
load citiesItaly.mat
CIT=citiesItaly;

nam=CIT.Properties.RowNames;
[~,ind]=sort(nam);
CITord=CIT(ind,:);

% Modo alternativo non riportato nel libro
% Chiamata a sortrows con secondo argomento "RowNames"
CITORDchk=sortrows(CIT,"RowNames");
assert(isequal(CITord,CITORDchk),"Diverso ordinamento")


% Aggiungo alla table COO la variabile addedval standardizzata
% Chiamo la nuova variabile valagg
COO.valagg=zscore(CITord.addedval);

geobubble(COO,"LAT","LONG",'Basemap','streets','SizeVariable','valagg')
