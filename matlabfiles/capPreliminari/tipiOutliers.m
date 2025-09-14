%%Tipi di outliers, scatter + boxplot bivariato sui dati
rng(20); n=200; x=unifrnd(-20,80,n,1);
a=2; %intercetta della vera retta 
b=15; % pendenza della vera retta
sig=100; 
y=a+b*x+sig*randn(n,1);
A=[40 0]; B=[-70 5]; C=[-80 2000];
xout=max(x)+70; D=[xout, a+b*xout];  
ExtraPoints=[A;B;C;D]; 
X=[x,y];           
Xadd=[X;ExtraPoints];
scatterboxplot(Xadd(:,1),Xadd(:,2))
lab=["A" "B" "C" "D"]; 
text(ExtraPoints(:,1)+3,ExtraPoints(:,2),lab)
% print -depsc figs\tipiOutliers.eps;

%% Aggiungiamo il boxplot bivariato
plots=struct;
plots.labeladd='';
boxplotb(Xadd,'plots',plots)
% print -depsc figs\tipiOutliers.eps;


%% Chiamata alla funzione FSR per identificare in automatico i valori anomali
out=FSR(Xadd(:,2),Xadd(:,1));
disp('Unità dichiarate anomale in base alla regressione robusta')
disp(out.outliers)
% Aggiungo al grafico la retta di regressione robusta
refline(out.beta(2),out.beta(1))


%% La parte di seguito non è stata inserita nel libro
% print -depsc figs\tipiOutliersFSR.eps;

%  %% Confronto tra retta robusta e retta basata su tutti i punti
% scatter(Xadd(:,1),Xadd(:,2))
% h1 = lsline();
% h1.Color = 'r';
%  out=FSR(Xadd(:,2),Xadd(:,1),'plots',0);
%  refline(out.beta(2),out.beta(1))
% legend({'Retta non robusta' 'Retta robusta'})
