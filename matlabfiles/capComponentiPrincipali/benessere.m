%%  CARICAMENTO DATI
Xtable=readtable('benessere.xlsx','ReadRowNames',true);
% X = matrice di double senza nomi delle righe e nomi delle colonne
X=table2array(Xtable);
% nameXvars = cell che contiene i nomi delle variabili
nameXvars=Xtable.Properties.VariableNames;
[n,p]=size(X);

%% Calcolare la matrice di correlazione,
% Standardizzo i dati
Z=zscore(X);
% calcolo matrice di correlazione
R=cov(Z);
% mostro la matrice di correlazione in formato table
Rtable=array2table(R,'RowNames',nameXvars,'VariableNames',nameXvars);
format bank
disp(Rtable)
format short
% R poteva essere ottenuta direttamente da X utilizzando la funzione corr

%% Autovettori e autovalori della matrice di correlazione
[V,La]=eig(R);
% Riordino in modo tale che
% La(1,1) sia il grande autovalore e V(:,1) sia l'autovettore associato
% La(2,2) sia il secondo più grande autovalore e V(:,2) sia l'autovettore associato
la=diag(La);
[aa,indsor]=sort(la,'descend');
V=V(:,indsor);
lasor=la(indsor);
La=diag(lasor);
%% CALCOLO COMPONENTI PRINCIPALI
% Calcolare la matrice che contiene le
% componenti principali (Y=Z V)
Y=Z*V;

Autoval=[lasor 100*(lasor)/p 100*cumsum(lasor)/p];

namecolsAutoval={'Autovalori' 'Var_spiegata' 'Var_cum_spiegata'};
namePCs="PC"+((1:p)');
Autovaltable=array2table(Autoval,'RowNames', namePCs,'VariableNames',namecolsAutoval);
disp(Autovaltable)

%% VISUALIZZAZIONE VARIANZA SPIEGATA TRAMITE DIAGRAMMA DI PARETO
figure
pareto(Autoval(:,1),namePCs)
xlabel('Componenti principali')
ylabel('Varianza spiegata (%)')

%% INTERPRETAZIONE DELLE COMPONENTI
MatrComp=V*sqrt(La);

% MatrComp ha dimensione p x p. Nel nostro esempio 7*7;
% Ora la ridefinisco prendendo solo le correlazioni tra le variabili
% originarie e le prime due componenti principali
MatrComp=MatrComp(:,1:2);

MatrCompt=array2table(MatrComp,"RowNames",nameXvars,"VariableNames",namePCs(1:2));
disp('Correlazioni tra le variabili originarie e le CP')
disp(MatrCompt)

%% SOMMA QUADRATI COLONNE DELLA MATRICE DI COMPONENTI
j=1;
disp(['La somma dei quadrati della colonna ' num2str(j) ])
disp(['della matrice di componenti ' num2str(sum(MatrComp(:,j).^2))])
disp(['è uguale all'' autovalore ' num2str(j) ' = ' num2str(lasor(j))])


%% Visualizzazione grafica matrici di componenti
% Le label sull'asse x del grafico a barre sono i nomi delle variabili, il
% secondo argomento di categorical specifica che vogliano usare l'ordine
% delle labels specificato dentro varlabs e non l'ordine alfabetico
xlabels=categorical(nameXvars,nameXvars);

figure
for j=1:2
    subplot(2,1,j)
    b=bar(xlabels, MatrComp(:,j),'g');
    title(['Correlazioni con PC' num2str(j)])
    % xtips e ytips sono le coordinate numeriche dove inserire le etichette
    % del valore numerico sopra ogni barra
    xtips = b.XEndPoints;
    ytips = b.YEndPoints;
    barlabels = string(round(MatrComp(:,j),2));
    text(xtips,ytips,barlabels,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
end
% print -depsc figs\benessere2.eps;



%% COMUNALITA'
disp('Quote di varianza di ogni variabile spiegate dalle prime due PC')
Comu=sum(MatrComp.^2,2);
Comutable=array2table(Comu,'RowNames',nameXvars,'VariableNames',{'Comunalità'});
disp(Comutable)

%% Rappresentazione grafica delle correlazioni tra le variabili
% originarie e le prime due componenti principali tramite vettori 
close all
zeroes = zeros(p,1);
% Frecce che partono dall'origine e arrivano fino a MatrComp
quiver(zeroes,zeroes,MatrComp(:,1),MatrComp(:,2))
% Label delle frecce
text(MatrComp(:,1),MatrComp(:,2),nameXvars,...
    'VerticalAlignment','bottom','HorizontalAlignment','center');
% Vengono aggiunti gli assi cartesiani
xline(0)
yline(0)
% Aggiunta delle label sugli assi
xlabel('Prima PC: Indice di povertà');
ylabel('Seconda PC: Indice di malessere delle aziende');
% Stessa unità di misura per i due assi
axis equal




%% Rappresentazione nel piano cartesiano degli scores (non standardizzati)
figure
plot(Y(:,1),Y(:,2),'o')
xlabel('Prima PC: Indice di povertà');
ylabel('Seconda PC: Indice di malessere delle aziende');
text(Y(:,1),Y(:,2),Xtable.Properties.RowNames)
% Vengono aggiunti gli assi cartesiani
xline(0); yline(0)
% print -depsc figs\benessere4.eps;

%% Calcolo delle componenti principali standardizzate
% Yst= componenti principali standardizzate cov(Yst) = matrice identità
Yst=Y*sqrt(inv(La));
% Rappresentazione nel piano cartesiano degli scores (standardizzati)
plot(Yst(:,1),Yst(:,2),'o')
xlabel('Prima PC: Indice di povertà');
ylabel('Seconda PC: Indice di malessere delle aziende');
text(Yst(:,1),Yst(:,2),Xtable.Properties.RowNames)
% Vengono aggiunti gli assi cartesiani
xline(0); yline(0)
% print -depsc figs\benessere5.eps;

%% Biplot (questa section non è riportata nel testo)
% Rappresentazione simultanea dei punti riga tramite gli score
% standardizzati e punti colonna tramite le correlazioni tra le variabili
% originarie e le componenti principali
close all
hold('on')
% Rappresentazione nel piano cartesiano dei punti riga tramite gli scores
% standardizzati
plot(Yst(:,1),Yst(:,2),'o')
xlabel('Prima componente principale stand. (Indice di povertà)');
ylabel('Seconda componente principale stand. (Indice di malessere delle aziende)');
text(Yst(:,1),Yst(:,2),Xtable.Properties.RowNames)
xline(0)
yline(0)

% Aggiunta delle frecce che rappresentano le correlazioni tra le variabili
% originarie e le componenti principali
zeroes = zeros(p,1);
quiver(zeroes,zeroes,MatrComp(:,1),MatrComp(:,2))

% vengono aggiunte le etichette con i nomi delle variabili
dx=0.01;
dy=0.01;
text(MatrComp(:,1)+dx,MatrComp(:,2)+dy,nameXvars,'Color','Blue');

% axis tight= Fit the axes box tightly around the data by setting the
% axis limits equal to the range of the data.
axis tight

