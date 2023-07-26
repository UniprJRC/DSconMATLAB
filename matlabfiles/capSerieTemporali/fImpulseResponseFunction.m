function vPsi = fImpulseResponseFunction(vAR, vMA, cK)
% Input vAR: 1 times p vector of autoregressive coefficients (\phi_1, \ldots, \phi_p),  
%       vMA: 1 times q vector of moving average coefficients (\theta_1, \ldots, \theta_q)
%       cK: number of lags
vPsi = filter([1 vMA], [1 -vAR], [1 zeros(1,cK)]) ;
end