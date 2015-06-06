% Удвоить все элементы упорядоченного двоичного дерева, больше `10`.

btree__double(nil, nil) :- !.
btree__double(btree(Root, LeftBranch, RightBranch), btree(NewRoot, NewLeftBranch, NewRightBranch)) :-
    Root > 10,
    !,
    NewRoot is Root * 2,
    btree__double(LeftBranch, NewLeftBranch),
    btree__double(RightBranch, NewRightBranch).
btree__double(btree(Root, LeftBranch, RightBranch), btree(Root, LeftBranch, NewRightBranch)) :-
    btree__double(RightBranch, NewRightBranch).


:- begin_tests(btree__double).

test(btree__double,
     [R == btree(100,
                 btree(34,
                       btree(24,
                             btree(9, nil, nil),
                             btree(28, nil, nil)),
                       btree(46,
                             btree(38, nil, nil),
                             nil)),
                 btree(144,
                       btree(108,
                             nil,
                             btree(134, nil, nil)),
                       btree(152, nil, nil)))]) :-
    btree__double(
        btree(50,
              btree(17,
                    btree(12,
                          btree(9, nil, nil),
                          btree(14, nil, nil)),
                    btree(23,
                          btree(19, nil, nil),
                          nil)),
              btree(72,
                    btree(54,
                          nil,
                          btree(67, nil, nil)),
                    btree(76, nil, nil))),
        R).

:- end_tests(btree__double).

:- run_tests.