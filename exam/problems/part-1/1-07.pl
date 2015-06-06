% Составить список из элементов исходного числового списка, элементы которого кратны 3.

list_mod3([], []) :- !.
list_mod3([X | T], [X | R]) :-
	X mod 3 =:= 0,
	list_mod3(T, R),
    !.
list_mod3([_ | T], R) :-
    list_mod3(T, R).


:- begin_tests(list_mod3).

test(list_mod3, [R == []]) :- list_mod3([], R).

test(list_mod3, [R == []]) :- list_mod3([1, 2, 4], R).

test(list_mod3, [R == [6, 33, -3, 9, -9]]) :- list_mod3([121, -5, 6, 1, 33, -3, 2, 9, -9], R).

:- end_tests(list_mod3).

:- run_tests.