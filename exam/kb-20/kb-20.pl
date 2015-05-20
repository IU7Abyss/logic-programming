% Problem 1
% В числовом списке поменять местами минимальный и
% последний элементы (минимум уникален)

list__min([], ResultMin, ResultMin) :- !.
list__min([Value | TailList], TempMin, ResultMin) :-
    Value =< TempMin,
    !,
    list__min(TailList, Value, ResultMin).
list__min([_Value | TailList], TempMin, ResultMin) :-
    list__min(TailList, TempMin, ResultMin).


list__last_value([LastValue | []], LastValue) :- !.
list__last_value([_Value | TailList], Result) :-
    list__last_value(TailList, Result).


list__magic_swap_aux([_ | []], Min, [Min]) :- !.
list__magic_swap_aux([Min | TailList], Min, [LastValue | TailResultList]) :-
    !,
    list__last_value(TailList, LastValue),
    list__magic_swap_aux(TailList, Min, TailResultList).
list__magic_swap_aux([Value | TailList], Min, [Value | TailResultList]) :-
    list__magic_swap_aux(TailList, Min, TailResultList).


list__magic_swap([Head | TailList], ResultList) :-
    list__min(TailList, Head, Min),
    list__magic_swap_aux([Head | TailList], Min, ResultList).


% list__magic_swap([5, 2, 1, 4, 10], R).



% Problem 2
% Добавить в упорядоченный по невозрастанию список
% элементы заданного множества, не нарушив порядок

list__insert([], Value, [Value]) :- !.
list__insert([V1 | TailList], Value, [V1 | TailResult]) :-
    V1 >= Value,
    !,
    list__insert(TailList, Value, TailResult).
list__insert([V1 | TailList], Value, [Value, V1 | TailList]) :- !.


list__insert_by_set(ResultList, [], ResultList) :- !.
list__insert_by_set(List, [Value | TailSet], ResultList) :-
    list__insert(List, Value, TempList),
    list__insert_by_set(TempList, TailSet, ResultList).


% list__insert_by_set([5, 4, 2, 1], [10, 8, 7, 9, 5], R). 


% Problem 3
% Определить количество элементов упорядоченного двоичного дерева,
% совпадающих с элементами множества

is_member(Value, [Value | _TailSet]) :- !.
is_member(Value, [_Value | TailSet]) :-
    is_member(Value, TailSet).


btree__count_by_set_aux(nil, _Set, ResultCount, ResultCount) :- !.
btree__count_by_set_aux(btree(Value, LeftBranch, RightBranch), Set, AccCount, Count) :-
    is_member(Value, Set),
    !,
    NewAccCount is AccCount + 1,
    btree__count_by_set_aux(LeftBranch, Set, NewAccCount, TempCount),
    btree__count_by_set_aux(RightBranch, Set, TempCount, Count).
btree__count_by_set_aux(btree(_Value, LeftBranch, RightBranch), Set, AccCount, Count) :-
    btree__count_by_set_aux(LeftBranch, Set, AccCount, TempCount),
    btree__count_by_set_aux(RightBranch, Set, TempCount, Count).


btree__count_by_set(BTree, Set, ResultCount) :-
    btree__count_by_set_aux(BTree, Set, 0, ResultCount).

% btree__count_by_set(
%         btree(5,
%               btree(3,
%                     btree(2,
%                           btree(1, nil, nil),
%                           nil),
%                     btree(4, nil, nil)),
%               btree(7,
%                     btree(6, nil, nil),
%                     btree(8, nil, nil))),
%         [4, 2, 6],
%         Count).