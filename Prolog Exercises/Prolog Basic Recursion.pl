/*Questão 1*/

soma(0,0). % fato que define que a soma de zero números é zero
soma(X,Y) :- X > 0, Z is X - 1, soma(Z,W), Y is X + W. % testamos se o número fornecido é maior que zero para evitar números negativos. depois decrementamos X para usar como parâmetro da recursão. Chamamos a soma recursivamente que vai empilhar até o zero e retornar o valor de W, depois usamos o valor de W para fazer a soma de 0 até X


/*Questão 2*/

fatorial(0,1).
fatorial(X,Y) :- X > 0, Z is X - 1, fatorial(Z,W), Y is X * W. % funciona da mesma forma que a anterior, mas trocando a operação por multiplicação e o fato pelo fatorial de zero por 1


/*Questão 3*/

fibo(1,0). % define o fibonacci de 1 como 0
fibo(2,1). % define o fibonacci de 2 como 1
fibo(X,Y) :-
    X > 1,        % evitar números negativos
    Z is X - 1,   % atribui ao Z o número anterior
    V is X - 2,   % atribui ao V o anterior do anterior
    fibo(Z,Z1),   % chama recursivamente até atribuir a Z1 o fibonacci de X - 1
    fibo(V,V2),   % chama recursivamente até atribuir a V2 o fibonacci de X - 2
    Y is Z1 + V2. % retorna como Y a soma do fibonacci de X-1 com X-2

