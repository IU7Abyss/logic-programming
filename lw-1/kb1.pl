% Сформировать базу знаний, содержащую информацию о студентах:
% фамилия, группа, район проживания, успеваемость, особые условия.
%
% - Выделить студентов одной (заданной) группы.
% - Выделить студентов этой группы, живущих в одном (заданном) районе.
% - Определить условия получения стипендии (правило) и 
%   получить список студентов (только фамилии),
%   которые получают стипендию.
%
% sandbox: http://swish.swi-prolog.org/p/lw01-kb1.pl

% lastname, group, district, grade, condition
student('Ivanov'   , 'IU7-61', 'Strogino'  , 'A', '').
student('Petrov'   , 'IU7-63', 'Chertanovo', 'B', 'scholar').
student('Skvortcov', 'IU7-62', 'Zuzino'    , 'E', '').
student('Smirnov'  , 'IU7-62', 'Bibirevo'  , 'C', 'scholar').
student('Kozlov'   , 'IU7-63', 'Zuzino'    , 'C', 'orphan').
student('Novikov'  , 'IU7-61', 'Zuzino'    , 'D', 'scholar').
student('Kuznecov' , 'IU7-63', 'Arbat'     , 'E', 'scholar').
student('Popov'    , 'IU7-61', 'Zuzino'    , 'B', '').
student('Sokolov'  , 'IU7-62', 'Kuncevo'   , 'A', 'orphan').
student('Lebedev'  , 'IU7-61', 'Kurkino'   , 'B', 'scholar').
student('Morozov'  , 'IU7-61', 'Kuncevo'   , 'B', '').
student('Petrov'   , 'IU7-63', 'Ramenki'   , 'C', 'orphan').
student('Volkov'   , 'IU7-62', 'Strogino'  , 'A', 'orphan').
student('Vasilev'  , 'IU7-63', 'Strogino'  , 'B', 'scholar').
student('Pavlov'   , 'IU7-61', 'Ramenki'   , 'D', 'orphan').

grant(Lastname, Condition) :- 
    student(Lastname, _, _, _, Condition).

/** <examples>
% Students that are in the same group
?- student(Lastname, 'IU7-61', _, _, _).
?- student(Lastname, 'IU7-62', _, _, _).
?- student(Lastname, 'IU7-63', _, _, _).

% Students that are in the same group and district
?- student(Lastname, 'IU7-61', 'Strogino', _, _).

% Students that are have grant
?- grant(Lastname).
*/