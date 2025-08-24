load citiesItaly.mat
% Vengono create le chiavi in formato stringa
nam=string(citiesItaly.Properties.RowNames);
% Creazione del dictionary
d=dictionary(nam,citiesItaly.unemploy);
disp(d("Novara"))


% Recupero del tasso di disoccupazione di Novara direttamente 
% dalla table citiesItaly tramite i RowNames  
taxDisoccNovara = citiesItaly{"Novara", "unemploy"};