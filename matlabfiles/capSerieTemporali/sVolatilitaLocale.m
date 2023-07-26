url     = 'https://fred.stlouisfed.org/';
d       = fetch(fred(url),'SP500')
vret    =  price2ret(d.Data(:,2));                            % serie mensile
vdates  = datetime(datestr(d.Data(2:end,1)));      % serie di date
TT      = timetable(vdates,vret);                 % creiamo la timetable
gfc = figure();
cn = length(vret);   % num
 
%
g = figure('Name','SP500 rendimenti giornalieli')
plot(vdates, vret, LineWidth=1);   
set(gca,'TickLabelInterpreter','latex');
xlabel('t', Interpreter='latex')
ylabel(' ','Interpreter','latex',Rotation=90)
grid on; box on;
exportgraphics(g,'gSP500ret.pdf')
vind = ismissing(vret);
vret(vind) = []; 
vdates(vind) = [];
vy = log((vret).^2+0.00001)
cn = length(vy);   % num
%% Estensione della serie con h previsioni mediante trend lineare adattato alle prime e ultime cm  osservazioni
chmax = 40;   
cm = 30; 
vy0   = flip(vy(1:cm)); mX0 = (1:cm)'; 
vy0f  = mean(vy(1:cm))*ones(chmax,1); 
 
vy1f  = mean(vy(end-cm:end))*ones(chmax,1); 
vyext = [vy0f; vy; vy1f];
plot(vyext)
%%
 
% vyf = filter(vw_t, 1, vyext )
% vyhat = vyf(2*ch+1:end);
% plot(t, [vy, vyhat])

chmin = 3; 
vCVscore = NaN(chmax-chmin,1)
for h = chmin:chmax
    vyext = [vy0f(end-h+1:end); vy; vy1f(1:h)];
    vh = (-h:h)'
    vw_t = (1-(abs(vh)/h).^3).^3; vw_t = vw_t/(sum(vw_t));
    dw0  = vw_t(h+1);
    vyf = filter(vw_t, 1, vyext );
    vyhat = vyf(2*h+1:end);
    plot(vdates, [vy, vyhat]); hold on;
    vCVscore(h-chmin+1) = sum((vy(chmax+1:cn-chmax)-vyhat(chmax+1:cn-chmax)).^2)/((1-dw0)^2)
end

  