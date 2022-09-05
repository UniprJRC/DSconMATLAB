%% Calcolo delle norme
x=[-3 2 -10 5 20];
% pp vettore che contiene le norme da calcolare
pp=[-Inf; 1; 2; Inf];
% norme= vettore che conterrà i risultati del calcolo
norme=zeros(length(pp),1);

for i=1:length(pp)
    norme(i)=norm(x,pp(i));
end
% lab=etichette da inserire come nomi di riga nella table
lab="Norma p="+ string(pp);
normeT=array2table(norme,"RowNames",lab,"VariableNames","Norme");
disp(normeT)
