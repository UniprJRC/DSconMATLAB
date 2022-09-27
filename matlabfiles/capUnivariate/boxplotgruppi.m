miofile="Firm.xlsx"; % Caricamento file Firm.xlsx dentro MATLAB 
X=readtable(miofile,"ReadRowNames",true);

subplot(1,2,1)
boxplot(X.Wage)
% add2boxplot accetta in input anche la table
add2boxplot(X(:,"Wage"))
subplot(1,2,2)
boxplot(X.Wage,X.Gender)
add2boxplot(X(:,"Wage"),X.Gender)
% print -depsc boxplotMF.eps;

%% Modo alternativo (non inserito nel libro)
miofile="Firm.xlsx"; % Caricamento file Firm.xlsx dentro MATLAB 
X=readtable(miofile,"ReadRowNames",true);
nomeVariabile="CommutingTime"; % CommutingTime
subplot(1,2,1)
boxplot(X{:,nomeVariabile})
% add2boxplot accetta in input anche la table
add2boxplot(X(:,nomeVariabile))
subplot(1,2,2)
boxplot(X{:,nomeVariabile},X.Gender)
add2boxplot(X(:,nomeVariabile),X.Gender)
% L'istruzione sgtitle inserisce un title
% sopra la griglia dei subplots
sgtitle(nomeVariabile)


%% Confronto dei quantili della retribuzione
% boo = vettore booleano che contiene true in corrispondenza
% dei maschi
boo=strcmp(X.Gender,'M');

% Un modo alternativo per creare questo vettore 
% booleano era
% boo=categorical(X.Gender)=="M";

% quan= quantili richiesi
quan=0.1:0.05:0.9;
% Calcolo i quantili separatamente per M e F
qM=quantile(X.Wage(boo),quan);
qF=quantile(X.Wage(~boo),quan);
% Confronto i quantili
plot(quan,qM,'r--',quan,qF,'b-o')
legend(["Maschi" "Femmine"],'Location','best')
% print -depsc boxplotQUANT.eps;




