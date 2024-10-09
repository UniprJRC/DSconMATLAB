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



