% Osservazione: Si veda l'help di peaks per la documentazione

% Mesh (reticolato)
mesh(peaks)

%% Mesh con i contorni sotto
meshc(peaks)

%% Contorni
contour(peaks)

%% Superficie sfumata 3D
surf(peaks)

%% 
[x,y]=meshgrid(-4:0.1:4)
z=x.^2-y.^2;
mesh(x,y,z)

%% Mesh con i contorni sotto
meshc(x,y,z)

%% Contorni
contour(x,y,z)

%% Superficie sfumata 3D
surf(x,y,z)
