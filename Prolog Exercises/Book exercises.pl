% concatenate

conc([], L, L).

conc([X | L1], L2, [X | L3]) :- conc(L1, L2, L3).


% 3.1

delete3last(IN, OUT) :- conc(OUT, [_,_,_], IN).


% 3.2

last(ITEM, LIST) :- conc(_, [ITEM], LIST).

last(ITEM, [ITEM]). 
last(ITEM, [_ | TAIL] ) :- last(ITEM, TAIL). 

% 3.3
evenlength([]).
evenlength([_ | TAIL]) :- oddlength(TAIL).

oddlength([_]).
oddlength([_ | TAIL]) :- evenlength(TAIL).

% 3.4
reverse([],[]).
reverse([X], [X]).
reverse([HEAD | TAIL], REVERSED) :- reverse(TAIL, R1), conc(R1, [HEAD], REVERSED).


% 3.5
listequal(L1, L2) :- conc(L1, [], L2).
palindrome(L1) :- reverse(L1, REV), listequal(L1, REV).

% 3.6

shift([], []).
shift([X], [X]).
shift([HEAD | TAIL], L2) :- conc(TAIL, [HEAD], L2).

% 3.7

means(0, zero).
means(1, one).
means(2, two).
means(3, three).
means(4, four).
means(5, five).
means(6, six).
means(7, seven).
means(8, eight).
means(9, nine).

translate([],[]).
translate([X], L) :- means(X, NUM), L = [NUM].
translate([HEAD | TAIL], L2) :- translate(TAIL, LIST), means(HEAD, NUM), L2 = [NUM | LIST].

% 3.8 ???
sublist(S,L) :- conc(_,L2,L), conc(S,_,L2).
subset(SET, SUBSET) :- sublist(L1, SET), sublist(L2, SET), conc(L1, L2, SUBSET).

% 3.9
equalsize([_],[_]).
equalsize([_|TAIL],[_|TAIL2]) :- equalsize(TAIL, TAIL2).

similarsize([],[_]).
similarsize([_],[]).
similarsize([_|TAIL],[_|TAIL2]) :- similarsize(TAIL, TAIL2).

dividelist(LIST, L1, L2) :- evenlength(LIST), conc(L1, L2, LIST), equalsize(L1,L2).
dividelist(LIST, L1, L2) :- oddlength(LIST), conc(L1, L2, LIST), similarsize(L1,L2).


%3.11
flatten([HEAD|TAIL],[HEAD]) :- listequal(TAIL,[]).
flatten([HEAD|TAIL],L) :- flatten([HEAD],HL), flatten(TAIL, TL), conc(HL, TL, L).