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



% Посчитать сумму элементов дерева, находящихся в интервале [A, B].
is_in_interval(Value, interval(LeftBorder, RightBorder)) :-
    LeftBorder =< Value,
    Value =< RightBorder.

is_left_out_interval(Value, interval(LeftBorder, _RightBorder)) :-
    Value < LeftBorder.

btree__sum_by_interval(BTree, Interval, Result) :-
    btree__sum_by_interval_aux(BTree, Interval, 0, Result).

btree__sum_by_interval_aux(nil, _Interval, Acc, Acc) :- !.
btree__sum_by_interval_aux(btree(Root, LeftBranch, RightBranch), Interval, Acc, Result) :-
    is_in_interval(Root, Interval),
    !,
    NewAcc is Acc + Root,
    btree__sum_by_interval_aux(LeftBranch, Interval, NewAcc, LeftBranchAcc),
    btree__sum_by_interval_aux(RightBranch, Interval, LeftBranchAcc, Result).
btree__sum_by_interval_aux(btree(Root, _LeftBranch, RightBranch), Interval, Acc, Result) :-
    is_left_out_interval(Root, Interval),
    !,
    btree__sum_by_interval_aux(RightBranch, Interval, Acc, Result).
btree__sum_by_interval_aux(btree(_Root, LeftBranch, _RightBranch), Interval, Acc, Result) :-
    btree__sum_by_interval_aux(LeftBranch, Interval, Acc, Result).


:- begin_tests(btree__sum_by_interval).

test(btree__sum_by_interval, [R == 10]) :- btree__sum_by_interval(
    btree(2,
          btree(7, nil, nil),
          btree(3,
                btree(4, nil, nil),
                btree(1, nil, nil))),
    interval(1, 5),
    R).

:- end_tests(btree__sum_by_interval).

:- run_tests.