% Predicado unário que representa o objetivo de colocar 2L na jarra 1.
objetivo((2,_)).

% Predicado auxiliar que retorna o menor operando.
min(X, Y, Z) :- X =< Y, Z is X.
min(X, Y, Z) :- Y < X, Z is Y.

% Predicado auxiliar que retorna o maior operando.
max(X, Y, Z) :- X >= Y, Z is X.
max(X, Y, Z) :- Y > X, Z is Y.

% ações possíveis neste programa.
acao((J1,J2), encher1, (4,J2)):- J1 < 4.

acao((J1,J2), encher2, (J1,3)):- J2 < 3.

acao((J1,J2), esvaziar1, (0,J2)):- J1 > 0.

acao((J1,J2), esvaziar2, (J1,0)):- J2 > 0.

acao((J1,J2), passar12, (X, Y)) :- 
    max(J1 - (3 - J2), 0, X),
    min(J2 + J1, 3, Y).

acao((J1,J2), passar21, (X, Y)) :- 
    max(J1 - (4 - J2), 0, Y),
    min(J2 + J1, 4, X).

% Retorna todos os estados possíveis a partir do estado N e das ações definidas anteriormente.
vizinho(N, FilhosN) :- findall(X, acao(N, _, X), FilhosN).

includes(X, LIST) :-
    append(_, [ X | _ ], LIST).

listDifference(_, [], []). % a diferença entre uma lista vazia e qualquer outra vai ser uma lista vazia
listDifference([], L2, L2). % a diferença entre uma lista e uma lista vazia é a própria lista

listDifference(L1, [HEAD2|TAIL2], RESULTADO) :- % caso em que HEAD2 não está em L1
    listDifference(L1, TAIL2, R1),
    not(includes(HEAD2, L1)),
    append([HEAD2], R1, RESULTADO). % só adiciona no resultado se HEAD2 não estiver em L1

listDifference(L1, [_|TAIL2], RESULTADO) :- % se já estiver na lista 1, só ignora e continua a execução
    listDifference(L1, TAIL2, RESULTADO).

% Adiciona os nós vizinhos ao final da fila.
adiciona_fronteira(NN, F1, F2) :- append(F1, NN, F2).
%
busca_largura1([Node | _], _, LAUX2, L) :- objetivo(Node), append(LAUX2, [Node], L).

busca_largura1([Node | F1], LAUX, LAUX2, L) :- 
    vizinho(Node, VIZINHOS), % Recupera os filhos de Node.
    append([Node], LAUX, VISITADOS), % Adiciona o Node à lista de visitados.
    listDifference(VISITADOS, VIZINHOS, NAO_VISITADOS), % Verifica se os filhos desse estado já foram visitados em um outro momento.
    adiciona_fronteira(NAO_VISITADOS, F1, F2), % Adiciona à fila de execução apenas os filhos não vizitados.
    append(NAO_VISITADOS, VISITADOS, V1), % Considera os filhos não visitados, que ja entraram para a fila de execução, como visitados para a próxima iteração.
    append(LAUX2, [Node], L3), % Guarda o estado analizado em uma lista auxiliar.
    busca_largura1(F2, V1, L3, L).

busca_largura(L1, L2) :-
    busca_largura1(L1, [], [], L2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Adiciona os nós vizinhos no inicio da fila.
adiciona_fronteira_p(NN, F1, F2) :- append(NN, F1, F2).

busca_profundidade1([Node | _], _, LAUX2, L) :- objetivo(Node), append(LAUX2, [Node], L).

busca_profundidade1([Node | F1], LAUX, LAUX2, L) :- 
    vizinho(Node, VIZINHOS),
    append([Node], LAUX, VISITADOS),
    listDifference(VISITADOS, VIZINHOS, NAO_VISITADOS),
    adiciona_fronteira_p(NAO_VISITADOS, F1, F2),
    append(NAO_VISITADOS, VISITADOS, V1), 
    append(LAUX2, [Node], L3),
    busca_profundidade1(F2, V1, L3, L).

busca_profundidade(L1, L2) :-
    busca_profundidade1(L1, [], [], L2).


