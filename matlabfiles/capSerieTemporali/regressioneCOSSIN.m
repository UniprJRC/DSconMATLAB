% Carica i dati di input
y = readtable("totalsales.xlsx");
n = size(y,1);
t = 1:n;
s = 12;
numcomp = floor(s/2); % Utile quando si usano valori dispari di freqseaso (non in questo caso)
% Ciclo per creare le basi ortogonali Coseno e Seno
Xseaso = zeros(n,numcomp*2);
for j=1:numcomp
    varpi=j*2*pi/s;
    Xseaso(:,2*j-1:2*j)=[cos(varpi*t); sin(varpi*t)].'; % Trasposta della matrice
end
% Rimuovo l'ultima colonna di Xseaso  (in quanto uguale a 0)
Xseaso=Xseaso(:,1:end-1);

% Creazione del nome delle variabili
nomivar1=["Cos"; "Sin"]+(1:numcomp);
myname=nomivar1(1:end-1)';

% transformo l'array in tabella
Xseaso2 = array2table([Xseaso y.vendite]);
Xseaso2.Properties.VariableNames=[myname;"vendite"];
% Fit minimi quadrati per trovare gli alpha e i beta
% per tutti i modelli richiesti
fitseaso = fitlm(Xseaso2);
Xseaso2rid = [Xseaso2(:,1:4) Xseaso2(:,end)];
fitseasorid = fitlm(Xseaso2rid);

% Rappresentazione grafica delle serie osservate e dei valori previsti dai modelli
plot(y.data, y.vendite, 'LineWidth', 4, 'Color', "k"); hold on;
plot(y.data, fitseaso.Fitted, 'LineWidth', 3, 'LineStyle', '--', 'Color', "r")
plot(y.data, fitseasorid.Fitted, 'LineWidth', 3, 'Color', "b");
title({'Serie delle vendite: osservate (nero)', 'previste modello completo (rosso tratteggiato)', 'previste modello ridotto (blu)'});
set(gca,'FontSize',15)
