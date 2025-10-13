%% Caricamento dati
load citiesItaly2024.mat
X=citiesItaly2024;
LatLong=X.Properties.UserData{2};
LL=array2table(LatLong,"VariableNames",["Lat" "Long"]);
CIT=[citiesItaly2024 LL];

%% Creazione grafico
subplot(1,2,1)
geoiconchart(CIT, "Lat","Long","election.png",  SizeVariable="ElecPar");
latlim = [39, 47];
lonlim = [7, 13.5];
geolimits(latlim, lonlim);
geobasemap('satellite')
subplot(1,2,2)
gg=geoiconchart(CIT, "Lat","Long","election.png",  SizeVariable="ElecPar");
geolimits([36, 44], [12, 18.5]);
geobasemap('satellite')