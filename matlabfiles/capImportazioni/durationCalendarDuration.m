% dt = data iniziale
dt = datetime(2025,1,31);
dt.Format = 'eeee, MMMM d, yyyy HH:mm:ss';
disp('Data iniziale')
disp(dt)
disp("Usando duration (aggiunta di 30 giorni esatti):");
disp(dt + duration(30*24,0,0));
disp("Usando calendarDuration (aggiunta di un mese di calendario):");
disp(dt + calmonths(1));

%% Aggiungo 1 anno e due mesi
cd = calendarDuration(1, 2, 0);
disp(dt+cd)