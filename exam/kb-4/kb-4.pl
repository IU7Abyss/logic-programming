% Сформировать упорядоченный список из первых `n` штук нечётных чисел.
is_odd(Value) :-
    1 is Value mod 2.

list__gen_odd_aux(_Value, 0, []) :- !.
list__gen_odd_aux(Value, N, [Value | TailResultList]) :-
    NewN is N - 1,
    NewOdd is Value + 2,
    list__gen_odd_aux(NewOdd, NewN, TailResultList).

list__gen_odd(FromValue, N, ResultList) :-
    is_odd(FromValue),
    !,
    list__gen_odd_aux(FromValue, N, ResultList).
list__gen_odd(FromValue, N, ResultList) :-
    OddFromValue is FromValue + 1,
    list__gen_odd_aux(OddFromValue, N, ResultList).


:- begin_tests(list__gen_odd).

test(list__gen_odd, [R == [-3, -1, 1, 3, 5]]) :-
    list__gen_odd(-4, 5, R).

:- end_tests(list__gen_odd).



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



% Найти среднее арифметическое элементов упорядоченного двоичного дерева,
% лежащих в интервале `[3, 12]`.
is_between(Value, interval(LeftBorder, RightBorder)) :-
    LeftBorder < Value,
    Value < RightBorder.

is_left_out_interval(Value, interval(LeftBorder, _RightBorder)) :-
    Value < LeftBorder.


btree__average(BTree, Interval, ResultAvr) :-
    btree__average_aux(BTree, Interval, 0, 0, ResultSum, ResultCount),
    ResultCount > 0,
    ResultAvr is ResultSum / ResultCount.
    
btree__average_aux(nil, _Interval, TempToResultSum, TempToResultCount, TempToResultSum, TempToResultCount) :- !.
btree__average_aux(btree(ValueIsLeftBorder, _LeftBranch, RightBranch), interval(ValueIsLeftBorder, RightBorder), TempSum, TempCount, ResultSum, ResultCount) :-
    !,
    NewSum is TempSum + ValueIsLeftBorder,
    NewCount is TempCount + 1,
    btree__average_aux(RightBranch, interval(ValueIsLeftBorder, RightBorder), NewSum, NewCount, ResultSum, ResultCount).
btree__average_aux(btree(ValueIsRightBorder, LeftBranch, _RightBranch), interval(LeftBorder, ValueIsRightBorder), TempSum, TempCount, ResultSum, ResultCount) :-
    !,
    NewSum is TempSum + ValueIsRightBorder,
    NewCount is TempCount + 1,
    btree__average_aux(LeftBranch, interval(LeftBorder, ValueIsRightBorder), NewSum, NewCount, ResultSum, ResultCount).
btree__average_aux(btree(Value, LeftBranch, RightBranch), Interval, TempSum, TempCount, ResultSum, ResultCount) :-
    is_between(Value, Interval),
    !,
    NewSum is TempSum + Value,
    NewCount is TempCount + 1,
    btree__average_aux(LeftBranch, Interval, NewSum, NewCount, ResultLeftBranchSum, ResultLeftBranchCount),
    btree__average_aux(RightBranch, Interval, ResultLeftBranchSum, ResultLeftBranchCount, ResultSum, ResultCount).
btree__average_aux(btree(Value, _LeftBranch, RightBranch), Interval, TempSum, TempCount, ResultSum, ResultCount) :-
    is_left_out_interval(Value, Interval),
    !,
    btree__average_aux(RightBranch, Interval, TempSum, TempCount, ResultSum, ResultCount).
btree__average_aux(btree(_Value, LeftBranch, _RightBranch), Interval, TempSum, TempCount, ResultSum, ResultCount) :-
    btree__average_aux(LeftBranch, Interval, TempSum, TempCount, ResultSum, ResultCount).


:- begin_tests(btree__average).

test(btree__average, [fail]) :-
    btree__average(
        btree(50, nil, nil),
        interval(3, 12),
        _R).

test(btree__average, [fail]) :-
    btree__average(
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
        interval(77, 79),
        _R).

test(btree__average, [R == 10.5]) :-
    btree__average(
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
        interval(3, 12),
        R).

:- end_tests(btree__average).

:- run_tests.