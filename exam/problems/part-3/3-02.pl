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