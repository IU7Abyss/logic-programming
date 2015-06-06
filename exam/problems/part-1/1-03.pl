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