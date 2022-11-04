% Tabella di contingenza di partenza
N=[20, 40, 20; 10, 45 45; 0, 5, 15];

% Estrai il numero di righe e di colonne della tabella di input N
[I,J] = size(N);
% Inizializzo C e D 
C=0;
D=0;
for i=1:I-1
    for j=1:J
        % coppie concordanti solo quando j<J
        if j<J
            xsel=N(i+1:I,j+1:J);
            C=C+N(i,j)*sum(xsel(:));
        end
        % coppie discordanti solo quando j>1
        if j>1
            xsel=N(i+1:I,1:j-1);
            D=D+N(i,j)*sum(xsel(:));
        end
    end
end

% Indice gamma
gamma = (C - D)/(C + D);
disp(['Indice gamma= ' num2str(gamma)])