load citiesItaly.mat

%% Costruzione manuale del grafico ad istogrammi in coordinate polari
nomevar="addedval";
numeroclassi=10;
zone=[repelem("N",46) repelem("CS",57)]';
[X01,C,S]=normalize(citiesItaly,"range");
X02pi=2*pi.*X01.*0.99999+1e-10;
edgesPolar=linspace(0,2*pi,numeroclassi+1);
trasp=0.2; 
citN=X02pi{zone=="N",nomevar};
h1=polarhistogram(citN,edgesPolar,'FaceAlpha',trasp);
hold on
citCS=X02pi{zone=="CS",nomevar};
h2=polarhistogram(citCS,edgesPolar,"FaceAlpha",trasp);
set(gca,"ThetaTick",rad2deg(edgesPolar))
edgesOriginal=edgesPolar/(2*pi)*S{:,nomevar}+C{:,nomevar};
set(gca,'ThetaTickLabel',string(edgesOriginal(1:end-1)));
lege=["North" "Centre and South"];
legend(lege)

%% Chiamata alla funzione histFS
figure
Freq=histFS(citiesItaly.addedval,edgesOriginal,zone,sort(lege));

%% Creazione grafico delle variabile 1.6 con variabile di raggruppamento
figure
zone=[repelem("N",46) repelem("CS",57)]';
polarhistogramFS(citiesItaly,'groupvars',zone,'DataVars',1:6);

%% Example of  DisplayStyle 'stairs' with linewidth
figure
z3=[repelem("N",46) repelem("C",21) repelem("S",36)]';
dv=["addedval" "depos" "pensions" "unemploy"];
polarhistogramFS(citiesItaly,'DataVars',dv,'groupvars',z3,'nbins',10, ...
    'DisplayStyle','stairs','LineWidth',2);

