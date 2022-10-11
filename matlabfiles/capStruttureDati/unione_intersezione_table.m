%% Unione dei record di due table
load('Tinter.mat')
ds1=Tinter.ds1;
ds2=Tinter.ds2;
dsu=[ds1;ds2];
disp(unique(dsu))

%% Unione delle colonne di due table  (stesso numero di righe)
clear
load Tjoin
Tleft=Tjoin.Tleft;
Tright=Tjoin.Tright;
TunioneColonne=[Tleft Tright(:,2:end)];
disp(TunioneColonne)
%% Unione delle colonne di due table  (diverso numero di righe)
% Funzioni innerjoin e outerjoin
Tleft(3:7,:)=[];
innerjoin(Tleft,Tright,'LeftKeys',1,'RightKeys',1)
outerjoin(Tleft,Tright,'LeftKeys',1,'RightKeys',1)

%% Unione colonne (le tabelle hanno solo alcuni identificatori comuni)
clear
load Tjoin
Tleft=Tjoin.Tleft;
Tright=Tjoin.Tright;
Tleft(3:7,:)=[];
Tright([1 8],:)=[];
iij=innerjoin(Tleft,Tright,'LeftKeys',1,'RightKeys',1);
disp(iij)

uoj=outerjoin(Tleft,Tright,'LeftKeys',1,'RightKeys',1);
disp(uoj)

