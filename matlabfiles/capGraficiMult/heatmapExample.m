%% X= mm di pioggia negli ultimi 21 anni 
X=[255	167	123	65	41
244	196	89	52	12
268	198	119	46	20
321	179	88	31	11
413	152	51	31	4
432 137 42 15 4
567 63 14 7 0
550	63	24	8	6
454	114	39	16	7
337	165	81	44	24
238	162	110	65	55
263	176	113	64	35];
rowNam=["Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"];
colNam=["<0.1" "0.1-4.0" "4.1-10.0" "10.1-20.0" ">20.0"];
% se X è una matrice numerica i vettori contenenti le etichette  
% dei due assi vanno inseriti come primi due argomenti di input
heatmap(colNam,rowNam,X)

% print -depsc heatmapMAT.eps;

%% Caricamento dei dati in memoria
clear % clear iniziale della memoria
load("Rend.mat") % caricamento del file Rend.mat.

% Vettore che contiene le etichette delle classi
etichette=["<=-0.05"; "(-0.05,-0.03]"; "(-0.03,-0.02]"; "(-0.02,-0.01]"; ...
    "(-0.01,0.0]"; "(0.0,0.01]"; "(0.01,0.02]"; "(0.02,0.03]";...
    "(0.03,0.05]"; ">0.05"];

titsel=["ENI" "ASSICURAZIONIGENERALI" "FINECOBANKSPA" "FERRARI_MIL_"];
Rsel=Rt{:,titsel}; % Rsel array di doubles 

% Nella matrice dei rendimenti dobbiamo quindi rimpiazzare ogni singolo
% rendimento con l'etichetta relativa alla classe di appartenenza.
% Ad esempio il
% rendimento -0.045 deve essere rimpiazzato con  "(-0.05,-0.03]",  in quanto
% -0.045 appartiene a questa classe. Similmente il rendimento 0.06 deve
% essere rimpiazzato con ">0.05" in quanto 0.06 appartiene a questa classe.
%

% MamtriceEti = si inizializza  una matrice di stringhe che ha la stessa
% dimensione di Rsel. Si utilizza il carattere "0" per inizializare la
% matrice anche se poteva utilizzare qualsiasi altro carattere. Questa
% matrice di stringhe andrà a contenere nella colonna j la classe di
% appartenenza di ciascun rendimento del titolo j (j=1,...,4)
MatriceEti=string(zeros(size(Rsel)));

% classi vettore da passare a histcounts
classi=[-Inf, -0.05 -0.03:0.01:0.03 0.05 +Inf];

for j=1:4
    [~,~,bin]=histcounts(Rsel(:,j),classi);
    % etibin è il vettore che contiene l'informazione sulla classe di
    % appartenenza di ogni rendimento. Il vettore etibin viene inserito
    % nella j-esima colonna della matrice MatriceEti
    etibin=etichette(bin);
    MatriceEti(:,j)=etibin;
end

disp("Prime 5 righe di MatriceEti")
disp(MatriceEti(1:5,:))

% L'istruzione categorical di seguito serve a specificare qual è
% l'ordine delle etichette da utilizzare 
MatriceEtic=categorical(MatriceEti,etichette,'Ordinal',true);

Nt=array2table(MatriceEtic,"VariableNames",titsel);

i=2; % Variabile da insere nelle righe della heatmap
j=3; % Variabile da insere nelle colonne della heatmap
heatmap(Nt,i,j)

% print -depsc heatmapTAB.eps;


% %% Heatmap passando dalla tabella di contingenza 
% i=1;
% j=2;
% % Costruire la tabella di contingenza tra i vettori che contengono la
% % classe di appartenenza di ogni rendimento.
% [N,~,~,lab]=crosstab(MatriceEtic(:,i),MatriceEtic(:,j));
% 
% Ntable=array2table(N,'RowNames',lab(:,1),'VariableNames',lab(:,2));
% 
% % Rappresetazione grafica
% % heatmap tra le classi di rendimento del titolo i e del titolo j
% figure
% 
% heatmap(lab(:,1),lab(:,2),N)
% xlabel(titsel(i))
% ylabel(titsel(j))
% title(["Heatmap tra classi di rendimento tra i titoli " titsel(i) " e "  titsel(j)])