:-use_module(library(lists)).
:-use_module(library(random)).

starting_state([[0,1,0,0,0,0,0,0,0],
                [0,1,0,0,0,0,0,0,0],
                [2,2,1,2,0,0,1,0,0],
                [0,1,0,0,0,0,0,0,0],
                [0,1,0,0,0,0,0,0,0],
                [1,2,0,2,0,2,0,2,0],
                [2,1,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0,0],
                [0,1,0,0,0,0,0,0,0]
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


start:- starting_state(Board), show_board(Board), setRandomPieces(Board, 10, NewBoard), show_board(NewBoard) , humanVhuman(NewBoard, 1).




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
    check_crosscut(Board, Line, Column, Piece),
    write('Direction of next piece (1-up, 2-down, 3-right, 4-left) : '),
    read(Dir),
    (Dir =:= 1 -> Line1 is Line-1, Column1 is Column,  getCell(Line1, Column1, Board, Cell1), Cell1 = 0, check_three_in-row(Board, 1, Piece, Line1, Column1), check_crosscut(Board, Line1, Column1, Piece) ; 
        (Dir =:= 2 -> Line1 is Line+1, Column1 is Column,  getCell(Line1, Column1, Board, Cell1), Cell1 = 0, check_three_in-row(Board, 2, Piece, Line1, Column1) , check_crosscut(Board, Line1, Column1, Piece) ; 
            (Dir =:= 3 -> Column1 is Column+1, Line1 is Line,  getCell(Line1, Column1, Board, Cell1), Cell1 = 0, check_three_in-row(Board, 3, Piece, Line1, Column1) , check_crosscut(Board, Line1, Column1, Piece) ; 
                (Dir =:= 4 -> Column1 is Column-1, Line1 is Line,  getCell(Line1, Column1, Board, Cell1), Cell1 = 0, check_three_in-row(Board, 4, Piece, Line1, Column1) , check_crosscut(Board, Line1, Column1, Piece) ; fail) ) ) ).


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

check_crosscut_right_top(Board, Line, Column, 1):-
    Line1 is Line-1,
    getCell(Line1, Column, Board, Cell1),
    (Cell1 =:= 2 -> Column1 is Column+1, getCell(Line, Column1, Board, Cell2), 
        (Cell2 =:= 2 -> getCell(Line1, Column1, Board, Cell3) , Cell3 \==  1 ; !) ; ! ).

check_crosscut_left_top(Board, Line, Column, 1):-
    Line1 is Line-1,
    getCell(Line1, Column, Board, Cell1),
    (Cell1 =:= 2 -> Column1 is Column-1, getCell(Line, Column1, Board, Cell2), 
        (Cell2 =:= 2 -> getCell(Line1, Column1, Board, Cell3) , Cell3 \==  1 ; !) ; ! ).

check_crosscut_left_bottom(Board, Line, Column, 1):-
    Line1 is Line+1,
    getCell(Line1, Column, Board, Cell1),
    (Cell1 =:= 2 -> Column1 is Column-1, getCell(Line, Column1, Board, Cell2), 
        (Cell2 =:= 2 -> getCell(Line1, Column1, Board, Cell3) , Cell3 \==  1 ; !) ; ! ).

check_crosscut_right_bottom(Board, Line, Column, 1):-
    Line1 is Line+1,
    getCell(Line1, Column, Board, Cell1),
    (Cell1 =:= 2 -> Column1 is Column+1, getCell(Line, Column1, Board, Cell2), 
        (Cell2 =:= 2 -> getCell(Line1, Column1, Board, Cell3) , Cell3 \==  1 ; !) ; ! ).


check_crosscut_right_top(Board, Line, Column, 2):-
    Line1 is Line-1,
    getCell(Line1, Column, Board, Cell1),
    (Cell1 =:= 1 -> Column1 is Column+1, getCell(Line, Column1, Board, Cell2), 
        (Cell2 =:= 1 -> getCell(Line1, Column1, Board, Cell3) , Cell3 \==  2 ; !) ; ! ).

check_crosscut_left_top(Board, Line, Column, 2):-
    Line1 is Line-1,
    getCell(Line1, Column, Board, Cell1),
    (Cell1 =:= 1 -> Column1 is Column-1, getCell(Line, Column1, Board, Cell2), 
        (Cell2 =:= 1 -> getCell(Line1, Column1, Board, Cell3) , Cell3 \==  2 ; !) ; ! ).

check_crosscut_left_bottom(Board, Line, Column, 2):-
    Line1 is Line+1,
    getCell(Line1, Column, Board, Cell1),
    (Cell1 =:= 1 -> Column1 is Column-1, getCell(Line, Column1, Board, Cell2), 
        (Cell2 =:= 1 -> getCell(Line1, Column1, Board, Cell3) , Cell3 \==  2 ; !) ; ! ).

check_crosscut_right_bottom(Board, Line, Column, 2):-
    Line1 is Line+1,
    getCell(Line1, Column, Board, Cell1),
    (Cell1 =:= 1 -> Column1 is Column+1, getCell(Line, Column1, Board, Cell2), 
        (Cell2 =:= 1 -> getCell(Line1, Column1, Board, Cell3) , Cell3 \==  2 ; !) ; ! ).

check_crosscut(Board, Line, Column, Piece):-
    check_crosscut_right_top(Board, Line, Column, Piece),
    check_crosscut_left_top(Board, Line, Column, Piece),
    check_crosscut_left_bottom(Board, Line, Column, Piece),
    check_crosscut_right_bottom(Board, Line, Column, Piece).

check_crosscut(Board, 1, Column, Piece):-
    check_crosscut_left_bottom(Board, 1, Column, Piece),
    check_crosscut_right_bottom(Board, 1, Column, Piece).

check_crosscut(Board, 9, Column, Piece):-
    check_crosscut_left_top(Board, 9, Column, Piece),
    check_crosscut_right_top(Board, 9, Column, Piece).

check_crosscut(Board, Line, 1, Piece):-
    check_crosscut_right_top(Board, Line, 1, Piece),
    check_crosscut_right_bottom(Board, Line, 1, Piece).

check_crosscut(Board, Line, 9, Piece):-
    check_crosscut_left_top(Board, Line, 9, Piece),
    check_crosscut_left_bottom(Board, Line, 9, Piece).

check_crosscut(Board, 1, 1, Piece):-
    check_crosscut_right_bottom(Board, 1, 1, Piece).

check_crosscut(Board, 1, 9, Piece):-
    check_crosscut_left_bottom(Board, 1, 9, Piece).

check_crosscut(Board, 9 , 1, Piece):-
    check_crosscut_right_top(Board, 9, 1 , Piece).

check_crosscut(Board, 9, 9, Piece):-
    check_crosscut_left_top(Board, 9, 9, Piece).





choose_coords(Board, Line, Column, Piece):-
    write('Line: '),
    read(Line),
    %nl,
    write('Column: '),
    read(Column),
    getCell(Line,Column, Board, Cell),
    Cell = 0,
    check_crosscut(Board, Line, Column, Piece).

choose_coords(Board, Line, Column, Piece):-write('Erro'),nl,choose_coords(Board, Line, Column, Piece),!.

human_play(P, 1,  Line, Column, Board, Result) :-
    choose_coords(Board, Line, Column, P),
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






humanVhuman(Board, Player):-
    write('JOGADOR '),
    write(Player),
    write(': '),
    write('nr de pecas a jogar (1 ou 2): '),
    read(N),
    human_play(Player, N,  Line, Column, Board , Board1),
    show_board(Board1),
    (checkCompletePath(1,1,Board1,Player) -> write('JOGADOR'), write(Player), write(' VENCEU O JOGO'), ! ; (Player =:= 1-> humanVhuman(Board1, 2) ; humanVhuman(Board1, 1) ) ).

    








 %-------------> Check path <---------------%

% Verificar os vizinhos de um ponto %

neighbor(Line, Column, Line1, Column1):-
    Column1 is Column + 1,
    Line1 is Line + 1,
    Line1 =< 9,
    Column1 =< 9.


neighbor(Line, Column, Line1, Column1):-
    Column1 is Column + 1,
    Line1 is Line - 1,
    Line1 >= 1,
    Column1 =< 9.


neighbor(Line, Column, Line1, Column1):-
    Column1 is Column - 1,
    Line1 is Line - 1,
    Line1 >= 1,
    Column1 >= 9.


neighbor(Line, Column, Line1, Column1):-
    Column1 is Column - 1,
    Line1 is Line + 1,
    Line1 =< 9,
    Column1 >= 1.


neighbor(Line, Column, Line1, Column1):-
    Column1 is Column + 1,
    Line1 is Line,
    Column1 =< 9.


neighbor(Line, Column, Line1, Column1):-
    Column1 is Column - 1,
    Line1 is Line,
    Column1 >= 1.


neighbor(Line, Column, Line1, Column1):-
    Line1 is Line + 1,
    Column1 is Column,
    Line1 =< 9.


neighbor(Line, Column, Line1, Column1):-
    Line1 is Line - 1,
    Column1 is Column,
    Line1 >= 1.



% condicoes finais ---------- modificar % 
path([[Line,9] | _], Board, 2):-
    getCell(Line,9, Board, Piece),
    Piece == 2.

path([[9,Column] | _], Board, 1):-
    getCell(9,Column, Board, Piece),
    Piece == 1.


path([[Line,Column] | T], Board, Player):-
   neighbor(Line, Column, Line1, Column1),
        getCell(Line1,Column1, Board, Piece),
        Piece = Player,
        \+ member([Line1, Column1], T),
        path([[Line1, Column1] | [[Line,Column] | T]], Board, Player).
 


% Tentativa de criar um caminho completo, tanto para o jogador 1 como para o jogador 2 %

checkCompletePath(10, _, _, 1).
checkCompletePath(_, 10, _, 2).

checkCompletePath(Line, Column, Board, 2):-
    write('checkCompletePath'),
    Line =< 9,
    Column =< 9,
    getCell(Line, Column, Board, Piece),
    (Piece \== 2 -> Line1 is Line + 1, checkCompletePath(Line1, Column, Board, 2);
        (\+ path([[Line, Column]], Board, 2) -> Line1 is Line + 1, checkCompletePath(Line1, Column, Board, 2); true)).



checkCompletePath(Line, Column, Board, 1):- 
    write('checkCompletePath'),
    nl,
    Line =< 9,
    Column =< 9,
    getCell(Line, Column, Board, Piece),
    (Piece \== 1 -> Column1 is Column + 1, checkCompletePath(Line, Column1, Board, 1);
        (\+ path([[Line, Column]], Board, 1) -> Column1 is Column + 1, checkCompletePath(Line, Column1, Board, 1);
            true)).




%decide_white_play(Board, Line, Column, Line1, Column1, NrPieces):-