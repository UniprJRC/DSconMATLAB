close all
clear
X=[1.7 3.5; 1 5; -2 2.5; 5 1 ];
[n,p]=size(X);
zern=zeros(n,1);
zerp=zeros(p,1);
% Etichette dei punti A, B, C, ....
labx=char((('A'+0):('A'+n-1))');

% NON NEL LIBRO: un modo alternativo per ottenere il char array 4x1 era
% labx=('A':'D')'


% lwd = Linewidth delle frecce associate agli assi
lwd=2;
% coloriginalaxis = colore degli assi originali
coloriginalaxis='r';
% colnewaxis = colore dei nuovi assi cartesiani
colnewaxis='k';

% fsize = FontSize delle label degli assi
fsize=14;
% kk = scalare che determina la lunghezza degli assi cartesiani
kk=5;

% base canonica (matrice identità)
E=eye(p);

%% Pannello in alto a sinistra: punti nello spazio originale
nr=2; nc=2;
subplot(nr,nc,1)
% quiver(zern,zern,X(:,1),X(:,2) traccia le frecce da 0,0 ai punti X(:,1) e
% X(:,2). Il terzo argomento di quiver settato su 'off' serve per fare in
% modo che la lunghezza delle frecce non venga riscalata in automatico.
quiver(zern,zern,X(:,1),X(:,2),'off')
textOrigCoo=labx+"=("+string(num2str(X(:,1),3))+...
    ","+string(num2str(X(:,2),3))+")";
% Gli spazi vuoti dentro textOrigCoo vengono eliminati
textOrigCoo=strrep(textOrigCoo," ","");
text(X(:,1),X(:,2),textOrigCoo,'HorizontalAlignment',...
    'left','Color',coloriginalaxis)
hold('on')
% Assi cartesiani base canonica
quiver(zerp,zerp,kk*E(:,1),kk*E(:,2),'off',...
    'LineWidth',lwd,'Color',coloriginalaxis)
% label degli assi della base canonica
labaxis=["e_1";"e_2"];
text(kk*E(:,1),kk*E(:,2),labaxis,'HorizontalAlignment','left','Color',...
    coloriginalaxis,'FontSize',fsize)
% scala uguale nei due assi
axis equal

%% Pannello in alto a destra: vettori nella nuova base 
% e coordinate dei punti nella nuova base
subplot(nr,nc,2)
quiver(zern,zern,X(:,1),X(:,2),'off')
% Nuova base
V=[ 0.5156   -0.8569;  0.8569    0.5156];
hold('on')
Vtra=V';
% Nuovi assi cartesiani ortogonali v_1 v_2
quiver(zerp,zerp,kk*Vtra(:,1),kk*Vtra(:,2), ...
    'off','LineWidth',lwd,'Color',colnewaxis)
% label degli assi
labnewaxis=["v_1";"v_2"];
text(kk*Vtra(:,1),kk*Vtra(:,2),labnewaxis,...
    'HorizontalAlignment','left', 'Color',colnewaxis,'FontSize',fsize)

% Y=X*V=Coordinate dei punti nel nuovo riferimento 
% ortogonale V(:,1), V(:,2)
Y=X*V;
textNewCoo=labx+"=("+ string(num2str(Y(:,1),3)) + ...
    "," + string(num2str(Y(:,2),3))+")";
textNewCoo=strrep(textNewCoo," ","");
% L'istruzione di seguito inserisce l'indicazione delle coordinate dei
% punti nel nuovo sistema di riferimento (le etichette vengono plottate in
% corrispondenza di X(:,1) e X(:,2) ossia delle vecchie coordinate)
text(X(:,1),X(:,2),textNewCoo,'Color',colnewaxis)
axis equal

%% Pannello in basso: vettori nella nuova base 
subplot(nr,nc,3:4)
quiver(zern,zern,Y(:,1),Y(:,2),'off')
hold('on')
quiver(zerp,zerp,kk*E(:,1),kk*E(:,2), ...
    'off','LineWidth',lwd,'Color',colnewaxis)

text(Y(:,1),Y(:,2),textNewCoo,'Color',colnewaxis)
text(kk*E(:,1),kk*E(:,2),labnewaxis,...
    'HorizontalAlignment','left','Color', colnewaxis,'FontSize',fsize)
axis equal

%{
%% Nel pannello in basso a destra si aggiunge una spiegazione dei vari assi
% Osservazione: questo pannello non è stato inserito nel testo
subplot(nr,nc,4);
set(gca,'XTick','','YTick','','XTickLabel','','YTickLabel','')

c = uicontrol('Style','text','Units','normalized','FontSize',13);

msg={['Pannello in alto a sinistra: coordinate dei punti nello spazio originale',...
    ' (base canonica e1 e2). Pannello in alto a destra: rappresentazione dei nuovi' ...
    ' assi cartesiani v1 v2 e coordinate dei punti nel nuovo sistema di riferimento. ' ...
    'Pannello in basso a sinistra: rappresentazione dei punti nel nuovo sistema' ...
    ' di assi cartesiani v1 v2.']};
c.String=msg;
c.Position=[0.6 0.15 0.3 0.3];
wrappedtext = textwrap(c,c.String,60);
%}

% print -depsc figs\basecan.eps;