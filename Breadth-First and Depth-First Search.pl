% Predicado un�rio que representa o objetivo de colocar 2L na jarra 1.
objetivo((2,_)).

% Predicado auxiliar que retorna o menor operando.
min(X, Y, Z) :- X =< Y, Z is X.
min(X, Y, Z) :- Y < X, Z is Y.

% Predicado auxiliar que retorna o maior operando.
max(X, Y, Z) :- X >= Y, Z is X.
max(X, Y, Z) :- Y > X, Z is Y.

% a��es poss�veis neste programa.
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

% Retorna todos os estados poss�veis a partir do estado N e das a��es definidas anteriormente.
vizinho(N, FilhosN) :- findall(X, acao(N, _, X), FilhosN).

includes(X, LIST) :-
    append(_, [ X | _ ], LIST).

listDifference(_, [], []). % a diferen�a entre uma lista vazia e qualquer outra vai ser uma lista vazia
listDifference([], L2, L2). % a diferen�a entre uma lista e uma lista vazia � a pr�pria lista

listDifference(L1, [HEAD2|TAIL2], RESULTADO) :- % caso em que HEAD2 n�o est� em L1
    listDifference(L1, TAIL2, R1),
    not(includes(HEAD2, L1)),
    append([HEAD2], R1, RESULTADO). % s� adiciona no resultado se HEAD2 n�o estiver em L1

listDifference(L1, [_|TAIL2], RESULTADO) :- % se j� estiver na lista 1, s� ignora e continua a execu��o
    listDifference(L1, TAIL2, RESULTADO).

% Adiciona os n�s vizinhos ao final da fila.
adiciona_fronteira(NN, F1, F2) :- append(F1, NN, F2).
%
busca_largura1([Node | _], _, LAUX2, L) :- objetivo(Node), append(LAUX2, [Node], L).

busca_largura1([Node | F1], LAUX, LAUX2, L) :- 
    vizinho(Node, VIZINHOS), % Recupera os filhos de Node.
    append([Node], LAUX, VISITADOS), % Adiciona o Node � lista de visitados.
    listDifference(VISITADOS, VIZINHOS, NAO_VISITADOS), % Verifica se os filhos desse estado j� foram visitados em um outro momento.
    adiciona_fronteira(NAO_VISITADOS, F1, F2), % Adiciona � fila de execu��o apenas os filhos n�o vizitados.
    append(NAO_VISITADOS, VISITADOS, V1), % Considera os filhos n�o visitados, que ja entraram para a fila de execu��o, como visitados para a pr�xima itera��o.
    append(LAUX2, [Node], L3), % Guarda o estado analizado em uma lista auxiliar.
    busca_largura1(F2, V1, L3, L).

busca_largura(L1, L2) :-
    busca_largura1(L1, [], [], L2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Adiciona os n�s vizinhos no inicio da fila.
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


