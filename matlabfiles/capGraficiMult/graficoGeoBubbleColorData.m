% Carica i dati della distribuzione dei volantini
volantini=readtable("dist.volantini.parma.2019.csv");
% converte il tipo di edificio in varaibile categorica per l'uso dell'opzione
% 'ColorData' da usare nella funzione geobubble
volantini.building=categorical(volantini.building);
summary(volantini)
totvola = sum(volantini.nvol);
% L'opzione 'ColorData', identifica il tipo di edificio
% con opportuno colore e aggiunge la legenda di tale specificazione
geobubble(volantini.Y, volantini.X, volantini.nvol,'Basemap','streets','ColorData',volantini.building)
title('Mappa della distribuzione volantini');
set(gca,'FontSize',15)

