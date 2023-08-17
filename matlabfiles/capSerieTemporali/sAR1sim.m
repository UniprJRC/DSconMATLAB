m = 0.5; phi = 0.8; sigma2 = 1.0;
n = 300;
e = normrnd(0, sigma2, n, 1);
y = m/(1-phi) + filter(1, [1 -phi], e);
subplot(3, 1, 1); 
plot(y); 
title('Serie simulata');

subplot(3, 1, 2); 
autocorr(y); 
title("FAC campionaria");

subplot(3, 1, 3); 
parcorr(y);  
title("FACP campionaria")
