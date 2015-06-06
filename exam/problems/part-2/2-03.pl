% Проверить, является первое множество подмножеством второго.

set__is_memeber(Value, [Value | _TailSet]) :- !.
set__is_memeber(Value, [_Value | TailSet]) :-
    set__is_memeber(Value, TailSet).

set__is_subset([], _Set) :- !.
set__is_subset([Value | TailSubSet], Set) :-
    set__is_memeber(Value, Set),
    !,
    set__is_subset(TailSubSet, Set).
    

:- begin_tests(set__is_subset).

test(set__is_subset, [fail]) :- set__is_subset([3, 1, 0, 10, 90], [-1, 3, 2, 5, 9, 7, -100, 1, 0, -9, 12, 11, 10]).
test(set__is_subset, [true]) :- set__is_subset([3, 1, 0, 10], [-1, 3, 2, 5, 9, 7, -100, 1, 0, -9, 12, 11, 10]).

:- end_tests(set__is_subset).

:- run_tests.