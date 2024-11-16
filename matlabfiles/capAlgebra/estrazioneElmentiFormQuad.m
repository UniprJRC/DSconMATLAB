rng(1) % Per replicabilità dei risultati
n=10; p=6;
A=randn(n,p);

% Definizione variabili i,j
i=2; j=5;
% epre = vettore elementare e_i di lunghezza n (tutti elementi uguali a
% zero tranne quello in posizione i che risulta uguale ad 1)
epre=zeros(n,1);
epre(i)=1;
% epost = vettore elementare e_j di lunghezza p (tutti elementi uguali a
% zero tranne quello in posizione j che risulta uguale ad 1)
epost=zeros(p,1);
epost(j)=1;

disp(['Estrazione elemento (' num2str(i) ',' num2str(j) ') ' ...
    'di A in maniera matriciale'])
disp(epre'*A*epost)
disp(['Estrazione elemento (' num2str(i) ',' num2str(j) ') ' ...
    'di A tramite l''istruzione A(i,j)'])
disp(A(i,j))
                