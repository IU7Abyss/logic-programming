% Добавить в упорядоченный по невозрастанию список
% элементы заданного множества, не нарушив порядок

list__insert([], Value, Value) :- !.
list__insert([V1 | TailList], Value, [V1 | TailResult]) :-
    V1 >= Value,
    !,
    list__insert(TailList, Value, TailResult).
list__insert([V1 | TailList], Value, [Value, V1 | TailList]) :- !.


list__insert_by_set(ResultList, [], ResultList) :- !.
list__insert_by_set(List, [Value | TailSet], ResultList) :-
    list__insert(List, Value, TempList),
    list__insert_by_set(TempList, TailSet, ResultList).


% list__insert_by_set([5, 4, 2, 1], [10, 8, 7, 9, 5], R). 