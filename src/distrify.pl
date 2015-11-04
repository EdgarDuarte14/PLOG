%-----------> Includes <-----------% 
:- use_module(library(lists)).
:- use_module(library(random)).

:- include('menus.pl').
:- include('utils.pl').


%-----------> Lauching the game <------------%
distrify:-
		mainMenu.


%---------> Change the player <---------%
changePlayer(Player, NextPlayer):-
	(Player = 1 -> NextPlayer = 2;
	Player = 2 -> NextPlayer = 1). 

%--------> Main game program <-----------%

play(Game):-
	initialize(Game, Position, Player),
	display_game(Position, Player),
	play(Position, Player, Result).

play(Position, Player, Result):-
	game_over(Position, Player, Result), !, announce(Result).

play(Position, Player, Result):-
	choose_move(Position, Player, Move),
	move(Move, Position, Position1),
	display_game(Position1, Player),
	next_player(Player, Player1),
	!, play(Position1, Player1, Result).

choose_move(Position, computer, Move):-
	findall(M, move(Position, M), Moves),
	evaluate_and_choose(Moves, Position, (nil, -1000), Move).


evaluate_and_choose([Move|Moves], Position, Record, BestMove):-
	move(Move, Position, Position1),
	value(Position1, Value),
	update(Move, Value, Record, Record1),
	evaluate_and_choose(Moves, Position, Record1, Move).
evaluate_and_choose([], Position, (Move, Value), Move).

update(Move, Value, (Move1, Value1), (Move1, Value1)):-
	Value <= Value1.

update(Move, Value, (Move1, Value1), (Move, Value)):-
	Value > Value1.

%-------------> Check path <---------------%

%Check the neighbors of a point

neighbor(Line, Column, Line1, Column1):-
	Column1 is Column + 1,
	Line1 is Line + 1,
	Line1 =< 8,
	Column1 =< 8.


neighbor(Line, Column, Line1, Column1):-
	Column1 is Column + 1,
	Line1 is Line - 1,
	Line1 >= 0,
	Column1 =< 8.


neighbor(Line, Column, Line1, Column1):-
	Column1 is Column - 1,
	Line1 is Line - 1,
	Line1 >= 0,
	Column1 >= 0.


neighbor(Line, Column, Line1, Column1):-
	Column1 is Column - 1,
	Line1 is Line + 1,
	Line1 =< 8,
	Column1 >= 0.


neighbor(Line, Column, Line1, Column1):-
	Column1 is Column + 1,
	Column1 =< 8.


neighbor(Line, Column, Line1, Column1):-
	Column1 is Column - 1,
	Column1 >= 0.


neighbor(Line, Column, Line1, Column1):-
	Line1 is Line + 1,
	Line1 =< 8.


neighbor(Line, Column, Line1, Column1):-
	Line1 is Line - 1,
	Line1 >= 0.

