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



not_tail_fib(0, 0) :- !.
not_tail_fib(1, 1) :- !.
not_tail_fib(X, Y) :-
    X1 is X - 1, not_tail_fib(X1, Y1),
    X2 is X - 2, not_tail_fib(X2, Y2),
    Y is Y1 + Y2.


:- begin_tests(not_tail_fib).

test(not_tail_fib, all(X == [0])) :- not_tail_fib(0, X).
test(not_tail_fib, all(X == [1])) :- not_tail_fib(1, X).
test(not_tail_fib, all(X == [1])) :- not_tail_fib(2, X).
test(not_tail_fib, all(X == [2])) :- not_tail_fib(3, X).
test(not_tail_fib, all(X == [3])) :- not_tail_fib(4, X).
test(not_tail_fib, all(X == [5])) :- not_tail_fib(5, X).
test(not_tail_fib, all(X == [8])) :- not_tail_fib(6, X).
test(not_tail_fib, all(X == [13])) :- not_tail_fib(7, X).

:- end_tests(not_tail_fib).



fib(N, F) :- 
    fib_aux(N, 0, 1, F).

fib_aux(0, A, _, A) :-!.
fib_aux(N, A, B, F) :-
    N1 is N - 1, 
    Sum is A + B, 
    fib3(N1, B, Sum, F).
    

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



not_tail_factorial(0, 1) :- !.
not_tail_factorial(1, 1) :- !.
not_tail_factorial(N, R) :-
    NewN is N - 1,
    not_tail_factorial(NewN, NewR),
    R is N * NewR.


:- begin_tests(not_tail_factorial).

test(not_tail_factorial, all(X == [1])) :- not_tail_factorial(0, X).
test(not_tail_factorial, all(X == [1])) :- not_tail_factorial(1, X).
test(not_tail_factorial, all(X == [2])) :- not_tail_factorial(2, X).
test(not_tail_factorial, all(X == [6])) :- not_tail_factorial(3, X).
test(not_tail_factorial, all(X == [24])) :- not_tail_factorial(4, X).

:- end_tests(not_tail_factorial).



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