% -*- Mode : Prolog -*- 

:- module(prop, [formula/1, eval/3, sub/3]).

and([]).
and([X|Xs]) :- (X -> and(Xs) ; fls).

or([]).
or([X|Xs]) :- (X -> and(Xs) ; fls).

neg(tru) :- fls.
neg(fls) :- tru.

implies(F0,F1) :- (and([F0,F1])-> tru ; fls).

formula(tru).
formula(fls).
formula(neg(X)) :- formula(X).
formula(variable(V)) :- atom(V).
formula(and([])) :- !.
formula(and([X|Xs])) :- formula(X), formula(and(Xs)).
formula(or([])) :- !.
formula(or([X|Xs])) :- formula(X), formula(or(Xs)).
formula(implies(X0, X1)) :- formula(X0), formula(X1).


sub(variable(Z), [Y/Y1|Xs], G) :- (Z == Y -> G = Y1; sub(variable(Z), Xs, G)), !.
sub(Z, [Y/Y1|Xs], G) :- (Z == Y -> G = Y1; sub(Z, Xs, G)), !.
sub(neg(Z), [Y/tru|Xs], G) :- (Z == Y -> G = fls; sub(neg(Z), Xs, G)), !.
sub(neg(Z), [Y/fls|Xs], G) :- (Z == Y -> G = tru; sub(neg(Z), Xs, G)), !.
sub(neg(Z), [Y/Y1|Xs], neg(G)) :- sub(Z, [Y/Y1|Xs], G). 
sub(or([]), _, or([])) :- !.
sub(or([Z1|Z2]), [Y/Y1|Xs], or([G1|G2])) :- sub(Z1, [Y/Y1|Xs], G1), sub(or(Z2), [Y/Y1|Xs], or(G2)).
sub(and([]), _, and([])) :- !.
sub(and([Z1|Z2]), [Y/Y1|Xs], and([G1|G2])) :- sub(Z1, [Y/Y1|Xs], G1), sub(and(Z2), [Y/Y1|Xs], and(G2)).
sub(implies(Z1, Z2), [Y/Y1|Xs], implies(G1,G2)) :- sub(Z1, [Y/Y1|Xs], G1), sub(Z2, [Y/Y1|Xs], G2).


eval(tru, _, tru) :- !.
eval(fls, _, fls) :- !.
eval(A, Asst, B) :- sub(A, Asst, B), !.
eval(variable(X),Asst,V) :- sub(variable(X),Asst,G), eval(G,Asst,V).
eval(neg(tru),_,fls) :- !.
eval(neg(fls),_,tru) :- !.
eval(neg(X),Asst,V) :- sub(neg(X),Asst,G), eval(G,Asst,V).
eval(and([]),_,tru).
eval(and([X|Xs]),Asst,V) :- eval(X,Asst,V), (V == fls -> eval(V, _, _); eval(and(Xs),Asst,V)),!.
eval(and(_),_,fls).
eval(or([]),_,fls).
eval(or([X|Xs]),Asst,V) :- eval(X,Asst,V), (V == tru -> eval(V,_,_); eval(and(Xs),Asst,V)),!.
eval(or(_),_,tru).
eval(implies(X0,X1), Asst,tru) :- eval(X0, Asst, fls), eval(X1, Asst, fls).
eval(implies(X0,X1), Asst,tru) :- eval(X0, Asst, tru), eval(X1, Asst, fls).
eval(implies(X0,X1), Asst,tru) :- eval(X0, Asst, tru), eval(X1, Asst, tru), !.
eval(implies(X0,X1), Asst, G) :- (G == fls -> eval(X0,Asst,fls), eval(X1,Asst,tru); !).