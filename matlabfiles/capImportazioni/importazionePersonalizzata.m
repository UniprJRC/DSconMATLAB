clear
filename="FTSeMibTitoliSel.xlsx";
opts=detectImportOptions(filename);
disp(opts.VariableTypes)
preview(filename,opts)

% Forzo le variabili 4 e 7 ad avere il formato numerico
opts.VariableTypes([4 7])={'double'};
Y = readtimetable(filename,opts);
head(Y)
%% Cambiamento periodicità: retime e convert2annual 

funzioneRichiesta="max";
Y1=retime(Y,"yearly",funzioneRichiesta);
newDates=dateshift(Y1.Properties.RowTimes,'end','year');
Y1.Properties.RowTimes=newDates;
Y2=convert2annual(Y,'Aggregation',funzioneRichiesta);
assert(isequaln(Y1,Y2),"Conversione diversa")