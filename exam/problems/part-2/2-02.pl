% Проверить, присутствует ли заданный элемент в заданном множестве,
% и если нет то добавить его в множество.

set__add([], Value, [Value]) :- !.
set__add([Value | TailResultSet], Value, [Value | TailResultSet]) :- !.
set__add([AnotherValue | TailSet], Value, [AnotherValue | TailResultSet]) :-
    set__add(TailSet, Value, TailResultSet).



:- begin_tests(set_add).

test(set_add, [R == [1, 2, 3, 4, 5]]) :-
    set__add([1, 2, 3, 4, 5], 5, R).

test(set_add, [R == [1, 2, 3, 4, 5, 0]]) :-
    set__add([1, 2, 3, 4, 5], 0, R).

:- end_tests(set_add).

:- run_tests.