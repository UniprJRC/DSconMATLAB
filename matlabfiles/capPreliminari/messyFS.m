
% opzione TreatAsMissing di readtable
X=readtable('messyFS.csv','TreatAsMissing',{'NA', 'NaN'})
% funzione standardizeMissing
X1=standardizeMissing(X,-99)

% Ulteriori informazioni sul preprocessing dei dati insieme alla recente
% app datacleaner sono alla pagina
% https://it.mathworks.com/help/matlab/preprocessing-data.html