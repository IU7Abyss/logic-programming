% Найти `A\B`, где `A` и `B` - множестaва.

% Всё множество A рассмотрено => собираем результат
set__complement_aux([], _SetB, _Variants, []) :- !.
% Список вариантов пуст => не найдено совпадение => запомнить значение => продолжить поиск
set__complement_aux([Value | TailSetA], SetB, [], [Value | TailResultSet]) :-
    !,
    set__complement_aux(TailSetA, SetB, SetB, TailResultSet).
% Найдено совпадение => начать новый поиск
set__complement_aux([Value | TailSetA], SetB, [Value | _TailVariants], ResultSet) :-
    !,
    set__complement_aux(TailSetA, SetB, SetB, ResultSet).
% Не найдено совпадение => продолжить
set__complement_aux(SetA, SetB, [_ | TailVariants], ResultSet) :-
    set__complement_aux(SetA, SetB, TailVariants, ResultSet).



set__complement(SetA, SetB, ResultSet) :-
    set__complement_aux(SetA, SetB, SetB, ResultSet).



:- begin_tests(set__complement).

test(set__complement, [R == [1, 3, 5, 7]]) :-
    set__complement([1, 2, 3, 4, 5, 6, 7], [2, 4, 6], R).

:- end_tests(set__complement).

:- run_tests.