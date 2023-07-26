function r = fSampleACF( y, nlags )
% Funzione di autocorrelazione campionaria della serie y
% viene calcolata per tutti i ritardi compresi tra 0 e nlags
c_0 = fautocovariance(y, 0);
r  = [1, zeros(1, nlags)];
for k = 1:nlags 
    c_k    = fautocovariance(y,k);
    r(k+1) = c_k/c_0;
end
end

