%% Questo file 

%% Esercizio 1.1

ono = [0 1 2];

vn = [0; 1; 2];

mn = [0 1 2; 3 4 5];

nd = 1:2:15;   

%% Esercizio 1.2

ot = ["John" "Doe"];

vt = ["John"; "Doe"];

%% Esercizio 1.3
% Imposta il seed per la generazione di numeri casuali
rng(22);

% Genera una matrice 3x2 di numeri casuali
A = rand(3, 2);

% Visualizza la matrice
disp(A);

%% 1.4 Tipologia di dati in MATLAB

disp(A>0.4)

disp('Marco'+1)

%% 1.5 Le cell

% Esercizio 1.3
cm=  {1,2,3; "Buongiorno a tutti", rand(3,2),[11; 22; 33]};

disp(cm)


C = {'Nome1', 'Nome2';
'Nome3', 'Nome4';
'Nome5', 'Nome6'};

disp(C=="Nome4")

%% 1.6 Le struct

rng(22)
% Esercizio 1.5
st = struct;
st.a = 1;
st.b = 2;
st.c = 3;
st.d = "Buongiorno a tutti";
st.e = rand(3,2);
st.f = [11; 22; 33];

disp(st)

%% 1.7 Le table
% Definire i dati per le colonne
ColonnaNumerica = (1:10)';  
ColonnaStringa = ["SRL"; "SNC"; "SPA"; "SRL"; "SNC"; ...
                  "SPA"; "SRL"; "SNC"; "SPA"; "SRL"]; 
ColonnaBooleani = [true; false; true; false; true; false; true; false; true; false];  % Terza colonna: dati booleani

% Definire i nomi delle righe (aziende)
NomiRighe = ["Azienda1"; "Azienda2"; "Azienda3"; "Azienda4"; "Azienda5"; ...
             "Azienda6"; "Azienda7"; "Azienda8"; "Azienda9"; "Azienda10"];

% Creare la tabella
T = table(ColonnaNumerica, ColonnaStringa, ColonnaBooleani, 'RowNames', NomiRighe);

% Visualizzare la tabella
disp(T);


data = [110.63, 3.7; 736871, 12157];

Summary = array2table(data,"VariableNames",["Acquisti in euro", "Numero visite"], "RowNames", ["Media mensile", "Totale mensile"]);

%% Esercizio 1.6
Firm = readtable('Firm.xlsx','Sheet','data','Range','A1:J108', 'ReadRowNames', 0);

Firm = readtable('Firm.xlsx',Sheet='data',Range='A1:J108',ReadRowNames=0)

%% Esercizio 1.7
Firm = readtable('Firm.xlsx',Sheet='data',Range='A1:J108',ReadRowNames=0)
solarray1 = Firm(1:5,7);

soltable1 = Firm.Wage(1:5);

solarray2 = Firm(1:5,[7, 10]);

soltable2 = [Firm.Wage(1:5), Firm.Seniority(1:5)];

Firm = readtable('Firm.xlsx',Sheet='data',Range='A1:J108',ReadRowNames=1)
rowP0219 =Firm('P0219',:);

rowP0219P0476 =Firm({'P0219', 'P0476'},:);

% 1.7.5 Estrazione dei dati da una table in base a criteri
subset1 = Firm(Firm.Gender == "F", :);

subset2 = Firm(Firm.Gender == "F" & Firm.Education == "B", :);

subset3 = Firm((Firm.Gender == "F" & Firm.Education == "B") | (Firm.Gender == "M" & Firm.Wage > 4000), :);

subset4 = Firm(Firm.Wage >= 3000 &  Firm.Wage < 3500, :);

Sur=Firm.Surname;
Nam=Firm.Name;

%% 1.7.4 Estrazione dei dati da una table da una table

% see file 


