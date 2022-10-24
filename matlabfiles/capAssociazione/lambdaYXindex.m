N=[150 80 20 50;
   80 250 30 140;
  30 50 0 120];
% n=numerosità del campione
n = sum(N(:));

% ndotj= vettore riga che contiene le somme di colonna
ndotj=sum(N,1);

% ndotjmax = massimo delle somme di colonna
ndotjmax=max(ndotj);

% sumnimax= sommatoria delle max freq di ogni riga
sumnimax=sum(max(N,[],2));

% Goodman and Kruskal lambda
lambdaYX=(sumnimax-ndotjmax)/(n-ndotjmax);
disp(['Indice lambdaYX=' num2str(lambdaYX)])