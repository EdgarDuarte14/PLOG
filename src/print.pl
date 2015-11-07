:-use_module(library(lists)).
:-use_module(library(random)).

starting_state([[1,1,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0],
                [2,0,0,2,0,0,1,0,0],
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


start:- starting_state(Board), show_board(Board), setRandomPieces(Board, 10, NewBoard), show_board(NewBoard) , humanVhuman(NewBoard).




getCell(1, Coluna, [H|_], Celula):- getCellCol(Coluna, H, Celula).
getCell(N, Col, [_|T], Cell):- Previous is N-1, getCell(Previous, Col, T, Cell).

getCellCol(1, [Cell|_], Cell).
getCellCol(N, [_|T], Cell):- Previous is N-1, getCellCol(Previous, T, Cell).

%setCellLine(Line, Col, Tab, Piece, NewTab).

setCell(1, Col, [H|T], Piece, [H1|T], Sucess):- getCell(1, Col, [H|T], Cell),  (Cell =:= 0 -> setCellCol(Col, H, Piece, H1), Sucess = 1 ; write('Already has a piece there'), setCellCol(Col, H, Cell, H1) , Sucess = 0).
setCell(N, Col, [H|T], Piece, [H|T1], Sucess):- Previous is N-1, setCell(Previous, Col, T, Piece, T1, Sucess).

setCellCol(1, [_|T], Piece, [Piece|T]).
setCellCol(N, [H|T], Piece, [H|T1]):- Previous is N-1, setCellCol(Previous, T, Piece, T1).

setRandomPieces(Board, 0, Board):- !.

setRandomPieces(Board, N, NewBoard) :-
    random(1, 10, Line),
    random(1, 10, Col),
    random(1, 3, Piece),
    setCell(Line, Col, Board, Piece, Board1, Sucess),
    %show_board(Board1),
    (Sucess =:= 1 -> N1 is N-1; N1 is N),
    write(N1),
    setRandomPieces(Board1, N1, NewBoard).



choose_coords_dir(Board,Dir , Line, Column, Line1, Column1, Piece):-
    write('Line: '),
    read(Line),
    %nl,
    write('Column: '),
    read(Column),
    getCell(Line,Column, Board, Cell),
    Cell = 0,
    write('Direction of next piece (1-up, 2-down, 3-right, 4-left) : '),
    read(Dir),
    (Dir =:= 1 -> Line1 is Line-1, Column1 is Column,  getCell(Line1, Column1, Board, Cell1), Cell1 = 0, check_three_in-row(Board, 1, Piece, Line1, Column1) ; 
        (Dir =:= 2 -> Line1 is Line+1, Column1 is Column,  getCell(Line1, Column1, Board, Cell1), Cell1 = 0, check_three_in-row(Board, 2, Piece, Line1, Column1) ; 
            (Dir =:= 3 -> Column1 is Column+1, Line1 is Line,  getCell(Line1, Column1, Board, Cell1), write(Cell1), Cell1 = 0, check_three_in-row(Board, 3, Piece, Line1, Column1) ; 
                (Dir =:= 4 -> Column1 is Column-1, Line1 is Line,  getCell(Line1, Column1, Board, Cell1), Cell1 = 0, check_three_in-row(Board, 4, Piece, Line1, Column1) ; fail) ) ) ).


choose_coords_dir(Board, Dir, Line, Column, Line1, Column1, Piece):-write('Erro'), nl ,choose_coords_dir(Board, Dir, Line, Column, Line1, Column1, Piece),!.

check_three_in-row(_,1,_,1,_):- !.

check_three_in-row(_,1,_,8,_):- !.

check_three_in-row(_,2,_,9,_):- !.

check_three_in-row(_,2,_,2,_):- !.

check_three_in-row(_,3,_,_,2):- !.
check_three_in-row(_,3,_,_,9):- !.
check_three_in-row(_,4,_,_,1):- !.
check_three_in-row(_,4,_,_,8):- !.

check_three_in-row(Board, 1, Piece, Line , Column):-
    Line1 is Line-1,
    getCell(Line1, Column, Board, Cell1),
    Cell1 \== Piece,
    Line2 is Line+2,
    getCell(Line2, Column, Board, Cell2),
    Cell2 \== Piece.

check_three_in-row(Board, 2, Piece, Line, Column):-
    %Line > 1,
    Line1 is Line+1,
    getCell(Line1, Column, Board, Cell1),
    Cell1 \== Piece,
    Line2 is Line-2,
    getCell(Line2, Column, Board, Cell2),
    Cell2 \== Piece.

check_three_in-row(Board, 3 , Piece, Line, Column):-
    Column1 is Column+1,
    getCell(Line, Column1, Board, Cell1),
    Cell1 \== Piece,
    Column2 is Column-2,
    getCell(Line, Column2, Board, Cell2),
    Cell2 \== Piece.

check_three_in-row(Board, 4 , Piece, Line, Column):-
    Column1 is Column-1,
    getCell(Line, Column1, Board, Cell1),
    Cell1 \== Piece,
    Column2 is Column+2,
    getCell(Line, Column2, Board, Cell2),
    Cell2 \== Piece.



choose_coords(Board, Line, Column):-
    write('Line: '),
    read(Line),
    %nl,
    write('Column: '),
    read(Column),
    getCell(Line,Column, Board, Cell),
    Cell = 0.
    %(Cell =:= 0 -> write('ok');  write('not a valid play: already has a piece there'), nl, choose_coords(Board, Line1, Column1)).

choose_coords(Board, Line, Column):-write('Erro'),nl,choose_coords(Board, Line, Column),!.

human_play(P, 1,  Line, Column, Board, Result) :-
    choose_coords(Board, Line, Column),
    write(Line),
    write(Column),
    setCell(Line, Column, Board, P, Result, Sucess).

human_play(P, 2,  Line, Column, Board, Result) :-
    choose_coords_dir(Board, Dir, Line, Column, Line1, Column1, P),
    write(Line),
    write(Column),
    setCell(Line, Column, Board, P, Result1, Sucess),
    setCell(Line1, Column1, Result1, P, Result, Sucess).
    %show_board(Result).




humanVhuman(Board):- 
    write('JOGADOR 1: '),
    nl,
    write('nr de pecas a jogar (1 ou 2): '),
    read(N),
    human_play(1, N,  Line, Column, Board , Board1),
    
    %%%% Depois aqui coloca-se funcao para ver se ganhou o jogo
    show_board(Board1),


    write('JOGADOR 2: '),
    nl,
    write('nr de pecas a jogar (1 ou 2): '),
    read(N1),
    human_play(2, N1,  Line2, Column2, Board1 , Board2),
    show_board(Board2),

    %%%% Depois aqui coloca-se funcao para ver se ganhou o jogo

    humanVhuman(Board2).