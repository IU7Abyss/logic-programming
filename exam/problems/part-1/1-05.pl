% Посчитать количество максимальных элементов в списке.

list__count_max([TempMax | TailList], Count) :-
    list__count_max_aux(TailList, TempMax, 1, Count).

list__count_max_aux([], _Max, Count, Count) :- !.
list__count_max_aux([TempMax | TailList], TempMax, TempCountMax, Count) :-
    !,
    IncCount is TempCountMax + 1,
    list__count_max_aux(TailList, TempMax, IncCount, Count).
list__count_max_aux([Value | TailList], TempMax, _TempCountMax, Count) :-
    Value > TempMax,
    !,
    list__count_max_aux(TailList, Value, 1, Count).
list__count_max_aux([_Value | TailList], TempMax, TempCountMax, Count) :-
    list__count_max_aux(TailList, TempMax, TempCountMax, Count).


:- begin_tests(list__count_max).

test(list__count_max, [fail]) :-
    list__count_max([], _).

test(list__count_max, [R == 4]) :- 
    list__count_max([1, 2, -3, 10, 3, 10, -100, 10, -1000, 10], R).

:- end_tests(list__count_max).

:- run_tests.