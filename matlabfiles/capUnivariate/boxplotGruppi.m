% Caricamento files

miofile="Firm.xlsx"; % Caricamento file Firm.xlsx dentro MATLAB
X=readtable(miofile,"ReadRowNames",true);


%% Boxplot per sesso e titolo di studio (chiamata a boxplot)
close all
SesTit=string(X.Gender)+string(X.Education);
SesTitc=categorical(SesTit,unique(SesTit));
boxplot(X.Wage,SesTitc);
ylabel('Retribuzione')
% print -depsc boxplotFMABC.eps;


%% Boxplot per sesso e titolo di studio (tramite chiamata a boxchart)
figure
boxchart(categorical(X.Gender),X.Wage,'GroupByColor',X.Education);
ylabel('Retribuzione')
% Aggiunta della legenda al grafico
legend
% print -depsc boxchartFMABC.eps;

%% violinplot per sesso e titolo di studio (tramite chiamata a violinplot)
figure
violinplot(categorical(X.Gender),X.Wage,'GroupByColor',X.Education);
ylabel('Retribuzione')
% Aggiunta della legenda al grafico
legend(categories(categorical(X.Education)))
% Si noti che solo l'istruzione legend senza specificare le categorie non
% funziona

%% Dalla versione 2025a violinplot con table (non presente nel libro)
X.Gender=categorical(X.Gender);
X.Education=categorical(X.Education);
X.SesTitc=SesTitc;

violinplot(X,"SesTitc","Wage")

% con orientamento orizzontale
violinplot(X,"SesTitc","Wage",'Orientation','horizontal')

% Gender e Education affiancati
violinplot(X,["Gender" "Education"],"Wage")

%% Esempio di violinplot con punti interni
nomeVariabile="Wage";
xsel=X{:,nomeVariabile};
% se withpoints è true nel grafico a violino vengono aggiunti i punti
% relativi alle osservazioni
withpoints=true;
subplot(1,2,1)
violinplot(xsel)

if withpoints==true
    hold('on')
    one=ones(size(X,1),1);
    scatter(one,xsel)
end

subplot(1,2,2)
violinplot(categorical(X.Gender),xsel)

if withpoints==true
    hold('on')
    % Osservazione: dato che quando trasformo la variabile in
    % categorica le modalità sono inserite in ordine alfabetico, il
    % primo violinplot si riferisce alla modalità F
    boo=X.Gender=="F";
    % punti relativi alle donne
    scatter(one(boo,1),xsel(boo))
    % punti relativi agli uomini
    scatter(2*one(~boo,1),xsel(~boo))
end
% L'istruzione sgtitle inserisce un title
% sopra la griglia dei subplots
sgtitle(nomeVariabile)
