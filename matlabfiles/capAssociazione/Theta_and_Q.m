%% Relazione tra theta e Q tramite plot
thx=0:0.1:20;
Q=(thx-1)./(thx+1);
plot(thx,Q)
xlabel('$\theta$','Interpreter','latex')
ylabel('$Q= \frac{\theta-1}{\theta+1}$','Interpreter','latex')
title('Relazione tra Q e \theta')

%% Relazione tra theta e Q  tramite fplot
fplot(@(th)(th-1)./(th+1),[0 20])
xlabel('$\theta$','Interpreter','latex')
ylabel('$Q= \frac{\theta-1}{\theta+1}$','Interpreter','latex')
title('Relazione tra Q e \theta')

% print -depsc figs\thetaQ.eps;

%% Relazione tra theta e Q attraverso il calcolo simbolico
syms th
Q=(th-1)./(th+1);
fplot(Q,[0 20])
xlabel('$\theta$','Interpreter','latex')
ylabel('$Q= \frac{\theta-1}{\theta+1}$','Interpreter','latex')
title('Relazione tra Q e \theta')

%% Relazione tra theta e U (parte non presente nel libro)
figure
thx=0:0.1:20;
U=(sqrt(thx)-1)./(sqrt(thx)+1);
plot(thx,U)
xlabel('$\theta$','Interpreter','latex')
ylabel('$U= \frac{\sqrt \theta-1}{\sqrt \theta+1}$','Interpreter','latex')
title('Relazione tra U e \theta')

