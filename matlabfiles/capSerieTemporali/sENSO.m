url = ('https://www.cpc.ncep.noaa.gov/data/indices/sstoi.indices');
websave('sstoi.txt',url)
data  = readtable('sstoi.txt', VariableNamingRule='preserve');  
t1    = datetime(data.YR(1),data.MON(1),31);  % data iniziale 
n     = size(data,1);                         % n.ro delle osservazioni
t     = t1 +  calmonths(0:n-1);               % vettore di date 
y     = data.ANOM_3;    % selezione della serie delle anomalie regione 3.4
plot(t, y, 'LineWidth',2);
yline(0,'Color','r','LineStyle','--')
xlim([t(1)-calmonths(6), t(end)+calmonths(6)]);
% exportgraphics(g,'enso.eps');
% exportgraphics(g,'enso.pdf')

%% sample ACF
 % alternatively use this code
K = 5;
Ylags = [y, NaN(n,K)];
for k = 1:K
    Ylags(k+1:end,k+1) = y(1:n-k);
end
% Modo alternativo per ottenere la matrice sfasata
YlagsCHK=lagmatrix(y,0:5);

%% Autocorrelazioni 
% con denominatore della covarianza n-k
C = corr(Ylags, rows="pairwise");
% con denominatore della covarianza n
rho = autocorr(y,K);
autoC=[C(:,1) rho];
nam=["Autocorr con denom (n-k) nella cov" "Autocorrelazioni"];
disp(array2table(autoC,"VariableNames",nam))


%% Autorrelazioni tramite GUIautocorr
GUIautocorr(y,'lag',2)

%% 
bar(0:K, C(1,:))

r = fSampleACF( y, K );
K = 45;
bar(0:K, r)
g = figure;
bar(0:K, r);
%%
g = figure;
autocorr(y, 45); %title({'Autocorrelazione'}, Interpreter="latex");
title('')
set(gca,'TickLabelInterpreter','latex');
xlabel(' ', Interpreter='latex')
ylabel(' ')
% exportgraphics(g,'gacf.pdf')



%% Periodogramma via regressione lineare 
warning('off')
Perio0 = NaN(floor(n/2),1);
t   = (1:n)';
for j = 1:floor(n/2)
    omega_j = 2*pi*j/n;
    mdl = fitlm([cos(omega_j*t) sin(omega_j*t)], y); 
    ESS = mdl.SSR;
    Perio0(j) = mdl.SSR/(4*pi);
end
omega = 2 * pi * (1:floor(n/2))' / n; % Frequenze di Fourier
bar(omega, Perio0); xlim([0 pi]); xlabel('\omega'); ylabel('I(\omega)');
set(gca,'TickLabelInterpreter','latex');

%% Periodogram via Fast Fourier Transform
vj = (0:floor(n/2))'; omega = 2 * pi * vj / n; % Frequenze di Fourier
Perio = abs(fft(y)).^2/(n*2*pi) ;
Perio = Perio(1:length(omega));
Perio(2)  % valore identico a Perio_j calcolato in precedenza
plot(omega, Perio); xlim([0 pi]); xlabel('\omega'); ylabel('I(\omega)');
set(gca,'TickLabelInterpreter','latex'); 
%
g = figure;
bar(omega, Perio); xlim([0 pi]); 
xlabel('$\omega$', Interpreter='latex'); ylabel('$I(\omega)$', Interpreter='latex'); 
set(gca,'TickLabelInterpreter','latex');
% exportgraphics(g,'gPerio.pdf')

%% esercizio
plot(2*pi./ omega, Perio)
[omega Perio]


%% Ljung-Box 
[Decision, pValue, LBstat, CriticaValue] = lbqtest(y, 'Lags', 10) 
