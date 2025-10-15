gcd(0, X, X) :- !.
gcd(X, 0, X) :- !.
gcd(A, B, C) :- A =< B, D is B-A, gcd(D, A, C).
gcd(A, B, C) :- A > B, !, gcd(B, A, C).

split([], _, [], []).
split([H1 | T], H, [H1 | A], B) :- H1 =< H, split(T, H, A, B).
split([H1 | T], H, A, [H1 | B]) :- H1 > H, !, split(T, H, A, B).

insertsort([], []).
insertsort([X | T], S) :- insertsort(T, ST), insert(X, ST, S).

insert(X, [], [X]).
insert(X, [TH | T], [X, TH | T]) :- X =< TH.
insert(X, [TH | T], [TH | ST]) :- X > TH, !, insert(X, ST, T).

quick([], []).
quick([X], [X]).
quick([H | T], L) :- split(T, H, A, B), quick(A, A1), quick(B, B1), merge(A1, [H | B1], L).

merge([], [], []).
merge(A, [], A).
merge([], B, B).
merge([A | TA], [B | TB], [A | C]) :- A =< B, merge(TA, [B | TB], C).
merge([A | TA], [B | TB], [B | C]) :- A > B, !, merge([A | TA], TB, C).

queen([]).
queen([[X, Y] | S]) :- queen(S), member(Y, [1, 2, 3, 4, 5, 6, 7, 8]), not(attack([X, Y], S)).

attack([X, Y], S) :- member([X1, Y1], S), twoQueensAttack(X, Y, X1, Y1).
twoQueensAttack(X, Y, X1, Y1) :- X = X1.
twoQueensAttack(X, Y, X1, Y1) :- Y = Y1.
twoQueensAttack(X, Y, X1, Y1) :- X1 - X =:=   Y1 - Y.
twoQueensAttack(X, Y, X1, Y1) :- X1 - X =:= -(Y1 - Y).

queenSol(S) :- S = [[1,X1],[2,X2],[3,X3],[4,X4],[5,X5],[6,X6],[7,X7],[8,X8]], queen(S).

% ?- aggregate_all(count, queenSol(S), C).
% C = 92.

solution(Sol) :- Sol=[
    [1,N1,C1,P1,D1,S1],   
    [2,N2,C2,P2,D2,S2], 
    [3,N3,C3,P3,D3,S3], 
    [4,N4,C4,P4,D4,S4], 
    [5,N5,C5,P5,D5,S5]],
    member([_,british,red,_,_,_],Sol),
    member([BH,_,blue,_,_,_], Sol),
    member([NH,norwegian,_,_,_,_],Sol),
    adjacent(BH, NH),
    member([WH,_,white,_,_,_],Sol),
    member([GH,_,green,_,_,_],Sol),
    WH - 1 =:= GH,
    member([_,_,green,_,coffee,_],Sol),
    member([3,_,_,_,milk,_],Sol),
    member([_,_,yellow,_,_,dunhill],Sol),
    member([1,norwegian,_,_,_,_],Sol),
    member([_,swedish,_,dog,_,_],Sol),
    member([_,_,_,bird,_,pallmall],Sol),
    member([MH,_,_,_,_,marlboro],Sol),
    member([CH,_,_,cat,_,_],Sol),
    adjacent(MH, CH),
    member([_,_,_,_,beer,winfield],Sol),
    member([HH,_,_,horse,_,_],Sol),
    member([DH,_,_,_,_,dunhill],Sol),
    adjacent(HH, DH),
    member([_,german,_,_,_,rothmans],Sol),
    member([WH,_,_,_,water,_],Sol),
    adjacent(WH, MH),
    permutation([N1, N2, N3, N4, N5], [british, swedish, danish, norwegian, german]),
    permutation([C1, C2, C3, C4, C5], [red, white, blue, yellow, green]),
    permutation([P1, P2, P3, P4, P5], [bird, dog, horse, cat, fish]),
    permutation([D1, D2, D3, D4, D5], [milk, beer, tea, water, coffee]),
    permutation([S1, S2, S3, S4, S5], [pallmall, winfield, marlboro, dunhill, rothmans]).

adjacent(A, B) :- A + 1 =:= B.
adjacent(A, B) :- A - 1 =:= B.

% S = [[1, norwegian, yellow, fish, tea, dunhill], [2, danish, blue, horse, beer, winfield], [3, british, red, bird, milk, pallmall], [4, swedish, green, dog, coffee, marlboro], [5, german, white, cat, water, rothmans]]

hasFish(N) :- solution(S), member([_,N,_,fish,_,_],S).

% N = norwegian
