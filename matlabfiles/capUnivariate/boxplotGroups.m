%% File loading

myfile="Firm.xlsx"; % Load the file Firm.xlsx into MATLAB
X = readtable(myfile,"ReadRowNames",true);

%% Boxplot by gender and education (using boxplot function)
close all
SesTit = string(X.Gender) + string(X.Education);
SesTitc = categorical(SesTit, unique(SesTit));
boxplot(X.Wage, SesTitc);
ylabel('Wage')
% print -depsc boxplotFMABC.eps;

%% Boxplot by gender and education (using boxchart function)
figure
boxchart(categorical(X.Gender), X.Wage, 'GroupByColor', X.Education);
ylabel('Wage')
% Add legend to the chart
legend
% print -depsc boxchartFMABC.eps;

%% Violin plot by gender and education (using violinplot function)
figure
violinplot(categorical(X.Gender), X.Wage, 'GroupByColor', X.Education);
ylabel('Wage')
% Add legend to the chart
legend(categories(categorical(X.Education)))
% Note: legend without specifying the categories does not work

%% From version 2025a: violinplot with table (not in the book)
X.Gender = categorical(X.Gender);
X.Education = categorical(X.Education);
X.SesTitc = SesTitc;
figure
violinplot(X, "SesTitc", "Wage")

% with horizontal orientation
figure
violinplot(X, "SesTitc", "Wage", 'Orientation', 'horizontal')


% Gender and Education side by side
figure
violinplot(X, ["Gender" "Education"], "Wage")

%% Example of violin plot with internal points
variableName = "Wage";
xsel = X{:, variableName};
% if withpoints is true, points corresponding to the observations are
% added to the violin plot
withpoints = true;
subplot(1,2,1)
violinplot(xsel)

if withpoints == true
    hold('on')
    one = ones(size(X,1),1);
    scatter(one, xsel)
end

subplot(1,2,2)
violinplot(categorical(X.Gender), xsel)

if withpoints == true
    hold('on')
    % Note: when transforming the variable into categorical, the categories
    % are inserted in alphabetical order, so the first violinplot refers to category F
    boo = X.Gender == "F";
    % points for females
    scatter(one(boo,1), xsel(boo))
    % points for males
    scatter(2*one(~boo,1), xsel(~boo))
end
% The sgtitle command inserts a title above the subplot grid
sgtitle(variableName)

