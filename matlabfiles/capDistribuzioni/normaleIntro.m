%% Dati di input
x=(-9:0.1:9)';
media=3;
varianza=4;

sigma=sqrt(varianza);

% Calcolo della densità tramite la funzione normpdf
ypdf=normpdf(x,media,sigma);
% Implementazione manuale della densità
ypdfCHK = exp(-0.5 * ((x - media)./sigma).^2) ./ (sqrt(2*pi) .* sigma);
disp('Controllo uguaglianza delle due implementazioni ')
assert(max(abs(ypdf-ypdfCHK))<1e-10,['Errore implementazione ' ...
    'manuale della densità'])

% Rappresentazione grafica
subplot(2,1,1)
plot(x,ypdf);

medias=num2str(media);
vars=num2str(varianza);
title(['Funzione di densità: N('  medias ',' vars ')'])
ylabel('f(x)')

subplot(2,1,2)
ycdf=normcdf(x,media,sigma);
plot(x,ycdf);
title(['Funzione di ripartizione: N('  medias ',' vars ')'])
ylabel('F(x)=Pr(X<x)')

% print -depsc figs\normintro.eps;
% print -depsc figs\disttool.eps;

%% La parte di seguito non è nel testo
close all
% Rappresetazione grafica tramite comet
subplot(2,1,1)
comet(x,ypdf);

title(['Funzione di densità: N('  medias ',' vars ')'])
ylabel('f(x)')

subplot(2,1,2)
comet(x,ycdf);
title(['Funzione di ripartizione: N('  medias ',' vars ')'])
ylabel('F(x)=Pr(X<x)')

