%-----------> Includes <-----------% 
:- use_module(library(lists)).
:- use_module(library(random)).

:- include('menus.pl').
:- include('utils.pl').
:- include('print.pl').

%-----------> Lauching the game <------------%
distrify:-
		mainMenu.


%---------> Change the player <---------%
changePlayer(Player, NextPlayer):-
	(Player = 1 -> NextPlayer = 2;
	Player = 2 -> NextPlayer = 1). 

%--------> Main game program <-----------%


