member(X, [X | _]) :- !.
member(X, [_ | T]) :- 
    member(X, T).


:- begin_tests(member).

test(member, [fail]) :- member([], []).
test(member, [fail]) :- member(1, []).

test(member, [true]) :- member([], [[]]).

test(member, [fail]) :- member(1, [2, 3, 4]).

test(member, [true]) :- member(1, [1, 2 ,3]).

:- end_tests(member).



reverse(L, RL) :-
    reverse(L, [], RL). 

reverse([], Buf, Buf) :- !.
reverse([H | T], Buf, RL) :-
    reverse(T, [H | Buf], RL).


:- begin_tests(reverse).

test(reverse, [X == [1, 2, 3, 4, 5]]) :- reverse([5, 4, 3, 2, 1], X).

test(reverse, [X == []]) :- reverse([], X).
test(reverse, [X == [[]]]) :- reverse([[]], X).
test(reverse, [X == [[], []]]) :- reverse([[], []], X).

test(reverse, [X == [[], 1]]) :- reverse([1, []], X).
test(reverse, [X == [1, []]]) :- reverse([[], 1], X).

:- end_tests(reverse).



append([], L2, L2) :- !.
append([H | T], L2, [H | TR]) :-
    append(T, L2, TR).


:- begin_tests(append).

test(append, [X == []]) :- append([], [], X).

test(append, [X == [1]]) :- append([1], [], X).
test(append, [X == [1]]) :- append([], [1], X).

test(append, [X == [3, 2, 1, 0]]) :- append([3, 2], [1, 0], X).

test(append, [X == [3, 2, []]]) :- append([3, 2], [[]], X).
test(append, [X == [[], 3, 2]]) :- append([[]], [3, 2], X).

:- end_tests(append).



delete([], _Element, []) :- !.
delete([Element | T], Element, RT) :-
    delete(T, Element, RT),
    !.
delete([H | T], Element, [H | RT]) :-
    delete(T, Element, RT).


:- begin_tests(delete).

test(delete, [X == []]) :- delete([1, 1, 1], 1, X).

test(delete, [X == [1, 3, 4]]) :- delete([1, 5, 3, 5, 4], 5, X).

:- end_tests(delete).




max([Max], Max) :- !.
max([CurMax | T], Max) :-
    max_aux(T, CurMax, Max).

max_aux([], Max, Max) :- !.
max_aux([H | T], CurMax, Max) :-
    H > CurMax,
    max_aux(T, H, Max),
    !.
max_aux([_ | T], CurMax, Max) :-
    max_aux(T, CurMax, Max).


:- begin_tests(max).

test(max, [fail]) :- max([], _).

test(max, [X == 1]) :- max([1], X).
test(max, [X == 1]) :- max([1, 1, 1, 1], X).

test(max, [X == 2]) :- max([2, 1, 1, 1], X).
test(max, [X == 2]) :- max([1, 1, 1, 2], X).
test(max, [X == 2]) :- max([1, 1, 2, 1], X).

test(max, [X == 5]) :- max([1, 5, 3, 4, 5], X).
test(max, [X == 5]) :- max([5, 4, 3, 2, 1], X).

test(max, [X == 25]) :- max([5, 4, 10, 12, 1, 25, 0], X).
test(max, [X == 25]) :- max([5, 25, 10, 12, 1, 9, 0], X).

:- end_tests(max).