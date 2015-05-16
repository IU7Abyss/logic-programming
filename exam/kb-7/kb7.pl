% Дан числовой список. 
% Сформировать новый список, перенеся в него
% сначала отрицательные элементы, 
% а потом положительные элементы не меняя порядок.

is_negative(X) :-
    X < 0.

append([], L2, L2) :- !.
append([H | T], L2, [H | TR]) :-
    append(T, L2, TR).

split_by_neg_and_pos([], [], []) :- !.
split_by_neg_and_pos([X | T], [X | NegAcc], PosAcc) :-
    is_negative(X),
    !,
    split_by_neg_and_pos(T, NegAcc, PosAcc).
split_by_neg_and_pos([X | T], NegAcc, [X | PosAcc]) :-
    split_by_neg_and_pos(T, NegAcc, PosAcc).

special_list(List, Result) :-
    split_by_neg_and_pos(List, NegAcc, PosAcc),
    append(NegAcc, PosAcc, Result).


:- begin_tests(special_list).

test(special_list, [R == [-2, -9, -25, 9, 20, 15, 2, 30]]) :- special_list([-2, 9, 20, -9, 15, 2, -25, 30], R).

:- end_tests(special_list).



% Даны числовой список и множество. 
% Удалить из списка все вхождения максимального элемента множества.

set__cut_to_first_number([], []) :- !.
set__cut_to_first_number([X | Set], Result) :-
    atom(X),
    !,
    set__cut_to_first_number(Set, Result).
set__cut_to_first_number(Set, Set) :- !.

set__find_max_number(Set, Max) :-
    set__cut_to_first_number(Set, [X | CuttedSet]),
    set__find_max_number_aux(CuttedSet, X, Max).    

set__find_max_number_aux([], TempMax, TempMax) :-
    atomic(TempMax),
    !.
set__find_max_number_aux([X | Set], TempMax, Result) :-
    number(X),
    X > TempMax,
    !,
    set__find_max_number_aux(Set, X, Result).
set__find_max_number_aux([_ | Set], TempMax, Result) :-
    set__find_max_number_aux(Set, TempMax, Result).

list__delete([], _Element, []) :- !.
list__delete([Element | Tail], Element, ResultList) :-
    list__delete(Tail, Element, ResultList),
    !.
list__delete([NotElement | Tail], Element, [NotElement | ResultTail]) :-
    list__delete(Tail, Element, ResultTail).

list__delete_max_by_set(List, Set, ResultList) :-
    set__find_max_number(Set, Max),
    list__delete(List, Max, ResultList),
    !.
list__delete_max_by_set(List, _, List) :- !.


:- begin_tests(list__delete_max_by_set).

test(list__delete_max_by_set, [R == [1, 2, -5, 9, 6, 6]]) :- 
    list__delete_max_by_set([1, 2, -5, 10, 9, 10, 6, 6], [a, b, c, 3, g, 10, a, 5], R).

test(list__delete_max_by_set, [R == [1, 2, -5, 10, 9, 10, 6, 6]]) :- 
    list__delete_max_by_set([1, 2, -5, 10, 9, 10, 6, 6], [a, b, c], R).
test(list__delete_max_by_set, [R == [1, 2, -5, 10, 9, 10, 6, 6]]) :- 
    list__delete_max_by_set([1, 2, -5, 10, 9, 10, 6, 6], [a, -4, c], R).

:- end_tests(list__delete_max_by_set).



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