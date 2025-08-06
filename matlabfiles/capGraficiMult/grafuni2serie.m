%% Caricamento dati
X = readtable("grafuniv2serie.xlsx",'Sheet','dati','ReadRowNames',true);
Xd=X{:,1:2};
mesi=categorical(X.Properties.RowNames,X.Properties.RowNames);
nr=2; % nr= numero di righe nella finestra grafica
nc=4; % nc = numero di colonne nella finestra grafica
subplot(nr,nc,1)
bar(mesi,Xd)
title('Barre verticali')

subplot(nr,nc,2)
barh(mesi, Xd)
title('Barre orizzontali')

subplot(nr,nc,3)
bar(mesi,Xd,'stacked') % colonne in pila
title('Colonne in pila')

subplot(nr,nc,4)
% colonne in pila al 100%
bar(mesi,100*Xd./sum(Xd,2),'stacked')
title('Colonne in pila al 100%')

subplot(nr,nc,5)
area(mesi,100*Xd./sum(Xd,2),2) % area in pila al 100%
title('Area in pila al 100%')

subplot(nr,nc,6)
bar3(mesi, Xd) % barre 3D
title('Barre 3D')

subplot(nr,nc,7)
stairs(mesi, Xd) % a gradini
title('Gradini')

subplot(nr,nc,8) % barre personalizzate con legenda
bar(mesi, Xd(:,1),0.7, "FaceColor","yellow","FaceAlpha",0.5,...                       
    "EdgeColor","black","LineWidth",1.5); 
hold on
bar(mesi,Xd(:,2),0.25,"FaceColor","red");
legend(["Sci" "Sci"+newline+"d'acqua"],"Location","northwest")
title('Barre personalizzate')

