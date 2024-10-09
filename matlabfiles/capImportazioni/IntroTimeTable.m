%% Caricamento del contenuto del file Firm.xlsx come timetable
TT=readtimetable('Firm.xlsx');
head(TT,3)

%% Caricamento del contenuto del file Firm.xlsx come time e passaggio a timetable
Xt=readtable('Firm.xlsx');
TT=table2timetable(Xt);

%% Estrazione di record (primo criterio)
sel=timerange('1996-12-05','1998-06-01');
TT(sel,:)

%% Parte non nel libro
sel=timerange('-inf','1998-06-01');
% significa tutte le date prima del primo giugno 1998

%% Parte non nel lbro
% le due date da inserire dentro timerange invece di essere definite come
% due characters potevano essere introdotte tramite datetime(Y,M,D)
sel=timerange(datetime(1996,12,05),datetime(1998,06,01));
TT(sel,:)


%% Estrazione di record (secondo criterio)
sel2=timerange('1999','2001','years');
TT(sel2,:)


%% Estrazione di un intervallo di date con unità di misura i mesi
timerange(datetime(2022,15,1),datetime(2023,11,4),'months')


%% Estrazione di record (esercizio 4.4)

% booleano per gli anni richiesti
anni=TT.Properties.RowTimes.Year >=1995 &  TT.Properties.RowTimes.Year  <=1999;
% booleano per i mesi richiesti
mesi= TT.Properties.RowTimes.Month>=3 & TT.Properties.RowTimes.Month<=4; 
% booleano per i giorni richiesti
giorni=TT.Properties.RowTimes.Day >=20;
% I tre criteri vengono combinati tramite operatore logico and
disp(TT(anni & mesi & giorni,1:4))


%% Ulteriori esempi con timerange (PARTE NON INSERITA NEL TESTO) 

% Es. di data passata come stringa con formato riconosciuto
TR      = timerange("2016-01-01","2022-12-31")

% Es. di data passata come stringa con formato non riconosciuto
% Dato che il formato "01-01-2016" non viene riconosciuto
% occorre convertire la stringa con datetime
TR      = timerange(datetime("01-01-2016","InputFormat","dd-MM-yyyy"), ...
    datetime("31-12-2022","InputFormat","dd-MM-yyyy"))

% Esempio di stringa contentente data non univoca
% In questo caso MATLAB fornisce uno warning
% Le date sono ambigue. MATLAB assume che il formato si MM/dd/uuuu
% ma avverte che il formato potrebbe anche essere 'dd/MM/uuuu'
TR=timerange("02/01/2016","11/12/2022");


%% Esempio di stringa ambigua
% La data è il primo di febbraio del 2016 oppure
% il due di gennaio del 2016?
stringaContenenteData="01/02/2016";
disp('Data non chiara')
disp(stringaContenenteData)
disp('Conversione con il formato "dd/MM/yyyy"')
ini1=datetime(stringaContenenteData,'InputFormat',"dd/MM/yyyy");
disp(ini1)
disp('Conversione con il formato "MM/dd/yyyy"')
ini2=datetime(stringaContenenteData,'InputFormat',"MM/dd/yyyy");
disp(ini2)

%% Osservazione 
% Nei numeri passati a datetime  con il formato t = datetime(Y,M,D)
% nell'help di datetime si dice che "If an element of the Y, M, D, falls
% outside the conventional range, then datetime adjusts both that element
% and the same element of the previous input."

% Questo significa che è possibile (ad esempio) nel secondo argomento 
% scrivere un valore maggiore di 12
Y=2022;
M=16;
D=3;
disp(['Y=' num2str(Y) ' M=' num2str(M) ' D=' num2str(D)])
disp([' La sintassi datetime(2022,16,3) ' ...
    'corrisponde al 3 di aprile 2023'])
disp(datetime(Y,M,D))

% Similmente posso scrivere per D un numero maggiore di 31. 
% Ad esempio, datetime(2023,2,50) corrisponde al 22-Mar-2023