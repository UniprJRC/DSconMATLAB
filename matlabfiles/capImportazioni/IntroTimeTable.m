%% Caricamento del contenuto del file Firm.xlsx come timetable
TT=readtimetable('Firm.xlsx');
head(TT,3)

%% Caricamento del contenuto del file Firm.xlsx come time e passaggio a timetable
Xt=readtable('Firm.xlsx');
TT=table2timetable(Xt);

%% Estrazione di record (primo criterio)
sel=timerange('1996-12-05','1998-06-01');
TT(sel,:)

%% Estrazione di record (secondo criterio)
sel2=timerange('1999','2001','years');
TT(sel2,:)


%% Estrazione di un intervallo di date con unità di misura i mesi
timerange(datetime(2022,5,1),datetime(2023,11,4),'months')

%% Estrazione di record (esercizio 4.4)

% booleano per gli anni richiesti
anni=TT.Properties.RowTimes.Year >=1995 &  TT.Properties.RowTimes.Year  <=1999;
% booleano per i mesi richiesti
mesi= TT.Properties.RowTimes.Month>=3 & TT.Properties.RowTimes.Month<=4; 
% booleano per i giorni richiesti
giorni=TT.Properties.RowTimes.Day >=20;
% I tre criteri vengono combinati tramite operatore logico and
disp(TT(anni & mesi & giorni,1:4))