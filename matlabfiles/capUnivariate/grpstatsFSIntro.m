%% Caricamento dati

load citiesItaly
stats=["mean" "median" "skewness" "kurtosis"];

%% Output di grpstats
TBL=grpstats(citiesItaly,[],stats);
disp(TBL)

%% Output di grpstatsFS
TBL=grpstatsFS(citiesItaly,[],stats);
disp(TBL)


%% grpstatsFS con tutte le opzioni di default
TBL=grpstatsFS(citiesItaly);
disp(TBL)

%% grpstatsFS con variable di raggruppamento
zone=[repelem("N",46) repelem("CS",57)]';
citiesItaly.zone=zone;
TBL=grpstatsFS(citiesItaly,"zone",["mean" "median"]);
disp(TBL)

%% grpstatsFS con grafici
% plots,1 intervalli di confidenza delle medie
TBL=grpstatsFS(citiesItaly,"zone",["mean" "median" "meanci"],'plots',1);
disp(TBL)

%% grpstatsFS con grafici personalizzati
plots=struct;
plots.selStats="median";
TBL=grpstatsFS(citiesItaly,"zone",["mean" "median" "meanci"],'plots',plots);
disp(TBL)

