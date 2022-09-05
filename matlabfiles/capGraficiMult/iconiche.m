load citiesItaly.mat
X=citiesItaly{:,:};
% cambio di segno addedval, deposit, pension, export
sel=[1:3 5];
X(:,sel)=-X(:,sel);
glyphplot(X,'obslabels',citiesItaly.Properties.RowNames)
% print -depsc stelle.eps;
%%
load citiesItaly.mat
X=citiesItaly{:,:};

% cambio di segno unemploy, bankrup, billsoverd
sel=[4 6 7];
X(:,sel)=-X(:,sel);
glyphplot(X,'obslabels',citiesItaly.Properties.RowNames,'glyph','face')
% print -depsc facce.eps;

