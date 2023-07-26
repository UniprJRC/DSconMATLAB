mY  = readmatrix("HadCRUT.5.0.1.0.analysis.summary_series.global.annual.csv");
vy = mY(1:end-1,2);   
cn = length(vy);     % numero delle osservazioni 
cstarty = 1850; cstartm = 12; cstartd = 31;   % data inizio serie
cendy   = 2022; cendm   = 12; cendd = 31;     % data finale 
t1 = datetime(cstarty,cstartm,cstartd);    t2 = datetime(cendy,cendm,cendd);
t  = (t1:calyears(1):t2)';                     % creazione vettore di date
%% grafico della serie
g = figure('Name','Serie Temperature Globali')
plot(t, vy, LineWidth=2);     xlim([t1-5*calyears(1), t2+5*calyears(1)]);
set(gca,'TickLabelInterpreter','latex');
xlabel('t', Interpreter='latex')
ylabel('Gradi centigradi','Interpreter','latex',Rotation=90)
grid on; box on;
exportgraphics(g,'gTemperature.pdf')
%% Approccio classico: Regressione polinomiale globale 
cpmax = 5;  cl = 10;
mX = [];   mXo = []; 
vt = (1:cn)'; vtf = (cn+1:cn+cl)';
myhat = NaN(cn,cpmax); myfor = NaN(cl,cpmax);
for p=1:cpmax
    mX     = [mX vt.^p];  mXo = [mXo vtf.^p];
    mdl    = fitlm(mX,vy); 
    vypred = predict(mdl, mXo);
    myhat(:,p) = mdl.Fitted;
    myfor(:,p) = vypred; 
end
g = figure('Name','Fit polinomiale')
plot(t, vy, 'b', LineWidth=2);  
xlim([t1-5*calyears(1), t2+(5+cl)*calyears(1)]);
set(gca,'TickLabelInterpreter','latex'); xlabel('t', Interpreter='latex');
hold on 
newcolors = {'black','red','magenta','yellow','green'};
colororder(newcolors)
g1 = plot(t, myhat, LineWidth=2);  
tn = (t2+calyears(1:cl))';
g2 = plot(tn, myfor,   '--', LineWidth=2); 
legend( {'Serie', 'T. lineare', 'T. quadratico', 'T. cubico', 'T. quartico', 'T. quintico'}, ...
    Location='southeast', Interpreter='latex');  
grid on; box on;
hold off
exportgraphics(g,'gTrendPolinomiale.pdf')
%% plot kernel
ch = 20;
vh = (-ch:ch)';
vw_u = ones(2*ch+1,1)/(2*ch+1);
vw_l = 1-abs(vh)/ch;           vw_l = vw_l/(sum(vw_l));
vw_q = 1-(abs(vh)/ch).^2;      vw_q = vw_q/(sum(vw_q));
vw_t = (1-(abs(vh)/ch).^3).^3; vw_t = vw_t/(sum(vw_t));
g = figure('Name','kernels')
subplot(2,2,1); bar(vh, vw_u, 0.5, 'r');  title('Uniforme','Interpreter','latex');  
ylim([0 0.06]); set(gca,'TickLabelInterpreter','latex');
subplot(2,2,2); bar(vh, vw_l, 0.5, 'r');  title('Triangolare','Interpreter','latex');    
ylim([0 0.06]); set(gca,'TickLabelInterpreter','latex');
subplot(2,2,3); bar(vh, vw_q, 0.5, 'r');  title('Quadratico','Interpreter','latex'); 
ylim([0 0.06]); set(gca,'TickLabelInterpreter','latex');
subplot(2,2,4); bar(vh, vw_t, 0.5, 'r'); title('Tricube ','Interpreter','latex');    
ylim([0 0.06]); set(gca,'TickLabelInterpreter','latex');
exportgraphics(g,'gKernels.pdf')
%% Estensione della serie con h previsioni mediante trend lineare adattato alle prime e ultime cm  osservazioni
chmax = 40;   
cm = 30; 
vy0   = flip(vy(1:cm)); mX0 = (1:cm)'; 
mdl0  = fitlm(mX0,vy0);
vy0f  = predict(mdl0, (cm+1:cm+chmax)'); 
vy0f  = flip(vy0f);
vy1   = vy(cn-cm+1:cn); mX1 = (1:cm)'; 
mdl1  = fitlm(mX1,vy1);
vy1f  = predict(mdl1, (cm+1:cm+chmax)'); 
vyext = [vy0f; vy; vy1f];   % serie estesa 
%plot(vyext)
%% Cross-validation
chmin = 3; 
myhat = [];
vCVscore = NaN(chmax-chmin,1)
for h = chmin:chmax
    vyext = [vy0f(end-h+1:end); vy; vy1f(1:h)];
    vh = (-h:h)'
    vw_t = (1-(abs(vh)/h).^3).^3; vw_t = vw_t/(sum(vw_t));
    dw0  = vw_t(h+1);
    vyf = filter(vw_t, 1, vyext );
    vyhat = vyf(2*h+1:end);
    myhat(:,h-chmin+1) = vyhat;
    plot(t, [vy, vyhat]); hold on;
    vCVscore(h-chmin+1) = sum((vy-vyhat).^2)/((1-dw0)^2)
end
%%
g = figure('Name','Trend')
plot(t, vy, 'b', LineWidth=1);  
xlim([t1-5*calyears(1), t2+(5+cl)*calyears(1)]);
set(gca,'TickLabelInterpreter','latex'); xlabel('t', Interpreter='latex');
hold on 
plot(t, myhat(:,[3,8,13]) , LineWidth=2);  
legend( {'Serie', '$h=5$', '$h=10$', '$h=15$'}, ...
    Location='southeast', Interpreter='latex');  
grid on; box on;
exportgraphics(g,'gTrendTemp.pdf')
%% pesi per coefficiente angolare beta_1, kernel uniforme
ch = 25
vh = (-ch:ch)';
vw_beta0 = ones(2*ch+1,1)/(2*ch+1);
vw_beta1 = flip(3*vh/(ch*(ch+1)*(2*ch+1)));
%vw_beta1 =  flip(vh/sum(vh.^2));

vbf = filter(vw_beta1, 1, vyext );
vbhat = vbf(2*h+1:end);
plot(t,  vbhat);
%% Loess 
dspan = 0.2;
disp(['n.ro osservazioni utilizzate: ', num2str(floor(dspan*cn))])
vyhat = smooth(vy, dspan,'loess');
plot(t, [vy, vyhat])
legend('Serie','Stima ''loess'' di $\mu_t$','Location','NW',Interpreter='latex'); 
 