% Сформировать базу знаний, cодержащую информацию о автомобилях 
% и их характеристиках.
%    
%  - Подобрать вариант для покупки по заданным условиям.
%
% sandbox: http://swish.swi-prolog.org/p/lw01-kb3.pl

% brand, model, color, rev, price 
car(audi   , 'a6'   , red   , 1 , 2000).
car(bmv    , 'r10'  , green , 0 , 5000).
car(vaz    , '21010', white , 10, 20000).
car(traktor, 'b'    , green , 1 , 30000).
car(shkoda , 're'   , blu   , 2 , 10).
car(citroen, 'e'    , orange, 5 , 56).

byPrice(Brand, Model, Color, Rev, CPrice) :-
    car(Brand, Model, Color, Rev, Price),
    Price =< CPrice.

/** <examples>
?- byPrice(Brand, Model, Color, Rev, 30000).
*/