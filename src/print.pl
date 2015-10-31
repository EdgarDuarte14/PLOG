:-use_module(library(lists)).

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


start:- starting_state(Board), show_board(Board).