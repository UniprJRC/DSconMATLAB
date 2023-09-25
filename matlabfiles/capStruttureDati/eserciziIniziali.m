%% Esercizio 1.1
d = 3;
class(d)
size(d)

c = 'Buongiorno a tutti';
class(c)
size(c)

s = "Saluti amico";
class(s)
size(s)

%% Esercizio 1.2

on = [0 1 2];

vn = [0; 1; 2];

mn = [0 1 2; 3 4 5];

nd = [1:2:15];   % Si noti che la parentesi quadra non è necessaria

%% Esercizio 1.3

ot = ["John" "Doe"];

vt = ["John"; "Doe"];

%% Esercizio 1.4
cm=  {1,2,3; "Buongiorno a tutti", rand(3,2),[11; 22; 33]};

%% Esercizio 1.5
st = struct;
st.a = 1;
st.b = 2;
st.c = 3;
st.d = "Buongiorno a tutti";
st.e = rand(3,2);
st.f = [11; 22; 33];

%% 1.5.1 Creazione di una tabella
data = ["P0211", "BASILICO", "TIZIANA",  "F", "16-Jun-1991", "A", 1877, 27, 10, 11;
    "P0212", "BONINO", "PAOLO", "M", "01-Jul-1993", "B", 2375,  35, 12, 8];
Firm = array2table(data,"VariableNames",["Code" "Surname" "Name"  "Gender"  "BirthDate" "Education"  "Wage"   "CommutingTime" "SmartWorkHours" "Seniority"]);

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

%% 1.6.1 Salvataggio dei risultati ottenuti
cm = {1,2,3; "Buongiorno a tutti", rand(3,2),[11; 22; 33]};
save('myCell.mat', 'cm');


data = [110.63, 3.7; 736871, 12157];

Summary = array2table(data,"VariableNames",["Acquisti in euro", "Numero visite"], "RowNames", ["Media mensile", "Totale mensile"]);

% Salvataggio della matrice "data" in ".txt" e in ".xlsx":
writematrix(data,'data.txt','Delimiter','tab');
writematrix(data,'data.xlsx');

% Salvataggio della tabella "Summary" in ".txt" e in ".xlsx":
writetable(Summary,'Summary.txt','Delimiter','tab','WriteRowNames',true);
writetable(Summary,'Summary.xlsx','WriteRowNames',true);

%% Esercizio 1.8
subset1 = Firm(Firm.Gender == "F", :);

subset2 = Firm(Firm.Gender == "F" & Firm.Education == "B", :);

subset3 = Firm((Firm.Gender == "F" & Firm.Education == "B") | (Firm.Gender == "M" & Firm.Wage > 4000), :);

subset4 = Firm(Firm.Wage >= 3000 &  Firm.Wage < 3500, :);
