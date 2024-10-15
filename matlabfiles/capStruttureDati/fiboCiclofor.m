% Inizializzo n (numeri di elementi della sequenza di Fibonacci) 
% ed il vettore f che conterrà i numeri della sequenza di
% Fibonacci
n=10;
f=zeros(1,n);
% I primi due valori della sequenza di Fibonacci sono 0 e 1
f(1)=0;
f(2)=1;
%
for i = 3:n
    f(i) = f(i-1) + f(i-2);
end
disp(f)