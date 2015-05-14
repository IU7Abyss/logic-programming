quick_sort(List, Sorted) :-
    quick_sort_aux(List, [], Sorted).

quick_sort_aux([], Acc, Acc) :- !.
quick_sort_aux([H | T], Acc, Sorted) :-
	split_by(H, T, L2, L1),
	quick_sort_aux(L1, Acc, Sorted1),
    quick_sort_aux(L2, [H | Sorted1], Sorted).

split_by(_, [], [], []) :- !.
split_by(H, [X | T], [X | LS], RS) :- 
    X =< H, 
    split_by(H, T, LS, RS), 
    !.
split_by(H, [X | T], LS, [X | RS] ) :- 
    split_by(H, T, LS, RS).


:- begin_tests(quick_sort).

test(quick_sort, [R == [-1, 2, 3, 4, 5, 8, 10, 10, 12]]) :- quick_sort([5, 3, 4, 10, 10, 2, 8, -1, 12], R).

:- end_tests(quick_sort).