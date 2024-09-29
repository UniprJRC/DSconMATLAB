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
% Estrazione dei valori di Wage tramite {}
miofile="Firm.xlsx"; % Caricamento file Firm.xlsx dentro MATLAB
X=readtable(miofile,"ReadRowNames",true);
nomeVariabile="Wage";
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

%% violinplot (solo versione 2024b)
% Questa cell viene eseguita se si ha a disposizione MATLAB relsease almeno
% R2024b
if isMATLABReleaseOlderThan("R2024b") ==false

    % Estrazione dei valori di Wage tramite {}
    miofile="Firm.xlsx"; % Caricamento file Firm.xlsx dentro MATLAB
    X=readtable(miofile,"ReadRowNames",true);
    nomeVariabile="Wage";
    xsel=X{:,nomeVariabile};
    % se withpoints è true nel grafico a violino vengono aggiunti i punti
    % relativi alle osservazioni
    withpoints=true;
    subplot(1,2,1)
    violinplot(xsel)
    
    if withpoints==true
        hold('on')
        one=ones(size(X,1),1);
        scatter(one,xsel)
    end

    subplot(1,2,2)
    violinplot(categorical(X.Gender),xsel)
    
    if withpoints==true
        hold('on')
        % Osservazione: dato che quando trasformo la variabile in
        % categorica le modalità sono inserite in ordine alfabetico, il
        % primo violinplot si riferisce alla modalità F
        boo=X.Gender=="F";
        % punti relativi alle donne
        scatter(one(boo,1),xsel(boo))
        % punti relativi agli uomini
        scatter(2*one(~boo,1),xsel(~boo))
    end
    % L'istruzione sgtitle inserisce un title
    % sopra la griglia dei subplots
    sgtitle(nomeVariabile)
end

%% Confronto dei quantili della retribuzione
% boo = vettore booleano che contiene true in corrispondenza
% dei maschi
boo=strcmp(X.Gender,'M');

% Un modo alternativo per creare questo vettore
% booleano era
% boo=categorical(X.Gender)=="M";

% quan= quantili richiesti
quan=0.1:0.05:0.9;
% Calcolo i quantili separatamente per M e F
qM=quantile(X.Wage(boo),quan);
qF=quantile(X.Wage(~boo),quan);
% Confronto i quantili
plot(quan,qM,'r--',quan,qF,'b-o')
legend(["Maschi" "Femmine"],'Location','best')
% print -depsc boxplotQUANT.eps;




