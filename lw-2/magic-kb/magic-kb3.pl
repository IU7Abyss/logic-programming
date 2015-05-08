% Создать базу знаний с информацией о детях и их родителях. 
% Сформировать правило, позволяющее по имени человека определить 
% его бабушек или дедушек (бабушку, дедушку).
%
% sandbox: http://swish.swi-prolog.org/p/magic-kb3.pl

% child, father, mother
child_of(petunia, paul  , helen).
child_of(lili   , paul  , helen).
child_of(james  , albert, ruth).
child_of(dudley , vernon, petunia).
child_of(harry  , james , lili).

grand_parent_of(GrandFather, GrandMother, Child) :-
    child_of(Child, Father, Mother),
    (
    	child_of(Father, GrandFather, GrandMother)
    ;	
    	child_of(Mother, GrandFather, GrandMother)
    ).

/** <examples>
?- trace, grand_parents_of(GrandFather, GrandMother, harry).
?- grand_parents_of(GrandFather, _, harry).
?- grand_parents_of(_, GrandMother, harry).

?- trace, grand_parents_of(GrandFather, GrandMother, dudley).
?- grand_parents_of(GrandFather, _, dudley).
?- grand_parents_of(_, GrandMother, dudley).
*/