%               %
%     MENUS     %
%               %

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
	clearScreen,
	write('                                 '), nl,
	write('       ===> Distrify <===        '), nl,
	write('                                 '), nl,
	write('================================='), nl,
	write('================================='), nl,
	write('==                             =='), nl,
	write('==   1. Play                   =='), nl,
	write('==   2. Instructions           =='), nl,
	write('==   3. About the game         =='), nl,
	write('==   4. Exit                   =='), nl,
	write('==                             =='), nl,
	write('================================='), nl,
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
	clearScreen,
	write('                                 '), nl,
	write('      ===> Game Options <===     '), nl,
	write('                                 '), nl,
	write('================================='), nl,
	write('================================='), nl,
	write('==                             =='), nl,
	write('==   1. Player vs Player       =='), nl,
	write('==   2. Player vs Computer     =='), nl,
	write('==   3. Computer vs Computer   =='), nl,
	write('==   4. Previous Menu          =='), nl,
	write('==                             =='), nl,
	write('================================='), nl,
	write('================================='), nl,
	write('Choose your game option:'), nl.

playerVsPlayer:-
	clearScreen,
	write('                                          '), nl,
	write('    ==> Player vs Player  mode choosen    '), nl,
	write('                                          '), nl,
	startHvsH,
	pressEnter, nl.


playerVsComputer:-
	clearScreen,
	write('                                         '), nl,
	write('    ==> Player vs Computer mode choosen  '), nl,
	write('                                         '), nl,
	startCvsH,
	pressEnter, nl.


computerVsComputer:-
	clearScreen,
	write('                                          '), nl,
	write('  ==> Computer vs Computer  mode choosen  '), nl,
	write('                                          '), nl,
	startCvsC,
	pressEnter, nl.


helpMenu:-
	clearScreen,
	write('                                                                         '), nl,
	write('                         ===> How to play <===                           '), nl,
	write('                                                                         '), nl,
	write('========================================================================='), nl,
	write('========================================================================='), nl,
	write('==                                                                     =='), nl,
	write('==   Distrify is connection game played by two players, white and      =='), nl,
	write('==   black pieces, the player with the black pieces (Player1) starts   =='), nl,
	write('==   the game by putting a piece anywhere in the board, then the       =='), nl,
	write('==   players start alternating turns and have a choice to place one    =='), nl,
	write('==   or two stones, if two are placed:                                 =='), nl,
	write('==   1) the placed stones must not be diagonally adjacent to each      =='), nl,
	write('==   other                                                             =='), nl,
    write('==   2) the placed stones cannot result in the formation of a new      =='), nl,
    write('==   horizontal, vertical, or diagonal three-in-a-row of the same type =='), nl,
    write('==                                                                     =='), nl,
    write('==   a player move can never result in a crosscut                      =='), nl,
    write('==   CROSSCUT: X 0                                                     =='), nl,
    write('==             0 X                                                     =='), nl,
    write('==                                                                     =='), nl,
    write('==   Black wins if there exists a path of orthogonally or diagonally   =='), nl,
    write('==   adjacent black stones reaching between the top and bottom rows    =='), nl,
    write('==   while White wins if there exists an analogous path stretching     =='), nl,
    write('==   from the westmost to eastmost columns.                            =='), nl,
    write('==                                                                     =='), nl,
    write('========================================================================='), nl,
    write('========================================================================='), nl,
    pressEnter, nl.



aboutGameMenu:-
	clearScreen,
	write('                                     '), nl,
	write('           ===> About <===           '), nl,
	write('                                     '), nl,
	write('====================================='), nl,
	write('====================================='), nl,
	write('==                                 =='), nl,
	write('==   This project was design by:   =='), nl,
	write('==      ==> Andre Barros           =='), nl,
	write('==      ==> Edgar Ramos            =='), nl,
	write('==                                 =='), nl,
	write('==   This project was developed    =='), nl,
	write('==   in the class of PLOG along    =='), nl,
	write('==   the course of MIEIC           =='), nl,
	write('==                                 =='), nl,
	write('====================================='), nl,
	write('====================================='), nl,
	pressEnter, nl.