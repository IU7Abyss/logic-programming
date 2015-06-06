% Сформировать упорядоченный список из первых `n` штук нечётных чисел.

is_odd(Value) :-
    1 is Value mod 2.

list__gen_odd_aux(_Value, 0, []) :- !.
list__gen_odd_aux(Value, N, [Value | TailResultList]) :-
    NewN is N - 1,
    NewOdd is Value + 2,
    list__gen_odd_aux(NewOdd, NewN, TailResultList).

list__gen_odd(FromValue, N, ResultList) :-
    is_odd(FromValue),
    !,
    list__gen_odd_aux(FromValue, N, ResultList).
list__gen_odd(FromValue, N, ResultList) :-
    OddFromValue is FromValue + 1,
    list__gen_odd_aux(OddFromValue, N, ResultList).



:- begin_tests(list__gen_odd).

test(list__gen_odd, [R == [-3, -1, 1, 3, 5]]) :-
    list__gen_odd(-4, 5, R).

:- end_tests(list__gen_odd).

:- run_tests.