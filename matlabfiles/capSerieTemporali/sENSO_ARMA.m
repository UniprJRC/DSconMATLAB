url = ('https://www.cpc.ncep.noaa.gov/data/indices/sstoi.indices');
websave('sstoi.txt',url)
data  = readtable('sstoi.txt', VariableNamingRule='preserve');  % Importazione dei dati in formato 'table'
t1    = datetime(data.YR(1),data.MON(1),31);  % data iniziale 
n     = size(data,1);                         % n.ro delle osservazioni
t     = t1 +  calmonths(0:n-1);               % vettore di date 
y     = data.ANOM_3;    % selezione della serie delle anomalie regione 3.4
%
plot(t, y, 'LineWidth',2);  
autocorr(y);
parcorr(y)
%% selezione del modello
cpmax = 5; cqmax = 2;
mAIC  = NaN(cpmax+1,cqmax+1); mBIC = NaN(cpmax+1,cqmax+1);
for p = 0:cpmax
    for q = 0:cqmax
        Mdl = arima(p,0,q); Mdl.Constant = 0;
        EstMdl = estimate(Mdl, y);
        mAIC(p+1, q+1) = EstMdl.summarize.AIC;
        mBIC(p+1, q+1) = EstMdl.summarize.BIC;
    end
end
% Selezione mediante AIC 
[dminAIC iInd] = min(mAIC(:)); [ir, ic] = ind2sub(size(mAIC),iInd);
cpsel = ir-1; cqsel = ic-1;
% Selezione mediante BIC 
[dminBIC iInd] = min(mBIC(:)); [ir, ic] = ind2sub(size(mBIC),iInd);
cpsel = ir-1; cqsel = ic-1;
% stima del modello scelto
Mdl = arima(cpsel,0,cqsel); Mdl.Constant = 0;
EstMdl = estimate(Mdl, y)
summarize(EstMdl)
phi1 = EstMdl.AR{1}; phi2 = EstMdl.AR{2}; theta =  EstMdl.MA{1};
vr = roots([-phi2 -phi1 1]); % radici del polinomio autoregressivo
dmod = abs(vr);              % modulo delle radici
% funzione di risposta all'impulso
irf =  filter( [1 theta], [1 -phi1 -phi2],[1; zeros(48, 1)]);
bar(0:48, irf)
% analisi dei residui
e = infer(EstMdl, y) 
plot(t,e); autocorr(e); parcorr(e)
m = 12;
[h, pvalie, stat, cvalue] = lbqtest(e, Lags = m, Dof = m-cpsel-cqsel ) % Ljung-Box 
%% previsione 
[yfor, msfe] = forecast(EstMdl,18,y)
tf = t(end)+calmonths(1:18)
g = figure()
plot(t(end-12*8:end), y(end-12*8:end)); hold on;
plot(tf, yfor, Color = 'b', LineStyle="-",LineWidth=2)
plot(tf, yfor+1.96*sqrt(msfe), Color = 'b', LineStyle="--",LineWidth=2);
plot(tf, yfor-1.96*sqrt(msfe), Color = 'b', LineStyle="--",LineWidth=2);
set(gca,'TickLabelInterpreter','latex');
hold off
grid on; box on;
exportgraphics(g,'gNinofor.pdf')


%%
tt=t(1:end-18); 
yt=y(1:end-18); 
[yfor, msfe] = forecast(EstMdl,18,yt);  % previsioni fino a 18 mesi in avanti
tf = tt(end)+calmonths(1:18);
g = figure();
plot(tt(end-12*8:end), yt(end-12*8:end));  
hold on;
plot(tf, yfor, Color = 'b', LineStyle="-",LineWidth=2) 
plot(tf, yfor+1.96*sqrt(msfe), Color = 'b',LineStyle="--",LineWidth=2);   
plot(tf, yfor-1.96*sqrt(msfe), Color = 'b',LineStyle="--",LineWidth=2);   
plot(tf, y(end-17:end), Color = 'g', LineStyle="-",LineWidth=2) 
set(gca,'TickLabelInterpreter','latex'); 
legend({'Storico','Previsione', 'Limite superiore', 'Limite inferiore', ...
    'Osservato'},'Location', 'best', 'Interpreter', 'latex');