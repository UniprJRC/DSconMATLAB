%% Esercizio
% Rappresentare i tre vettori della base canonica
% Costruire il cubo
close all
X=eye(3);
  zer=zeros(3,1);
quiver3(zer,zer,zer,X(:,1),X(:,2),X(:,3),'off','LineWidth',2)
% Mostrare il cubo di lato unitario
[x,y,z] = meshgrid([0;1],[0;1],[0;1]);
% Con le istruzioni che seguono x, y e z vengono trasformati in vettori
% colonna
x=x(:);
y=y(:);
z=z(:);
% XX=matrice che contiene le coordinate degli spigoli del cubo
XX=[x,y,z];
[TriIdx, vol] = convhull(XX(:,1),XX(:,2),XX(:,3));
% vol è il volumne
disp(['Volume del cubo unitario=' num2str(vol)])
% trisurf = grafico di superfici definite su griglie triangolari
hold('on')
trisurf(TriIdx, XX(:,1),XX(:,2),XX(:,3),'FaceAlpha',0)
axis equal


%% 
X=[-1.0542    2.7479   -0.5810
    -1.3661   -0.2187    1.4443
     3.2015    1.9302    3.3204];
close all
  zer=zeros(3,1);
quiver3(zer,zer,zer,X(:,1),X(:,2),X(:,3),'off','LineWidth',2)
hold('on')
strpoints="("+string(X(:,1))+","+string(X(:,2))+","+string(X(:,3))+")";
textscatter3(X(:,1),X(:,2),X(:,3),strpoints);
axis equal
%% 

% close all
figure
[U,Gam,V]=svd(X,'econ');
Y=X*V;

% 
[x,y,z] = meshgrid([0;1],[0;1],[0;1]);
x=x(:)*Gam(1,1);
y=y(:)*Gam(2,2);
z=z(:)*Gam(3,3);
XX=[x,y,z];
XX=XX*V';
[TriIdx, vol] = convhull(XX(:,1),XX(:,2),XX(:,3));
disp("Calcolo numerico del volume")
disp(vol)

% trisurf = grafico di superfici definite su griglie triangolari
trisurf(TriIdx, XX(:,1),XX(:,2),XX(:,3),'FaceAlpha',0)
hold('on')
  zer=zeros(3,1);
quiver3(zer,zer,zer,X(:,1),X(:,2),X(:,3),'off','LineWidth',2)
axis equal
%% Parallelepipedo ruotato
% close all
figure
XX=[x,y,z];
X2=XX(:,1);
Y2=XX(:,2);
Z2=XX(:,3);
[TriIdx, vol] = convhull(X2,Y2,Z2);
% trisurf = grafico di superfici definite su griglie triangolari
trisurf(TriIdx, X2, Y2, Z2,'FaceAlpha',0)
hold('on')
  zer=zeros(3,1);
  Xv=X*V;
quiver3(zer,zer,zer,Xv(:,1),Xv(:,2),Xv(:,3),'off','LineWidth',2)
% view(gca,[41.1475141015367 51.1570094916719]);
axis equal
% %% 
% X=[0 0 0;X;sum(X)];
% [k,vol]=convhull(X(:,1),X(:,2),X(:,3))
% 
% [TriIdx, V] = convhull(X,Y,Z)
% trisurf(TriIdx, X, Y, Z)
% 
% %% 
% A=[2 4 5;
%    3 1 2;
%    4 8 2];
% 
% a=alphaShape(A(:,1),A(:,2),A(:,3))
% 
% 
% clear all
% N = 100;
% x = linspace(0,1,N);
% y = linspace(0,1,N);
% Z = peaks(N)
% [X,Y] = meshgrid(x,y);
% [TriIdx, V] = convhull(X,Y,Z)
% trisurf(TriIdx, X, Y, Z)
% 
% 
% P = [0 0 0; 1 1 1; 1.5 0.5 2; 1.5 -0.5 2; 1.25 0.3 1; 1 0 1; 1.25 -0.3 1; 1 -1 1];
% [k,av] = convhull(P);
% trisurf(a,X(:),Y(:),Z(:),'FaceColor','cyan')
%      
% %% test
% x=[1 3 6];
% y=[2 1 4];
% z=[3 2 5];
% A=[x;y;z]
% [X,Y,Z] = meshgrid(x,y,z);
% [TriIdx,b]=convhull(X(:),Y(:),Z(:))
% trisurf(TriIdx, X(:),Y(:),Z(:),'FaceAlpha',0)
% 
% %% 
% close all
% k=0.1;
%  A=[1 3 4;
%     2 4 5;
%     6 8 2];
%   A=[0 0 1;
%      2 4 5;
%      6 8 2];
% 
%  a1=A(1,:);
%  a2=A(2,:);
%  a3=A(3,:);
% %  a1=A(:,1);
% %   a2=A(:,2);
% %   a3=A(:,3);
%  
% % [x,y,z] = meshgrid([min(a1):k:max(a1)],[min(a2):k:max(a2)],[min(a3):k:max(a3)]);
% [x,y,z] = meshgrid([0:k:max(a1)],[0:k:max(a2)],[0:k:max(a3)]);
% [x,y,z] = meshgrid(a1,a2,a3);
% [x,y,z] = meshgrid([0 1],[0 1],[0 1]);
% 
% center=0;
% x = 3*x(:)+center;
% y = 2*y(:)+center;
% z = 5*z(:)+center;
% % 26
% rot=true;
% if rot==true
% rng(27)
%  S=cov(randn(20,3));
%  [V,La]=eig(S);
% 
%  XX=[x y z]*V; % +[2 4 6];
%  x=XX(:,1);
%  y=XX(:,2);
%  z=XX(:,3);
% end
% [k1,av1] = convhull(x,y,z,'Simplify',true);
% 
% trisurf(k1,x,y,z,'FaceColor','cyan','FaceAlpha',0)
% hold('on')
% % quiver3(0,0,0,a1(3),a1(2),a1(3))
% % quiver3(0,0,0,3,0,0,'off')
% axis equal
% 
% XX=(diag([3 2 5])*V)
% zer=zeros(3,1);
% quiver3(zer,zer,zer,XX(:,1),XX(:,2),XX(:,3),'off','LineWidth',2)
% 
% %%
% [U,Gam,V1]=svd(XX,'econ');
% U'*XX*V1;
% 
% 
% %%
% n1=3;
% All=[A; a1+a2; a1+a3; a2+a3; a1+a2+a3];
% quiver3(zeros(n1,1),zeros(n1,1),zeros(n1,1),a1',a2',a3','off')
% hold('on')
% quiver3(0,0,0,3,0,0,'off')
