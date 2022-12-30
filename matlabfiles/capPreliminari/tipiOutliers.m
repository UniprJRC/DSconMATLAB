close all
rng(20)
n=200;
% Valori x generati da U(-20,80)
x=unifrnd(-20,80,n,1);
a=2; %intercetta della vera retta
b=15; % pendenza della vera retta
sig=100;
% ai punti della retta viene aggiunto un disturbo
% casuale normale con varianza sig^2
y=a+b*x+sig*randn(n,1);
A=[40 0];
B=[-70 5];
xout=max(x)+70;
C=[xout, a+b*xout];
D=[-80 2000];
X=[x,y];
ExtraPoints=[A;B;C;D];
Xadd=[X;ExtraPoints];
scatterboxplot(Xadd(:,1),Xadd(:,2))
lab=["A" "B" "C" "D"];
text(ExtraPoints(:,1)+3,ExtraPoints(:,2),lab)
% print -depsc figs\tipiOutliers.eps;


%% Boxplot bivariato sui dati
% Al diagramma di dispersione precedente viene aggiunto il boxplot
% bivariato
close all
rng(20)
n=200;
% Valori x generati da U(-20,80)
x=unifrnd(-20,80,n,1);
a=2; %intercetta della vera retta
b=15; % pendenza della vera retta
sig=100;
% ai punti della retta viene aggiunto un disturbo
% casuale normale con varianza sig^2
y=a+b*x+sig*randn(n,1);
A=[40 0];
B=[-70 5];
C=[-80 2000];
D=[xout, a+b*xout];
xout=max(x)+70;
X=[x,y];
ExtraPoints=[A;B;C;D];
Xadd=[X;ExtraPoints];
scatterboxplot(Xadd(:,1),Xadd(:,2))

lab=["A" "B" "C" "D"];
text(ExtraPoints(:,1)+3,ExtraPoints(:,2),lab)
% Aggiungiamo il boxplot bivariato
plots=struct;
% L'istruzione che segue per evitare che boxplotb aggiunga
% i numeri delle righe associati agli outliers.
plots.labeladd='';
% Nelle due righe seguono (non presenti nel testo) posso modificare il
% colore della parte interna (hinge, che corrisponde alla scatola del
% boxplot univariato) o della parte esterna (fence, che corrisponde ai
% baffi (whiskers) del boxplot univariato.
% plots.InnerColor='r';
% plots.OuterColor='c';
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
