%% Parametri di input
mu = [1;2];
Sigma = [0.8 0.7;0.7 1.3];
% Si costruisce la griglia (tutte le combinazioni di coordinate x e y)
seqx=-3:0.05:4;
seqy=-2:0.05:6;
% Costruzione della griglia tramite meshgrid
[X,Y] = meshgrid(seqx,seqy);
% const = fattore che precede la parte exp
const = (1/sqrt(2*pi))^2/sqrt(det(Sigma));
% Si calcola la densità per ogni punto della griglia
xtilde = [X(:)-mu(1) Y(:)-mu(2)];
pdfVector = const*exp(-0.5*diag(xtilde*(Sigma\(xtilde'))));
% pdfVector è un vettore colonna di lunghezza length(seqx)-by-length(seqy)
% che viene trasformato in una matrice di dimensioni size(X)
pdf = reshape(pdfVector,size(X));

% surfc consente di visualizzare anche le curve di equidensità
surfc(X, Y, pdf, 'LineStyle', 'none');

title('Densità normale bivariata')
xlabel('$X$', 'Interpreter', 'latex')
ylabel('$Y$', 'Interpreter', 'latex')
% Angolo visuale che consente di visualizzare
% anche i contorni di equidensità
view([38 -39]);

% print -depsc figs\bivnormMatr.eps;
