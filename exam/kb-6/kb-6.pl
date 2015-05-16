% Создать новый упорядоченный список из элементов исходного списка,
% лежащих в интервале [-2, 10]

quick_sort(List, SortedList) :-
    quick_sort_aux(List, [], SortedList).

quick_sort_aux([], Acc, Acc) :- !.
quick_sort_aux([Pivot | TailList], Acc, SortedList) :-
    split_by(Pivot, TailList, List2, List1),
    quick_sort_aux(List1, Acc, SortedList1),
    quick_sort_aux(List2, [Pivot | SortedList1], SortedList).

split_by(_, [], [], []) :- !.
split_by(Pivot, [Value | TailList], [Value | LeftSortedList], RightSortedList) :-
    Value =< Pivot,
    !,
    split_by(Pivot, TailList, LeftSortedList, RightSortedList).
split_by(Pivot, [Value | TailList], LeftSortedList, [Value | RightSortedList] ) :-
    split_by(Pivot, TailList, LeftSortedList, RightSortedList).


is_in_interval(Value, interval(LeftBorder, RightBorder)) :-
    LeftBorder =< Value,
    Value =< RightBorder.


list__values_in_interval([], _, []) :- !.
list__values_in_interval([Value | TailList], interval(LeftBorder, RightBorder), [Value | ResultList]) :-
    is_in_interval(Value, interval(LeftBorder, RightBorder)),
    !,
    list__values_in_interval(TailList, interval(LeftBorder, RightBorder), ResultList).
list__values_in_interval([_Value | TailList], interval(LeftBorder, RightBorder), ResultList) :-
    list__values_in_interval(TailList, interval(LeftBorder, RightBorder), ResultList).


list__sort_in_interval(List, interval(LeftBorder, RightBorder), ResultList) :-
    list__values_in_interval(List, interval(LeftBorder, RightBorder), TempList),
    quick_sort(TempList, ResultList).



% Проверить, является первое множество подмножеством второго.

set__is_memeber(Value, [Value | _TailSet]) :- !.
set__is_memeber(Value, [_Value | TailSet]) :-
    set__is_memeber(Value, TailSet).

set__is_subset([], _Set) :- !.
set__is_subset([Value | TailSubSet], Set) :-
    set__is_memeber(Value, Set),
    !,
    set__is_subset(TailSubSet, Set).
    

:- begin_tests(set__is_subset).

test(set__is_subset, [fail]) :- set__is_subset([3, 1, 0, 10, 90], [-1, 3, 2, 5, 9, 7, -100, 1, 0, -9, 12, 11, 10]).
test(set__is_subset, [true]) :- set__is_subset([3, 1, 0, 10], [-1, 3, 2, 5, 9, 7, -100, 1, 0, -9, 12, 11, 10]).

:- end_tests(set__is_subset).



% Определить высоту дерева (наибольшую длину пути от корня дерева до его листа).

btree__height(btree(Root, LeftBranch, RightBranch), ResultHeight) :-
    btree__height_aux(btree(Root, LeftBranch, RightBranch), 0, 0, ResultHeight).

btree__height_aux(nil, TempHeight, CurrentHeight, CurrentHeight) :-
    CurrentHeight >= TempHeight,
    !.
btree__height_aux(nil, TempHeight, _CurrentHeight, TempHeight) :- !.
btree__height_aux(btree(_Root, LeftBranch, RightBranch), TempHeight, Acc, ResultHeight) :-
    CurrentHeight is Acc + 1,
    btree__height_aux(LeftBranch, TempHeight, CurrentHeight, LeftBranchHeight),
    btree__height_aux(RightBranch, LeftBranchHeight, CurrentHeight, ResultHeight).


:- begin_tests(btree__height).

test(btree__height, [R == 1]) :- btree__height(btree(1, nil, nil), R).
test(btree__height, [R == 4]) :-
    btree__height(
        btree(5,
              btree(3,
                    btree(2,
                          btree(1, nil, nil),
                          nil),
                    btree(4, nil, nil)),
              btree(7,
                    btree(6, nil, nil),
                    btree(8, nil, nil))),
        R).
test(btree__height, [R == 3]) :-
    btree__height(
        btree(5,
              btree(3,
                    btree(2, nil, nil),
                    btree(4, nil, nil)),
              btree(7, nil, nil)),
        R).

:- end_tests(btree__height).

:- run_tests.