A=[2 4 5;
   3 1 2;
   4 8 2];

a=alphaShape(A(:,1),A(:,2),A(:,3))


clear all
N = 100;
x = linspace(0,1,N);
y = linspace(0,1,N);
Z = peaks(N)
[X,Y] = meshgrid(x,y);
[TriIdx, V] = convhull(X,Y,Z)
trisurf(TriIdx, X, Y, Z)


P = [0 0 0; 1 1 1; 1.5 0.5 2; 1.5 -0.5 2; 1.25 0.3 1; 1 0 1; 1.25 -0.3 1; 1 -1 1];
[k,av] = convhull(P);
trisurf(a,X(:),Y(:),Z(:),'FaceColor','cyan')
     
%% test
x=[1 3 6];
y=[2 1 4];
z=[3 2 5];
A=[x;y;z]
[X,Y,Z] = meshgrid(x,y,z);
[TriIdx,b]=convhull(X(:),Y(:),Z(:))
trisurf(TriIdx, X(:),Y(:),Z(:),'FaceAlpha',0)

%% 
close all
k=0.1;
 A=[1 3 4;
    2 4 5;
    6 8 2];
  A=[0 0 1;
     2 4 5;
     6 8 2];

 a1=A(1,:);
 a2=A(2,:);
 a3=A(3,:);
%  a1=A(:,1);
%   a2=A(:,2);
%   a3=A(:,3);
 
% [x,y,z] = meshgrid([min(a1):k:max(a1)],[min(a2):k:max(a2)],[min(a3):k:max(a3)]);
[x,y,z] = meshgrid([0:k:max(a1)],[0:k:max(a2)],[0:k:max(a3)]);
[x,y,z] = meshgrid(a1,a2,a3);
[x,y,z] = meshgrid([0 1],[0 1],[0 1]);

center=0;
x = 3*x(:)+center;
y = 2*y(:)+center;
z = 5*z(:)+center;
% 26
rot=true;
if rot==true
rng(27)
 S=cov(randn(20,3));
 [V,La]=eig(S);

 XX=[x y z]*V; % +[2 4 6];
 x=XX(:,1);
 y=XX(:,2);
 z=XX(:,3);
end
[k1,av1] = convhull(x,y,z,'Simplify',true);

trisurf(k1,x,y,z,'FaceColor','cyan','FaceAlpha',0)
hold('on')
% quiver3(0,0,0,a1(3),a1(2),a1(3))
% quiver3(0,0,0,3,0,0,'off')
axis equal

XX=(diag([3 2 5])*V)
zer=zeros(3,1);
quiver3(zer,zer,zer,XX(:,1),XX(:,2),XX(:,3),'off','LineWidth',2)

%%
[U,Gam,V1]=svd(XX,'econ');
U'*XX*V1;


%%
n1=3;
All=[A; a1+a2; a1+a3; a2+a3; a1+a2+a3];
quiver3(zeros(n1,1),zeros(n1,1),zeros(n1,1),a1',a2',a3','off')
hold('on')
quiver3(0,0,0,3,0,0,'off')
