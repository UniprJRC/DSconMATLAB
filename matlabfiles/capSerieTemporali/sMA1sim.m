mu = 0.5; theta = -0.8; sigma2 = 1.0;
n  = 300;
e  = normrnd(0, sigma2, n, 1);
y  = mu + filter([1 theta], 1, e);
subplot(3, 1, 1); plot(y); title('Serie simulata');
subplot(3, 1, 2); autocorr(y); title("FAC campionaria");
subplot(3, 1, 3); parcorr(y);  title("FACP campionaria")
