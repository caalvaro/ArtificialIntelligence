% -------- questão 1 ---------
%  Faça um programa Prolog que dadas duas listas L1 e L2, retorne a lista L3 que é a união de L1 e L2. Note que nesta união não pode haver elementos repetidos.

% regra de apoio para fazer concatenação de listas
conc([], L, L).
conc([X | L1], L2, [X | L3]) :- conc(L1, L2, L3).

% regra de apoio para testar se um elemento pertence a uma lista
includes(X, LIST) :-
    conc(_, [ X | _ ], LIST). % uma lista possui um elemento se eu posso concatenar uma lista qualquer com uma lista que começa por esse elemento, obtendo a lista original.

% regra de apoio para remover elementos repetidos de uma lista
removeRepetidos([],[]). % uma lista vazia não tem elementos repetidos
removeRepetidos([X], [X]). % uma lista com um só elemento não tem elementos repetidos

removeRepetidos([HEAD|TAIL], RESULTADO) :- % caso em que HEAD não aparece no Tail da lista
    removeRepetidos(TAIL, R1),
    not(includes(HEAD,TAIL)), % testa se H não pertence à lista
    conc([HEAD], R1, RESULTADO). % só adciona H se ele não aparece no Tail da lista

removeRepetidos([_|TAIL], RESULTADO) :-  % caso contrário, só ignora o elemento repetido e continua a execução
    removeRepetidos(TAIL, RESULTADO).

% regra principal para fazer a união
union(L1, L2, RESULTADO) :-
    removeRepetidos(L1, R1), % remove os elementos repetidos da lista 1
    removeRepetidos(L2, R2), % remove os elementos repetidos da lista 2
    union2(R1, R2, RESULTADO). % faz a união entre as listas

union2(L1, [], L1). % uma lista unida com a vazia é ela mesma
union2([], L2, L2). % uma lista unida com a vazia é ela mesma

union2(L1, [HEAD2|TAIL2], RESULTADO) :- % caso em que HEAD2 não está em L1
    union2(L1, TAIL2, R1),
    not(includes(HEAD2, L1)),
    conc(R1, [HEAD2], RESULTADO). % só adiciona no resultado se HEAD2 não estiver em L1

union2(L1, [_|TAIL2], RESULTADO) :- % se já estiver na lista 1, só ignora e continua a execução
    union2(L1, TAIL2, RESULTADO).




% -------- questão 2 ---------
% Faça um programa Prolog que dadas duas listas L1 e L2, retorne a lista L3 que contém todos os elementos de L2 que não estão em L1. Você deve usar not.
% a lógica é identica à da união, exceto pelo caso base

listDifference(_, [], []). % a diferença entre uma lista vazia e qualquer outra vai ser uma lista vazia
listDifference([], L2, L2). % a diferença entre uma lista e uma lista vazia é a própria lista

listDifference(L1, [HEAD2|TAIL2], RESULTADO) :- % caso em que HEAD2 não está em L1
    listDifference(L1, TAIL2, R1),
    not(includes(HEAD2, L1)),
    conc([HEAD2], R1, RESULTADO). % só adiciona no resultado se HEAD2 não estiver em L1

listDifference(L1, [_|TAIL2], RESULTADO) :- % se já estiver na lista 1, só ignora e continua a execução
    listDifference(L1, TAIL2, RESULTADO).

