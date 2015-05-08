% Создать базу знаний с информацией о детях и их родителях.
% Сформировать правило, позволяющее по имени человека определить
% его бабушек или дедушек (бабушку, дедушку).
%
% sandbox: http://swish.swi-prolog.org/p/magic-kb.pl

sex(paul  , male).
sex(albert, male).
sex(vernon, male).
sex(james , male).
sex(harry , male).
sex(dudley, male).

sex(helen  , female).
sex(ruth   , female).
sex(petunia, female).
sex(lili   , female).

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

grand_parent_of(GrandParent, Child, Sex) :-
    sex(GrandParent, Sex),
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