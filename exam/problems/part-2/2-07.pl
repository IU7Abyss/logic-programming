% Объединить 2 множества

is_set_member(X, [X | _]) :- !.
is_set_member(X, [_ | T]) :-
    is_set_member(X, T).

set_union(S, S, S) :- !.
set_union([], S2, S2) :- !.
set_union(S1, [], S1) :- !.
set_union(S1, S2, R) :-
    set_union_aux(S1, S2, S1, R).

set_union_aux(_S1, [], Acc, Acc) :- !.
set_union_aux(S1, [X2 | T2], Acc, R) :-
    is_set_member(X2, S1),
    set_union_aux(S1, T2, Acc, R),
    !.
set_union_aux(S1, [X2 | T2], Acc, R) :-
    set_union_aux(S1, T2, [X2 | Acc], R).


:- begin_tests(set_union).

test(set_union, [R == []]) :- set_union([], [], R).

test(set_union, [R == [1, 2, 3]]) :- set_union([1, 2, 3], [], R).
test(set_union, [R == [1, 2, 3]]) :- set_union([], [1, 2, 3], R).

test(set_union, [R == [1, 2, 3]]) :- set_union([1, 2, 3], [3, 2, 1], R).
test(set_union, [R == [5, 4, 0, 1, 2, 3]]) :- set_union([0, 1, 2, 3], [3, 4, 5, 0], R).

:- end_tests(set_union).

:- run_tests.