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

:- run_tests.