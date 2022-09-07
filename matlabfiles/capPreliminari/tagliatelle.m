%% Caricamento dati
X=readtable('tagliatelle.xlsx','Sheet','Dati','Range','A1:C41');
% Mostro le prime 5 righe dellta table X
disp(head(X,5))

%%  Analisi dei missing values 
% Ismis è un array di valori Booleani che ha la stessa dimensione di X
Ismis=ismissing(X);
disp('Matrice booleana Ismis (prime 5 righe)')
disp(Ismis(1:5,:))

% nummissC= numero di missing per ogni variabile
nummissC=sum(Ismis,1);
disp('Numero di missing per ogni variabile')
disp(nummissC)

% nummissR= numero di missing per ogni riga
nummissR=sum(Ismis,2);
disp('Numero di missing per le prime 5 righe')
disp(nummissR(1:5,:))

% Vengono cancellate le righe che presentano missing values
% X1 contiene solo 23 righe
X1=X;
X1(nummissR>0,:)=[];

% Vengono cancellate le colonne con più di 3 missing values
% X2 contiene solo la prima colonna (tagliat)
X2=X;
X2(:,nummissC>3)=[];

% Per contare il numero di righe con valori mancanti
disp("Numero di righe con valori mancanti")
disp(sum(sum(Ismis,2)>0))


%% Osservazione: per rimuovere dalla matrice X le colonne che hanno almeno 10 missing
% values.
[Rred,TF] = rmmissing(X,2,'MinNumMissing',10);
% Il secondo argomento di output 




%% Inizializzazione
% n e p dimensioni di X
[n,p]=size(X);
% nummiss1 = numero di valori mancanti per ogni colonna
nummiss1=zeros(p,1);
% mea= medie omettendo i missing values
meas=nummiss1;
% sigmas = deviazioni standard omettendo i missing values
sigmas=meas;
% Outsup  = outliers superiori
Outsup=meas;
% Outinf =outliers inferiori
Outinf=meas;
% ciclo for sulle colonne della table X per estrarre le informazioni richieste
for j=1:p
    Xj=X{:,j};
    nummiss1(j)=sum(ismissing(Xj));
    meas(j)=mean(Xj,'omitnan');
    sigmas(j)=std(Xj,'omitnan');
    perc=prctile(Xj,[25 75]);
    PTsup=perc(2)+1.5*(perc(2)-perc(1));
    PTinf=perc(1)-1.5*(perc(2)-perc(1));
    Xjsenzamissing=Xj(~ismissing(Xj));
    Outsup(j)=sum(Xjsenzamissing>PTsup);
    Outinf(j)=sum(Xjsenzamissing<PTinf);
end

% Percentuale di valori mancanti per ogni colonna
percmiss=100*nummiss1/n;

Ma=[nummiss1 meas sigmas nummiss1 percmiss Outinf Outsup ];

% Trasformo la matrice Ma in una table
Matable=array2table(Ma,'RowNames',X.Properties.RowNames,...
    'VariableNames',{'Nmis' 'Media' 'Devstd' 'Manc_cont' ...
    'Manc_perc' 'estMin' 'estMax'});
disp(Matable)


%% mdpattern con tagliatelle.xlsx
close all
X=readtable('tagliatelle.xlsx','Sheet','Dati','Range','A1:C41');
[Mispat,tMisAndOut]=mdpattern(X)
% print -depsc figs\mdpattern.eps;


%% mdpattern con il dataset Finance
close all
fn='mdpattern.xlsx'; rg='A1:K10001';
X=readtable(fn,'Sheet','Finance','ReadRowNames',true,'Range',rg);
[MispatF,tMisAndOutF]=mdpattern(X);
% print -depsc figs\mdpattern1.eps;


%% Calcolo degli istogrammi e dei boxplot (parte non inserita nel libro)
% tramite il comando subplot(2,3,5) ad esempio creiamo una finestra grafica
% che può accogliere 6 grafici (due per ogni riga e tre per ogni colonna)
% La sintassi subplot(2,3,5) significa "vai ad inserire il grafico nel
% pannello 5 (ossia nel pannello in basso in mezzo)"
close all
for j=1:3
    Xj=X{:,j};
    subplot(2,p,j)
    Xjsenzamissing=Xj(~ismissing(Xj));
    boxplot(Xjsenzamissing)
    title(X.Properties.VariableNames(j))
    subplot(2,p,j+3)
    histogram(Xjsenzamissing,8)
    title(X.Properties.VariableNames(j))
end
