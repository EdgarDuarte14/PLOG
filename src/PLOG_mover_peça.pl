getCell(1, Coluna, [H|_], Celula):- getCellCol(Coluna, H, Celula).
getCell(N, Col, [_|T], Cell):- Previous is N-1, getCell(Previous, Col, T, Cell).

getCellCol(1, [Cell|_], Cell).
getCellCol(N, [_|T], Cell):- Previous is N-1, getCellCol(Previous, T, Cell).

%setCellLine(Line, Col, Tab, Piece, NewTab).

setCell(1, Col, [H|T], Piece, [H1|T]):- getCell(1, Col, [H|T], Cell),  (Cell =:= 0 -> setCellCol(Col, H, Piece, H1) ; write('Already has a piece there'), setCellCol(Col, H, Cell, H1)).
setCell(N, Col, [H|T], Piece, [H|T1]):- Previous is N-1, setCell(Previous, Col, T, Piece, T1).

setCellCol(1, [_|T], Piece, [Piece|T]).
setCellCol(N, [H|T], Piece, [H|T1]):- Previous is N-1, setCellCol(Previous, T, Piece, T1).


