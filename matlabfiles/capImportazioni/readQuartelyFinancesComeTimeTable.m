%% File di corredo all'Esercizio 4.5

miofile="quarterlyFinances1999To2019.csv";
TT=readtimetable(miofile,"StartTime",datetime(1999,1,1), ...
    "TimeStep",calquarters,'TrimNonNumeric',true);
head(TT(:,1:3),4)


%% Parte non presente nel libro
% StartTime poteva anche essere definito come character
TT1=readtimetable(miofile,"StartTime",'01/01/1999', ...
    "TimeStep",calquarters,'TrimNonNumeric',true);
head(TT1(:,1:3),4)