female(alice). %1
female(eve). %2
female(ida). %3

male(bob). %3
male(charlie). %4
male(frank). %5
male(gary). %6
male(harry). %7

parent(charlie,bob). %8
parent(eve,bob). %9
parent(charlie,alice). %10
parent(eve,alice). %11
parent(frank,charlie). %12
parent(gary,frank). %13
parent(frank, harry). %14
parent(harry, ida). %15

% person(?X) iff X is a person (male or female).
person(X) :- male(X).
person(X) :- female(X).
% short form:
%person(X) :- male(X); female(X).


% sibling(?X,?Y) iff X is a sibling of Y.
sibling(X,Y) :- parent(P,X), parent(P,Y), X\=Y.

% How do we get rid of duplicates?

% Let's define a new predicate to work with.

% son(?X) iff X is a son.
son1(X) :- male(X), parent(_,X). %42

% How did we get the answers, in this order?

% Prolog's SEARCH for answers/proofs always proceeds
% top to bottom, left to right.

% We consider the query son(Who).
% We say son(X) is the GOAL.
% -- search top to bottom, find rule for son.
% Now we have two SUBGOALS: male(Who) and parent(_,Who).
% This is called UNIFICATION: we UNIFY X with Who.
% -- prove male(Who) first (left to right!)
% -- search top to bottom, find first fact for male
% -- found male(bob), left to prove SUBGOAL parent(_,bob)
% -- search top to bottom, find first fact for parent(<something>,bob)
% -- found parent(charlie,bob) -- success!
% On success, Prolog reports true, or, if there were variables in the
%  query, then unifications of those variables.
% If I hit semi-colon, Prolog will BACKTRACK to search for more
%  answers/proofs.
% -- backtrack to parent(_,bob)
% -- search top to bottom, (but NOT what I've done before)
% -- find parent(eve,bob) -- success!
% If I hit semi-colon, backtrack!
% -- backtrack to parent(_,bob)
% -- search top to bottom, (but NOT what I've done before)
% -- haven't found anything else that proves parent(_,bob) -- BACKTRACK!
% -- backtrack all the way to back to male(Who)
% -- search top to bottom, find male(charlie)
% ...... etc.

% CUT! A way to prune search trees.
% Try it:
5son(X) :- male(X), parent(_,X), !.
% Didn't work...
son(X) :- male(X), !, parent(_,X).
% Didn't work either...
% Need to think. (A good idea when programming!)
% Want:
% -- try all males (so -- no cut in the rule where male(X) is!)
% -- if there is a parent, don't look for other parents (so -- cut in the
% rule where parent(,) is)