% Stelle
load citiesItaly.mat
X=citiesItaly{:,:};
sel=[1:3 5];
X(:,sel)=-X(:,sel); % cambio di segno addedval, deposit, pension, export
glyphplot(X,'obslabels',citiesItaly.Properties.RowNames)

%% Facce
load citiesItaly.mat
X=citiesItaly{:,:};
sel=[4 6 7];
X(:,sel)=-X(:,sel); % cambio di segno unemploy, bankrup, billsoverd
glyphplot(X,'obslabels',citiesItaly.Properties.RowNames,'glyph','face')


