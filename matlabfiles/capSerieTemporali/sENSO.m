% El Niño-Oscillazione Meridionale 
% (conosciuto anche con la sigla ENSO - El Niño-Southern Oscillation) 


%% Serie storica della temperatura del mare (regione del pacifico)
url = ('https://www.cpc.ncep.noaa.gov/data/indices/sstoi.indices');
websave('sstoi.txt',url);
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

%% Matrice degli sfasamenti
K = 5;
Ylags = NaN(n,K+1);
for k = 0:K
    Ylags(k+1:end,k+1) = y(1:n-k);
end

% Modo alternativo per ottenere la matrice sfasata
YlagsCHK=lagmatrix(y,0:5);
diff=max(abs(Ylags-YlagsCHK),[],'all');
assert(diff==0,"Errore di implementazione nella " + ...
    "matrice degli sfasamenti")

%% Analisi preliminari (NON NEL LIBRO)
% Diagramma di dispersione tra yt e yt-1
scatter(Ylags(:,2),Ylags(:,1))
xlabel('y_{t-1}')
ylabel('y_{t}')
title('Diagramma di dispersione tra y_{t} e y_{t-1} (serie sfasata di 1)')

% yXplot tra yt ed i suoi sfasamenti
nomiY=["yt" "yt-"+(1:K)];
Ylagst=array2table(Ylags,'VariableNames',nomiY);
yXplot(Ylagst(:,1),Ylagst(:,2:end));

% Analisi delle correlazioni tra yt ed i suoi sfasamenti
correl=corr(Ylags(:,1),Ylags(:,2:end),'rows','pairwise');
correlt=array2table(correl,"RowNames","y_t","VariableNames",nomiY(2:end));
disp('correlazioni tra yt ed i suoi sfasamenti')
disp(correlt)

%% Autocorrelazioni (confrontro tra le due formule)

% con denominatore della covarianza n-k
C = corr(Ylags, rows="pairwise");
% con denominatore della covarianza n
rho = autocorr(y,K);
autoC=[C(:,1) rho];
nam=["Autocorr con denom (n-k) nella cov" "Autocorrelazioni"];
disp(array2table(autoC,"VariableNames",nam))


%% Autorrelazioni tramite GUIautocorr
GUIautocorr(y,'lag',2)

%% Autocorrelazioni mostrate tramite grafici a barre 
figure
subplot(2,1,1)
bar(0:K, C(1,:))
title('Autocorrelazioni calcolate tramite chiamata a corr (den n-k)')
% In questo caso utilizziamo la parola "Correlazioni"
ylabel('Correlazioni')

subplot(2,1,2)
r = fSampleACF( y, K );
bar(0:K, r)
title('Autocorrelazioni calcolate tramite chiamata a fSampleACF (den n)')
% In questo caso utilizziamo la parola "Autocorrelazioni"
ylabel('Autocorrelazioni')

%% Autocorrelazioni fino allo sfasamemento 45 (calcolate tramite fSampleACF)
Knew = 45;
rnew = fSampleACF( y, Knew );
figure;
bar(0:Knew, rnew);

%% Autocorrelazioni (tramite chiamata a autocorr)
g = figure;
autocorr(y, 45); %title({'Autocorrelazione'}, Interpreter="latex");
title('')
set(gca,'TickLabelInterpreter','latex');
xlabel(' ', Interpreter='latex')
ylabel(' ')
% exportgraphics(g,'gacf.pdf')

%% Ljung-Box  test
% Questa section anticipa il contenuto della sezione 
% 15.7.5 La verifica dell'ipotesi di incorrelazione
[Decision, pValue, LBstat, CriticaValue] = lbqtest(y, 'Lags', 10) 


%% Periodogramma via regressione lineare 
close all
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
bar(omega, Perio0); 
xlim([0 pi]); 
xlabel('\omega'); ylabel('I(\omega)');
set(gca,'TickLabelInterpreter','latex');

%% Periodogram via Fast Fourier Transform
vj = (0:floor(n/2))';omega = 2 * pi * vj / n; % Frequenze di Fourier
Perio = abs(fft(y)).^2/(n*2*pi) ;
Perio = Perio(1:length(omega));
Perio(2)  % valore identico a Perio_j calcolato in precedenza
plot(omega, Perio); 
xlim([0 pi]); xlabel('\omega'); ylabel('I(\omega)');
set(gca,'TickLabelInterpreter','latex'); 
%
g = figure;
bar(omega, Perio); xlim([0 pi]); 
xlabel('$\omega$', Interpreter='latex'); ylabel('$I(\omega)$', Interpreter='latex'); 
set(gca,'TickLabelInterpreter','latex');
% exportgraphics(g,'gPerio.pdf')

xregion(0.075,0.262)
%% esercizio
% plot(2*pi./ omega, Perio)
% [omega Perio]


