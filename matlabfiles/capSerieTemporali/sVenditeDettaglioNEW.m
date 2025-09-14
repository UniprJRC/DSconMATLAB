mY  = readmatrix("sts_trtu_m.xlsx","Sheet","Sheet 1","Range","DF13:NZ16");
y = log(mY(3,:)');
% date da gennaio 2000 fino a maggio 2023
t1 = datetime(2000,1,31);
t2 = datetime(2023,5,31);
t = (t1:calmonths(1):t2)';
plot(t, y )
n=length(y);
% Osservazione: creazione estrattore
% t1-30 in modo tale da partire dal primo di gennaio del 2000
TR = timerange(t1-30,t2);

%% creiamo le variabili di calendario fino al 2050
t1c = datetime(1900, 1, 1);
t2c = datetime(2050,12,31);
vdate = (t1c:caldays(1):t2c)';     % giorni di calendario

vdow = day(vdate, 'dayofweek');  % giorni della settimana (1=domenica)
TD = dummyvar(vdow);

TDtt=array2timetable(TD,'Rowtimes',vdate);
Gtt = retime(TDtt,'monthly','sum');
% In alternativa si poteva utilizzare convert2monthly
% TCAL=convert2monthly(TDtt,'Aggregation',"sum");


% leap è la variabile Bt (assume valore 0.75 per gli anni bisestili e
% -0.25 per gli altri anni).
leap=zeros(size(Gtt,1),1);
numDays=sum(Gtt{:,:},2);
leap(numDays==29)=0.75;
leap(numDays==28)=-0.25;
% La variabile leap viene aggiunta a Gtt
Gtt.leap=leap;

% Viene creata  G^*_1 (lun-dom), ..., G^*_6 (sab-dom)
Gtt{:,1:6}=Gtt{:,2:7}-Gtt{:,1};
Gtt(:,7)=[];

% G^* and B components
GBtt=Gtt(TR,:);

%% Dummy associata al periodo pasquale
mEaster = readmatrix('Easter.xlsx'); 
% the file Easter.xlsx contains the Easter dates from 1900 to 2099
vEasterdates = datetime(mEaster);
vdate=(vEasterdates(1)-10:vEasterdates(end)+10)';
% ia = posizione di vdate dove si trova la Pasqua
[~,ia]=intersect(vdate,vEasterdates);
easterDummy=zeros(length(vdate),1);
ch1 = 3; ch2 = 2;
easterPeriod=ia+(-ch1:ch2);
% easterDummy = vettore che assume valore 1 in corrispondenza del periodo
% Pasquale (da 3 giorni prima della Pasqua fino a due giorni dopo)
easterDummy(easterPeriod(:))=1;
easter = easterDummy/(ch1+ch2+1);
Ett   = retime(timetable(vdate,easter),'monthly','sum');
Ett.easter = Ett.easter - 1/12;

% Variabile dummy per il range di date definito da TR
Ett=Ett(TR,:);
% Xcaltt = timetable con gli effetti di calendatio
Xcaltt=[GBtt Ett];

% Variabili dummies mensili (effetti stagionali)
tempi=Xcaltt.Properties.RowTimes;
Seas=dummyvar(tempi.Month);
SeasD = Seas(:,1:end-1)-Seas(:,end);
trend=(1:n)';
TStt=array2timetable([y trend SeasD],'RowTimes',tempi);

yXtt=[TStt Xcaltt];
yXtt.Properties.VariableNames(1:13)=["y" "trend" "Seas"+(1:11)];

yXtt=[TStt Xcaltt];
yXtt.Properties.VariableNames(1:13)=["y" "trend" "Seas"+(1:11)];

yX=timetable2table(yXtt,'ConvertRowTimes',false);

% utilizziamo fino al dic 2016
ff=(n-5-12*6);
yXt=yX(1:ff,:);
t=tempi(1:ff);
X=yXt{:,2:end};
y=yXt{:,1};
% I dati da gen 2017 fino a dic 2019 sono utilizzati per il test
yXtnew=yX(ff+1:ff+36,:);
tnew=tempi(ff+1:ff+36);
ynew=yX{ff+1:ff+36,1};

%% Stima del modello
mdl=fitlm(yXt,'ResponseVar','y');
disp(mdl)

% yX = dateshift(yXtt,'end','month')
%%

%{
 mdl = fitlm(X,y, 'VarNames',{'Trend', 'SeasD1','SeasD2','SeasD3','SeasD4','SeasD5','SeasD6',...
     'SeasD7','SeasD8','SeasD9','SeasD10','SeasD11','TD1','TD2','TD3','TD4','TD5','TD6','Leap','Easter', 'Vendite'});
%}

% trend 
vT =  mdl.Coefficients.Estimate(1)+X(:,1)*mdl.Coefficients.Estimate(2);

% componente stagionale
vdelt0 = mdl.Coefficients.Estimate(3:13);
vS = X(:,2:12)*vdelt0;

% componenti di calendario
vC = X(:,13:end)* mdl.Coefficients.Estimate(14:end);

% effetti stagionali
vdelt = [vdelt0; -sum(vdelt0)]  ;

% effetti di calendario
vgamma0 = mdl.Coefficients.Estimate(14:19);
vgamma  = [vgamma0; -sum(vgamma0)];

%% Previsione nei 3 anni successivi
[ypred, yci] = predict(mdl,yXtnew,'Alpha',0.001);


%% Grafici

plot(t,[yXt.y mdl.Fitted])
%subplot(3,2,1); plot(t0,[vy0 mdl.Fitted])
%plot(t0, mdl.Residuals.Raw)
autocorr(mdl.Residuals.Raw);
title('{\bf Autocorrelazione dei residui}')

figure();
subplot(3,2,1); 
plot(t,[y vT]); 
set(gca,'TickLabelInterpreter','latex');
title("Serie e trend lineare", Interpreter="latex")

subplot(3,2,2); 
plot(t, [vS, vC]);
set(gca,'TickLabelInterpreter','latex'); 
title("Comp. stagionale e di calendario", Interpreter="latex");

% Effetti stagionali (mese dell'anno)
subplot(3,2,3); 
bar(vdelt);  
title("Effetti stagionali", Interpreter="latex");
set(gca, 'XTick', 1:length(vdelt)); ylim([-0.2,0.3])
set(gca,'XTickLabel',{'Gen','Feb','Mar','Apr','Mag','Giu','Lug','Ago','Set','Ott','Nov','Dic'});
set(gca,'TickLabelInterpreter','latex');

% Effetti di calendario (giorno della settimana)
subplot(3,2,4); 
bar(vgamma);  
set(gca,'TickLabelInterpreter','latex'); 
title("Effetti di calendario", Interpreter="latex");
set(gca, 'XTick', 1:length(vgamma)); ylim([-0.02,0.01])
set(gca,'XTickLabel',{'Lun','Mar','Mer','Gio','Ven','Sab','Dom'});

% Residui
subplot(3,2,5); 
plot(t, y-vT-vS-vC);  
title("Residui", Interpreter="latex"); set(gca,'TickLabelInterpreter','latex');
line([t(1) t(end)], [0 0], 'LineStyle','--','Color', 'r');

% Autocorrelazione nei residui
subplot(3,2,6);   
autocorr(mdl.Residuals.Raw); title({'Autocorrelazione dei residui'}, Interpreter="latex");
set(gca,'TickLabelInterpreter','latex'); 
xlabel(' ', Interpreter='latex')
ylabel(' ')

%% Previsione - test sample 2017.1-2019.12
% mXo = mX(cn-5-12*6+1:cn-5-12*3,:);
% tnew = t(cn-5-12*6+1:cn-5-12*3); 
%vyo = y(cn-5-12*6+1:cn-5-12*3);
% [vypred, myci] = predict(mdl, mXo, 'Alpha',0.001);


% grafico
g = figure();
plot(t(end-12*6:end), y(end-12*6:end), 'r+');   hold on;
plot(t(end-12*6:end), mdl.Fitted(end-12*6:end),'b', 'LineWidth',1);
plot(tnew, vyo, 'r*');
plot(tnew,  ypred, 'b', 'LineWidth', 2 )
fill([tnew', fliplr(tnew') ], [yci(:,1)', flipud(yci(:,2))']', 'b', 'EdgeColor','none', 'FaceAlpha',0.25)
set(gca,'TickLabelInterpreter','latex');
legend({'Serie storica','Valori predetti','Valori osservati ','Previsioni'}, 'Location','southeast', Interpreter="latex");
exportgraphics(g,'gPrevClassica.pdf')
hold off




%%
mX =  mXcal;  % matrice dei regressori
[cn, cK] =   size(mX);
t0  =  t(1:cn-5-12*6);
vy0 = vy(1:cn-5-12*6);
mX0 = mX(1:cn-5-12*6,:);
%% Specificazione modello regARIMA
Mdl = regARIMA('Intercept', 0,  'D', 1, 'Seasonality', 12, 'MALags', 1, 'sMALags', 12);
[EstMdl,~,~,~] = estimate(Mdl, vy0, 'X', mX0); % stima
summarize(EstMdl)
ve = infer(EstMdl,vy0,'X', mX0); %residui
plot(t0,ve); 
autocorr(ve(13:end));
vy0_hat = vy0-ve;
%% Previsione - test sample 2017.1-2019.12
mXo = mX(cn-5-12*6+1:cn-5-12*3,:); % regressori nel periodo di previsione
tnew = t(cn-5-12*6+1:cn-5-12*3); vyo = vy(cn-5-12*6+1:cn-5-12*3);
[vypred,vmsfe] = forecast(EstMdl,36,'Y0', vy0, 'X0', mX0,'XF',mXo);