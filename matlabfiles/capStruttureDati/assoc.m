% Verifica associazione
N= [87 188;     42 406];
n11=N(1,1);
n11star=sum(N(:,1))*sum(N(1,:))/sum(N,"all");
diff=n11-n11star;
diffstring=num2str(diff);
if diff>0
    disp('Associazione positiva')
    disp(['La differenza tra n11 e n11* è =' diffstring])
else
    disp('Associazione negativa')
    disp(['La differenza tra n11 e n11* =' diffstring])
end
