% Stima del modello Trend+Stagionalità+Irregolare per la serie Airline
%% Caricamento dati e grafico
air   = load('Data_Airline.mat');
y     = log(air.Data);
vdate  = datetime(air.dates, "ConvertFrom", "datenum");
subplot(2,1,1);
plot(vdate, air.Data);
title('Serie Airline');
subplot(2,1,2);
plot(vdate, y);
title('Trasformazione logaritmica');

% print -depsc airline.eps;
%% Tramite  stackedplot
figure
stackedplot(air.DataTimeTable)

%% Creazione della matrice delle dummy stagionali e del trend
mD = dummyvar(month(vdate));  % 12 dummy stagionali
n     = length(y);
trend = (1:n)';                % regressore trend

%% Specificazione non vincolata (non identificata)
X = [trend, mD];
nomivar=["Trend" "D"+(1:12) "y"];
Mdl0 = fitlm(X,y, 'VarNames',nomivar);
disp(Mdl0)

%% Par. 1: matrice X con s-1 dummies D_jt^*, j = 1, ..., s-1
mDt = mD(:,1:11)-mD(:,12);
X1 = [trend, mDt];
nomivar1=["Trend", "D"+(1:11)+"t" "y"];
Mdl1 = fitlm(X1,y, 'VarNames',nomivar1);
disp(Mdl1)
% Coefficiente stagionale in corrispondenza della stagione s
dseas_s = -sum(Mdl1.Coefficients.Estimate(3:end));
% Coefficienti stagionali a somma sero
seascoef1 = [Mdl1.Coefficients.Estimate(3:end); dseas_s];
assert(abs(sum(seascoef1))<1e-15,"Coeff stag con somma diversa da 0")

%% Par. 2: eliminiamo l'intercetta dalla chiamata a fitlm
X2 = [trend, mD];
nomivar2=["Trend", "D"+(1:12)+"t" "y"];
Mdl2 = fitlm(X2, y, 'Intercept', false, 'VarNames',nomivar2);
beta0 = mean(Mdl2.Coefficients.Estimate(2:end));
seascoef2 = Mdl2.Coefficients.Estimate(2:end)-beta0;
assert(max(abs(seascoef2-seascoef1))<1e-14,"stag diverse da prima par")

%% Par. 3: eliminiamo la dummy D_st (ultima stagione)
X3 = [trend, mD(:,1:11)];
nomivar3=["Trend", "D"+(1:11)+"t" "y"];
Mdl3 = fitlm(X3,y, 'VarNames',nomivar3);
beta0dagger=Mdl3.Coefficients.Estimate(1);
% Stima dell'intercetta
beta0 =  beta0dagger + sum(Mdl3.Coefficients.Estimate(3:end))/12;
% Stima dei coefficienti stagionali delta1, ..., deltas-1
dseas = beta0dagger+Mdl3.Coefficients.Estimate(3:end)-beta0;
% Stima del coefficiente stagionale deltas
seas_s = beta0dagger-beta0;
seascoef3 = [dseas; seas_s];
assert(max(abs(seascoef3-seascoef1))<1e-14,"stag diverse da prima par")

%% Controllo uguaglianza tra i valori stimati nelle diverse param.
assert(max(abs(Mdl1.Fitted-Mdl2.Fitted))<1e-14,"yhat diversi")
assert(max(abs(Mdl1.Fitted-Mdl3.Fitted))<1e-14,"yhat diversi")
