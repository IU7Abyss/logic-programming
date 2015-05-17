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



% Найти `A\B`, где `A` и `B` - множестaва.
% Всё множество A рассмотрено => собираем результат
set__complement_aux([], _SetB, _Variants, []) :- !.
% Список вариантов пуст => не найдено совпадение => запомнить значение => продолжить поиск
set__complement_aux([Value | TailSetA], SetB, [], [Value | TailResultSet]) :-
    !,
    set__complement_aux(TailSetA, SetB, SetB, TailResultSet).
% Найдено совпадение на итерации => начать новый поиск
set__complement_aux([Value | TailSetA], SetB, [Value | _TailVariants], ResultSet) :-
    !,
    set__complement_aux(TailSetA, SetB, SetB, ResultSet).
% Не найдено совпадение на итерации => продолжить
set__complement_aux(SetA, SetB, [_ | TailVariants], ResultSet) :-
    set__complement_aux(SetA, SetB, TailVariants, ResultSet).

set__complement(SetA, SetB, ResultSet) :-
    set__complement_aux(SetA, SetB, SetB, ResultSet).

:- begin_tests(set__complement).

test(set__complement, [R == [1, 3, 5, 7]]) :-
    set__complement([1, 2, 3, 4, 5, 6, 7], [2, 4, 6], R).

:- end_tests(set__complement).



% Удвоить все элементы упорядоченного двоичного дерева, больше `10`.
btree__double(nil, nil) :- !.
btree__double(btree(Root, LeftBranch, RightBranch), btree(NewRoot, NewLeftBranch, NewRightBranch)) :-
    Root > 10,
    !,
    NewRoot is Root * 2,
    btree__double(LeftBranch, NewLeftBranch),
    btree__double(RightBranch, NewRightBranch).
btree__double(btree(Root, LeftBranch, RightBranch), btree(Root, LeftBranch, NewRightBranch)) :-
    btree__double(RightBranch, NewRightBranch).


:- begin_tests(btree__double).

test(btree__double,
     [R == btree(100,
                 btree(34,
                       btree(24,
                             btree(9, nil, nil),
                             btree(28, nil, nil)),
                       btree(46,
                             btree(38, nil, nil),
                             nil)),
                 btree(144,
                       btree(108,
                             nil,
                             btree(134, nil, nil)),
                       btree(152, nil, nil)))]) :-
    btree__double(
        btree(50,
              btree(17,
                    btree(12,
                          btree(9, nil, nil),
                          btree(14, nil, nil)),
                    btree(23,
                          btree(19, nil, nil),
                          nil)),
              btree(72,
                    btree(54,
                          nil,
                          btree(67, nil, nil)),
                    btree(76, nil, nil))),
        R).

:- end_tests(btree__double).

:- run_tests.