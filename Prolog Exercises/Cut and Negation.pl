% -------- quest�o 1 ---------
%  Fa�a um programa Prolog que dadas duas listas L1 e L2, retorne a lista L3 que � a uni�o de L1 e L2. Note que nesta uni�o n�o pode haver elementos repetidos.

% regra de apoio para fazer concatena��o de listas
conc([], L, L).
conc([X | L1], L2, [X | L3]) :- conc(L1, L2, L3).

% regra de apoio para testar se um elemento pertence a uma lista
includes(X, LIST) :-
    conc(_, [ X | _ ], LIST). % uma lista possui um elemento se eu posso concatenar uma lista qualquer com uma lista que come�a por esse elemento, obtendo a lista original.

% regra de apoio para remover elementos repetidos de uma lista
removeRepetidos([],[]). % uma lista vazia n�o tem elementos repetidos
removeRepetidos([X], [X]). % uma lista com um s� elemento n�o tem elementos repetidos

removeRepetidos([HEAD|TAIL], RESULTADO) :- % caso em que HEAD n�o aparece no Tail da lista
    removeRepetidos(TAIL, R1),
    not(includes(HEAD,TAIL)), % testa se H n�o pertence � lista
    conc([HEAD], R1, RESULTADO). % s� adciona H se ele n�o aparece no Tail da lista

removeRepetidos([_|TAIL], RESULTADO) :-  % caso contr�rio, s� ignora o elemento repetido e continua a execu��o
    removeRepetidos(TAIL, RESULTADO).

% regra principal para fazer a uni�o
union(L1, L2, RESULTADO) :-
    removeRepetidos(L1, R1), % remove os elementos repetidos da lista 1
    removeRepetidos(L2, R2), % remove os elementos repetidos da lista 2
    union2(R1, R2, RESULTADO). % faz a uni�o entre as listas

union2(L1, [], L1). % uma lista unida com a vazia � ela mesma
union2([], L2, L2). % uma lista unida com a vazia � ela mesma

union2(L1, [HEAD2|TAIL2], RESULTADO) :- % caso em que HEAD2 n�o est� em L1
    union2(L1, TAIL2, R1),
    not(includes(HEAD2, L1)),
    conc(R1, [HEAD2], RESULTADO). % s� adiciona no resultado se HEAD2 n�o estiver em L1

union2(L1, [_|TAIL2], RESULTADO) :- % se j� estiver na lista 1, s� ignora e continua a execu��o
    union2(L1, TAIL2, RESULTADO).




% -------- quest�o 2 ---------
% Fa�a um programa Prolog que dadas duas listas L1 e L2, retorne a lista L3 que cont�m todos os elementos de L2 que n�o est�o em L1. Voc� deve usar not.
% a l�gica � identica � da uni�o, exceto pelo caso base

listDifference(_, [], []). % a diferen�a entre uma lista vazia e qualquer outra vai ser uma lista vazia
listDifference([], L2, L2). % a diferen�a entre uma lista e uma lista vazia � a pr�pria lista

listDifference(L1, [HEAD2|TAIL2], RESULTADO) :- % caso em que HEAD2 n�o est� em L1
    listDifference(L1, TAIL2, R1),
    not(includes(HEAD2, L1)),
    conc([HEAD2], R1, RESULTADO). % s� adiciona no resultado se HEAD2 n�o estiver em L1

listDifference(L1, [_|TAIL2], RESULTADO) :- % se j� estiver na lista 1, s� ignora e continua a execu��o
    listDifference(L1, TAIL2, RESULTADO).

