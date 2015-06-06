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