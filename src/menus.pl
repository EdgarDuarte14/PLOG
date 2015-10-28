%=================%
%= @@ game menus =%
%=================%

mainMenu:- 
	printMainMenu,
	getChar(Input),
	(
		Input = '1' -> gameModeMenu, mainMenu;
		Input = '2' -> helpMenu, mainMenu;
		Input = '3' -> aboutGameMenu, mainMenu;
		Input = '4';

		nl,
		write('Error: Invalid input.'), nl,
		pressEnter, nl,
		mainMenu
	).

printMainMenu:-
	write('                                 '), nl,
	write('       ===> Distrify <===        '), nl,
	write('                                 '), nl,
	write('================================='), nl,
	write('=   1. Play                     ='), nl,
	write('=   2. Instructions             ='), nl,
	write('=   3. About the game           ='), nl,
	write('=   4. Exit                     ='), nl,
	write('================================='), nl,
	write('Choose your game option:'), nl.


gameModeMenu:-
	printGameModeMenu,
	getChar(Input),
	(
		Input = '1' -> playerVsPlayer;
		Input = '2' -> playerVsComputer;
		Input = '3' -> computerVsComputer;
		Input = '4';

		nl,
		write('Error: Invalid input.'), nl,
		pressEnter, nl,
		gameModeMenu
	).

printGameModeMenu:-
	write('                                  '), nl,
	write('      ===> Game Options <===      '), nl,
	write('                                  '), nl,
	write('=================================='), nl,
	write('=   1. Player vs Player          ='), nl,
	write('=   2. Player vs Computer        ='), nl,
	write('=   3. Computer vs Computer      ='), nl,
	write('=   4. Previous Menu             ='), nl,
	write('=================================='), nl,
	write('Choose your game option:'), nl.

playerVsPlayer:-
	write('                                          '), nl,
	write('       ==> Player vs Player choosen       '), nl,
	write('                                          '), nl,
	pressEnter, nl.


playerVsComputer:-
	write('                                         '), nl,
	write('      ==> Player vs Computer choosen     '), nl,
	write('                                         '), nl,
	pressEnter, nl.


computerVsComputer:-
	write('                                          '), nl,
	write('     ==> Computer vs Computer choosen     '), nl,
	write('                                          '), nl,
	pressEnter, nl.


helpMenu:-
	write('                                                                     '), nl,
	write('                       ===> How to play <===                         '), nl,
	write('                                                                     '), nl,
	write('====================================================================='), nl,
	write('=                                                                   ='), nl,
	write('=   Distrify is a board game where you have to beat your opponent   ='), nl,
	write('=                                                                   ='), nl,
	write('====================================================================='), nl,
	pressEnter, nl.

aboutGameMenu:-
	write('                                     '), nl,
	write('           ===> About <===           '), nl,
	write('                                     '), nl,
	write('====================================='), nl,
	write('=                                   ='), nl,
	write('=   This project was design by:     ='), nl,
	write('=      ==> Andre Barros             ='), nl,
	write('=      ==> Edgar Ramos              ='), nl,
	write('=                                   ='), nl,
	write('====================================='), nl,
	pressEnter, nl.