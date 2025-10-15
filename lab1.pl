parent(ion,maria).
parent(ana,maria).
parent(ana,dan).
parent(maria,elena).
parent(maria,radu).
parent(elena,nicu).
parent(radu,george).
parent(radu,dragos).

child(X, Y) :- parent(Y, X).
brother(X, Y) :- X \== Y, parent(Z, X), parent(Z, Y). 
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

descendant(X, Y) :- child(X, Y).
descendant(X, Y) :- child(X, Z), descendant(Z, Y).
ancestor(X, Y) :- descendant(Y, X).

max(X, Y, X) :- X >= Y.
max(X, Y, Y) :- Y >= X.

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

concat(A, [], A).
concat([A], B, [A | B]). 
concat([A | T1], B, [A | T2]) :- concat(T1, B, T2).

alternatingSum([], 0).
alternatingSum([A], A).
alternatingSum([A, B], C) :- C is A - B.
alternatingSum([A, B | T], S) :- alternatingSum(T, S1), S is A - B + S1.

delete(_, [], []).
delete(X, [X | T], T1) :- delete(X, T, T1).
delete(X, [Y | T], [Y | T1]) :- X \== Y, delete(X, T, T1).

deleteExactlyOne(X, [X], []).
deleteExactlyOne(X, [X | T], T).
deleteExactlyOne(X, [Y | T], [Y | T1]) :- X \== Y, deleteExactlyOne(X, T, T1).

reverse([], []).
reverse([A], [A]).
reverse([A | T], L) :- reverse(T, T1), concat(T1, [A], L).

permutation([], []).
permutation([A | T], B) :- deleteExactlyOne(A, B, C), permutation(T, C).

count(_, [], 0).
count(A, [A | T], S) :- count(A, T, S1), S is 1 + S1.
count(A, [B | T], S) :- A \== B, count(A, T, S).

insert(A, 0, B, [A | B]).
insert(A, I, [B | T], [B | T1]) :- I1 is I - 1, insert(A, I1, T, T1).

merge(A, [], A).
merge([], B, B).
merge([A | TA], [B | TB], [A | T]) :- A =< B, merge(TA, [B | TB], T).
merge([TA], [B | TB], [B, A | T]) :- A >= B, merge([A | TA], TB, T).
