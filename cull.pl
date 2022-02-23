
% example words KB FORMAT
% :-dynamic word/1.
% word([c,r,a,n,e]).
% word([c,r,a,t,e]).
% word([p,l,a,n,e]).
% word([l,a,t,t,e]).
% word([p,l,a,i,n]).
% word([n,e,w,e,r]).

:-dynamic currentGuess/1.
currentGuess([-1,-1,-1,-1,-1]).
:-dynamic currentPattern/1.
currentPattern([-1,-1,-1,-1,-1]).

:- dynamic makeGuess/3.

solution([c,r,a,n,e]).

makeGuessAndCull(Guess):-
    % load the makeGuess Pred
    consult(check),
    solution(Solution),
    % make our guess based on the solution word and store the result pattern
    makeGuess(Solution,Guess,R),
    writef('Result: %p%p%p%p%p\n', R),

    % update our current guess and associated pattern
    retract(currentGuess(_)), retract(currentPattern(_)),
    asserta(currentGuess(Guess)), asserta(currentPattern(R)),

    % remove words from our KB that don't fit the pattern
    forall(word(X), cullWords3(X)).

% for all words, if the word can be used with the current guess to make the current pattern, leave it in
cullWords3(Word) :- currentPattern(P), currentGuess(G), makeGuess(Word, G, P), !.
% otherwise, remove it from the database
cullWords3(Word) :- retract(word(Word)).



printWordList() :- forall(word(X), writef('%p%p%p%p%p\n',X)).

