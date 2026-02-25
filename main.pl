eval(E, E) :- integer(E).
eval(A+B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA + EvalB.
eval(A-B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA - EvalB.
eval(A*B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA * EvalB.
eval(A/B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA / EvalB.
eval(A^B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA ^ EvalB.

%# -----------------------------------------------

simplify(E, E) :- integer(E).
simplify(E, E) :- atom(E).
simplify(A*B, S) :- simplify(A, SimpA), simplify(B, SimpB), simpMul(SimpA, SimpB, S).
simplify(A/B, S) :- simplify(A, SimpA), simplify(B, SimpB), simpDiv(SimpA, SimpB, S).
simplify(A^B, S) :- simplify(A, SimpA), simplify(B, SimpB), simpPow(SimpA, SimpB, S).
simplify(A+B, S) :- simplify(A, SimpA), simplify(B, SimpB), simpAdd(SimpA, SimpB, S).
simplify(A-B, S) :- simplify(A, SimpA), simplify(B, SimpB), simpSub(SimpA, SimpB, S).

simpMul(0, _, 0).
simpMul(_, 0, 0).
simpMul(1, X, X).
simpMul(X, 1, X).
simpMul(A, B, S) :- integer(A), integer(B), S is A * B.
simpMul(A, X, A*X).

simpDiv(0, X, 0).
simpDiv(X, 0, 0). %# crash here instead of returning 0.........???
simpDiv(1, X, X).
simpDiv(X, 1, X).
simpDiv(A, B, S) :- integer(A), integer(B), S is A/B.
simpDiv(A, X, A/X).

simpPow(X, 0, 1).
simpPow(X, 1, X).
simpPow(A, B, S) :- integer(A), integer(B), S is A ^ B.
simpPow(A, X, A^X).

simpAdd(X, 0, X).
simpAdd(0, X, X).
simpAdd(A, B, S) :- integer(A), integer(B), S is A + B.
simpAdd(A, X, A+X).

simpSub(X, 0, X).
simpSub(0, X, X).
simpSub(A, B, S) :- integer(A), integer(B), S is A - B.
simpSub(A, X, A-X).

%# ----------------------------------

deriv(x, 1) :- !.
deriv(C, 0) :- integer(C), !.
deriv(C, 0) :0 atom(C), !.

%# party_builder(_, []) :- party_builder(1, [klefstad]).

party_seating([]).
party_seating(L) :- findall(X, (male(X) ; female(X)), G),
    permutation(G, L),
    L = [First|_],
    append(L, [First], Wrap),
    valid_pairs(Wrap),
    !.

valid_pairs([_]).
valid_pairs([A, B|T]) :-
    speaks(A, Match),
    speaks(B, Match),
    \+ (female(A), female(B)),
    valid_pairs([B|T]).



