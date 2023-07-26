function [ gamma_k ] = fautocovariance( y, k )
% y is a column vector
% computes the autocovariance of y at lag k
n       = length(y);
ystar   = y - mean(y);
gamma_k = dot( ystar(k+1:n), ystar(1:n-k)) / n;
end

