% Сформировать базу знаний, содержащую информацию 
% о вкладчиках разных банков.
% 
%  - Выделить вкладчиков (фамилию) и указать название банка, 
%    в котором вклад больше заданной суммы.
%
% sandbox: http://swish.swi-prolog.org/p/lw01-kb2.pl

% Lastname, Bank, Money
deposit('Ivanov'   , sberbank, 1000).
deposit('Petrov'   , citibank, 5000).
deposit('Skvortcov', rsb     , 4999).
deposit('Smirnov'  , tinkoff , 2999).
deposit('Kozlov'   , rsb     , 10000).
deposit('Novikov'  , sberbank, 3549).
deposit('Kuznecov' , sberbank, 9999).
deposit('Popov'    , tinkoff , 20000).
deposit('Sokolov'  , tinkoff , 20001).
deposit('Lebedev'  , rsb	 , 15499).
deposit('Morozov'  , sberbank, 2500).
deposit('Petrov'   , bm      , 5555).
deposit('Volkov'   , bm      , 300).
deposit('Vasilev'  , rsb     , 7890).
deposit('Pavlov'   , bm      , 200).

depositor(Lastname, Bank, Money, MinMoney):-
    deposit(Lastname, Bank, Money),
    Money > MinMoney.

/** <examples>
?- depositor(Lastname, Bank, Money, 1000).
*/