%% See also HW1 for the manual implementation of the first steps
% of hierarchical clustering

%% Metodo del legame completo (tutto automatizzato)
d=[0.31 0.23 0.32 0.26 0.25 0.34 0.21 0.36 0.28 0.31 0.04 0.07 0.31 0.28 0.09];
names=["1=San Pellegrino" "2=Panna" "3=Rocchetta" "4=Vera"  "5=Levissima" 
    "6=Fiuggi"];
out=linkage(d,'complete');
dendrogram(out,'Labels',names);
%     print -depsc figs\dendroINI.eps;

%% Metodo del legame medio (tutto automatizzato) (Es. 14.2)
d=[0.31 0.23 0.32 0.26 0.25 0.34 0.21 0.36 0.28 0.31 0.04 0.07 0.31 0.28 0.09];
names=["1=San Pellegrino" "2=Panna" "3=Rocchetta" "4=Vera"  "5=Levissima" "6=Fiuggi"];
out=linkage(d,'average');
dendrogram(out,'Labels',names,'Orientation','left');
%     print -depsc figs\dendroINI1.eps;

