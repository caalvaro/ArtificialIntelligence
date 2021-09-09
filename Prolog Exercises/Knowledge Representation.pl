parent(pam,bob).
parent(tom,bob).
parent(tom,liz).
parent(pam,liz). % adicionei essa linha para ter o caso em que liz e bob são irmãos
parent(bob,ann).
parent(bob,pat).
parent(pat,jim).
female(pam).
female(liz).
female(ann).
female(pat).
male(tom).
male(bob).
male(jim).
father(X,Y) :- male(X), parent(X,Y).
mother(X,Y) :- female(X), parent(X,Y).

/*X e Y são irmão se possuem mesmo pai e mãe, não aceita o caso em que X e Y são iguais*/
irmaos(X,Y) :- father(Z,X), father(Z,Y), mother(W,X), mother(W,Y), X \= Y.


