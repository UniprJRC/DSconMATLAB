%% Caricamento dati
TT0  = readtimetable("FTSEMIB.MI.csv", "VariableNamingRule","modify");
TR  = timerange(datetime(2018, 1, 1), datetime(2023,6,31));
TT = rmmissing(TT0(TR, :)); 
vdates = TT.Index; 
vy     = TT.FTSEMIB_MI_Close;
%% Calcolo delle medie mobili di 50 e 150 termini
mm50  = movavg(vy,'simple',50);
mm150 = movavg(vy,'simple',150);


g = figure("Name","Medie mobili semplici")
%title('FTSEMib e serie storiche di breve-medio e lungo periodo semplici')
plot(vdates,vy,'b'); hold on; 
plot(vdates, mm50, 'r--', LineWidth=2) 
plot(vdates, mm150,'k'); hold off;
legend({'FTSE MIB' 'MM semplice 50 termini' 'MM semplice 150 termini'},'Location','best', Interpreter='latex')
set(gca,'TickLabelInterpreter','latex');
xlabel('t', Interpreter='latex')
ylabel(' ','Interpreter','latex',Rotation=90)
grid on; box on; 
exportgraphics(g,'gMedieMobili.pdf')
%% confronto con
mmf50 = filter(ones(50,1)/50,1,vy)
mm50  = movavg(vy,'simple',50, 'fill');
[mm50, mmf50]
%% Livellamento esponenziale
TT0  = readtimetable("FTSEMIB.MI.csv", "VariableNamingRule","modify");
TR  = timerange(datetime(2005, 1, 1), datetime(2023,6,31));
TT = rmmissing(TT0(TR, :)); 
vdates = TT.Index(2:end); 
vy      = diff(log(TT.FTSEMIB_MI_Close)); % rendimenti logaritmici
dlambda = 0.06
ves = filter(1, [1 -(1-dlambda)], dlambda * vy.^2, vy(1).^2);
vVaR    =  -norminv(0.05) * sqrt(ves)
vu = [1; zeros(70,1)]
vpesi = filter(1, [1 -(1-dlambda)], dlambda * vu);

% 
g = figure();
subplot(2,2,1); 
plot(vdates, vy) ;  title("Rendimenti logaritmici", Interpreter="latex");
set(gca,'TickLabelInterpreter','latex');
subplot(2,2,2); 
plot(vdates, vy.^2); hold on; 
plot(vdates, ves, LineWidth=2);  ylim([0, 0.005]); hold off;
title("Volatilit\`{a}  ", Interpreter="latex"); 
set(gca,'TickLabelInterpreter','latex');
legend({'$y_t^2$' '$\sigma_{t+1|t}^2$'},'Location','northeast', Interpreter='latex')
subplot(2,2,3); 
plot(vdates, vVaR, 'r', LineWidth=2); title("Value at Risk", Interpreter="latex");
set(gca,'TickLabelInterpreter','latex');
subplot(2,2,4);
bar(0:70, vpesi, 0.5); set(gca,'TickLabelInterpreter','latex');
title("Pesi $w_j = \lambda (1-\lambda)^j$", Interpreter="latex")
xlabel('Ritardo', Interpreter='latex')
ylabel('$w_j$ ','Interpreter','latex',Rotation=90)
grid on; box on; 
exportgraphics(g,'gVaR.pdf')
 