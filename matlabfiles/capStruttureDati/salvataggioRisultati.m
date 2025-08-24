%% 1.6.1 Salvataggio dei risultati ottenuti
cm = {1,2,3; "Buongiorno a tutti", rand(3,2),[11; 22; 33]};
save('myCell.mat', 'cm');

data = [110.63, 3.7; 736871, 12157];

Summary = array2table(data,"VariableNames",["Acquisti in euro", "Numero visite"], "RowNames", ["Media mensile", "Totale mensile"]);

% Salvataggio della matrice "data" in ".txt" e in ".xlsx":
writematrix(data,'data.txt','Delimiter','tab');
writematrix(data,'data.xlsx');

% Salvataggio della tabella "Summary" in ".txt" e in ".xlsx":
writetable(Summary,'Summary.txt','Delimiter','tab','WriteRowNames',true);
writetable(Summary,'Summary.xlsx','WriteRowNames',true);
