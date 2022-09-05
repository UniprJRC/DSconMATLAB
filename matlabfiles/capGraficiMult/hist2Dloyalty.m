load('loyalty.txt');
y=loyalty(:,4);
X=loyalty(:,1:3);
histogram2(X(:,1),y,20)
xlabel("Numero di visite al supermercato")
ylabel("Ammmontare speso")
zlabel("Frequenze")
% print -depsc LOYhist2D.eps;

figure;
scatter(X(:,1),y)
xlabel("Numero di visite al supermercato")
ylabel("Ammmontare speso")
% print -depsc LOYscatter.eps;
cascade
