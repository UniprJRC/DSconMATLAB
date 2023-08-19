% Carica i dati della distribuzione dei volantini
volantini=readtable("dist.volantini.parma.2019.csv");
summary(volantini)
% Ci sono 4 categorie di edificio 
% Nelle coordinate in cui si ditribuisce si collocano almeno 30 volantini
% e al massimo 48

totvola = sum(volantini.nvol);
%Il totale dei volantini distribuiti ammonta a quasi 44000

% converte il tipo di edificio in modo categorico per l'uso dell'opzione
% 'ColorData' da usare nella funzione geobubble
volantini.building=categorical(volantini.building);
% crea il grafico con il titolo che può essere ingrandito o rimpicciolito
% con il mouse. L'opzione 'ColorData', identifica il tipo di edificio 
% con opportuno colore e aggiunge la legenda di tale specificazione
geobubble(volantini.Y, volantini.X, volantini.nvol,'Basemap','streets','ColorData',volantini.building)
title('Mappa della distribuzione volantini');
set(gca,'FontSize',15)

