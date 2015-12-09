%               %
%     MENUS     %
%               %

mainMenu:- 
	printMainMenu,
	getChar(Input),
	(
		Input = '1' -> gameModeMenu, mainMenu;
		Input = '2' -> aboutGameMenu, mainMenu;
		Input = '3';

		nl,
		write('Error: Invalid input.'), nl,
		pressEnter, nl,
		mainMenu
	).

printMainMenu:-
	clearScreen,
	write('                                   '), nl,
	write('      ===> Tic Tac Logic <===      '), nl,
	write('                                   '), nl,
	write('==================================='), nl,
	write('==================================='), nl,
	write('==                               =='), nl,
	write('==    1. Play                    =='), nl,
	write('==    2. About the game          =='), nl,
	write('==    3. Exit                    =='), nl,
	write('==                               =='), nl,
	write('==================================='), nl,
	write('==================================='), nl,
	write('Choose your game option:'), nl.


gameModeMenu:-
	printGameModeMenu,
	getChar(Input),
	(
		Input = '1' -> 6x6;
		Input = '2' -> 8x8;
		Input = '3' -> 10x10;
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
	write('==    1. 6x6 Mode              =='), nl,
	write('==    2. 8x8 Mode              =='), nl,
	write('==    3. 10x10 Mode            =='), nl,
	write('==    4. Previous Menu         =='), nl,
	write('==                             =='), nl,
	write('================================='), nl,
	write('================================='), nl,
	write('Choose your game option:'), nl.

6x6:-
	clearScreen,
	write('                                          '), nl,
	write('          ==> 6x6 mode choosen            '), nl,
	write('                                          '), nl,
	startHvsH,
	pressEnter, nl.


8x8:-
	clearScreen,
	write('                                         '), nl,
	write('          ==> 8x8 mode choosen           '), nl,
	write('                                         '), nl,
	startCvsH,
	pressEnter, nl.


10x10:-
	clearScreen,
	write('                                          '), nl,
	write('          ==> 10x10 mode choosen          '), nl,
	write('                                          '), nl,
	startCvsC,
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