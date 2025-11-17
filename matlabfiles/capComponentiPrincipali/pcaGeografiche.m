%% Es con lat e long
load citiesItaly2024.mat0
% Retrieve Latitude and Longitude of each province
LatLong=citiesItaly2024.Properties.UserData{2};
out=pcaFS(citiesItaly2024,'Latitude',LatLong(:,1),'Longitude',LatLong(:,2));

% Es con shape
load citiesItaly2024.mat
% Retrieve Shape file
ShapeFile=citiesItaly2024.Properties.UserData{1};
out=pcaFS(citiesItaly2024,'ShapeFile',ShapeFile);