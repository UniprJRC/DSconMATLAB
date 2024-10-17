% Inizializzo n (numeri di elementi della sequenza di Fibonacci) 
% ed il vettore f che conterrà i numeri della sequenza di
% Fibonacci
n=10;
f=zeros(1,n);
% I primi due valori della sequenza di Fibonacci sono 0 e 1
f(1)=0;
f(2)=1;
i=3;
while i <=n
    f(i) = f(i-1) + f(i-2);
    i=i+1;
end
disp(f)