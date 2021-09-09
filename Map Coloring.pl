%%%%% ALUNOS %%%%%%
% Álvaro de Carvalho
% Caio Silva


% fronteiras

fronteira(brasil, uruguai).
fronteira(brasil, argentina).
fronteira(brasil, paraguai).
fronteira(brasil, bolivia).
fronteira(brasil, peru).
fronteira(brasil, colombia).
fronteira(brasil, venezuela).
fronteira(brasil, guiana).
fronteira(brasil, suriname).
fronteira(brasil, guiana_francesa).
fronteira(argentina, chile).
fronteira(argentina, uruguai).
fronteira(argentina, paraguai).
fronteira(argentina, bolivia).
fronteira(argentina, brasil).
fronteira(uruguai, argentina).
fronteira(uruguai, brasil).
fronteira(chile, argentina).
fronteira(chile, bolivia).
fronteira(chile, peru).
fronteira(paraguai, argentina).
fronteira(paraguai, bolivia).
fronteira(paraguai, brasil).
fronteira(bolivia, paraguai).
fronteira(bolivia, argentina).
fronteira(bolivia, chile).
fronteira(bolivia, peru).
fronteira(bolivia, brasil).
fronteira(peru, chile).
fronteira(peru, bolivia).
fronteira(peru, brasil).
fronteira(peru, colombia).
fronteira(peru, equador).
fronteira(equador, peru).
fronteira(equador, colombia).
fronteira(colombia, equador).
fronteira(colombia, peru).
fronteira(colombia, brasil).
fronteira(colombia, venezuela).
fronteira(venezuela, colombia).
fronteira(venezuela, brasil).
fronteira(venezuela, guiana).
fronteira(guiana, venezuela).
fronteira(guiana, brasil).
fronteira(guiana, suriname).
fronteira(suriname, guiana).
fronteira(suriname, brasil).
fronteira(suriname, guiana_francesa).
fronteira(guiana_francesa, suriname).
fronteira(guiana_francesa, brasil).

% cores
cor(azul).
cor(verde).
cor(vermelho).
cor(amarelo).

% functores auxiliares

% concatenate

conc([], L, L).

conc([X | L1], L2, [X | L3]) :- conc(L1, L2, L3).


% Recebe um pais e a lista de paises coloridos
% Retorna uma cor que não foi usada nos países adjacentes
cor_pais(PAIS, LISTA, RESULTADO) :-
    cor_pais2(PAIS, LISTA, [], RESULTADO), !.

cor_pais2(PAIS, [(PAIS_COLORIDO, COR)], CORES, RESULTADO) :- % caso base, apenas um país na lista de coloridos
    faz_fronteira(PAIS, PAIS_COLORIDO),			% se o pais que eu quero colorir faz fronteira com o pais já colorido
    conc([COR], CORES, NOVAS_CORES),			% adiciona a cor do país já colorido nas cores que não podemos usar
    nova_cor(NOVAS_CORES, RESULTADO).           % retorna uma cor que possa ser usada

cor_pais2(_, [_], CORES, RESULTADO) :- % outro caso base, se o único pais da lista de coloridos não faz fronteira
    nova_cor(CORES, RESULTADO).

cor_pais2(PAIS, [(PAIS_COLORIDO, COR)|TAIL], CORES, RESULTADO) :-	% caso que entra em recursão se os países fazem fronteira
    faz_fronteira(PAIS, PAIS_COLORIDO),				% se o pais que eu quero colorir faz fronteira com o pais já colorido
    conc([COR], CORES, NOVAS_CORES),				% adiciona a cor do país já colorido nas cores que não podemos usar
    cor_pais2(PAIS, TAIL, NOVAS_CORES, RESULTADO).	% faz uma recursão para continuar buscando fronteiras na lista

cor_pais2(PAIS, [_|TAIL], CORES, RESULTADO) :-  % se os países não fazem fronteira, apenas continua a execução
    cor_pais2(PAIS, TAIL, CORES, RESULTADO).	% faz uma recursão para continuar buscando fronteiras na lista

nova_cor(LISTA, COR) :-					% recebe uma lista de cores e retorna uma cor que não está na lista
    cor(COR),							% pega uma cor
    not(conc(_, [COR|_], LISTA)), !.	% garante que a cor não está incluída na lista

faz_fronteira(PAIS1,PAIS2) :-			% função pra verificar se dois países fazem fronteira
    fronteira(PAIS1,PAIS2) ; fronteira(PAIS2, PAIS1).


% functor principal
colore_mapa([P], [(P, azul)]).	% caso base, colore o único país da lista de uma cor qualquer


colore_mapa([PAIS|TAIL], RESULTADO) :-
    colore_mapa(TAIL, R1),					% faz uma recursão sobre a lista até chegar no último elemento
    cor_pais(PAIS, R1, COR),				% procura uma cor que não foi usada nos países adjacentes ao país
    conc([(PAIS, COR)], R1, RESULTADO), !.  % adiciona o resultado na lista final


%%%% Consultas %%%%%%

% colore_mapa(LISTA_DE_PAISES, LISTA_COM_RESULTADO).
% Exemplo:
% colore_mapa([brasil, uruguai, argentina, chile, paraguai, jamaica, peru], L).