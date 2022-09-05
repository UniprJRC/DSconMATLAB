INDICE

1 Introduzione all’utilizzo di MATLAB e alla gestione dei dati 19
1.1 L’interfaccia di MATLAB . . . . . . . . . . . . . . . . . . . . . 19
1.2 L’esecuzione del codice . . . . . . . . . . . . . . . . . . . . . . . 22
1.3 Classi di dati . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
1.4 Gli array . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
1.4.1 Creazione dei diversi tipi di array . . . . . . . . . . . . . 27
1.4.2 Estrazione dei dati da un array . . . . . . . . . . . . . . 31
1.5 Le tabelle . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
1.5.1 Creazione di una tabella . . . . . . . . . . . . . . . . . . 33
1.5.2 Importazione di una tabella . . . . . . . . . . . . . . . . 34
1.5.3 Estrazione dei dati da una tabella . . . . . . . . . . . . 36
1.6 Gestione dei dati . . . . . . . . . . . . . . . . . . . . . . . . . . 39
1.6.1 Salvataggio dei risultati ottenuti . . . . . . . . . . . . . 39
1.6.2 Estrazione dei dati in base a dei criteri . . . . . . . . . . 41
1.6.3 Intersezione di due table con le stesse variabili . . . . . 42
1.6.4 Unione e intersezione di due table . . . . . . . . . . . . 43
1.7 Introduzione alla generazione di numeri casuali . . . . . . . . . 48
1.8 Elementi di base di programmazione . . . . . . . . . . . . . . . 49
1.8.1 Le istruzioni if e i cicli . . . . . . . . . . . . . . . . . . . 49
1.8.2 L’istruzione assert . . . . . . . . . . . . . . . . . . . . . 53
1.8.3 Alcune costanti speciali . . . . . . . . . . . . . . . . . . 53
2 Algebra lineare di base 57
2.1 Operazioni elementari con le matrici . . . . . . . . . . . . . . . 57
2.2 Le matrici diagonali . . . . . . . . . . . . . . . . . . . . . . . . 60
2.3 Alcune matrici particolari . . . . . . . . . . . . . . . . . . . . . 63
2.4 Le matrici idempotenti . . . . . . . . . . . . . . . . . . . . . . . 65
2.5 Le matrici ortogonali . . . . . . . . . . . . . . . . . . . . . . . 65
2.6 Moltiplicazione di matrici trasposte . . . . . . . . . . . . . . . . 66
2.7 Moltiplicazione di matrici inverse . . . . . . . . . . . . . . . . . 67
2.8 La trasposta dell’inversa . . . . . . . . . . . . . . . . . . . . . . 68
2.9 Sistemi di equazioni lineari . . . . . . . . . . . . . . . . . . . . 69
2.10 La traccia . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
2.11 L’espansione implicita . . . . . . . . . . . . . . . . . . . . . . . 72
2.12 Matrice degli scostamenti standardizzati tramite espressioni matriciali
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76
3 La matrice dei dati e le analisi univariate 81
3.1 Analisi univariate di variabili categoriche . . . . . . . . . . . . . 83
3.2 Analisi univariate di variabili quantitative . . . . . . . . . . . . 86
3.3 Grafici univariati per dati categorici o quantitativi . . . . . . . 89
3.4 Le distribuzioni di frequenze di variabili quantitative . . . . . . 95
3.5 Analisi univariate di variabili quantitative in presenza di sottogruppi
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 98
3.6 Intervalli di confidenza e riepiloghi avanzati . . . . . . . . . . . 104
4 Variabili casuali: densità e distribuzioni 109
4.1 La variabile Gaussiana o normale . . . . . . . . . . . . . . . . . 109
4.2 La variabile aleatoria Uniforme . . . . . . . . . . . . . . . . . . 123
4.3 La variabile aleatoria chi quadrato . . . . . . . . . . . . . . . . 125
4.4 La variabile aleatoria T di Student . . . . . . . . . . . . . . . . 130
4.5 La distribuzione normale bivariata . . . . . . . . . . . . . . . . 134
4.6 La distribuzione uniforme discreta . . . . . . . . . . . . . . . . 142

5 I trattamenti preliminari dei dati 145
5.1 I dati mancanti e strategie per il loro trattamento . . . . . . . . 145
5.2 I valori anomali e le strategie per il loro trattamento . . . . . . 148
5.3 Analisi automatica dei missing e dei valori anomali univariati . 154
5.4 Operazioni avanzate con i missing values . . . . . . . . . . . . . 157
6 La relazione tra le variabili quantitative: correlazione e cograduazione
161
6.1 La matrice di covarianze e la matrice di correlazione . . . . . . 165
6.2 La significatività della correlazione . . . . . . . . . . . . . . . . 170
6.3 L’indice di cograduazione di Spearman . . . . . . . . . . . . . 177
6.3.1 La cograduzione in presenza di gradi ripetuti . . . . . . 177
6.4 La relazione tra gli indici di correlazione e cograduazione . . . . 182
6.5 La correlazione e la cograduazione in presenza di missing values 183
7 L’associazione 187
7.1 Introduzione . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 187
7.2 Indici di associazione per le tabelle 2 × 2 . . . . . . . . . . . . 187
7.2.1 Misure basate sulla statistica di Pearson . . . . . . . . 191
7.2.2 Misure basate sul rapporto dei prodotti incrociati . . . . 195
7.3 Indici di associazione per le tabelle I × J . . . . . . . . . . . . 198
7.4 Indici di associazione basati sulla riduzione dell’errore . . . . . 202
7.5 Indici di associazione basati sulla riduzione dell’eterogeneità . . 205
7.6 Indici di associazione per variabili ordinali . . . . . . . . . . . . 209
8 Le rappresentazioni grafiche 215
8.1 Rappresentazioni grafiche per serie storiche univariate . . . . . 215
8.2 I grafici a cascata . . . . . . . . . . . . . . . . . . . . . . . . . . 217
8.3 Rappresentazioni grafiche per serie storiche bivariate . . . . . . 219
8.4 I grafici ad imbuto . . . . . . . . . . . . . . . . . . . . . . . . . 221
8.5 Grafici per la stima della densità univariata . . . . . . . . . . . 221
8.6 Grafici a dispersione personalizzati . . . . . . . . . . . . . . . . 227
8.7 Grafici a dispersione con istogrammi o boxplot ai margini . . . 229
8.8 Grafici con istogrammi bivariati . . . . . . . . . . . . . . . . . . 233
8.9 Grafici esplorativi per l’analisi di regressione . . . . . . . . . . . 234
8.10 Grafici a tre dimensioni . . . . . . . . . . . . . . . . . . . . . . 239
8.11 Il balloonplot . . . . . . . . . . . . . . . . . . . . . . . . . . . . 242
8.12 La matrice dei diagrammi di dispersione . . . . . . . . . . . . . 244
8.12.1 La matrice dei diagrammi di dispersione con variabile di
raggruppamento . . . . . . . . . . . . . . . . . . . . . . 248
