clear
filename="FTSeMibTitoliSel.xlsx";
opts=detectImportOptions(filename);
disp(opts.VariableTypes)
preview(filename,opts)

% Forzo le variabili 4 e 7 ad avere il formato numerico
opts.VariableTypes([4 7])={'double'};
Y = readtimetable(filename,opts);
head(Y)