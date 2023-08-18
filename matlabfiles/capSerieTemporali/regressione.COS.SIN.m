% Carica i dati di input
y = readtable("totalsales.xlsx");
s1 = size(y);
T = s1(1);
sss = 1:T;
freqseaso = 12;
numcomp = floor(freqseaso/2); % Utile quando si usano valori dispari di freqseaso (non in questo caso) 
% Ciclo per creare le basi ortogonali Coseno e Seno
Xseaso = zeros(T,numcomp*2);
    for j=1:numcomp
        Xseaso(:,2*j-1:2*j)=[cos(j*2*pi*sss/freqseaso); sin(j*2*pi*sss/freqseaso)].'; % Trasposta della matrice
    end
% Rimuovo l'ultima colonna di Xseaso 
Xseaso=Xseaso(:,1:end-1); 
        
% Creazione del nome delle variabili
nomivar1=[(1:numcomp)+"Cos", (1:(numcomp-1))+"Sin"];
myname = sort(nomivar1) % alterna i nomi Coseno e Seno
myname2=[myname "vendite"]
 
% transformo l'array in tabella
Xseaso2 = array2table([Xseaso y.vendite])
Xseaso2.Properties.VariableNames=myname2
% Fit minimi quadrati per trovare gli alpha e i beta
% per tutti i modelli richiesti
fitseaso = fitlm(Xseaso2);
Xseaso2rid = [Xseaso2(:,1:4) Xseaso2(:,end)]
fitseasorid = fitlm(Xseaso2rid);

% Rappresentazione grafica delle serie osservate e dei valori previsti dai modelli
plot(y.data, y.vendite, 'LineWidth', 4, 'Color', "k"); hold on;
plot(y.data, fitseaso.Fitted, 'LineWidth', 3, 'LineStyle', '--', 'Color', "r")
plot(y.data, fitseasorid.Fitted, 'LineWidth', 3, 'Color', "b");
title({'Serie delle vendite: osservate (nero)', 'previste modello completo (rosso tratteggiato)', 'previste modello ridotto (blu)'});
set(gca,'FontSize',15)
