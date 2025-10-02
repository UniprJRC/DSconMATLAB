% Le prime 10 righe sono generate tramite il Copilot
modalita = ["Licenza media", "Secondaria superiore", "Laurea", "Dottorato"];
c = repmat(modalita, 1, 3); % Ripete le modalità per ottenere almeno 12 elementi
c = c(1:10); % Seleziona solo i primi 10 elementi

% Visualizzare l'array di stringhe
disp(c)


%% Esempio del libro
% categorical con elenco delle modalitè e Ordinal true
cat=categorical(c,modalita,'Ordinal',true);
[min(cat) max(cat)]

% categorical senza elenco delle modalità e Ordinal false
cat=categorical(c);
categories(cat)

% categorical senza elenco delle modalità e Ordinal true
cat=categorical(c,'Ordinal',true);
[min(cat) max(cat)]


%% La parte di seguito è per approfondimenti

%% Creazione vettore categorico (senza secondo argomento di input)
cat=categorical(c);
% L'ordine con cui vengono presentate le modalità è quello alfabetico
disp(tabulate(cat))


%% Creazione vettore categorico (con secondo argomento di input)
cat=categorical(c,modalita);
% L'ordine con cui vengono presentate le modalità è quello 
% del secondo argomento di input di categorical
disp(tabulate(cat))


%% Creazione vettore categorico ordinale

cat=categorical(c,'Ordinal',true);
disp('Vettore cat con modalità non ordinate, min e max sono')
[min(cat) max(cat)]

% con secondo argomento di input e 'Ordinal',true
cat=categorical(c,modalita,'Ordinal',true);
disp('Vettore cat con modalità ordinate, min e max sono')
[min(cat) max(cat)]

%% Funzione categories mostra le modalità
categories(cat)

%% Non posso aggiungere una modalità non prevista
% Ad esempio 
% cat(2)="nnn"
% non funzione

%% Per aggiungere una modalità se la variabile è categorica ordinale
newcat=addcats(cat,"nnn","Before","Licenza media");
disp(categories(newcat))


%%
modalita = ["Licenza media", "Secondaria superiore", "Laurea", "Dottorato"];


% Creare un array di stringhe di lunghezza 10
c = repmat(modalita, 1, 3); % Ripetere le modalità per ottenere almeno 12 elementi
c = c(1:10); % Selezionare solo i primi 10 elementi

