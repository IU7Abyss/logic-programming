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