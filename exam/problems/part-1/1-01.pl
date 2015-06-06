% Все элементы исходного списка удвоить,
% если сумма его первых двух элементов больше `0`
% и уменьшить на `10` в противном случае.

list__sum_aux([], Acc, Acc) :- !.
list__sum_aux([Value | TailList], Acc, Sum) :-
    IncAcc is Acc + Value,
    list__sum_aux(TailList, IncAcc, Sum).

list__sum(List, Sum) :-
    list__sum_aux(List, 0, Sum).

list__is_great_sum(List, Condition) :-
    list__sum(List, Sum),
    Sum > Condition.

list__multi([], _CMulti, []) :- !.
list__multi([Value | TailList], CMulti, [X | TailResultList]) :-
    X is Value * CMulti,
    list__multi(TailList, CMulti, TailResultList).

list__dec([], _CDec, []) :- !.
list__dec([Value | TailList], CDec, [X | TailResultList]) :-
    X is Value - CDec,
    list__dec(TailList, CDec, TailResultList).

list__multi_or_dec([V1, V2 | TailList], ConditionForDouble, CMulti, _CDec, ResultList) :-
    list__is_great_sum([V1, V2], ConditionForDouble),
    !,
    list__multi([V1, V2 | TailList], CMulti, ResultList).
list__multi_or_dec(List, _ConditionForDouble, _CMulti, CDec, ResultList) :-
    list__dec(List, CDec, ResultList).



list__double_or_dec_by_10(List, ResultList) :-
    list__multi_or_dec(List, 0, 2, 10, ResultList).



:- begin_tests(list__double_or_dec_by_10).

test(list__double_or_dec_by_10, [R == []]) :-
    list__double_or_dec_by_10([], R).

test(list__double_or_dec_by_10, [R == [-10]]) :-
    list__double_or_dec_by_10([0], R).

test(list__double_or_dec_by_10, [R == [0, 2, 4, 6, 8]]) :-
    list__double_or_dec_by_10([0, 1, 2, 3, 4], R).

test(list__double_or_dec_by_10, [R == [-11, -12, -10, -9, -8, -7, -6]]) :-
    list__double_or_dec_by_10([-1, -2, 0, 1, 2, 3, 4], R).

:- end_tests(list__double_or_dec_by_10).

:- run_tests.