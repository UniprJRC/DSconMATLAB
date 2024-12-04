x025=norminv(0.025)
% Il primo argomento di normspec  è l'intervallo. Gli argomenti due e tre
% sono rispettivamente la media e la standard deviation della v.c. normale.
% Il quarto argomento è un character contenente 'inside' o 'outside' a
% seconda che la regione da colorare sia interna o esterna all'intervallo
% specificato.
p = normspec([x025 -x025],0,1,'outside') 
% print -depsc normspecFIG.eps;
