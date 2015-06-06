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