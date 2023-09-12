%% Importazione da banca data fred
c=fred('https://fred.stlouisfed.org/');
d=fetch(c,'ITACPIALLMINMEI');
ipcm      =  d.Data(:,2);
% Le date in formato numerico vengono convertite in formato data
date    = datetime(d.Data(:,1),'ConvertFrom','datenum');
% viene create la timetable TT
TT      = timetable(date,ipcm);
head(TT,5)

%% Tasso di cambio euro dollaro
c = fred('https://fred.stlouisfed.org/');
c.DataReturnFormat='timetable';
d  = fetch(c,'DEXUSEU');
TT=d.Data{1};
head(TT,3)
 

%% selezione di un intervallo di dati (parte non inserita nel testo)
TR      = timerange("2016-01-01","2022-12-31")      
TR      = timerange("01-01-2016","31-13-2022")      
clc
TR=timerange("01/01/2016","31/12/2022");
TR=timerange("01/01/2016","31/12/2022",'days');

ini=datetime("01/02/2016",'InputFormat',"dd/MM/yyyy");
ini=datetime("01/02/2016",'InputFormat',"MM/dd/yyyy");

TTs     = TT(TR,:),
% aggregazione in serie annuale
TTA     = retime(TTs, "yearly", "mean");
