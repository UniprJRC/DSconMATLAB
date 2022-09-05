% Questo script mostra una classificazione "sfortunata" ad ARI negativo, e
% l'ARI  medio calcolato su 10000 classificazioni casuali, che risulta
% prossimo a zero.
rng(12345);
class_vera        = [1, 2, 3, 1, 4, 5, 6, 2];
class_sfortunata  = [2, 2, 1, 1, 3, 3, 3, 3];
repliche = 10000; 
class_casuali     = randi(6 , repliche, 8);
AR1 = 0;
for i = 1:repliche
    AR1=AR1+RandIndexFS(class_casuali(i,:),class_vera);
end
AR1 = AR1/repliche;
AR2 = RandIndexFS(class_sfortunata,class_vera);
disp(['ARI medio = ' num2str(AR1) ' --- ARI sfortunato = ' num2str(AR2)]);

