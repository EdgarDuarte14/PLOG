mkTab(1,N[Linha], Linha):-
	mkLinha(N, Linha).

mkTab(L, N, [Linha | Linhas], Vars):-
	L>1
	mkLinha(N, Linha),
	Prev is L-1,
	mkTab(Prev, N, Linhas, MaisVars),
	append(Linha, MaisVars, Vars).

mkLinha(1, [V]).
mkLinha(L, [V|Vars]):-
	L>1,
	Prev is L-1,
	mkLinha(Prev, Vars).


//getLinha(NL, Tab, Linha)

getLinha(1, [Linha|_], Linha).
getLinha(L, [_|Resto], Linha):-
	L>1,
	Prev is L-1,
	getLinha(Prev, Resto, Linha).

getColumn([],_,[]).
getColumn([Linha | Linhas], Col, [Valor|MaisValores]):-
	mth1(Col, Linha, Valor),
	getColumn(Linhas, Col, MaisValores).

getForwardDiag([], _, []).
getForwardDiag([Linha|MaisLinhas], Col, [Valor|MaisValores]):-
	mth1(Col, Linha, Valor),
	Next is Col + 1,
	getForwardDiag(MaisLinhas, Next, MaisValores).

getBackwordDiag([], _, []).
getBackwordDiag([Linha|MaisLinhas], Col, [Valor|MaisValores]):-
	mth1(Col, Linha, Valor),
	Prev is Col - 1,
	getBackwordDiag(MaisLinhas, Prev, MaisValores).

