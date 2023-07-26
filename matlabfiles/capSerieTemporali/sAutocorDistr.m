rng(125);
n      = 1000;  m  = 10;
y      = rand(n, 1)-0.5;  % serie temporale
ybar   = mean(y);
rhohat = autocorr(y,m);
[~,pValue,LBstat, CritVal]  = lbqtest(y, Lags=1:m);
T = table(LBstat',CritVal',pValue','VariableNames',{'LB test','Critical Value','p-value'});

T = table(LBstat',CritVal',pValue',...
    'VariableNames',{'LB test','Critical Value','p-value'}, ...
    'RowNames',{'Lag 1', 'Lag 2' ,'Lag 3', 'Lag 4' ,'Lag 5', 'Lag 6' ,'Lag 7', 'Lag 8' ,'Lag 9', 'Lag 10' } )  
 
 
 
 
 