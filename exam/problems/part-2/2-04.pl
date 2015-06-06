% Даны числовой список и множество. 
% Удалить из списка все вхождения максимального элемента множества.

set__cut_to_first_number([], []) :- !.
set__cut_to_first_number([X | Set], Result) :-
    atom(X),
    !,
    set__cut_to_first_number(Set, Result).
set__cut_to_first_number(Set, Set) :- !.

set__find_max_number(Set, Max) :-
    set__cut_to_first_number(Set, [X | CuttedSet]),
    set__find_max_number_aux(CuttedSet, X, Max).    

set__find_max_number_aux([], TempMax, TempMax) :-
    atomic(TempMax),
    !.
set__find_max_number_aux([X | Set], TempMax, Result) :-
    number(X),
    X > TempMax,
    !,
    set__find_max_number_aux(Set, X, Result).
set__find_max_number_aux([_ | Set], TempMax, Result) :-
    set__find_max_number_aux(Set, TempMax, Result).

list__delete([], _Element, []) :- !.
list__delete([Element | Tail], Element, ResultList) :-
    list__delete(Tail, Element, ResultList),
    !.
list__delete([NotElement | Tail], Element, [NotElement | ResultTail]) :-
    list__delete(Tail, Element, ResultTail).

list__delete_max_by_set(List, Set, ResultList) :-
    set__find_max_number(Set, Max),
    list__delete(List, Max, ResultList),
    !.
list__delete_max_by_set(List, _, List) :- !.


:- begin_tests(list__delete_max_by_set).

test(list__delete_max_by_set, [R == [1, 2, -5, 9, 6, 6]]) :- 
    list__delete_max_by_set([1, 2, -5, 10, 9, 10, 6, 6], [a, b, c, 3, g, 10, a, 5], R).

test(list__delete_max_by_set, [R == [1, 2, -5, 10, 9, 10, 6, 6]]) :- 
    list__delete_max_by_set([1, 2, -5, 10, 9, 10, 6, 6], [a, b, c], R).
test(list__delete_max_by_set, [R == [1, 2, -5, 10, 9, 10, 6, 6]]) :- 
    list__delete_max_by_set([1, 2, -5, 10, 9, 10, 6, 6], [a, -4, c], R).

:- end_tests(list__delete_max_by_set).

:- run_tests.