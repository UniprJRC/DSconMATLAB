%% Caricamento dati
miofile="Firm.xlsx";
Xt=readtable(miofile,"ReadRowNames",true);

%% Impostazione tipologia delle varibili

% Definisco la variabili Gender come qualitativa nominale (categorical
% senza ordine tra le modalità)
Xt.Gender = categorical(Xt.Gender);
% Definisco la variabili Education come qualitativa ordinale (categorical
% con ordine tra le modalità A<B<C)
% Per ulteriori informazioni su questa operazione consultare
% https://it.mathworks.com/help/matlab/matlab_prog/convert-table-variables-containing-strings-to-categorical.html
Xt.Education=categorical(Xt.Education,{'A','B','C'},'Ordinal',true');
summary(Xt)

%% Distribuzioni di frequenze

tabulate(Xt.Education)

%% Moda per le variabili qualitative nominali
mode(Xt.Gender)

%% Mediana per le variabili qualitative ordinali
median(Xt.Education)

%% Grafico a torta
histogram('Categories',{'Yes','No','Maybe'},'BinCounts',[22 18 3])
histogram(Xt.Education,'Categories',{'B','C'})

%% GUI che mostra il calcolo del quantile 0.7 in una variabile ordinale
GUIquantile(Xt.Education,0.7)

% print -depsc GUIquantile.eps;