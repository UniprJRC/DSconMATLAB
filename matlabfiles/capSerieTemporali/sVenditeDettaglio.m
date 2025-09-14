mY  = readmatrix("sts_trtu_m.xlsx","Sheet","Sheet 1","Range","DF13:NZ16");
vy = log(mY(3,:)');
% date
cstarty = 2000; cstartm = 1; cstartd = 31;
cendy   = 2023; cendm   = 5; cendd = 31;
t1 = datetime(cstarty,cstartm,cstartd);  
t2 = datetime(cendy,cendm,cendd);
t = (t1:calmonths(1):t2)'; 
plot(t, vy )
%% creiamo le variabili di calendario fino al 2050
cendy = 2050;
t1c = datetime(cstarty, cstartm, 1); t2c = datetime(2050,12,31);
vdate = (t1c:caldays(1):t2c)';     % giorni di calendario
vdow = day(vdate, 'dayofweek');  % giorni della settimana (1=domenica)  
mD = dummyvar(vdow);
TT_dow = timetable(vdate, mD);
TT_ndow = retime(TT_dow,'monthly','sum');   % timetable with 
vlom = sum(TT_ndow.mD,2);
vlom_star = vlom;
vlom_star(month(TT_ndow.vdate) ==  2) = 28.25;
vleapy = vlom-vlom_star;
%% Pasqua
mEaster = readmatrix('Easter.xlsx'); %   il file Easter.xlsx contiene le date della Pasqua dal 1900 al 2099
mEaster = mEaster(cstarty-1900+1:cendy-1900+1,:);
vEasterdates = datetime(mEaster);
vEaster = datenum(mEaster);
vd = datenum(vdate);
ch1 = 3; ch2 = 2;
vEasterDummy = sum((vd <= (vEaster+ch2)') & (vd >= (vEaster-ch1)'),2)/(ch1+ch2+1) ;
TT_e   = retime(timetable(vdate,vEasterDummy),'monthly','sum') ;  
vEasterRegr =TT_e.vEasterDummy-mean(TT_e.vEasterDummy);
TT_cal = timetable(TT_ndow.vdate, TT_ndow.mD(:,2:end)-TT_ndow.mD(:,1), vleapy,vEasterRegr); 
TR = timerange(t1c,t2);
mXcal = table2array(TT_cal(TR,:));
cn = size(mXcal, 1);
vt = (1:cn)';
mSeasD = dummyvar(month(t)); 
cs = 12; 
mSeasDs = mSeasD(:,1:cs-1)-mSeasD(:,cs);
%%
mX = [vt, mSeasDs, mXcal];  % matrice dei regressori
[cn, cK] =   size(mX);
% training sample 2000.1-2016.12
t0  =  t(1:cn-5-12*6);
vy0 = vy(1:cn-5-12*6);
mX0 = mX(1:cn-5-12*6,:);
%% Stima del modello
mdl = fitlm(mX0,vy0, 'VarNames',{'Trend', 'SeasD1','SeasD2','SeasD3','SeasD4','SeasD5','SeasD6',...
    'SeasD7','SeasD8','SeasD9','SeasD10','SeasD11','TD1','TD2','TD3','TD4','TD5','TD6','Leap','Easter', 'Vendite'});
plot(t0,[vy0 mdl.Fitted])
%subplot(3,2,1); plot(t0,[vy0 mdl.Fitted])
%plot(t0, mdl.Residuals.Raw)
autocorr(mdl.Residuals.Raw); title('{\bf Autocorrelazione dei residui}')
g = figure();
% trend 
vT =  mdl.Coefficients.Estimate(1)+mX0(:,1)*mdl.Coefficients.Estimate(2);
subplot(3,2,1); plot(t0,[vy0 vT]); set(gca,'TickLabelInterpreter','latex'); 
title("Serie e trend lineare", Interpreter="latex")
% profilo stagionale
vdelta0 = mdl.Coefficients.Estimate(3:13);
vdelta = [vdelta0; -sum(vdelta0)]  ;
% componente stagionale 
vS = mX0(:,2:12)*vdelta0;
% componente di calendario
vC = mX0(:,13:end)* mdl.Coefficients.Estimate(14:end);
subplot(3,2,2); plot(t0, [vS, vC]);   
set(gca,'TickLabelInterpreter','latex'); title("Comp. stagionale e di calendario", Interpreter="latex");
%
subplot(3,2,3); bar( vdelta);  title("Effetti stagionali", Interpreter="latex");
set(gca, 'XTick', 1:length(vdelta)); ylim([-0.2,0.3])
set(gca,'XTickLabel',{'Gen','Feb','Mar','Apr','Mag','Giu','Lug','Ago','Set','Ott','Nov','Dic'});
set(gca,'TickLabelInterpreter','latex');
%
vgamma0 = mdl.Coefficients.Estimate(14:19);
vgamma  = [vgamma0; -sum(vgamma0)];
subplot(3,2,4); bar(vgamma);  set(gca,'TickLabelInterpreter','latex'); title("Effetti di calendario", Interpreter="latex");
set(gca, 'XTick', 1:length(vgamma)); ylim([-0.02,0.01])
set(gca,'XTickLabel',{'Lun','Mar','Mer','Gio','Ven','Sab','Dom'});
% 
subplot(3,2,5); plot(t0, vy0-vT-vS-vC);  title("Residui", Interpreter="latex"); set(gca,'TickLabelInterpreter','latex'); 
line([t0(1) t0(end)], [0 0], 'LineStyle','--','Color', 'r');  
%
subplot(3,2,6);   autocorr(mdl.Residuals.Raw); title({'Autocorrelazione dei residui'}, Interpreter="latex");
set(gca,'TickLabelInterpreter','latex'); xlabel(' ', Interpreter='latex')
ylabel(' ')
exportgraphics(g,'gModelloClassico.pdf') 
%% Previsione - test sample 2017.1-2019.12
mXo = mX(cn-5-12*6+1:cn-5-12*3,:);
tnew = t(cn-5-12*6+1:cn-5-12*3); vyo = vy(cn-5-12*6+1:cn-5-12*3);
[vypred, myci] = predict(mdl, mXo, 'Alpha',0.001);
% grafico
g = figure();
plot(t0(end-12*6:end), vy0(end-12*6:end), 'r+');   hold on;
plot(t0(end-12*6:end), mdl.Fitted(end-12*6:end),'b', 'LineWidth',1);
plot(tnew, vyo, 'r*'); 
plot(tnew,  vypred, 'b', 'LineWidth', 2 )
fill([tnew', fliplr(tnew') ], [myci(:,1)', flipud(myci(:,2))']', 'b', 'EdgeColor','none', 'FaceAlpha',0.25)
set(gca,'TickLabelInterpreter','latex');
legend({'Serie storica','Valori predetti','Valori osservati ','Previsioni'}, 'Location','southeast', Interpreter="latex"); 
exportgraphics(g,'gPrevClassica.pdf') 
hold off

 