%% Parametri di input
mu = [1 2];  Sigma = [0.8 0.7;0.7 1.3];
% Si costruisce la griglia (tutte le combinazioni di coordinate x e y)
seqx=-3:0.05:4; lx=length(seqx);
seqy=-2:0.05:6; ly=length(seqy);
% Costruzione della griglia tramite meshgrid
[X,Y] = meshgrid(seqx,seqy); % X e Y hanno dimensione ly-by-lx
% const = fattore che precede la parte exp
const = (1/sqrt(2*pi))^2/sqrt(det(Sigma));
% Si calcola la densità per ogni punto della griglia
% xtilde =ly*lx-by-2
xtilde = [X(:)-mu(1) Y(:)-mu(2)]; 
formQuad=diag(xtilde*(Sigma\(xtilde')));
formQuadMatrix=reshape(formQuad,ly,lx);
% pdf contiene la densità
pdf = const*exp(-0.5*formQuadMatrix);

% surfc consente di visualizzare anche le curve di equidensità
surfc(X, Y, pdf, 'LineStyle', 'none');
title('Densità normale bivariata')
xlabel('$x$', 'Interpreter', 'latex','FontSize',14); 
ylabel('$y$', 'Interpreter', 'latex','FontSize',14); 
view([38 -39]);

%% Countours of ellipses
figure
contour(X,Y,formQuadMatrix,[0.1 1 2:2:14],'ShowText','on')
xline(mu(1),'--'); yline(mu(2),'--') 
xlabel('$x_1$','Interpreter','latex','FontSize',14);
ylabel('$x_2$','Interpreter','latex','FontSize',14);
colorbar
%% 
figure
Q=zeros(lx,ly);
SigmaInv = inv(Sigma);

for i=1:lx
    for j=1:ly
        x=[seqx(i) seqy(j)]-mu;
        Q(i,j)=x*SigmaInv*x';
    end
end
contour(X,Y,Q',[0.1 1 2:2:14],'ShowText','on')

% contour poteva anche essere chiamato come
% contour(seqx,seqy,Q',[0.1 1 2:2:14],'ShowText','on')

xline(mu(1),'--'); yline(mu(2),'--') 
fs=14; xlabel('$x_1$','Interpreter','latex','FontSize',fs); 
ylabel('$x_2$','Interpreter','latex','FontSize',fs);
colorbar
assert(max(abs(formQuadMatrix-Q'),[],"all")<1e-12,"Errore nelle due implementazioni")

