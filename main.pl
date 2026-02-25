eval(E, E) :- integer(E).
eval(A+B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA + EvalB.
eval(A-B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA - EvalB.
eval(A*B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA * EvalB.
eval(A/B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA / EvalB.
eval(A^B, V) :- eval(A, EvalA), eval(B, EvalB), V is EvalA ^ EvalB.
