load('loyalty.txt');
y=loyalty(:,4);
X=loyalty(:,1:3);
scatter(X(:,1),y)
xlabel("Numero di visite al supermercato")
ylabel("Ammontare speso")
figure
histogram2(X(:,1),y,20)
xlabel("Numero di visite al supermercato")
ylabel("Ammontare speso")
zlabel("Frequenze")

% print -depsc LOYhist2D.eps;
% print -depsc LOYscatter.eps;
