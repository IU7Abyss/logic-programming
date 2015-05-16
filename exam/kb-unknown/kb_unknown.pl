% Составить список из элементов исходного числового списка, элементы которого кратны 3.

list_mod3([], []) :- !.
list_mod3([X | T], [X | R]) :-
	X mod 3 =:= 0,
	list_mod3(T, R),
    !.
list_mod3([_ | T], R) :-
    list_mod3(T, R).


:- begin_tests(list_mod3).

test(list_mod3, [R == []]) :- list_mod3([], R).

test(list_mod3, [R == []]) :- list_mod3([1, 2, 4], R).

test(list_mod3, [R == [6, 33, -3, 9, -9]]) :- list_mod3([121, -5, 6, 1, 33, -3, 2, 9, -9], R).

:- end_tests(list_mod3).



% Объединить 2 множества

is_set_member(X, [X | _]) :- !.
is_set_member(X, [_ | T]) :-
    is_set_member(X, T).

set_union(S, S, S) :- !.
set_union([], S2, S2) :- !.
set_union(S1, [], S1) :- !.
set_union(S1, S2, R) :-
    set_union_aux(S1, S2, S1, R).

set_union_aux(_S1, [], Acc, Acc) :- !.
set_union_aux(S1, [X2 | T2], Acc, R) :-
    is_set_member(X2, S1),
    set_union_aux(S1, T2, Acc, R),
    !.
set_union_aux(S1, [X2 | T2], Acc, R) :-
    set_union_aux(S1, T2, [X2 | Acc], R).


:- begin_tests(set_union).

test(set_union, [R == []]) :- set_union([], [], R).

test(set_union, [R == [1, 2, 3]]) :- set_union([1, 2, 3], [], R).
test(set_union, [R == [1, 2, 3]]) :- set_union([], [1, 2, 3], R).

test(set_union, [R == [1, 2, 3]]) :- set_union([1, 2, 3], [3, 2, 1], R).
test(set_union, [R == [5, 4, 0, 1, 2, 3]]) :- set_union([0, 1, 2, 3], [3, 4, 5, 0], R).

:- end_tests(set_union).



% Создать список из элементов упорядоченного дерева, лежащих в диапазоне [-2, 5].

is_in_diapason(X, L, R) :-
    L =< X, 
    X =< R.
is_out_left(X, L) :-
    X =< L.

btree_select_in_diapason(btree(Root, LBranch, RBranch), LBorder, RBorder, Result) :-
    btree_select_in_diapason_aux(btree(Root, LBranch, RBranch), LBorder, RBorder, [], Result).

btree_select_in_diapason_aux(nil, _, _, Acc, Acc) :- !.
btree_select_in_diapason_aux(btree(Root, LBranch, RBranch), LBorder, RBorder, Acc, Result) :-
    is_in_diapason(Root, LBorder, RBorder),
    !,
    btree_select_in_diapason_aux(LBranch, LBorder, RBorder, Acc, Result1),
    btree_select_in_diapason_aux(RBranch, LBorder, RBorder, [Root | Result1], Result).
btree_select_in_diapason_aux(btree(Root, _, RBranch), LBorder, RBorder, Acc, Result) :-
    is_out_left(Root, LBorder),
    !,
    btree_select_in_diapason_aux(RBranch, LBorder, RBorder, Acc, Result).
btree_select_in_diapason_aux(btree(_, LBranch, _), LBorder, RBorder, Acc, Result) :-
    btree_select_in_diapason_aux(LBranch, LBorder, RBorder, Acc, Result).

% test
% ?- btree_select_in_diapason(btree(3, btree(1, btree(-1, nil, nil), btree(2, nil, nil)), btree(5, nil, btree(7, nil, nil))), -2, 5, Res).