% Добавить в упорядоченное двоичное дерево 
% первые три элемента множества, 
% если они отсутствуют в дереве.

btree__insert(btree(Value, _, _), Value, _) :- !, fail.
btree__insert(nil, Value, btree(Value, nil, nil)) :- !.
btree__insert(btree(Root, LBranch, RBranch), Value, btree(Root, NewLBranch, RBranch)) :-
    Value < Root,
    !,
    btree__insert(LBranch, Value, NewLBranch).
btree__insert(btree(Root, LBranch, RBranch), Value, btree(Root, LBranch, NewRBranch)) :-
    btree__insert(RBranch, Value, NewRBranch).

btree__add_first_n_element_from_set(BTree, Set, N, ResultBTree) :-
    set__cut_to_first_number(Set, NewSet),
    btree__add_first_n_element_from_set_aux(BTree, NewSet, N, ResultBTree).
    
btree__add_first_n_element_from_set_aux(ResultBTree, _Set, 0, ResultBTree) :- !.
btree__add_first_n_element_from_set_aux(ResultBTree, [], _N, ResultBTree) :- !.
btree__add_first_n_element_from_set_aux(BTree, [Value | TailCuttedSet], N, ResultBTree) :-
    btree__insert(BTree, Value, PreResultBTree),
    !,
    It is N - 1,
    btree__add_first_n_element_from_set(PreResultBTree, TailCuttedSet, It, ResultBTree).
btree__add_first_n_element_from_set_aux(BTree, [_ | TailCuttedSet], N, ResultBTree) :-
    btree__add_first_n_element_from_set(BTree, TailCuttedSet, N, ResultBTree).


:- begin_tests(btree__add_first_n_element_from_set).

test(btree__add_first_n_element_from_set, [R == btree(5, btree(3, btree(2, nil, nil), btree(4, nil, nil)), btree(7, nil, nil))]) :-
    btree__add_first_n_element_from_set(btree(5, btree(3, btree(2, nil, nil), btree(4, nil, nil)), btree(7, nil, nil)), [a, b, c], 3, R).

test(btree__add_first_n_element_from_set, [R == btree(5, btree(3, btree(2, btree(1, nil, nil), nil), btree(4, nil, nil)), btree(7, btree(6, nil, nil), btree(8, nil, nil)))]) :-
    btree__add_first_n_element_from_set(btree(5, btree(3, btree(2, nil, nil), btree(4, nil, nil)), btree(7, nil, nil)), [a, b, 2, 6, c, 1, d, 7, e, 8, 3, 9, 10], 3, R).

:- end_tests(btree__add_first_n_element_from_set).

:- run_tests.