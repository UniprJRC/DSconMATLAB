% Preambolo (non nel libro)
S=[1 3; 3 15];
[V,D]=eig(S);
% I due vettori v1 e v2 derivano dalle due colonne della matrice V

% Osservazione: come scritto nell'help della funzione quiver MATLAB
% aggiusta in automatico la lunghezza dei vettori. Per evitare il rescaling
% automatico bisogna specificare 'off' come ultimo argomento di quiver

%% Esempio di vettori ortogonali
a=0.9796;
b=0.2011;
v1=[a;b];
v2=[b;-a];
% Modo 1: disegno il primo vettore
quiver(0,0,a,b)
% hold('on') per fare in modo che il grafico successivo si sovrapponga al
% grafico precedente
hold('on')
% disegno il secondo vettore
quiver(0,0,b,-a)

%% Modo 2: un'unica chiamata a quiver
% Creo una nuova figura
figure
zer=zeros(2,1);
quiver(zer,zer,v1,v2)

% La funzione acosd ritorna la funzione inversa del coseno in gradi
theta=acosd(v1'*v2);
disp(['L''angolo tra i due vettori è ' num2str(theta) ' gradi'])
% m1=coefficiente angolare della retta che passa
% attraverso il primo vettore
m1=v1(2)/v1(1);
% m2=coefficiente angolare della retta che passa
% attraverso il secondo vettore
m2=v2(2)/v2(1);
% Verifico che m1=-1/m2
disp(['m1=' num2str(m1) '=-1/m2=' num2str(-1/m2)])


%% Esempio di vettori ortogonali (opzione 'off')  NON E' NEL TESTO
a=0.9796;
b=0.2011;
v1=[a;b];
v2=[b;-a];
% Modo 1: disegno il primo vettore
quiver(0,0,a,b,'off')
% hold('on') per fare in modo che il grafico successivo si sovrapponga al
% grafico precedente
hold('on')
% disegno il secondo vettore
quiver(0,0,b,-a,'off')

%% Modo 2: un'unica chiamata a quiver (opzione 'off')  NON E' NEL TESTO
% Creo una nuova figura
figure
zer=zeros(2,1);
quiver(zer,zer,v1,v2,'off')

% La funzione acosd ritorna la funzione inversa del coseno in gradi
theta=acosd(v1'*v2);
disp(['L''angolo tra i due vettori è ' num2str(theta) ' gradi'])
% m1=coefficiente angolare della retta che passa
% attraverso il primo vettore
m1=v1(2)/v1(1);
% m2=coefficiente angolare della retta che passa
% attraverso il secondo vettore
m2=v2(2)/v2(1);
% Verifico che m1=-1/m2
disp(['m1=' num2str(m1) '=-1/m2=' num2str(-1/m2)])


%% Coeff. di corr. lineare come prodotto scalare diviso prodotto delle norme
% n e p a piacere
rng(1)
n=100;
p=5;
X=randn(n,p);
Xtilde=X-mean(X);

% La riga di seguito implmenta l'ultima equazione di p. 347
disp("rij calcolato come prodotto scalare diviso prodotto delle nome")
i=2;
j=3;
rij=Xtilde(:,i)'*Xtilde(:,j)/(norm(Xtilde(:,i))*norm(Xtilde(:,j)));
