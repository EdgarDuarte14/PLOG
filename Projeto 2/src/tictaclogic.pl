:-use_module(library(lists)).
:-use_module(library(random)).

:- include('menus.pl').
:- include('utils.pl').

%-----------> Lauching the game <------------%
tictac:-
        mainMenu.


starting_state([[0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0]
                ]).



printColumnId:- write('  a    b    c    d    e    f    g    h    i \n').

printInitialSeperator:- write( '  -------------------------------------------- \n').

write_piece(0):-write('|    ').
write_piece(1):-write('| X  ').
write_piece(2):-write('| 0  ').

write_line([]):- write('|').
write_line([H|T]):-
     write_piece(H),
    write_line(T).

show_lines(_, []).
show_lines(N, [H|T]):-
    write(N), write('|    |    |    |    |    |    |    |    |    | \n'),write(' '), write_line(H), nl, write(' |____|____|____|____|____|____|____|____|____|'), nl,
    N2 is N+1,
    show_lines(N2, T).

show_board(Board):-
    nl, printColumnId, printInitialSeperator,
    show_lines(1, Board), nl.





getCell(1, Coluna, [H|_], Celula):- getCellCol(Coluna, H, Celula).
getCell(N, Col, [_|T], Cell):- Previous is N-1, getCell(Previous, Col, T, Cell).

getCellCol(1, [Cell|_], Cell).
getCellCol(N, [_|T], Cell):- Previous is N-1, getCellCol(Previous, T, Cell).

%setCellLine(Line, Col, Tab, Piece, NewTab).

setCell(1, Col, [H|T], Piece, [H1|T], Sucess):- getCell(1, Col, [H|T], Cell),  (Cell =:= 0 -> setCellCol(Col, H, Piece, H1), Sucess = 1 ; write('Already has a piece there'), setCellCol(Col, H, Cell, H1) , Sucess = 0).
setCell(N, Col, [H|T], Piece, [H|T1], Sucess):- Previous is N-1, setCell(Previous, Col, T, Piece, T1, Sucess).

setCellCol(1, [_|T], Piece, [Piece|T]).
setCellCol(N, [H|T], Piece, [H|T1]):- Previous is N-1, setCellCol(Previous, T, Piece, T1).



% Funcao aula  - contar o numero de 1s no tabuleiro %

conta_peca1([],_).conta_peca1([V|T], N):-
    var(V),
    V #= 1,
    M is N+1,
    conta_peca1(T,M).


conta_peca1([V|T], N):-
    var(V),
    V #= 0,
    conta_peca1(T,M).

conta_peca1([V|Mais], N):-
    V==1,
    conta_peca1(Mais, M),
    N is M+1.

conta_peca1([V|Mais], N):-
    V==0,
    conta_peca1(Mais, M).
