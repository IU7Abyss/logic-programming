member(Elem, [Elem | _]) :- !.
member(Elem, [_ | Tail]) :- 
	member(Elem, Tail).


:- begin_tests(member).

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



max([X], X) :- !.

max([H | T], H) :- 
	max(T, M),
	H > M, 
	!.
max([_ | T], M) :- 
	max(T, M).


:- begin_tests(max).

test(max, all(X == [5])) :- max([1, 5, 3, 4, 5], X).
test(max, all(X == [5])) :- max([5, 4, 3, 2, 1], X).
test(max, all(X == [5])) :- max([5, 5, 5, 5, 5], X).

test(max, [fail]) :- max([], 0).

:- end_tests(max).