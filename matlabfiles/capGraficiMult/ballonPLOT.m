N=[156	14	2	4;
    124	20	5	4;
    77	11	7	13;
    82	36	15	7;
    53	11	1	57;
    32	24	4	53;
    33	23	9	55;
    12	46	23	15;
    10	51	75	3;
    13	13	21	66;
    8	1	53	77;
    0	3	160	2;
    0	1	6	153];
rowslab={'Laundry' 'Main-meal' 'Dinner' 'Breakfeast' 'Tidying' 'Dishes' ...
    'Shopping' 'Official' 'Driving' 'Finances' 'Insurance'...
    'Repairs' 'Holidays'};
colslab={'Wife'	'Alternating'	'Husband'	'Jointly'};
tableN=array2table(N,'VariableNames',colslab,'RowNames',rowslab);
% In this case a table is supplied
balloonplot(tableN);

% print -depsc balloonPLOT.eps;