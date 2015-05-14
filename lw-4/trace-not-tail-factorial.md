# Not tail factorial

```prolog
(1) not_tail_factorial(0, 1) :- !.
(2) not_tail_factorial(1, 1) :- !.
(3) not_tail_factorial(N, R) :-
(4) 	NewN is N - 1,
(5)    	not_tail_factorial(NewN, NewR),
(6)    	R is N * NewR.
```

```prolog
?- not_tail_factorial(3, R).
```

- ТР: `not_tail_factorial(3, R)`.
- Шаг 1.1:
	+ ТЦ: `not_tail_factorial(3, R)`.
	+ ПР4: `3 = N`, `R = R`.
	+ ТР: `NewN_1 is 3 - 1`, `not_tail_factorial(NewN_1, NewR_1)`, `R is 3 * NewR_1`.
- Шаг 1.2:
	+ ТЦ: `NewN_1 is 3 - 1` => `{ NewN_1 = 2 }`.
	+ ТР: `not_tail_factorial(2, NewR_1)`, `R is 3 * NewR_1`.
	- Шаг 2.1:
		+ ТЦ: `not_tail_factorial(2, NewR_1)`
		+ ПР4: `2 = N`, `NewR_1 = R`
		+ ТР: `NewN_2 is 2 - 1`, `not_tail_factorial(NewN_2, NewR_2)`, `NewR_1 is 2 * NewR_2`, `R is 3 * NewR_1`.
	- Шаг 2.2:
		+ ТЦ: `NewN_2 is 2 - 1` => `{ NewN_2 = 1 }`
		+ ТР: `not_tail_factorial(1, NewR_2)`, `NewR_1 is 2 * NewR_2`, `R is 3 * NewR_1`.
		- Шаг 3.3.1:
			+ ТЦ: `not_tail_factorial(1, NewR_2)`
			+ ПР2: `1 = 1`, `1 = NewR_2`
			+ ТР: `!`, `NewR_1 is 2 * 1`, `R is 3 * NewR1`
		- Шаг 3.3.2:
			+ ТЦ: `!` => `true`
			+ ТР: `NewR_1 is 2 * 1`, `R is 3 * NewR_1`
	- Шаг 2.3
		+ ТЦ: `NewR_1 is 2 * 1` => `{ NewR_1 = 2 }`.
		+ ТР: `R is 3 * 2`
- Шаг 3.3
	+ ТЦ: `R is 3 * 2` => `{ R = 6 }`