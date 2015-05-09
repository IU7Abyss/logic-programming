max(X, Y, X) :-
    X >= Y,
    !.
max(_, Y, Y) :- !.


:- begin_tests(max2).

test(max, all(X == [0])) :- max(0, 0, X).

test(max, all(X == [1])) :- max(0, 1, X).
test(max, all(X == [1])) :- max(1, 0, X).

:- end_tests(max2).



max(X, Y, Z, XYZ) :-
    max(X, Y, XY),
    max(XY, Z, XYZ).


:- begin_tests(max3).

test(max, all(X == [0])) :- max(0, 0, 0, X).

test(max, all(X == [1])) :- max(0, 0, 1, X).
test(max, all(X == [1])) :- max(0, 1, 0, X).
test(max, all(X == [1])) :- max(0, 1, 1, X).
test(max, all(X == [1])) :- max(1, 0, 0, X).
test(max, all(X == [1])) :- max(1, 0, 1, X).
test(max, all(X == [1])) :- max(1, 1, 0, X).

test(max, all(X == [2])) :- max(0, 1, 2, X).
test(max, all(X == [2])) :- max(1, 0, 2, X).
test(max, all(X == [2])) :- max(0, 2, 1, X).
test(max, all(X == [2])) :- max(1, 2, 0, X).
test(max, all(X == [2])) :- max(2, 1, 0, X).
test(max, all(X == [2])) :- max(2, 0, 1, X).

:- end_tests(max3).



fib(0, 0) :- !.
fib(1, 1) :- !.
fib(X, Y) :- 
    fib_aux(X, Y, _).

fib_aux(1, 1, 0) :- !.
fib_aux(X, Y1, Y2) :-
    X1 is X - 1,
    fib_aux(X1, Y2, Y3),
    Y1 is Y2 + Y3.


:- begin_tests(fib).

test(fib, all(X == [0])) :- fib(0, X).
test(fib, all(X == [1])) :- fib(1, X).
test(fib, all(X == [1])) :- fib(2, X).
test(fib, all(X == [2])) :- fib(3, X).
test(fib, all(X == [3])) :- fib(4, X).
test(fib, all(X == [5])) :- fib(5, X).
test(fib, all(X == [8])) :- fib(6, X).
test(fib, all(X == [13])) :- fib(7, X).

:- end_tests(fib).



factorial(0, 1) :- !.
factorial(1, 1) :- !.
factorial(N, R) :- 
    factorial_aux(N, 1, R).

factorial_aux(1, R, R) :- !.
factorial_aux(N, Acc, R) :-
    NewN is N - 1,
    NewAcc is Acc * N,
    factorial_aux(NewN, NewAcc, R).


:- begin_tests(factorial).

test(factorial, all(X == [1])) :- factorial(0, X).
test(factorial, all(X == [1])) :- factorial(1, X).
test(factorial, all(X == [2])) :- factorial(2, X).
test(factorial, all(X == [6])) :- factorial(3, X).
test(factorial, all(X == [24])) :- factorial(4, X).

:- end_tests(factorial).
