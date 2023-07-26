url       = 'https://fred.stlouisfed.org/';
d         = fetch(fred(url),'ITACPIALLMINMEI')
ipcm      =  d.Data(:,2);                            % serie mensile
vdates    = datetime(datestr(d.Data(1:end,1)));      % serie di date
table(year(vdates), month(vdates), ipcm)             % mostra la serie per anno e mese 
TT      = timetable(vdates,ipcm)                     % creiamo la timetable
gfc = figure();
subplot(2,1,1)
plot(vdates, ipcm,'r','LineStyle',"-",LineWidth= 2); 
title('Indice dei prezzi al consumo (NIC)',"FontSize",14,"Interpreter","latex");
box("on"); grid("on");
subplot(2,1,2)
plot(vdates(13:end), 100*(ipcm(13:end)./ipcm(1:end-12)-1),'r','LineStyle',"-",LineWidth= 2);  
title('Tasso di inflazione tendenziale (base annua)',"FontSize",14,"Interpreter","latex")
box("on"); grid("on");
exportgraphics(gcf,'gIPC.pdf')
%% selezione di un intervallo di dati 
TR      = timerange("2016-01-01","2022-12-31")      % selezione della porzione della serie
TTs     = TT(TR,:)
%% Aggregazione in serie annuale 
TTA     = retime(TTs, "yearly", "mean"); 
ipc     = TTA.ipcm;                   % serie annuale
%% Inflazione su base annua e 2016
ipc_l     = log(ipc);
t_infl    = 100 * diff(ipc)./ipc(1:end-1); 
t_infl_l  = 100 * diff(ipc_l); 
t_infl_2016   = 100 * (ipc/ipc(1)-1);
t_infl_l_2016 = 100 * (ipc_l - ipc_l(1));
TTA2 = table(year(TTA.vdates), ipc, ipc_l, [NaN; t_infl], [NaN; t_infl_l],  t_infl_2016, t_infl_l_2016, ...
    'VariableNames',  {'Anno', 'ipc' 'log(ipc)', 't_infl','t_infl_l','t_infl_2016', 't_infl_l_2016'})
writetable(TTA2, 'IPC.xlsx')