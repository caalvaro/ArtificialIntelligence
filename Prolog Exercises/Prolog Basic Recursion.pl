/*Quest�o 1*/

soma(0,0). % fato que define que a soma de zero n�meros � zero
soma(X,Y) :- X > 0, Z is X - 1, soma(Z,W), Y is X + W. % testamos se o n�mero fornecido � maior que zero para evitar n�meros negativos. depois decrementamos X para usar como par�metro da recurs�o. Chamamos a soma recursivamente que vai empilhar at� o zero e retornar o valor de W, depois usamos o valor de W para fazer a soma de 0 at� X


/*Quest�o 2*/

fatorial(0,1).
fatorial(X,Y) :- X > 0, Z is X - 1, fatorial(Z,W), Y is X * W. % funciona da mesma forma que a anterior, mas trocando a opera��o por multiplica��o e o fato pelo fatorial de zero por 1


/*Quest�o 3*/

fibo(1,0). % define o fibonacci de 1 como 0
fibo(2,1). % define o fibonacci de 2 como 1
fibo(X,Y) :-
    X > 1,        % evitar n�meros negativos
    Z is X - 1,   % atribui ao Z o n�mero anterior
    V is X - 2,   % atribui ao V o anterior do anterior
    fibo(Z,Z1),   % chama recursivamente at� atribuir a Z1 o fibonacci de X - 1
    fibo(V,V2),   % chama recursivamente at� atribuir a V2 o fibonacci de X - 2
    Y is Z1 + V2. % retorna como Y a soma do fibonacci de X-1 com X-2

