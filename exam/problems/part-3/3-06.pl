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