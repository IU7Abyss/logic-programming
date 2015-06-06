% Удалить из списка все вхождения элементов из заданного множества.

list__delete_element([], _Value, []) :- !.
list__delete_element([Value | TailList], Value, ResultList) :-
    !,
    list__delete_element(TailList, Value, ResultList).
list__delete_element([AnotherValue | TailList], Value, [AnotherValue | TailResultList]) :-
    list__delete_element(TailList, Value, TailResultList).

list__delete_by_set(ResultList, [], ResultList) :- !.
list__delete_by_set(List, [Value | TailSet], ResultList) :-
    list__delete_element(List, Value, TempResult),
    list__delete_by_set(TempResult, TailSet, ResultList).


:- begin_tests(list__delete_by_set).

test(list__delete_by_set, [R == [2, 2, 2, 2, 3, 2, 1, 10, 9, 8]]) :-
    list__delete_by_set([2, 2, 2, 2, 3, 2, 1, 10, 9, 8], [], R).
test(list__delete_by_set, [R == [10, 9]]) :-
    list__delete_by_set([2, 2, 2, 2, 3, 2, 1, 10, 9, 8], [2, 3, 1, 8], R).

:- end_tests(list__delete_by_set).

:- run_tests.