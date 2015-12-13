:-use_module(library(lists)).
:-use_module(library(clpfd)).
:-use_module(library(random)).


:- include('menus.pl').
:- include('utils.pl').


%-----------> Lauching the game <------------%

tictac(6):-
        starting_state6x6(Board), principal(Board, 6).

tictac(8):-
        starting_state8x8(Board), principal(Board, 8).

tictac(10):-
        starting_state10x10(Board), principal(Board, 10).


starting_state6x6([[ C1, C2, 1,C4, C5, C6],
                   [ C7, C8, 1,C10,C11,C12],
                   [ 1,C14,C15,C16,C17, 1],
                   [C19,C20, 0,C22,C23,C24],
                   [C25, 1,C27,C28,C29, 1],
                   [ 0,C32,C33,C34, 0,C36]
                  ]).

starting_state6x6_empty([[C1,C2,C3,C4,C5,C6],
                [C7,C8,C9,C10,C11,C12],
                [C13,C14,C15,C16,C17,C18],
                [C19,C20,C21,C22,C23,C24],
                [C25,C26,C27,C28,C29,C30],
                [C31,C32,C33,C34,C35,C36]
                ]).


starting_state8x8([[C1, C2, C3, C4, C5, C6, C7, C8],
                   [C9,C10,C11,C12,C13,C14,C15,C16],
                   [C17,C18,C19,C20,C21,C22,C23,C24],
                   [C25,C26,C27,C28,C29,C30,C31,C32],
                   [C33,C34,C35,C36,C37,C38,C39,C40],
                   [C41,C42,C43,C44,C45,C46,C47,C48],
                   [C49,C50,C51,C52,C53,C54,C55,C56],
                   [C57,C58,C59,C60,C61,C62,C63,C64]]).

starting_state10x10([[C1, C2, C3, C4, C5, C6, C7, C8, C9, C10],
                   [C11,C12,C13,C14,C15,C16,C17,C18,C19,C20],
                   [C21,C22,C23,C24,C25,C26,C27,C28,C29,C30],
                   [C31,C32,C33,C34,C35,C36,C37,C38,C39,C40],
                   [C41,C42,C43,C44,C45,C46,C47,C48,C49,C50],
                   [C51,C52,C53,C54,C55,C56,C57,C58,C59,C60],
                   [C61,C62,C63,C64,C65,C66,C67,C68,C69,C70],
                   [C71,C72,C73,C74,C75,C76,C77,C78,C79,C80],
                   [C81,C82,C83,C84,C85,C86,C87,C88,C89,C90],
                   [C91,C92,C93,C94,C95,C96,C97,C98,C99,C100]]).


printInitialSeperator(0):- nl.
printInitialSeperator(N):-
 write( '-----'),
 N1 is N-1,
 printInitialSeperator(N1).

write_piece(1):-write('| X  ').
write_piece(0):-write('| 0  ').


write_line([]):- write('|').
write_line([H|T]):-
     write_piece(H),
    write_line(T).

show_lines(_, [], _).
show_lines(N, [H|T], N1):-
    write(' '),write_separators(N1), nl,write(' '), write_line(H), nl, write(' '), write_bottom(N1), nl,
    N2 is N+1,
    show_lines(N2, T, N1).

write_separators(0):-write('|').
write_separators(N):-
    write('|    '),
    N1 is N-1,
    write_separators(N1).

write_bottom(0):-write('|').
write_bottom(N):-
    write('|____'),
    N1 is N-1,
    write_bottom(N1).

show_board(Board):-
    nl,
    length(Board, Num),
    write('  '),
    printInitialSeperator(Num),
    show_lines(1, Board, Num), nl.




flatten([], []).
flatten([Line|Rest], List):- flatten(Rest, L2), append(Line,L2, List).

choose_var([], _, _).

choose_var(Vars, Selected, Rest):-
    length(Vars, Num),
    random(0, Num, Ran),
    nth0(Ran, Vars, Selected, Rest),
    var(Selected).




    

principal(Board, N):-
    flatten(Board, Vars),
    domain(Vars, 0,1),
    transpose(Board, Columns),
    apply_restrictions(Board, N),
    apply_restrictions(Columns, N),
    statistics(walltime, _),
    labeling([variable(choose_var)], Vars),
    statistics(walltime, [_, ElapsedTime | _]),
    format('~nElapsed time: ~3d seconds', ElapsedTime), nl,
    fd_statistics,
    show_board(Board).



check_consecutive([]).

check_consecutive([_ , _]).

check_consecutive([_]).

check_consecutive([H1, H2, H3 |T]):-
    (H1 #\= H2) #\/ (H1 #\= H3),
    check_consecutive([H2, H3 | T]).

check_sum(Line, N):-
    D is N div 2,
    sum(Line, #=, D).

get_compare_lists([_], [_], Results).

get_compare_lists([], [],  Results).

get_compare_lists([H1| T], [H2| T2], [N1 | Results]):-
    N1 #= (H1 #\= H2),
    get_compare_lists(T, T2, Results).

check_unique(Results):-
    sum(Results, #> , 0).




apply_restrictions([], _).


apply_restrictions([H1, H2|T], N):-
    check_consecutive(H1),
    check_sum(H1, N),
    get_compare_lists(H1, H2, Results),
    check_unique(Results),
    apply_restrictions([H2 | T], N).

apply_restrictions([H1|T], N):-
    check_consecutive(H1),
    check_sum(H1, N),
    apply_restrictions(T, N).