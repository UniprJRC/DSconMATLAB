%% Guardo in anteprima l'output del caricamento dati
miofile="quarterlyFinances1999To2019.csv";
opts = detectImportOptions(miofile);
preview(miofile,opts)

%% Mostro il formato di caricamento delle variabili
disp(opts.VariableTypes)

%% detectImportOptions con l'opzione 'TrimNonNumeric'
opts = detectImportOptions(miofile,'TrimNonNumeric',true);
preview(miofile,opts)
disp(opts.VariableTypes)

%% Caricamento effettivo
X=readtable(miofile,opts);
head(X,2)