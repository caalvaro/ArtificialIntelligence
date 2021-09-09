% estado inicial
%inicial([12, 1, 10, 2, 7, 11, 4, 14, 5, 16, 9, 15, 8, 13, 6, 3]).

% estado inicial
%inicial([12, 1, 10, 2, 7, 11, 4, 14, 5, 16, 9, 15, 8, 13, 6, 3]).
%inicial([ 1, 2, 16, 3,  5,  6,  7,  4, 9, 10, 11, 8, 13, 14, 15, 12]). % 4 passos
%inicial([  16, 1,  2,  3,  5,  6,  7,  4, 9, 10, 11, 8, 13, 14, 15, 12]). % 6 passos
%inicial([  5, 1,  2,  3,   16, 6,  7,  4,  9, 10, 11, 8, 13, 14, 15, 12]). % 7 passos
%inicial([  5, 1,  2,  3, 9, 6, 7, 4, 16, 10, 11, 8, 13, 14, 15, 12]). % 8 passos
%inicial([  5, 1,  2,  3, 9, 6, 7, 4, 10, 16, 11, 8, 13, 14, 15, 12]). % 9 passos
%inicial([  5, 1,  2,  3, 9, 6, 7, 4, 10, 14, 11, 8, 13, 16, 15, 12]). % 10 passos
%inicial([ 5, 1, 2, 3, 9, 6, 7, 4, 10, 14, 11, 8, 16, 13, 15, 12]). % 11 passos
%inicial([ 5, 1, 2, 3, 9, 6, 7, 4, 16, 14, 11, 8, 10, 13, 15,
% 12]). % 12 passos - 18.3 segundos inicial([ 5, 1, 2, 3, 9, 6, 7, 4,
% 14, 16, 11, 8, 10, 13, 15, 12]). % 13 passos - 165.6 segundos
%inicial([ 5, 1, 2, 3, 9, 6, 7, 4, 14, 11, 16, 8, 10, 13, 15, 12]). %
% 14 passos - inicial([ 5, 1, 2, 3, 9, 6, 16, 4, 14, 11, 7, 8, 10, 13,
% 15, 12]). % 15 passos - inicial([ 5, 1, 2, 3, 9, 6, 4, 16, 14, 11, 7,
% 8, 10, 13, 15, 12]). % 16 passos -
%inicial([ 5, 1, 2, 16, 9, 6, 4, 3, 14, 11, 7, 8, 10, 13, 15, 12]). % 17
% passos -
%inicial([ 5, 1, 16, 2, 9, 6, 4, 3, 14, 11, 7, 8, 10, 13, 15, 12]). % 18
% passos -
%inicial([ 5, 1, 4, 2, 9, 6, 16, 3, 14, 11, 7, 8, 10, 13, 15, 12]). % 19
% passos -

%inicial([ 5, 1, 4, 2, 9, 6, 7, 3, 14, 11, 16, 8, 10, 13, 15, 12]). % 20
% passos -
%
inicial([ 5, 1, 4, 2, 9, 6, 7, 3, 14, 11, 15, 8, 10, 13, 16, 12]). % 21
% passos - 1622 nós gerados(h2)
%
%inicial([ 5, 1, 4, 2, 9, 6, 7, 3, 14, 11, 15, 8, 10, 13, 12, 16]). % 22
% passos -
%
%inicial([ 5, 1, 4, 2, 9, 6, 7, 3, 14, 11, 15, 16, 10, 13, 12, 8]). % 23
% passos -

%  5  1  4  2
%  9  6  7  3
% 14 11 15  8
% 10 13 12 16

% Predicado unário que representa o objetivo
objetivo([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]).

% Retorna a posição de Elemento na Lista
posicao1([Head|_], Elemento, Num, Pos) :-
    Head = Elemento,
    Pos is Num, !.

% Retorna a posição de Elemento na Lista
posicao1([_|Tail], Elemento, Num, Pos) :-
    Proximo is Num + 1,
    posicao1(Tail, Elemento, Proximo, Pos).

% Retorna a posição do Vazio na Lista
posicaoVazio(Lista, Pos) :-
    posicao1(Lista, 16, 1, Pos).

% Retorna a posição de Elemento na Lista
posicao(Lista, Elemento, Pos) :-
    posicao1(Lista, Elemento, 1, Pos).

% retorna a linha referente a posição no array do tabuleiro
linha1(Pos, 4) :- Pos =< 4, !.
linha1(Pos, 3) :- Pos =< 8, !.
linha1(Pos, 2) :- Pos =< 12, !.
linha1(Pos, 1) :- Pos =< 16.

linha(List, Linha) :-
    posicaoVazio(List, Pos),
    linha1(Pos, Linha).

% retorna a quantidade de elementos menores que B na lista após B
menor([], _, Num, Num).

menor([Head|Tail], B, Num, Res) :-
    Head \= 16,
    B > Head,
    Prox is Num + 1,
    menor(Tail, B, Prox, Res).

menor([Head|Tail], B, Num, Res) :-
    (B =< Head ; Head = 16),
    menor(Tail, B, Num, Res).


% calcula a quantidade de inversões que existem na lista
numero_inversoes([_], Aux, Aux).

numero_inversoes([Head|Tail], Aux, Inversoes) :-
    Head \= 16,
    menor(Tail, Head, 0, Res),
    Prox is Aux + Res,
    numero_inversoes(Tail, Prox, Inversoes).

numero_inversoes([Head|Tail], Aux, Inversoes) :-
    Head = 16,
    numero_inversoes(Tail, Aux, Inversoes).

% verifica se o tabuleiro é solucionavel
solucionavel :-
    inicial(L),
    linha(L, Linha),
    numero_inversoes(L, 0, Inversoes),
    teste(Linha, Inversoes),!.

solucionavel :-
    inicial(L),
    linha(L, Linha),
    numero_inversoes(L, 0, Inversoes),
    not(teste(Linha, Inversoes)),
    write("Não é solucionável\n\n"),!, fail.

% testa se a linha é par e a qtd de inversões é impar
teste(Linha, Inversoes) :-
    0 is mod(Linha, 2),
    1 is mod(Inversoes, 2), !.

% testa se a linha é ímpar e a qtd de inversões é par
teste(Linha, Inversoes) :-
    1 is mod(Linha, 2),
    0 is mod(Inversoes, 2).

% 1 , 2, 4, 2, 1, 3, 2, 5, 2, 3, 2, 5, 1, 4, 2, 3

% [12, 1, 10, 2,
%  7, 11, 4, 14,
%  5, 0, 9, 15,
%  8, 13, 6, 3]
%

% ação de deslocar a posição vazia para a esquerda
acao(EstadoAtual, esquerda, ProxEstado) :-
    posicaoVazio(EstadoAtual, Pos),
    not(1 is mod(Pos,4)),
    append(Esquerda, [16|Direita], EstadoAtual),
    append(L1, [Last], Esquerda),
    append(L1, [16, Last|Direita], ProxEstado).

% ação de deslocar a posição vazia para a direita
acao(EstadoAtual, direita, ProxEstado) :-
    posicaoVazio(EstadoAtual, Pos),
    not(0 is mod(Pos,4)),
    append(Esquerda, [16|Direita], EstadoAtual),
    append([First], L1, Direita),
    append(Esquerda, [First, 16|L1], ProxEstado).

% ação de deslocar a posição vazia para cima
acao(EstadoAtual, cima, ProxEstado) :-
    linha(EstadoAtual, Linha),
    not(0 is mod(Linha,4)),
    append(Esquerda, [X1, X2, X3, X4, 16|Direita], EstadoAtual),
    append(Esquerda, [16, X2, X3, X4, X1|Direita], ProxEstado).

% ação de deslocar a posição vazia para baixo
acao(EstadoAtual, baixo, ProxEstado) :-
    linha(EstadoAtual, Linha),
    not(1 is mod(Linha,4)),
    append(Esquerda, [16, X2, X3, X4, X1|Direita], EstadoAtual),
    append(Esquerda, [X1, X2, X3, X4, 16|Direita], ProxEstado).

% verifica quantos elementos estão fora do lugar
foraDoLugar([], _, Aux, Aux).

foraDoLugar([Head|Tail], Indice, Aux, Res) :-
    Head = Indice,
    ProxIndice is Indice + 1,
    foraDoLugar(Tail, ProxIndice, Aux, Res), !.

foraDoLugar([Head|Tail], Indice, Aux, Res) :-
    Head \= Indice,
    ProxIndice is Indice + 1,
    ProxAux is Aux + 1,
    foraDoLugar(Tail, ProxIndice, ProxAux, Res).

heuristica1((Estado, Profundidade), Resultado) :-
    foraDoLugar(Estado, 1, 0, R1),
    Resultado is R1 + Profundidade.

% retorna a posição do elemento no tabuleiro objetivo
posicaoOriginal(Elemento, X, Y) :-
    X is mod(Elemento-1, 4) +1,
    Y is ((Elemento-1) // 4) + 1.

% retorna a posição do elemento no tabuleiro atual
posicaoAtual(Estado, Elemento, X, Y) :-
    posicao(Estado, Elemento, Pos),
    X is mod(Pos-1, 4) + 1,
    Y is ((Pos-1) // 4) + 1.

% soma a distancia entre o tabuleiro atual e o final, com o atual e o inicial
manhattan(_, [], Aux, Aux).

manhattan(Estado, [Head|Tail], Aux, Res) :-
    posicaoAtual(Estado, Head, X1, Y1),
    posicaoOriginal(Head, X2, Y2),
    ProxAux is Aux + abs(X1 - X2) + abs(Y1 - Y2),
    manhattan(Estado, Tail, ProxAux, Res).

heuristica2((Estado, Profundidade), Resultado) :-
    manhattan(Estado, Estado, 0, R1),
    Resultado is R1 + Profundidade.

% executa a heuristica escolhida
heuristica(H, (Estado, Profundidade), Res) :-
    H = h1,
    heuristica1((Estado, Profundidade), Res), !.

heuristica(H, (Estado, Profundidade), Res) :-
    H = h2,
    heuristica2((Estado, Profundidade), Res), !.

% Retorna todos os estados possíveis a partir do estado N e das ações definidas anteriormente.
vizinho(Estado, FilhosN) :- findall(X, acao(Estado, _, X), FilhosN).

listDifference(_, [], []). % a diferença entre uma lista vazia e qualquer outra vai ser uma lista vazia
listDifference([], L2, L2). % a diferença entre uma lista e uma lista vazia é a própria lista

listDifference(L1, [HEAD2|TAIL2], RESULTADO) :- % caso em que HEAD2 não está em L1
    listDifference(L1, TAIL2, R1),
    not(member(HEAD2, L1)),
    append([HEAD2], R1, RESULTADO). % só adiciona no resultado se HEAD2 não estiver em L1

listDifference(L1, [_|TAIL2], RESULTADO) :- % se já estiver na lista 1, só ignora e continua a execução
    listDifference(L1, TAIL2, RESULTADO).

% ordenação quicksort
pivoting(_, _,[],[],[]).
pivoting(Heur, (NodeH, ProfundidadeH, HeuristicaH, PaiH),[(NodeX, ProfundidadeX, HeuristicaX, PaiX)|T],[(NodeX, ProfundidadeX, HeuristicaX, PaiX)|L],G):-
    HeuristicaX > HeuristicaH,
    pivoting(Heur,(NodeH, ProfundidadeH, HeuristicaH, PaiH),T,L,G).

pivoting(Heur, (NodeH, ProfundidadeH, HeuristicaH, PaiH),[(NodeX, ProfundidadeX, HeuristicaX, PaiX)|T],L,[(NodeX, ProfundidadeX, HeuristicaX, PaiX)|G]):-
    HeuristicaX =< HeuristicaH,
    pivoting(Heur, (NodeH, ProfundidadeH, HeuristicaH, PaiH),T,L,G).

% ordenação quicksort
quick_sort(Heur, List, Sorted) :- q_sort(Heur, List,[],Sorted).
q_sort(_, [],Acc,Acc).
q_sort(Heur, [H|T],Acc,Sorted) :-
    pivoting(Heur, H,T,L1,L2),
    q_sort(Heur, L1,Acc,Sorted1),
    q_sort(Heur, L2,[H|Sorted1],Sorted).

% Adiciona os nós vizinhos ao final da fila.
adiciona_fronteira(_, [], F1, F1) :- !.

adiciona_fronteira(Heur, NN, F1, F3) :-
    append(F1, NN, F2),
    quick_sort(Heur, F2, F3).

criaVizinhos(_, _, [], _, []).

criaVizinhos(Heur, NodePai, [Head|Tail], Profundidade, L) :-
    NovaProfundidade is Profundidade + 1,
    heuristica(Heur, (Head, Profundidade), Heuristica),
    criaVizinhos(Heur, NodePai, Tail, Profundidade, L1),
    append(L1, [(Head, NovaProfundidade, Heuristica, NodePai)], L).

achaPai([], _, []).

achaPai(Pai, Lista, NoPai) :-
    append(_, [(Pai, ProfPai, HeurPai, PaiPai)|_], Lista),
    NoPai = (Pai, ProfPai, HeurPai, PaiPai), !.

geraCaminho((Node, _, _, []), _, AUX,  [Node|AUX]).

geraCaminho((Node, _, _, Pai), Sequencia, AUX, Caminho) :-
    achaPai(Pai, Sequencia, NoPai),
    append([Node], AUX, C1),
    geraCaminho(NoPai, Sequencia, C1, Caminho), !.

buscaAEstrela1(_, [(Node, Profundidade, Heuristica, Pai) | _], _, LAUX2, L, 1) :-
    objetivo(Node),
    append([(Node, Profundidade, Heuristica, Pai)], LAUX2, L), !.

buscaAEstrela1(Heur, [(Node, Profundidade, Heuristica, Pai) | F1], JAVISITADOS, SeqAUX, Sequencia, QtdGerados) :-
    vizinho(Node, VIZINHOS), % Recupera os filhos de Node.

    append([Node], JAVISITADOS, VISITADOS), % Adiciona o Node à lista de visitados.

    listDifference(VISITADOS, VIZINHOS, NAO_VISITADOS), % Verifica se os filhos desse estado já foram visitados em um outro momento.

    criaVizinhos(Heur, Node, NAO_VISITADOS, Profundidade, NAO_VISITADOS2),

    adiciona_fronteira(Heur, NAO_VISITADOS2, F1, F2), % Adiciona à fila de execução apenas os filhos não vizitados.

    append(NAO_VISITADOS, VISITADOS, V1), % Considera os filhos não visitados, que ja entraram para a fila de execução, como visitados para a próxima iteração.
    append( [(Node, Profundidade, Heuristica, Pai)], SeqAUX, L3), % Guarda o estado analizado em uma lista auxiliar.

    buscaAEstrela1(Heur, F2, V1, L3, Sequencia, Qtd),

    length(NAO_VISITADOS, Tamanho),
    QtdGerados is Qtd + Tamanho.

buscaAEstrela(Heur, Caminho, QtdGerados) :-
    inicial(EstadoInicial),
    solucionavel,
    heuristica(Heur, (EstadoInicial, 0), Heuristica),
    buscaAEstrela1(Heur, [(EstadoInicial, 0, Heuristica, [])], [], [], [Head|Tail], QtdGerados),
    geraCaminho(Head, [Head|Tail], [], Caminho),
    !.
