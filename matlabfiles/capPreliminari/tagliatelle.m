%% Caricamento dati
X=readtable('tagliatelle.xlsx','Sheet','Dati','Range','A1:C41');
disp('Prime 5 righe della table in input X')
disp(head(X,5))

%%  Analisi dei missing values 
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
disp(nummissR(1:5)')

% Vengono cancellate le righe che presentano missing values
% X1 contiene solo 23 righe
X1=X; X1(nummissR>0,:)=[];

% Vengono cancellate le colonne con più di 3 missing values
% X2 contiene solo la prima colonna (umidit)
X2=X; X2(:,nummissC>3)=[];

% Per contare il numero di righe con valori mancanti
disp("Numero di righe con valori mancanti")
disp(sum(sum(Ismis,2)>0))


%% Osservazione: per rimuovere dalla matrice X le colonne che hanno almeno 10 missing values.
[Rred,TF] = rmmissing(X,2,'MinNumMissing',10);

%% Inizializzazione
[n,p]=size(X);
% nummiss1 = numero di valori mancanti per ogni colonna
nummiss1=zeros(p,1);

meas=nummiss1; % meas= medie omettendo i missing values
sigmas=meas; % sigmas = deviazioni standard omettendo i missing values
Outsup=meas; % Outsup  = outliers superiori
Outinf=meas; % Outinf = outliers inferiori
% ciclo for sulle colonne della table X per estrarre le informazioni richieste
for j=1:p
    Xj=X{:,j};
    nummiss1(j)=sum(ismissing(Xj));
    meas(j)=mean(Xj,'omitnan');   sigmas(j)=std(Xj,'omitnan');
    perc=prctile(Xj,[25 75]);
    PTsup=perc(2)+1.5*(perc(2)-perc(1)); PTinf=perc(1)-1.5*(perc(2)-perc(1));
    Xjsenzamissing=Xj(~ismissing(Xj));
    Outsup(j)=sum(Xjsenzamissing>PTsup); Outinf(j)=sum(Xjsenzamissing<PTinf);
end

% Percentuale di valori mancanti per ogni colonna
percmiss=100*nummiss1/n;

Ma=[nummiss1 meas sigmas nummiss1 percmiss Outinf Outsup ];
% Trasformo la matrice Ma in una table
Matable=array2table(Ma,'RowNames',X.Properties.RowNames,'VariableNames',...
    {'Nmis' 'Media' 'Devstd' 'Manc_cont' 'Manc_perc' 'estMin' 'estMax'});
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


%% Calcolo dei boxplot e degli istogrammi (parte non inserita nel libro)
% tramite il comando subplot(2,3,5) ad esempio creiamo una finestra grafica
% che può accogliere 6 grafici (due per ogni riga e tre per ogni colonna)
% La sintassi subplot(2,3,5) significa "vai ad inserire il grafico nel
% pannello 5 (ossia nel pannello in basso in mezzo)"
close all
p=size(X,2);
% k=numero di variabili da visualizzare
% k deve essere un numero intero positivo compreso tra 1 e p
k=5;
for j=1:k
    Xj=X{:,j};
    subplot(2,k,j)
    Xjsenzamissing=Xj(~ismissing(Xj));
    boxplot(Xjsenzamissing)
    title(X.Properties.VariableNames(j))
    subplot(2,k,j+k)
    histogram(Xjsenzamissing,8)
    title(X.Properties.VariableNames(j))
end


%% Calcolo dei boxplot e degli istogrammi con curva normale (parte non inserita nel libro)
close all
p=size(X,2);
% k=numero di variabili da visualizzare
% k deve essere un numero intero positivo compreso tra 1 e p
k=3;
for j=1:k
    Xj=X{:,j};
    subplot(2,k,j)
    Xjsenzamissing=Xj(~ismissing(Xj));
    boxplot(Xjsenzamissing)
    title(X.Properties.VariableNames(j))
    subplot(2,k,j+k)
    histfit(Xjsenzamissing,10)
    title(X.Properties.VariableNames(j))
end
