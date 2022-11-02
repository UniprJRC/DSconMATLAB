% Valore a piacere per r
r=2;
% Sequenza di valori di k richiesti dal testo dell'esercizio
kk=[0.25 0.5 1 2 4 10];
% Le coordinate x vanno da -r ad r
x=(-r:0.001:r)';

for j=1:length(kk)
    subplot(2,3,j)
    k=kk(j);
    % Trova la coordinata y dell'equazione |x|^k+|y|^k=r^k
    y=(r^k-abs(x).^k).^(1/k);
    % plot(x,y)

    plot([x;x],[y;-y])
    % Vengono aggiunti gli assi cartesiani
    xline(0)
    yline(0)
    % Viene fissato il limite min e max per l'asse x
    xlim([-r*1.1 r*1.1])
    % Il valore di k utilizzato viene inserito nel titolo
    title(['k=' num2str(k)])
    % Stessa scala per i due assi
    axis equal
end
% print -depsc figs\minkcontour.eps;

%% NON NEL LIBRO
% Ad ogni pannello si aggiunge la circonferenza di raggio r
% Valore a piacere per r
r=2;
% Sequenza di valori di k richiesti dal testo dell'esercizio
kk=[0.25 0.5 1 2 4 10];
% Le coordinate x vanno da -r ad r
x=(-r:0.001:r)';

for j=1:length(kk)
    subplot(2,3,j)
    k=kk(j);
    % Trova la coordinata y dell'equazione |x|^k+|y|^k=r^k
    y=(r^k-abs(x).^k).^(1/k);
    % plot(x,y)

    plot([x;x],[y;-y])
    % Vengono aggiunti gli assi cartesiani
    xline(0)
    yline(0)
    % Viene fissato il limite min e max per l'asse x
    xlim([-r*1.1 r*1.1])
    % Il valore di k utilizzato viene inserito nel titolo
    title(['k=' num2str(k)])
    % Stessa scala per i due assi
    axis equal
    % viene aggiunta la circonferenza di raggio r
    hold on
    k=2;
    y=(r^k-abs(x).^k).^(1/k);
    plot([x;x],[y;-y])

end




%%  Distanza euclidea in funzione dei vettori elementari

X = [1.2 2.1; 3.4 5.1; 1.9 2.2; 4.1 2.3; 4.2 2.9];
n=size(X,1);
k=2;

D=squareform(pdist(X,'minkowski',k));
nomirighe=string(('A':'E')');
% L'array D viene trasformato in table
Dtable=array2table(D,"RowNames",nomirighe,"VariableNames",nomirighe);
disp(Dtable)

ei=zeros(5,1);
ei(1)=1;
ej=zeros(5,1);
ej(2)=1;

dist12=((ei-ej)'*(X*X')^(k/2)*(ei-ej))^(1/k);
% dist12 è quello all'elemento 1,2 delle table Dtable
disp(dist12)

