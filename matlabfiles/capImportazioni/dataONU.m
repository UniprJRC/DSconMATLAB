X=readtable("dataONU.xlsx");
ch=split(X{:,1},"_");
datstr=string(ch(:,1))+string(ch(:,3));
rowtim=datetime(datstr,'Inputformat','yyyyMMddHHmm')+minutes(30);
TT=table2timetable(X(:,2:4),'RowTimes',rowtim);

TTchk=readtimetable("dataONU.xlsx",'StartTime',datetime(2002,1,2,0,30,0), ...
    'TimeStep',hours,'Range','B1:D8761');

stackedplot(TT(:,1:2))
% stackedplot(,'')
% 
% cellfun(@x x(a:b)
