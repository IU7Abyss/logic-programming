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