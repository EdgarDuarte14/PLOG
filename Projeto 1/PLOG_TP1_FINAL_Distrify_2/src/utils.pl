pressEnter:-
	write('Press Enter to continue.'), nl,
	waitEnter, !.

waitEnter:-
	get_char(_).

getChar(Input):-
	get_char(Input),
	get_char(_).

clearScreen:-
	write('\e[2J'). %Clear Screen on 