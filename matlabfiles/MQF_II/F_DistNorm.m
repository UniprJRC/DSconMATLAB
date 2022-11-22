function [x, medcamp, stdevcamp, stdevcamp_parz, skewncamp, skewncamp_parz, kurtoscamp, kurtoscamp_parz] = F_DistNorm(n,mu,sigma)
%% ESERCIZIO DISTRIBUZIONE NORMALE

% La funzione genera un vettore aleatorio x di dimensione n x 1, da una
% distribuzione normale con  media mu e deviazione standard sigma.
% In aggiunta, partendo dalla simulazione, la funzione calcola la media,
% la deviazione standard, l'indice di asimmetria e l'indice di curtosi del campione. 

% INPUTS:   n      := il numero delle righe del vettore colonna x generato
% da una distribuzione normale con parametri:
%           mu     := la media della distribuzione normale
%           sigma  := deviazione standard della distribuzione normale
% OUTPUTS:  x      := vettore aleatorio simulato
%           medcamp := media campionaria
%           stdevcamp  := deviazione standard campionaria (imparziale)
%           skewncamp  := l'indice di asimmetria campionaria (imparziale)
%           kurtoscamp := l'indice di curtosi campionaria (imparziale)
%           stdevcamp_parz  := deviazione standard campionaria (parziale)
%           skewncamp_parz  := l'indice di asimmetria campionaria (parziale)
%           kurtoscamp_parz := l'indice di curtosi campionaria (parziale)
x = mu + sigma*randn(n,1);   % genera una variabile aleatoria normale
                             % da una normale standard con media 0 e
                             % deviazione standard 1
medcamp = mean(x);       % media dei valori simulati x
x0 = x-medcamp;          % gli scarti
stdevcamp = sqrt(sum(x0.^2)/(n-1)); % deviazione standard (imparziale)
stdevcamp_parz=sqrt((n-1)/n*sum(x0.^2)/(n-1));  % deviazione standard (parziale)
skewncamp_parz = mean(x0.^3)/stdevcamp_parz^3; % l'indice di asimmetria (parziale)
skewncamp=sqrt(n*(n-1))/(n-2)*skewncamp_parz; % l'indice di asimmetria (imparziale)
kurtoscamp_parz = mean(x0.^4)/stdevcamp_parz^4;  % l'indice di curtosi (parziale)
kurtoscamp = (n-1)/((n-2)*(n-3))*((n+1)*kurtoscamp_parz-3*(n-1))+3;  
% l'indice di curtosi (imparziale)

% Confronta le quantità calcolate precedentemente con le funzioni già
% installate in Matlab.
% Attenzione: Richiede l'installazione del toolbox "Statistics and Machine Learning"
% dev = std(x, flag); flag = 1 (default) == deviazione standard 
% (parziale); flag = 0 == deviazione standard (imparziale)
% skewn = skewness(x, flag); % flag = 1 (default) == l'indice di asimmetria 
% (parziale); flag = 0 == l'indice di asimmetria (imparziale)     
% kurtos = kurtosis(x, flag); % flag = 1 (default) == l'indice di curtosi 
% (parziale); flag = 0 == l'indice di curtosi (imparziale)        
end