Y  = readmatrix("HadCRUT.5.0.1.0.analysis.summary_series.global.annual.csv");
y = Y(1:end-1,2);   
n = length(y);     % numero delle osservazioni 
cstarty = 1850; cstartm = 12; cstartd = 31;   % data inizio serie
cendy   = 2022; cendm   = 12; cendd = 31;     % data finale 
t1 = datetime(cstarty,cstartm,cstartd);    t2 = datetime(cendy,cendm,cendd);
t  = (t1:calyears(1):t2)';                     % creazione vettore di date


%% grafico della serie
% g = figure('Name','Serie Temperature Globali');
plot(t, y, LineWidth=2);     xlim([t1-5*calyears(1), t2+5*calyears(1)]);
set(gca,'TickLabelInterpreter','latex');
xlabel('t', Interpreter='latex')
ylabel('Gradi centigradi','Interpreter','latex',Rotation=90)
grid on; box on;
% exportgraphics(g,'gTemperature.pdf')

%% Approccio classico: Regressione polinomiale globale 
cpmax = 5;  % cpmax = massimo ordine del polinomio
cl = 10; % orizzonte di previsione

vt = (1:n)'; 
vtf = (n+1:n+cl)';
Yfitted = NaN(n,cpmax); 
Yforecast = NaN(cl,cpmax);

Xall=[vt; vtf].^(1:cpmax);
mX=Xall(1:n,:);
mXo=Xall(n+1:end,:);

for j=1:cpmax
    mdl    = fitlm(mX(:,1:j),y); 
    vypred = predict(mdl, mXo(:,1:j));
    Yfitted(:,j) = mdl.Fitted;
    Yforecast(:,j) = vypred; 
end
% g = figure('Name','Fit polinomiale');
plot(t, y, 'b', LineWidth=2);  
xlim([t1-5*calyears(1), t2+(5+cl)*calyears(1)]);
set(gca,'TickLabelInterpreter','latex'); xlabel('t', Interpreter='latex');
hold on 
newcolors = {'black','red','magenta','yellow','green'};
colororder(newcolors)
g1 = plot(t, Yfitted, LineWidth=2);  
tn = (t2+calyears(1:cl))';
g2 = plot(tn, Yforecast,   '--', LineWidth=2); 
legend( {'Serie', 'T. lineare', 'T. quadratico', 'T. cubico', ...
    'T. quartico', 'T. quintico'}, ...
    Location='southeast', Interpreter='latex');  
grid on; box on;
hold off
% exportgraphics(g,'gTrendPolinomiale.pdf')

%% plot kernel
ch = 20;
vh = (-ch:ch)';
vw_u = ones(2*ch+1,1)/(2*ch+1);
vw_l = 1-abs(vh)/ch;           vw_l = vw_l/(sum(vw_l));
vw_q = 1-(abs(vh)/ch).^2;      vw_q = vw_q/(sum(vw_q));
vw_t = (1-(abs(vh)/ch).^3).^3; vw_t = vw_t/(sum(vw_t));
% g = figure('Name','kernels');
subplot(2,2,1); 
bar(vh, vw_u, 0.5, 'r');  
title('Uniforme','Interpreter','latex');  
ylim([0 0.06]); 
set(gca,'TickLabelInterpreter','latex');
subplot(2,2,2); 
bar(vh, vw_l, 0.5, 'r');  
title('Triangolare','Interpreter','latex');    
ylim([0 0.06]); 
set(gca,'TickLabelInterpreter','latex');
subplot(2,2,3); 
bar(vh, vw_q, 0.5, 'r');  
title('Quadratico','Interpreter','latex'); 
ylim([0 0.06]); 
set(gca,'TickLabelInterpreter','latex');
subplot(2,2,4); 
bar(vh, vw_t, 0.5, 'r'); 
title('Tricube ','Interpreter','latex');    
ylim([0 0.06]); 
set(gca,'TickLabelInterpreter','latex');
% exportgraphics(g,'gKernels.pdf')

%% Estensione della serie con h previsioni 
% mediante trend lineare adattato alle prime e ultime m  osservazioni
chmax = 40;   
m = 30; 
% Modello stimato in base alle prime cm osservazioni
y0   = flip(y(1:m)); 
X0 = (1:m)'; 
mdl0  = fitlm(X0,y0);
% Previsioni da aggiungere prima di y(1) in modo da estendere
% la serie a sinistra
yhatprima  = predict(mdl0, (m+1:m+chmax)'); 
yhatprima  = flip(yhatprima);

y1   = y(n-m+1:n); 
X1 = (1:m)'; 
mdl1  = fitlm(X1,y1);
yhatdopo  = predict(mdl1, (m+1:m+chmax)'); 

vyext = [yhatprima; y; yhatdopo];   % serie estesa 
%plot(vyext)

%% Cross-validation
chmin = 3; 
% Yfitted = [];
Yfitted=zeros(n,chmax-chmin+1);
vCVscore = NaN(chmax-chmin,1);
for h = chmin:chmax
    vyext = [yhatprima(end-h+1:end); y; yhatdopo(1:h)];
    vh = (-h:h)';
    % kernel tricube
    vw_t = (1-(abs(vh)/h).^3).^3; 
    vw_t = vw_t/(sum(vw_t));
    dw0  = vw_t(h+1);
    vyf = filter(vw_t, 1, vyext );
    vyhat = vyf(2*h+1:end);
    Yfitted(:,h-chmin+1) = vyhat;
    plot(t, [y, vyhat]); hold on;
    vCVscore(h-chmin+1) = sum((y-vyhat).^2)/((1-dw0)^2);
end

%%
g = figure('Name','Trend');
plot(t, y, 'b', LineWidth=1);  
xlim([t1-5*calyears(1), t2+(5+cl)*calyears(1)]);
set(gca,'TickLabelInterpreter','latex'); 
xlabel('t', Interpreter='latex');
hold on 
plot(t, Yfitted(:,[3,8,13]) , LineWidth=2);  
legend( {'Serie', '$h=5$', '$h=10$', '$h=15$'}, ...
    Location='southeast', Interpreter='latex');  
grid on; box on;
% exportgraphics(g,'gTrendTemp.pdf')

%% Pesi per coefficiente angolare beta_1, kernel uniforme
ch = 25;
vh = (-ch:ch)';
vw_beta0 = ones(2*ch+1,1)/(2*ch+1);
vw_beta1 = flip(3*vh/(ch*(ch+1)*(2*ch+1)));
%vw_beta1 =  flip(vh/sum(vh.^2));

vbf = filter(vw_beta1, 1, vyext );
vbhat = vbf(2*h+1:end);
plot(t,  vbhat);

%% Loess 
dspan = 0.2;
disp(['n.ro osservazioni utilizzate: ', num2str(floor(dspan*n))])
vyhat = smooth(y, dspan,'loess');
plot(t, [y, vyhat])
legend('Serie','Stima ''loess'' di $\mu_t$','Location','NW',Interpreter='latex'); 
 