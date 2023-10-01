%% Esempio di utilizzo di fitdist

%% Dati generati da una T con 2 gradi di libertà
rng default
nu=5; % gradi di libertà
n=100; % dimensione del campione
sigma=3; % parametro di scala
mu=2; % parametro di posizione (location)
X=sigma*trnd(nu,n,1)+mu;

%% Viene adattato un modello t
stime=fitdist(X,"tLocationScale");
disp(stime)

%% Viene adattato un modello Normale
% In questo caso si stimano i parametri mu e sigma
stimeN=fitdist(X,"Normal");
disp(stimeN)

%% Viene adattato un modello Weibull
stimeW=fitdist(X,"Weibull");
disp(stimeW)



