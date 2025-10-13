load citiesItaly2024.mat
X=citiesItaly2024;
disp(X.Properties.UserData)

% Extract the geospatial data from the loaded table
GT = X.Properties.UserData{1};
% GT è una geotable 
% isgeotable(GT) produce true

% Osservazione mapping toolbox deve essere installato
geoplot(GT,'ColorVariable','COD_REG')
geobasemap('darkwater')

%% geoplot con Name,Value 'ColorVariable'
GT1=[GT citiesItaly2024];
% tiledlayout(1,4); nel libro
tiledlayout('flow')
sel=["Bankrup"    "UrbanFra" "SalaryA"  "SpendingA"];
maptype={'colorterrain' 'bluegreen' 'landcover' 'none'};
for j=1:length(sel)
    nexttile
    geoplot(GT1,'ColorVariable',sel(j))
    title(sel(j))
    colorbar
    geobasemap(maptype{j})
end

%% geoplotFS
geoplotFS(citiesItaly2024,2,GT)

%% Modo alternativo di chiamata a geoplotFS
% secondo argomento può essere il nome della variabile
% Call geoplotFS with additional parameters for customization
geoplotFS(citiesItaly2024, "ElecPar", GT);