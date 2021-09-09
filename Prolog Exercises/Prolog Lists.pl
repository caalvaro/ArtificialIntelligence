% Questão 1

insere(X, [], [X]). % caso base: lista vazia

insere(X, [HEAD | TAIL], L) :- X =< HEAD,
                               L = [X, HEAD | TAIL]. % adiciona o X na frente da lista se ele for menos que o primeiro elemento dela
insere(X, [HEAD | TAIL], L) :- insere(X, TAIL, L1), %chama a função recursivamente até encontrar o caso em que X é menor ou igual ao primeiro elemento de TAIL
                               L = [HEAD | L1]. % adiciona a cabeça da lista de volta para preenchê-la novamente



% Questão 2

multiplos(X, L, COUNT) :-
    X - 4 >= 0,
    C is COUNT + 1, % usa um contador para gerenciar os múltiplos de 4
    multiplos(X - 4, LISTA, C), % chama a função recursivamente enquanto formpossível decrementar 4 de X
    NOVO is C * 4,
    L = [NOVO | LISTA]. % ao sair da recursão, adiciona um novo multiplo na lista

multiplos(X, LISTA, COUNT) :- LISTA = [0]. % caso base, quando X - 4 < 0

multiplos4(X, L) :- multiplos(X, L, 0). % regra para ser usada na consulta, abstrai a parte do contador para o usuário


