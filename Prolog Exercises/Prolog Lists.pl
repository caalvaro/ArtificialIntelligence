% Quest�o 1

insere(X, [], [X]). % caso base: lista vazia

insere(X, [HEAD | TAIL], L) :- X =< HEAD,
                               L = [X, HEAD | TAIL]. % adiciona o X na frente da lista se ele for menos que o primeiro elemento dela
insere(X, [HEAD | TAIL], L) :- insere(X, TAIL, L1), %chama a fun��o recursivamente at� encontrar o caso em que X � menor ou igual ao primeiro elemento de TAIL
                               L = [HEAD | L1]. % adiciona a cabe�a da lista de volta para preench�-la novamente



% Quest�o 2

multiplos(X, L, COUNT) :-
    X - 4 >= 0,
    C is COUNT + 1, % usa um contador para gerenciar os m�ltiplos de 4
    multiplos(X - 4, LISTA, C), % chama a fun��o recursivamente enquanto formposs�vel decrementar 4 de X
    NOVO is C * 4,
    L = [NOVO | LISTA]. % ao sair da recurs�o, adiciona um novo multiplo na lista

multiplos(X, LISTA, COUNT) :- LISTA = [0]. % caso base, quando X - 4 < 0

multiplos4(X, L) :- multiplos(X, L, 0). % regra para ser usada na consulta, abstrai a parte do contador para o usu�rio


