% Stima del modello Trend+Stagionalità+Irregolare per la serie Airline (Box  e Jenkins)
air    = load('Data_Airline.mat');
vy     = log(air.Data); 
cn     = length(vy);
vdate  = datetime(air.dates, "ConvertFrom", "datenum")
figure("Name","Serie");
subplot(2,1,1); plot(vdate, air.Data); title('Serie Airline');
subplot(2,1,2); plot(vdate, vy);       title('Trasformazione logaritmicaLogarithmic transformation'); 
mD = dummyvar(month(vdate));  % 12 dummy stagionali
vt = (1:cn)';                 % regressore trend
%% Specificazione non vincolata (non identificata) - nota il Warning"
mX = [vt, mD];
Mdl0 = fitlm(mX,vy, 'VarNames',{'Trend', 'D1','D2','D3','D4','D5','D6',...
    'D7','D8','D9','D10','D11','D12', 'y'})
%% s-1 dummies D_jt^*, j = 1, ..., s-1
mDt = mD(:,1:11)-mD(:,12);
mX = [vt, mDt ];
Mdl1 = fitlm(mX,vy, 'VarNames',{'Trend', 'D1t','D2t','D3t','D4t','D5t','D6t',...
    'D7t','D8t','D9t','D10t','D11t', 'y'})
dseas_s = -sum(Mdl1.Coefficients.Estimate(3:end));
vseascoef = [Mdl1.Coefficients.Estimate(3:end); dseas_s ];
%% Eliminiamo l'intercetta
mX = [vt, mD];
Mdl2 = fitlm(mX,vy, 'Intercept', false, 'VarNames',{'Trend', 'D1','D2','D3','D4','D5','D6',...
    'D7','D8','D9','D10','D11','D12', 'y'})
dbeta0 = mean(Mdl2.Coefficients.Estimate(2:end));
vseascoef = Mdl2.Coefficients.Estimate(2:end)-dbeta0;
sum(vseascoef)
%% Eliminiamo la dummy D_st
mX = [vt, mD(:,1:11)];
Mdl3 = fitlm(mX,vy, 'VarNames',{'Trend', 'D1','D2','D3','D4','D5','D6',...
    'D7','D8','D9','D10','D11', 'y'})
dbeta0 = Mdl3.Coefficients.Estimate(1) + sum(Mdl3.Coefficients.Estimate(3:end))/12; % intercept
dseas_s = -sum(Mdl3.Coefficients.Estimate(3:end))/12;
vseas_1 = Mdl3.Coefficients.Estimate(3:end)+Mdl3.Coefficients.Estimate(1)-dbeta0;
vseascoef = [vseas_1; dseas_s ];
 