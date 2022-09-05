close all
%% Caricamento dati
X = readtable("Waterfall.xlsx",'Sheet','Bilancio', ...
    'ReadRowNames',true,'Range','A1:B14');
% L'opzione SetAsTotal specifica quali sono le righe
% da utilizzare come step intermedi 
waterfallchart(X,'SetAsTotal',[1 3 7 11 13]);
% Per personalizzare il formato dei numeri sull'asse y
ax=gca;
ax.YRuler.Exponent=0; % toglie il formato in virgola mobile
title('Dal ricavo lordo al reddito netto')

% print -depsc waterfall.eps;