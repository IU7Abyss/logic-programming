max2(X, Y, X) :-
    X >= Y,
    !.
max2(_, Y, Y) :- !.


:- begin_tests(max2).

test(max2, all(X == [0])) :- max2(0, 0, X).

test(max2, all(X == [1])) :- max2(0, 1, X).
test(max2, all(X == [1])) :- max2(1, 0, X).

:- end_tests(max2).



max3(X, Y, Z, XYZ) :-
    max2(X, Y, XY),
    max2(XY, Z, XYZ).


:- begin_tests(max3).

test(max3, all(X == [0])) :- max3(0, 0, 0, X).

test(max3, all(X == [1])) :- max3(0, 0, 1, X).
test(max3, all(X == [1])) :- max3(0, 1, 0, X).
test(max3, all(X == [1])) :- max3(0, 1, 1, X).
test(max3, all(X == [1])) :- max3(1, 0, 0, X).
test(max3, all(X == [1])) :- max3(1, 0, 1, X).
test(max3, all(X == [1])) :- max3(1, 1, 0, X).

test(max3, all(X == [2])) :- max3(0, 1, 2, X).
test(max3, all(X == [2])) :- max3(1, 0, 2, X).
test(max3, all(X == [2])) :- max3(0, 2, 1, X).
test(max3, all(X == [2])) :- max3(1, 2, 0, X).
test(max3, all(X == [2])) :- max3(2, 1, 0, X).
test(max3, all(X == [2])) :- max3(2, 0, 1, X).

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