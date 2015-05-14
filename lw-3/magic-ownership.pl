% Сформировать базу знаний с информацией о собственниках и 
% их собственности. Собственность может быть разных видов, 
% т.е. обладать разными характеристиками.
% 
% Выделить землевладельцев.
% 
% Подсчитать стоимость всех видов собственности одного (каждого)
% собственника.

% person id, first name, last name, sex
person(1, "Vernon"  , "Dursley", male).
person(2, "Petunia" , "Dursley", female).
person(3, "Marjorie", "Dursley", female).
person(4, "Dudley"  , "Dursley", female).
person(5, "Lily"    , "Potter" , female).
person(6, "James"   , "Potter" , male).
person(7, "Harry"   , "Potter" , male).
person(8, "Arthur"  , "Weasley", male).


person_id(FirstName, LastName, ID) :-
    person(ID, FirstName, LastName, _).


person_full_name(PersonID, FirstName, LastName) :-
    person(PersonID, FirstName, LastName, _).


% person id
has_ownership(1).
has_ownership(2).
has_ownership(3).
has_ownership(8).


% person id, item, year of acquisition, cost
ownership(1, car("Vauxhall", "Chevette", red, 1991), 1991, 2000).
ownership(2, house("4 Privet Drive", 1970), 1980, 5000).
ownership(3, land("Unknown2", 30), 1981, 14500).
ownership(8, land("Unknown0", 20), 1971, 10000).
ownership(8, land("Unknown1", 25), 1972, 15000).
ownership(8, car("Ford", "Anglia 105E Deluxe", lightblue, 1990), 1992, 1000).


count_ownership(PersonID, Count) :-
    has_ownership(PersonID),
    aggregate_all(count, ownership(PersonID, _, _, _), Count).

    
cost_of_ownership(PersonID, Cost) :-
    ownership(PersonID, _, _, Cost).


total_cost_of_ownership(FirstName, LastName, Total) :-
    person_id(FirstName, LastName, PersonID),
    total_cost_of_ownership(PersonID, Total).   

total_cost_of_ownership(PersonID, Total) :-
    has_ownership(PersonID),
    aggregate_all(sum(Cost), cost_of_ownership(PersonID, Cost), Total).


landowner(FirstName, LastName) :-
    person_id(FirstName, LastName, PersonID),
    landowner(PersonID).

landowner(PersonID) :-
    has_ownership(PersonID),
    landowner_aux(PersonID).

landowner_aux(PersonID) :-
    ownership(PersonID, land(_, _), _, _),
    !.


% Защита
% tax type, rate
tax(car, 0.1).
tax(land, 0.4).
tax(house, 0.2). 

count_tax(PersonID, FirstName, LastName, TaxType, ResultTax) :-
    ownership(PersonID, Own, _, Cost),
    functor(Own, TaxType, _),
    person_id(FirstName, LastName, PersonID), 
    tax(TaxType, TaxRate), 
    ResultTax is Cost * TaxRate. 


/** <examples>
?- landowner(FirstName, LastName).

?- PID = 8, total_cost_of_ownership(PID, Total), person_full_name(PID, FirstName, LastName).

?- total_cost_of_ownership(FirstName, LastName, Cost).

% защита
?- count_tax(8, FirstName, LastName, ResultTax, Type).
?- count_tax(_, FirstName, LastName, ResultTax, Type).
*/ 