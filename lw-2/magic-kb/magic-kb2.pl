% Создать базу знаний с информацией о детях и их родителях. 
% Сформировать правило, позволяющее по имени человека определить 
% его бабушек или дедушек (бабушку, дедушку).
%
% sandbox: http://swish.swi-prolog.org/p/magic-kb2.pl

man(paul).
man(albert).
man(vernon).
man(james).
man(harry).
man(dudley).

woman(helen).
woman(ruth).
woman(petunia).
woman(lili).

parent_of(paul   , petunia).
parent_of(helen  , petunia).
parent_of(paul   , lili).
parent_of(helen  , lili).
parent_of(albert , james).
parent_of(ruth   , james).
parent_of(petunia, dudley).
parent_of(vernon , dudley).
parent_of(lili   , harry).
parent_of(james  , harry).

grand_parent_of(GrandParent, Child, male) :-
    man(GrandParent),
    parent_of(GrandParent, Parent),
    parent_of(Parent, Child).

grand_parent_of(GrandParent, Child, female) :-
    woman(GrandParent),
    parent_of(GrandParent, Parent),
    parent_of(Parent, Child).

/** <examples>
?- grand_parent_of(GrandParentName, harry, _).
?- grand_parent_of(GrandParentName, harry, female).
?- grand_parent_of(GrandParentName, harry, male).

?- grand_parent_of(GrandParentName, dudley, _).
?- grand_parent_of(GrandParentName, dudley, female).
?- grand_parent_of(GrandParentName, dudley, male). 
*/